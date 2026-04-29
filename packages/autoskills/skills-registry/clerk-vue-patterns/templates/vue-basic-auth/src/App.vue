<script setup lang="ts">
import { Show, SignInButton, SignUpButton, UserButton } from '@clerk/vue'
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
</template>
