<script setup lang="ts">
</script>

<template>
  <header>
    <Show when="signed-out">
      <SignInButton />
      <SignUpButton />
    </Show>
    <Show when="signed-in">
      <UserButton />
    </Show>
  </header>

  <main>
    <NuxtPage />
  </main>
</template>
