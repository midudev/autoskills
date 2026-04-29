# Dimensions by Scope

Dimension availability matrix for the Cost Management Query API, organized by scope type and agreement type.

## Scope URL Patterns

| Scope | URL Pattern |
|-------|-------------|
| Subscription | `/subscriptions/<subscription-id>` |
| Resource Group | `/subscriptions/<subscription-id>/resourceGroups/<resource-group-name>` |
| Management Group | `/providers/Microsoft.Management/managementGroups/<management-group-id>` |
| Billing Account | `/providers/Microsoft.Billing/billingAccounts/<billing-account-id>` |
| Billing Profile | `/providers/Microsoft.Billing/billingAccounts/<billing-account-id>/billingProfiles/<billing-profile-id>` |
| Invoice Section | `/providers/Microsoft.Billing/billingAccounts/<billing-account-id>/billingProfiles/<billing-profile-id>/invoiceSections/<invoice-section-id>` |
| Department (EA) | `/providers/Microsoft.Billing/billingAccounts/<billing-account-id>/departments/<department-id>` |
| Enrollment Account (EA) | `/providers/Microsoft.Billing/billingAccounts/<billing-account-id>/enrollmentAccounts/<enrollment-account-id>` |
| Customer (Partner) | `/providers/Microsoft.Billing/billingAccounts/<billing-account-id>/customers/<customer-id>` |

## Common Dimensions

The following dimensions are available across most scopes:

> ⚠️ **Warning:** `ResourceId` grouping is **only supported at subscription and resource group scopes**. At higher scopes (billing account, management group, billing profile, etc.), use `ServiceName`, `SubscriptionName`, or another supported dimension instead. See [guardrails.md](guardrails.md) for the full scope restriction table.

| Dimension | Description |
|-----------|-------------|
| `ResourceGroupName` | Resource group containing the resource. |
| `ResourceId` | Full Azure resource ID. |
| `ResourceLocation` | Azure region where the resource is deployed. |
| `ServiceName` | Azure service name (e.g., Virtual Machines, Storage). |
| `ServiceFamily` | Service family grouping (e.g., Compute, Storage, Networking). |
| `ServiceTier` | Service tier or SKU tier (e.g., Standard, Premium). |
| `MeterCategory` | Top-level meter classification. |
| `MeterSubCategory` | Meter sub-classification. |
| `Meter` | Specific meter name. |
| `ChargeType` | Type of charge (e.g., Usage, Purchase, Refund). |
| `PublisherType` | Publisher type (e.g., Azure, Marketplace, AWS). |
| `PricingModel` | Pricing model (e.g., OnDemand, Reservation, SavingsPlan, Spot). |
| `SubscriptionName` | Subscription display name. |
| `SubscriptionId` | Subscription GUID. |
| `TagKey` | Azure resource tag key (use with `TagKey` column type in grouping). |
| `Product` | Product name from the price sheet. |
| `BenefitName` | Reservation or savings plan name. |
| `BillingPeriod` | Billing period identifier. |

## Scope-Specific Dimensions

Additional dimensions available only at certain scopes:

| Scope | Additional Dimensions |
|-------|-----------------------|
| Subscription | _(common dimensions only)_ |
| Resource Group | _(common dimensions only)_ |
| Management Group | `DepartmentName`, `EnrollmentAccountName` |
| Billing Account | `BillingProfileName`, `DepartmentName`, `EnrollmentAccountName`, `InvoiceSectionName`, `Customer` |
| Billing Profile | `InvoiceSectionName`, `Customer` |
| Invoice Section | _(common dimensions only)_ |
| Department (EA) | `EnrollmentAccountName` |
| Enrollment Account (EA) | _(common dimensions only)_ |
| Customer (Partner) | _(common dimensions only)_ |

## Agreement Type Dimension Sets

Available dimensions vary by agreement type. Only dimensions listed for your agreement type are valid in GroupBy and Filter expressions.

### EA (Enterprise Agreement)

| Dimension | Available |
|-----------|-----------|
| `ResourceGroupName` | ✅ |
| `ResourceId` | ✅ ⚠️ |
| `SubscriptionName` | ✅ |
| `Product` | ✅ |
| `ResourceLocation` | ✅ |
| `ServiceName` | ✅ |
| `ServiceFamily` | ✅ |
| `TagKey` | ✅ |
| `MeterSubCategory` | ✅ |
| `PublisherType` | ✅ |
| `PricingModel` | ✅ |
| `ChargeType` | ✅ |
| `ServiceTier` | ✅ |
| `BenefitName` | ✅ |
| `BillingProfileName` | ✅ |
| `DepartmentName` | ✅ |
| `EnrollmentAccountName` | ✅ |
| `BillingPeriod` | ✅ |

