# SwiftUI View Structure Reference

## Table of Contents

- [View Structure Principles](#view-structure-principles)
- [Recommended View File Structure](#recommended-view-file-structure)
- [Struct or Method / Computed Property?](#struct-or-method--computed-property)
- [Prefer Modifiers Over Conditional Views](#prefer-modifiers-over-conditional-views)
- [Extract Subviews, Not Computed Properties](#extract-subviews-not-computed-properties)
- [@ViewBuilder](#viewbuilder)
- [Keep View Body Simple and Avoid High-Cost Operations](#keep-view-body-simple-and-avoid-high-cost-operations)
- [When to Extract Subviews](#when-to-extract-subviews)
- [Container View Pattern](#container-view-pattern)
- [Utilize Lazy Containers for Large Data Sets](#utilize-lazy-containers-for-large-data-sets)
- [ZStack vs overlay/background](#zstack-vs-overlaybackground)
- [Compositing Group Before Clipping](#compositing-group-before-clipping)
- [Split State-Driven Parts into Custom View Types](#split-state-driven-parts-into-custom-view-types)
- [Reusable Styling with ViewModifier](#reusable-styling-with-viewmodifier)
- [Skeleton Loading with Redacted Views](#skeleton-loading-with-redacted-views)
- [AnyView](#anyview)
- [UIViewRepresentable Essentials](#uiviewrepresentable-essentials)
- [Troubleshooting](#troubleshooting)
- [Summary Checklist](#summary-checklist)

## View Structure Principles

SwiftUI's diffing algorithm compares view hierarchies to determine what needs updating. Proper view composition directly impacts performance.

## Recommended View File Structure

Use a consistent order when declaring SwiftUI views:

1. Environment Properties
2. State Properties
3. Private Properties
4. Initializer (if needed)
5. Body
6. Computed Properties/Methods for Subviews

```swift
struct ContentView: View {
    // MARK: - Environment Properties
    @Environment(\.colorScheme) var colorScheme

    // MARK: - State Properties
    @Binding var isToggled: Bool
    @State private var viewModel: SomeViewModel

    // MARK: - Private Properties
    private let title: String = "SwiftUI Guide"

    // MARK: - Initializer (if needed)
    init(isToggled: Binding<Bool>) {
        self._isToggled = isToggled
    }

    // MARK: - Body
    var body: some View {
        VStack {
            header
            content
        }
    }

    // MARK: - Computed Subviews
    private var header: some View {
        Text(title).font(.largeTitle).padding()
    }

    private var content: some View {
        VStack {
            Text("Counter: \(counter)")
        }
    }
}
```

## Struct or Method / Computed Property?

If a `View` is intended to be reusable across multiple screens, encapsulate it within a separate `struct`. If its usage is confined to a single context, it can be declared as a function or computed property within the containing `View`.

However, if a view maintains state using `@State`, `@Binding`, `@ObservedObject`, `@Environment`, `@StateObject`, or similar wrappers, it should generally be a separate `struct`.

- For simple, static views: a computed property is acceptable.
- For views requiring parameters: a method is more appropriate, but only when those parameters are stable. If parameters change per-call (e.g. inside a `ForEach` where each call receives a different item), prefer a separate `struct` so SwiftUI can diff inputs and skip body evaluation.
- For reusable, stateful, or logically independent UI sections: prefer a dedicated `struct`.

```swift
struct ContentView: View {
    var titleView: some View {
        Text("Hello from Property")
            .font(.largeTitle)
            .foregroundColor(.blue)
    }

    func messageView(text: String, color: Color) -> some View {
        Text(text)
            .font(.title)
            .foregroundColor(color)
            .padding()
    }

    var body: some View {
        VStack {
            titleView
            messageView(text: "Hello from Method", color: .red)
        }
    }
}
```

## Prefer Modifiers Over Conditional Views

**Prefer "no-effect" modifiers over conditionally including views.** When you introduce a branch, consider whether you're representing multiple views or two states of the same view.

### Use Opacity Instead of Conditional Inclusion

```swift
// Good - same view, different states
SomeView()
    .opacity(isVisible ? 1 : 0)

// Avoid - creates/destroys view identity
if isVisible {
    SomeView()
}
```

**Why**: Conditional view inclusion can cause loss of state, poor animation performance, and breaks view identity. Using modifiers maintains view identity across state changes.

### When Conditionals Are Appropriate

Use conditionals when you truly have **different views**, not different states:

```swift
// Correct - fundamentally different views
if isLoggedIn {
    DashboardView()
} else {
    LoginView()
}

// Correct - optional content
if let user {
    UserProfileView(user: user)
}
```

### Conditional View Modifier Extensions Break Identity

A common pattern is an `if`-based `View` extension for conditional modifiers. This changes the view's return type between branches, which destroys view identity and breaks animations:

```swift
// Problematic -- different return types per branch
extension View {
    @ViewBuilder func `if`<T: View>(_ condition: Bool, transform: (Self) -> T) -> some View {
        if condition {
            transform(self)  // Returns T
        } else {
            self              // Returns Self
        }
    }
}
```

Prefer applying the modifier directly with a ternary or always-present modifier:

```swift
// Good -- same view identity maintained
Text("Hello")
    .opacity(isHighlighted ? 1 : 0.5)

// Good -- modifier always present, value changes
Text("Hello")
    .foregroundStyle(isError ? .red : .primary)
```

## Extract Subviews, Not Computed Properties

### The Problem with @ViewBuilder Functions

When you use `@ViewBuilder` functions or computed properties for complex views, the entire function re-executes on every parent state change:

```swift
// BAD - re-executes complexSection() on every tap
struct ParentView: View {
    @State private var count = 0

    var body: some View {
        VStack {
            Button("Tap: \(count)") { count += 1 }
            complexSection()  // Re-executes every tap!
        }
    }

    @ViewBuilder
    func complexSection() -> some View {
        // Complex views that re-execute unnecessarily
        ForEach(0..<100) { i in
            HStack {
                Image(systemName: "star")
                Text("Item \(i)")
                Spacer()
                Text("Detail")
            }
        }
    }
}
```

### The Solution: Separate Structs

Extract to separate `struct` views. SwiftUI can skip their `body` when inputs don't change:

```swift
// GOOD - ComplexSection body SKIPPED when its inputs don't change
struct ParentView: View {
    @State private var count = 0

    var body: some View {
        VStack {
            Button("Tap: \(count)") { count += 1 }
            ComplexSection()  // Body skipped during re-evaluation
        }
    }
}

struct ComplexSection: View {
    var body: some View {
        ForEach(0..<100) { i in
            HStack {
                Image(systemName: "star")
                Text("Item \(i)")
                Spacer()
                Text("Detail")
            }
        }
    }
}
```

### Why This Works

1. SwiftUI compares the `ComplexSection` struct (which has no properties)
2. Since nothing changed, SwiftUI skips calling `ComplexSection.body`
3. The complex view code never executes unnecessarily

## @ViewBuilder

Use `@ViewBuilder` functions for small, simple sections (a few views, no expensive computation) that don't affect performance. They work particularly well for static content that doesn't depend on any `@State` or `@Binding`, since SwiftUI won't need to diff them independently. Extract to a separate `struct` when the section is complex, depends on state, or needs to be skipped during re-evaluation.

The `@ViewBuilder` attribute is only required when a function or computed property returns multiple different views conditionally, for example through `if` or `switch`:

```swift
@ViewBuilder
private var conditionalView: some View {
    if isExpanded {
        VStack {
            Text("Expanded View")
            Image(systemName: "star")
        }
    } else {
        Text("Collapsed View")
    }
}
```

If every branch returns the same concrete type, `@ViewBuilder` is unnecessary:

```swift
var conditionalText: some View {
    if Bool.random() {
        Text("Hello")
    } else {
        Text("World")
    }
}
```

Prefer `@ViewBuilder` when:

- there is conditional branching between multiple view types
- extracting a separate `struct` would not provide meaningful separation

## Keep View Body Simple and Avoid High-Cost Operations

Refrain from performing complex operations within the `body` of your view. Instead of passing a ready-to-use sequence with filtering, mapping, or sorting directly into `ForEach`, prepare the sequence outside the body.

```swift
// Avoid such things ...
var body: some View {
    List {
        ForEach(model.values.filter { $0 > 0 }, id: \.self) {
            Text(String($0))
                .padding()
        }
    }
}
```

Prefer:

```swift
struct FilteredListView: View {
    private let filteredValues: [Int]

    init(values: [Int]) {
        self.filteredValues = values.filter { $0 > 0 } // Perform filtering once
    }

    var body: some View {
        List {
            content
        }
    }

    private var content: some View {
        ForEach(filteredValues, id: \.self) { value in
            Text(String(value))
                .padding()
        }
    }
}
```

The reason this matters is that the system can call `body` multiple times during a single layout phase. Complex body computation makes those calls more expensive than necessary.

General guidance:

- avoid filtering, sorting, and mapping inline in `body`
- avoid constructing expensive formatters in `body`
- avoid heavy branching in large view trees
- move data preparation into init, model layer, or dedicated helpers

## When to Extract Subviews

Extract complex views into separate subviews when:
- The view has multiple logical sections or responsibilities
- The view contains reusable components
- The view body becomes difficult to read or understand
- You need to isolate state changes for performance
- The view is becoming large (keep views small for better performance)
- The section may evolve independently over time

## Container View Pattern

### Avoid Closure-Based Content

Closures can't be compared, causing unnecessary re-renders:

```swift
// BAD - closure prevents SwiftUI from skipping updates
struct MyContainer<Content: View>: View {
    let content: () -> Content

    var body: some View {
        VStack {
            Text("Header")
            content()  // Always called, can't compare closures
        }
    }
}

// Usage forces re-render on every parent update
MyContainer {
    ExpensiveView()
}
```

### Use @ViewBuilder Property Instead

```swift
// GOOD - view can be compared
struct MyContainer<Content: View>: View {
    @ViewBuilder let content: Content

    var body: some View {
        VStack {
            Text("Header")
            content  // SwiftUI can compare and skip if unchanged
        }
    }
}

// Usage - SwiftUI can diff ExpensiveView
MyContainer {
    ExpensiveView()
}
```

## Utilize Lazy Containers for Large Data Sets

When displaying extensive lists or grids, prefer `LazyVStack`, `LazyHStack`, `LazyVGrid`, or `LazyHGrid`. These containers load views only when they appear on the screen, reducing memory usage and improving performance.

```swift
struct ContentView: View {
    let items = Array(0..<1000)

    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(items, id: \.self) { item in
                    Text("Item \(item)")
                }
            }
        }
    }
}
```

Prefer lazy containers when:

- rendering large collections
- row views are non-trivial
- memory usage matters
- the content is inside `ScrollView`

## ZStack vs overlay/background

Use `ZStack` to **compose multiple peer views** that should be layered together and jointly define layout.

Prefer `overlay` / `background` when you’re **decorating a primary view**.  
Not primarily because they don’t affect layout size, but because they **express intent and improve readability**: the view being modified remains the clear layout anchor.

A key difference is **size proposal behavior**:
- In `overlay` / `background`, the child view implicitly adopts the size proposed to the parent when it doesn’t define its own size, making decorative attachments feel natural and predictable.
- In `ZStack`, each child participates independently in layout, and no implicit size inheritance exists. This makes it better suited for peer composition, but less intuitive for simple decoration.

Use `ZStack` (or another container) when the “decoration” **must explicitly participate in layout sizing**—for example, when reserving space, extending tappable/visible bounds, or preventing overlap with neighboring views.

### Examples

```swift
// GOOD - decoration via overlay (layout anchored to button)
Button("Continue") { }
    .overlay(alignment: .trailing) {
        Image(systemName: "lock.fill").padding(.trailing, 8)
    }

// BAD - ZStack when overlay suffices (layout no longer anchored to button)
ZStack(alignment: .trailing) {
    Button("Continue") { }
    Image(systemName: "lock.fill").padding(.trailing, 8)
}

// GOOD - background shape takes parent size
HStack(spacing: 12) { Text("Inbox"); Text("Next") }
    .background { Capsule().strokeBorder(.blue, lineWidth: 2) }
```

## Compositing Group Before Clipping

**Always add `.compositingGroup()` before `.clipShape()` when clipping layered views (`.overlay` or `.background`).** Without it, each layer is antialiased separately and then composited. Where antialiased edges overlap — typically at rounded corners — you get visible color fringes (semi-transparent pixels of different colors blending together).

```swift
let shape = RoundedRectangle(cornerRadius: 16)

// BAD - each layer antialiased separately, producing color fringes at corners
Color.red
    .overlay(.white, in: shape)
    .clipShape(shape)
    .frame(width: 200, height: 150)

// GOOD - layers composited first, antialiasing applied once during clipping
Color.red
    .overlay(.white, in: .rect)
    .compositingGroup()
    .clipShape(shape)
    .frame(width: 200, height: 150)
```

`.compositingGroup()` forces all child layers to be rendered into a single offscreen buffer before the clip is applied. This means antialiasing only happens once — on the final composited result — eliminating the fringe artifacts.

## Split State-Driven Parts into Custom View Types

Large views often depend on multiple independent state sources. If a single view body depends on all of them, then any state change can cause the entire body to re-evaluate.

```swift
struct BigAndComplicatedView: View {
    @State private var counter = 0
    @State private var isToggled = false
    @StateObject private var viewModel = SomeViewModel()

    let title = "Big and Complicated View"

    var body: some View {
        VStack {
            Text(title)
                .font(.largeTitle)

            Text("Counter: \(counter)")
                .font(.title)

            Toggle("Enable Feature", isOn: $isToggled)
                .padding()

            Button("Increment Counter") {
                counter += 1
            }

            Text("ViewModel Data: \(viewModel.data)")
                .padding()

            Button("Fetch Data") {
                viewModel.fetchData()
            }
        }
    }
}
```

### Better: Split Into Smaller Components

```swift
struct BigAndComplicatedView: View {
    @State private var counter = 0
    @State private var isToggled = false
    @StateObject private var viewModel = SomeViewModel()

    var body: some View {
        VStack {
            titleView
            CounterView(counter: $counter)
            ToggleView(isToggled: $isToggled)
            ViewModelDataView(data: viewModel.data) {
                viewModel.updateData()
            }
            .equatable()
        }
    }

    private var titleView: some View {
        Text("Big and Complicated View")
            .font(.largeTitle)
    }
}
```

Why this is better:

- changing `counter` only affects `CounterView`
- toggling only affects `ToggleView`
- updating the model data only affects `ViewModelDataView`

### Notes on Equatable

Using `Equatable` for a view is not a universal best practice, but it can be useful in targeted cases where:

- the input is small and well-defined
- the comparison logic is meaningful
- you want to reduce unnecessary body evaluation for a specific subtree

Do not use `Equatable` as a blanket optimization technique.

## Reusable Styling with ViewModifier

Extract repeated modifier combinations into a `ViewModifier` struct. Expose via a `View` extension for autocompletion:

```swift
private struct CardStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color(.secondarySystemBackground))
            .clipShape(.rect(cornerRadius: 12))
    }
}

extension View {
    func cardStyle() -> some View {
        modifier(CardStyle())
    }
}
```

### Custom ButtonStyle

Use the `ButtonStyle` protocol for reusable button designs. Use `PrimitiveButtonStyle` only when you need custom interaction handling (e.g., simultaneous gestures):

```swift
struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .bold()
            .foregroundStyle(.white)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(Color.accentColor)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .animation(.smooth, value: configuration.isPressed)
    }
}
```

### Discoverability with Static Member Lookup

Make custom styles and modifiers discoverable via leading-dot syntax:

```swift
extension ButtonStyle where Self == PrimaryButtonStyle {
    static var primary: PrimaryButtonStyle { .init() }
}

// Usage: .buttonStyle(.primary)
```

This pattern works for any SwiftUI style protocol (`ButtonStyle`, `ListStyle`, `ToggleStyle`, etc.).

## Skeleton Loading with Redacted Views

Use `.redacted(reason: .placeholder)` to show skeleton views while data loads. Use `.unredacted()` to opt out specific views:

```swift
VStack(alignment: .leading) {
    Text(article?.title ?? String(repeating: "X", count: 20))
        .font(.headline)
    Text(article?.author ?? String(repeating: "X", count: 12))
        .font(.subheadline)
    Text("SwiftLee")
        .font(.caption)
        .unredacted()
}
.redacted(reason: article == nil ? .placeholder : [])
```

Apply `.redacted` on a container to redact all children at once.

## AnyView

`AnyView` is type erasure. SwiftUI uses structural identity based on type information to determine when views should be updated.

```swift
private var nameView: some View {
    if isEditable {
        TextField("Your name", text: $name)
    } else {
        Text(name)
    }
}
```

Avoid patterns like:

```swift
private var nameView: some View {
    if isEditable {
        return AnyView(TextField("Your name", text: $name))
    } else {
        return AnyView(Text(name))
    }
}
```

Because `AnyView` erases type information, SwiftUI loses some optimization opportunities. Prefer `@ViewBuilder` or conditional branches with concrete view types.

Use `AnyView` only when type erasure is truly necessary for API design.

## UIViewRepresentable Essentials

When bridging UIKit views into SwiftUI:

- `makeUIView(context:)` is called **once** to create the UIKit view
- `updateUIView(_:context:)` is called on **every SwiftUI redraw** to sync state
- The representable struct itself is **recreated on every redraw** -- avoid heavy work in its init
- Use a `Coordinator` for delegate callbacks and two-way communication

```swift
struct MapView: UIViewRepresentable {
    let coordinate: CLLocationCoordinate2D

    func makeUIView(context: Context) -> MKMapView {
        let map = MKMapView()
        map.delegate = context.coordinator
        return map
    }

    func updateUIView(_ map: MKMapView, context: Context) {
        map.setCenter(coordinate, animated: true)
    }

    func makeCoordinator() -> Coordinator { Coordinator() }

    class Coordinator: NSObject, MKMapViewDelegate { }
}
```

## Troubleshooting

### Debug SwiftUI Renderings

If it is needed to debug render cycles and read console output you can leverage the `_printChanges()` or `_logChanges()` methods on `View`. These methods print information about when the view is being evaluated and what changes are triggering updates. This can be very helpful when your view body is called multiple times and you want to know why.

```swift
struct ContentView: View {
    @State private var counter: Int = 99

    init() {
        print(Self.self, #function)
    }

    var body: some View {
        let _ = Self._printChanges()

        VStack {
            Text("Counter: \(counter)")
            Button {
                counter += 1
            } label: {
                Text("Counter +1")
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}
```

As an alternative to `Self._printChanges()`, you can use `_logChanges()`

```swift
struct ContentView: View {
    @State private var counter: Int = 99

    var body: some View {
        let _ = Self._logChanges()

        VStack {
            Text("Counter: \(counter)")
            Button {
                counter += 1
            } label: {
                Text("Counter +1")
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}
```

Use these tools only for debugging and remove them from production code.

### Handling "The Compiler Is Unable to Type-Check This Expression in Reasonable Time"

If you encounter:

> The compiler is unable to type-check this expression in reasonable time; try breaking up the expression into distinct sub-expressions

it is often caused by overly complex view structures or expressions.

Ways to fix it:

- break large expressions into smaller computed values
- extract subviews
- split long modifier chains
- simplify nested generics and builders
- avoid huge inline closures

## Summary Checklist

- [ ] Follow a consistent view file structure (Environment → State → Private → Init → Body → Subviews)
- [ ] Prefer modifiers over conditional views for state changes
- [ ] Avoid `if`-based conditional modifier extensions (they break view identity)
- [ ] Extract complex views into separate subviews, not computed properties
- [ ] Keep views small for readability and performance
- [ ] Use `@ViewBuilder` only where it actually adds value
- [ ] Avoid heavy filtering, mapping, sorting, or formatter creation inside `body`
- [ ] Use lazy containers for large data sets
- [ ] Container views use `@ViewBuilder let content: Content`
- [ ] Prefer `overlay` / `background` for decoration and `ZStack` for peer composition
- [ ] `.compositingGroup()` before `.clipShape()` on layered views to avoid antialiasing fringes
- [ ] Split state-heavy areas into smaller view types
- [ ] Extract repeated styling into `ViewModifier` or `ButtonStyle`
- [ ] Expose reusable styles via static member lookup when it improves discoverability
- [ ] Use `.redacted(reason: .placeholder)` for loading skeletons
- [ ] Avoid `AnyView` unless type erasure is truly needed
- [ ] In `UIViewRepresentable`, keep heavy work out of struct init
- [ ] Use `_printChanges()` / `_logChanges()` to debug rendering behavior
- [ ] Break up overly complex expressions when the compiler struggles
