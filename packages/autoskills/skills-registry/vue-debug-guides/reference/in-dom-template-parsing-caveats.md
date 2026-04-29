---
title: In-DOM Template Parsing Caveats
impact: HIGH
impactDescription: Browser HTML parsing before Vue compilation causes case sensitivity, self-closing tag, and element nesting issues
type: gotcha
tags: [vue3, templates, in-dom, html-parsing, kebab-case, self-closing-tags]
---

# In-DOM Template Parsing Caveats

**Impact: HIGH** - When writing Vue templates directly in the DOM (not in `.vue` files), the browser's native HTML parser processes the template BEFORE Vue sees it. This causes three critical issues: case sensitivity problems, self-closing tag failures, and element placement restrictions.

These issues do NOT apply to Single-File Components (SFCs) or string templates where Vue's compiler handles parsing directly.

## Task Checklist

- [ ] Use kebab-case for component names in in-DOM templates
- [ ] Use kebab-case for prop names in in-DOM templates
- [ ] Use explicit closing tags (not self-closing) in in-DOM templates
- [ ] Use `is="vue:component-name"` for components inside restricted elements
- [ ] Prefer SFCs to avoid all in-DOM parsing issues

## Issue 1: Case Insensitivity

HTML is case-insensitive. The browser lowercases everything before Vue sees it.

**Incorrect (in-DOM template):**
```html
<!-- Browser converts to: <blogpost posttitle="hello"> -->
<BlogPost postTitle="hello" @updatePost="onUpdate"></BlogPost>
```

**Correct (in-DOM template):**
```html
<!-- Use kebab-case for everything -->
<blog-post post-title="hello" @update-post="onUpdate"></blog-post>
```

**In SFCs, PascalCase works fine:**
```vue
<!-- BlogPost.vue - PascalCase recommended -->
<template>
  <BlogPost postTitle="hello" @updatePost="onUpdate" />
</template>
```

## Issue 2: Self-Closing Tags Fail

HTML only allows self-closing syntax for void elements (`<input>`, `<img>`, etc.). For all others, the browser expects closing tags.

**Incorrect (in-DOM template):**
```html
<!-- Browser thinks the tag never closed, breaks nesting -->
<my-component />
<another-component />
```

**Correct (in-DOM template):**
```html
<!-- Explicit closing tags required -->
<my-component></my-component>
<another-component></another-component>
```

**In SFCs, self-closing works fine:**
```vue
<template>
  <MyComponent />
  <AnotherComponent />
</template>
```

## Issue 3: Element Placement Restrictions

Some HTML elements have strict rules about valid children. Invalid elements are hoisted out by the browser before Vue sees the template.

**Restricted parent elements:**
- `<ul>`, `<ol>` - only allow `<li>`
- `<table>` - only allows `<thead>`, `<tbody>`, `<tfoot>`, `<tr>`, `<caption>`, `<colgroup>`
- `<tr>` - only allows `<td>`, `<th>`
- `<select>` - only allows `<option>`, `<optgroup>`

**Incorrect (in-DOM template):**
```html
<!-- Browser hoists blog-post-row outside the table -->
<table>
  <blog-post-row v-for="post in posts" :post="post"></blog-post-row>
</table>

<!-- Renders as: -->
<blog-post-row></blog-post-row>
<blog-post-row></blog-post-row>
<table></table>
```

**Correct (in-DOM template):**
```html
<!-- Use is="vue:component-name" on a valid native element -->
<table>
  <tr is="vue:blog-post-row" v-for="post in posts" :key="post.id" :post="post"></tr>
</table>
```

```html
<ul>
  <li is="vue:todo-item" v-for="todo in todos" :key="todo.id" :todo="todo"></li>
</ul>
```

**Important:** The `vue:` prefix is required! Without it, `is` is treated as a native customized built-in element attribute.

```html
<!-- WRONG: Missing vue: prefix -->
<tr is="blog-post-row"></tr>

<!-- CORRECT: With vue: prefix -->
<tr is="vue:blog-post-row"></tr>
```

## When Do These Apply?

| Template Type | Affected? | Example |
|---------------|-----------|---------|
| Single-File Component (`.vue`) | No | `<template>` section |
| String template | No | `template: '<div>...</div>'` |
| In-DOM template | **Yes** | `<div id="app">...</div>` |
| `<script type="text/x-template">` | **Yes** | Browser parses the script content |

## Best Practice: Use SFCs

The simplest solution is to use Single-File Components (`.vue` files) which completely avoid in-DOM parsing issues:

```vue
<!-- MyComponent.vue - All issues avoided -->
<script setup>
import BlogPost from './BlogPost.vue'
</script>

<template>
  <BlogPost postTitle="hello" @updatePost="onUpdate" />

  <table>
    <BlogPostRow v-for="post in posts" :key="post.id" :post="post" />
  </table>
</template>
```

## Reference
- [Vue.js - In-DOM Template Parsing Caveats](https://vuejs.org/guide/essentials/component-basics.html#in-dom-template-parsing-caveats)
