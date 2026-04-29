---
title: Combine useWatch with getValues for Timing Safety
impact: HIGH
impactDescription: prevents missed updates due to subscription timing
tags: sub, useWatch, getValues, timing, subscription
---

## Combine useWatch with getValues for Timing Safety

If `setValue()` is called before useWatch establishes its subscription, the update is missed. Combine useWatch with getValues to guarantee no updates are lost.

**Incorrect (setValue before subscription misses update):**

```typescript
function PrefillableForm() {
  const { setValue, control } = useForm()
  const couponCode = useWatch({ control, name: 'couponCode' })

  useEffect(() => {
    const savedCoupon = localStorage.getItem('savedCoupon')
    if (savedCoupon) {
      setValue('couponCode', savedCoupon)  // May fire before useWatch subscription
    }
  }, [setValue])

  return <div>Applied coupon: {couponCode}</div>  {/* May show stale value */}
}
```

**Correct (merge subscription with current values):**

```typescript
function PrefillableForm() {
  const { setValue, control, getValues } = useForm()

  const useFormValues = () => ({
    ...useWatch({ control }),
    ...getValues(),  // Fallback ensures no missed values
  })

  const { couponCode } = useFormValues()

  useEffect(() => {
    const savedCoupon = localStorage.getItem('savedCoupon')
    if (savedCoupon) {
      setValue('couponCode', savedCoupon)
    }
  }, [setValue])

  return <div>Applied coupon: {couponCode}</div>  {/* Always shows current value */}
}
```

Reference: [useWatch](https://react-hook-form.com/docs/usewatch)