### MCA (Microsoft Customer Agreement)

| Dimension | Available |
|-----------|-----------|
| `ResourceGroupName` | ✅ |
| `ResourceId` | ✅ ⚠️ |
| `SubscriptionName` | ✅ |
| `Product` | ✅ |
| `ResourceLocation` | ✅ |
| `ServiceName` | ✅ |
| `ServiceFamily` | ✅ |
| `TagKey` | ✅ |
| `MeterSubCategory` | ✅ |
| `PublisherType` | ✅ |
| `PricingModel` | ✅ |
| `ChargeType` | ✅ |
| `ServiceTier` | ✅ |
| `BenefitName` | ✅ |
| `BillingProfileName` | ✅ |
| `InvoiceSectionName` | ✅ |

### MOSP (Microsoft Online Services Program / Pay-As-You-Go)

| Dimension | Available |
|-----------|-----------|
| `ResourceGroupName` | ✅ |
| `ResourceId` | ✅ ⚠️ |
| `SubscriptionName` | ✅ |
| `Product` | ✅ |
| `ResourceLocation` | ✅ |
| `ServiceName` | ✅ |
| `ServiceFamily` | ✅ |
| `TagKey` | ✅ |
| `MeterSubCategory` | ✅ |
| `PublisherType` | ✅ |
| `PricingModel` | ✅ |
| `ChargeType` | ✅ |
| `ServiceTier` | ✅ |
| `BenefitName` | ✅ |

> ⚠️ `ResourceId` is available as a dimension but **only works in GroupBy at subscription and resource group scopes**. At billing account or management group scopes, use `ServiceName` or `SubscriptionName` instead.

### Comparison Summary

| Dimension | EA | MCA | MOSP |
|-----------|----|----|------|
| `ResourceGroupName` | ✅ | ✅ | ✅ |
| `ResourceId` | ✅ ⚠️ | ✅ ⚠️ | ✅ ⚠️ |
| `SubscriptionName` | ✅ | ✅ | ✅ |
| `Product` | ✅ | ✅ | ✅ |
| `ResourceLocation` | ✅ | ✅ | ✅ |
| `ServiceName` | ✅ | ✅ | ✅ |
| `ServiceFamily` | ✅ | ✅ | ✅ |
| `TagKey` | ✅ | ✅ | ✅ |
| `MeterSubCategory` | ✅ | ✅ | ✅ |
| `PublisherType` | ✅ | ✅ | ✅ |
| `PricingModel` | ✅ | ✅ | ✅ |
| `ChargeType` | ✅ | ✅ | ✅ |
| `ServiceTier` | ✅ | ✅ | ✅ |
| `BenefitName` | ✅ | ✅ | ✅ |
| `BillingProfileName` | ✅ | ✅ | ❌ |
| `DepartmentName` | ✅ | ❌ | ❌ |
| `EnrollmentAccountName` | ✅ | ❌ | ❌ |
| `InvoiceSectionName` | ❌ | ✅ | ❌ |
| `BillingPeriod` | ✅ | ❌ | ❌ |

## Scope Resolution Priority

When multiple scope identifiers are available in context, use the following priority order (highest first):

| Priority | Scope | Notes |
|----------|-------|-------|
| 1 | Management Group | Broadest organizational scope. |
| 2 | Resource Group | Narrowest resource scope. |
| 3 | Subscription | Default scope for most queries. |
| 4 | Billing Profile + Invoice Section | MCA billing hierarchy. |
| 5 | Billing Profile | MCA billing scope. |
| 6 | Department | EA organizational unit. |
| 7 | Enrollment Account | EA enrollment scope. |
| 8 | Customer | Partner/CSP customer scope. |
| 9 | Invoice Section | Standalone invoice section. |
| 10 | Billing Account | Top-level billing scope. |

> 💡 **Tip:** When a user provides both a subscription and a resource group, prefer the Resource Group scope (priority 2) over Subscription (priority 3) for more targeted results.

## Required Context Variables

The following context variables are needed to resolve scope and validate dimensions:

| Variable | Description | Used For |
|----------|-------------|----------|
| `AgreementType` | The agreement type (`EA`, `MCA`, `MOSP`). | Determines valid dimension set. |
| `AccountType` | Account type within the agreement. | Refines scope-specific behavior. |
| `CallScopeId` | The fully qualified scope URL for the API call. | Builds the request URL path. |
