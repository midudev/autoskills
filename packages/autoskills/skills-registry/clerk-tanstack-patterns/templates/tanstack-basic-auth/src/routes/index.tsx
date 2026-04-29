import {
  Show,
  UserButton,
  SignInButton,
} from '@clerk/tanstack-react-start'
import { createFileRoute } from '@tanstack/react-router'

export const Route = createFileRoute('/')({
  component: Home,
})

function Home() {
  return (
    <div>
      <h1>Index Route</h1>
      <Show when="signed-in">
        <p>You are signed in</p>
        <UserButton />
      </Show>
      <Show when="signed-out">
        <p>You are signed out</p>
        <SignInButton />
      </Show>
    </div>
  )
}
