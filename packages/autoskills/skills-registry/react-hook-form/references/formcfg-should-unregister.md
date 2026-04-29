---
title: Enable shouldUnregister for Dynamic Form Memory Efficiency
impact: HIGH
impactDescription: reduces memory usage for forms with frequently mounted/unmounted fields
tags: formcfg, should-unregister, dynamic-forms, memory
---

## Enable shouldUnregister for Dynamic Form Memory Efficiency

By default, unmounted fields retain their values and validation state. For forms with frequently added/removed fields, enable `shouldUnregister` to automatically clean up unmounted fields.

**Incorrect (unmounted fields persist in memory):**

```typescript
const { register, handleSubmit } = useForm({
  shouldUnregister: false,  // Default: unmounted fields stay in form state
})

function MultiStepForm() {
  const [step, setStep] = useState(1)

  return (
    <form onSubmit={handleSubmit(onSubmit)}>
      {step === 1 && (
        <input {...register('personalInfo.name')} />
      )}
      {step === 2 && (
        <input {...register('companyInfo.company')} />  {/* Step 1 fields still in memory */}
      )}
    </form>
  )
}
```

**Correct (unmounted fields cleaned up automatically):**

```typescript
const { register, handleSubmit } = useForm({
  shouldUnregister: true,  // Unmounted fields removed from form state
})

function MultiStepForm() {
  const [step, setStep] = useState(1)

  return (
    <form onSubmit={handleSubmit(onSubmit)}>
      {step === 1 && (
        <input {...register('personalInfo.name')} />
      )}
      {step === 2 && (
        <input {...register('companyInfo.company')} />  {/* Step 1 fields cleaned up */}
      )}
    </form>
  )
}
```

**When NOT to use:**
- Multi-step wizards where you need to preserve values across steps
- Conditional fields that should retain values when hidden

Reference: [useForm - shouldUnregister](https://react-hook-form.com/docs/useform)
