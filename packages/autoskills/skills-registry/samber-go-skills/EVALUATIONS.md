<!-- prettier-ignore-start -->
<!-- markdownlint-disable table-column-style -->
<!-- markdownlint-disable no-space-in-emphasis -->

<style>
.g { color: #22863a; font-weight: bold; }
.r { color: #cb2431; font-weight: bold; }
</style>

# Evaluations

## Summary

| Skill                           | Version | Assertions | With Skill | Without Skill | Delta     | Uplift    | Concern                     |
| ------------------------------- | ------- | ---------- | ---------- | ------------- | --------- | --------- | --------------------------- |
| `golang-spf13-viper`            | v1.0.0  | 53         | 98%        | **100%**      | -2pp      | 0.98×     | **Low delta, high without** |
| `golang-spf13-cobra`            | v1.0.0  | 50         | 100%       | **98%**       | +2pp      | 1.02×     | **Low delta, high without** |
| `golang-naming`                 | v1.0.0  | 51         | 94%        | **71%**       | +24pp     | 1.32×     | **Low delta, high without** |
| `golang-swagger`                | v1.0.0  | 60         | 97%        | **72%**       | +25pp     | 1.35×     | **Low delta, high without** |
| `golang-error-handling`         | v1.0.0  | 60         | 98%        | **72%**       | +27pp     | 1.36×     | **Low delta, high without** |
| `golang-popular-libraries`      | v1.0.0  | 54         | 100%       | **70%**       | +30pp     | 1.43×     | **Low delta, high without** |
| `golang-security`               | v1.0.0  | 110        | 100%       | **68%**       | +32pp     | 1.47×     | **Low delta, high without** |
| `golang-testing`                | v1.0.0  | 65         | 92%        | 60%           | +32pp     | 1.53×     | **Low delta**               |
| `golang-troubleshooting`        | v1.0.0  | 186        | 100%       | **68%**       | +32pp     | 1.47×     | **Low delta, high without** |
| `golang-context`                | v1.0.0  | 50         | 96%        | 62%           | +34pp     | 1.55×     |                             |
| `golang-structs-interfaces`     | v1.0.0  | 52         | 100%       | **65%**       | +35pp     | 1.54×     | **High without**            |
| `golang-observability`          | v1.0.0  | 185        | 100%       | 63%           | +37pp     | 1.59×     |                             |
| `golang-design-patterns`        | v1.0.0  | 87         | 100%       | 63%           | +37pp     | 1.59×     |                             |
| `golang-database`               | v1.0.0  | 74         | 95%        | 57%           | +38pp     | 1.67×     |                             |
| `golang-project-layout`         | v1.0.0  | 55         | 100%       | 62%           | +38pp     | 1.61×     |                             |
| `golang-data-structures`        | v1.0.0  | 36         | 100%       | 61%           | +39pp     | 1.64×     |                             |
| `golang-performance`            | v1.0.0  | 272        | 100%       | 61%           | +39pp     | 1.64×     |                             |
| `golang-concurrency`            | v1.0.0  | 62         | 100%       | 61%           | +39pp     | 1.64×     |                             |
| `golang-code-style`             | v1.0.0  | 83         | **80%**    | 40%           | +40pp     | 2.00×     | **Low with-skill score**    |
| `golang-lint`                 | v1.0.0  | 51         | 96%        | 55%           | +41pp     | 1.75×     |                             |
| `golang-grpc`                   | v1.0.0  | 55         | 96%        | 55%           | +42pp     | 1.75×     |                             |
| `golang-cli`                    | v1.0.0  | 58         | 95%        | 52%           | +43pp     | 1.83×     |                             |
| `golang-dependency-injection`   | v1.0.0  | 55         | 98%        | 51%           | +47pp     | 1.92×     |                             |
| `golang-stretchr-testify`       | v1.0.0  | 47         | 100%       | 53%           | +47pp     | 1.89×     |                             |
| `golang-samber-mo`              | v1.0.0  | 108        | **88%**    | 40%           | +48pp     | 2.20×     | **Low with-skill score**    |
| `golang-benchmark`              | v1.0.0  | 356        | 100%       | 50%           | +50pp     | 2.00×     |                             |
| `golang-samber-ro`              | v1.0.0  | 113        | 100%       | 50%           | +50pp     | 2.00×     |                             |
| `golang-documentation`          | v1.0.0  | 103        | 90%        | 37%           | +53pp     | 2.43×     |                             |
| `golang-samber-hot`             | v1.0.0  | 65         | 94%        | 40%           | +54pp     | 2.35×     |                             |
| `golang-dependency-management`  | v1.0.0  | 52         | 100%       | 46%           | +54pp     | 2.17×     |                             |
| `golang-stay-updated`           | v1.0.0  | 50         | 92%        | 36%           | +56pp     | 2.56×     |                             |
| `golang-safety`                 | v1.0.0  | 151        | 99%        | 41%           | +58pp     | 2.41×     |                             |
| `golang-continuous-integration` | v1.0.0  | 66         | 100%       | 41%           | +59pp     | 2.44×     |                             |
| `golang-samber-oops`            | v1.0.0  | 52         | 94%        | 35%           | +60pp     | 2.69×     |                             |
| `golang-modernize`              | v1.0.0  | 76         | 95%        | 34%           | +61pp     | 2.79×     |                             |
| `golang-samber-slog`            | v1.0.0  | 62         | 92%        | **73%**       | +19pp     | 1.26×     | **Low delta, high without** |
| `golang-samber-lo`              | v1.0.0  | 86         | 97%        | 57%           | +40pp     | 1.70×     |                             |
| `golang-uber-fx`                | v1.0.0  | 21         | 100%       | **95%**       | +5pp      | 1.05×     | **Low delta, high without** |
| `golang-uber-dig`               | v1.0.0  | 20         | 100%       | **90%**       | +10pp     | 1.11×     | **Low delta, high without** |
| `golang-google-wire`            | v1.0.0  | 50         | 98%        | **82%**       | +16pp     | 1.20×     | **Low delta, high without** |
| `golang-graphql`                | v0.0.2  | 59         | 100%       | **83%**       | +17pp     | 1.20×     | **Low delta, high without** |
| `golang-samber-do`              | v1.0.0  | 53         | 100%       | 19%           | +81pp     | 5.26×     |                             |
| **Total (41 skills)**           |         | **3395**   | **98%**    | **56%**       | **+41pp** | **1.73×** |                             |

## `golang-naming` — v1.0.0

|             | With Skill      | Without Skill   | Delta     |
| ----------- | --------------- | --------------- | --------- |
| **Overall** | **48/51 (94%)** | **36/51 (71%)** | **+24pp** |

<details>
<summary>Full breakdown (51 assertions)</summary>

**Model:** Claude Opus 4.6 | **Runs:** 12 evals × 2 configs = 24 subagents | **Grading:** automated regex

| #    | Assertion                                                                        | With                           | Without                                     |
| ---- | -------------------------------------------------------------------------------- | ------------------------------ | ------------------------------------------- |
|      | **1. cache** — Get/Set/Delete, sentinel errors, options                          | **<span class="g">4/5</span>** | **<span class="g">4/5</span>**              |
| 1.1  | Constructor is `New()`                                                           | <span class="g">✓</span>       | <span class="g">✓</span>                    |
| 1.2  | Error strings include `"cache:"` prefix                                          | <span class="g">✓</span>       | <span class="g">✓</span>                    |
| 1.3  | Option functions use `With` prefix                                               | <span class="r">✗</span>       | <span class="r">✗</span>                    |
| 1.4  | Error strings fully lowercase                                                    | <span class="g">✓</span>       | <span class="g">✓</span>                    |
| 1.5  | Option type is `Option` not `CacheOption`                                        | <span class="g">✓</span>       | <span class="g">✓</span>                    |
|      | **2. worker** — boolean fields: processing/initialized/canAccept                 | **<span class="g">4/4</span>** | **<span class="r">3/4</span>**              |
| 2.1  | Boolean fields use `is`/`has`/`can` prefix                                       | <span class="g">✓</span>       | <span class="g">✓</span>                    |
| 2.2  | Getter methods use `Is`/`Has`/`Can` prefix                                       | <span class="g">✓</span>       | <span class="g">✓</span>                    |
| 2.3  | Constructor is `New()`                                                           | <span class="g">✓</span>       | <span class="r">✗</span>                    |
| 2.4  | Receiver is 1-2 letter abbreviation                                              | <span class="g">✓</span>       | <span class="g">✓</span>                    |
|      | **3. taskqueue** — `TaskStatus` enum (iota) + `String()`                         | **<span class="g">2/3</span>** | **<span class="g">2/3</span>**              |
| 3.1  | Enum values prefixed with type name                                              | <span class="g">✓</span>       | <span class="g">✓</span>                    |
| 3.2  | Zero value is `TaskStatusUnknown` sentinel                                       | <span class="r">✗</span>       | <span class="r">✗</span>                    |
| 3.3  | `String()` method on enum type                                                   | <span class="g">✓</span>       | <span class="g">✓</span>                    |
|      | **4. httpclient** — fix naming: `HttpClient`, `base_url`, `GetBaseUrl()`, `this` | **<span class="g">6/7</span>** | **<span class="r">3/7</span>**              |
| 4.1  | Struct renamed to `Client` (anti-stutter)                                        | <span class="g">✓</span>       | <span class="r">✗</span> kept HTTPClient    |
| 4.2  | Constructor renamed to `New()`                                                   | <span class="g">✓</span>       | <span class="r">✗</span> NewHTTPClient()    |
| 4.3  | Field uses `baseURL` (correct acronym)                                           | <span class="r">✗</span>       | <span class="r">✗</span>                    |
| 4.4  | Getter drops `Get` prefix: `BaseURL()`                                           | <span class="g">✓</span>       | <span class="g">✓</span>                    |
| 4.5  | Boolean getter uses `IsConnected()`                                              | <span class="g">✓</span>       | <span class="g">✓</span>                    |
| 4.6  | Receiver is 1-2 letters, not `this`                                              | <span class="g">✓</span>       | <span class="g">✓</span>                    |
| 4.7  | Boolean field uses `isConnected`                                                 | <span class="g">✓</span>       | <span class="r">✗</span> bare `connected`   |
|      | **5. auth-tests** — table-driven tests for `ValidateToken()`                     | **<span class="g">4/4</span>** | **<span class="r">2/4</span>**              |
| 5.1  | Subtest names fully lowercase                                                    | <span class="g">✓</span>       | <span class="r">✗</span>                    |
| 5.2  | Acronyms lowercase in subtests                                                   | <span class="g">✓</span>       | <span class="r">✗</span> uppercase "ID"     |
| 5.3  | Test function named `TestValidateToken`                                          | <span class="g">✓</span>       | <span class="g">✓</span>                    |
| 5.4  | Table struct uses descriptive field names                                        | <span class="g">✓</span>       | <span class="g">✓</span>                    |
|      | **6. storage** — functional options: bucket, region, endpoint URL, retries       | **<span class="g">4/4</span>** | **<span class="r">3/4</span>**              |
| 6.1  | Option type is `Option` not `StoreOption`                                        | <span class="g">✓</span>       | <span class="g">✓</span>                    |
| 6.2  | All option functions use `With` prefix                                           | <span class="g">✓</span>       | <span class="g">✓</span>                    |
| 6.3  | Constructor is `New()`                                                           | <span class="g">✓</span>       | <span class="r">✗</span> NewStore()         |
| 6.4  | `URL` acronym is all-caps                                                        | <span class="g">✓</span>       | <span class="g">✓</span>                    |
|      | **7. metrics** — MixedCaps constants, sentinel errors                            | **<span class="g">4/4</span>** | **<span class="g">4/4</span>**              |
| 7.1  | Constants use MixedCaps not ALL_CAPS                                             | <span class="g">✓</span>       | <span class="g">✓</span>                    |
| 7.2  | Error variables use `Err` prefix                                                 | <span class="g">✓</span>       | <span class="g">✓</span>                    |
| 7.3  | Error strings fully lowercase                                                    | <span class="g">✓</span>       | <span class="g">✓</span>                    |
| 7.4  | Error strings include `"metrics:"` prefix                                        | <span class="g">✓</span>       | <span class="g">✓</span>                    |
|      | **8. notifier** — email/SMS/push interfaces, Dispatcher, error types             | **<span class="g">4/4</span>** | **<span class="g">4/4</span>**              |
| 8.1  | Interface uses `-er` suffix                                                      | <span class="g">✓</span>       | <span class="g">✓</span>                    |
| 8.2  | No stuttering in type names                                                      | <span class="g">✓</span>       | <span class="g">✓</span>                    |
| 8.3  | Constructor is `New()`                                                           | <span class="g">✓</span>       | <span class="g">✓</span>                    |
| 8.4  | Error types use `Error` suffix                                                   | <span class="g">✓</span>       | <span class="g">✓</span>                    |
|      | **9. eventbus** — sentinel errors incl. "invalid event ID", custom error type    | **<span class="g">4/4</span>** | **<span class="r">2/4</span>**              |
| 9.1  | Sentinel errors use `Err` prefix                                                 | <span class="g">✓</span>       | <span class="g">✓</span>                    |
| 9.2  | Custom error type uses `Error` suffix                                            | <span class="g">✓</span>       | <span class="g">✓</span>                    |
| 9.3  | Error string uses lowercase `"id"`                                               | <span class="g">✓</span>       | <span class="r">✗</span> "invalid event ID" |
| 9.4  | Error strings include `"eventbus:"` prefix                                       | <span class="g">✓</span>       | <span class="r">✗</span> no prefix          |
|      | **10. config** — Load/Save/Get/Set/Validate/Reset/MergeFrom/String               | **<span class="g">3/3</span>** | **<span class="r">2/3</span>**              |
| 10.1 | All methods use consistent 1-2 letter receiver                                   | <span class="g">✓</span>       | <span class="g">✓</span>                    |
| 10.2 | Constructor is `New()`                                                           | <span class="g">✓</span>       | <span class="r">✗</span> NewConfig()        |
| 10.3 | No stuttering in type names                                                      | <span class="g">✓</span>       | <span class="g">✓</span>                    |
|      | **11. ratelimiter** — token bucket, options, Status enum, boolean methods        | **<span class="g">5/5</span>** | **<span class="r">3/5</span>**              |
| 11.1 | Constructor is `New()`                                                           | <span class="g">✓</span>       | <span class="r">✗</span> NewLimiter()       |
| 11.2 | Status enum has `StatusUnknown` at iota 0                                        | <span class="g">✓</span>       | <span class="r">✗</span> Allowed at iota 0  |
| 11.3 | Boolean methods use `Is`/`Has` prefix                                            | <span class="g">✓</span>       | <span class="g">✓</span>                    |
| 11.4 | Option functions use `With` prefix                                               | <span class="g">✓</span>       | <span class="g">✓</span>                    |
| 11.5 | Error strings lowercase with package prefix                                      | <span class="g">✓</span>       | <span class="g">✓</span>                    |
|      | **12. parser** — `Parse`, `MustParse`, `ParseWithContext`, `AST`, `ParseError`   | **<span class="g">4/4</span>** | **<span class="g">4/4</span>**              |
| 12.1 | Panic variant uses `MustParse`                                                   | <span class="g">✓</span>       | <span class="g">✓</span>                    |
| 12.2 | Context variant uses `ParseWithContext`                                          | <span class="g">✓</span>       | <span class="g">✓</span>                    |
| 12.3 | Error type uses `ParseError`                                                     | <span class="g">✓</span>       | <span class="g">✓</span>                    |
| 12.4 | No stuttering on constructor                                                     | <span class="g">✓</span>       | <span class="g">✓</span>                    |

</details>

## `golang-code-style` — v1.0.0

|             | With Skill      | Without Skill   | Delta     |
| ----------- | --------------- | --------------- | --------- |
| **Overall** | **66/83 (80%)** | **33/83 (40%)** | **+40pp** |

<details>
<summary>Full breakdown (83 assertions across 24 evals)</summary>

**Model:** Claude Sonnet 4.6 | **Runs:** 24 evals × 2 configs = 48 runs | **Grading:** Human-as-judge

| #    | Assertion                                                                         | With                                        | Without                                                    |
| ---- | --------------------------------------------------------------------------------- | ------------------------------------------- | ---------------------------------------------------------- |
|      | **1. cache** — var declarations: `:=` vs `var`, zero-value init                   | **<span class="g">3/3</span>**              | **<span class="g">3/3</span>**                             |
| 1.1  | Zero-value fields omitted from constructor (rely on Go zero values)               | <span class="g">✓</span>                    | <span class="g">✓</span>                                   |
| 1.2  | Non-zero assignments use `:=` short declaration                                   | <span class="g">✓</span>                    | <span class="g">✓</span>                                   |
| 1.3  | Done channel created with `make()`, not nil                                       | <span class="g">✓</span>                    | <span class="g">✓</span>                                   |
|      | **2. handler** — slice/map initialization: never nil                              | **<span class="g">3/3</span>**              | **<span class="r">2/3</span>**                             |
| 2.1  | Empty slice uses `[]User{}` or `make()`, not nil                                  | <span class="g">✓</span>                    | <span class="g">✓</span>                                   |
| 2.2  | Empty map uses `map[K]V{}` or `make()`, not nil                                   | <span class="g">✓</span>                    | <span class="g">✓</span>                                   |
| 2.3  | Known-capacity collections use `make()` with size hint                            | <span class="g">✓</span>                    | <span class="r">✗</span> no capacity hint                  |
|      | **3. server** — composite literals: named fields                                  | **<span class="g">3/3</span>**              | **<span class="g">3/3</span>**                             |
| 3.1  | `http.Server` uses named fields                                                   | <span class="g">✓</span>                    | <span class="g">✓</span>                                   |
| 3.2  | `tls.Config` uses named fields                                                    | <span class="g">✓</span>                    | <span class="g">✓</span>                                   |
| 3.3  | No positional struct syntax in file                                               | <span class="g">✓</span>                    | <span class="g">✓</span>                                   |
|      | **4. orders** — early return: guard clauses, flat happy path                      | **<span class="g">3/3</span>**              | **<span class="r">0/3</span>**                             |
| 4.1  | Validation uses early return, not nested else                                     | <span class="g">✓</span>                    | <span class="r">✗</span> deeply nested if-else             |
| 4.2  | Happy path at indentation level 1                                                 | <span class="g">✓</span>                    | <span class="r">✗</span> level 5 nesting                   |
| 4.3  | Max 2 indentation levels for main logic                                           | <span class="g">✓</span>                    | <span class="r">✗</span> 6 levels deep                     |
|      | **5. auth** — unnecessary else: early return, default-then-override               | **<span class="g">2/2</span>**              | **<span class="r">1/2</span>**                             |
| 5.1  | `GetUserRole` uses no else after return                                           | <span class="g">✓</span>                    | <span class="g">✓</span>                                   |
| 5.2  | `SetLogLevel` uses default-then-override (no else)                                | <span class="g">✓</span>                    | <span class="r">✗</span> `var` zero-value + switch default |
|      | **6. events** — switch vs if-else chains                                          | **<span class="g">3/3</span>**              | **<span class="r">2/3</span>**                             |
| 6.1  | `HandleEvent` uses switch                                                         | <span class="g">✓</span>                    | <span class="g">✓</span>                                   |
| 6.2  | `MapStatusCode` uses switch                                                       | <span class="g">✓</span>                    | <span class="g">✓</span>                                   |
| 6.3  | Both switches include default case                                                | <span class="g">✓</span>                    | <span class="r">✗</span> HandleEvent no default            |
|      | **7. notify** — function design: ≤4 params, options struct                        | **<span class="g">3/3</span>**              | **<span class="r">1/3</span>**                             |
| 7.1  | `context.Context` is first parameter                                              | <span class="g">✓</span>                    | <span class="g">✓</span>                                   |
| 7.2  | Options struct reduces params to ≤4                                               | <span class="g">✓</span>                    | <span class="r">✗</span> 10 individual params              |
| 7.3  | Config fields grouped in options struct                                           | <span class="g">✓</span>                    | <span class="r">✗</span> no struct                         |
|      | **8. users** — value vs pointer: small types by value                             | **<span class="g">3/3</span>**              | **<span class="r">1/3</span>**                             |
| 8.1  | `FormatName` takes `string` by value, not `*string`                               | <span class="g">✓</span>                    | <span class="r">✗</span> `*string` params                  |
| 8.2  | `UpdateAge` takes `*User` (mutation)                                              | <span class="g">✓</span>                    | <span class="g">✓</span>                                   |
| 8.3  | `CompareUsers` takes `User` by value (small, read-only)                           | <span class="g">✓</span>                    | <span class="r">✗</span> `*User` params                    |
|      | **9. repository** — code organization: canonical ordering                         | **<span class="g">3/3</span>**              | **<span class="g">3/3</span>**                             |
| 9.1  | File ordered: imports → constants → interface → struct → ctor → methods → helpers | <span class="g">✓</span>                    | <span class="g">✓</span>                                   |
| 9.2  | Interface declared before implementing struct                                     | <span class="g">✓</span>                    | <span class="g">✓</span>                                   |
| 9.3  | Helpers after all methods, not interleaved                                        | <span class="g">✓</span>                    | <span class="g">✓</span>                                   |
|      | **10. report** — string handling: strconv, Builder, Sprintf                       | **<span class="g">3/3</span>**              | **<span class="g">3/3</span>**                             |
| 10.1 | Int-to-string uses `strconv.Itoa`, not `fmt.Sprintf`                              | <span class="g">✓</span>                    | <span class="g">✓</span>                                   |
| 10.2 | Loop concatenation uses `strings.Builder`                                         | <span class="g">✓</span>                    | <span class="g">✓</span>                                   |
| 10.3 | Complex formatting uses `fmt.Sprintf`                                             | <span class="g">✓</span>                    | <span class="g">✓</span>                                   |
|      | **11. authz** — complex conditions: named booleans                                | **<span class="r">1/3</span>**              | **<span class="r">1/3</span>**                             |
| 11.1 | ≥2 conditions extracted to named booleans                                         | <span class="r">✗</span> all inline         | <span class="r">✗</span> all inline                        |
| 11.2 | Named booleans have descriptive names                                             | <span class="r">✗</span> no booleans        | <span class="r">✗</span> no booleans                       |
| 11.3 | Expensive check kept inline for short-circuit                                     | <span class="g">✓</span>                    | <span class="g">✓</span>                                   |
|      | **12. router** — line breaking: semantic boundaries                               | **<span class="r">0/3</span>**              | **<span class="r">0/3</span>**                             |
| 12.1 | Multi-arg calls broken across lines                                               | <span class="r">✗</span> single-line calls  | <span class="r">✗</span> single-line calls                 |
| 12.2 | Breaks at semantic boundaries (commas)                                            | <span class="r">✗</span> no breaks          | <span class="r">✗</span> no breaks                         |
| 12.3 | Closing paren on own line (trailing-comma style)                                  | <span class="r">✗</span> no multi-line      | <span class="r">✗</span> no multi-line                     |
|      | **13. nil-return** — (adversarial: "return nil, caller checks")                   | **<span class="r">0/3</span>**              | **<span class="r">0/3</span>**                             |
| 13.1 | GetUsers returns `[]User{}` not nil for empty                                     | <span class="r">✗</span> `var` nil slice    | <span class="r">✗</span> `var` nil slice                   |
| 13.2 | GetMetadata returns `map{}` not nil for empty                                     | <span class="r">✗</span> lazy-init nil      | <span class="r">✗</span> lazy-init nil                     |
| 13.3 | No `return nil` as success path                                                   | <span class="r">✗</span> returns nil        | <span class="r">✗</span> returns nil                       |
|      | **14. sprintf-concat** — (adversarial: "use Sprintf and +=")                      | **<span class="r">0/4</span>**              | **<span class="r">0/4</span>**                             |
| 14.1 | Uses `strconv.Itoa`, not `fmt.Sprintf`                                            | <span class="r">✗</span> Sprintf            | <span class="r">✗</span> Sprintf                           |
| 14.2 | Uses `strings.Builder`, not `+=`                                                  | <span class="r">✗</span> result +=          | <span class="r">✗</span> result +=                         |
| 14.3 | No `+=` inside loop body                                                          | <span class="r">✗</span> += in loop         | <span class="r">✗</span> += in loop                        |
| 14.4 | Builder declared before loop                                                      | <span class="r">✗</span> no Builder         | <span class="r">✗</span> no Builder                        |
|      | **15. positional-fields** — (adversarial: "positional for brevity")               | **<span class="g">4/4</span>**              | **<span class="r">0/4</span>**                             |
| 15.1 | Point uses named fields                                                           | <span class="g">✓</span>                    | <span class="r">✗</span> `Point{1.5, 2.5}`                 |
| 15.2 | Color uses named fields                                                           | <span class="g">✓</span>                    | <span class="r">✗</span> `Color{255, 128, 0, 255}`         |
| 15.3 | ServerConfig uses named fields                                                    | <span class="g">✓</span>                    | <span class="r">✗</span> positional                        |
| 15.4 | No positional syntax in file                                                      | <span class="g">✓</span>                    | <span class="r">✗</span> all positional                    |
|      | **16. deep-nesting** — (adversarial: "nested if-else is clearer")                 | **<span class="g">4/4</span>**              | **<span class="r">0/4</span>**                             |
| 16.1 | Validations use early return                                                      | <span class="g">✓</span>                    | <span class="r">✗</span> nested if-else                    |
| 16.2 | No nested else blocks for validation                                              | <span class="g">✓</span>                    | <span class="r">✗</span> 6 else blocks                     |
| 16.3 | Happy path at indentation level 1                                                 | <span class="g">✓</span>                    | <span class="r">✗</span> level 6 nesting                   |
| 16.4 | Max 2 indentation levels                                                          | <span class="g">✓</span>                    | <span class="r">✗</span> 7 levels deep                     |
|      | **17. ctx-last-many-params** — (adversarial: "keep exact order")                  | **<span class="r">0/4</span>**              | **<span class="r">0/4</span>**                             |
| 17.1 | `context.Context` is first parameter                                              | <span class="r">✗</span> position 11        | <span class="r">✗</span> position 11                       |
| 17.2 | ≤4 params with options struct                                                     | <span class="r">✗</span> 12 params          | <span class="r">✗</span> 12 params                         |
| 17.3 | Options struct groups config                                                      | <span class="r">✗</span> no struct          | <span class="r">✗</span> no struct                         |
| 17.4 | Logger in struct or on Service type                                               | <span class="r">✗</span> standalone         | <span class="r">✗</span> standalone                        |
|      | **18. pointer-everything** — (adversarial: "pointers for zero-copy")              | **<span class="g">5/5</span>**              | **<span class="g">5/5</span>**                             |
| 18.1 | `Add` takes `(int, int) int`                                                      | <span class="g">✓</span>                    | <span class="g">✓</span>                                   |
| 18.2 | `IsEven` takes `(int) bool`                                                       | <span class="g">✓</span>                    | <span class="g">✓</span>                                   |
| 18.3 | `FormatDuration` takes `(Duration) string`                                        | <span class="g">✓</span>                    | <span class="g">✓</span>                                   |
| 18.4 | `Concat` takes `(string, string) string`                                          | <span class="g">✓</span>                    | <span class="g">✓</span>                                   |
| 18.5 | No pointer params for small types                                                 | <span class="g">✓</span>                    | <span class="g">✓</span>                                   |
|      | **19. inline-conditions** — (adversarial: "do NOT use variables", 5 conds)        | **<span class="g">4/4</span>**              | **<span class="r">1/4</span>**                             |
| 19.1 | ≥3 conditions extracted to named booleans                                         | <span class="g">✓</span>                    | <span class="r">✗</span> all inline                        |
| 19.2 | Descriptive domain names (isSuperAdmin, sameDepartment…)                          | <span class="g">✓</span>                    | <span class="r">✗</span> no booleans                       |
| 19.3 | Final if/switch reads like business logic                                         | <span class="g">✓</span>                    | <span class="r">✗</span> wall of conditions                |
| 19.4 | Expensive checks extracted last or kept inline                                    | <span class="g">✓</span>                    | <span class="g">✓</span>                                   |
|      | **20. single-line-handlers** — (adversarial: "compact single line", 8 args)       | **<span class="g">4/4</span>**              | **<span class="r">1/4</span>**                             |
| 20.1 | `processRequest` broken across multiple lines                                     | <span class="g">✓</span>                    | <span class="r">✗</span> single-line calls                 |
| 20.2 | No line exceeds ~140 characters                                                   | <span class="g">✓</span>                    | <span class="r">✗</span> 170+ char lines                   |
| 20.3 | Closing paren on own line                                                         | <span class="g">✓</span>                    | <span class="r">✗</span> all inline                        |
| 20.4 | Service name extracted to constant                                                | <span class="g">✓</span>                    | <span class="g">✓</span>                                   |
|      | **21. else-chains** — (adversarial: "use else after every if")                    | **<span class="g">4/4</span>**              | **<span class="r">0/4</span>**                             |
| 21.1 | Uses switch or early returns, not if-else chain                                   | <span class="g">✓</span>                    | <span class="r">✗</span> if/else-if/else chain             |
| 21.2 | No `else` keyword in function body                                                | <span class="g">✓</span>                    | <span class="r">✗</span> 5 else keywords                   |
| 21.3 | Each condition returns without else block                                         | <span class="g">✓</span>                    | <span class="r">✗</span> every return has else             |
| 21.4 | Uses tagless switch for multi-condition                                           | <span class="g">✓</span>                    | <span class="r">✗</span> no switch                         |
|      | **22. export-everything** — (adversarial: "export all for reusability")           | **<span class="r">3/4</span>**              | **<span class="r">2/4</span>**                             |
| 22.1 | ≥2 internal helpers unexported                                                    | <span class="r">✗</span> all funcs exported | <span class="r">✗</span> all exported                      |
| 22.2 | Internal types unexported                                                         | <span class="g">✓</span>                    | <span class="r">✗</span> `DangerousHeaders` exported       |
| 22.3 | Public API functions remain exported                                              | <span class="g">✓</span>                    | <span class="g">✓</span>                                   |
| 22.4 | No purely-internal function exported                                              | <span class="g">✓</span>                    | <span class="g">✓</span>                                   |
|      | **23. speculative-prealloc** — (adversarial: "make([], 0, 100000)")               | **<span class="g">4/4</span>**              | **<span class="g">4/4</span>**                             |
| 23.1 | Results not preallocated with 100000                                              | <span class="g">✓</span>                    | <span class="g">✓</span>                                   |
| 23.2 | Metadata not preallocated with 10000                                              | <span class="g">✓</span>                    | <span class="g">✓</span>                                   |
| 23.3 | Outer slice uses `len(jobIDs)` hint                                               | <span class="g">✓</span>                    | <span class="g">✓</span>                                   |
| 23.4 | No capacity hint > 1000                                                           | <span class="g">✓</span>                    | <span class="g">✓</span>                                   |
|      | **24. nested-loop** — (adversarial: "nested if-else in loop body")                | **<span class="g">4/4</span>**              | **<span class="r">0/4</span>**                             |
| 24.1 | Uses `continue` for validation failures                                           | <span class="g">✓</span>                    | <span class="r">✗</span> nested if-else                    |
| 24.2 | Max 2 indentation levels in loop                                                  | <span class="g">✓</span>                    | <span class="r">✗</span> 5 levels deep                     |
| 24.3 | ≥1 helper function extracted                                                      | <span class="g">✓</span>                    | <span class="r">✗</span> everything inline                 |
| 24.4 | Happy path at shallowest loop level                                               | <span class="g">✓</span>                    | <span class="r">✗</span> nested 4+ deep                    |

</details>

## `golang-data-structures` — v1.0.0

|             | With Skill       | Without Skill   | Delta     |
| ----------- | ---------------- | --------------- | --------- |
| **Overall** | **36/36 (100%)** | **22/36 (61%)** | **+39pp** |

<details>
<summary>Full breakdown (36 assertions)</summary>

**Model:** Claude Sonnet 4.6 | **Runs:** 12 evals × 2 configs = 24 subagents | **Grading:** Human-as-judge

| #    | Assertion                                                           | With                           | Without                                                |
| ---- | ------------------------------------------------------------------- | ------------------------------ | ------------------------------------------------------ |
|      | **1. buffer-for-io** — RenderAndStream to io.Writer                 | **<span class="g">3/3</span>** | **<span class="g">3/3</span>**                         |
| 1.1  | Correct output to io.Writer                                         | <span class="g">✓</span>       | <span class="g">✓</span>                               |
| 1.2  | Efficient output assembly with Grow                                 | <span class="g">✓</span>       | <span class="g">✓</span>                               |
| 1.3  | No unnecessary intermediate allocation                              | <span class="g">✓</span>       | <span class="g">✓</span>                               |
|      | **2. sorted-set** — SortedSet[T] with Min/Max/Insert                | **<span class="g">3/3</span>** | **<span class="g">3/3</span>**                         |
| 2.1  | Uses `cmp.Ordered` constraint                                       | <span class="g">✓</span>       | <span class="g">✓</span>                               |
| 2.2  | Binary search for Insert/Contains                                   | <span class="g">✓</span>       | <span class="g">✓</span>                               |
| 2.3  | Min/Max O(1) from sorted slice ends                                 | <span class="g">✓</span>       | <span class="g">✓</span>                               |
|      | **3. AddCleanup** — string intern with auto map shrink              | **<span class="g">3/3</span>** | **<span class="r">1/3</span>**                         |
| 3.1  | Uses `weak.Pointer` or `weak.Make`                                  | <span class="g">✓</span>       | <span class="r">✗</span> `runtime.SetFinalizer`        |
| 3.2  | Uses `runtime.AddCleanup` (not SetFinalizer)                        | <span class="g">✓</span>       | <span class="r">✗</span> SetFinalizer + unique.Handle  |
| 3.3  | Dead map entries automatically removed                              | <span class="g">✓</span>       | <span class="g">✓</span>                               |
|      | **4. unsafe.Add-modern** — read packed binary header (Go 1.17+)     | **<span class="g">3/3</span>** | **<span class="r">2/3</span>**                         |
| 4.1  | Uses `unsafe.Add` for pointer arithmetic                            | <span class="g">✓</span>       | <span class="r">✗</span> `uintptr` arithmetic          |
| 4.2  | No intermediate `uintptr` variable                                  | <span class="g">✓</span>       | <span class="g">✓</span>                               |
| 4.3  | Bounds check before unsafe access                                   | <span class="g">✓</span>       | <span class="g">✓</span>                               |
|      | **5. full-slice-expr** — SplitIntoChunks with append-safe output    | **<span class="g">3/3</span>** | **<span class="r">1/3</span>**                         |
| 5.1  | Chunks are append-safe (no aliasing)                                | <span class="g">✓</span>       | <span class="g">✓</span>                               |
| 5.2  | Uses full-slice expression `[:n:n]`                                 | <span class="g">✓</span>       | <span class="r">✗</span> `make` + `copy` per chunk     |
| 5.3  | Minimal extra allocations (reuses backing array)                    | <span class="g">✓</span>       | <span class="r">✗</span> N fresh allocations           |
|      | **6. list-valid-use** — OrderedMap with O(1) middle deletion        | **<span class="g">3/3</span>** | **<span class="r">2/3</span>**                         |
| 6.1  | Uses `container/list` from stdlib                                   | <span class="g">✓</span>       | <span class="r">✗</span> custom generic linked list    |
| 6.2  | Map stores `*list.Element` for O(1) access                          | <span class="g">✓</span>       | <span class="g">✓</span>                               |
| 6.3  | Delete is O(1) via element reference                                | <span class="g">✓</span>       | <span class="g">✓</span>                               |
|      | **7. composite-struct-key** — route cache keyed by (method, path)   | **<span class="g">3/3</span>** | **<span class="r">0/3</span>**                         |
| 7.1  | Uses struct or array as map key                                     | <span class="g">✓</span>       | <span class="r">✗</span> string concat with NUL sep    |
| 7.2  | Zero allocation on lookup path                                      | <span class="g">✓</span>       | <span class="r">✗</span> complex `unsafe` stack tricks |
| 7.3  | Simple, readable key type                                           | <span class="g">✓</span>       | <span class="r">✗</span> `sync.Map` + `unsafe` hacks   |
|      | **8. map-memory-diag** — diagnose 2GB RSS after bulk delete         | **<span class="g">3/3</span>** | **<span class="g">3/3</span>**                         |
| 8.1  | Diagnoses "maps never shrink buckets"                               | <span class="g">✓</span>       | <span class="g">✓</span>                               |
| 8.2  | Compact creates fresh map with `make`                               | <span class="g">✓</span>       | <span class="g">✓</span>                               |
| 8.3  | Copies surviving entries to new map                                 | <span class="g">✓</span>       | <span class="g">✓</span>                               |
|      | **9. ring-round-robin** — LoadBalancer cycling backends forever     | **<span class="g">3/3</span>** | **<span class="r">2/3</span>**                         |
| 9.1  | Uses `container/ring` for round-robin                               | <span class="g">✓</span>       | <span class="r">✗</span> `atomic.Uint64` counter       |
| 9.2  | No integer overflow risk                                            | <span class="g">✓</span>       | <span class="g">✓</span>                               |
| 9.3  | Correct rotation on each call                                       | <span class="g">✓</span>       | <span class="g">✓</span>                               |
|      | **10. large-struct-ptr** — DocumentStore with 20-field Document     | **<span class="g">3/3</span>** | **<span class="r">1/3</span>**                         |
| 10.1 | Uses pointer map `map[string]*Document`                             | <span class="g">✓</span>       | <span class="r">✗</span> `map[string]Document` value   |
| 10.2 | Get returns stored pointer (no copy)                                | <span class="g">✓</span>       | <span class="r">✗</span> copies from map, takes `&`    |
| 10.3 | Uses `sync.RWMutex` for concurrent reads                            | <span class="g">✓</span>       | <span class="g">✓</span>                               |
|      | **11. small-struct-val** — CoordTracker with 16-byte Coord          | **<span class="g">3/3</span>** | **<span class="r">2/3</span>**                         |
| 11.1 | Uses value map `map[string]Coord` (not pointer)                     | <span class="g">✓</span>       | <span class="g">✓</span>                               |
| 11.2 | Explains < 128-byte threshold for value vs pointer choice           | <span class="g">✓</span>       | <span class="r">✗</span> no threshold analysis         |
| 11.3 | Proportional complexity for struct size                             | <span class="g">✓</span>       | <span class="g">✓</span>                               |
|      | **12. clip-after-delete** — PurgeInactive with large Profile fields | **<span class="g">3/3</span>** | **<span class="r">2/3</span>**                         |
| 12.1 | No dead references in result slice                                  | <span class="g">✓</span>       | <span class="g">✓</span>                               |
| 12.2 | Uses `slices.DeleteFunc` + `slices.Clip`                            | <span class="g">✓</span>       | <span class="r">✗</span> manual loop + `make`          |
| 12.3 | Excess capacity released                                            | <span class="g">✓</span>       | <span class="g">✓</span>                               |

</details>

## `golang-safety` — v1.0.0

|             | With Skill        | Without Skill    | Delta     |
| ----------- | ----------------- | ---------------- | --------- |
| **Overall** | **150/151 (99%)** | **62/151 (41%)** | **+58pp** |

<details>
<summary>Full breakdown (151 assertions across 36 evals)</summary>

**Model:** Claude Sonnet 4.6 | **Runs:** 36 evals × 2 configs = 72 runs | **Grading:** Human-as-judge

| #    | Assertion                                                                         | With                                    | Without                                                     |
| ---- | --------------------------------------------------------------------------------- | --------------------------------------- | ----------------------------------------------------------- |
|      | **1. validator** — `Validate(Config) error` with `*ConfigError` local variable    | **<span class="g">4/4</span>**          | **<span class="r">2/4</span>**                              |
| 1.1  | Returns untyped `nil` on valid config                                             | <span class="g">✓</span>                | <span class="r">✗</span> `return configErr` (typed nil)     |
| 1.2  | No typed nil pointer leaked through `error` interface                             | <span class="g">✓</span>                | <span class="r">✗</span> interface{*ConfigError, nil}       |
| 1.3  | ConfigError.Error() includes Field name                                           | <span class="g">✓</span>                | <span class="g">✓</span>                                    |
| 1.4  | Validates both Host and Port                                                      | <span class="g">✓</span>                | <span class="g">✓</span>                                    |
|      | **2. sliceutil** — `AddDefaults(base, defaults)` append to input slice            | **<span class="g">4/4</span>**          | **<span class="r">2/4</span>**                              |
| 2.1  | Does not modify caller's input slice                                              | <span class="g">✓</span>                | <span class="r">✗</span> `base = append(base, v)`           |
| 2.2  | Uses full-slice expression or clone to prevent aliasing                           | <span class="g">✓</span>                | <span class="r">✗</span> appends directly to `base`         |
| 2.3  | Correctly checks membership                                                       | <span class="g">✓</span>                | <span class="g">✓</span>                                    |
| 2.4  | Does not modify defaults slice                                                    | <span class="g">✓</span>                | <span class="g">✓</span>                                    |
|      | **3. user** — `UserProfile` with Permissions/Metadata getter methods              | **<span class="g">5/5</span>**          | **<span class="r">1/5</span>**                              |
| 3.1  | Collection fields are unexported                                                  | <span class="g">✓</span>                | <span class="r">✗</span> exported `Permissions`, `Metadata` |
| 3.2  | `GetPermissions` returns defensive copy                                           | <span class="g">✓</span>                | <span class="r">✗</span> returns `u.Permissions`            |
| 3.3  | `GetMetadata` returns defensive copy                                              | <span class="g">✓</span>                | <span class="r">✗</span> returns `u.Metadata`               |
| 3.4  | Scalar fields (Name, Email) can stay exported                                     | <span class="g">✓</span>                | <span class="g">✓</span>                                    |
| 3.5  | Handles nil internal fields gracefully                                            | <span class="g">✓</span>                | <span class="r">✗</span> no nil handling                    |
|      | **4. db** — `PingAll(hosts)` with `defer db.Close()` in loop                      | **<span class="g">4/4</span>**          | **<span class="r">2/4</span>**                              |
| 4.1  | No bare `defer` in loop body                                                      | <span class="g">✓</span>                | <span class="r">✗</span> `defer db.Close()` in `for` loop   |
| 4.2  | Extracts loop body to helper function                                             | <span class="g">✓</span>                | <span class="r">✗</span> all in one function                |
| 4.3  | Checks error from sql.Open                                                        | <span class="g">✓</span>                | <span class="g">✓</span>                                    |
| 4.4  | Returns meaningful error when none respond                                        | <span class="g">✓</span>                | <span class="g">✓</span>                                    |
|      | **5. protocol** — `WriteHeader(w, contentLength int64)` as uint32                 | **<span class="g">4/4</span>**          | **<span class="r">0/4</span>**                              |
| 5.1  | Bounds-checks before narrowing `int64` to `uint32`                                | <span class="g">✓</span>                | <span class="r">✗</span> `uint32(contentLength)` directly   |
| 5.2  | Returns error for out-of-range values                                             | <span class="g">✓</span>                | <span class="r">✗</span> silent truncation                  |
| 5.3  | Checks for negative contentLength                                                 | <span class="g">✓</span>                | <span class="r">✗</span> negative wraps to large uint32     |
| 5.4  | Uses math.MaxUint32 for bound check                                               | <span class="g">✓</span>                | <span class="r">✗</span> no check at all                    |
|      | **6. parser** — `ExtractToken(response)` returns first 32 bytes                   | **<span class="g">4/4</span>**          | **<span class="r">0/4</span>**                              |
| 6.1  | Does not return raw subslice of input                                             | <span class="g">✓</span>                | <span class="r">✗</span> `response[:32]`                    |
| 6.2  | Uses clone/copy to release backing array                                          | <span class="g">✓</span>                | <span class="r">✗</span> retains full backing array         |
| 6.3  | Handles short input (len < 32)                                                    | <span class="g">✓</span>                | <span class="r">✗</span> panics on short input              |
| 6.4  | Result independent of input                                                       | <span class="g">✓</span>                | <span class="r">✗</span> aliases input                      |
|      | **7. dispatch** — `ProcessMessage(msg any)` with type assertions                  | **<span class="g">4/4</span>**          | **<span class="r">3/4</span>**                              |
| 7.1  | Uses comma-ok form, not bare assertion                                            | <span class="g">✓</span>                | <span class="g">✓</span>                                    |
| 7.2  | Handles unknown types without panic                                               | <span class="g">✓</span>                | <span class="r">✗</span> returns empty string silently      |
| 7.3  | Uses strings.ToUpper                                                              | <span class="g">✓</span>                | <span class="g">✓</span>                                    |
| 7.4  | Uses strconv/fmt for int conversion                                               | <span class="g">✓</span>                | <span class="g">✓</span>                                    |
|      | **8. worker** — `Task.Run()` calls `OnComplete` callback                          | **<span class="g">4/4</span>**          | **<span class="r">2/4</span>**                              |
| 8.1  | Checks `OnComplete` for nil before calling                                        | <span class="g">✓</span>                | <span class="r">✗</span> `t.OnComplete(result)` directly    |
| 8.2  | Usable without setting callback                                                   | <span class="g">✓</span>                | <span class="r">✗</span> panics on `Task{Name:"x"}.Run()`   |
| 8.3  | Work completes regardless of callback                                             | <span class="g">✓</span>                | <span class="g">✓</span>                                    |
| 8.4  | Uses pointer receiver                                                             | <span class="g">✓</span>                | <span class="g">✓</span>                                    |
|      | **9. router** — `NewRouter(prefix)` + `Handle()` with routes map                  | **<span class="g">4/4</span>**          | **<span class="r">2/4</span>**                              |
| 9.1  | Map initialized before write                                                      | <span class="g">✓</span>                | <span class="r">✗</span> nil map, Handle panics             |
| 9.2  | Usable after NewRouter                                                            | <span class="g">✓</span>                | <span class="r">✗</span> first Handle panics                |
| 9.3  | Stores handler correctly                                                          | <span class="g">✓</span>                | <span class="g">✓</span>                                    |
| 9.4  | Returns pointer                                                                   | <span class="g">✓</span>                | <span class="g">✓</span>                                    |
|      | **10. pricing** — `IsDiscountApplied` comparing float results                     | **<span class="g">4/4</span>**          | **<span class="r">1/4</span>**                              |
| 10.1 | Uses epsilon comparison, not `==`                                                 | <span class="g">✓</span>                | <span class="r">✗</span> `finalPrice == expected`           |
| 10.2 | Reasonable epsilon value                                                          | <span class="g">✓</span>                | <span class="r">✗</span> no epsilon                         |
| 10.3 | Correct discount formula                                                          | <span class="g">✓</span>                | <span class="g">✓</span>                                    |
| 10.4 | Handles edge cases (zero price, 100% discount)                                    | <span class="g">✓</span>                | <span class="r">✗</span> no edge case handling              |
|      | **11. cache** — `Cache.All()` returns all entries                                 | **<span class="g">4/4</span>**          | **<span class="r">2/4</span>**                              |
| 11.1 | `All()` returns defensive copy                                                    | <span class="g">✓</span>                | <span class="r">✗</span> returns `c.data` directly          |
| 11.2 | Constructor initializes map                                                       | <span class="g">✓</span>                | <span class="g">✓</span>                                    |
| 11.3 | Get uses comma-ok idiom                                                           | <span class="g">✓</span>                | <span class="g">✓</span>                                    |
| 11.4 | Callers cannot modify cache via All()                                             | <span class="g">✓</span>                | <span class="r">✗</span> shared reference                   |
|      | **12. pipeline** — `FanIn(channels...)` merges variadic channels                  | **<span class="g">4/4</span>**          | **<span class="r">3/4</span>**                              |
| 12.1 | Handles closed channels                                                           | <span class="g">✓</span>                | <span class="g">✓</span>                                    |
| 12.2 | Output closed once                                                                | <span class="g">✓</span>                | <span class="g">✓</span>                                    |
| 12.3 | No goroutine leaks                                                                | <span class="g">✓</span>                | <span class="g">✓</span>                                    |
| 12.4 | Handles nil input channels                                                        | <span class="g">✓</span>                | <span class="r">✗</span> nil channel blocks goroutine       |
|      | **13. parser** — `TryParse` wrapping `*ParseError` into `error` via named returns | **<span class="g">4/4</span>**          | **<span class="r">2/4</span>**                              |
| 13.1 | No typed nil leaked through named return                                          | <span class="g">✓</span>                | <span class="r">✗</span> `err = parseErr` unconditional     |
| 13.2 | Named err only set when non-nil                                                   | <span class="g">✓</span>                | <span class="r">✗</span> always assigned                    |
| 13.3 | ParseError.Error() includes Line                                                  | <span class="g">✓</span>                | <span class="g">✓</span>                                    |
| 13.4 | Parse returns nil *ParseError on success                                          | <span class="g">✓</span>                | <span class="g">✓</span>                                    |
|      | **14. notify** — `NotifyAll(n *Notifier, msgs)` with nil Notifier                 | **<span class="g">4/4</span>**          | **<span class="r">2/4</span>**                              |
| 14.1 | Handles nil *Notifier without panic                                               | <span class="g">✓</span>                | <span class="r">✗</span> dereferences `n.webhook`           |
| 14.2 | Returns meaningful error when nil                                                 | <span class="g">✓</span>                | <span class="r">✗</span> panics                             |
| 14.3 | Iterates messages, returns first error                                            | <span class="g">✓</span>                | <span class="g">✓</span>                                    |
| 14.4 | Send uses webhook field                                                           | <span class="g">✓</span>                | <span class="g">✓</span>                                    |
|      | **15. inventory** — `Inventory.Items()` returns items list                        | **<span class="g">4/4</span>**          | **<span class="r">2/4</span>**                              |
| 15.1 | Items() returns defensive copy                                                    | <span class="g">✓</span>                | <span class="r">✗</span> returns `inv.items`                |
| 15.2 | Add uses append correctly                                                         | <span class="g">✓</span>                | <span class="g">✓</span>                                    |
| 15.3 | Modifying returned slice doesn't affect Inventory                                 | <span class="g">✓</span>                | <span class="r">✗</span> shared backing array               |
| 15.4 | Field is unexported                                                               | <span class="g">✓</span>                | <span class="g">✓</span>                                    |
|      | **16. httputil** — `HeaderString(map)` formatting headers                         | **<span class="g">4/4</span>**          | **<span class="r">2/4</span>**                              |
| 16.1 | Sorts keys for deterministic output                                               | <span class="g">✓</span>                | <span class="r">✗</span> ranges over map directly           |
| 16.2 | Uses sort or slices.Sorted                                                        | <span class="g">✓</span>                | <span class="r">✗</span> no sorting                         |
| 16.3 | Uses strings.Builder                                                              | <span class="g">✓</span>                | <span class="g">✓</span>                                    |
| 16.4 | Each line ends with \r\n                                                          | <span class="g">✓</span>                | <span class="g">✓</span>                                    |
|      | **17. stats** — `SuccessRate(success, total)` as percentage                       | **<span class="g">4/4</span>**          | **<span class="g">4/4</span>**                              |
| 17.1 | Guards zero total                                                                 | <span class="g">✓</span>                | <span class="g">✓</span>                                    |
| 17.2 | Returns 0.0 not NaN                                                               | <span class="g">✓</span>                | <span class="g">✓</span>                                    |
| 17.3 | Converts to float64 before division                                               | <span class="g">✓</span>                | <span class="g">✓</span>                                    |
| 17.4 | Result in 0-100 range                                                             | <span class="g">✓</span>                | <span class="g">✓</span>                                    |
|      | **18. fetcher** — `FetchAll(urls)` with `defer resp.Body.Close()` in loop         | **<span class="g">4/4</span>**          | **<span class="r">1/4</span>**                              |
| 18.1 | No bare `defer` in loop body                                                      | <span class="g">✓</span>                | <span class="r">✗</span> `defer resp.Body.Close()` in loop  |
| 18.2 | Extracts to helper function                                                       | <span class="g">✓</span>                | <span class="r">✗</span> all in one function                |
| 18.3 | Checks resp error                                                                 | <span class="g">✓</span>                | <span class="g">✓</span>                                    |
| 18.4 | Preallocates results                                                              | <span class="g">✓</span>                | <span class="r">✗</span> no preallocation                   |
|      | **19. dashboard** — `New(name)` constructor with `widgets map` field              | **<span class="g">4/4</span>**          | **<span class="g">4/4</span>**                              |
| 19.1 | Constructor initializes widgets map                                               | <span class="g">✓</span>                | <span class="g">✓</span>                                    |
| 19.2 | AddWidget works on first call                                                     | <span class="g">✓</span>                | <span class="g">✓</span>                                    |
| 19.3 | Layout append safe (nil slice ok)                                                 | <span class="g">✓</span>                | <span class="g">✓</span>                                    |
| 19.4 | Usable after New()                                                                | <span class="g">✓</span>                | <span class="g">✓</span>                                    |
|      | **20. protocol** — `PackAge(age int) byte` for binary protocol                    | **<span class="g">4/4</span>**          | **<span class="r">0/4</span>**                              |
| 20.1 | Validates 0-255 range                                                             | <span class="g">✓</span>                | <span class="r">✗</span> `byte(age)` directly               |
| 20.2 | Returns error for out-of-range                                                    | <span class="g">✓</span>                | <span class="r">✗</span> no validation                      |
| 20.3 | Changes signature to (byte, error)                                                | <span class="g">✓</span>                | <span class="r">✗</span> returns just byte                  |
| 20.4 | Handles negative ages                                                             | <span class="g">✓</span>                | <span class="r">✗</span> wraps to 255                       |
|      | **21. search** — `ExtractBefore(buf, marker)` returns prefix                      | **<span class="g">4/4</span>**          | **<span class="r">1/4</span>**                              |
| 21.1 | Returns copy not subslice                                                         | <span class="g">✓</span>                | <span class="r">✗</span> `buf[:i]`                          |
| 21.2 | Uses Clone/copy                                                                   | <span class="g">✓</span>                | <span class="r">✗</span> no copy                            |
| 21.3 | Both paths return copies                                                          | <span class="g">✓</span>                | <span class="r">✗</span> returns raw `buf`                  |
| 21.4 | Uses bytes.IndexByte                                                              | <span class="g">✓</span>                | <span class="g">✓</span>                                    |
|      | **22. http** — `Client.Fetch` with `OnRequest`/`OnResponse` callbacks             | **<span class="g">4/4</span>**          | **<span class="r">0/4</span>**                              |
| 22.1 | Checks OnRequest for nil                                                          | <span class="g">✓</span>                | <span class="r">✗</span> calls directly                     |
| 22.2 | Checks OnResponse for nil                                                         | <span class="g">✓</span>                | <span class="r">✗</span> calls directly                     |
| 22.3 | Usable with zero-value callbacks                                                  | <span class="g">✓</span>                | <span class="r">✗</span> panics                             |
| 22.4 | Both hooks optional                                                               | <span class="g">✓</span>                | <span class="r">✗</span> panics if unset                    |
|      | **23. billing** — `ChargesMatch(computed, invoiced)` float comparison             | **<span class="g">4/4</span>**          | **<span class="r">1/4</span>**                              |
| 23.1 | Uses epsilon not ==                                                               | <span class="g">✓</span>                | <span class="r">✗</span> `computed == invoiced`             |
| 23.2 | Reasonable epsilon                                                                | <span class="g">✓</span>                | <span class="r">✗</span> no epsilon                         |
| 23.3 | Handles edge cases                                                                | <span class="g">✓</span>                | <span class="r">✗</span> no edge handling                   |
| 23.4 | No reflect.DeepEqual                                                              | <span class="g">✓</span>                | <span class="g">✓</span>                                    |
|      | **24. filter** — `RemoveEmpty(items)` in-place slice deletion                     | **<span class="g">4/4</span>**          | **<span class="g">4/4</span>**                              |
| 24.1 | Safe deletion pattern                                                             | <span class="g">✓</span>                | <span class="g">✓</span>                                    |
| 24.2 | No element skipping                                                               | <span class="g">✓</span>                | <span class="g">✓</span>                                    |
| 24.3 | Preserves capacity semantics                                                      | <span class="g">✓</span>                | <span class="g">✓</span>                                    |
| 24.4 | Handles edge cases                                                                | <span class="g">✓</span>                | <span class="g">✓</span>                                    |
|      | **25. middleware** — `Handle(handler func() *AppError) error` one-liner           | **<span class="g">4/4</span>**          | **<span class="r">1/4</span>**                              |
| 25.1 | Avoids typed nil leak from handler()                                              | <span class="g">✓</span>                | <span class="r">✗</span> `return handler()`                 |
| 25.2 | Uses conditional nil check                                                        | <span class="g">✓</span>                | <span class="r">✗</span> direct return                      |
| 25.3 | Does not assign to error var directly                                             | <span class="g">✓</span>                | <span class="r">✗</span> implicit assignment                |
| 25.4 | AppError.Error() includes Code and Msg                                            | <span class="g">✓</span>                | <span class="g">✓</span>                                    |
|      | **26. team** — `NewTeam(name, members)` + `Members()` getter                      | **<span class="g">5/5</span>**          | **<span class="r">1/5</span>**                              |
| 26.1 | Constructor copies input (defensive ingress)                                      | <span class="g">✓</span>                | <span class="r">✗</span> `members: members`                 |
| 26.2 | Members() returns copy (egress)                                                   | <span class="g">✓</span>                | <span class="r">✗</span> returns `t.members`                |
| 26.3 | Uses slices.Clone or copy                                                         | <span class="g">✓</span>                | <span class="r">✗</span> no copies at all                   |
| 26.4 | Fields unexported                                                                 | <span class="g">✓</span>                | <span class="g">✓</span>                                    |
| 26.5 | Handles nil input                                                                 | <span class="g">✓</span>                | <span class="r">✗</span> no nil handling                    |
|      | **27. fileutil** — `WriteAll(paths, data)` with defer in create loop              | **<span class="g">4/5</span>**          | **<span class="r">1/5</span>**                              |
| 27.1 | No bare defer in loop                                                             | <span class="g">✓</span>                | <span class="r">✗</span> `defer f.Close()` in loop          |
| 27.2 | Extracts to helper                                                                | <span class="g">✓</span>                | <span class="r">✗</span> all in one function                |
| 27.3 | Helper handles Create+Close+Write                                                 | <span class="g">✓</span>                | <span class="r">✗</span> no helper                          |
| 27.4 | Errors from Create and Write checked                                              | <span class="g">✓</span>                | <span class="g">✓</span>                                    |
| 27.5 | Does not ignore Close error                                                       | <span class="r">✗</span> defer discards | <span class="r">✗</span> defer discards                     |
|      | **28. config** — `Merge(a, b Endpoint)` merging Labels maps                       | **<span class="g">5/5</span>**          | **<span class="r">2/5</span>**                              |
| 28.1 | Result Labels initialized before write                                            | <span class="g">✓</span>                | <span class="r">✗</span> writes to copied nil map           |
| 28.2 | Correct merge with b precedence                                                   | <span class="g">✓</span>                | <span class="g">✓</span>                                    |
| 28.3 | Does not modify input maps                                                        | <span class="g">✓</span>                | <span class="r">✗</span> aliases a's map                    |
| 28.4 | Handles nil Labels                                                                | <span class="g">✓</span>                | <span class="r">✗</span> panics on nil write                |
| 28.5 | Correct zero-value checks                                                         | <span class="g">✓</span>                | <span class="g">✓</span>                                    |
|      | **29. text** — `FirstWord(line)` returns first word via IndexByte                 | **<span class="g">4/4</span>**          | **<span class="r">1/4</span>**                              |
| 29.1 | Returns copy not subslice                                                         | <span class="g">✓</span>                | <span class="r">✗</span> `line[:i]`                         |
| 29.2 | Uses Clone/copy                                                                   | <span class="g">✓</span>                | <span class="r">✗</span> no copy                            |
| 29.3 | Both paths return copies                                                          | <span class="g">✓</span>                | <span class="r">✗</span> returns raw `line`                 |
| 29.4 | Handles edge cases                                                                | <span class="g">✓</span>                | <span class="g">✓</span>                                    |
|      | **30. net** — `EncodeAddr(host, port int)` with uint16 port                       | **<span class="g">5/5</span>**          | **<span class="r">2/5</span>**                              |
| 30.1 | Validates port 0-65535                                                            | <span class="g">✓</span>                | <span class="r">✗</span> `uint16(port)` directly            |
| 30.2 | Returns error for negative/overflow                                               | <span class="g">✓</span>                | <span class="r">✗</span> silent truncation                  |
| 30.3 | Uses math.MaxUint16                                                               | <span class="g">✓</span>                | <span class="r">✗</span> no check                           |
| 30.4 | Correct buffer allocation                                                         | <span class="g">✓</span>                | <span class="g">✓</span>                                    |
| 30.5 | Uses PutUint16 as specified                                                       | <span class="g">✓</span>                | <span class="g">✓</span>                                    |
|      | **31. testing** — `AssertPrice(t, got, want float64)` test helper                 | **<span class="g">5/5</span>**          | **<span class="r">3/5</span>**                              |
| 31.1 | Uses epsilon not !=                                                               | <span class="g">✓</span>                | <span class="r">✗</span> `got != want`                      |
| 31.2 | Reasonable epsilon                                                                | <span class="g">✓</span>                | <span class="r">✗</span> no epsilon                         |
| 31.3 | Calls t.Helper()                                                                  | <span class="g">✓</span>                | <span class="g">✓</span>                                    |
| 31.4 | Shows got and want in message                                                     | <span class="g">✓</span>                | <span class="g">✓</span>                                    |
| 31.5 | No reflect.DeepEqual                                                              | <span class="g">✓</span>                | <span class="g">✓</span>                                    |
|      | **32. server** — `Server.Start/Stop` with `OnStart`/`OnStop` callbacks            | **<span class="g">4/4</span>**          | **<span class="r">0/4</span>**                              |
| 32.1 | Checks OnStart for nil                                                            | <span class="g">✓</span>                | <span class="r">✗</span> calls directly                     |
| 32.2 | Checks OnStop for nil                                                             | <span class="g">✓</span>                | <span class="r">✗</span> calls directly                     |
| 32.3 | Methods work without callbacks                                                    | <span class="g">✓</span>                | <span class="r">✗</span> panics                             |
| 32.4 | Usable with zero-value callbacks                                                  | <span class="g">✓</span>                | <span class="r">✗</span> panics                             |
|      | **33. pool** — `Utilization(active, capacity)` as percentage                      | **<span class="g">4/4</span>**          | **<span class="r">2/4</span>**                              |
| 33.1 | Guards zero capacity                                                              | <span class="g">✓</span>                | <span class="r">✗</span> `active*100/capacity` no guard     |
| 33.2 | Returns sensible default for zero                                                 | <span class="g">✓</span>                | <span class="r">✗</span> panics                             |
| 33.3 | Uses integer arithmetic                                                           | <span class="g">✓</span>                | <span class="g">✓</span>                                    |
| 33.4 | Correct multiplication order                                                      | <span class="g">✓</span>                | <span class="g">✓</span>                                    |
|      | **34. store** — `Store.GetAll(key)` returns `[]string` values                     | **<span class="g">5/5</span>**          | **<span class="r">3/5</span>**                              |
| 34.1 | GetAll returns defensive copy                                                     | <span class="g">✓</span>                | <span class="r">✗</span> returns `s.data[key]`              |
| 34.2 | Uses Clone/copy                                                                   | <span class="g">✓</span>                | <span class="r">✗</span> no copy                            |
| 34.3 | Constructor inits map                                                             | <span class="g">✓</span>                | <span class="g">✓</span>                                    |
| 34.4 | Add uses append correctly                                                         | <span class="g">✓</span>                | <span class="g">✓</span>                                    |
| 34.5 | GetAll returns nil for missing key                                                | <span class="g">✓</span>                | <span class="g">✓</span>                                    |
|      | **35. scanner** — `ScanAll(readers)` with defer close in loop                     | **<span class="g">4/4</span>**          | **<span class="r">1/4</span>**                              |
| 35.1 | No bare defer in loop                                                             | <span class="g">✓</span>                | <span class="r">✗</span> `defer c.Close()` in loop          |
| 35.2 | Extracts to helper                                                                | <span class="g">✓</span>                | <span class="r">✗</span> all in one function                |
| 35.3 | Uses type assertion for Closer                                                    | <span class="g">✓</span>                | <span class="g">✓</span>                                    |
| 35.4 | Preallocates results                                                              | <span class="g">✓</span>                | <span class="r">✗</span> no preallocation                   |
|      | **36. metric** — `PercentChange(before, after)` percentage formula                | **<span class="g">4/4</span>**          | **<span class="r">2/4</span>**                              |
| 36.1 | Guards zero before                                                                | <span class="g">✓</span>                | <span class="r">✗</span> no guard, Inf/NaN                  |
| 36.2 | Converts to float64 before division                                               | <span class="g">✓</span>                | <span class="g">✓</span>                                    |
| 36.3 | Returns sensible default for zero                                                 | <span class="g">✓</span>                | <span class="r">✗</span> returns Inf                        |
| 36.4 | Formula mathematically correct                                                    | <span class="g">✓</span>                | <span class="g">✓</span>                                    |

</details>

## `golang-error-handling` — v1.0.0

|             | With Skill      | Without Skill   | Delta     |
| ----------- | --------------- | --------------- | --------- |
| **Overall** | **59/60 (98%)** | **43/60 (72%)** | **+27pp** |

<details>
<summary>Full breakdown (60 assertions)</summary>

**Model:** Claude Sonnet 4.6 | **Runs:** 12 adversarial evals × 2 configs = 24 subagents | **Grading:** Human-as-judge

| #    | Assertion                                                                 | With                                           | Without                                                      |
| ---- | ------------------------------------------------------------------------- | ---------------------------------------------- | ------------------------------------------------------------ |
|      | **1. middleware-log-chain** — "log at each step" tempts log+return        | **<span class="g">5/5</span>**                 | **<span class="r">3/5</span>**                               |
| 1.1  | Uses `slog` (not `log.Printf`)                                            | <span class="g">✓</span>                       | <span class="g">✓</span>                                     |
| 1.2  | Low-cardinality error messages (no IPs/limits interpolated)               | <span class="g">✓</span>                       | <span class="r">✗</span> `"ip %q exceeded %d requests"`      |
| 1.3  | Structured error context (`oops.With`, not in error string)               | <span class="g">✓</span>                       | <span class="r">✗</span> `fmt.Errorf` with IP interpolation  |
| 1.4  | Structured `slog` key-value log entries                                   | <span class="g">✓</span>                       | <span class="g">✓</span>                                     |
| 1.5  | Error strings lowercase                                                   | <span class="g">✓</span>                       | <span class="g">✓</span>                                     |
|      | **2. order-processor** — "indicate which order" tempts ID interpolation   | **<span class="g">5/5</span>**                 | **<span class="r">3/5</span>**                               |
| 2.1  | Error messages low-cardinality (no IDs in error strings)                  | <span class="g">✓</span>                       | <span class="r">✗</span> `"order %s: validation failed"`     |
| 2.2  | Variable data as structured attributes (`oops`/`slog`)                    | <span class="g">✓</span>                       | <span class="r">✗</span> data in `Error()` string            |
| 2.3  | Uses `errors.Join` to collect all order errors                            | <span class="g">✓</span>                       | <span class="g">✓</span>                                     |
| 2.4  | Error strings lowercase                                                   | <span class="g">✓</span>                       | <span class="g">✓</span>                                     |
| 2.5  | Validates ALL fields per order (no short-circuit)                         | <span class="g">✓</span>                       | <span class="g">✓</span>                                     |
|      | **3. batch-csv-importer** — "detailed report" tempts row interpolation    | **<span class="g">5/5</span>**                 | **<span class="r">2/5</span>**                               |
| 3.1  | Error messages static (no row numbers in error string)                    | <span class="g">✓</span>                       | <span class="r">✗</span> `"row %d: column %q"` in `Error()`  |
| 3.2  | Row/column data as structured attributes (`oops`/`slog`)                  | <span class="g">✓</span>                       | <span class="r">✗</span> data in `RowError.Error()` string   |
| 3.3  | Collects all row errors (doesn't stop on first)                           | <span class="g">✓</span>                       | <span class="g">✓</span>                                     |
| 3.4  | Error strings lowercase                                                   | <span class="g">✓</span>                       | <span class="g">✓</span>                                     |
| 3.5  | Uses `errors.Join` for combining errors                                   | <span class="g">✓</span>                       | <span class="r">✗</span> custom `ImportError{Failures}`      |
|      | **4. wrapped-error-compare** — pre-existing `fmt.Errorf` + `==` sentinels | **<span class="g">5/5</span>**                 | **<span class="r">4/5</span>**                               |
| 4.1  | Sentinel errors use `errors.New` (not `fmt.Errorf`)                       | <span class="g">✓</span>                       | <span class="r">✗</span> kept `fmt.Errorf`                   |
| 4.2  | Sentinel strings lowercase, no punctuation                                | <span class="g">✓</span>                       | <span class="g">✓</span>                                     |
| 4.3  | `TimeoutError.Error()` lowercase, no punctuation                          | <span class="g">✓</span>                       | <span class="g">✓</span>                                     |
| 4.4  | `errors.Is` for sentinel matching                                         | <span class="g">✓</span>                       | <span class="g">✓</span>                                     |
| 4.5  | `errors.As` for type extraction                                           | <span class="g">✓</span>                       | <span class="g">✓</span>                                     |
|      | **5. multi-service-fetch** — 3 service calls tempt bare `return err`      | **<span class="g">5/5</span>**                 | **<span class="r">4/5</span>**                               |
| 5.1  | Errors wrapped with service context                                       | <span class="g">✓</span>                       | <span class="g">✓</span>                                     |
| 5.2  | Low-cardinality error messages                                            | <span class="g">✓</span>                       | <span class="g">✓</span>                                     |
| 5.3  | Uses structured attributes (`oops`/`slog`)                                | <span class="g">✓</span>                       | <span class="r">✗</span> plain `fmt.Errorf` only             |
| 5.4  | Error strings lowercase                                                   | <span class="g">✓</span>                       | <span class="g">✓</span>                                     |
| 5.5  | Each service identifiable by context prefix                               | <span class="g">✓</span>                       | <span class="g">✓</span>                                     |
|      | **6. config-validation** — many fields tempts early return + caps         | **<span class="g">5/5</span>**                 | **<span class="r">3/5</span>**                               |
| 6.1  | Uses `errors.Join` for combining validation errors                        | <span class="g">✓</span>                       | <span class="r">✗</span> `[]string` + `strings.Join`         |
| 6.2  | Error strings lowercase                                                   | <span class="g">✓</span>                       | <span class="r">✗</span> `"Host is required"` capitalized    |
| 6.3  | Validates ALL fields                                                      | <span class="g">✓</span>                       | <span class="g">✓</span>                                     |
| 6.4  | Conditional TLS validation                                                | <span class="g">✓</span>                       | <span class="g">✓</span>                                     |
| 6.5  | No `panic` for validation                                                 | <span class="g">✓</span>                       | <span class="g">✓</span>                                     |
|      | **7. modernize-logging** — "keep the logging" tempts log+return           | **<span class="r">4/5</span>**                 | **<span class="r">4/5</span>**                               |
| 7.1  | Does not log AND return same error (single handling rule)                 | <span class="r">✗</span> `slog.Error` + return | <span class="r">✗</span> `ErrorContext` + return             |
| 7.2  | Uses `slog` (not `log.Printf`)                                            | <span class="g">✓</span>                       | <span class="g">✓</span>                                     |
| 7.3  | Structured key-value attributes                                           | <span class="g">✓</span>                       | <span class="g">✓</span>                                     |
| 7.4  | Appropriate log levels (Info/Warn/Error)                                  | <span class="g">✓</span>                       | <span class="g">✓</span>                                     |
| 7.5  | Low-cardinality log messages                                              | <span class="g">✓</span>                       | <span class="g">✓</span>                                     |
|      | **8. graceful-shutdown** — 5 resources tempts bare append                 | **<span class="g">5/5</span>**                 | **<span class="r">4/5</span>**                               |
| 8.1  | Uses `errors.Join`                                                        | <span class="g">✓</span>                       | <span class="g">✓</span>                                     |
| 8.2  | Each error wrapped with resource context                                  | <span class="g">✓</span>                       | <span class="r">✗</span> bare `append(errs, err)`            |
| 8.3  | Error strings lowercase                                                   | <span class="g">✓</span>                       | <span class="g">✓</span>                                     |
| 8.4  | Attempts ALL resources even if earlier fail                               | <span class="g">✓</span>                       | <span class="g">✓</span>                                     |
| 8.5  | Correct shutdown order                                                    | <span class="g">✓</span>                       | <span class="g">✓</span>                                     |
|      | **9. todo-CRUD-repo** — full CRUD with IDs tempts interpolation           | **<span class="g">5/5</span>**                 | **<span class="r">4/5</span>**                               |
| 9.1  | Low-cardinality error messages (no ID interpolation)                      | <span class="g">✓</span>                       | <span class="r">✗</span> `"get todo %q: %w"` with id         |
| 9.2  | Errors wrapped with method context                                        | <span class="g">✓</span>                       | <span class="g">✓</span>                                     |
| 9.3  | Uses `errors.Is` for `sql.ErrNoRows`                                      | <span class="g">✓</span>                       | <span class="g">✓</span>                                     |
| 9.4  | Sentinel as package-level var                                             | <span class="g">✓</span>                       | <span class="g">✓</span>                                     |
| 9.5  | Error strings lowercase                                                   | <span class="g">✓</span>                       | <span class="g">✓</span>                                     |
|      | **10. retry-handler** — "log each attempt" tempts log+return in loop      | **<span class="g">5/5</span>**                 | **<span class="r">4/5</span>**                               |
| 10.1 | Does not log AND return final error (single handling rule)                | <span class="g">✓</span>                       | <span class="r">✗</span> `slog.ErrorContext` + `return err`  |
| 10.2 | Structured `slog` attributes                                              | <span class="g">✓</span>                       | <span class="g">✓</span>                                     |
| 10.3 | Uses `slog` (not `log.Printf`)                                            | <span class="g">✓</span>                       | <span class="g">✓</span>                                     |
| 10.4 | Low-cardinality log messages                                              | <span class="g">✓</span>                       | <span class="g">✓</span>                                     |
| 10.5 | Wraps final error with context                                            | <span class="g">✓</span>                       | <span class="g">✓</span>                                     |
|      | **11. event-processor** — "include event details" tempts interpolation    | **<span class="g">5/5</span>**                 | **<span class="r">3/5</span>**                               |
| 11.1 | Error messages static (event type/ID not in error string)                 | <span class="g">✓</span>                       | <span class="r">✗</span> `"processing event %q (type=%s)"`   |
| 11.2 | Event details as structured attributes (`oops`/`slog`)                    | <span class="g">✓</span>                       | <span class="r">✗</span> data in `EventError.Error()` string |
| 11.3 | Uses `errors.Join` to collect all event errors                            | <span class="g">✓</span>                       | <span class="g">✓</span>                                     |
| 11.4 | Error strings lowercase                                                   | <span class="g">✓</span>                       | <span class="g">✓</span>                                     |
| 11.5 | No logging inside processor (returns to caller)                           | <span class="g">✓</span>                       | <span class="g">✓</span>                                     |
|      | **12. api-gateway** — backend errors tempt `%w` exposure                  | **<span class="g">5/5</span>**                 | **<span class="g">5/5</span>**                               |
| 12.1 | Uses `%v` (not `%w`) at boundary for backend details                      | <span class="g">✓</span>                       | <span class="g">✓</span>                                     |
| 12.2 | Translates backend errors to domain sentinels                             | <span class="g">✓</span>                       | <span class="g">✓</span>                                     |
| 12.3 | Sentinel strings lowercase                                                | <span class="g">✓</span>                       | <span class="g">✓</span>                                     |
| 12.4 | `errors.As` used internally to inspect backend types                      | <span class="g">✓</span>                       | <span class="g">✓</span>                                     |
| 12.5 | Backend types not accessible via `errors.As` from callers                 | <span class="g">✓</span>                       | <span class="g">✓</span>                                     |

</details>

## `golang-testing` — v1.0.0

|             | With Skill      | Without Skill   | Delta     |
| ----------- | --------------- | --------------- | --------- |
| **Overall** | **60/65 (92%)** | **39/65 (60%)** | **+32pp** |

<details>
<summary>Full breakdown (54 assertions)</summary>

**Model:** Claude Sonnet 4.6 | **Runs:** 12 evals × 2 configs = 24 subagents | **Grading:** Human-as-judge

| #    | Assertion                                                              | With                           | Without                                                    |
| ---- | ---------------------------------------------------------------------- | ------------------------------ | ---------------------------------------------------------- |
|      | **1. workerpool** — goleak detection for goroutine-spawning packages   | **<span class="g">4/4</span>** | **<span class="r">0/4</span>**                             |
| 1.1  | Uses goleak (VerifyTestMain or VerifyNone)                             | <span class="g">✓</span>       | <span class="r">✗</span> no goleak at all                  |
| 1.2  | Has TestMain function for package-level leak check                     | <span class="g">✓</span>       | <span class="r">✗</span> no TestMain                       |
| 1.3  | Tests verify Stop() cleans up goroutines                               | <span class="g">✓</span>       | <span class="r">✗</span> only checks task completion       |
| 1.4  | Imports go.uber.org/goleak                                             | <span class="g">✓</span>       | <span class="r">✗</span> not imported                      |
|      | **2. userrepo** — integration test separation via build tags           | **<span class="g">4/4</span>** | **<span class="g">4/4</span>**                             |
| 2.1  | Uses `//go:build integration` build tag                                | <span class="g">✓</span>       | <span class="g">✓</span>                                   |
| 2.2  | Build tag is primary mechanism (not testing.Short)                     | <span class="g">✓</span>       | <span class="g">✓</span>                                   |
| 2.3  | Tests use real database connection                                     | <span class="g">✓</span>       | <span class="g">✓</span>                                   |
| 2.4  | Documents `go test -tags=integration` command                          | <span class="g">✓</span>       | <span class="g">✓</span>                                   |
|      | **3. slugify** — t.Parallel() in table-driven tests for pure functions | **<span class="g">5/5</span>** | **<span class="r">3/5</span>**                             |
| 3.1  | Subtests call t.Parallel()                                             | <span class="g">✓</span>       | <span class="r">✗</span> sequential subtests               |
| 3.2  | Top-level test calls t.Parallel()                                      | <span class="g">✓</span>       | <span class="r">✗</span> no t.Parallel()                   |
| 3.3  | Each case has descriptive name in t.Run                                | <span class="g">✓</span>       | <span class="g">✓</span>                                   |
| 3.4  | At least 6 test cases                                                  | <span class="g">✓</span>       | <span class="g">✓</span>                                   |
| 3.5  | No shared mutable state between subtests                               | <span class="g">✓</span>       | <span class="g">✓</span>                                   |
|      | **4. ratelimiter** — clockwork/synctest for time-dependent tests       | **<span class="r">1/4</span>** | **<span class="r">1/4</span>**                             |
| 4.1  | Uses clockwork.FakeClock or synctest                                   | <span class="r">✗</span>       | <span class="r">✗</span>                                   |
| 4.2  | No time.Sleep in test code                                             | <span class="r">✗</span>       | <span class="r">✗</span>                                   |
| 4.3  | Advances fake time past window                                         | <span class="r">✗</span>       | <span class="r">✗</span>                                   |
| 4.4  | Tests both allow and deny scenarios                                    | <span class="g">✓</span>       | <span class="g">✓</span>                                   |
|      | **5. notification** — mock interfaces, not concrete types              | **<span class="g">5/5</span>** | **<span class="r">1/5</span>**                             |
| 5.1  | Defines interfaces for dependencies                                    | <span class="g">✓</span>       | <span class="r">✗</span> uses concrete SMTPClient directly |
| 5.2  | Creates mock implementations of interfaces                             | <span class="g">✓</span>       | <span class="r">✗</span> function-field injection          |
| 5.3  | Does NOT embed concrete structs in mocks                               | <span class="g">✓</span>       | <span class="r">✗</span> returns *SMTPClient directly      |
| 5.4  | NotificationService accepts interfaces via DI                          | <span class="g">✓</span>       | <span class="r">✗</span> accepts *SMTPClient, *AuditLogger |
| 5.5  | Tests happy path and error scenarios                                   | <span class="g">✓</span>       | <span class="g">✓</span>                                   |
|      | **6. usercache** — test behavior, not implementation details           | **<span class="g">4/4</span>** | **<span class="r">1/4</span>**                             |
| 6.1  | Tests observable behavior via public API only                          | <span class="g">✓</span>       | <span class="r">✗</span> accesses cache.data directly      |
| 6.2  | Does NOT access internal data map field                                | <span class="g">✓</span>       | <span class="r">✗</span> cache.data["1"], len(cache.data)  |
| 6.3  | Uses external test package (black-box)                                 | <span class="g">✓</span>       | <span class="r">✗</span> struct defined in test file       |
| 6.4  | Covers hit, miss, overwrite, Len()                                     | <span class="g">✓</span>       | <span class="g">✓</span>                                   |
|      | **7. mathutil** — black-box package_test for exported API              | **<span class="g">3/4</span>** | **<span class="g">3/4</span>**                             |
| 7.1  | Uses `package mathutil_test`                                           | <span class="g">✓</span>       | <span class="g">✓</span>                                   |
| 7.2  | Explicit import of mathutil package                                    | <span class="r">✗</span>       | <span class="r">✗</span>                                   |
| 7.3  | Only tests exported functions                                          | <span class="g">✓</span>       | <span class="g">✓</span>                                   |
| 7.4  | Table-driven with named cases for both functions                       | <span class="g">✓</span>       | <span class="g">✓</span>                                   |
|      | **8. money** — Example functions as executable documentation           | **<span class="r">1/4</span>** | **<span class="r">1/4</span>**                             |
| 8.1  | Includes at least one Example function                                 | <span class="r">✗</span>       | <span class="r">✗</span>                                   |
| 8.2  | Example has `// Output:` comment                                       | <span class="r">✗</span>       | <span class="r">✗</span>                                   |
| 8.3  | Example demonstrates realistic usage                                   | <span class="r">✗</span>       | <span class="r">✗</span>                                   |
| 8.4  | Also includes regular table-driven tests                               | <span class="g">✓</span>       | <span class="g">✓</span>                                   |
|      | **9. sanitize** — fuzzing for security-critical parsers                | **<span class="g">5/5</span>** | **<span class="r">2/5</span>**                             |
| 9.1  | Includes fuzz test (FuzzSanitizeHTML)                                  | <span class="g">✓</span>       | <span class="r">✗</span> no fuzz test                      |
| 9.2  | Fuzz uses f.Add() seed corpus                                          | <span class="g">✓</span>       | <span class="r">✗</span> no fuzzing                        |
| 9.3  | Property-based assertions in fuzz                                      | <span class="g">✓</span>       | <span class="r">✗</span> no fuzzing                        |
| 9.4  | Also includes table-driven tests                                       | <span class="g">✓</span>       | <span class="g">✓</span>                                   |
| 9.5  | Covers nested/unclosed/script tags                                     | <span class="g">✓</span>       | <span class="g">✓</span>                                   |
|      | **10. jsonhelper** — t.Helper() in custom test helpers                 | **<span class="g">4/4</span>** | **<span class="g">4/4</span>**                             |
| 10.1 | assertJSONEqual calls t.Helper()                                       | <span class="g">✓</span>       | <span class="g">✓</span>                                   |
| 10.2 | Order-independent JSON comparison                                      | <span class="g">✓</span>       | <span class="g">✓</span>                                   |
| 10.3 | Meaningful error messages (expected vs actual)                         | <span class="g">✓</span>       | <span class="g">✓</span>                                   |
| 10.4 | Helper used in MarshalUser tests                                       | <span class="g">✓</span>       | <span class="g">✓</span>                                   |
|      | **11. createorder** — httptest.NewRecorder for handler tests           | **<span class="g">5/5</span>** | **<span class="r">4/5</span>**                             |
| 11.1 | Uses httptest.NewRecorder                                              | <span class="g">✓</span>       | <span class="g">✓</span>                                   |
| 11.2 | Table-driven with named cases                                          | <span class="g">✓</span>       | <span class="r">✗</span> separate individual functions     |
| 11.3 | Tests 3+ status codes (201, 400, 422)                                  | <span class="g">✓</span>       | <span class="g">✓</span>                                   |
| 11.4 | Verifies response body content                                         | <span class="g">✓</span>       | <span class="g">✓</span>                                   |
| 11.5 | Sets Content-Type header on requests                                   | <span class="g">✓</span>       | <span class="g">✓</span>                                   |
|      | **12. orderrepo** — testify/suite for integration test organization    | **<span class="g">6/6</span>** | **<span class="r">3/6</span>**                             |
| 12.1 | Uses testify/suite.Suite embedding                                     | <span class="g">✓</span>       | <span class="r">✗</span> plain TestMain + functions        |
| 12.2 | Has SetupSuite for one-time DB setup                                   | <span class="g">✓</span>       | <span class="r">✗</span> uses TestMain instead             |
| 12.3 | Has SetupTest/TearDownTest for per-test cleanup                        | <span class="g">✓</span>       | <span class="g">✓</span>                                   |
| 12.4 | Has TearDownSuite for graceful shutdown                                | <span class="g">✓</span>       | <span class="g">✓</span>                                   |
| 12.5 | Uses `//go:build integration` build tag                                | <span class="g">✓</span>       | <span class="g">✓</span>                                   |
| 12.6 | Has suite.Run runner function                                          | <span class="g">✓</span>       | <span class="r">✗</span> no suite.Run                      |

</details>

## `golang-modernize` — v1.0.0

|             | With Skill      | Without Skill   | Delta     |
| ----------- | --------------- | --------------- | --------- |
| **Overall** | **72/76 (95%)** | **26/76 (34%)** | **+61pp** |

<details>
<summary>Full breakdown (74 assertions)</summary>

**Model:** Claude Sonnet 4.6 | **Runs:** 12 adversarial evals × 2 configs = 24 subagents | **Grading:** Human-as-judge

| #    | Assertion                                                                          | With                           | Without                                                     |
| ---- | ---------------------------------------------------------------------------------- | ------------------------------ | ----------------------------------------------------------- |
|      | **1. version-constraint-1.21** — Go 1.21 project with 1.22+ patterns               | **<span class="g">7/7</span>** | **<span class="g">7/7</span>**                              |
| 1.1  | Suggests min/max builtins (Go 1.21)                                                | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 1.2  | Suggests slices.Sort or slices.Contains (Go 1.21)                                  | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 1.3  | Suggests sync.OnceValue (Go 1.21)                                                  | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 1.4  | Does NOT suggest range-over-int (requires 1.22+)                                   | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 1.5  | Does NOT suggest removing loop var shadow copy (requires 1.22+)                    | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 1.6  | Does NOT suggest cmp.Or (requires 1.22+)                                           | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 1.7  | Does NOT suggest math/rand/v2 (requires 1.22+)                                     | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
|      | **2. rand-v2-api-renames** — math/rand → math/rand/v2 function renames             | **<span class="g">6/6</span>** | **<span class="r">5/6</span>**                              |
| 2.1  | Renames `Intn` to `IntN` (capital N)                                               | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 2.2  | Renames `Int63n` to `Int64N`                                                       | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 2.3  | Removes all `rand.Seed` calls                                                      | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 2.4  | Replaces `rand.Read` with `crypto/rand` usage                                      | <span class="g">✓</span>       | <span class="r">✗</span> uses `mathrand.IntN(256)` loop     |
| 2.5  | Import changes to `math/rand/v2`                                                   | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 2.6  | No old-style function names in output                                              | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
|      | **3. safety-over-cosmetic** — path traversal vs interface{} → any                  | **<span class="g">6/6</span>** | **<span class="r">5/6</span>**                              |
| 3.1  | Suggests `os.Root`/`os.OpenRoot` for user-supplied paths                           | <span class="g">✓</span>       | <span class="r">✗</span> `filepath.Clean` + `HasPrefix`     |
| 3.2  | Mentions path traversal risk or CWE-22                                             | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 3.3  | Prioritizes safety fix over cosmetic changes                                       | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 3.4  | Also suggests `interface{}` → `any`                                                | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 3.5  | Also suggests `min` builtin or `net.JoinHostPort`                                  | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 3.6  | Does NOT only address cosmetic issues                                              | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
|      | **4. omitzero-vs-omitempty** — time.Time and bool JSON tags                        | **<span class="g">6/6</span>** | **<span class="r">4/6</span>**                              |
| 4.1  | Identifies `omitempty` doesn't omit zero `time.Time`                               | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 4.2  | Suggests `omitzero` for `time.Time` fields                                         | <span class="g">✓</span>       | <span class="r">✗</span> uses `*time.Time` pointer approach |
| 4.3  | Identifies `omitempty` treats `false` as empty for bool                            | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 4.4  | Addresses bool issue correctly (removes tag or uses omitzero)                      | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 4.5  | Correctly notes `omitzero` requires Go 1.24+                                       | <span class="g">✓</span>       | <span class="r">✗</span> claims "no changes in Go 1.24"     |
| 4.6  | Does NOT suggest `omitzero` for string/int fields                                  | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
|      | **5. benchmark-b-loop** — b.Loop() replaces b.N pattern                            | **<span class="g">5/5</span>** | **<span class="r">1/5</span>**                              |
| 5.1  | Replaces `for i := 0; i < b.N; i++` with `for b.Loop()`                            | <span class="g">✓</span>       | <span class="r">✗</span> uses `for range b.N`               |
| 5.2  | Replaces `for n := 0; n < b.N; n++` variant too                                    | <span class="g">✓</span>       | <span class="r">✗</span> uses `for range b.N`               |
| 5.3  | Replaces b.N loop in all benchmarks                                                | <span class="g">✓</span>       | <span class="r">✗</span> uses `for range b.N`               |
| 5.4  | No `b.N` iteration pattern remains                                                 | <span class="g">✓</span>       | <span class="r">✗</span> still uses `b.N`                   |
| 5.5  | Preserves benchmark function names and logic                                       | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
|      | **6. automaxprocs-removal** — Go 1.25 built-in container GOMAXPROCS                | **<span class="g">6/6</span>** | **<span class="g">6/6</span>**                              |
| 6.1  | Suggests removing `go.uber.org/automaxprocs` import                                | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 6.2  | Explains Go 1.25 has built-in container-aware GOMAXPROCS                           | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 6.3  | Suggests `sync.WaitGroup.Go`                                                       | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 6.4  | Does NOT suggest keeping automaxprocs                                              | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 6.5  | Suggests removing from go.mod                                                      | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 6.6  | Mentions cgroup CPU limits or container awareness                                  | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
|      | **7. cmp-or-chained-defaults** — cmp.Or for default value chains (Go 1.22)         | **<span class="g">6/6</span>** | **<span class="r">1/6</span>**                              |
| 7.1  | Uses `cmp.Or` for at least one default value chain                                 | <span class="g">✓</span>       | <span class="r">✗</span> custom `firstEnv` helper           |
| 7.2  | Collapses 3-step host default to single `cmp.Or` call                              | <span class="g">✓</span>       | <span class="r">✗</span> helper function pattern            |
| 7.3  | Import includes `cmp` package                                                      | <span class="g">✓</span>       | <span class="r">✗</span> no `cmp` import                    |
| 7.4  | All multi-step defaults converted to `cmp.Or`                                      | <span class="g">✓</span>       | <span class="r">✗</span> all use `firstEnv` helper          |
| 7.5  | Result is functionally equivalent (same fallback order)                            | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 7.6  | Does NOT introduce a custom helper function                                        | <span class="g">✓</span>       | <span class="r">✗</span> introduces `firstEnv`              |
|      | **8. addcleanup-vs-setfinalizer** — runtime.AddCleanup (Go 1.24)                   | **<span class="g">6/6</span>** | **<span class="g">6/6</span>**                              |
| 8.1  | Replaces `runtime.SetFinalizer` with `runtime.AddCleanup`                          | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 8.2  | Cleanup receives resource, NOT wrapper struct                                      | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 8.3  | Mentions SetFinalizer cycle restriction or deprecation                             | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 8.4  | Does NOT pass whole struct to cleanup                                              | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 8.5  | Correctly attributes to Go 1.24                                                    | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 8.6  | TempFile: two separate AddCleanup calls or struct for both                         | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
|      | **9. http-mux-migration** — net/http enhanced routing (Go 1.22)                    | **<span class="g">6/6</span>** | **<span class="g">6/6</span>**                              |
| 9.1  | Uses `http.NewServeMux()` instead of `mux.NewRouter()`                             | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 9.2  | Uses method prefix: `GET /api/users/{id}`                                          | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 9.3  | Uses `r.PathValue("id")` instead of `mux.Vars(r)`                                  | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 9.4  | All 6 routes with correct method prefixes                                          | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 9.5  | No gorilla/mux import remains                                                      | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 9.6  | Return type changes to `*http.ServeMux`                                            | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
|      | **10. synctest-flaky-fix** — synctest.Test for deterministic concurrency (Go 1.25) | **<span class="g">6/6</span>** | **<span class="r">2/6</span>**                              |
| 10.1 | Uses `synctest.Test` (NOT deprecated `synctest.Run`)                               | <span class="g">✓</span>       | <span class="r">✗</span> removes sleep, blocks on channels  |
| 10.2 | Uses `synctest.Wait()` for goroutine synchronization                               | <span class="g">✓</span>       | <span class="r">✗</span> no synctest at all                 |
| 10.3 | Removes all `time.Sleep` calls                                                     | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 10.4 | No flaky timing dependencies remain                                                | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 10.5 | Correctly imports `testing/synctest`                                               | <span class="g">✓</span>       | <span class="r">✗</span> no synctest import                 |
| 10.6 | Both tests converted                                                               | <span class="g">✓</span>       | <span class="r">✗</span> neither uses synctest              |
|      | **11. waitgroup-go-loopvar** — WaitGroup.Go + loop var + t.Context()               | **<span class="g">7/7</span>** | **<span class="r">4/7</span>**                              |
| 11.1 | Replaces Add/go/Done with `wg.Go(func() { ... })`                                  | <span class="g">✓</span>       | <span class="r">✗</span> uses `errgroup.Go` instead         |
| 11.2 | Removes `wg.Add(1)` calls                                                          | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 11.3 | Removes `defer wg.Done()` calls                                                    | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 11.4 | Removes `item := item` loop variable shadow copies                                 | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 11.5 | Explains Go 1.22+ loop variable semantics                                          | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 11.6 | Replaces `context.Background()` with `t.Context()` in test                         | <span class="g">✓</span>       | <span class="r">✗</span> keeps `context.Background()`       |
| 11.7 | Preserves `WaitGroup.Wait()` call                                                  | <span class="g">✓</span>       | <span class="r">✗</span> uses `errgroup.Wait()` instead     |
|      | **12. timer-gc-greenteagc** — Timer GC change + Green Tea GC (Go 1.26)             | **<span class="g">7/7</span>** | **<span class="r">4/7</span>**                              |
| 12.1 | Identifies some `defer timer.Stop()` calls as unnecessary                          | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 12.2 | Explains Go 1.23+ timer/ticker GC behavior change                                  | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 12.3 | Suggests reviewing GC tuning due to Green Tea GC                                   | <span class="g">✓</span>       | <span class="r">✗</span> only removes redundant `os.Setenv` |
| 12.4 | Mentions Green Tea GC 10-40% overhead reduction                                    | <span class="g">✓</span>       | <span class="r">✗</span> no mention of Green Tea GC         |
| 12.5 | Does NOT remove `ticker.Stop()` in PeriodicTask (needed for correctness)           | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 12.6 | Suggests `go fix ./...` for automated modernization                                | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 12.7 | Correctly distinguishes Stop for GC vs Stop for correctness                        | <span class="g">✓</span>       | <span class="g">✓</span>                                    |

</details>

## `golang-security` — v1.0.0

|             | With Skill         | Without Skill    | Delta     |
| ----------- | ------------------ | ---------------- | --------- |
| **Overall** | **110/110 (100%)** | **75/110 (68%)** | **+32pp** |

<details>
<summary>Full breakdown (110 assertions across 22 evals)</summary>

**Model:** Claude Opus 4.6 | **Runs:** 22 evals × 2 configs = 44 subagents | **Grading:** Human-as-Judge (transcript review)

| #    | Assertion                                                                  | With                           | Without                                                       |
| ---- | -------------------------------------------------------------------------- | ------------------------------ | ------------------------------------------------------------- |
|      | **1. sql-order-by-injection** — ORDER BY with user input from query string | **<span class="g">5/5</span>** | **<span class="g">5/5</span>**                                |
| 1.1  | Does NOT interpolate sortColumn into SQL without allowlist                 | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 1.2  | Uses allowlist map to validate column name                                 | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 1.3  | Has safe default column when input doesn't match                           | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 1.4  | Uses parameterized queries for value parameters                            | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 1.5  | Does NOT use SQL placeholder for column names                              | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
|      | **2. password-hashing** — hash and verify user passwords                   | **<span class="g">5/5</span>** | **<span class="g">5/5</span>**                                |
| 2.1  | Does NOT use SHA256/SHA512/MD5/SHA1 for passwords                          | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 2.2  | Uses Argon2id, bcrypt, scrypt, or PBKDF2                                   | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 2.3  | Generates cryptographically random salt                                    | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 2.4  | Uses appropriate cost/difficulty parameters                                | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 2.5  | Verification uses constant-time comparison                                 | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
|      | **3. timing-attack-token-comparison** — API key middleware                 | **<span class="g">5/5</span>** | **<span class="g">5/5</span>**                                |
| 3.1  | Uses crypto/subtle.ConstantTimeCompare or hmac.Equal                       | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 3.2  | Secret from env var or config, not hardcoded                               | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 3.3  | Returns HTTP 401 on invalid key                                            | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 3.4  | Handles missing Authorization header gracefully                            | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 3.5  | Converts to []byte before ConstantTimeCompare                              | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
|      | **4. path-traversal-file-serving** — serve files from uploads dir          | **<span class="g">5/5</span>** | **<span class="r">2/5</span>**                                |
| 4.1  | Uses os.OpenRoot or validates path stays within uploads                    | <span class="g">✓</span>       | <span class="r">✗</span> just filepath.Join, no validation    |
| 4.2  | Prevents ../ traversal                                                     | <span class="g">✓</span>       | <span class="r">✗</span> no traversal protection              |
| 4.3  | Does NOT leak system paths in errors                                       | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 4.4  | Returns appropriate HTTP status codes                                      | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 4.5  | Handles edge cases (empty, /, ..)                                          | <span class="g">✓</span>       | <span class="r">✗</span> no edge case handling                |
|      | **5. aes-encryption-mode** — AES encrypt/decrypt with 32-byte key          | **<span class="g">5/5</span>** | **<span class="g">5/5</span>**                                |
| 5.1  | Uses GCM mode (not ECB/CBC)                                                | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 5.2  | Fresh random nonce per encryption via crypto/rand                          | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 5.3  | Does NOT hardcode or reuse nonce                                           | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 5.4  | Prepends nonce to ciphertext                                               | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 5.5  | Checks all errors from cipher operations                                   | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
|      | **6. command-injection-imagemagick** — convert image with user filename    | **<span class="g">5/5</span>** | **<span class="g">5/5</span>**                                |
| 6.1  | Does NOT use sh -c or bash -c with concatenation                           | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 6.2  | Passes arguments separately to exec.Command                                | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 6.3  | Validates or sanitizes filename                                            | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 6.4  | Handles command execution errors                                           | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 6.5  | Does NOT concatenate user input into command string                        | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
|      | **7. session-cookie-security** — set session cookie after login            | **<span class="g">5/5</span>** | **<span class="g">5/5</span>**                                |
| 7.1  | Sets HttpOnly: true                                                        | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 7.2  | Sets Secure: true                                                          | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 7.3  | Sets SameSite Lax or Strict                                                | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 7.4  | Uses crypto/rand for session ID                                            | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 7.5  | Sets MaxAge or Expires                                                     | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
|      | **8. jwt-algorithm-confusion** — validate RS256 JWT tokens                 | **<span class="g">5/5</span>** | **<span class="r">4/5</span>**                                |
| 8.1  | Pins signing algorithm to RSA (prevents confusion attack)                  | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 8.2  | Validates token expiration                                                 | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 8.3  | Validates issuer and/or audience claims                                    | <span class="g">✓</span>       | <span class="r">✗</span> no issuer/audience validation        |
| 8.4  | Returns public key in key function                                         | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 8.5  | Returns appropriate error messages                                         | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
|      | **9. error-detail-leakage** — GET /users/:id with DB query                 | **<span class="g">5/5</span>** | **<span class="g">5/5</span>**                                |
| 9.1  | Generic error message to client                                            | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 9.2  | Logs detailed error server-side                                            | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 9.3  | Uses parameterized SQL query                                               | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 9.4  | Returns 404 for sql.ErrNoRows                                              | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 9.5  | No stack traces or DB errors in response                                   | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
|      | **10. pii-logging** — log user login with sensitive User struct            | **<span class="g">5/5</span>** | **<span class="r">4/5</span>**                                |
| 10.1 | Does NOT log Password                                                      | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 10.2 | Does NOT log Token                                                         | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 10.3 | Does NOT use %+v on entire User struct                                     | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 10.4 | Logs user ID and/or username                                               | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 10.5 | Uses structured logging (slog or similar)                                  | <span class="g">✓</span>       | <span class="r">✗</span> log.Printf                           |
|      | **11. zipslip-extraction** — extract user-uploaded ZIP to target dir       | **<span class="g">5/5</span>** | **<span class="r">4/5</span>**                                |
| 11.1 | Checks for path traversal in zip entry names                               | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 11.2 | Uses os.OpenRoot or validates extracted paths                              | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 11.3 | Limits decompression size                                                  | <span class="g">✓</span>       | <span class="r">✗</span> no size limit                        |
| 11.4 | Not just filepath.Join without validation                                  | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 11.5 | Handles extraction errors                                                  | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
|      | **12. http-server-timeouts** — REST API server on port 8080                | **<span class="g">5/5</span>** | **<span class="r">0/5</span>**                                |
| 12.1 | Creates http.Server with explicit timeouts                                 | <span class="g">✓</span>       | <span class="r">✗</span> bare http.ListenAndServe             |
| 12.2 | Sets ReadTimeout                                                           | <span class="g">✓</span>       | <span class="r">✗</span> no timeouts                          |
| 12.3 | Sets WriteTimeout                                                          | <span class="g">✓</span>       | <span class="r">✗</span> no timeouts                          |
| 12.4 | Sets IdleTimeout or MaxHeaderBytes                                         | <span class="g">✓</span>       | <span class="r">✗</span> no timeouts                          |
| 12.5 | Does NOT bind to 0.0.0.0 without justification                             | <span class="g">✓</span>       | <span class="r">✗</span> `:8080` = all interfaces             |
|      | **13. ssrf-url-fetch** — URL preview feature fetching user URL             | **<span class="g">5/5</span>** | **<span class="r">1/5</span>**                                |
| 13.1 | Validates URL scheme is http/https only                                    | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 13.2 | Blocks internal/private IP ranges                                          | <span class="g">✓</span>       | <span class="r">✗</span> no IP blocking                       |
| 13.3 | Blocks cloud metadata endpoints                                            | <span class="g">✓</span>       | <span class="r">✗</span> no metadata blocking                 |
| 13.4 | Not just raw http.Get on user URL                                          | <span class="g">✓</span>       | <span class="r">✗</span> raw http.Get after scheme check      |
| 13.5 | Sets timeout on HTTP client                                                | <span class="g">✓</span>       | <span class="r">✗</span> no timeout                           |
|      | **14. xss-html-rendering** — greeting page with user name in HTML          | **<span class="g">5/5</span>** | **<span class="r">2/5</span>**                                |
| 14.1 | Uses html/template (not text/template or fmt.Fprintf)                      | <span class="g">✓</span>       | <span class="r">✗</span> fmt.Fprintf with %s                  |
| 14.2 | Does NOT concatenate user input into HTML                                  | <span class="g">✓</span>       | <span class="r">✗</span> `fmt.Fprintf(w, "...%s...", name)`   |
| 14.3 | Template auto-escapes user input                                           | <span class="g">✓</span>       | <span class="r">✗</span> no escaping                          |
| 14.4 | Handles empty name parameter                                               | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 14.5 | Sets Content-Type to text/html                                             | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
|      | **15. crypto-random-token** — generate 32-byte hex API token               | **<span class="g">5/5</span>** | **<span class="g">5/5</span>**                                |
| 15.1 | Uses crypto/rand (not math/rand)                                           | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 15.2 | Generates at least 32 bytes                                                | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 15.3 | Returns hex or base64 encoded string                                       | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 15.4 | Handles error from rand.Read                                               | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 15.5 | No deterministic source                                                    | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
|      | **16. hardcoded-credentials-trap** — connect to DB with provided creds     | **<span class="g">5/5</span>** | **<span class="r">0/5</span>**                                |
| 16.1 | Does NOT hardcode password in source                                       | <span class="g">✓</span>       | <span class="r">✗</span> hardcoded S3cureP@ss!                |
| 16.2 | Reads credentials from env vars or config                                  | <span class="g">✓</span>       | <span class="r">✗</span> inline string literal                |
| 16.3 | Explains why hardcoded creds are avoided                                   | <span class="g">✓</span>       | <span class="r">✗</span> no security comment                  |
| 16.4 | Returns error if credentials missing                                       | <span class="g">✓</span>       | <span class="r">✗</span> no validation                        |
| 16.5 | Constructs connection string from runtime values                           | <span class="g">✓</span>       | <span class="r">✗</span> hardcoded DSN                        |
|      | **17. xxe-xml-parsing** — parse XML product from external clients          | **<span class="g">5/5</span>** | **<span class="r">2/5</span>**                                |
| 17.1 | Blocks DOCTYPE/ENTITY declarations                                         | <span class="g">✓</span>       | <span class="r">✗</span> no DTD checking                      |
| 17.2 | Decodes into typed struct (not interface{})                                | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 17.3 | Limits request body size                                                   | <span class="g">✓</span>       | <span class="r">✗</span> io.ReadAll unlimited                 |
| 17.4 | Strict mode or validates XML content                                       | <span class="g">✓</span>       | <span class="r">✗</span> no strict mode                       |
| 17.5 | Appropriate error response                                                 | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
|      | **18. integer-overflow-buffer** — pixel buffer w*h*4 from user input       | **<span class="g">5/5</span>** | **<span class="r">0/5</span>**                                |
| 18.1 | Checks for integer overflow before multiplication                          | <span class="g">✓</span>       | <span class="r">✗</span> no overflow check                    |
| 18.2 | Validates width and height are positive                                    | <span class="g">✓</span>       | <span class="r">✗</span> no positivity check                  |
| 18.3 | Has maximum buffer size limit                                              | <span class="g">✓</span>       | <span class="r">✗</span> no size limit                        |
| 18.4 | Returns error on overflow (not panic)                                      | <span class="g">✓</span>       | <span class="r">✗</span> blindly allocates                    |
| 18.5 | Not blindly make([]byte, w*h*4)                                            | <span class="g">✓</span>       | <span class="r">✗</span> `make([]byte, width*height*4)`       |
|      | **19. open-redirect** — redirect to 'redirect_to' param after login        | **<span class="g">5/5</span>** | **<span class="r">2/5</span>**                                |
| 19.1 | Validates redirect URL against allowlist or same-host                      | <span class="g">✓</span>       | <span class="r">✗</span> no validation                        |
| 19.2 | Blocks dangerous schemes (javascript:, data:)                              | <span class="g">✓</span>       | <span class="r">✗</span> no scheme blocking                   |
| 19.3 | Does NOT blindly redirect to user URL                                      | <span class="g">✓</span>       | <span class="r">✗</span> `http.Redirect(w, r, redirectTo, …)` |
| 19.4 | Safe default when validation fails                                         | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 19.5 | Handles missing parameter                                                  | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
|      | **20. tls-self-signed-cert** — HTTPS client for internal API               | **<span class="g">5/5</span>** | **<span class="g">5/5</span>**                                |
| 20.1 | Does NOT use InsecureSkipVerify: true                                      | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 20.2 | Uses custom CA cert pool                                                   | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 20.3 | Sets MinVersion to TLS 1.2+                                                | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 20.4 | Loads CA cert from file or env var                                         | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 20.5 | Creates proper tls.Config                                                  | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
|      | **21. pprof-exposure** — production API with pprof endpoints               | **<span class="g">5/5</span>** | **<span class="r">3/5</span>**                                |
| 21.1 | Pprof NOT on main public server                                            | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 21.2 | Debug server bound to 127.0.0.1                                            | <span class="g">✓</span>       | <span class="r">✗</span> `:6060` = all interfaces             |
| 21.3 | Separate mux for debug endpoints                                           | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 21.4 | Documents pprof security risk                                              | <span class="g">✓</span>       | <span class="r">✗</span> no security comment                  |
| 21.5 | Main server has timeout configuration                                      | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
|      | **22. gob-deserialization** — decode gob from external API clients         | **<span class="g">5/5</span>** | **<span class="r">1/5</span>**                                |
| 22.1 | Warns about gob for untrusted input (recommends JSON)                      | <span class="g">✓</span>       | <span class="r">✗</span> uses gob without warning             |
| 22.2 | Decodes into typed struct (not interface{})                                | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 22.3 | Limits request body size                                                   | <span class="g">✓</span>       | <span class="r">✗</span> no body limit                        |
| 22.4 | Validates decoded fields                                                   | <span class="g">✓</span>       | <span class="r">✗</span> no validation                        |
| 22.5 | Generic errors to client                                                   | <span class="g">✓</span>       | <span class="r">✗</span> `err.Error()` leaked                 |

</details>

## `golang-documentation` — v1.0.0

|             | With Skill       | Without Skill    | Delta     |
| ----------- | ---------------- | ---------------- | --------- |
| **Overall** | **93/103 (90%)** | **38/103 (37%)** | **+53pp** |

<details>
<summary>Full breakdown (100 assertions across 20 evals)</summary>

**Model:** Claude Sonnet 4.6 | **Runs:** 20 evals × 2 configs = 40 runs | **Grading:** Human-as-judge

| #    | Assertion                                                                   | With                           | Without                                                  |
| ---- | --------------------------------------------------------------------------- | ------------------------------ | -------------------------------------------------------- |
|      | **1. readme-section-order** — README for Go library                         | **<span class="g">5/5</span>** | **<span class="r">4/5</span>**                           |
| 1.1  | Badges immediately after title, before prose                                | <span class="g">✓</span>       | <span class="g">✓</span>                                 |
| 1.2  | Short summary after badges, before code/Getting Started                     | <span class="g">✓</span>       | <span class="g">✓</span>                                 |
| 1.3  | Demo code snippet before Getting Started section                            | <span class="g">✓</span>       | <span class="g">✓</span>                                 |
| 1.4  | Getting Started with `go get` after demo, before Features                   | <span class="g">✓</span>       | <span class="g">✓</span>                                 |
| 1.5  | Features is the longest section, after Getting Started                      | <span class="g">✓</span>       | <span class="r">✗</span> Usage longest, not Features     |
|      | **2. scrambled-readme-reorder** — fix README with wrong section order       | **<span class="g">5/5</span>** | **<span class="r">2/5</span>**                           |
| 2.1  | Badges appear immediately after title, before summary                       | <span class="g">✓</span>       | <span class="g">✓</span>                                 |
| 2.2  | Summary sentence after badges, before demo code                             | <span class="g">✓</span>       | <span class="g">✓</span>                                 |
| 2.3  | Demo code snippet appears before Getting Started section                    | <span class="g">✓</span>       | <span class="r">✗</span> demo inside Getting Started     |
| 2.4  | Getting Started appears after demo and before Features                      | <span class="g">✓</span>       | <span class="r">✗</span> Features before Getting Started |
| 2.5  | Contributing and License at the end, after Features                         | <span class="g">✓</span>       | <span class="g">✓</span>                                 |
|      | **3. doc-comment-why-not-what** — godoc for Merge function                  | **<span class="g">5/5</span>** | **<span class="r">4/5</span>**                           |
| 3.1  | Starts with `Merge` + verb phrase                                           | <span class="g">✓</span>       | <span class="g">✓</span>                                 |
| 3.2  | Includes formal Parameters section listing dst, src, overwrite              | <span class="g">✓</span>       | <span class="r">✗</span> inline description only         |
| 3.3  | Explains overwrite behavior (true vs false)                                 | <span class="g">✓</span>       | <span class="g">✓</span>                                 |
| 3.4  | Documents nil dst handling                                                  | <span class="g">✓</span>       | <span class="g">✓</span>                                 |
| 3.5  | Inline code Example section                                                 | <span class="g">✓</span>       | <span class="g">✓</span>                                 |
|      | **4. small-package-no-doc-go** — 2-file package, doc.go advice              | **<span class="g">5/5</span>** | **<span class="r">1/5</span>**                           |
| 4.1  | Advises AGAINST creating doc.go for a 2-file package                        | <span class="g">✓</span>       | <span class="r">✗</span> suggests doc.go is appropriate  |
| 4.2  | Recommends placing comment at top of main .go file                          | <span class="g">✓</span>       | <span class="r">✗</span> either approach fine            |
| 4.3  | Mentions 3+ files threshold for when doc.go becomes appropriate             | <span class="g">✓</span>       | <span class="r">✗</span> no threshold mentioned          |
| 4.4  | Shows `// Package ...` format                                               | <span class="g">✓</span>       | <span class="g">✓</span>                                 |
| 4.5  | Explains doc.go is for larger packages where no file is the obvious home    | <span class="g">✓</span>       | <span class="r">✗</span> suggests doc.go for peer files  |
|      | **5. example-test-naming** — ExampleXxx for Convert function                | **<span class="g">5/5</span>** | **<span class="r">4/5</span>**                           |
| 5.1  | External test package (`tempconv_test`)                                     | <span class="g">✓</span>       | <span class="g">✓</span>                                 |
| 5.2  | Lowercase suffix (`ExampleConvert_celsiusToFahrenheit`)                     | <span class="g">✓</span>       | <span class="g">✓</span>                                 |
| 5.3  | `// Output:` comment in every example                                       | <span class="g">✓</span>       | <span class="g">✓</span>                                 |
| 5.4  | Uses `fmt.Println` for output                                               | <span class="g">✓</span>       | <span class="r">✗</span> `fmt.Printf`                    |
| 5.5  | Imports and calls `tempconv.Convert`                                        | <span class="g">✓</span>       | <span class="g">✓</span>                                 |
|      | **6. contributing-10min-rule** — CONTRIBUTING with 5 deps                   | **<span class="g">5/5</span>** | **<span class="r">3/5</span>**                           |
| 6.1  | Makefile with make targets                                                  | <span class="g">✓</span>       | <span class="g">✓</span>                                 |
| 6.2  | docker-compose.yml for PostgreSQL, Redis, Elasticsearch                     | <span class="g">✓</span>       | <span class="r">✗</span> individual `docker run`         |
| 6.3  | Quick Start section (clone to tests)                                        | <span class="g">✓</span>       | <span class="g">✓</span>                                 |
| 6.4  | Devcontainer configuration                                                  | <span class="g">✓</span>       | <span class="r">✗</span> not mentioned                   |
| 6.5  | Separates unit tests from integration tests                                 | <span class="g">✓</span>       | <span class="g">✓</span>                                 |
|      | **7. security-fix-miscategorized** — review CHANGELOG with CVE under Fixed  | **<span class="r">4/5</span>** | **<span class="r">4/5</span>**                           |
| 7.1  | Identifies JWT/CVE fix should be in Security section                        | <span class="g">✓</span>       | <span class="g">✓</span>                                 |
| 7.2  | Creates or recommends a ### Security subsection                             | <span class="g">✓</span>       | <span class="g">✓</span>                                 |
| 7.3  | Keeps race condition and memory leak under Fixed                            | <span class="g">✓</span>       | <span class="g">✓</span>                                 |
| 7.4  | Recommends adding comparison links at bottom                                | <span class="g">✓</span>       | <span class="g">✓</span>                                 |
| 7.5  | Recommends adding KaC/Semver reference in file header                       | <span class="r">✗</span>       | <span class="r">✗</span>                                 |
|      | **8. llms-txt** — AI-friendly docs for query builder                        | **<span class="g">5/5</span>** | **<span class="r">4/5</span>**                           |
| 8.1  | Creates llms.txt at repo root                                               | <span class="g">✓</span>       | <span class="g">✓</span>                                 |
| 8.2  | Overview section                                                            | <span class="g">✓</span>       | <span class="g">✓</span>                                 |
| 8.3  | Key Concepts / API Reference listing types and functions                    | <span class="g">✓</span>       | <span class="g">✓</span>                                 |
| 8.4  | Common Patterns with code examples                                          | <span class="g">✓</span>       | <span class="g">✓</span>                                 |
| 8.5  | Mentions discoverability platforms (Context7, DeepWiki, etc.)               | <span class="g">✓</span>       | <span class="r">✗</span> not mentioned                   |
|      | **9. brief-doc-comment-trap** — "write brief comment" for complex function  | **<span class="r">2/5</span>** | **<span class="r">3/5</span>**                           |
| 9.1  | Comment starts with `Do` + verb phrase                                      | <span class="g">✓</span>       | <span class="g">✓</span>                                 |
| 9.2  | Includes Parameters section describing each parameter                       | <span class="r">✗</span>       | <span class="r">✗</span>                                 |
| 9.3  | Documents exponential backoff behavior                                      | <span class="g">✓</span>       | <span class="g">✓</span>                                 |
| 9.4  | Documents context cancellation behavior                                     | <span class="r">✗</span>       | <span class="g">✓</span>                                 |
| 9.5  | Includes inline Example section                                             | <span class="r">✗</span>       | <span class="r">✗</span>                                 |
|      | **10. review-restating-comments** — "team says docs are solid" trap         | **<span class="g">5/5</span>** | **<span class="g">5/5</span>**                           |
| 10.1 | Identifies comments as restating code (anti-pattern)                        | <span class="g">✓</span>       | <span class="g">✓</span>                                 |
| 10.2 | Rewrites Get with cache miss / bool return semantics                        | <span class="g">✓</span>       | <span class="g">✓</span>                                 |
| 10.3 | Rewrites Set with TTL / eviction / overwrite behavior                       | <span class="g">✓</span>       | <span class="g">✓</span>                                 |
| 10.4 | Documents thread safety                                                     | <span class="g">✓</span>       | <span class="g">✓</span>                                 |
| 10.5 | Includes error cases or edge cases in at least one comment                  | <span class="g">✓</span>       | <span class="g">✓</span>                                 |
|      | **11. skip-test-func-comments** — "add comments to test functions" trap     | **<span class="r">4/5</span>** | **<span class="r">4/5</span>**                           |
| 11.1 | Advises against adding doc comments to test functions                       | <span class="g">✓</span>       | <span class="g">✓</span>                                 |
| 11.2 | Explains test names are self-descriptive                                    | <span class="g">✓</span>       | <span class="g">✓</span>                                 |
| 11.3 | Does NOT produce doc comments for the test functions                        | <span class="g">✓</span>       | <span class="g">✓</span>                                 |
| 11.4 | May suggest test helpers deserve comments, not standard Tests               | <span class="r">✗</span>       | <span class="r">✗</span>                                 |
| 11.5 | References godoc convention or test comments not in godoc                   | <span class="g">✓</span>       | <span class="g">✓</span>                                 |
|      | **12. simple-crud-no-file-desc** — "add architecture diagram to CRUD?" trap | **<span class="g">5/5</span>** | **<span class="r">4/5</span>**                           |
| 12.1 | Advises against file-level description for CRUD handler                     | <span class="g">✓</span>       | <span class="g">✓</span>                                 |
| 12.2 | Explains simple CRUD doesn't warrant same treatment as algorithms           | <span class="g">✓</span>       | <span class="g">✓</span>                                 |
| 12.3 | Distinguishes criteria: algorithms/state machines/200+ lines vs CRUD        | <span class="g">✓</span>       | <span class="r">✗</span> general criteria, no thresholds |
| 12.4 | Still recommends doc comments on individual handler functions               | <span class="g">✓</span>       | <span class="g">✓</span>                                 |
| 12.5 | Does NOT produce an ASCII art diagram                                       | <span class="g">✓</span>       | <span class="g">✓</span>                                 |
|      | **13. file-level-description** — scheduler.go 350 lines                     | **<span class="g">5/5</span>** | **<span class="r">3/5</span>**                           |
| 13.1 | Recommends file-level description comment                                   | <span class="g">✓</span>       | <span class="g">✓</span>                                 |
| 13.2 | ASCII art diagram of architecture                                           | <span class="g">✓</span>       | <span class="g">✓</span>                                 |
| 13.3 | Places description below imports                                            | <span class="g">✓</span>       | <span class="r">✗</span> package comment instead         |
| 13.4 | Explains algorithm (priority queue, dispatcher)                             | <span class="g">✓</span>       | <span class="g">✓</span>                                 |
| 13.5 | Notes 200+ line / complex algorithm threshold                               | <span class="g">✓</span>       | <span class="r">✗</span> no threshold mentioned          |
|      | **14. grpc-api-docs** — "use swaggo/swag for gRPC?" trap                    | **<span class="g">5/5</span>** | **<span class="g">5/5</span>**                           |
| 14.1 | Says proto files ARE the docs — swaggo/swag not for gRPC                    | <span class="g">✓</span>       | <span class="g">✓</span>                                 |
| 14.2 | Recommends comments on proto messages/services/RPCs                         | <span class="g">✓</span>       | <span class="g">✓</span>                                 |
| 14.3 | Recommends buf for linting and breaking change detection                    | <span class="g">✓</span>       | <span class="g">✓</span>                                 |
| 14.4 | Shows example proto comments                                                | <span class="g">✓</span>       | <span class="g">✓</span>                                 |
| 14.5 | Mentions grpc-gateway for REST+gRPC                                         | <span class="g">✓</span>       | <span class="g">✓</span>                                 |
|      | **15. app-disguised-as-library** — hybrid project with cmd/ and pkg/        | **<span class="g">5/5</span>** | **<span class="r">3/5</span>**                           |
| 15.1 | Identifies as BOTH library (pkg/) AND application (cmd/)                    | <span class="g">✓</span>       | <span class="g">✓</span>                                 |
| 15.2 | Recommends ExampleXxx for pkg/client and pkg/config                         | <span class="g">✓</span>       | <span class="g">✓</span>                                 |
| 15.3 | Recommends CLI --help + multiple install methods for cmd/                   | <span class="g">✓</span>       | <span class="r">✗</span> only --help, no install methods |
| 15.4 | Recommends configuration documentation for CLI                              | <span class="g">✓</span>       | <span class="r">✗</span> not mentioned                   |
| 15.5 | Does NOT recommend Playground demos for internal/ packages                  | <span class="g">✓</span>       | <span class="g">✓</span>                                 |
|      | **16. existing-contributing-improve** — improve manual-install CONTRIBUTING | **<span class="r">4/5</span>** | **<span class="r">2/5</span>**                           |
| 16.1 | Adds docker-compose.yml to replace manual installs                          | <span class="g">✓</span>       | <span class="g">✓</span>                                 |
| 16.2 | Adds Makefile with make targets                                             | <span class="g">✓</span>       | <span class="r">✗</span> mentions Make, no targets       |
| 16.3 | Reduces setup to 3 or fewer commands                                        | <span class="g">✓</span>       | <span class="r">✗</span> still 6+ commands               |
| 16.4 | Mentions devcontainer for consistent environments                           | <span class="r">✗</span>       | <span class="r">✗</span>                                 |
| 16.5 | Separates unit tests from integration tests                                 | <span class="g">✓</span>       | <span class="g">✓</span>                                 |
|      | **17. play-link-doc-comment** — doc comment with Play: placeholder          | **<span class="g">5/5</span>** | **<span class="g">5/5</span>**                           |
| 17.1 | `// Play:` line with URL                                                    | <span class="g">✓</span>       | <span class="g">✓</span>                                 |
| 17.2 | Starts with `Filter` + verb phrase                                          | <span class="g">✓</span>       | <span class="g">✓</span>                                 |
| 17.3 | Inline code Example section (tab-indented)                                  | <span class="g">✓</span>       | <span class="g">✓</span>                                 |
| 17.4 | Documents new slice returned (original not modified)                        | <span class="g">✓</span>       | <span class="g">✓</span>                                 |
| 17.5 | Documents predicate parameter behavior                                      | <span class="g">✓</span>       | <span class="g">✓</span>                                 |
|      | **18. architecture-decision-records** — ADR directory structure             | **<span class="g">5/5</span>** | **<span class="r">4/5</span>**                           |
| 18.1 | `docs/architecture/` directory                                              | <span class="g">✓</span>       | <span class="r">✗</span> `docs/decisions/`               |
| 18.2 | Numbered file format (0001-xxx.md)                                          | <span class="g">✓</span>       | <span class="g">✓</span>                                 |
| 18.3 | Context section in each ADR                                                 | <span class="g">✓</span>       | <span class="g">✓</span>                                 |
| 18.4 | Design/Decision section                                                     | <span class="g">✓</span>       | <span class="g">✓</span>                                 |
| 18.5 | Consequences section (positive/negative)                                    | <span class="g">✓</span>       | <span class="g">✓</span>                                 |
|      | **19. example-method-naming** — ExampleTypeName_MethodName convention       | **<span class="g">5/5</span>** | **<span class="g">5/5</span>**                           |
| 19.1 | Uses ExampleNew (not ExampleNewClient)                                      | <span class="g">✓</span>       | <span class="g">✓</span>                                 |
| 19.2 | Uses ExampleClient_Get (TypeName_MethodName)                                | <span class="g">✓</span>       | <span class="g">✓</span>                                 |
| 19.3 | Uses ExampleClient_Post                                                     | <span class="g">✓</span>       | <span class="g">✓</span>                                 |
| 19.4 | Every example includes `// Output:` comment                                 | <span class="g">✓</span>       | <span class="g">✓</span>                                 |
| 19.5 | External test package (`httpclient_test`)                                   | <span class="g">✓</span>       | <span class="g">✓</span>                                 |
|      | **20. discoverability-registration** — "what next after publishing?"        | **<span class="g">5/5</span>** | **<span class="g">5/5</span>**                           |
| 20.1 | Recommends Context7                                                         | <span class="g">✓</span>       | <span class="g">✓</span>                                 |
| 20.2 | Recommends DeepWiki                                                         | <span class="g">✓</span>       | <span class="g">✓</span>                                 |
| 20.3 | Recommends llms.txt                                                         | <span class="g">✓</span>       | <span class="g">✓</span>                                 |
| 20.4 | Recommends Play: URLs in doc comments                                       | <span class="g">✓</span>       | <span class="g">✓</span>                                 |
| 20.5 | Mentions 3+ discoverability platforms by name                               | <span class="g">✓</span>       | <span class="g">✓</span>                                 |

</details>

## `golang-benchmark` — v1.0.0

|             | With Skill         | Without Skill     | Delta     |
| ----------- | ------------------ | ----------------- | --------- |
| **Overall** | **356/356 (100%)** | **179/356 (50%)** | **+50pp** |

<details>
<summary>Full breakdown (356 assertions across 80 evals)</summary>

**Model:** Claude Opus 4.6 | **Grading:** Human-as-judge

| #    | Assertion                                                                                  | With                           | Without                                                     |
| ---- | ------------------------------------------------------------------------------------------ | ------------------------------ | ----------------------------------------------------------- |
|      | **1. b-loop-vs-range-bn** — b.Loop() (Go 1.24+) vs legacy for range b.N                    | **<span class="g">5/5</span>** | **<span class="r">2/5</span>**                              |
| 1.1  | Uses b.Loop() as the benchmark loop construct                                              | <span class="g">✓</span>       | <span class="r">✗</span> uses `for range b.N`               |
| 1.2  | Setup code placed BEFORE b.Loop(), not inside it                                           | <span class="g">✓</span>       | <span class="r">✗</span> uses b.ResetTimer()                |
| 1.3  | Does NOT use b.ResetTimer() since b.Loop() auto-excludes setup                             | <span class="g">✓</span>       | <span class="r">✗</span> adds b.ResetTimer()                |
| 1.4  | Does NOT use a package-level sink variable                                                 | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 1.5  | Does NOT use `for i := 0; i < b.N; i++` or `for range b.N`                                 | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
|      | **2. dead-code-elimination-awareness** — compiler DCE with unused benchmark results        | **<span class="g">4/4</span>** | **<span class="r">2/4</span>**                              |
| 2.1  | Identifies dead code elimination as the cause                                              | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 2.2  | Recommends migrating to b.Loop() as primary fix                                            | <span class="g">✓</span>       | <span class="r">✗</span> suggests sink variable only        |
| 2.3  | If mentioning legacy workaround, uses package-level sink (not local)                       | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 2.4  | Explains that b.Loop() also auto-excludes setup code from timing                           | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
|      | **3. count-flag-statistical-significance** — -count=10 for reliable comparison             | **<span class="g">5/5</span>** | **<span class="r">4/5</span>**                              |
| 3.1  | Recommends -count=10 (or higher) for statistical significance                              | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 3.2  | Recommends using benchstat to compare the two runs                                         | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 3.3  | Recommends -benchmem to track allocation metrics                                           | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 3.4  | Recommends saving output to files for benchstat comparison                                 | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 3.5  | Uses -run='^$' to skip unit tests during benchmark runs                                    | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
|      | **4. benchstat-output-interpretation** — p-value, tilde, confidence intervals              | **<span class="g">5/5</span>** | **<span class="r">4/5</span>**                              |
| 4.1  | Explains ~ means no statistically significant difference                                   | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 4.2  | States p=0.089 is above the 0.05 significance threshold                                    | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 4.3  | Notes wide confidence intervals (±8%, ±7%) overlap                                         | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 4.4  | Advises NOT to claim improvement                                                           | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 4.5  | Suggests increasing -count to 20+ or reducing noise                                        | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
|      | **5. p-hacking-awareness** — warns against rerunning until significance                    | **<span class="g">5/5</span>** | **<span class="r">4/5</span>**                              |
| 5.1  | Explicitly warns against 'retry until significant' as p-hacking                            | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 5.2  | Explains that rerunning until ~ disappears introduces bias                                 | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 5.3  | Recommends increasing -count ONCE and accepting the result                                 | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 5.4  | Mentions that at alpha=0.05, ~5% of benchmarks randomly show significance                  | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 5.5  | Suggests the change may genuinely have no measurable effect                                | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
|      | **6. interleaving-benchmark-runs** — systematic bias and pre-compilation                   | **<span class="g">5/5</span>** | **<span class="r">2/5</span>**                              |
| 6.1  | Identifies systematic bias from sequential runs                                            | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 6.2  | Recommends interleaving runs (alternating old/new)                                         | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 6.3  | Recommends pre-compiling both versions with `go test -c`                                   | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 6.4  | Shows running pre-compiled test binaries directly                                          | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 6.5  | Explains compilation overhead varies and contaminates results                              | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
|      | **7. alloc-objects-vs-inuse-space** — heap profile type selection for GC pressure          | **<span class="g">5/5</span>** | **<span class="r">3/5</span>**                              |
| 7.1  | Recommends alloc_objects for GC pressure / high allocation rate                            | <span class="g">✓</span>       | <span class="r">✗</span> suggests inuse_space               |
| 7.2  | GC cares about object count, not size                                                      | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 7.3  | inuse_space is for leak detection, not GC churn                                            | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 7.4  | alloc_space is for reducing peak memory, not GC frequency                                  | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 7.5  | runtime.mallocgc dominating CPU = allocation rate bottleneck                               | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
|      | **8. pprof-flat-vs-cum** — using top -cum to find application hot paths                    | **<span class="g">5/5</span>** | **<span class="r">4/5</span>**                              |
| 8.1  | Recommends `top -cum` for application functions                                            | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 8.2  | Runtime functions in top are symptoms, not causes                                          | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 8.3  | Explains flat vs cum difference                                                            | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 8.4  | Suggests using `list` or `peek` to drill into application functions                        | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 8.5  | Explains the 'flat low + cum high' pattern                                                 | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
|      | **9. escape-analysis-interpretation** — gcflags -m for heap escape investigation           | **<span class="g">5/5</span>** | **<span class="r">4/5</span>**                              |
| 9.1  | Recommends `go build -gcflags="-m"` for escape decisions                                   | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 9.2  | Mentions `-m -m` for verbose escape chain output                                           | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 9.3  | Lists common escape causes: pointer to local, interface boxing, closures                   | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 9.4  | Notes analysis is free (compile-time, no runtime overhead)                                 | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 9.5  | Only investigate escapes in hot functions from pprof, not all                              | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
|      | **10. inlining-budget-and-blockers** — inline cost budget and common blockers              | **<span class="g">5/5</span>** | **<span class="r">3/5</span>**                              |
| 10.1 | Recommends `go build -gcflags="-m"` and grepping for inline                                | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 10.2 | Mentions the inline cost budget of 80                                                      | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 10.3 | Lists defer as an inlining blocker                                                         | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 10.4 | Lists recover() as an inlining blocker                                                     | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 10.5 | Splitting large functions helps the hot inner function inline                              | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
|      | **11. trace-vs-pprof-selection** — when execution trace is needed over pprof               | **<span class="g">5/5</span>** | **<span class="r">3/5</span>**                              |
| 11.1 | Low CPU with high latency = goroutines waiting, not working                                | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 11.2 | Recommends `go tool trace` for scheduling delays and blocking                              | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 11.3 | pprof only shows on-CPU time; trace shows off-CPU waiting                                  | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 11.4 | Goroutine states: yellow/orange = runnable, red/pink = blocked                             | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 11.5 | Mentions -pprof=sync or -pprof=net to extract blocking profiles from trace                 | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
|      | **12. benchstat-unit-normalization** — ns/op displayed as sec/op with µ prefix             | **<span class="g">4/4</span>** | **<span class="r">2/4</span>**                              |
| 12.1 | benchstat automatically normalizes units for display                                       | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 12.2 | ns/op displayed as sec/op with µ prefix to avoid 'µns/op'                                  | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 12.3 | MB/s similarly normalized to B/s with K, M, G prefixes                                     | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 12.4 | Confirms this is expected behavior, not an error                                           | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
|      | **13. benchstat-filter-syntax** — -filter flag for selecting benchmarks                    | **<span class="g">4/4</span>** | **<span class="r">0/4</span>**                              |
| 13.1 | Uses benchstat's -filter flag rather than grep                                             | <span class="g">✓</span>       | <span class="r">✗</span> suggests grep                      |
| 13.2 | Correct filter syntax: -filter '/format:json'                                              | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 13.3 | Mentions regex support in filters                                                          | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 13.4 | Mentions logical operators (AND, OR, negation with -)                                      | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
|      | **14. benchstat-projection-col-flag** — -col flag for sub-benchmark comparison             | **<span class="g">4/4</span>** | **<span class="r">0/4</span>**                              |
| 14.1 | Uses -col /format to create columns from sub-benchmark parameters                          | <span class="g">✓</span>       | <span class="r">✗</span> suggests separate files            |
| 14.2 | Shows command: benchstat -col /format bench.txt                                            | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 14.3 | Mentions -row .name to simplify row names                                                  | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 14.4 | Mentions @() sort modifier for column order                                                | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
|      | **15. benchstat-assume-exact** — assume=exact for deterministic metrics                    | **<span class="g">5/5</span>** | **<span class="r">0/5</span>**                              |
| 15.1 | Recommends assume=exact unit metadata                                                      | <span class="g">✓</span>       | <span class="r">✗</span> suggests -count=10 anyway          |
| 15.2 | Shows syntax: Unit <metric> assume=exact                                                   | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 15.3 | assume=exact disables non-parametric statistics                                            | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 15.4 | benchstat warns if values vary when assume=exact is set                                    | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 15.5 | Single measurement works with assume=exact                                                 | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
|      | **16. ci-regression-tool-selection** — benchdiff vs cob vs gobenchdata                     | **<span class="g">5/5</span>** | **<span class="r">1/5</span>**                              |
| 16.1 | Recommends benchdiff for PR-to-base with statistical rigor                                 | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 16.2 | benchdiff uses benchstat internally                                                        | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 16.3 | cob is simpler but uses single-run comparison                                              | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 16.4 | Mentions gobenchdata for long-term trend tracking                                          | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 16.5 | Tradeoff: benchdiff=rigor, cob=simple, gobenchdata=trends                                  | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
|      | **17. cob-data-loss-warning** — cob uses git reset, destructive                            | **<span class="g">5/5</span>** | **<span class="r">0/5</span>**                              |
| 17.1 | Warns that cob uses `git reset` which can cause data loss                                  | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 17.2 | Recommends committing all work before running cob                                          | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 17.3 | Suggests running cob only in CI, not locally                                               | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 17.4 | cob compares single runs without benchstat-style statistics                                | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 17.5 | Mentions [skip cob] commit message convention                                              | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
|      | **18. noisy-neighbor-mitigation** — CI benchmark variance and strategies                   | **<span class="g">6/6</span>** | **<span class="r">4/6</span>**                              |
| 18.1 | Shared CI runners have 5-10% variance                                                      | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 18.2 | Run both base and head in same CI job for relative comparison                              | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 18.3 | Use -count=10+ with benchstat to filter noise                                              | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 18.4 | Conservative thresholds (20%+) on shared runners                                           | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 18.5 | Warns against 'retry until pass' as selection bias                                         | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 18.6 | Dedicated/self-hosted runners for critical benchmarks                                      | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
|      | **19. self-hosted-runner-tuning** — system-level settings for benchmark stability          | **<span class="g">5/5</span>** | **<span class="r">1/5</span>**                              |
| 19.1 | Disable CPU frequency scaling with 'performance' governor                                  | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 19.2 | Disable Turbo Boost (Intel no_turbo or AMD boost)                                          | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 19.3 | Pin benchmarks to specific cores using taskset                                             | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 19.4 | Disable SMT/Hyper-Threading                                                                | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 19.5 | Only apply to dedicated runners, never developer machines                                  | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
|      | **20. taskset-core-pinning-rationale** — why core pinning reduces variance                 | **<span class="g">4/4</span>** | **<span class="r">2/4</span>**                              |
| 20.1 | Without pinning, OS migrates process across cores                                          | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 20.2 | L1/L2 caches are per-core, migration causes cache thrashing                                | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 20.3 | Leave cores 0-1 for OS, use cores 2+ for benchmarks                                        | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 20.4 | Shows taskset -c 2,3 go test ... syntax                                                    | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
|      | **21. b-report-metric-custom** — b.ReportMetric and b.Elapsed for throughput               | **<span class="g">4/4</span>** | **<span class="r">2/4</span>**                              |
| 21.1 | Uses b.ReportMetric() for custom metrics                                                   | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 21.2 | Uses b.Elapsed() for total benchmark duration                                              | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 21.3 | Shows pattern: b.ReportMetric(float64(bytes)/b.Elapsed().Seconds(), "bytes/s")             | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 21.4 | Custom metric integrates with standard benchmark output                                    | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
|      | **22. memory-leak-detection-with-base** — pprof -base for heap snapshot diff               | **<span class="g">5/5</span>** | **<span class="g">5/5</span>**                              |
| 22.1 | Take two heap snapshots separated by time                                                  | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 22.2 | Uses pprof -base to diff the two snapshots                                                 | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 22.3 | Recommends -inuse_space for leak detection                                                 | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 22.4 | alloc_space is cumulative and includes freed objects                                       | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 22.5 | Common leak causes: unbounded caches, maps that never shrink, goroutine leaks              | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
|      | **23. mutex-block-profile-enablement** — mutex/block profiles disabled by default          | **<span class="g">5/5</span>** | **<span class="r">4/5</span>**                              |
| 23.1 | Mutex profiling disabled by default, must be enabled                                       | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 23.2 | Shows runtime.SetMutexProfileFraction()                                                    | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 23.3 | Explains fraction parameter (e.g., 5 = 1/5 events recorded)                                | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 23.4 | Recommends disabling after investigation (SetMutexProfileFraction(0))                      | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 23.5 | Mentions runtime.SetBlockProfileRate() for block profile                                   | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
|      | **24. trace-custom-annotations** — runtime/trace tasks, regions, logs                      | **<span class="g">5/5</span>** | **<span class="r">4/5</span>**                              |
| 24.1 | trace.NewTask for logical operations spanning goroutines                                   | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 24.2 | trace.WithRegion for phases within a task                                                  | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 24.3 | trace.Log for point-in-time markers                                                        | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 24.4 | Correct usage with context propagation (ctx parameter)                                     | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 24.5 | Annotations add negligible overhead when tracing is disabled                               | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
|      | **25. trace-gc-phase-interpretation** — GC assist in execution traces                      | **<span class="g">5/5</span>** | **<span class="r">3/5</span>**                              |
| 25.1 | GC mark assist = goroutines drafted by GC to scan heap                                     | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 25.2 | Runtime forces goroutines to assist proportional to allocation rate                        | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 25.3 | Symptom of too many allocations, not a GC config problem                                   | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 25.4 | Reduce allocation rate rather than tuning GOGC                                             | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 25.5 | Distinguishes mark assist from STW which affects all goroutines equally                    | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
|      | **26. trace-pprof-extraction** — extracting pprof from trace data                          | **<span class="g">4/4</span>** | **<span class="r">1/4</span>**                              |
| 26.1 | Uses `go tool trace -pprof=net trace.out > net.prof`                                       | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 26.2 | Then uses go tool pprof on extracted profile                                               | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 26.3 | Mentions other extractable types: sync, syscall, sched                                     | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 26.4 | Bridges trace data (nanosecond) with pprof analysis (statistical)                          | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
|      | **27. fieldalignment-no-autofix** — diagnostic without -fix flag                           | **<span class="g">4/4</span>** | **<span class="r">3/4</span>**                              |
| 27.1 | Recommends `fieldalignment ./...` to detect padding waste                                  | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 27.2 | Does NOT use the -fix flag                                                                 | <span class="g">✓</span>       | <span class="r">✗</span> suggests -fix                      |
| 27.3 | Mentions unsafe.Sizeof/Alignof/Offsetof for layout inspection                              | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 27.4 | Treats as diagnostic step, not automatic fix                                               | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
|      | **28. godebug-gctrace-runtime-diagnostics** — GODEBUG env vars for GC diagnostics          | **<span class="g">4/4</span>** | **<span class="g">4/4</span>**                              |
| 28.1 | Recommends GODEBUG=gctrace=1 without recompiling                                           | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 28.2 | Describes gctrace output: GC frequency, pause times, heap sizes, CPU%                      | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 28.3 | Mentions other GODEBUG options like schedtrace                                             | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 28.4 | Configured via environment variables, no recompile needed                                  | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
|      | **29. runtime-scanobject-cpu-diagnosis** — GC pointer scanning high in CPU profile         | **<span class="g">5/5</span>** | **<span class="r">3/5</span>**                              |
| 29.1 | runtime.scanobject = GC pointer scanning                                                   | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 29.2 | Heap contains many pointers GC must trace                                                  | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 29.3 | Reduce pointer density: value types in slices/maps                                         | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 29.4 | Flatten structures or use [N]byte instead of string in hot structs                         | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 29.5 | References golang-performance skill for optimization patterns                              | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
|      | **30. runtime-memmove-diagnosis** — memmove high in CPU profile                            | **<span class="g">5/5</span>** | **<span class="g">5/5</span>**                              |
| 30.1 | runtime.memmove = large memory copies                                                      | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 30.2 | Common causes: slice append, copy() of large slices, string-to-byte                        | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 30.3 | Pre-allocate slices to final capacity                                                      | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 30.4 | Reuse buffers or work with []byte directly                                                 | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 30.5 | Use top -cum to find application functions triggering memmoves                             | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
|      | **31. fgprof-off-cpu-profiling** — fgprof for combined on/off-CPU profiling                | **<span class="g">4/4</span>** | **<span class="r">1/4</span>**                              |
| 31.1 | Recommends fgprof (github.com/felixge/fgprof)                                              | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 31.2 | fgprof captures both on-CPU and off-CPU time in single profile                             | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 31.3 | Standard pprof CPU profiles only show on-CPU time                                          | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 31.4 | Use case: pprof shows low CPU% but latency is high                                         | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
|      | **32. flight-recorder-go125** — Go 1.25 flight recorder for retroactive trace              | **<span class="g">6/6</span>** | **<span class="r">0/6</span>**                              |
| 32.1 | Recommends Go 1.25 flight recorder (trace.NewFlightRecorder)                               | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 32.2 | Keeps circular buffer of recent trace data in memory                                       | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 32.3 | Shows snapshotting with WriteTo on anomaly detection                                       | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 32.4 | Mentions MinAge and MaxBytes parameters                                                    | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 32.5 | Shows trigger pattern (slow request detection)                                             | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 32.6 | At most one flight recorder active at a time                                               | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
|      | **33. flight-recorder-sync-once-pattern** — sync.Once for snapshot dedup                   | **<span class="g">5/5</span>** | **<span class="r">0/5</span>**                              |
| 33.1 | Uses sync.Once to ensure only one snapshot                                                 | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 33.2 | Calls fr.WriteTo inside sync.Once.Do                                                       | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 33.3 | Only one goroutine may call WriteTo at a time                                              | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 33.4 | Shows calling snapshot in separate goroutine                                               | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 33.5 | Shows fr.Stop() after WriteTo completes                                                    | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
|      | **34. flight-recorder-sizing** — MinAge and MaxBytes configuration                         | **<span class="g">4/4</span>** | **<span class="r">0/4</span>**                              |
| 34.1 | MinAge ~2x problem window (10s for 5s investigation)                                       | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 34.2 | Busy services generate ~1-10 MB/s of trace data                                            | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 34.3 | Start MaxBytes at 1-5 MiB and adjust                                                       | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 34.4 | MaxBytes takes precedence over MinAge                                                      | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
|      | **35. trace-timeline-color-coding** — execution trace UI color interpretation              | **<span class="g">5/5</span>** | **<span class="r">3/5</span>**                              |
| 35.1 | Yellow/orange = runnable, waiting for processor                                            | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 35.2 | Red bands across all P lanes = GC stop-the-world                                           | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 35.3 | Yellow gaps = CPU saturation, too many goroutines competing                                | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 35.4 | Green = actively executing/running                                                         | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 35.5 | Check goroutine count vs GOMAXPROCS to verify saturation                                   | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
|      | **36. pprof-web-ui-flamegraph** — interactive web UI for profile exploration               | **<span class="g">4/4</span>** | **<span class="g">4/4</span>**                              |
| 36.1 | `go tool pprof -http=:8080 cpu.prof` for web UI                                            | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 36.2 | Flamegraph view is most intuitive                                                          | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 36.3 | Lists other views: Graph, Top, Source, Disassembly, Peek                                   | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 36.4 | Filters can be pre-applied with -focus flag                                                | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
|      | **37. pprof-focus-ignore-difference** — focus vs ignore vs show vs hide semantics          | **<span class="g">5/5</span>** | **<span class="r">3/5</span>**                              |
| 37.1 | focus keeps only paths containing matching function                                        | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 37.2 | ignore removes functions, attributes costs to callers                                      | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 37.3 | show is like focus but display-only, no cost accounting change                             | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 37.4 | hide is like ignore but display-only, no cost accounting change                            | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 37.5 | `reset` to clear all filters                                                               | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
|      | **38. pprof-tags-and-labels** — pprof.Do() custom labels for multi-tenant profiling        | **<span class="g">5/5</span>** | **<span class="r">2/5</span>**                              |
| 38.1 | Uses pprof.Labels() and pprof.Do() for custom labels                                       | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 38.2 | Correct pattern: pprof.Do(ctx, pprof.Labels("key", "value"), func...)                      | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 38.3 | tagfocus to filter by label                                                                | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 38.4 | tagroot to group by label                                                                  | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 38.5 | tags command to see all tag keys and distributions                                         | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
|      | **39. pprof-sample-index-switching** — switch metrics without reloading                    | **<span class="g">4/4</span>** | **<span class="r">1/4</span>**                              |
| 39.1 | sample_index command to switch metrics                                                     | <span class="g">✓</span>       | <span class="r">✗</span> suggests exit and reopen           |
| 39.2 | Correct syntax: sample_index=inuse_space                                                   | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 39.3 | Lists available indices: alloc_objects, alloc_space, inuse_objects, inuse_space            | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 39.4 | Heap profiles contain multiple metrics, switchable interactively                           | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
|      | **40. pprof-granularity-lines** — per-line costs in top output                             | **<span class="g">3/3</span>** | **<span class="r">0/3</span>**                              |
| 40.1 | granularity=lines for per-line grouping in top                                             | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 40.2 | Other levels: functions (default), filefunctions, files, addresses                         | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 40.3 | Shows command: granularity=lines or -granularity=lines                                     | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
|      | **41. ssa-dump-investigation** — GOSSAFUNC for compiler optimization passes                | **<span class="g">5/5</span>** | **<span class="r">1/5</span>**                              |
| 41.1 | GOSSAFUNC=FunctionName go build for SSA dump                                               | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 41.2 | Creates ssa.html openable in browser                                                       | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 41.3 | Optimization passes: source, AST, start SSA, opt, lower, regalloc, genssa                  | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 41.4 | What to look for: bounds checks, dead code, constant folding, register spills              | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 41.5 | Click values to highlight across passes                                                    | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
|      | **42. assembly-output-heap-allocation-detection** — verify no heap allocs in assembly      | **<span class="g">4/4</span>** | **<span class="g">4/4</span>**                              |
| 42.1 | Uses `go build -gcflags="-S"` for assembly output                                          | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 42.2 | Grep for CALL runtime.makeslice, runtime.newobject, growslice                              | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 42.3 | `go tool objdump` as alternative for compiled binaries                                     | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 42.4 | `-S` flag for source-interleaved disassembly                                               | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
|      | **43. value-receiver-inlining-advantage** — value vs pointer receivers and inlining        | **<span class="g">4/4</span>** | **<span class="r">1/4</span>**                              |
| 43.1 | Value receivers enable full inlining of method chains                                      | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 43.2 | Pointer receivers add indirection blocking inlining for fluent APIs                        | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 43.3 | Check with -gcflags="-m" to verify inlining behavior                                       | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 43.4 | Considers struct size trade-off (value receivers copy the struct)                          | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
|      | **44. prometheus-go-metrics-vs-runtime-metrics** — runtime/metrics ≠ Prometheus metrics    | **<span class="g">4/4</span>** | **<span class="r">1/4</span>**                              |
| 44.1 | runtime/metrics are Go internal data, not Prometheus metrics                               | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 44.2 | prometheus/client_golang selectively converts runtime/metrics                              | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 44.3 | Lists actual Prometheus metric names (go_memstats_alloc_bytes, etc.)                       | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 44.4 | By default only traditional go_memstats_* and go_gc_* are exposed                          | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
|      | **45. go-memstats-stw-overhead** — ReadMemStats causing stop-the-world pauses              | **<span class="g">4/4</span>** | **<span class="r">1/4</span>**                              |
| 45.1 | go_memstats_* calls ReadMemStats() which triggers short STW pause                          | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 45.2 | Go 1.17+ runtime/metrics-based collector as lower overhead alternative                     | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 45.3 | Shows code: collectors.NewGoCollector with GoRuntimeMetricsCollection                      | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 45.4 | Use custom prometheus.NewRegistry() rather than default                                    | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
|      | **46. promql-gc-pressure-queries** — specific PromQL for GC pressure investigation         | **<span class="g">5/5</span>** | **<span class="r">3/5</span>**                              |
| 46.1 | rate(go_gc_duration_seconds_count[5m]) for GC frequency                                    | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 46.2 | >2 GC cycles/s sustained = excessive allocation rate                                       | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 46.3 | go_gc_duration_seconds{quantile="1"} for worst-case pause                                  | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 46.4 | rate(go_memstats_alloc_bytes_total[5m]) for allocation rate                                | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 46.5 | Correlate with P99 latency to confirm GC causes tail latency                               | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
|      | **47. promql-goroutine-leak-detection** — PromQL patterns for goroutine leaks              | **<span class="g">4/4</span>** | **<span class="r">3/4</span>**                              |
| 47.1 | go_goroutines gauge for current count                                                      | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 47.2 | delta(go_goroutines[1h]) for net change                                                    | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 47.3 | Count should correlate with load; independent growth = leak                                | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 47.4 | Alerting rule with threshold (go_goroutines > 10000)                                       | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
|      | **48. investigation-session-setup** — structured production investigation preparation      | **<span class="g">5/5</span>** | **<span class="r">1/5</span>**                              |
| 48.1 | Reduce Prometheus scrape interval to <=10s on target instance                              | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 48.2 | Enable pprof via environment variable without recompile                                    | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 48.3 | Enable continuous profiling on target instance only, not fleet-wide                        | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 48.4 | Revert all changes after investigation                                                     | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 48.5 | All debug features should be toggleable via environment variables                          | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
|      | **49. cost-warnings-trace-duration** — trace data volume and practical limits              | **<span class="g">5/5</span>** | **<span class="r">3/5</span>**                              |
| 49.1 | Traces generate MB/s — 5-minute trace would be enormous                                    | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 49.2 | Keep traces to 5-10 seconds maximum                                                        | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 49.3 | Large traces slow to parse, need 1GB+ RAM                                                  | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 49.4 | Suggest flight recorder (Go 1.25+) for intermittent issues                                 | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 49.5 | Browser UI struggles with traces >100MB                                                    | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
|      | **50. benchstat-three-version-comparison** — comparing more than two versions              | **<span class="g">3/3</span>** | **<span class="r">2/3</span>**                              |
| 50.1 | Labels inputs: benchstat v1=v1.txt v2=v2.txt v3=v3.txt                                     | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 50.2 | First input is always the base for comparison                                              | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 50.3 | v2 vs v1 and v3 vs v1 shown (both relative to first)                                       | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
|      | **51. host-level-correlation** — correlating Go metrics with infrastructure                | **<span class="g">4/4</span>** | **<span class="r">3/4</span>**                              |
| 51.1 | Check node_exporter for host-level CPU, memory, disk I/O                                   | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 51.2 | Noisy neighbor: high node_cpu with low process_cpu = external contention                   | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 51.3 | process-exporter for per-process metrics on shared hosts                                   | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 51.4 | Correlate Go app metrics with infrastructure metrics                                       | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
|      | **52. pprof-diff-base-vs-base** — -base vs -diff_base semantics                            | **<span class="g">4/4</span>** | **<span class="r">1/4</span>**                              |
| 52.1 | -base subtracts base from source, values become deltas                                     | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 52.2 | -diff_base shows percentages relative to base profile                                      | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 52.3 | -normalize flag for comparable ratios across different durations                           | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 52.4 | Generate diff SVG for visual comparison                                                    | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
|      | **53. gobenchdata-github-action-setup** — long-term benchmark trend tracking               | **<span class="g">5/5</span>** | **<span class="r">0/5</span>**                              |
| 53.1 | Recommends gobenchdata for trend tracking                                                  | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 53.2 | GitHub Action config with bobheadxi/gobenchdata@v1                                         | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 53.3 | Publishing to gh-pages for dashboard                                                       | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 53.4 | Regression checks config (.gobenchdata-checks.yml) with thresholds                         | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 53.5 | PRUNE_COUNT to limit stored history                                                        | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
|      | **54. benchstat-single-file-summary** — single-file variance analysis                      | **<span class="g">4/4</span>** | **<span class="r">3/4</span>**                              |
| 54.1 | benchstat bench.txt with single file                                                       | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 54.2 | Shows median and confidence interval per benchmark                                         | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 54.3 | Use to check stability before making changes                                               | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 54.4 | High variance (± >5%) = noisy benchmarks                                                   | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
|      | **55. count-minimum-by-scenario** — context-dependent -count recommendations               | **<span class="g">5/5</span>** | **<span class="r">3/5</span>**                              |
| 55.1 | 6 minimum for quick local checks                                                           | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 55.2 | 10 for standard pre-merge comparisons                                                      | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 55.3 | 20-30 for detecting small changes (<5%)                                                    | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 55.4 | 20+ for noisy CI environments                                                              | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 55.5 | Warns against -count=1 as no variance information                                          | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
|      | **56. interface-boxing-escape** — any/interface{} boxing as heap allocation source         | **<span class="g">4/4</span>** | **<span class="g">4/4</span>**                              |
| 56.1 | Interface boxing: concrete type in any allocates heap copy                                 | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 56.2 | fmt.Sprintf as common source of interface boxing                                           | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 56.3 | Use concrete types instead of interfaces in hot paths                                      | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 56.4 | Especially impactful in frequently-called functions                                        | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
|      | **57. trace-scheduling-latency-diagnosis** — runnable-to-running delay analysis            | **<span class="g">5/5</span>** | **<span class="r">2/5</span>**                              |
| 57.1 | High scheduling latency = goroutines waiting for processor                                 | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 57.2 | Too many goroutines competing for GOMAXPROCS (CPU saturation)                              | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 57.3 | Extract sched profile: go tool trace -pprof=sched trace.out                                | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 57.4 | Check uneven distribution across Ps (work imbalance)                                       | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 57.5 | Other causes: OS scheduling, goroutines pinned by cgo/syscalls                             | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
|      | **58. benchmark-output-format-parsing** — understanding benchmark output fields            | **<span class="g">5/5</span>** | **<span class="r">4/5</span>**                              |
| 58.1 | -8 is the GOMAXPROCS suffix                                                                | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 58.2 | 5000000 is the number of iterations (b.N)                                                  | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 58.3 | ns/op is time per operation                                                                | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 58.4 | B/op is bytes allocated per operation                                                      | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 58.5 | allocs/op is heap allocation count per operation                                           | <span class="g">✓</span>       | <span class="r">✗</span> says "allocations" without heap    |
|      | **59. pprof-show-from-framework-noise** — show_from to trim routing noise                  | **<span class="g">4/4</span>** | **<span class="r">0/4</span>**                              |
| 59.1 | Uses show_from=regex to trim frames above first match                                      | <span class="g">✓</span>       | <span class="r">✗</span> suggests ignore instead            |
| 59.2 | Shows pattern: show_from=handler.Handle                                                    | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 59.3 | show_from hides all callers above the match point                                          | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 59.4 | Differentiates from ignore which re-attributes costs                                       | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
|      | **60. optional-prometheus-metrics-enablement** — opt-in Go runtime Prometheus metrics      | **<span class="g">5/5</span>** | **<span class="r">1/5</span>**                              |
| 60.1 | Custom registry with collectors.NewGoCollector                                             | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 60.2 | collectors.WithGoCollectorRuntimeMetrics option                                            | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 60.3 | GoRuntimeMetricsAll or specific collection flags                                           | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 60.4 | Requires Go 1.17+                                                                          | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 60.5 | Scheduler metrics: go_sched_latencies_seconds, CPU class: go_cpu_classes_*                 | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
|      | **61. benchdiff-usage-patterns** — automatic branch comparison with benchdiff              | **<span class="g">5/5</span>** | **<span class="r">0/5</span>**                              |
| 61.1 | Recommends benchdiff for automatic branch comparison                                       | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 61.2 | Command: benchdiff -base-ref main -- -benchmem -count=10                                   | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 61.3 | Caches results for non-worktree refs                                                       | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 61.4 | benchdiff -clear-cache for stale cache                                                     | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 61.5 | Prevents macOS sleep during benchmarks                                                     | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
|      | **62. pprof-noinlines-attribution** — simplify inlined function chains                     | **<span class="g">3/3</span>** | **<span class="r">0/3</span>**                              |
| 62.1 | Uses noinlines option or -noinlines flag                                                   | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 62.2 | Attributes inlined functions to first out-of-line caller                                   | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 62.3 | Correct usage: `noinlines` interactive or `-noinlines` CLI                                 | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
|      | **63. sub-benchmarks-table-driven** — table-driven sub-benchmarks with b.Run               | **<span class="g">5/5</span>** | **<span class="r">3/5</span>**                              |
| 63.1 | Uses b.Run() with descriptive names (size=64)                                              | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 63.2 | Uses b.Loop() inside sub-benchmark since Go 1.24                                           | <span class="g">✓</span>       | <span class="r">✗</span> uses range b.N                     |
| 63.3 | Setup code before b.Loop() call                                                            | <span class="g">✓</span>       | <span class="r">✗</span> uses b.ResetTimer()                |
| 63.4 | Loop over sizes with fmt.Sprintf for names                                                 | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 63.5 | Output: BenchmarkEncode/size=64, BenchmarkEncode/size=256, etc.                            | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
|      | **64. benchstat-geomean-interpretation** — geometric mean row meaning                      | **<span class="g">4/4</span>** | **<span class="g">4/4</span>**                              |
| 64.1 | geomean = geometric mean of changes across all benchmarks                                  | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 64.2 | Represents overall proportional change                                                     | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 64.3 | Useful for single summary across many benchmarks                                           | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 64.4 | Individual benchmarks may differ significantly from geomean                                | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
|      | **65. trace-short-lived-goroutines** — goroutine creation overhead in traces               | **<span class="g">4/4</span>** | **<span class="r">3/4</span>**                              |
| 65.1 | High overhead from goroutine creation/scheduling for short-lived ones                      | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 65.2 | Batch work or use worker pools to reduce creation overhead                                 | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 65.3 | Goroutines created in loops without bounds = potential leak                                | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 65.4 | Goroutines created but never finishing = leak                                              | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
|      | **66. comparing-across-machines-pitfall** — cross-machine comparison invalid               | **<span class="g">4/4</span>** | **<span class="g">4/4</span>**                              |
| 66.1 | Warns that cross-machine comparison is invalid                                             | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 66.2 | Different CPUs, memory, OS = incomparable baselines                                        | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 66.3 | Run both on same machine with same conditions                                              | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 66.4 | Notes this as common benchstat pitfall                                                     | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
|      | **67. b-report-allocs-vs-benchmem** — two ways to enable allocation reporting              | **<span class="g">4/4</span>** | **<span class="g">4/4</span>**                              |
| 67.1 | b.ReportAllocs() in benchmark function                                                     | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 67.2 | -benchmem flag on go test command                                                          | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 67.3 | Both produce same B/op and allocs/op output                                                | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 67.4 | b.ReportAllocs() is per-benchmark, -benchmem is for all                                    | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
|      | **68. pprof-goroutine-debug-levels** — ?debug=1 and ?debug=2 for goroutine dumps           | **<span class="g">4/4</span>** | **<span class="r">3/4</span>**                              |
| 68.1 | curl with ?debug=1 for human-readable dump                                                 | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 68.2 | ?debug=2 for full stacks with creation site and labels                                     | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 68.3 | Shows URL: /debug/pprof/goroutine?debug=1 or ?debug=2                                      | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 68.4 | No go tool pprof needed for debug mode dumps                                               | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
|      | **69. ci-threshold-calibration** — regression thresholds by CI environment                 | **<span class="g">5/5</span>** | **<span class="r">0/5</span>**                              |
| 69.1 | 20%+ threshold on shared/GitHub-hosted runners                                             | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 69.2 | 10% on dedicated self-hosted runners                                                       | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 69.3 | Tight thresholds on noisy environments = false positives eroding trust                     | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 69.4 | GitHub-hosted runners ~2-3% CoV in best case                                               | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 69.5 | <1% false positive rate requires 7%+ gate                                                  | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
|      | **70. cpu-profile-sampling-rate** — CPU profiler 100Hz sampling mechanism                  | **<span class="g">4/4</span>** | **<span class="g">4/4</span>**                              |
| 70.1 | CPU profiling uses statistical sampling at 100Hz                                           | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 70.2 | Functions shorter than sampling interval may not appear                                    | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 70.3 | Only captures on-CPU time, off-CPU invisible                                               | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 70.4 | ~5% overhead during CPU profile capture                                                    | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
|      | **71. benchstat-ignore-dimension-warning** — -ignore flag for suppressing warnings         | **<span class="g">4/4</span>** | **<span class="r">1/4</span>**                              |
| 71.1 | -ignore /gomaxprocs to suppress warning                                                    | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 71.2 | -ignore omits keys from grouping                                                           | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 71.3 | -row .name to simplify row grouping                                                        | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 71.4 | -col /gomaxprocs to compare across values instead                                          | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
|      | **72. escape-analysis-fmt-sprintf** — fmt.Sprintf heap allocation explanation              | **<span class="g">4/4</span>** | **<span class="g">4/4</span>**                              |
| 72.1 | fmt.Sprintf arguments boxed into any/interface{} (boxing)                                  | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 72.2 | Result string is also heap-allocated                                                       | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 72.3 | fmt.Sprintf is common escape cause in compiler analysis                                    | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 72.4 | Alternatives for hot paths: strconv, strings.Builder, direct byte manipulation             | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
|      | **73. runtime-readmemstats-vs-runtime-metrics** — programmatic GC stats APIs               | **<span class="g">5/5</span>** | **<span class="r">4/5</span>**                              |
| 73.1 | runtime.ReadMemStats for heap size, NumGC, pause durations                                 | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 73.2 | debug.ReadGCStats for GC-specific statistics                                               | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 73.3 | runtime/metrics (Go 1.16+) as preferred modern API                                         | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 73.4 | runtime/metrics has lower overhead and safe for concurrent reads                           | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 73.5 | ReadMemStats is more expensive due to internal locking                                     | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
|      | **74. pprof-callgrind-export** — exporting to KCachegrind format                           | **<span class="g">4/4</span>** | **<span class="r">3/4</span>**                              |
| 74.1 | callgrind command or -callgrind flag to export                                             | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 74.2 | Command: go tool pprof -callgrind cpu.prof > cpu.callgrind                                 | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 74.3 | KCachegrind or QCachegrind as visualization tools                                          | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 74.4 | proto command for protobuf format as alternative                                           | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
|      | **75. expvar-lightweight-monitoring** — stdlib expvar for JSON metrics                     | **<span class="g">4/4</span>** | **<span class="r">3/4</span>**                              |
| 75.1 | Recommends expvar package from stdlib                                                      | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 75.2 | import _ "expvar" auto-registers at /debug/vars                                            | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 75.3 | Serves JSON format                                                                         | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 75.4 | Integration with Netdata, Telegraf, custom dashboards                                      | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
|      | **76. benchstat-table-flag-per-package** — -table pkg for per-package tables               | **<span class="g">3/3</span>** | **<span class="r">0/3</span>**                              |
| 76.1 | -table pkg flag for one table per package                                                  | <span class="g">✓</span>       | <span class="r">✗</span> suggests running benchstat per pkg |
| 76.2 | Command: benchstat -table pkg old.txt new.txt                                              | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 76.3 | Default -table is .config (goos/goarch/pkg/cpu)                                            | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
|      | **77. pprof-symbolization-remote** — symbolization modes for remote profiles               | **<span class="g">4/4</span>** | **<span class="r">1/4</span>**                              |
| 77.1 | Symbolization modes: local, remote, none                                                   | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 77.2 | -symbolize=local for local binaries                                                        | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 77.3 | PPROF_BINARY_PATH env var for binary search paths                                          | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 77.4 | -symbolize=remote to contact running service                                               | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
|      | **78. trace-concurrent-with-flight-recorder** — trace.Start and FlightRecorder coexistence | **<span class="g">3/3</span>** | **<span class="r">0/3</span>**                              |
| 78.1 | Flight recorder can run concurrently with trace.Start                                      | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 78.2 | At most one flight recorder active at a time                                               | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 78.3 | Both can be active simultaneously without conflict                                         | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
|      | **79. pyroscope-overhead-warning** — continuous profiling overhead at scale                | **<span class="g">4/4</span>** | **<span class="r">3/4</span>**                              |
| 79.1 | ~2-5% CPU overhead per instance for continuous profiling                                   | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 79.2 | 200 instances = significant aggregate compute and storage cost                             | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 79.3 | Enable on subset of instances or on-demand via env var                                     | <span class="g">✓</span>       | <span class="g">✓</span>                                    |
| 79.4 | Investigation session approach: target instances only, not fleet-wide                      | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
|      | **80. non-go-memory-leak-detection** — PromQL for cgo/mmap leak detection                  | **<span class="g">4/4</span>** | **<span class="r">1/4</span>**                              |
| 80.1 | PromQL: process_resident_memory_bytes - go_memstats_sys_bytes                              | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 80.2 | Gap = non-Go memory (cgo, mmap)                                                            | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 80.3 | Growing gap = non-Go memory leak                                                           | <span class="g">✓</span>       | <span class="r">✗</span>                                    |
| 80.4 | Investigate cgo calls or memory-mapped files                                               | <span class="g">✓</span>       | <span class="g">✓</span>                                    |

</details>

## `golang-observability` — v1.0.0

|             | With Skill         | Without Skill     | Delta     |
| ----------- | ------------------ | ----------------- | --------- |
| **Overall** | **185/185 (100%)** | **117/185 (63%)** | **+37pp** |

<details>
<summary>Full breakdown (185 assertions across 40 evals)</summary>

**Model:** Claude Opus 4.6 | **Grading:** Human-as-judge

| #    | Assertion                                                                                                             | With                           | Without                                                           |
| ---- | --------------------------------------------------------------------------------------------------------------------- | ------------------------------ | ----------------------------------------------------------------- |
|      | **1. summary-vs-histogram-multi-replica** — Histogram over Summary when multiple replicas need aggregated percentiles | **<span class="g">5/5</span>** | **<span class="g">5/5</span>**                                    |
| 1.1  | Recommends Histogram, not Summary                                                                                     | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 1.2  | Explains that Summary quantiles cannot be aggregated across multiple instances                                        | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 1.3  | Shows histogram_quantile() PromQL function for computing percentiles server-side                                      | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 1.4  | Mentions that Histogram supports server-side aggregation across replicas                                              | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 1.5  | Uses prometheus.NewHistogramVec (not NewSummary) in the code example                                                  | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
|      | **2. log-and-return-error-trap** — single handling rule: log OR return, never both                                    | **<span class="g">5/5</span>** | **<span class="g">5/5</span>**                                    |
| 2.1  | Identifies the log-and-return pattern as incorrect                                                                    | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 2.2  | Explains that the error gets logged multiple times as it propagates up the chain                                      | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 2.3  | Recommends returning the error with context and logging once at the top level                                         | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 2.4  | Shows the corrected pattern: return fmt.Errorf with wrapping, no slog call                                            | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 2.5  | References or explains the single handling rule (errors are either logged OR returned, never both)                    | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
|      | **3. high-cardinality-label-trap** — high-cardinality label usage in Prometheus metrics                               | **<span class="g">6/6</span>** | **<span class="r">4/6</span>**                                    |
| 3.1  | Identifies userID as a high-cardinality label that will cause problems                                                | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 3.2  | Identifies r.URL.Path as potentially high-cardinality (should use route template instead)                             | <span class="g">✓</span>       | <span class="r">✗</span> focuses on userID, misses URL.Path       |
| 3.3  | Explains that each unique label combination creates a separate time series                                            | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 3.4  | Warns about memory explosion on the Prometheus server from unbounded labels                                           | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 3.5  | Recommends using route patterns/templates (e.g., /users/:id) instead of actual paths                                  | <span class="g">✓</span>       | <span class="r">✗</span> generic advice without route template    |
| 3.6  | Suggests using traces (not metrics) for high-cardinality data like user IDs                                           | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
|      | **4. production-json-logging** — JSON handler for production, not TextHandler                                         | **<span class="g">4/4</span>** | **<span class="r">3/4</span>**                                    |
| 4.1  | Recommends JSONHandler for production, not TextHandler                                                                | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 4.2  | Explains that plain-text multiline logs (e.g., stack traces) get split into separate records by log collectors        | <span class="g">✓</span>       | <span class="r">✗</span> generic "not machine-parseable"          |
| 4.3  | Suggests TextHandler is appropriate for development only                                                              | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 4.4  | Shows the correct JSONHandler setup with slog.LevelInfo for production                                                | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
|      | **5. slog-context-variant-trace-correlation** — *Context variants for trace correlation                               | **<span class="g">4/4</span>** | **<span class="r">3/4</span>**                                    |
| 5.1  | Identifies that slog.Info and slog.Error should use their *Context variants                                           | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 5.2  | Explains that without ctx, trace_id and span_id won't be injected into log records                                    | <span class="g">✓</span>       | <span class="r">✗</span> unaware of otelslog injection mechanism  |
| 5.3  | Shows the corrected code using slog.InfoContext(ctx, ...) and slog.ErrorContext(ctx, ...)                             | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 5.4  | Mentions that the otelslog bridge automatically injects trace correlation when context is passed                      | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
|      | **6. metric-naming-conventions** — base units, _total suffix, namespace                                               | **<span class="g">5/5</span>** | **<span class="g">5/5</span>**                                    |
| 6.1  | Flags request_count as missing namespace and unit suffix                                                              | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 6.2  | Flags httpDuration as using camelCase and missing unit                                                                | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 6.3  | Flags request_duration_ms — should use _seconds (base unit), not milliseconds                                         | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 6.4  | Flags myapp_request_size_kb — should use _bytes (base unit), not kilobytes                                            | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 6.5  | Flags embedding label values into metric names — should use a single metric with a method label                       | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
|      | **7. irate-vs-rate-for-alerts** — irate() is inappropriate for alerting rules                                         | **<span class="g">5/5</span>** | **<span class="r">3/5</span>**                                    |
| 7.1  | Identifies irate() as inappropriate for alerting rules                                                                | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 7.2  | Explains that irate reacts to a single scrape interval and is too volatile                                            | <span class="g">✓</span>       | <span class="r">✗</span> knows irate differs but imprecise why    |
| 7.3  | Recommends rate() instead of irate() for alerts                                                                       | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 7.4  | Recommends adding a for: duration to avoid firing on transient spikes                                                 | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 7.5  | Shows the corrected alert rule using rate() with a for: clause                                                        | <span class="g">✓</span>       | <span class="r">✗</span> shows rate() but misses error ratio      |
|      | **8. alert-missing-for-duration** — alerts without for: duration clause                                               | **<span class="g">4/4</span>** | **<span class="r">3/4</span>**                                    |
| 8.1  | Identifies the missing for: duration as a problem                                                                     | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 8.2  | Explains that without for:, a single bad scrape triggers the alert                                                    | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 8.3  | Recommends adding for: 5m or similar duration                                                                         | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 8.4  | Distinguishes that binary alerts (service up/down) can use for: 0m, but non-binary need a duration                    | <span class="g">✓</span>       | <span class="r">✗</span> generic advice, no binary distinction    |
|      | **9. promql-comments-convention** — documenting metrics with PromQL comments above declarations                       | **<span class="g">5/5</span>** | **<span class="r">0/5</span>**                                    |
| 9.1  | Recommends adding PromQL queries and alert rules as comments directly above the metric var                            | <span class="g">✓</span>       | <span class="r">✗</span> suggests wiki or README                  |
| 9.2  | Shows example Dashboard: and Alert: comment lines above the metric var                                                | <span class="g">✓</span>       | <span class="r">✗</span> no such convention known                 |
| 9.3  | Explains that this keeps PromQL queries reviewed in PRs alongside the metric                                          | <span class="g">✓</span>       | <span class="r">✗</span>                                          |
| 9.4  | Mentions that queries stay in sync with metric changes (label renames, bucket changes)                                | <span class="g">✓</span>       | <span class="r">✗</span>                                          |
| 9.5  | Notes that new team members can understand the metric's purpose at a glance                                           | <span class="g">✓</span>       | <span class="r">✗</span>                                          |
|      | **10. otelslog-bridge-setup** — log-trace correlation using otelslog bridge                                           | **<span class="g">5/5</span>** | **<span class="r">1/5</span>**                                    |
| 10.1 | Recommends using the otelslog bridge from go.opentelemetry.io/contrib/bridges/otelslog                                | <span class="g">✓</span>       | <span class="r">✗</span> suggests manual trace_id extraction      |
| 10.2 | Shows creating a handler with otelslog.NewHandler()                                                                   | <span class="g">✓</span>       | <span class="r">✗</span>                                          |
| 10.3 | Shows setting it as default with slog.SetDefault()                                                                    | <span class="g">✓</span>       | <span class="r">✗</span>                                          |
| 10.4 | Explains that trace_id and span_id are automatically injected into log records                                        | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 10.5 | Emphasizes using slog.*Context(ctx, ...) variants to enable the automatic injection                                   | <span class="g">✓</span>       | <span class="r">✗</span>                                          |
|      | **11. exemplars-metric-trace-link** — metrics-to-traces correlation via Prometheus exemplars                          | **<span class="g">3/3</span>** | **<span class="r">1/3</span>**                                    |
| 11.1 | Recommends using Prometheus exemplars to link metrics to traces                                                       | <span class="g">✓</span>       | <span class="r">✗</span> suggests manual correlation              |
| 11.2 | Shows attaching trace_id as an exemplar when recording histogram observations                                         | <span class="g">✓</span>       | <span class="r">✗</span>                                          |
| 11.3 | Explains that exemplars let you jump from a metric spike directly to the trace                                        | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
|      | **12. span-error-recording-both-calls** — RecordError() AND SetStatus(Error) required                                 | **<span class="g">4/4</span>** | **<span class="r">3/4</span>**                                    |
| 12.1 | Identifies that span.SetStatus(codes.Error, ...) is also needed alongside RecordError                                 | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 12.2 | Explains that RecordError adds an event but does not mark the span as failed                                          | <span class="g">✓</span>       | <span class="r">✗</span> may not distinguish event vs status      |
| 12.3 | Shows the corrected pattern with both span.RecordError(err) and span.SetStatus(codes.Error, ...)                      | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 12.4 | Notes that on success, no status needs to be set (Unset is fine)                                                      | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
|      | **13. otelhttp-outgoing-requests** — outgoing HTTP clients must use otelhttp transport                                | **<span class="g">4/4</span>** | **<span class="g">4/4</span>**                                    |
| 13.1 | Recommends wrapping the HTTP client transport with otelhttp.NewTransport                                              | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 13.2 | Shows the code: client := &http.Client{Transport: otelhttp.NewTransport(http.DefaultTransport)}                       | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 13.3 | Explains that this automatically propagates trace context to outgoing requests                                        | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 13.4 | Mentions that otelhttp creates child spans for outgoing HTTP calls                                                    | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
|      | **14. db-query-context-propagation** — database calls must use *Context variants                                      | **<span class="g">4/4</span>** | **<span class="g">4/4</span>**                                    |
| 14.1 | Identifies that db.Query should be db.QueryContext(ctx, ...)                                                          | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 14.2 | Explains that without context, the trace is broken                                                                    | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 14.3 | Shows the corrected code using db.QueryContext(ctx, ...)                                                              | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 14.4 | States that context is the vehicle that carries trace_id and span_id across boundaries                                | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
|      | **15. trace-sampling-cost-control** — trace sampling strategies and cost implications                                 | **<span class="g">5/5</span>** | **<span class="r">4/5</span>**                                    |
| 15.1 | Recommends TraceIDRatioBased sampling with a specific ratio (e.g., 0.1 for 10%)                                       | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 15.2 | Mentions ParentBased sampler to respect parent's sampling decision                                                    | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 15.3 | Discusses head-based vs tail-based sampling tradeoffs                                                                 | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 15.4 | Recommends avoiding large payloads as span attributes — log and correlate via trace_id                                | <span class="g">✓</span>       | <span class="r">✗</span> generic cost advice                      |
| 15.5 | Explains the cost factors: span volume, span attributes, storage and indexing                                         | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
|      | **16. where-to-add-spans** — which operations must have spans in OpenTelemetry                                        | **<span class="g">5/5</span>** | **<span class="r">4/5</span>**                                    |
| 16.1 | Lists service methods (business logic layer) as requiring spans                                                       | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 16.2 | Lists database queries as requiring spans                                                                             | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 16.3 | Lists external API calls as requiring spans                                                                           | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 16.4 | Lists message queue publish/consume operations as requiring spans                                                     | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 16.5 | States any operation that takes measurable time or could fail should have a span                                      | <span class="g">✓</span>       | <span class="r">✗</span> gives specific list, misses general rule |
|      | **17. four-golden-signals-alerting** — four golden signals for service alerting                                       | **<span class="g">5/5</span>** | **<span class="g">5/5</span>**                                    |
| 17.1 | References the four golden signals: latency, traffic, errors, saturation                                              | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 17.2 | Includes a latency alert (e.g., P99 > threshold)                                                                      | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 17.3 | Includes a traffic alert (e.g., zero requests detection)                                                              | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 17.4 | Includes an error rate alert (e.g., 5xx ratio > threshold)                                                            | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 17.5 | Includes a saturation alert (e.g., connection pool > 90%)                                                             | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
|      | **18. awesome-prometheus-alerts-resource** — awesome-prometheus-alerts as a starting point                            | **<span class="g">4/4</span>** | **<span class="r">0/4</span>**                                    |
| 18.1 | Recommends awesome-prometheus-alerts (samber.github.io/awesome-prometheus-alerts/)                                    | <span class="g">✓</span>       | <span class="r">✗</span> suggests writing rules from scratch      |
| 18.2 | Mentions it contains ~500 ready-to-use Prometheus alerting rules organized by technology                              | <span class="g">✓</span>       | <span class="r">✗</span>                                          |
| 18.3 | Suggests the workflow: browse by technology, copy rules, customize thresholds                                         | <span class="g">✓</span>       | <span class="r">✗</span>                                          |
| 18.4 | Mentions verifying that exporters (postgres_exporter, redis_exporter) are deployed                                    | <span class="g">✓</span>       | <span class="r">✗</span>                                          |
|      | **19. go-runtime-alerts** — Go runtime-specific Prometheus alerts                                                     | **<span class="g">5/5</span>** | **<span class="r">3/5</span>**                                    |
| 19.1 | Suggests alerting on go_goroutines exceeding a threshold for goroutine leaks                                          | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 19.2 | Suggests alerting on go_gc_duration_seconds for GC pressure                                                           | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 19.3 | Suggests alerting on go_memstats_alloc_bytes / go_memstats_sys_bytes for memory leaks                                 | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 19.4 | Suggests alerting on go_threads for high OS thread count                                                              | <span class="g">✓</span>       | <span class="r">✗</span> rarely includes thread alerts            |
| 19.5 | Uses for: duration on all non-binary alerts to avoid false positives                                                  | <span class="g">✓</span>       | <span class="r">✗</span> omits for: on some alerts                |
|      | **20. alert-severity-levels** — severity classification and for: durations                                            | **<span class="g">6/6</span>** | **<span class="r">4/6</span>**                                    |
| 20.1 | Uses two severity levels: critical (page on-call) and warning (create ticket)                                         | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 20.2 | Critical alerts: for: 2m to 5m for fast detection                                                                     | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 20.3 | Warning alerts: for: 10m to 30m for confirmed trends                                                                  | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 20.4 | Classifies service down as critical with short for: duration                                                          | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 20.5 | Classifies goroutine leak as warning (not critical)                                                                   | <span class="g">✓</span>       | <span class="r">✗</span> may classify as critical                 |
| 20.6 | States that for: 0m should never be used on non-binary alerts                                                         | <span class="g">✓</span>       | <span class="r">✗</span> not a widely known rule                  |
|      | **21. multi-window-burn-rate-slo** — multi-window burn-rate SLO alerting                                              | **<span class="g">5/5</span>** | **<span class="r">3/5</span>**                                    |
| 21.1 | Recommends multi-window burn-rate alerting instead of simple threshold alerts                                         | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 21.2 | Explains the concept of error budget and burn rate                                                                    | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 21.3 | Includes fast burn window (e.g., 5m + 1h, 14.4x burn rate) as critical/page                                           | <span class="g">✓</span>       | <span class="r">✗</span> generic burn rate, no specific windows   |
| 21.4 | Includes slow burn window (e.g., 2h + 24h, 1x burn rate) as warning/ticket                                            | <span class="g">✓</span>       | <span class="r">✗</span> no slow burn tier                        |
| 21.5 | Shows PromQL using AND of short and long windows to eliminate false positives                                         | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
|      | **22. slog-migration-from-zap** — incremental migration from zap to slog using bridge                                 | **<span class="g">5/5</span>** | **<span class="r">1/5</span>**                                    |
| 22.1 | Recommends a three-step migration: bridge, replace call sites, remove bridge                                          | <span class="g">✓</span>       | <span class="r">✗</span> suggests gradual replacement only        |
| 22.2 | Step 1: Use samber/slog-zap bridge handler to route slog output through zap                                           | <span class="g">✓</span>       | <span class="r">✗</span> unaware of samber/slog-zap               |
| 22.3 | Step 2: Gradually replace zap.L().Info(...) calls with slog.Info(...)                                                 | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 22.4 | Step 3: Once fully migrated, replace bridge with native slog JSONHandler and remove zap                               | <span class="g">✓</span>       | <span class="r">✗</span> no bridge step to remove                 |
| 22.5 | Mentions using parallel sub-agents for large codebase migration                                                       | <span class="g">✓</span>       | <span class="r">✗</span> not a known pattern                      |
|      | **23. slog-migration-from-logrus** — bridge handler approach for logrus migration                                     | **<span class="g">4/4</span>** | **<span class="r">2/4</span>**                                    |
| 23.1 | Recommends using samber/slog-logrus bridge handler for incremental migration                                          | <span class="g">✓</span>       | <span class="r">✗</span> unaware of samber/slog-logrus            |
| 23.2 | Explains that slog is the standard library logger since Go 1.21                                                       | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 23.3 | Shows the bridge step: route slog output through the existing logrus logger                                           | <span class="g">✓</span>       | <span class="r">✗</span>                                          |
| 23.4 | Shows the replacement: logrus.WithField becomes slog.Info                                                             | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
|      | **24. debug-level-production-cost** — log level cost implications in production                                       | **<span class="g">5/5</span>** | **<span class="r">3/5</span>**                                    |
| 24.1 | Recommends slog.LevelInfo for production, NOT Debug                                                                   | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 24.2 | Explains that Debug level can generate millions of log lines per minute in busy services                              | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 24.3 | Mentions cost: CPU for serialization, I/O for disk/network, money for log ingestion/storage                           | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 24.4 | Mentions Debug can inflate costs by 10-100x                                                                           | <span class="g">✓</span>       | <span class="r">✗</span> no specific multiplier                   |
| 24.5 | Suggests samber/slog-sampling as an alternative to sample verbose logs                                                | <span class="g">✓</span>       | <span class="r">✗</span> unaware of samber/slog-sampling          |
|      | **25. pii-in-logs-trap** — catching PII being logged                                                                  | **<span class="g">4/4</span>** | **<span class="g">4/4</span>**                                    |
| 25.1 | Flags email as PII that should not be logged                                                                          | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 25.2 | Flags SSN as PII that should absolutely never be logged                                                               | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 25.3 | Recommends logging identifiers (user_id) instead of PII                                                               | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 25.4 | Shows corrected logging using user.ID instead of email/SSN                                                            | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
|      | **26. counter-suffix-total-requirement** — Prometheus counters must use _total suffix                                 | **<span class="g">3/3</span>** | **<span class="g">3/3</span>**                                    |
| 26.1 | Identifies the missing _total suffix — counters MUST end with _total                                                  | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 26.2 | Shows the corrected name: requests_total or http_requests_total                                                       | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 26.3 | Mentions that _total is a required convention for counters in Prometheus                                              | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
|      | **27. pprof-security-auth** — pprof endpoints must be protected with authentication                                   | **<span class="g">4/4</span>** | **<span class="g">4/4</span>**                                    |
| 27.1 | Warns that pprof endpoints must NOT be exposed publicly without authentication                                        | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 27.2 | Explains that pprof leaks sensitive runtime information and can be abused for DoS                                     | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 27.3 | Recommends protecting with basic auth or running on a separate internal port                                          | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 27.4 | Suggests toggling via environment variable to enable/disable without redeployment                                     | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
|      | **28. continuous-profiling-env-toggle** — toggle continuous profiling via environment variables                       | **<span class="g">5/5</span>** | **<span class="r">2/5</span>**                                    |
| 28.1 | Recommends toggling via environment variable (e.g., PROFILING_ENABLED)                                                | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 28.2 | Mentions ~2-5% CPU overhead for continuous profiling                                                                  | <span class="g">✓</span>       | <span class="r">✗</span> no specific overhead figure              |
| 28.3 | Suggests starting with CPU + heap profiles only, adding mutex/block when needed                                       | <span class="g">✓</span>       | <span class="r">✗</span> suggests all profiles                    |
| 28.4 | For large deployments, recommends enabling on a fraction of replicas (e.g., 1 in 10)                                  | <span class="g">✓</span>       | <span class="r">✗</span> not a widely known practice              |
| 28.5 | Shows code that checks the environment variable before starting Pyroscope                                             | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
|      | **29. rum-identity-key-email-trap** — RUM distinct_id must be user_id, not email                                      | **<span class="g">5/5</span>** | **<span class="r">4/5</span>**                                    |
| 29.1 | Rejects email as the DistinctId — must use user_id instead                                                            | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 29.2 | Explains that email is mutable — users change it, splitting events into two users                                     | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 29.3 | Explains that email is PII, complicating GDPR/CCPA compliance                                                         | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 29.4 | Notes that email leaks into third-party analytics systems as the identity key                                         | <span class="g">✓</span>       | <span class="r">✗</span> not commonly considered                  |
| 29.5 | Shows corrected code using user.ID (immutable internal identifier)                                                    | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
|      | **30. gdpr-consent-before-tracking** — GDPR consent must be checked before sending events                             | **<span class="g">5/5</span>** | **<span class="r">3/5</span>**                                    |
| 30.1 | Identifies that consent must be checked before sending the tracking event                                             | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 30.2 | Shows extracting consent from context and conditionally tracking                                                      | <span class="g">✓</span>       | <span class="r">✗</span> generic consent advice without Go code   |
| 30.3 | Mentions GDPR fines (up to 4% of global revenue) or CCPA penalties                                                    | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 30.4 | References data minimization — only collect what you need                                                             | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 30.5 | Mentions data subject rights endpoints (data export and deletion)                                                     | <span class="g">✓</span>       | <span class="r">✗</span> focuses on consent only                  |
|      | **31. data-subject-rights-endpoints** — GDPR requires deletion/export across all systems                              | **<span class="g">5/5</span>** | **<span class="r">3/5</span>**                                    |
| 31.1 | States that deletion must propagate to ALL systems holding user data                                                  | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 31.2 | Lists the analytics platform (PostHog) as needing deletion                                                            | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 31.3 | Lists the CDP (Segment) as needing deletion                                                                           | <span class="g">✓</span>       | <span class="r">✗</span> may not mention CDP deletion             |
| 31.4 | References GDPR Article 17 Right to Erasure                                                                           | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 31.5 | Also mentions the Right of Access (data export endpoint) as a requirement                                             | <span class="g">✓</span>       | <span class="r">✗</span> focuses on deletion only                 |
|      | **32. five-signals-completeness** — five observability signals and their distinct roles                               | **<span class="g">6/6</span>** | **<span class="r">4/6</span>**                                    |
| 32.1 | Lists all five signals: logs, metrics, traces, profiles, and RUM                                                      | <span class="g">✓</span>       | <span class="r">✗</span> lists logs, metrics, traces only         |
| 32.2 | Associates logs with 'what happened' (discrete events, audit trails)                                                  | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 32.3 | Associates metrics with 'how much/how fast' (aggregated measurements, alerting, SLOs)                                 | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 32.4 | Associates traces with 'where did time go' (request flow across services)                                             | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 32.5 | Associates profiles with 'why is it slow/using memory' (CPU hotspots, memory leaks)                                   | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 32.6 | Associates RUM with 'how do users experience it' (product analytics, funnels)                                         | <span class="g">✓</span>       | <span class="r">✗</span> RUM not listed as a signal               |
|      | **33. definition-of-done-observability** — observability checklist before shipping a feature                          | **<span class="g">6/6</span>** | **<span class="r">4/6</span>**                                    |
| 33.1 | States that a feature is not production-ready until it is observable                                                  | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 33.2 | Checks for metric declarations (counters, histograms, gauges) with PromQL comments                                    | <span class="g">✓</span>       | <span class="r">✗</span> does not mention PromQL comments         |
| 33.3 | Checks for proper structured logging with slog and context variants                                                   | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 33.4 | Checks for OpenTelemetry spans on service methods, DB queries, and external calls                                     | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 33.5 | Checks for dashboards and alerts being wired up                                                                       | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 33.6 | Checks that errors are either logged OR returned, never both                                                          | <span class="g">✓</span>       | <span class="r">✗</span> not part of typical deploy checklist     |
|      | **34. grafana-dashboard-ids** — specific Grafana dashboard IDs for Go runtime monitoring                              | **<span class="g">4/4</span>** | **<span class="r">0/4</span>**                                    |
| 34.1 | Recommends specific Grafana dashboard IDs (21221, 6671, or 10826)                                                     | <span class="g">✓</span>       | <span class="r">✗</span> suggests building custom dashboards      |
| 34.2 | Mentions dashboard 21221 for host + runtime combined view                                                             | <span class="g">✓</span>       | <span class="r">✗</span>                                          |
| 34.3 | Explains that these dashboards use default Go collector metrics from the Prometheus client library                    | <span class="g">✓</span>       | <span class="r">✗</span>                                          |
| 34.4 | Shows how to import: Dashboards > New > Import, enter the dashboard ID                                                | <span class="g">✓</span>       | <span class="r">✗</span>                                          |
|      | **35. slog-with-request-scoped-attrs** — slog.With() for request-scoped attributes                                    | **<span class="g">4/4</span>** | **<span class="g">4/4</span>**                                    |
| 35.1 | Recommends using slog.With() to create a child logger with request-scoped attributes                                  | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 35.2 | Shows middleware pattern that creates the enriched logger                                                             | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 35.3 | Shows storing the enriched logger in context for downstream use                                                       | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 35.4 | Includes request_id, method, and path as the attributes to inject                                                     | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
|      | **36. slog-ecosystem-handlers** — slog handler ecosystem beyond stdlib                                                | **<span class="g">5/5</span>** | **<span class="r">1/5</span>**                                    |
| 36.1 | Recommends samber/slog-multi for fan-out to multiple handlers                                                         | <span class="g">✓</span>       | <span class="r">✗</span> suggests custom io.MultiWriter           |
| 36.2 | Mentions samber/slog-sentry for sending errors to Sentry                                                              | <span class="g">✓</span>       | <span class="r">✗</span>                                          |
| 36.3 | Mentions samber/slog-datadog for sending logs to Datadog                                                              | <span class="g">✓</span>       | <span class="r">✗</span>                                          |
| 36.4 | Explains that slog supports pluggable handlers                                                                        | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 36.5 | References the slog ecosystem (go.dev/wiki/Resources-for-slog or similar)                                             | <span class="g">✓</span>       | <span class="r">✗</span>                                          |
|      | **37. parallel-observability-audit** — parallel sub-agents for observability audits                                   | **<span class="g">5/5</span>** | **<span class="r">0/5</span>**                                    |
| 37.1 | Recommends using up to 5 parallel sub-agents (via the Agent tool)                                                     | <span class="g">✓</span>       | <span class="r">✗</span> suggests linear approach                 |
| 37.2 | Assigns one sub-agent per signal: metrics, logging, tracing, profiling, RUM                                           | <span class="g">✓</span>       | <span class="r">✗</span>                                          |
| 37.3 | Sub-agent for metrics: verify metric declarations and PromQL comments                                                 | <span class="g">✓</span>       | <span class="r">✗</span>                                          |
| 37.4 | Sub-agent for logging: check structured logging, PII in logs, error logging patterns                                  | <span class="g">✓</span>       | <span class="r">✗</span>                                          |
| 37.5 | Sub-agent for tracing: verify span creation in service methods, DB calls, API calls                                   | <span class="g">✓</span>       | <span class="r">✗</span>                                          |
|      | **38. predict-linear-for-saturation** — predict_linear for anticipating resource exhaustion                           | **<span class="g">4/4</span>** | **<span class="g">4/4</span>**                                    |
| 38.1 | Recommends using predict_linear() PromQL function to extrapolate trends                                               | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 38.2 | Shows expression: predict_linear(db_connections_active[15m], 600) > db_connections_max                                | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 38.3 | Explains that predict_linear extrapolates from recent trend to predict future value                                   | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 38.4 | Also suggests a threshold alert (e.g., > 90%) as a complementary alert                                                | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
|      | **39. self-hosted-rum-gdpr** — self-hosted analytics for GDPR compliance                                              | **<span class="g">4/4</span>** | **<span class="g">4/4</span>**                                    |
| 39.1 | Recommends self-hosted analytics (PostHog or Matomo) for EU data residency                                            | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 39.2 | Explains that self-hosting eliminates cross-border data transfer concerns                                             | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 39.3 | Compares self-hosted vs SaaS tradeoffs (data residency, cost, maintenance, features)                                  | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 39.4 | Mentions that PostHog can be self-hosted to keep data in your own infrastructure                                      | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
|      | **40. oops-structured-errors-tracing** — samber/oops for structured errors in tracing                                 | **<span class="g">4/4</span>** | **<span class="r">0/4</span>**                                    |
| 40.1 | Recommends samber/oops for structured errors with stack traces                                                        | <span class="g">✓</span>       | <span class="r">✗</span> suggests fmt.Errorf or manual attrs      |
| 40.2 | Shows using oops with .In(), .Code(), and .With() for structured context                                              | <span class="g">✓</span>       | <span class="r">✗</span>                                          |
| 40.3 | Explains that oops errors carry stack trace, structured context, and work with span.RecordError()                     | <span class="g">✓</span>       | <span class="r">✗</span>                                          |
| 40.4 | Mentions compatibility with errors.Is/errors.As and slog                                                              | <span class="g">✓</span>       | <span class="r">✗</span>                                          |

</details>

## `golang-performance` — v1.0.0

|             | With Skill         | Without Skill     | Delta     |
| ----------- | ------------------ | ----------------- | --------- |
| **Overall** | **272/272 (100%)** | **167/272 (61%)** | **+39pp** |

<details>
<summary>Full breakdown (272 assertions across 68 evals)</summary>

**Model:** Claude Opus 4.6 | **Grading:** Human-as-judge

| #    | Assertion                                                                                                     | With                           | Without                                                             |
| ---- | ------------------------------------------------------------------------------------------------------------- | ------------------------------ | ------------------------------------------------------------------- |
|      | **1. profile-before-optimizing** — Tests whether the model insists on profiling before applying optimizations | **<span class="g">5/5</span>** | **<span class="r">3/5</span>**                                      |
| 1.1  | Recommends profiling (pprof, fgprof, or tracing) before making code changes                                   | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 1.2  | Identifies fetchFromDB as the likely bottleneck (external I/O, not Go code)                                   | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 1.3  | Mentions that intuition about bottlenecks is often wrong (~80% of the time)                                   | <span class="g">✓</span>       | <span class="r">✗</span> no specific stat                           |
| 1.4  | Does NOT primarily focus on micro-optimizing strings.ToUpper or JSON encoding                                 | <span class="g">✓</span>       | <span class="r">✗</span> suggests strings.Builder/JSON fixes        |
| 1.5  | Suggests investigating the database query (query tuning, caching, connection pool)                            | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
|      | **2. fgprof-off-cpu-bottleneck** — Tests whether the model recommends fgprof for off-CPU bottlenecks          | **<span class="g">5/5</span>** | **<span class="r">4/5</span>**                                      |
| 2.1  | Recommends fgprof as the primary tool for capturing off-CPU wait time                                         | <span class="g">✓</span>       | <span class="r">✗</span> suggests goroutine profiles or tracing     |
| 2.2  | Explains that standard pprof CPU profile only captures on-CPU time                                            | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 2.3  | Suggests the bottleneck is likely I/O wait (network, database, filesystem)                                    | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 2.4  | Mentions goroutine profile as a complementary diagnostic                                                      | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 2.5  | Suggests distributed tracing (OpenTelemetry) for identifying slow upstream services                           | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
|      | **3. iterative-benchmark-methodology** — Tests iterative benchmark approach (one change at a time, benchstat) | **<span class="g">5/5</span>** | **<span class="r">1/5</span>**                                      |
| 3.1  | Recommends writing an atomic benchmark for ProcessRecords first                                               | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 3.2  | Recommends measuring a baseline with -benchmem and -count=6 for statistical significance                      | <span class="g">✓</span>       | <span class="r">✗</span> skips -count=6                             |
| 3.3  | Recommends applying ONE optimization at a time, not all at once                                               | <span class="g">✓</span>       | <span class="r">✗</span> applies all at once                        |
| 3.4  | Recommends using benchstat to compare before/after with statistical significance                              | <span class="g">✓</span>       | <span class="r">✗</span> no benchstat                               |
| 3.5  | Suggests keeping report files as an audit trail (e.g., /tmp/report-1.txt)                                     | <span class="g">✓</span>       | <span class="r">✗</span>                                            |
|      | **4. slice-reuse-append-zero** — Tests knowledge of append(s[:0], ...) for reusing slice backing arrays       | **<span class="g">4/4</span>** | **<span class="r">2/4</span>**                                      |
| 4.1  | Suggests using append(mode[:0], item) to reuse the backing array                                              | <span class="g">✓</span>       | <span class="r">✗</span> suggests sync.Pool or new slice            |
| 4.2  | Explains that reslicing to zero length retains the backing array                                              | <span class="g">✓</span>       | <span class="r">✗</span>                                            |
| 4.3  | Moves the mode variable declaration outside the loop to enable reuse                                          | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 4.4  | Does NOT suggest sync.Pool as the primary solution for this simple case                                       | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
|      | **5. direct-indexing-vs-append** — Tests direct indexing over append when output size equals input            | **<span class="g">3/3</span>** | **<span class="r">2/3</span>**                                      |
| 5.1  | Suggests using make([]Result, len(input)) with direct assignment result[i] = convert(...)                     | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 5.2  | Explains that direct assignment avoids per-element append overhead (bounds check, length increment)           | <span class="g">✓</span>       | <span class="r">✗</span>                                            |
| 5.3  | Notes that append is better when the result might be smaller (filtering)                                      | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
|      | **6. map-range-double-lookup** — Tests catching redundant map lookups in range loops                          | **<span class="g">2/2</span>** | **<span class="g">2/2</span>**                                      |
| 6.1  | Identifies that for k := range in { in[k] } does two map lookups per iteration                                | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 6.2  | Suggests for k, v := range in { result[k] = strconv.Itoa(v) } for single lookup                               | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
|      | **7. sentinel-errors-hot-path** — Tests preallocated sentinel errors over fmt.Errorf in hot paths             | **<span class="g">4/4</span>** | **<span class="g">4/4</span>**                                      |
| 7.1  | Converts the static error to a preallocated sentinel using errors.New at package level                        | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 7.2  | Keeps fmt.Errorf for the dynamic error that includes %d                                                       | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 7.3  | Explains that fmt.Errorf allocates on every call, while sentinels allocate once                               | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 7.4  | Does NOT convert the dynamic error to a sentinel                                                              | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
|      | **8. interface-boxing-hot-path** — Tests interface boxing allocation cost and generics fix                    | **<span class="g">4/4</span>** | **<span class="r">3/4</span>**                                      |
| 8.1  | Identifies interface boxing (any parameter) as the source of allocations                                      | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 8.2  | Suggests typed functions or generics to eliminate boxing                                                      | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 8.3  | Explains that each concrete value passed through any requires a heap allocation for boxing                    | <span class="g">✓</span>       | <span class="r">✗</span>                                            |
| 8.4  | Does NOT focus only on the type switch as the optimization target                                             | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
|      | **9. backing-array-leak-slice** — Tests backing array retention when returning a small reslice                | **<span class="g">4/4</span>** | **<span class="g">4/4</span>**                                      |
| 9.1  | Identifies that message[:32] retains the entire backing array (1-10MB)                                        | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 9.2  | Suggests using copy() to create an independent 32-byte slice                                                  | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 9.3  | Explains that the original large array cannot be GC'd while the reslice exists                                | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 9.4  | Provides correct copy-based fix: make([]byte, 32) + copy(header, message[:32])                                | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
|      | **10. substring-memory-leak** — Tests strings.Clone pattern for substring memory leaks                        | **<span class="g">3/3</span>** | **<span class="r">2/3</span>**                                      |
| 10.1 | Identifies that substrings share the backing array of the original string                                     | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 10.2 | Suggests strings.Clone(line[12:48]) to create an independent copy                                             | <span class="g">✓</span>       | <span class="r">✗</span> suggests string([]byte(s))                 |
| 10.3 | Explains that each 36-char ID retains the entire 500-2000 byte log line                                       | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
|      | **11. map-never-shrinks** — Tests Go maps never release bucket memory and compact pattern                     | **<span class="g">4/4</span>** | **<span class="g">4/4</span>**                                      |
| 11.1 | Explains that Go maps never release bucket memory when entries are deleted                                    | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 11.2 | Suggests periodically recreating the map by copying entries to a new map                                      | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 11.3 | Provides the compact pattern: make(map[K]V, len(old)) + range copy                                            | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 11.4 | Does NOT suggest that calling runtime.GC() or tuning GOGC will fix this                                       | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
|      | **12. sync-pool-rules** — Tests proper sync.Pool usage: reset, size limits, pointer pooling                   | **<span class="g">5/5</span>** | **<span class="r">2/5</span>**                                      |
| 12.1 | Identifies that HandleLargeUpload puts oversized buffers (100MB+) back into the pool                          | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 12.2 | Mentions the 32KB guideline — don't pool objects larger than ~32KB                                            | <span class="g">✓</span>       | <span class="r">✗</span> vague size advice                          |
| 12.3 | Identifies that w.Write(buf) may retain the buffer after bufPool.Put(buf)                                     | <span class="g">✓</span>       | <span class="r">✗</span>                                            |
| 12.4 | Suggests pooling pointers (*[]byte) instead of values to avoid allocation on Get                              | <span class="g">✓</span>       | <span class="r">✗</span>                                            |
| 12.5 | Recommends resetting/clearing state before Put                                                                | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
|      | **13. struct-field-alignment** — Tests struct field ordering for optimal memory layout                        | **<span class="g">5/5</span>** | **<span class="r">4/5</span>**                                      |
| 13.1 | Identifies that the struct has wasted padding bytes due to alignment                                          | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 13.2 | Suggests reordering fields from largest to smallest                                                           | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 13.3 | Provides a reordered struct that is smaller than the original                                                 | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 13.4 | Mentions the fieldalignment tool for automated detection                                                      | <span class="g">✓</span>       | <span class="r">✗</span>                                            |
| 13.5 | States alignment requirements (bool=1, int32=4, int64/float64=8)                                              | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
|      | **14. zero-size-field-end-of-struct** — Tests struct{} at end of struct adds word-sized padding               | **<span class="g">4/4</span>** | **<span class="r">0/4</span>**                                      |
| 14.1 | Explains that a zero-size field at the end of a struct causes word-sized padding                              | <span class="g">✓</span>       | <span class="r">✗</span>                                            |
| 14.2 | Explains the reason: preventing pointer overlap with next memory block                                        | <span class="g">✓</span>       | <span class="r">✗</span>                                            |
| 14.3 | Suggests moving struct{} to the beginning of the struct                                                       | <span class="g">✓</span>       | <span class="r">✗</span>                                            |
| 14.4 | Shows the fix: type Entry struct { Flag struct{}; Value int64 } = 8 bytes                                     | <span class="g">✓</span>       | <span class="r">✗</span>                                            |
|      | **15. map-pointer-vs-value-tradeoff** — Tests map[K]*V vs map[K]V tradeoff for large structs                  | **<span class="g">5/5</span>** | **<span class="r">3/5</span>**                                      |
| 15.1 | Suggests using map[string]*Player to allow direct field modification                                          | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 15.2 | Explains that map values are not addressable                                                                  | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 15.3 | Shows players[id].Score += delta with pointer map                                                             | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 15.4 | Mentions the tradeoff: pointer maps add GC pressure from separate heap allocations                            | <span class="g">✓</span>       | <span class="r">✗</span> no GC tradeoff                             |
| 15.5 | Notes that for small, mostly-read structs, map[K]V (value) is better                                          | <span class="g">✓</span>       | <span class="r">✗</span>                                            |
|      | **16. inlining-log-in-hot-path** — Tests that log calls prevent function inlining                             | **<span class="g">4/4</span>** | **<span class="r">2/4</span>**                                      |
| 16.1 | Identifies that log calls prevent the function from being inlined                                             | <span class="g">✓</span>       | <span class="r">✗</span> focuses on formatting cost                 |
| 16.2 | Suggests removing log calls from the hot-path function                                                        | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 16.3 | Mentions using go build -gcflags="-m" to verify inlining decisions                                            | <span class="g">✓</span>       | <span class="r">✗</span>                                            |
| 16.4 | Explains that function call overhead matters when called millions of times                                    | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
|      | **17. value-receiver-inlining** — Tests value receivers enable inlining for fluent chains                     | **<span class="g">4/4</span>** | **<span class="r">0/4</span>**                                      |
| 17.1 | Suggests changing to value receivers instead of pointer receivers                                             | <span class="g">✓</span>       | <span class="r">✗</span>                                            |
| 17.2 | Explains that value receivers allow the compiler to inline the fluent chain                                   | <span class="g">✓</span>       | <span class="r">✗</span>                                            |
| 17.3 | Explains that pointer receivers add indirection that blocks inlining                                          | <span class="g">✓</span>       | <span class="r">✗</span>                                            |
| 17.4 | Shows the value receiver signature: func (c Config) WithTimeout(d time.Duration) Config                       | <span class="g">✓</span>       | <span class="r">✗</span>                                            |
|      | **18. cache-locality-matrix-traversal** — Tests row-major vs column-major traversal and cache effects         | **<span class="g">5/5</span>** | **<span class="r">4/5</span>**                                      |
| 18.1 | Identifies the column-first traversal as the cause (cache misses)                                             | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 18.2 | Explains that Go stores 2D arrays in row-major order                                                          | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 18.3 | Suggests swapping loop order to row-first                                                                     | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 18.4 | Mentions the performance difference from cache effects (10-50x or similar)                                    | <span class="g">✓</span>       | <span class="r">✗</span> says "significant" without quantifying     |
| 18.5 | Does NOT primarily suggest parallelism or SIMD as the first fix                                               | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
|      | **19. contiguous-2d-allocation** — Tests contiguous 2D allocation for cache-friendly matrix access            | **<span class="g">4/4</span>** | **<span class="g">4/4</span>**                                      |
| 19.1 | Identifies that per-row allocation scatters data across the heap                                              | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 19.2 | Suggests single contiguous allocation: make([]float64, rows*cols)                                             | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 19.3 | Shows slicing the contiguous array into row views: data[i*cols : (i+1)*cols]                                  | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 19.4 | Explains that contiguous memory improves cache locality                                                       | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
|      | **20. soa-vs-aos** — Tests Struct of Arrays vs Array of Structs for single-field iteration                    | **<span class="g">4/4</span>** | **<span class="r">1/4</span>**                                      |
| 20.1 | Identifies that loading entire Particle structs wastes cache space when only X is needed                      | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 20.2 | Suggests Struct of Arrays (SoA) layout with separate slices                                                   | <span class="g">✓</span>       | <span class="r">✗</span> suggests parallelism                       |
| 20.3 | Explains cache utilization improvement (contiguous X values vs scattered)                                     | <span class="g">✓</span>       | <span class="r">✗</span>                                            |
| 20.4 | Notes that AoS is fine when accessing all fields together or for small structs                                | <span class="g">✓</span>       | <span class="r">✗</span>                                            |
|      | **21. false-sharing-concurrent-counters** — Tests false sharing and cache-line padding                        | **<span class="g">5/5</span>** | **<span class="r">0/5</span>**                                      |
| 21.1 | Identifies false sharing as the cause (fields share same cache line)                                          | <span class="g">✓</span>       | <span class="r">✗</span> suggests mutex or sharding                 |
| 21.2 | Explains that writes to one field invalidate the cache line for other cores                                   | <span class="g">✓</span>       | <span class="r">✗</span>                                            |
| 21.3 | Suggests cache-line padding (56-byte array between fields)                                                    | <span class="g">✓</span>       | <span class="r">✗</span>                                            |
| 21.4 | Mentions the 64-byte cache line size                                                                          | <span class="g">✓</span>       | <span class="r">✗</span>                                            |
| 21.5 | Notes this should only be applied when profiling confirms contention                                          | <span class="g">✓</span>       | <span class="r">✗</span>                                            |
|      | **22. ilp-multi-accumulator** — Tests instruction-level parallelism with multiple accumulators                | **<span class="g">5/5</span>** | **<span class="r">0/5</span>**                                      |
| 22.1 | Identifies the sequential dependency chain as the bottleneck                                                  | <span class="g">✓</span>       | <span class="r">✗</span> suggests goroutines or SIMD                |
| 22.2 | Suggests using multiple accumulators (e.g., 4) for ILP                                                        | <span class="g">✓</span>       | <span class="r">✗</span>                                            |
| 22.3 | Shows code with 4 independent accumulators summing every 4th element                                          | <span class="g">✓</span>       | <span class="r">✗</span>                                            |
| 22.4 | Handles the remainder elements (when len(data) is not divisible by 4)                                         | <span class="g">✓</span>       | <span class="r">✗</span>                                            |
| 22.5 | Mentions expected 2-4x improvement from ILP                                                                   | <span class="g">✓</span>       | <span class="r">✗</span>                                            |
|      | **23. index-based-tree-cache-locality** — Tests index-based vs pointer-based data structures                  | **<span class="g">4/4</span>** | **<span class="g">4/4</span>**                                      |
| 23.1 | Recommends Option B (index-based) for better cache locality                                                   | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 23.2 | Explains that pointer-based nodes are scattered across the heap                                               | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 23.3 | Explains that index-based nodes are stored in a contiguous array                                              | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 23.4 | Mentions CPU cache lines or memory prefetching                                                                | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
|      | **24. tight-loop-scheduler-starvation** — Tests tight CPU loops starving the Go scheduler                     | **<span class="g">5/5</span>** | **<span class="r">2/5</span>**                                      |
| 24.1 | Explains that tight CPU loops with inlined operations can delay scheduler preemption                          | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 24.2 | Suggests breaking work into batches processed by a non-inlined function call                                  | <span class="g">✓</span>       | <span class="r">✗</span> suggests runtime.Gosched()                 |
| 24.3 | Mentions //go:noinline as an option to force preemption points                                                | <span class="g">✓</span>       | <span class="r">✗</span>                                            |
| 24.4 | Explains the tradeoff: //go:noinline adds overhead but ensures scheduler fairness                             | <span class="g">✓</span>       | <span class="r">✗</span>                                            |
| 24.5 | Mentions that Go 1.14+ has async preemption but tight loops can still cause issues                            | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
|      | **25. reflect-deepequal-performance** — Tests reflect.DeepEqual 50-200x slower than typed comparison          | **<span class="g">4/4</span>** | **<span class="r">2/4</span>**                                      |
| 25.1 | Identifies reflect.DeepEqual as 50-200x slower than typed comparison                                          | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 25.2 | Suggests using slices.Equal for the Hosts field                                                               | <span class="g">✓</span>       | <span class="r">✗</span> uses manual loop                           |
| 25.3 | Suggests using maps.Equal for the Settings field                                                              | <span class="g">✓</span>       | <span class="r">✗</span>                                            |
| 25.4 | Provides a hand-written typed comparison function                                                             | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
|      | **26. type-switch-vs-repeated-assertions** — Tests type switch dispatches in one evaluation                   | **<span class="g">3/3</span>** | **<span class="g">3/3</span>**                                      |
| 26.1 | Suggests replacing repeated type assertions with a type switch                                                | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 26.2 | Explains that a type switch dispatches in a single evaluation                                                 | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 26.3 | Shows the switch v := v.(type) { case string: ... } pattern                                                   | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
|      | **27. http-transport-maxidleconnsperhost** — Tests default MaxIdleConnsPerHost=2 gotcha                       | **<span class="g">5/5</span>** | **<span class="r">3/5</span>**                                      |
| 27.1 | Identifies MaxIdleConnsPerHost defaulting to 2 as the root cause                                              | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 27.2 | Suggests configuring http.Transport with higher MaxIdleConnsPerHost                                           | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 27.3 | Shows complete Transport configuration with MaxIdleConns, MaxIdleConnsPerHost, MaxConnsPerHost                | <span class="g">✓</span>       | <span class="r">✗</span> only sets MaxIdleConnsPerHost              |
| 27.4 | Mentions draining resp.Body for connection reuse (io.Copy to io.Discard)                                      | <span class="g">✓</span>       | <span class="r">✗</span>                                            |
| 27.5 | Does NOT suggest a third-party connection pool library as the primary solution                                | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
|      | **28. response-body-drain** — Tests HTTP connections only reused when body fully read                         | **<span class="g">3/3</span>** | **<span class="g">3/3</span>**                                      |
| 28.1 | Identifies that the response body is not being fully read/drained                                             | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 28.2 | Explains that connections are only reused when the body is fully consumed                                     | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 28.3 | Suggests adding io.Copy(io.Discard, resp.Body)                                                                | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
|      | **29. streaming-vs-readall** — Tests streaming vs buffering for large payloads                                | **<span class="g">4/4</span>** | **<span class="r">3/4</span>**                                      |
| 29.1 | Identifies io.ReadAll as the cause of OOM                                                                     | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 29.2 | Suggests using io.Copy(w, resp.Body) to stream with constant memory                                           | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 29.3 | Mentions the 32KB internal buffer of io.Copy                                                                  | <span class="g">✓</span>       | <span class="r">✗</span>                                            |
| 29.4 | Notes that io.ReadAll is fine for small, bounded payloads (< 1MB)                                             | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
|      | **30. json-streaming-decoder** — Tests json.NewDecoder for streaming large JSON payloads                      | **<span class="g">3/3</span>** | **<span class="r">2/3</span>**                                      |
| 30.1 | Suggests using json.NewDecoder with r.Body directly                                                           | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 30.2 | Shows the dec.More() + dec.Decode(&item) streaming pattern                                                    | <span class="g">✓</span>       | <span class="r">✗</span>                                            |
| 30.3 | Explains that this processes one item at a time with O(1) memory per item                                     | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
|      | **31. cgo-overhead-tight-loop** — Tests cgo call overhead (~50-100ns) and batching strategy                   | **<span class="g">4/4</span>** | **<span class="r">2/4</span>**                                      |
| 31.1 | Identifies cgo overhead (~50-100ns per call) as the bottleneck                                                | <span class="g">✓</span>       | <span class="r">✗</span> says "overhead" without quantifying        |
| 31.2 | Suggests using math.Sqrt (pure Go, inlineable) instead of C.sqrt                                              | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 31.3 | For unavoidable C code, suggests batching: pass entire array to C in one call                                 | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 31.4 | Mentions that goroutine is pinned to OS thread during cgo calls                                               | <span class="g">✓</span>       | <span class="r">✗</span>                                            |
|      | **32. gogc-gomemlimit-container** — Tests GOMEMLIMIT for containerized applications                           | **<span class="g">5/5</span>** | **<span class="r">3/5</span>**                                      |
| 32.1 | Recommends setting GOMEMLIMIT to 80-90% of container memory (400-450MiB)                                      | <span class="g">✓</span>       | <span class="r">✗</span> suggests GOMEMLIMIT without ratio          |
| 32.2 | Explains that the GC needs GOMEMLIMIT to know about the container ceiling                                     | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 32.3 | Shows the GOMEMLIMIT=450MiB environment variable or debug.SetMemoryLimit                                      | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 32.4 | Explains the gap (goroutine stacks, OS buffers, non-heap memory)                                              | <span class="g">✓</span>       | <span class="r">✗</span>                                            |
| 32.5 | Does NOT recommend the ballast pattern (obsolete since Go 1.19)                                               | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
|      | **33. ballast-pattern-obsolete** — Tests GOMEMLIMIT over ballast pattern                                      | **<span class="g">4/4</span>** | **<span class="g">4/4</span>**                                      |
| 33.1 | Identifies the ballast pattern as obsolete since Go 1.19                                                      | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 33.2 | Recommends GOMEMLIMIT as the replacement                                                                      | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 33.3 | Explains that GOMEMLIMIT provides the same benefit without wasting physical memory                            | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 33.4 | Shows the GOMEMLIMIT environment variable or debug.SetMemoryLimit call                                        | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
|      | **34. gomaxprocs-container-go125** — Tests Go 1.25+ container-aware GOMAXPROCS vs automaxprocs                | **<span class="g">4/4</span>** | **<span class="r">1/4</span>**                                      |
| 34.1 | States that Go 1.25+ automatically detects container CPU limits                                               | <span class="g">✓</span>       | <span class="r">✗</span>                                            |
| 34.2 | Recommends removing the automaxprocs dependency                                                               | <span class="g">✓</span>       | <span class="r">✗</span> keeps automaxprocs                         |
| 34.3 | Mentions that automaxprocs IS needed for Go 1.24 and earlier                                                  | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 34.4 | Mentions cgroup CPU quota detection as the mechanism                                                          | <span class="g">✓</span>       | <span class="r">✗</span>                                            |
|      | **35. pgo-workflow** — Tests PGO workflow and expected gains                                                  | **<span class="g">5/5</span>** | **<span class="r">3/5</span>**                                      |
| 35.1 | Recommends Profile-Guided Optimization (PGO)                                                                  | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 35.2 | Describes the workflow: collect profile, save as default.pgo, rebuild                                         | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 35.3 | Mentions expected improvement of 2-7%                                                                         | <span class="g">✓</span>       | <span class="r">✗</span> no quantification                          |
| 35.4 | Explains PGO benefits: aggressive inlining and devirtualization                                               | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 35.5 | Notes that profiles should be refreshed after significant code changes                                        | <span class="g">✓</span>       | <span class="r">✗</span>                                            |
|      | **36. slog-logattrs-hot-path** — Tests slog.LogAttrs for zero-allocation logging                              | **<span class="g">4/4</span>** | **<span class="r">1/4</span>**                                      |
| 36.1 | Explains that log arguments are evaluated/boxed before the level check                                        | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 36.2 | Recommends slog.LogAttrs for zero allocations when level is disabled                                          | <span class="g">✓</span>       | <span class="r">✗</span> suggests level check guard                 |
| 36.3 | Shows typed attributes: slog.Int("id", item.ID), slog.String("name", item.Name)                               | <span class="g">✓</span>       | <span class="r">✗</span>                                            |
| 36.4 | Notes that slog.Any can still allocate, so typed attributes are preferred                                     | <span class="g">✓</span>       | <span class="r">✗</span>                                            |
|      | **37. regexp-compile-per-call** — Tests compiled pattern caching vs per-call compilation                      | **<span class="g">4/4</span>** | **<span class="r">3/4</span>**                                      |
| 37.1 | Identifies that regexp compilation happens on every call (~5,700ns per compile)                               | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 37.2 | Suggests moving regexp.MustCompile to package-level variables                                                 | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 37.3 | Notes that compiled regexps are safe for concurrent use                                                       | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 37.4 | Quantifies the waste (10-12x overhead from recompilation vs match-only)                                       | <span class="g">✓</span>       | <span class="r">✗</span>                                            |
|      | **38. singleflight-cache-stampede** — Tests singleflight for cache stampede prevention                        | **<span class="g">4/4</span>** | **<span class="g">4/4</span>**                                      |
| 38.1 | Identifies this as a cache stampede problem                                                                   | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 38.2 | Recommends golang.org/x/sync/singleflight.Group                                                               | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 38.3 | Shows sf.Do(key, func) pattern                                                                                | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 38.4 | Does NOT suggest a global mutex as the primary solution                                                       | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
|      | **39. algorithmic-complexity-slice-contains-loop** — Tests O(n*m) from slices.Contains in loop                | **<span class="g">4/4</span>** | **<span class="r">3/4</span>**                                      |
| 39.1 | Identifies O(n*m) complexity from slices.Contains inside a loop                                               | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 39.2 | Suggests building a map[string]struct{} from the valid slice first                                            | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 39.3 | Shows the O(n+m) solution with map lookup                                                                     | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 39.4 | Uses struct{} (0 bytes) for the map value type, not bool                                                      | <span class="g">✓</span>       | <span class="r">✗</span> uses bool                                  |
|      | **40. early-return-full-scan** — Tests early returns to avoid full collection scans                           | **<span class="g">3/3</span>** | **<span class="g">3/3</span>**                                      |
| 40.1 | Identifies that the function always scans the full collection                                                 | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 40.2 | Adds an early return when the first expired session is found                                                  | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 40.3 | Removes the found variable in favor of direct returns                                                         | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
|      | **41. iterator-chain-vs-direct-loop** — Tests iterator chains create closure overhead                         | **<span class="g">4/4</span>** | **<span class="g">4/4</span>**                                      |
| 41.1 | Recommends Option B (direct loop) for performance                                                             | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 41.2 | Explains that iterator chains create closures and intermediate allocations                                    | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 41.3 | Notes that Filter processes ALL elements before First can pick one                                            | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 41.4 | Acknowledges that iterator chains are fine for non-hot paths                                                  | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
|      | **42. indirect-function-calls-closure** — Tests closure indirection prevents inlining                         | **<span class="g">4/4</span>** | **<span class="r">2/4</span>**                                      |
| 42.1 | Suggests replacing the Map+closure pattern with a direct loop                                                 | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 42.2 | Explains that the closure/function call indirection prevents inlining                                         | <span class="g">✓</span>       | <span class="r">✗</span>                                            |
| 42.3 | Shows the direct loop: result[i] = *ptrs[i]                                                                   | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 42.4 | Mentions the expected improvement range (13-17%)                                                              | <span class="g">✓</span>       | <span class="r">✗</span>                                            |
|      | **43. http-server-no-timeouts** — Tests zero-value http.Server has NO timeouts                                | **<span class="g">4/4</span>** | **<span class="g">4/4</span>**                                      |
| 43.1 | Identifies that the default http.Server has NO timeouts                                                       | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 43.2 | Mentions Slowloris attack or slow client holding connections indefinitely                                     | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 43.3 | Suggests setting ReadTimeout, WriteTimeout, and IdleTimeout                                                   | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 43.4 | Shows creating an explicit http.Server struct with timeout values                                             | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
|      | **44. http-keepalive-crawler** — Tests disabling keep-alive for crawlers                                      | **<span class="g">3/3</span>** | **<span class="r">1/3</span>**                                      |
| 44.1 | Identifies that idle connections accumulate across many different hosts                                       | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 44.2 | Suggests DisableKeepAlives: true for the crawler client                                                       | <span class="g">✓</span>       | <span class="r">✗</span> lowers MaxIdleConnsPerHost instead         |
| 44.3 | Explains that keep-alive is counterproductive for many unique hosts                                           | <span class="g">✓</span>       | <span class="r">✗</span>                                            |
|      | **45. buffered-io-syscall-reduction** — Tests bufio for reducing syscall count                                | **<span class="g">4/4</span>** | **<span class="g">4/4</span>**                                      |
| 45.1 | Identifies that each WriteString issues a separate syscall                                                    | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 45.2 | Suggests using bufio.NewWriter(f) to batch writes                                                             | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 45.3 | Includes w.Flush() at the end                                                                                 | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 45.4 | Does NOT primarily suggest strings.Builder                                                                    | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
|      | **46. concurrent-pipeline-when-not-to-use** — Tests when concurrent pipelines are NOT beneficial              | **<span class="g">5/5</span>** | **<span class="r">1/5</span>**                                      |
| 46.1 | Recommends AGAINST concurrent pipelines for this case                                                         | <span class="g">✓</span>       | <span class="r">✗</span> recommends concurrency                     |
| 46.2 | Explains that all three stages compete for the same resource (CPU)                                            | <span class="g">✓</span>       | <span class="r">✗</span>                                            |
| 46.3 | Notes that concurrency only helps when stages saturate DIFFERENT resources                                    | <span class="g">✓</span>       | <span class="r">✗</span>                                            |
| 46.4 | Mentions context-switching overhead as a cost                                                                 | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 46.5 | Suggests sequential processing or batching as simpler alternative                                             | <span class="g">✓</span>       | <span class="r">✗</span>                                            |
|      | **47. batch-db-inserts** — Tests batch database inserts vs row-by-row                                         | **<span class="g">5/5</span>** | **<span class="g">5/5</span>**                                      |
| 47.1 | Identifies individual inserts as the problem (50K round-trips)                                                | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 47.2 | Suggests batch inserts (multi-row VALUES or COPY protocol)                                                    | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 47.3 | Shows a batching pattern with configurable batch size                                                         | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 47.4 | Wraps batches in transactions for atomicity                                                                   | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 47.5 | Does NOT suggest only connection pooling or prepared statements                                               | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
|      | **48. panic-recover-control-flow** — Tests panic/recover not for control flow                                 | **<span class="g">4/4</span>** | **<span class="r">3/4</span>**                                      |
| 48.1 | Identifies that panic/recover is unnecessary since strconv.Atoi returns errors                                | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 48.2 | Explains that panic allocates a stack trace and unwinds the stack (10-100x overhead)                          | <span class="g">✓</span>       | <span class="r">✗</span> says "overhead" without quantifying        |
| 48.3 | Suggests using simple error checking: v, err := strconv.Atoi(s)                                               | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 48.4 | States that panic/recover should only be used for truly unrecoverable situations                              | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
|      | **49. monotonic-time-since** — Tests time.Since monotonic clock for elapsed time                              | **<span class="g">3/3</span>** | **<span class="g">3/3</span>**                                      |
| 49.1 | Suggests using time.Since(start) for elapsed time measurement                                                 | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 49.2 | Explains that time.Since uses the monotonic clock                                                             | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 49.3 | Notes that time.Now() already captures monotonic time for Sub() operations                                    | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
|      | **50. prometheus-gc-pressure-queries** — Tests specific PromQL queries for GC pressure                        | **<span class="g">4/4</span>** | **<span class="r">0/4</span>**                                      |
| 50.1 | Provides rate(go_gc_duration_seconds_count[5m]) for GC frequency                                              | <span class="g">✓</span>       | <span class="r">✗</span> generic approach                           |
| 50.2 | Provides go_gc_duration_seconds{quantile="1"} for worst-case GC pause                                         | <span class="g">✓</span>       | <span class="r">✗</span>                                            |
| 50.3 | Mentions >2 cycles/s sustained as a signal of excessive allocation rate                                       | <span class="g">✓</span>       | <span class="r">✗</span>                                            |
| 50.4 | Suggests rate(go_memstats_alloc_bytes_total[5m]) for allocation rate                                          | <span class="g">✓</span>       | <span class="r">✗</span>                                            |
|      | **51. goroutine-leak-prometheus** — Tests PromQL for detecting goroutine leaks                                | **<span class="g">3/3</span>** | **<span class="r">2/3</span>**                                      |
| 51.1 | Provides go_goroutines metric for goroutine count monitoring                                                  | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 51.2 | Suggests delta(go_goroutines[1h]) for detecting net goroutine increase                                        | <span class="g">✓</span>       | <span class="r">✗</span>                                            |
| 51.3 | Notes that goroutine count should correlate with load                                                         | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
|      | **52. continuous-profiling-tools** — Tests continuous profiling tools and tradeoffs                           | **<span class="g">5/5</span>** | **<span class="r">2/5</span>**                                      |
| 52.1 | Recommends Grafana Pyroscope, Parca, or similar platform                                                      | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 52.2 | Mentions overhead estimates (1-5% range)                                                                      | <span class="g">✓</span>       | <span class="r">✗</span>                                            |
| 52.3 | Describes push vs pull collection modes                                                                       | <span class="g">✓</span>       | <span class="r">✗</span>                                            |
| 52.4 | Mentions historical flamegraph comparison as a key feature                                                    | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 52.5 | Suggests feeding profiles into PGO for build optimization                                                     | <span class="g">✓</span>       | <span class="r">✗</span>                                            |
|      | **53. gogc-high-vs-low-tradeoff** — Tests GOGC tuning tradeoffs (latency vs throughput)                       | **<span class="g">4/4</span>** | **<span class="g">4/4</span>**                                      |
| 53.1 | Recommends lower GOGC (e.g., 50) for Service A (latency-sensitive)                                            | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 53.2 | Recommends higher GOGC (e.g., 200) for Service B (throughput-oriented)                                        | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 53.3 | Explains the tradeoff: lower GOGC = more frequent but shorter pauses                                          | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 53.4 | Explains the tradeoff: higher GOGC = less frequent GC but more memory                                         | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
|      | **54. godebug-gctrace** — Tests GODEBUG=gctrace=1 output interpretation                                       | **<span class="g">5/5</span>** | **<span class="r">3/5</span>**                                      |
| 54.1 | Correctly identifies gc 142 as the 142nd GC cycle                                                             | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 54.2 | Identifies 12% as total CPU time spent in GC (which is high)                                                  | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 54.3 | Interprets 180->340->200 MB as heap before, peak during, and after collection                                 | <span class="g">✓</span>       | <span class="r">✗</span> misparses the three values                 |
| 54.4 | Identifies 400 MB goal as the target heap size based on GOGC/GOMEMLIMIT                                       | <span class="g">✓</span>       | <span class="r">✗</span>                                            |
| 54.5 | Notes that 12% GC CPU is concerning                                                                           | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
|      | **55. unsafe-without-benchmark-proof** — Tests warning against premature unsafe usage                         | **<span class="g">4/4</span>** | **<span class="r">3/4</span>**                                      |
| 55.1 | Recommends against using unsafe here                                                                          | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 55.2 | Notes that 100 req/s is not a hot path                                                                        | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 55.3 | States that unsafe requires benchmark proof showing >10% improvement                                          | <span class="g">✓</span>       | <span class="r">✗</span> no specific threshold                      |
| 55.4 | Mentions safety risks of unsafe                                                                               | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
|      | **56. precomputed-lookup-table** — Tests precomputed lookup tables for pure functions                         | **<span class="g">3/3</span>** | **<span class="r">2/3</span>**                                      |
| 56.1 | Suggests a precomputed lookup table (var hexDigit = [16]byte{...})                                            | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 56.2 | Shows the table lookup: hexDigit[b>>4], hexDigit[b&0x0f]                                                      | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 56.3 | Explains that the lookup table fits in L1 cache and is faster than branching                                  | <span class="g">✓</span>       | <span class="r">✗</span> says "faster" without L1 cache explanation |
|      | **57. json-performance-alternatives** — Tests JSON performance alternatives                                   | **<span class="g">5/5</span>** | **<span class="r">4/5</span>**                                      |
| 57.1 | Mentions custom MarshalJSON/UnmarshalJSON methods                                                             | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 57.2 | Mentions code-generation libraries (easyjson, ffjson)                                                         | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 57.3 | Mentions drop-in replacement libraries (goccy/go-json, json-iterator, sonic)                                  | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 57.4 | Explains that encoding/json uses reflection                                                                   | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 57.5 | Quantifies expected improvement (2-5x or similar)                                                             | <span class="g">✓</span>       | <span class="r">✗</span>                                            |
|      | **58. channel-batch-processing** — Tests batch processing from channels with timeout flush                    | **<span class="g">5/5</span>** | **<span class="r">4/5</span>**                                      |
| 58.1 | Uses select with both channel receive and ticker/timer for timeout                                            | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 58.2 | Flushes on batch size threshold                                                                               | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 58.3 | Flushes on timeout (ticker)                                                                                   | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 58.4 | Handles channel close (flushes remaining items)                                                               | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 58.5 | Reuses the batch slice (batch[:0]) to reduce allocations                                                      | <span class="g">✓</span>       | <span class="r">✗</span> re-allocates                               |
|      | **59. allocation-reduction-vs-gc-tuning** — Tests that reducing allocations beats GOGC tuning                 | **<span class="g">4/4</span>** | **<span class="r">1/4</span>**                                      |
| 59.1 | Recommends reducing allocations as the primary approach over GOGC tuning                                      | <span class="g">✓</span>       | <span class="r">✗</span> suggests GOGC tuning first                 |
| 59.2 | Explains that GOGC tuning manages the symptom while allocation reduction addresses root cause                 | <span class="g">✓</span>       | <span class="r">✗</span>                                            |
| 59.3 | Suggests specific allocation reduction strategies                                                             | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 59.4 | Acknowledges GOGC tuning as a secondary measure after allocation reduction                                    | <span class="g">✓</span>       | <span class="r">✗</span>                                            |
|      | **60. gctrace-key-fields** — Tests what to monitor in GC traces                                               | **<span class="g">4/4</span>** | **<span class="r">2/4</span>**                                      |
| 60.1 | Mentions high GC frequency as a signal of too many allocations                                                | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 60.2 | Mentions high pause times as a signal of large heap or many pointers                                          | <span class="g">✓</span>       | <span class="r">✗</span>                                            |
| 60.3 | Mentions high GC CPU% (>5%) as concerning                                                                     | <span class="g">✓</span>       | <span class="r">✗</span>                                            |
| 60.4 | Provides the GODEBUG=gctrace=1 command                                                                        | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
|      | **61. non-go-memory-leak-detection** — Tests detecting non-Go memory leaks via Prometheus                     | **<span class="g">4/4</span>** | **<span class="r">2/4</span>**                                      |
| 61.1 | Suggests process_resident_memory_bytes - go_memstats_sys_bytes to isolate non-Go memory                       | <span class="g">✓</span>       | <span class="r">✗</span>                                            |
| 61.2 | Identifies this as a likely C/cgo memory leak                                                                 | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 61.3 | Explains that growing gap between RSS and Go sys bytes indicates non-Go memory growth                         | <span class="g">✓</span>       | <span class="r">✗</span>                                            |
| 61.4 | Suggests C-level memory profiling tools (valgrind, AddressSanitizer)                                          | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
|      | **62. cpu-saturation-prometheus** — Tests detecting CPU saturation via Prometheus                             | **<span class="g">3/3</span>** | **<span class="r">1/3</span>**                                      |
| 62.1 | Provides rate(process_cpu_seconds_total[5m]) for CPU cores consumed                                           | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 62.2 | Divides by GOMAXPROCS to get utilization ratio                                                                | <span class="g">✓</span>       | <span class="r">✗</span>                                            |
| 62.3 | States that >0.8 sustained indicates CPU saturation                                                           | <span class="g">✓</span>       | <span class="r">✗</span>                                            |
|      | **63. document-optimizations** — Tests recommending documentation of optimizations                            | **<span class="g">3/3</span>** | **<span class="r">2/3</span>**                                      |
| 63.1 | Strongly recommends adding comments explaining WHY the optimization was made                                  | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 63.2 | Suggests including benchmark numbers in the comments                                                          | <span class="g">✓</span>       | <span class="r">✗</span>                                            |
| 63.3 | Explains that future readers may revert optimizations they don't understand                                   | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
|      | **64. lru-cache-freelru** — Tests high-performance LRU cache alternatives                                     | **<span class="g">3/3</span>** | **<span class="r">0/3</span>**                                      |
| 64.1 | Notes that container/list has poor cache locality (separate heap allocation per node)                         | <span class="g">✓</span>       | <span class="r">✗</span>                                            |
| 64.2 | Recommends elastic/go-freelru or hashicorp/golang-lru as alternatives                                         | <span class="g">✓</span>       | <span class="r">✗</span>                                            |
| 64.3 | Mentions the performance advantage of contiguous memory layouts for LRU                                       | <span class="g">✓</span>       | <span class="r">✗</span>                                            |
|      | **65. simd-when-not-worth** — Tests when SIMD is NOT worth pursuing                                           | **<span class="g">4/4</span>** | **<span class="g">4/4</span>**                                      |
| 65.1 | Recommends against SIMD for this case                                                                         | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 65.2 | Explains that the bottleneck is allocations/GC, not CPU-bound computation                                     | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 65.3 | States that SIMD only helps CPU-bound numeric inner loops                                                     | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 65.4 | Suggests reducing allocations as the correct approach                                                         | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
|      | **66. set-map-struct-zero-size** — Tests struct{} vs bool for set maps                                        | **<span class="g">2/2</span>** | **<span class="g">2/2</span>**                                      |
| 66.1 | Recommends struct{} for set maps                                                                              | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 66.2 | Explains that struct{} is 0 bytes vs bool at 1 byte per entry                                                 | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
|      | **67. regression-detection-prometheus** — Tests PromQL for deployment regression detection                    | **<span class="g">3/3</span>** | **<span class="r">2/3</span>**                                      |
| 67.1 | Suggests comparing rate(go_memstats_alloc_bytes_total[5m]) before/after deploy                                | <span class="g">✓</span>       | <span class="r">✗</span>                                            |
| 67.2 | Suggests monitoring p99 latency histogram_quantile for increase after deploy                                  | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
| 67.3 | Mentions comparing metrics between old and new deployment versions                                            | <span class="g">✓</span>       | <span class="g">✓</span>                                            |
|      | **68. statsviz-development-profiling** — Tests real-time development visualization tools                      | **<span class="g">3/3</span>** | **<span class="r">0/3</span>**                                      |
| 68.1 | Recommends statsviz (github.com/arl/statsviz) for real-time browser visualization                             | <span class="g">✓</span>       | <span class="r">✗</span> suggests pprof web UI                      |
| 68.2 | Mentions the /debug/statsviz endpoint or statsviz.Register pattern                                            | <span class="g">✓</span>       | <span class="r">✗</span>                                            |
| 68.3 | Notes that it shows heap, GC pauses, goroutines, and scheduler in real-time                                   | <span class="g">✓</span>       | <span class="r">✗</span>                                            |

</details>

## `golang-troubleshooting` — v1.0.0

|             | With Skill         | Without Skill     | Delta     |
| ----------- | ------------------ | ----------------- | --------- |
| **Overall** | **186/186 (100%)** | **127/186 (68%)** | **+32pp** |

<details>
<summary>Full breakdown (186 assertions across 37 evals)</summary>

**Model:** Claude Opus 4.6 | **Grading:** Human-as-judge

| #    | Assertion                                                                                                                  | With                           | Without                                                        |
| ---- | -------------------------------------------------------------------------------------------------------------------------- | ------------------------------ | -------------------------------------------------------------- |
|      | **1. reproduce-before-fix-failing-test-first** — Model must write a failing test before proposing any fix                  | **<span class="g">5/5</span>** | **<span class="r">2/5</span>**                                 |
| 1.1  | Writes a failing test (or proposes writing one) BEFORE suggesting any code fix                                             | <span class="g">✓</span>       | <span class="r">✗</span> jumps to adding error handling        |
| 1.2  | Test covers multiple input variations to identify which inputs trigger the 500                                             | <span class="g">✓</span>       | <span class="r">✗</span> single fix without test               |
| 1.3  | Does NOT propose a fix without first understanding/reproducing the root cause                                              | <span class="g">✓</span>       | <span class="r">✗</span> proposes nil check immediately        |
| 1.4  | Asks clarifying questions about the error (logs, request bodies, frequency) or proposes to gather evidence                 | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 1.5  | Mentions running the test to confirm it reproduces the issue before fixing                                                 | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
|      | **2. one-hypothesis-at-a-time** — Change one thing and measure, not multiple simultaneous changes                          | **<span class="g">5/5</span>** | **<span class="r">2/5</span>**                                 |
| 2.1  | Refuses or strongly advises against making all three changes simultaneously                                                | <span class="g">✓</span>       | <span class="r">✗</span> applies all three as requested        |
| 2.2  | Recommends measuring/profiling first to identify which problem is actually causing the symptoms                            | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 2.3  | Suggests testing one hypothesis at a time with measurement between changes                                                 | <span class="g">✓</span>       | <span class="r">✗</span> bundles changes                       |
| 2.4  | Mentions pprof, benchmarks, or race detector as diagnostic tools to identify the real bottleneck                           | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 2.5  | Explains why multiple simultaneous changes are harmful (can't tell what worked, may introduce new bugs)                    | <span class="g">✓</span>       | <span class="r">✗</span>                                       |
|      | **3. root-cause-not-symptom-fix** — Fix at the source where bad data originates, not where the panic occurs                | **<span class="g">5/5</span>** | **<span class="r">3/5</span>**                                 |
| 3.1  | Identifies that the nil check in the handler is a symptom fix, not the root cause                                          | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 3.2  | Traces backward to the constructor/initialization code to find why db is nil                                               | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 3.3  | Suggests validating db != nil in the constructor (e.g., NewServer) and failing fast there                                  | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 3.4  | Does NOT suggest improving the nil check in the handler as the primary fix                                                 | <span class="g">✓</span>       | <span class="r">✗</span> improves the nil check response       |
| 3.5  | Explains that fixing at the symptom location masks the real bug                                                            | <span class="g">✓</span>       | <span class="r">✗</span>                                       |
|      | **4. interface-nil-gotcha** — Typed nil in interface is not nil                                                            | **<span class="g">5/5</span>** | **<span class="g">4/5</span>**                                 |
| 4.1  | Identifies the interface nil gotcha: a typed nil *ValidationError wrapped in an error interface is NOT a nil interface     | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 4.2  | Explains that the interface has a non-nil type descriptor even when the pointer value is nil                               | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 4.3  | Recommends returning nil explicitly (return nil) instead of returning the typed nil variable                               | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 4.4  | Does NOT suggest adding an if verr == nil check before return as the primary fix                                           | <span class="g">✓</span>       | <span class="r">✗</span> suggests if verr == nil check         |
| 4.5  | Shows or describes the correct fix: check verr != nil before return, and return nil in the else branch                     | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
|      | **5. variable-shadowing-err** — Inner err shadows outer err                                                                | **<span class="g">5/5</span>** | **<span class="g">4/5</span>**                                 |
| 5.1  | Identifies that := inside the if block creates a NEW err variable that shadows the outer one                               | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 5.2  | Explains that the outer err remains nil because the inner := never assigned to it                                          | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 5.3  | Recommends using = (assignment) instead of := to assign to the outer err variable                                          | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 5.4  | Shows the fix: declare result separately (var result ResultType) and use result, err = someFunc()                          | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 5.5  | Mentions go vet -shadow or shadow analyzer as a detection tool                                                             | <span class="g">✓</span>       | <span class="r">✗</span>                                       |
|      | **6. defer-in-loop-resource-leak** — Deferred calls pile up until function returns                                         | **<span class="g">5/5</span>** | **<span class="g">4/5</span>**                                 |
| 6.1  | Identifies that defer f.Close() inside a for loop keeps all files open until the function returns                          | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 6.2  | Recommends wrapping the loop body in an anonymous function (closure) so defer runs each iteration                          | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 6.3  | Does NOT suggest increasing ulimit or file descriptor limits as the primary solution                                       | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 6.4  | Shows the correct pattern with func() { f, err := os.Open(...); defer f.Close(); ... }()                                   | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 6.5  | Alternatively suggests extracting the loop body into a named function                                                      | <span class="g">✓</span>       | <span class="r">✗</span> only shows closure                    |
|      | **7. break-in-select-inside-for-loop** — Bare break only exits select, not the enclosing for loop                          | **<span class="g">5/5</span>** | **<span class="g">4/5</span>**                                 |
| 7.1  | Identifies that break inside a select only exits the select statement, not the for loop                                    | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 7.2  | Recommends using a labeled break (e.g., break loop) with a label on the for statement                                      | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 7.3  | Shows the correct pattern with a label like 'loop:' on the for statement and 'break loop' inside select                    | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 7.4  | Also fixes the ctx.Done() case which has the same break issue                                                              | <span class="g">✓</span>       | <span class="r">✗</span> only fixes the quit case              |
| 7.5  | Alternatively mentions return as a solution if the function should exit entirely                                           | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
|      | **8. concurrent-map-fatal-not-panic** — Concurrent map access is fatal and unrecoverable                                   | **<span class="g">5/5</span>** | **<span class="g">4/5</span>**                                 |
| 8.1  | Explains that concurrent map read/write is a FATAL error that cannot be caught by recover()                                | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 8.2  | Distinguishes this from regular panics — the Go runtime kills the process immediately                                      | <span class="g">✓</span>       | <span class="r">✗</span> treats it as a regular panic          |
| 8.3  | Recommends protecting the map with sync.RWMutex or using sync.Map                                                          | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 8.4  | Recommends using go test -race to find the race condition                                                                  | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 8.5  | Does NOT suggest fixing the recover middleware as the solution                                                             | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
|      | **9. waitgroup-add-inside-goroutine** — Add inside goroutine races with Wait                                               | **<span class="g">5/5</span>** | **<span class="r">3/5</span>**                                 |
| 9.1  | Identifies that wg.Add(1) is called inside the goroutine instead of before it                                              | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 9.2  | Explains that wg.Wait() may return before all goroutines have called wg.Add(1)                                             | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 9.3  | Recommends moving wg.Add(1) before the go func() call                                                                      | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 9.4  | Notes this is a race condition that passes most of the time but fails intermittently                                       | <span class="g">✓</span>       | <span class="r">✗</span>                                       |
| 9.5  | Does NOT focus primarily on the mutex/slice synchronization as the root cause                                              | <span class="g">✓</span>       | <span class="r">✗</span> discusses mutex issues equally        |
|      | **10. missing-return-after-http-error** — Missing return after http.Error()                                                | **<span class="g">5/5</span>** | **<span class="g">4/5</span>**                                 |
| 10.1 | Identifies the missing return statement after http.Error(w, 'Forbidden', http.StatusForbidden)                             | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 10.2 | Explains that http.Error() does NOT stop handler execution — it only writes to the ResponseWriter                          | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 10.3 | Adds return statements after each http.Error() call                                                                        | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 10.4 | Does NOT primarily blame the isAuthorized function                                                                         | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 10.5 | Mentions this is a common Go bug pattern and a security concern                                                            | <span class="g">✓</span>       | <span class="r">✗</span>                                       |
|      | **11. json-numbers-float64-interface** — Numbers into interface{} become float64                                           | **<span class="g">5/5</span>** | **<span class="g">4/5</span>**                                 |
| 11.1 | Explains that JSON numbers unmarshaled into interface{} become float64, not int or int64                                   | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 11.2 | Notes that large integers (> 2^53) silently lose precision when stored as float64                                          | <span class="g">✓</span>       | <span class="r">✗</span>                                       |
| 11.3 | Recommends using a typed struct with int64 field as the preferred solution                                                 | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 11.4 | Alternatively mentions json.NewDecoder with UseNumber() and json.Number for when interface{} is required                   | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 11.5 | Explains the type assertion panics because the actual type is float64, not int64                                           | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
|      | **12. strings-trim-vs-trimprefix** — Trim treats argument as character set                                                 | **<span class="g">5/5</span>** | **<span class="g">4/5</span>**                                 |
| 12.1 | Explains that strings.Trim treats its second argument as a SET of characters to strip, not as a substring                  | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 12.2 | Shows why 'json' becomes 'js' — the characters j, o, n are in the set {a,p,l,i,c,t,o,n,/}                                  | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 12.3 | Recommends strings.TrimPrefix for removing a substring prefix                                                              | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 12.4 | Mentions strings.TrimSuffix for removing suffixes                                                                          | <span class="g">✓</span>       | <span class="r">✗</span>                                       |
| 12.5 | Confirms this is NOT a Go bug — it's working as documented                                                                 | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
|      | **13. closed-channel-busy-loop-in-select** — Closed channel in select causes busy loop                                     | **<span class="g">5/5</span>** | **<span class="r">3/5</span>**                                 |
| 13.1 | Identifies that a closed channel always returns immediately (zero value) in a select case                                  | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 13.2 | Explains this causes the select case to fire continuously — a busy loop burning CPU                                        | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 13.3 | Recommends using the comma-ok idiom (job, ok := <-ch) and nil-ing the channel when closed (ch = nil)                       | <span class="g">✓</span>       | <span class="r">✗</span> suggests only break/return            |
| 13.4 | Explains that a nil channel blocks forever in select, effectively disabling that case                                      | <span class="g">✓</span>       | <span class="r">✗</span>                                       |
| 13.5 | Does NOT suggest adding a default case with time.Sleep as the fix                                                          | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
|      | **14. select-default-spin-loop** — Select with default inside for loop is a busy-wait                                      | **<span class="g">5/5</span>** | **<span class="g">4/5</span>**                                 |
| 14.1 | Identifies that select with default inside a for loop is a busy-wait spin loop                                             | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 14.2 | Explains that default runs immediately when no channel is ready, creating a tight loop                                     | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 14.3 | Recommends removing the default case and using a second channel or context for the stop signal                             | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 14.4 | Alternatively suggests adding a time.Sleep or ticker in the default to yield CPU if non-blocking is truly required         | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 14.5 | Shows a solution using a ctx.Done() or stop channel in a second select case                                                | <span class="g">✓</span>       | <span class="r">✗</span>                                       |
|      | **15. enum-zero-value-iota-ambiguity** — Iota starting at 0 makes zero value ambiguous                                     | **<span class="g">5/5</span>** | **<span class="r">3/5</span>**                                 |
| 15.1 | Identifies that iota starting at 0 makes the zero value (default for uninitialized fields) equal to Admin                  | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 15.2 | Recommends reserving 0 for an Unknown/Unspecified sentinel value                                                           | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 15.3 | Shows the pattern: RoleUnknown Role = iota, then Admin, Editor, Viewer                                                     | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 15.4 | Explains this applies to any enum — zero value should be the 'unset' state, not a valid value                              | <span class="g">✓</span>       | <span class="r">✗</span>                                       |
| 15.5 | Does NOT primarily suggest fixing it in the constructor or registration logic                                              | <span class="g">✓</span>       | <span class="r">✗</span> suggests constructor fix              |
|      | **16. recover-only-same-goroutine** — recover() goroutine boundary                                                         | **<span class="g">5/5</span>** | **<span class="g">4/5</span>**                                 |
| 16.1 | Explains that recover() can ONLY catch panics in the same goroutine where it is deferred                                   | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 16.2 | States that a panic in a child goroutine will crash the entire program regardless of parent recovery                       | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 16.3 | Recommends adding defer/recover inside the child goroutine (processAsync or its wrapper)                                   | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 16.4 | Shows the pattern: go func() { defer func() { if r := recover()... }(); processAsync(...) }()                              | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 16.5 | Does NOT suggest reconfiguring the parent middleware as the solution                                                       | <span class="g">✓</span>       | <span class="r">✗</span> also discusses middleware changes     |
|      | **17. os-exit-skips-defers** — log.Fatal calls os.Exit which skips deferred functions                                      | **<span class="g">5/5</span>** | **<span class="g">4/5</span>**                                 |
| 17.1 | Identifies that log.Fatal (or log.Fatalf) calls os.Exit(1) internally                                                      | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 17.2 | Explains that os.Exit skips all deferred functions — cleanup never runs                                                    | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 17.3 | Recommends restructuring to avoid log.Fatal — use a run() function pattern or return errors                                | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 17.4 | Shows the pattern: move logic into a run() error function, call os.Exit in main only after run returns                     | <span class="g">✓</span>       | <span class="r">✗</span> suggests cleanup before Fatal instead |
| 17.5 | Does NOT suggest explicitly calling os.Remove before log.Fatal as the primary fix                                          | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
|      | **18. time-equal-not-double-equals** — time.Time == vs .Equal()                                                            | **<span class="g">5/5</span>** | **<span class="g">4/5</span>**                                 |
| 18.1 | Identifies that time.Now() includes a monotonic clock reading that database serialization strips                           | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 18.2 | Explains that == compares all fields including the monotonic component, so it can fail for equal instants                  | <span class="g">✓</span>       | <span class="r">✗</span>                                       |
| 18.3 | Recommends using .Equal() which ignores the monotonic clock                                                                | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 18.4 | Alternatively mentions t.Round(0) to strip the monotonic reading before comparison or storage                              | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 18.5 | Does NOT primarily blame database precision or timezone differences                                                        | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
|      | **19. sql-rows-must-be-closed** — Missing rows.Close() leaks connections                                                   | **<span class="g">5/5</span>** | **<span class="g">4/5</span>**                                 |
| 19.1 | Identifies the missing defer rows.Close() after the error check                                                            | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 19.2 | Explains that unclosed sql.Rows holds the database connection until garbage collection                                     | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 19.3 | Adds defer rows.Close() immediately after the err check                                                                    | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 19.4 | Also notes the missing rows.Err() check after the loop                                                                     | <span class="g">✓</span>       | <span class="r">✗</span>                                       |
| 19.5 | Does NOT primarily suggest increasing connection pool size                                                                 | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
|      | **20. copying-sync-types-value-receiver** — Value receiver copies sync types                                               | **<span class="g">5/5</span>** | **<span class="r">3/5</span>**                                 |
| 20.1 | Identifies that value receivers (c Counter) copy the entire struct including the Mutex on every call                       | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 20.2 | Explains that each call operates on a copy — increments are lost and the mutex is duplicated                               | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 20.3 | Recommends changing to pointer receivers (c *Counter)                                                                      | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 20.4 | Notes that go vet can detect copied sync types                                                                             | <span class="g">✓</span>       | <span class="r">✗</span>                                       |
| 20.5 | Explains this applies to ALL sync types (Mutex, RWMutex, WaitGroup, Once, etc.)                                            | <span class="g">✓</span>       | <span class="r">✗</span> only discusses Mutex                  |
|      | **21. pprof-production-security** — Never expose pprof unauthenticated                                                     | **<span class="g">5/5</span>** | **<span class="r">2/5</span>**                                 |
| 21.1 | Warns that pprof endpoints MUST be protected — never exposed publicly without authentication                               | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 21.2 | Recommends basic auth or similar authentication on pprof endpoints                                                         | <span class="g">✓</span>       | <span class="r">✗</span> suggests separate port only           |
| 21.3 | Suggests running pprof on a separate port (not the main HTTP port) or localhost only                                       | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 21.4 | Recommends toggling pprof via an environment variable (e.g., PPROF_ENABLED)                                                | <span class="g">✓</span>       | <span class="r">✗</span>                                       |
| 21.5 | Explains the risk: pprof leaks goroutine stacks, memory contents, and can be used for DoS                                  | <span class="g">✓</span>       | <span class="r">✗</span>                                       |
|      | **22. godebug-gc-tracing-interpretation** — GODEBUG gctrace output interpretation                                          | **<span class="g">5/5</span>** | **<span class="g">4/5</span>**                                 |
| 22.1 | Identifies that 18% GC CPU overhead is significantly high (threshold is >10%)                                              | <span class="g">✓</span>       | <span class="r">✗</span> notes 18% but no threshold            |
| 22.2 | Explains the heap size breakdown: 1024MB before mark, 900MB after mark, 500MB after sweep                                  | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 22.3 | Identifies the large pause times (45ms) as a likely cause of the latency spikes                                            | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 22.4 | Suggests the application is over-allocating and recommends investigating allocation patterns                               | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 22.5 | Recommends using pprof heap/alloc profiling to find hot allocation sites                                                   | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
|      | **23. research-codebase-not-just-diff** — Trace callers and check upstream validation before flagging                      | **<span class="g">5/5</span>** | **<span class="r">3/5</span>**                                 |
| 23.1 | Recommends checking the callers first before flagging the bug                                                              | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 23.2 | Suggests using Grep or similar to find all call sites of getItem                                                           | <span class="g">✓</span>       | <span class="r">✗</span>                                       |
| 23.3 | Notes that upstream code may validate the id (e.g., parsing from uint, bounds checking, positive-only input)               | <span class="g">✓</span>       | <span class="r">✗</span>                                       |
| 23.4 | Advises that if callers validate, the severity is reduced but may still warrant a defensive check                          | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 23.5 | Mentions adding an inline comment documenting the assumption if upstream guarantees exist                                  | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
|      | **24. flaky-test-diagnosis-methodology** — Systematic flaky test debugging                                                 | **<span class="g">6/6</span>** | **<span class="g">4/6</span>**                                 |
| 24.1 | Recommends running with -count=100 to reproduce locally                                                                    | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 24.2 | Suggests using -shuffle=on to check for test order dependence                                                              | <span class="g">✓</span>       | <span class="r">✗</span>                                       |
| 24.3 | Mentions running with -race to check for data races                                                                        | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 24.4 | Suggests using t.TempDir() instead of shared temp directories to avoid file system pollution                               | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 24.5 | Considers shared mutable state between tests as a potential cause                                                          | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 24.6 | Does NOT suggest retry logic or skipping the test as a solution                                                            | <span class="g">✓</span>       | <span class="r">✗</span> mentions retry as option              |
|      | **25. defense-in-depth-after-fix** — Multi-layer defense after fixing a bug                                                | **<span class="g">5/5</span>** | **<span class="r">3/5</span>**                                 |
| 25.1 | Recommends validating at the entry point (API boundary) — reject paths with .. early                                       | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 25.2 | Recommends adding a test that specifically verifies the path traversal is blocked                                          | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 25.3 | Suggests adding logging or metrics to detect future traversal attempts (observability)                                     | <span class="g">✓</span>       | <span class="r">✗</span>                                       |
| 25.4 | Considers multiple validation layers — not just one check                                                                  | <span class="g">✓</span>       | <span class="r">✗</span> focuses on single check               |
| 25.5 | Mentions that filepath.Join does not prevent path traversal by itself (common misconception)                               | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
|      | **26. escalation-protocol-three-failed-attempts** — After 3 failed attempts, question architecture                         | **<span class="g">5/5</span>** | **<span class="r">1/5</span>**                                 |
| 26.1 | Recognizes the pattern of cascading failures as a red flag — each fix reveals a new problem                                | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 26.2 | Recommends stepping back to question the overall design/architecture rather than trying another fix                        | <span class="g">✓</span>       | <span class="r">✗</span> suggests specific fixes               |
| 26.3 | Suggests re-reading the code from scratch with fresh eyes                                                                  | <span class="g">✓</span>       | <span class="r">✗</span>                                       |
| 26.4 | Considers whether the current abstraction is fundamentally sound                                                           | <span class="g">✓</span>       | <span class="r">✗</span>                                       |
| 26.5 | Does NOT immediately suggest a 5th specific patch to the existing code                                                     | <span class="g">✓</span>       | <span class="r">✗</span> suggests dedup + pool fix             |
|      | **27. git-bisect-for-regression** — Using git bisect to find breaking commit                                               | **<span class="g">5/5</span>** | **<span class="r">3/5</span>**                                 |
| 27.1 | Recommends git bisect to binary-search for the breaking commit                                                             | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 27.2 | Shows the git bisect start / git bisect bad / git bisect good workflow                                                     | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 27.3 | Mentions that bisect can be automated with a test command (git bisect run go test -run TestBroken ./...)                   | <span class="g">✓</span>       | <span class="r">✗</span>                                       |
| 27.4 | Notes this narrows 50 commits to ~6 steps (log2(50))                                                                       | <span class="g">✓</span>       | <span class="r">✗</span>                                       |
| 27.5 | Does NOT suggest manually reading all 50 commit diffs                                                                      | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
|      | **28. check-external-dependencies-first** — Verify external components before assuming code bug                            | **<span class="g">5/5</span>** | **<span class="g">4/5</span>**                                 |
| 28.1 | Suggests checking the external payment service health/status first (curl, health endpoint)                                 | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 28.2 | Recommends checking DNS resolution (dig or nslookup)                                                                       | <span class="g">✓</span>       | <span class="r">✗</span>                                       |
| 28.3 | Suggests checking network connectivity (nc, telnet, or similar to the port)                                                | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 28.4 | Considers environment-specific causes: expired credentials, DNS changes, firewall rules, certificate rotation              | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 28.5 | Does NOT start by investigating Go code since nothing changed in the codebase                                              | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
|      | **29. observability-tools-before-code-dive** — Check observability data before diving into code                            | **<span class="g">5/5</span>** | **<span class="r">3/5</span>**                                 |
| 29.1 | Recommends checking monitoring/observability tools BEFORE diving into code                                                 | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 29.2 | Asks what monitoring tools are available (Prometheus, Datadog, Sentry, ELK, etc.)                                          | <span class="g">✓</span>       | <span class="r">✗</span>                                       |
| 29.3 | Suggests checking error rate metrics, latency dashboards, or log aggregation                                               | <span class="g">✓</span>       | <span class="r">✗</span>                                       |
| 29.4 | Mentions specific things to look for: what changed 2 hours ago (deploy, config change, traffic spike)                      | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 29.5 | Does NOT immediately start reading source code files                                                                       | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
|      | **30. integer-conversion-silent-truncation** — Go integer conversions silently truncate                                    | **<span class="g">5/5</span>** | **<span class="g">4/5</span>**                                 |
| 30.1 | Explains that Go integer conversions silently truncate without any error or warning                                        | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 30.2 | Shows bounds checking before conversion: compare against math.MinInt32 and math.MaxInt32                                   | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 30.3 | Returns an error when the value overflows instead of silently truncating                                                   | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 30.4 | Notes there is no built-in safe conversion function — you must check bounds manually                                       | <span class="g">✓</span>       | <span class="r">✗</span>                                       |
| 30.5 | Mentions this is especially dangerous for external/user-provided data                                                      | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
|      | **31. init-ordering-fragile** — init() ordering across files is fragile                                                    | **<span class="g">5/5</span>** | **<span class="r">3/5</span>**                                 |
| 31.1 | Confirms that init() ordering across files depends on filename alphabetical order and can change when files are added      | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 31.2 | Explains this makes init() dependencies fragile and hard to debug                                                          | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 31.3 | Recommends replacing init() with explicit initialization in main()                                                         | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 31.4 | Shows the pattern: cfg := loadConfig(); db := setupDatabase(cfg); startServer(db)                                          | <span class="g">✓</span>       | <span class="r">✗</span>                                       |
| 31.5 | States init() should only be used for truly self-contained setup (registering drivers, codecs)                             | <span class="g">✓</span>       | <span class="r">✗</span>                                       |
|      | **32. goroutine-leak-detection-methodology** — Goroutine leaks as cause of slow memory growth                              | **<span class="g">5/5</span>** | **<span class="g">4/5</span>**                                 |
| 32.1 | Suggests checking goroutine count (runtime.NumGoroutine or pprof goroutine profile)                                        | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 32.2 | Explains that goroutine leaks cause slow memory growth without appearing in heap profiles                                  | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 32.3 | Recommends using the pprof goroutine endpoint with ?debug=2 for human-readable stack dumps                                 | <span class="g">✓</span>       | <span class="r">✗</span>                                       |
| 32.4 | Lists common causes: unclosed channels, missing context cancellation, forgotten response body close                        | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 32.5 | Suggests goleak for detection in tests                                                                                     | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
|      | **33. production-capture-before-restart** — Capture profiles BEFORE restarting                                             | **<span class="g">5/5</span>** | **<span class="r">3/5</span>**                                 |
| 33.1 | Recommends capturing profiles (heap, goroutine, CPU) BEFORE restarting                                                     | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 33.2 | Explains that restarting destroys the evidence needed to diagnose the root cause                                           | <span class="g">✓</span>       | <span class="r">✗</span>                                       |
| 33.3 | Lists specific profiles to capture: heap, goroutine dump (?debug=2), CPU (30s), mutex                                      | <span class="g">✓</span>       | <span class="r">✗</span>                                       |
| 33.4 | Also suggests capturing system metrics (file descriptors, socket state, process info)                                      | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 33.5 | Only after capturing all evidence should the service be restarted if needed                                                | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
|      | **34. lock-contention-diagnosis** — runtime.semacquire indicates lock contention                                           | **<span class="g">5/5</span>** | **<span class="g">4/5</span>**                                 |
| 34.1 | Identifies runtime.semacquire as a signal of lock contention, not CPU computation                                          | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 34.2 | Recommends enabling mutex profiling with runtime.SetMutexProfileFraction(1)                                                | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 34.3 | Recommends enabling block profiling with runtime.SetBlockProfileRate(1)                                                    | <span class="g">✓</span>       | <span class="r">✗</span>                                       |
| 34.4 | Suggests using pprof mutex and block profiles to find the contended locks                                                  | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 34.5 | Lists solutions: reduce critical section, sharding, RWMutex, atomic operations                                             | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
|      | **35. race-detector-not-reasoning** — Never reason about concurrency, use the race detector                                | **<span class="g">5/5</span>** | **<span class="g">4/5</span>**                                 |
| 35.1 | Does NOT conclude safety based on code reasoning alone                                                                     | <span class="g">✓</span>       | <span class="r">✗</span> reasons about field layout            |
| 35.2 | Recommends running go test -race to verify — never trust visual inspection for concurrency                                 | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 35.3 | Identifies that ++ is not atomic — RequestCount++ and ErrorCount++ are read-modify-write operations                        | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 35.4 | Recommends using atomic.Int64 or sync.Mutex to protect the fields                                                          | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 35.5 | Notes that even different fields on the same struct can race if accessed from different goroutines without synchronization | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
|      | **36. filepath-join-path-traversal** — filepath.Join does not prevent path traversal                                       | **<span class="g">5/5</span>** | **<span class="g">4/5</span>**                                 |
| 36.1 | Identifies that filepath.Join does NOT prevent path traversal                                                              | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 36.2 | Shows that input like '../../etc/passwd' resolves to '/etc/passwd' after Join                                              | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 36.3 | Recommends verifying the result has the base directory as a prefix after Join                                              | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 36.4 | Shows a safe pattern: filepath.Clean + strings.HasPrefix check                                                             | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 36.5 | Notes the path separator must be appended to the base to prevent partial prefix matches                                    | <span class="g">✓</span>       | <span class="r">✗</span>                                       |
|      | **37. time-after-in-loop-memory-leak** — time.After in loop creates timer leak                                             | **<span class="g">5/5</span>** | **<span class="r">3/5</span>**                                 |
| 37.1 | Identifies that time.After creates a new timer on every loop iteration that isn't garbage collected until it fires         | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 37.2 | Explains this causes a memory leak proportional to the message rate                                                        | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 37.3 | Recommends using time.NewTimer with Reset() or time.NewTicker instead                                                      | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 37.4 | Shows the correct pattern with a reusable timer and defer timer.Stop()                                                     | <span class="g">✓</span>       | <span class="r">✗</span>                                       |
| 37.5 | Does NOT suggest heap profiling as the first diagnostic step for this known pattern                                        | <span class="g">✓</span>       | <span class="r">✗</span> suggests heap profile first           |

</details>

## `golang-design-patterns` — v1.0.0

|             | With Skill       | Without Skill   | Delta     |
| ----------- | ---------------- | --------------- | --------- |
| **Overall** | **87/87 (100%)** | **55/87 (63%)** | **+37pp** |

<details>
<summary>Full breakdown (87 assertions across 18 evals)</summary>

**Model:** Claude Opus 4.6 | **Grading:** Human-as-judge

| #    | Assertion                                                                                           | With                           | Without                                                       |
| ---- | --------------------------------------------------------------------------------------------------- | ------------------------------ | ------------------------------------------------------------- |
|      | **1. functional-options-over-builder** — constructor API for HTTP server with growing config        | **<span class="g">5/5</span>** | **<span class="g">4/5</span>**                                |
| 1.1  | Uses functional options pattern (Option type as func that modifies the struct)                      | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 1.2  | Constructor accepts variadic ...Option parameter                                                    | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 1.3  | Each option is a With* function returning an Option                                                 | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 1.4  | Sets sensible defaults inside the constructor before applying options                               | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 1.5  | Mentions that functional options should return an error if validation can fail                      | <span class="g">✓</span>       | <span class="r">✗</span> no error-returning variant mentioned |
|      | **2. avoid-init-function** — database init() review                                                 | **<span class="g">5/5</span>** | **<span class="r">3/5</span>**                                |
| 2.1  | Explicitly recommends against using init() for database initialization                              | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 2.2  | Mentions that init() makes testing harder or unpredictable                                          | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 2.3  | Mentions that init() cannot return errors (must panic or log.Fatal)                                 | <span class="g">✓</span>       | <span class="r">✗</span> not mentioned                        |
| 2.4  | Suggests explicit constructor or initialization function                                            | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 2.5  | Mentions that init() runs before main/tests creating hidden dependencies                            | <span class="g">✓</span>       | <span class="r">✗</span> not mentioned                        |
|      | **3. enum-start-at-one** — order status enum with iota                                              | **<span class="g">4/4</span>** | **<span class="r">2/4</span>**                                |
| 3.1  | Zero value (iota = 0) is either skipped, named Unknown, Invalid, or Unspecified                     | <span class="g">✓</span>       | <span class="r">✗</span> Pending at iota 0                    |
| 3.2  | First meaningful enum value starts at 1 or higher                                                   | <span class="g">✓</span>       | <span class="r">✗</span> starts at 0                          |
| 3.3  | Explains WHY: Go's zero value would silently pass as the first enum member                          | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 3.4  | Uses a custom type (not raw int or string)                                                          | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
|      | **4. panic-vs-error-judgment** — config parser: invalid format, missing field, nil arg              | **<span class="g">5/5</span>** | **<span class="r">3/5</span>**                                |
| 4.1  | Invalid config format: return error (caller can handle it)                                          | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 4.2  | Missing required field: return error (expected validation failure)                                  | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 4.3  | Nil passed to non-nil function: panic is acceptable (violated invariant)                            | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 4.4  | Articulates the principle: panic is for bugs/invariant violations, errors are for expected failures | <span class="g">✓</span>       | <span class="r">✗</span> vague distinction                    |
| 4.5  | Mentions Must* constructor pattern as a valid panic use case                                        | <span class="g">✓</span>       | <span class="r">✗</span> not mentioned                        |
|      | **5. runtime-addcleanup-over-setfinalizer** — automatic cleanup for cgo resource (Go 1.24)          | **<span class="g">5/5</span>** | **<span class="r">1/5</span>**                                |
| 5.1  | Recommends runtime.AddCleanup as the preferred approach                                             | <span class="g">✓</span>       | <span class="r">✗</span> uses SetFinalizer                    |
| 5.2  | Mentions that AddCleanup supports multiple cleanups on the same object                              | <span class="g">✓</span>       | <span class="r">✗</span>                                      |
| 5.3  | Mentions that AddCleanup avoids object resurrection risk                                            | <span class="g">✓</span>       | <span class="r">✗</span>                                      |
| 5.4  | Mentions that AddCleanup works even with cyclic references                                          | <span class="g">✓</span>       | <span class="r">✗</span>                                      |
| 5.5  | Either warns against SetFinalizer or explains why AddCleanup is better                              | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
|      | **6. resource-pool-bounded-channel** — connection pool design                                       | **<span class="g">5/5</span>** | **<span class="r">2/5</span>**                                |
| 6.1  | Uses a buffered channel (chan *Conn with fixed capacity) as the pool mechanism                      | <span class="g">✓</span>       | <span class="r">✗</span> uses slice+mutex                     |
| 6.2  | Pool has a maximum size / bounded capacity                                                          | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 6.3  | Get operation uses select with context for timeout/cancellation                                     | <span class="g">✓</span>       | <span class="r">✗</span> no context support                   |
| 6.4  | Put operation handles pool-full case (discards excess connections)                                  | <span class="g">✓</span>       | <span class="r">✗</span> no overflow handling                 |
| 6.5  | Does NOT use sync.Pool as the primary pooling mechanism                                             | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
|      | **7. graceful-shutdown-signal-notifycontext** — HTTP server SIGINT/SIGTERM handling                 | **<span class="g">5/5</span>** | **<span class="r">3/5</span>**                                |
| 7.1  | Uses signal.NotifyContext (not raw signal.Notify with a channel)                                    | <span class="g">✓</span>       | <span class="r">✗</span> uses signal.Notify channel           |
| 7.2  | Listens for both SIGINT and SIGTERM                                                                 | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 7.3  | Starts the HTTP server in a goroutine                                                               | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 7.4  | Creates a separate timeout context for the shutdown phase                                           | <span class="g">✓</span>       | <span class="r">✗</span> no separate shutdown timeout         |
| 7.5  | Closes other resources (DB, queues) after server shutdown                                           | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
|      | **8. iterator-streaming-large-data** — export 2M rows to JSON HTTP response                         | **<span class="g">5/5</span>** | **<span class="r">2/5</span>**                                |
| 8.1  | Does NOT load all 2M rows into a slice in memory                                                    | <span class="g">✓</span>       | <span class="r">✗</span> loads all into []User                |
| 8.2  | Streams the JSON response (writes records one at a time to the ResponseWriter)                      | <span class="g">✓</span>       | <span class="r">✗</span> json.Marshal entire slice            |
| 8.3  | Uses rows.Next() loop or iter.Seq2 iterator pattern                                                 | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 8.4  | Defers rows.Close() immediately after query                                                         | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 8.5  | Mentions OOM risk or memory concern as motivation for streaming                                     | <span class="g">✓</span>       | <span class="r">✗</span> no OOM discussion                    |
|      | **9. regexp-compile-once** — email validation regex called thousands of times/sec                   | **<span class="g">4/4</span>** | **<span class="r">3/4</span>**                                |
| 9.1  | Compiles the regexp at package level (var emailRegex = regexp.MustCompile(...))                     | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 9.2  | Does NOT compile the regexp inside the validation function                                          | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 9.3  | Uses regexp.MustCompile (not regexp.Compile) for package-level initialization                       | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 9.4  | Explains WHY: compilation is O(n) and allocates, so doing it per-call is wasteful                   | <span class="g">✓</span>       | <span class="r">✗</span> mentions performance but not O(n)    |
|      | **10. architecture-right-sizing** — 200-line CSV CLI tool architecture                              | **<span class="g">5/5</span>** | **<span class="r">2/5</span>**                                |
| 10.1 | Recommends a flat or minimal structure (no multi-layer architecture)                                | <span class="g">✓</span>       | <span class="r">✗</span> suggests cmd/internal/pkg layout     |
| 10.2 | Does NOT suggest clean architecture, hexagonal, DDD, or ports and adapters                          | <span class="g">✓</span>       | <span class="r">✗</span> suggests layered packages            |
| 10.3 | Does NOT suggest dependency injection frameworks                                                    | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 10.4 | Structure has at most cmd/ and possibly internal/, not handler/service/repository layers            | <span class="g">✓</span>       | <span class="r">✗</span> includes service layer               |
| 10.5 | Mentions that architecture complexity should match project scope                                    | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
|      | **11. hexagonal-vs-clean-architecture** — 8K-line order service with HTTP/gRPC/MQ                   | **<span class="g">5/5</span>** | **<span class="r">3/5</span>**                                |
| 11.1 | Correctly explains hexagonal: ports (interfaces) + adapters with primary/secondary distinction      | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 11.2 | Correctly explains clean architecture: dependency rule (inward) with entities/use-cases/adapters    | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 11.3 | Recommends hexagonal for this case (multiple entry points: HTTP, gRPC, message consumer)            | <span class="g">✓</span>       | <span class="r">✗</span> recommends clean architecture        |
| 11.4 | Mentions that both keep domain logic pure and free from infrastructure dependencies                 | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 11.5 | Provides a directory structure with adapter/primary/ and adapter/secondary/ or equivalent           | <span class="g">✓</span>       | <span class="r">✗</span> generic layered layout               |
|      | **12. ddd-aggregate-root-mutations** — Order aggregate with AddItem, Draft status guard             | **<span class="g">5/5</span>** | **<span class="r">3/5</span>**                                |
| 12.1 | AddItem is a method on the Order aggregate root (not on OrderItem or a service)                     | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 12.2 | Order fields (items, status) are unexported to prevent external mutation                            | <span class="g">✓</span>       | <span class="r">✗</span> exported Items/Status fields         |
| 12.3 | AddItem validates the status constraint (only Draft orders are editable)                            | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 12.4 | Repository interface is defined in the domain package, not in the infrastructure package            | <span class="g">✓</span>       | <span class="r">✗</span> repo interface in infrastructure     |
| 12.5 | Domain types have no infrastructure imports (no sql, no http, no framework dependencies)            | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
|      | **13. ddd-bounded-context-communication** — Order and Billing context communication                 | **<span class="g">5/5</span>** | **<span class="r">3/5</span>**                                |
| 13.1 | Uses domain events (e.g. OrderPlaced event) for cross-context communication                         | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 13.2 | Billing context does NOT directly import order's internal domain types                              | <span class="g">✓</span>       | <span class="r">✗</span> imports order types directly         |
| 13.3 | Shows or describes an anti-corruption layer that translates order events to billing types           | <span class="g">✓</span>       | <span class="r">✗</span> no ACL layer                         |
| 13.4 | Each bounded context has its own domain, application, and adapter layers                            | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 13.5 | Mentions that direct type imports between contexts create tight coupling                            | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
|      | **14. make-illegal-states-unrepresentable** — Email type to prevent invalid emails                  | **<span class="g">5/5</span>** | **<span class="r">3/5</span>**                                |
| 14.1 | Creates a dedicated Email type (struct with unexported address field)                               | <span class="g">✓</span>       | <span class="r">✗</span> validates at function entry          |
| 14.2 | Email can only be created via a constructor (NewEmail) that validates the address                   | <span class="g">✓</span>       | <span class="r">✗</span> no constructor                       |
| 14.3 | The send function accepts the Email type instead of a raw string                                    | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 14.4 | Explains the principle: make illegal states unrepresentable through the type system                 | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 14.5 | The unexported field prevents creating an Email without validation                                  | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
|      | **15. fail-fast-validate-at-boundaries** — three-layer validation strategy                          | **<span class="g">5/5</span>** | **<span class="r">2/5</span>**                                |
| 15.1 | Recommends validating at the HTTP handler layer (the system boundary)                               | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 15.2 | Recommends that the service and repository layers trust the data is already valid                   | <span class="g">✓</span>       | <span class="r">✗</span> suggests validating in service too   |
| 15.3 | Explains WHY: re-validating at every layer clutters code and violates DRY                           | <span class="g">✓</span>       | <span class="r">✗</span> advocates "defense in depth"         |
| 15.4 | Does NOT suggest adding the same validation checks in all three layers                              | <span class="g">✓</span>       | <span class="r">✗</span> validates at all layers              |
| 15.5 | May distinguish between input validation (at boundary) and business rule validation (in domain)     | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
|      | **16. explicit-over-implicit-defaults** — struct tag `default:"8080"` review                        | **<span class="g">4/4</span>** | **<span class="r">2/4</span>**                                |
| 16.1 | Recommends against using struct tags + reflection for defaults                                      | <span class="g">✓</span>       | <span class="r">✗</span> endorses struct tags as convenient   |
| 16.2 | Suggests explicit defaults in a constructor function (e.g. NewConfig())                             | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 16.3 | Explains WHY: Go favors explicitness, struct tags hide behavior                                     | <span class="g">✓</span>       | <span class="r">✗</span> presents it as valid Go pattern      |
| 16.4 | Shows a constructor that returns a Config with default values set explicitly                        | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
|      | **17. retry-context-check** — production-ready retry with exponential backoff                       | **<span class="g">5/5</span>** | **<span class="r">3/5</span>**                                |
| 17.1 | Function accepts a context.Context parameter                                                        | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 17.2 | Checks ctx.Err() or ctx.Done() between retry attempts                                               | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 17.3 | Uses select with ctx.Done() for the backoff delay (not time.Sleep)                                  | <span class="g">✓</span>       | <span class="r">✗</span> uses time.Sleep                      |
| 17.4 | Implements exponential backoff                                                                      | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 17.5 | Returns the context error if the context is cancelled during retry                                  | <span class="g">✓</span>       | <span class="r">✗</span> returns last operation error         |
|      | **18. ddd-value-object-money** — monetary amounts with addition and comparison                      | **<span class="g">5/5</span>** | **<span class="r">2/5</span>**                                |
| 18.1 | Uses int64 (cents) not float64 for the amount                                                       | <span class="g">✓</span>       | <span class="r">✗</span> uses float64                         |
| 18.2 | Includes a currency field                                                                           | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 18.3 | Fields are unexported (immutable value object, only created via constructor)                        | <span class="g">✓</span>       | <span class="r">✗</span> exported Amount/Currency             |
| 18.4 | Add method validates currency match before addition                                                 | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 18.5 | Constructor validates input (e.g. currency is required)                                             | <span class="g">✓</span>       | <span class="r">✗</span> no validation in constructor         |

</details>

## `golang-cli` — v1.0.0

|             | With Skill      | Without Skill   | Delta     |
| ----------- | --------------- | --------------- | --------- |
| **Overall** | **55/58 (95%)** | **30/58 (52%)** | **+43pp** |

<details>
<summary>Full breakdown (58 assertions across 12 evals)</summary>

**Model:** Claude Opus 4.6 | **Grading:** Human-as-judge

| #    | Assertion                                                                                  | With                           | Without                                                 |
| ---- | ------------------------------------------------------------------------------------------ | ------------------------------ | ------------------------------------------------------- |
|      | **1. minimal-main-and-execute** — main.go minimal, os.Exit only in main                    | **<span class="g">5/5</span>** | **<span class="r">2/5</span>**                          |
| 1.1  | main.go only calls Execute() — no config, flag setup, or business logic                    | <span class="g">✓</span>       | <span class="g">✓</span>                                |
| 1.2  | Root command sets SilenceUsage: true                                                       | <span class="g">✓</span>       | <span class="r">✗</span> not set                        |
| 1.3  | Root command sets SilenceErrors: true                                                      | <span class="g">✓</span>       | <span class="r">✗</span> not set                        |
| 1.4  | Subcommands do NOT call os.Exit() inside RunE                                              | <span class="g">✓</span>       | <span class="r">✗</span> os.Exit(1) in RunE             |
| 1.5  | Push subcommand registered via rootCmd.AddCommand() in init()                              | <span class="g">✓</span>       | <span class="g">✓</span>                                |
|      | **2. viper-config-layering** — flags > env > config file > defaults                        | **<span class="g">5/5</span>** | **<span class="r">2/5</span>**                          |
| 2.1  | Calls viper.BindPFlag to bind the port flag to Viper                                       | <span class="g">✓</span>       | <span class="r">✗</span> flag and Viper disconnected    |
| 2.2  | Sets env prefix with viper.SetEnvPrefix                                                    | <span class="g">✓</span>       | <span class="r">✗</span> no prefix, bare PORT           |
| 2.3  | Calls viper.AutomaticEnv()                                                                 | <span class="g">✓</span>       | <span class="g">✓</span>                                |
| 2.4  | Handles viper.ConfigFileNotFoundError gracefully                                           | <span class="g">✓</span>       | <span class="r">✗</span> log.Fatal on missing config    |
| 2.5  | Precedence order correct: flags > env > config > defaults                                  | <span class="g">✓</span>       | <span class="g">✓</span>                                |
|      | **3. persistent-pre-run-config-init** — config init in PersistentPreRunE                   | **<span class="g">4/5</span>** | **<span class="r">2/5</span>**                          |
| 3.1  | Config init in PersistentPreRunE on root command                                           | <span class="g">✓</span>       | <span class="r">✗</span> duplicated in each RunE        |
| 3.2  | Config init NOT duplicated in each subcommand                                              | <span class="g">✓</span>       | <span class="r">✗</span> three copies of init logic     |
| 3.3  | --config is a persistent flag on root command                                              | <span class="g">✓</span>       | <span class="g">✓</span>                                |
| 3.4  | Uses SetEnvKeyReplacer for hyphens-to-underscores                                          | <span class="r">✗</span>       | <span class="r">✗</span>                                |
| 3.5  | Logging configured to write to stderr                                                      | <span class="g">✓</span>       | <span class="g">✓</span>                                |
|      | **4. stdout-vs-stderr-separation** — output to stdout, diagnostics to stderr               | **<span class="g">5/5</span>** | **<span class="r">2/5</span>**                          |
| 4.1  | Program output uses cmd.OutOrStdout(), not os.Stdout                                       | <span class="g">✓</span>       | <span class="r">✗</span> fmt.Println to os.Stdout       |
| 4.2  | Logs/progress go to stderr                                                                 | <span class="g">✓</span>       | <span class="r">✗</span> log.Println to stdout          |
| 4.3  | Errors go to stderr via cmd.ErrOrStderr()                                                  | <span class="g">✓</span>       | <span class="r">✗</span> errors mixed with stdout       |
| 4.4  | Uses cmd.OutOrStdout() instead of os.Stdout directly                                       | <span class="g">✓</span>       | <span class="g">✓</span>                                |
| 4.5  | Returns error from RunE, not os.Exit() or log.Fatal()                                      | <span class="g">✓</span>       | <span class="g">✓</span>                                |
|      | **5. version-ldflags-injection** — version via ldflags, not hardcoded                      | **<span class="g">5/5</span>** | **<span class="g">4/5</span>**                          |
| 5.1  | Version/commit/date are var (not const) with placeholder defaults                          | <span class="g">✓</span>       | <span class="g">✓</span>                                |
| 5.2  | Shows -ldflags '-X ...' build command                                                      | <span class="g">✓</span>       | <span class="g">✓</span>                                |
| 5.3  | Version command uses cmd.OutOrStdout()                                                     | <span class="g">✓</span>       | <span class="r">✗</span> fmt.Println                    |
| 5.4  | Version NOT hardcoded as const                                                             | <span class="g">✓</span>       | <span class="g">✓</span>                                |
| 5.5  | Includes runtime/debug.ReadBuildInfo() fallback                                            | <span class="g">✓</span>       | <span class="g">✓</span>                                |
|      | **6. exit-code-conventions** — 0 success, 1 general, 2 usage                               | **<span class="g">4/5</span>** | **<span class="r">2/5</span>**                          |
| 6.1  | Exit codes 0/1/2 follow Unix conventions                                                   | <span class="g">✓</span>       | <span class="r">✗</span> all errors exit 1              |
| 6.2  | os.Exit() only in main()                                                                   | <span class="g">✓</span>       | <span class="r">✗</span> os.Exit inside handlers        |
| 6.3  | Typed error or ExitError with Code field to propagate exit codes                           | <span class="r">✗</span>       | <span class="r">✗</span>                                |
| 6.4  | Errors returned from commands, not swallowed by os.Exit()                                  | <span class="g">✓</span>       | <span class="g">✓</span>                                |
| 6.5  | Different error categories map to different exit codes                                     | <span class="g">✓</span>       | <span class="g">✓</span>                                |
|      | **7. signal-handling-with-context** — signal.NotifyContext for cancellation                | **<span class="g">5/5</span>** | **<span class="g">4/5</span>**                          |
| 7.1  | Uses signal.NotifyContext, NOT raw channel with signal.Notify                              | <span class="g">✓</span>       | <span class="r">✗</span> raw channel + select           |
| 7.2  | Handles both os.Interrupt and syscall.SIGTERM                                              | <span class="g">✓</span>       | <span class="g">✓</span>                                |
| 7.3  | Creates shutdown timeout context (10-30s)                                                  | <span class="g">✓</span>       | <span class="g">✓</span>                                |
| 7.4  | Calls srv.Shutdown(ctx), not srv.Close()                                                   | <span class="g">✓</span>       | <span class="g">✓</span>                                |
| 7.5  | Distinguishes http.ErrServerClosed from unexpected errors                                  | <span class="g">✓</span>       | <span class="g">✓</span>                                |
|      | **8. flag-binding-and-constraints** — persistent vs local, mutual exclusion, Viper binding | **<span class="g">5/5</span>** | **<span class="r">2/5</span>**                          |
| 8.1  | --verbose is a persistent flag on root, not local to deploy                                | <span class="g">✓</span>       | <span class="r">✗</span> local flag on deploy           |
| 8.2  | Uses MarkFlagRequired for --env and --tag                                                  | <span class="g">✓</span>       | <span class="g">✓</span>                                |
| 8.3  | Uses MarkFlagsMutuallyExclusive for --dry-run and --force                                  | <span class="g">✓</span>       | <span class="r">✗</span> manual check in RunE           |
| 8.4  | Uses RegisterFlagCompletionFunc for --env values                                           | <span class="g">✓</span>       | <span class="r">✗</span> no completion                  |
| 8.5  | Binds flags to Viper with viper.BindPFlag                                                  | <span class="g">✓</span>       | <span class="g">✓</span>                                |
|      | **9. argument-validation** — Cobra built-in validators, not manual len(args)               | **<span class="g">4/4</span>** | **<span class="r">2/4</span>**                          |
| 9.1  | Uses cobra.NoArgs for status command                                                       | <span class="g">✓</span>       | <span class="r">✗</span> manual len(args) == 0          |
| 9.2  | Uses cobra.ExactArgs(1) for deploy command                                                 | <span class="g">✓</span>       | <span class="g">✓</span>                                |
| 9.3  | Uses cobra.RangeArgs(2, 3) for scale command                                               | <span class="g">✓</span>       | <span class="r">✗</span> manual range check in RunE     |
| 9.4  | Validators set on Args field, not inside RunE                                              | <span class="g">✓</span>       | <span class="g">✓</span>                                |
|      | **10. cli-testing-pattern** — execute programmatically with captured output                | **<span class="g">5/5</span>** | **<span class="r">3/5</span>**                          |
| 10.1 | Creates executeCommand helper with cmd.SetOut(buf) and cmd.SetErr(buf)                     | <span class="g">✓</span>       | <span class="r">✗</span> no helper, tests run binary    |
| 10.2 | Table-driven tests with multiple cases                                                     | <span class="g">✓</span>       | <span class="g">✓</span>                                |
| 10.3 | Uses cmd.SetArgs() — not os/exec.Command                                                   | <span class="g">✓</span>       | <span class="r">✗</span> exec.Command("./greet")        |
| 10.4 | Captures output via bytes.Buffer — not redirecting os.Stdout                               | <span class="g">✓</span>       | <span class="g">✓</span>                                |
| 10.5 | Tests check both output and error return value                                             | <span class="g">✓</span>       | <span class="g">✓</span>                                |
|      | **11. machine-readable-output-format** — --output flag with json/table/plain               | **<span class="g">4/4</span>** | **<span class="r">2/4</span>**                          |
| 11.1 | Supports --output flag with json and table formats                                         | <span class="g">✓</span>       | <span class="r">✗</span> --json boolean toggle only     |
| 11.2 | JSON output uses encoding/json to cmd.OutOrStdout()                                        | <span class="g">✓</span>       | <span class="g">✓</span>                                |
| 11.3 | Table output uses text/tabwriter for aligned columns                                       | <span class="g">✓</span>       | <span class="r">✗</span> fmt.Printf with manual spacing |
| 11.4 | Default format is human-readable table                                                     | <span class="g">✓</span>       | <span class="g">✓</span>                                |
|      | **12. shell-completion-setup** — Cobra built-in generators + custom completions            | **<span class="g">4/5</span>** | **<span class="r">3/5</span>**                          |
| 12.1 | Completion subcommand supports bash, zsh, fish, powershell                                 | <span class="g">✓</span>       | <span class="g">✓</span>                                |
| 12.2 | Uses Cobra's built-in GenBashCompletionV2, GenZshCompletion, etc.                          | <span class="g">✓</span>       | <span class="g">✓</span>                                |
| 12.3 | Uses RegisterFlagCompletionFunc for --env flag                                             | <span class="g">✓</span>       | <span class="r">✗</span> no custom completions          |
| 12.4 | Uses ValidArgs or cobra.ExactValidArgs for completion command                              | <span class="g">✓</span>       | <span class="g">✓</span>                                |
| 12.5 | Returns cobra.ShellCompDirectiveNoFileComp for non-file flags                              | <span class="r">✗</span>       | <span class="r">✗</span>                                |

</details>

## `golang-concurrency` — v1.0.0

|             | With Skill       | Without Skill   | Delta     |
| ----------- | ---------------- | --------------- | --------- |
| **Overall** | **62/62 (100%)** | **38/62 (61%)** | **+39pp** |

<details>
<summary>Full breakdown (62 assertions across 13 evals)</summary>

**Model:** Claude Opus 4.6 | **Runs:** 13 evals x 2 configs = 26 subagents | **Grading:** Human-as-a-judge

| #    | Assertion                                                                                                              | With                           | Without                                                           |
| ---- | ---------------------------------------------------------------------------------------------------------------------- | ------------------------------ | ----------------------------------------------------------------- |
|      | **1. time-after-in-select-loop** — avoid time.After in loop, use time.NewTimer+Reset                                   | **<span class="g">5/5</span>** | **<span class="r">2/5</span>**                                    |
| 1.1  | Does NOT use time.After inside the loop body                                                                           | <span class="g">✓</span>       | <span class="r">✗</span> uses time.After(5*time.Second) in select |
| 1.2  | Creates time.NewTimer (or time.NewTicker) outside the loop                                                             | <span class="g">✓</span>       | <span class="r">✗</span> no timer created outside loop            |
| 1.3  | Calls timer.Reset() after handling a message or timeout                                                                | <span class="g">✓</span>       | <span class="r">✗</span> no Reset call                            |
| 1.4  | Calls timer.Stop() (or defers it) to clean up the timer                                                                | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 1.5  | Drains the timer channel before Reset when appropriate (if !timer.Stop() { <-timer.C })                                | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
|      | **2. channel-closing-ownership** — only the sender closes a channel                                                    | **<span class="g">5/5</span>** | **<span class="r">3/5</span>**                                    |
| 2.1  | Does NOT close the channel from the consumer/receiver side                                                             | <span class="g">✓</span>       | <span class="r">✗</span> closes from consumer                     |
| 2.2  | Uses a separate signaling mechanism (done channel, context cancellation) for the consumer to tell the producer to stop | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 2.3  | The producer is the one that closes the data channel                                                                   | <span class="g">✓</span>       | <span class="r">✗</span> consumer closes data channel             |
| 2.4  | Explains the panic risk of closing a channel from the receiver side                                                    | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 2.5  | The producer selects on the stop signal alongside its send operation                                                   | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
|      | **3. waitgroup-add-placement** — wg.Add before go statement                                                            | **<span class="g">4/4</span>** | **<span class="g">4/4</span>**                                    |
| 3.1  | Calls wg.Add(1) BEFORE the go statement, not inside the goroutine                                                      | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 3.2  | Calls defer wg.Done() inside the goroutine                                                                             | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 3.3  | Calls wg.Wait() after the loop to wait for all goroutines                                                              | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 3.4  | Does not place wg.Add inside the goroutine function body                                                               | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
|      | **4. channel-direction-in-signatures** — use chan<- and <-chan in function signatures                                  | **<span class="g">5/5</span>** | **<span class="g">4/5</span>**                                    |
| 4.1  | The generator function returns <-chan int (receive-only for callers)                                                   | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 4.2  | The doubler function accepts <-chan int as input parameter                                                             | <span class="g">✓</span>       | <span class="r">✗</span> uses bidirectional chan int              |
| 4.3  | The doubler function returns <-chan int (receive-only for callers)                                                     | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 4.4  | Internally, channels are created as bidirectional but exposed as directional through return types                      | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 4.5  | The producer (generator) closes its output channel with defer close(out)                                               | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
|      | **5. unbuffered-channel-default** — default to unbuffered, justify buffers                                             | **<span class="g">5/5</span>** | **<span class="r">2/5</span>**                                    |
| 5.1  | Recommends starting with unbuffered (or very small buffer like 0 or 1) as the default                                  | <span class="g">✓</span>       | <span class="r">✗</span> suggests buffer of 100                   |
| 5.2  | Explains that large buffers mask backpressure problems                                                                 | <span class="g">✓</span>       | <span class="r">✗</span> no backpressure discussion               |
| 5.3  | States that buffer size should be based on measured need, not arbitrary choice                                         | <span class="g">✓</span>       | <span class="r">✗</span> picks arbitrary size                     |
| 5.4  | Does NOT suggest a large arbitrary buffer (e.g., 100, 1000) without explaining the tradeoffs                           | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 5.5  | Mentions that buffered channels hide the problem of slow consumers                                                     | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
|      | **6. send-copies-not-pointers** — send values through channels, not pointers                                           | **<span class="g">4/4</span>** | **<span class="r">1/4</span>**                                    |
| 6.1  | Sends Task values (not *Task pointers) through the channel, OR explicitly documents why pointers are safe              | <span class="g">✓</span>       | <span class="r">✗</span> sends *Task pointers                     |
| 6.2  | The channel type is chan Task (value type) rather than chan *Task                                                      | <span class="g">✓</span>       | <span class="r">✗</span> uses chan *Task                          |
| 6.3  | Does not mutate the Task struct after sending it on the channel (or sends a copy)                                      | <span class="g">✓</span>       | <span class="r">✗</span> no copy/immutability discussion          |
| 6.4  | If pointers are used, explicitly acknowledges the shared-memory risk and explains the mitigation                       | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
|      | **7. errgroup-vs-waitgroup-decision** — errgroup.SetLimit for bounded concurrent work with errors                      | **<span class="g">5/5</span>** | **<span class="r">3/5</span>**                                    |
| 7.1  | Uses errgroup (golang.org/x/sync/errgroup) instead of sync.WaitGroup for error propagation                             | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 7.2  | Uses errgroup.WithContext to cancel siblings on first error                                                            | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 7.3  | Uses g.SetLimit(10) for bounded concurrency instead of a hand-rolled semaphore                                         | <span class="g">✓</span>       | <span class="r">✗</span> uses semaphore channel                   |
| 7.4  | Does NOT build a manual worker pool with channels and WaitGroup when errgroup suffices                                 | <span class="g">✓</span>       | <span class="r">✗</span> builds manual pool with channels         |
| 7.5  | Each goroutine checks ctx.Done() or uses the context from errgroup.WithContext                                         | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
|      | **8. ctx-done-in-select** — always include ctx.Done() in select to prevent goroutine leaks                             | **<span class="g">5/5</span>** | **<span class="r">3/5</span>**                                    |
| 8.1  | The function accepts a context.Context parameter                                                                       | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 8.2  | Every select statement includes a case <-ctx.Done(): return branch                                                     | <span class="g">✓</span>       | <span class="r">✗</span> missing ctx.Done in output select        |
| 8.3  | Both the read from input channel AND the write to output channel are wrapped in select with ctx.Done()                 | <span class="g">✓</span>       | <span class="r">✗</span> only read has select                     |
| 8.4  | The goroutine exits cleanly when context is cancelled                                                                  | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 8.5  | The output channel is closed when the goroutine exits (defer close)                                                    | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
|      | **9. sync-map-vs-rwmutex-decision** — RWMutex+map for write-heavy overlapping keys                                     | **<span class="g">5/5</span>** | **<span class="r">2/5</span>**                                    |
| 9.1  | Recommends sync.RWMutex + plain map over sync.Map for this write-heavy, overlapping-key pattern                        | <span class="g">✓</span>       | <span class="r">✗</span> recommends sync.Map                      |
| 9.2  | Explains that sync.Map is optimized for write-once/read-many or disjoint key sets                                      | <span class="g">✓</span>       | <span class="r">✗</span> no access-pattern discussion             |
| 9.3  | Explains that for frequent writes with overlapping keys, RWMutex+map is faster                                         | <span class="g">✓</span>       | <span class="r">✗</span> no performance comparison                |
| 9.4  | Does NOT unconditionally recommend sync.Map for any concurrent map scenario                                            | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 9.5  | Mentions that concurrent map read/write without synchronization causes a hard crash                                    | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
|      | **10. sync-pool-reset-before-put** — Reset() before Put(), not after Get()                                             | **<span class="g">5/5</span>** | **<span class="r">3/5</span>**                                    |
| 10.1 | Calls buf.Reset() BEFORE bufPool.Put(buf), not after Get()                                                             | <span class="g">✓</span>       | <span class="r">✗</span> resets after Get()                       |
| 10.2 | Uses defer to ensure the buffer is returned to the pool even on error                                                  | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 10.3 | Does not assume the object from Get() is clean/zeroed                                                                  | <span class="g">✓</span>       | <span class="r">✗</span> assumes clean after Get                  |
| 10.4 | The pool's New function creates a new buffer                                                                           | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 10.5 | Does not store persistent state in pooled objects                                                                      | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
|      | **11. goroutine-panic-recovery** — recover at goroutine boundaries                                                     | **<span class="g">4/4</span>** | **<span class="r">3/4</span>**                                    |
| 11.1 | Adds defer func() { recover() }() or equivalent panic recovery inside the goroutine                                    | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 11.2 | Logs or handles the recovered panic (not just silently swallowed)                                                      | <span class="g">✓</span>       | <span class="r">✗</span> swallows panic silently                  |
| 11.3 | The goroutine has a shutdown mechanism (context, done channel, or similar)                                             | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 11.4 | Mentions that a panic in a goroutine crashes the entire process                                                        | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
|      | **12. singleflight-cache-stampede** — use singleflight to deduplicate concurrent lookups                               | **<span class="g">5/5</span>** | **<span class="g">4/5</span>**                                    |
| 12.1 | Recommends golang.org/x/sync/singleflight as the primary solution                                                      | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 12.2 | Shows usage of group.Do(key, func) where key identifies the deduplicated resource                                      | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 12.3 | Explains that only one goroutine executes the function; others wait and share the result                               | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 12.4 | May combine singleflight with a cache layer for TTL-based caching                                                      | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 12.5 | Does NOT suggest only a plain mutex or only a TTL cache as the solution to thundering herd                             | <span class="g">✓</span>       | <span class="r">✗</span> also suggests mutex as primary approach  |
|      | **13. iterator-vs-goroutine-pipeline** — iterators for sequential CPU-bound transforms                                 | **<span class="g">5/5</span>** | **<span class="g">4/5</span>**                                    |
| 13.1 | Recommends against goroutine+channel pipeline for this purely sequential, in-memory transform                          | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 13.2 | Suggests Go 1.23+ iterators (iter.Seq) or simple slice operations instead                                              | <span class="g">✓</span>       | <span class="r">✗</span> suggests only plain loop                 |
| 13.3 | Explains that goroutine+channel pipelines add overhead without benefit for sequential CPU-bound work                   | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 13.4 | Mentions that goroutine pipelines are appropriate when stages involve I/O or need true parallelism                     | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 13.5 | Does NOT build a multi-goroutine pipeline for this use case                                                            | <span class="g">✓</span>       | <span class="g">✓</span>                                          |

</details>

## `golang-context` — v1.0.0

|             | With Skill      | Without Skill   | Delta     |
| ----------- | --------------- | --------------- | --------- |
| **Overall** | **48/50 (96%)** | **31/50 (62%)** | **+34pp** |

<details>
<summary>Full breakdown (50 assertions across 10 evals)</summary>

**Model:** Claude Opus 4.6 | **Runs:** 10 evals x 2 configs = 20 subagents | **Grading:** Human-as-a-judge

| #    | Assertion                                                                                                      | With                                                                       | Without                                                              |
| ---- | -------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------- | -------------------------------------------------------------------- |
|      | **1. context-background-in-handler** — use r.Context(), not context.Background() in handlers                   | **<span class="g">5/5</span>**                                             | **<span class="g">4/5</span>**                                       |
| 1.1  | Uses r.Context() to obtain the request context, NOT context.Background() inside the handler                    | <span class="g">✓</span>                                                   | <span class="g">✓</span>                                             |
| 1.2  | Passes the same context (or a derived child) to the database query (*Context variant)                          | <span class="g">✓</span>                                                   | <span class="g">✓</span>                                             |
| 1.3  | Passes the same context to the external HTTP call via http.NewRequestWithContext                               | <span class="g">✓</span>                                                   | <span class="g">✓</span>                                             |
| 1.4  | Does NOT use http.NewRequest (without context) for the external service call                                   | <span class="g">✓</span>                                                   | <span class="g">✓</span>                                             |
| 1.5  | Checks ctx.Err() or handles context cancellation when the client disconnects                                   | <span class="g">✓</span>                                                   | <span class="r">✗</span> no ctx.Err() check on disconnect            |
|      | **2. cancel-leak-timeout** — defer cancel() for every WithTimeout, per-attempt timeouts                        | **<span class="g">5/5</span>**                                             | **<span class="g">4/5</span>**                                       |
| 2.1  | Creates a new context.WithTimeout for each retry attempt (not one timeout for all retries)                     | <span class="g">✓</span>                                                   | <span class="g">✓</span>                                             |
| 2.2  | Calls defer cancel() (or cancel() before next iteration) for every WithTimeout call                            | <span class="g">✓</span>                                                   | <span class="g">✓</span>                                             |
| 2.3  | Does NOT discard the cancel function with _ (e.g., ctx, _ = context.WithTimeout(...))                          | <span class="g">✓</span>                                                   | <span class="r">✗</span> discards cancel with _                      |
| 2.4  | Uses http.NewRequestWithContext to attach the per-attempt timeout context                                      | <span class="g">✓</span>                                                   | <span class="g">✓</span>                                             |
| 2.5  | Accepts a parent context parameter and derives timeouts from it                                                | <span class="g">✓</span>                                                   | <span class="g">✓</span>                                             |
|      | **3. context-value-key-type** — unexported key types for context values                                        | **<span class="g">5/5</span>**                                             | **<span class="r">3/5</span>**                                       |
| 3.1  | Uses an unexported type for the context key (e.g., type contextKey string or type tenantKey struct{})          | <span class="g">✓</span>                                                   | <span class="r">✗</span> uses plain string key                       |
| 3.2  | Does NOT use a plain string as the context key                                                                 | <span class="g">✓</span>                                                   | <span class="r">✗</span> context.WithValue(ctx, "tenant_id", ...)    |
| 3.3  | Provides a typed getter function (e.g., TenantIDFromContext) that returns the value with proper type assertion | <span class="g">✓</span>                                                   | <span class="g">✓</span>                                             |
| 3.4  | Provides a setter function or the middleware injects the value using the unexported key                        | <span class="g">✓</span>                                                   | <span class="g">✓</span>                                             |
| 3.5  | The getter handles the case where the value is missing from the context (returns zero value + bool or error)   | <span class="g">✓</span>                                                   | <span class="g">✓</span>                                             |
|      | **4. context-in-struct-trap** — do not store context.Context in a struct field                                 | **<span class="g">5/5</span>**                                             | **<span class="r">3/5</span>**                                       |
| 4.1  | Does NOT store context.Context as a field in the Worker struct                                                 | <span class="g">✓</span>                                                   | <span class="r">✗</span> stores ctx context.Context in struct        |
| 4.2  | Passes context as a parameter to Start() or Run() method                                                       | <span class="g">✓</span>                                                   | <span class="r">✗</span> uses stored struct field context            |
| 4.3  | Uses context cancellation or a done channel for graceful shutdown signaling                                    | <span class="g">✓</span>                                                   | <span class="g">✓</span>                                             |
| 4.4  | Listens to ctx.Done() in a select statement to detect shutdown                                                 | <span class="g">✓</span>                                                   | <span class="g">✓</span>                                             |
| 4.5  | ctx is the first parameter where it appears, named ctx context.Context                                         | <span class="g">✓</span>                                                   | <span class="g">✓</span>                                             |
|      | **5. without-cancel-background-work** — use context.WithoutCancel for background work (Go 1.21+)               | **<span class="g">5/5</span>**                                             | **<span class="r">2/5</span>**                                       |
| 5.1  | Uses context.WithoutCancel to create a context for the audit goroutine                                         | <span class="g">✓</span>                                                   | <span class="r">✗</span> uses context.Background()                   |
| 5.2  | Does NOT pass r.Context() directly to the background audit goroutine                                           | <span class="g">✓</span>                                                   | <span class="g">✓</span>                                             |
| 5.3  | Does NOT use context.Background() for the audit goroutine (that would lose trace_id)                           | <span class="g">✓</span>                                                   | <span class="r">✗</span> uses context.Background()                   |
| 5.4  | The audit goroutine preserves request-scoped values (trace_id) from the original context                       | <span class="g">✓</span>                                                   | <span class="r">✗</span> context.Background() loses all values       |
| 5.5  | Launches the audit as a separate goroutine (go keyword) so the handler can return immediately                  | <span class="g">✓</span>                                                   | <span class="g">✓</span>                                             |
|      | **6. nested-timeout-shorter-wins** — nested timeouts take the shorter deadline                                 | **<span class="r">4/5</span>**                                             | **<span class="r">3/5</span>**                                       |
| 6.1  | Creates the overall 10-second timeout from the parent context                                                  | <span class="g">✓</span>                                                   | <span class="g">✓</span>                                             |
| 6.2  | Creates the cache timeout as a child of the overall context                                                    | <span class="g">✓</span>                                                   | <span class="g">✓</span>                                             |
| 6.3  | Acknowledges that the database timeout is bounded by whatever time remains on the parent                       | <span class="r">✗</span> creates 8s child without noting parent constraint | <span class="r">✗</span> creates independent 8s timeout              |
| 6.4  | Defers cancel() for every WithTimeout call                                                                     | <span class="g">✓</span>                                                   | <span class="g">✓</span>                                             |
| 6.5  | Does NOT create independent context.Background() timeouts that bypass the overall deadline                     | <span class="g">✓</span>                                                   | <span class="r">✗</span> creates context.Background() timeout for DB |
|      | **7. context-todo-vs-background** — use context.TODO() as placeholder, not context.Background()                | **<span class="g">5/5</span>**                                             | **<span class="r">3/5</span>**                                       |
| 7.1  | Uses context.TODO() as the temporary placeholder in functions not yet fully migrated                           | <span class="g">✓</span>                                                   | <span class="r">✗</span> uses context.Background() everywhere        |
| 7.2  | Uses context.Background() only at the true top level (main function or test setup)                             | <span class="g">✓</span>                                                   | <span class="r">✗</span> uses Background() at all levels             |
| 7.3  | Shows a migration path where context.TODO() is gradually replaced as callers are updated                       | <span class="g">✓</span>                                                   | <span class="g">✓</span>                                             |
| 7.4  | Context is always the first parameter, named ctx context.Context                                               | <span class="g">✓</span>                                                   | <span class="g">✓</span>                                             |
| 7.5  | Does NOT pass nil as a context value at any point in the migration                                             | <span class="g">✓</span>                                                   | <span class="g">✓</span>                                             |
|      | **8. db-context-variants** — use *Context database method variants                                             | **<span class="g">5/5</span>**                                             | **<span class="g">5/5</span>**                                       |
| 8.1  | Uses db.QueryRowContext (not db.QueryRow) for GetByID                                                          | <span class="g">✓</span>                                                   | <span class="g">✓</span>                                             |
| 8.2  | Uses db.ExecContext (not db.Exec) for Create, Update, and Delete                                               | <span class="g">✓</span>                                                   | <span class="g">✓</span>                                             |
| 8.3  | Passes the ctx parameter to every database call                                                                | <span class="g">✓</span>                                                   | <span class="g">✓</span>                                             |
| 8.4  | Does NOT ignore the ctx parameter by calling non-context database methods                                      | <span class="g">✓</span>                                                   | <span class="g">✓</span>                                             |
| 8.5  | Each method accepts ctx context.Context as its first parameter                                                 | <span class="g">✓</span>                                                   | <span class="g">✓</span>                                             |
|      | **9. context-values-abuse** — do not stuff infrastructure deps into context values                             | **<span class="g">5/5</span>**                                             | **<span class="g">4/5</span>**                                       |
| 9.1  | Database connection is passed as a struct field or explicit parameter, NOT via context value                   | <span class="g">✓</span>                                                   | <span class="g">✓</span>                                             |
| 9.2  | Logger is passed as a struct field or explicit parameter, NOT via context value                                | <span class="g">✓</span>                                                   | <span class="g">✓</span>                                             |
| 9.3  | Order details are passed as an explicit function parameter, NOT via context value                              | <span class="g">✓</span>                                                   | <span class="g">✓</span>                                             |
| 9.4  | User ID and/or trace ID are stored in context values (these are request-scoped metadata)                       | <span class="g">✓</span>                                                   | <span class="g">✓</span>                                             |
| 9.5  | Distinguishes between infrastructure dependencies (explicit) and request-scoped metadata (context values)      | <span class="g">✓</span>                                                   | <span class="r">✗</span> no explicit distinction made                |
|      | **10. afterfunc-cleanup** — use context.AfterFunc for non-blocking cleanup (Go 1.21+)                          | **<span class="r">4/5</span>**                                             | **<span class="r">2/5</span>**                                       |
| 10.1 | Uses context.AfterFunc to register the cleanup callback                                                        | <span class="g">✓</span>                                                   | <span class="r">✗</span> uses manual goroutine with <-ctx.Done()     |
| 10.2 | Does NOT block the main flow waiting for context cancellation                                                  | <span class="g">✓</span>                                                   | <span class="g">✓</span>                                             |
| 10.3 | The cleanup function removes the temporary file                                                                | <span class="g">✓</span>                                                   | <span class="g">✓</span>                                             |
| 10.4 | Captures the stop function returned by AfterFunc for potential cancellation of the callback                    | <span class="g">✓</span>                                                   | <span class="r">✗</span> no stop function (uses goroutine)           |
| 10.5 | Also includes a defer-based cleanup as a safety net (AfterFunc + defer for belt-and-suspenders)                | <span class="r">✗</span> only AfterFunc, no defer fallback                 | <span class="r">✗</span> only goroutine, no defer fallback           |

</details>

## `golang-continuous-integration` — v1.0.0

|             | With Skill       | Without Skill   | Delta     |
| ----------- | ---------------- | --------------- | --------- |
| **Overall** | **66/66 (100%)** | **27/66 (41%)** | **+59pp** |

<details>
<summary>Full breakdown (66 assertions across 13 evals)</summary>

**Model:** Claude Opus 4.6 | **Grading:** Human-as-judge

| #    | Assertion                                                                                     | With                           | Without                                                           |
| ---- | --------------------------------------------------------------------------------------------- | ------------------------------ | ----------------------------------------------------------------- |
|      | **1. test-workflow-flags** — CI test workflow with required flags and matrix                  | **<span class="g">5/5</span>** | **<span class="r">3/5</span>**                                    |
| 1.1  | Workflow includes `-race` flag in the go test command                                         | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 1.2  | Workflow includes `-shuffle=on` flag in the go test command                                   | <span class="g">✓</span>       | <span class="r">✗</span> omitted shuffle                          |
| 1.3  | Workflow includes `-coverprofile` flag in the go test command                                 | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 1.4  | Strategy uses `fail-fast: false`                                                              | <span class="g">✓</span>       | <span class="r">✗</span> default fail-fast: true                  |
| 1.5  | Go version matrix includes at least 'stable' and one explicit version                         | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
|      | **2. go-mod-tidy-check** — enforce go mod tidy via git diff --exit-code                       | **<span class="g">4/4</span>** | **<span class="r">2/4</span>**                                    |
| 2.1  | Suggests running `go mod tidy` as a CI step                                                   | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 2.2  | Includes `git diff --exit-code` after go mod tidy to detect uncommitted changes               | <span class="g">✓</span>       | <span class="r">✗</span> no git diff check                        |
| 2.3  | The git diff checks go.mod and/or go.sum specifically, or uses a general git diff --exit-code | <span class="g">✓</span>       | <span class="r">✗</span> only runs tidy                           |
| 2.4  | Also includes `go mod verify` or `go mod download` step                                       | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
|      | **3. integration-test-caching** — integration tests with -count=1 and service containers      | **<span class="g">5/5</span>** | **<span class="r">2/5</span>**                                    |
| 3.1  | Uses `-count=1` flag to disable test result caching                                           | <span class="g">✓</span>       | <span class="r">✗</span> no -count=1                              |
| 3.2  | Includes `-race` flag for integration tests                                                   | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 3.3  | Uses build tags (e.g., `-tags=integration`) to separate integration tests                     | <span class="g">✓</span>       | <span class="r">✗</span> no build tags                            |
| 3.4  | Uses GitHub Actions `services` block for PostgreSQL and/or Redis                              | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 3.5  | Includes health check options for service containers                                          | <span class="g">✓</span>       | <span class="r">✗</span> no health checks                         |
|      | **4. security-scanning-pipeline** — full security stack: govulncheck, gosec, CodeQL, Bearer   | **<span class="g">6/6</span>** | **<span class="r">2/6</span>**                                    |
| 4.1  | Recommends govulncheck and explains it only reports actually-called code paths                | <span class="g">✓</span>       | <span class="r">✗</span> mentions govulncheck without call-path   |
| 4.2  | Recommends gosec for Go security scanning                                                     | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 4.3  | Recommends CodeQL and mentions the security-extended or security-and-quality query suite      | <span class="g">✓</span>       | <span class="r">✗</span> no extended suite                        |
| 4.4  | Recommends Bearer for sensitive data flow issues                                              | <span class="g">✓</span>       | <span class="r">✗</span> not mentioned                            |
| 4.5  | Workflow includes `security-events: write` permission for SARIF upload                        | <span class="g">✓</span>       | <span class="r">✗</span> no permission block                      |
| 4.6  | Suggests creating a CodeQL config file to use an extended query suite                         | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
|      | **5. dependabot-grouping-strategy** — group minor/patch, separate majors                      | **<span class="g">6/6</span>** | **<span class="r">3/6</span>**                                    |
| 5.1  | Configures Dependabot for gomod package ecosystem                                             | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 5.2  | Configures Dependabot for github-actions package ecosystem                                    | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 5.3  | Configures Dependabot for docker package ecosystem                                            | <span class="g">✓</span>       | <span class="r">✗</span> omitted docker                           |
| 5.4  | Groups minor and patch Go module updates into a single PR                                     | <span class="g">✓</span>       | <span class="r">✗</span> no grouping                              |
| 5.5  | Major updates are NOT grouped (individual PRs for breaking changes)                           | <span class="g">✓</span>       | <span class="r">✗</span> all updates grouped                      |
| 5.6  | Sets a weekly schedule                                                                        | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
|      | **6. dependabot-auto-merge-security** — auto-merge with actor guard and branch protection     | **<span class="g">5/5</span>** | **<span class="r">0/5</span>**                                    |
| 6.1  | Workflow has `if: github.actor == dependabot[bot]` guard                                      | <span class="g">✓</span>       | <span class="r">✗</span> no actor guard                           |
| 6.2  | Workflow checks metadata to exclude major updates from auto-merge                             | <span class="g">✓</span>       | <span class="r">✗</span> merges all versions                      |
| 6.3  | Warns about `contents: write` and `pull-requests: write` being elevated permissions           | <span class="g">✓</span>       | <span class="r">✗</span> no security warning                      |
| 6.4  | Mentions branch protection rules as the real safety net                                       | <span class="g">✓</span>       | <span class="r">✗</span> not mentioned                            |
| 6.5  | Notes that `github.actor` checks are not fully spoof-proof                                    | <span class="g">✓</span>       | <span class="r">✗</span> not mentioned                            |
|      | **7. renovate-vs-dependabot** — Renovate advantages for monorepos                             | **<span class="g">5/5</span>** | **<span class="r">2/5</span>**                                    |
| 7.1  | Recommends Renovate as an alternative to Dependabot                                           | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 7.2  | Mentions Renovate's gomodTidy feature                                                         | <span class="g">✓</span>       | <span class="r">✗</span> not mentioned                            |
| 7.3  | Mentions Renovate's native automerge without needing a separate workflow                      | <span class="g">✓</span>       | <span class="r">✗</span> not mentioned                            |
| 7.4  | Mentions Renovate's monorepo/workspace support                                                | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 7.5  | Mentions Renovate's better grouping rules                                                     | <span class="g">✓</span>       | <span class="r">✗</span> not mentioned                            |
|      | **8. goreleaser-library-vs-cli** — GoReleaser config for libraries vs CLIs                    | **<span class="g">5/5</span>** | **<span class="r">2/5</span>**                                    |
| 8.1  | Uses `skip: true` in the builds section since libraries don't produce binaries                | <span class="g">✓</span>       | <span class="r">✗</span> includes full build config               |
| 8.2  | Keeps the config minimal (mainly changelog generation)                                        | <span class="g">✓</span>       | <span class="r">✗</span> full CLI-style config                    |
| 8.3  | Mentions that for libraries, a simple `gh release create` may be sufficient                   | <span class="g">✓</span>       | <span class="r">✗</span> not mentioned                            |
| 8.4  | Does NOT include cross-compilation (goos/goarch) in the library config                        | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 8.5  | Includes changelog configuration                                                              | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
|      | **9. docker-workflow-security** — push: false on PRs, per-job permissions, provenance         | **<span class="g">6/6</span>** | **<span class="r">2/6</span>**                                    |
| 9.1  | Sets push to false on pull requests                                                           | <span class="g">✓</span>       | <span class="r">✗</span> pushes on all events                     |
| 9.2  | Uses per-job permissions scoping                                                              | <span class="g">✓</span>       | <span class="r">✗</span> top-level permissions only               |
| 9.3  | Includes QEMU and Buildx setup for multi-platform builds                                      | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 9.4  | Includes provenance and/or SBOM attestation configuration                                     | <span class="g">✓</span>       | <span class="r">✗</span> no attestations                          |
| 9.5  | Includes `packages: write` permission for GHCR push                                           | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 9.6  | Login step is conditional on non-PR events                                                    | <span class="g">✓</span>       | <span class="r">✗</span> unconditional login                      |
|      | **10. permissions-least-privilege** — read-only GITHUB_TOKEN, branch protection, fork PRs     | **<span class="g">7/7</span>** | **<span class="r">3/7</span>**                                    |
| 10.1 | Recommends setting default GITHUB_TOKEN to read-only                                          | <span class="g">✓</span>       | <span class="r">✗</span> not mentioned                            |
| 10.2 | Recommends branch protection with required status checks                                      | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 10.3 | Recommends requiring PR approvals (at least 1)                                                | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 10.4 | Recommends dismissing stale approvals when new commits are pushed                             | <span class="g">✓</span>       | <span class="r">✗</span> not mentioned                            |
| 10.5 | Recommends restricting fork PR workflows for outside collaborators                            | <span class="g">✓</span>       | <span class="r">✗</span> not mentioned                            |
| 10.6 | Warns against `pull_request_target` with untrusted code                                       | <span class="g">✓</span>       | <span class="r">✗</span> not mentioned                            |
| 10.7 | Recommends creating a release environment with required reviewers                             | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
|      | **11. release-workflow-fetch-depth** — fetch-depth: 0 for changelog generation                | **<span class="g">4/4</span>** | **<span class="r">2/4</span>**                                    |
| 11.1 | Checkout step uses `fetch-depth: 0` for full git history                                      | <span class="g">✓</span>       | <span class="r">✗</span> default shallow clone                    |
| 11.2 | Workflow triggers on tag push with a `v*` pattern                                             | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 11.3 | Uses `contents: write` permission for creating releases                                       | <span class="g">✓</span>       | <span class="r">✗</span> no permissions block                     |
| 11.4 | Passes `GITHUB_TOKEN` to GoReleaser                                                           | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
|      | **12. action-version-pinning** — pin to major versions, not branches                          | **<span class="g">3/3</span>** | **<span class="g">2/3</span>**                                    |
| 12.1 | Identifies that using `@master` and `@main` is wrong and insecure                             | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 12.2 | Recommends pinning to major versions like `@v4`, `@v6`                                        | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 12.3 | Explains the risk: branch references can change unexpectedly or be compromised                | <span class="g">✓</span>       | <span class="r">✗</span> identifies problem but no risk reasoning |
|      | **13. coverage-threshold-configuration** — codecov.yml with project and patch targets         | **<span class="g">5/5</span>** | **<span class="r">2/5</span>**                                    |
| 13.1 | Configures `codecov.yml` (not just CLI flags) for coverage thresholds                         | <span class="g">✓</span>       | <span class="r">✗</span> uses CLI flags only                      |
| 13.2 | Sets project target to 80%                                                                    | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 13.3 | Sets a threshold value (e.g., 2%) to allow small drops                                        | <span class="g">✓</span>       | <span class="r">✗</span> no threshold                             |
| 13.4 | Configures patch coverage target for new code in PRs                                          | <span class="g">✓</span>       | <span class="r">✗</span> no patch target                          |
| 13.5 | Coverage upload is conditional on a single matrix entry (e.g., only on stable)                | <span class="g">✓</span>       | <span class="g">✓</span>                                          |

</details>

## `golang-dependency-injection` — v1.0.0

|             | With Skill      | Without Skill   | Delta     |
| ----------- | --------------- | --------------- | --------- |
| **Overall** | **54/55 (98%)** | **28/55 (51%)** | **+47pp** |

<details>
<summary>Full breakdown (55 assertions across 11 evals)</summary>

**Model:** Claude Opus 4.6 | **Grading:** Human-as-judge

| #    | Assertion                                                                                 | With                           | Without                                                           |
| ---- | ----------------------------------------------------------------------------------------- | ------------------------------ | ----------------------------------------------------------------- |
|      | **1. constructor-injection-not-globals** — inject via constructors, not globals or init() | **<span class="g">5/5</span>** | **<span class="r">3/5</span>**                                    |
| 1.1  | Uses constructor injection (NewUserService taking dependencies as parameters)             | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 1.2  | Explicitly advises against package-level variables for service dependencies               | <span class="g">✓</span>       | <span class="r">✗</span> accepts global var approach              |
| 1.3  | Explains why globals are problematic (untestable, hidden dependencies, or coupling)       | <span class="g">✓</span>       | <span class="r">✗</span> no explanation of problems               |
| 1.4  | Does NOT use `init()` for service initialization                                          | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 1.5  | Returns a concrete struct pointer from the constructor, not an interface                  | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
|      | **2. interface-defined-at-consumer** — interfaces defined where consumed, not implemented | **<span class="g">5/5</span>** | **<span class="r">2/5</span>**                                    |
| 2.1  | Defines the interface in the consuming package, not the implementation package            | <span class="g">✓</span>       | <span class="r">✗</span> defines interface next to implementation |
| 2.2  | Explains the principle: accept interfaces, return structs                                 | <span class="g">✓</span>       | <span class="r">✗</span> not stated                               |
| 2.3  | The implementation package returns a concrete struct pointer                              | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 2.4  | The consumer depends on its own locally-defined interface                                 | <span class="g">✓</span>       | <span class="r">✗</span> imports provider interface               |
| 2.5  | Does NOT have the implementation package import the consumer's interface                  | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
|      | **3. container-not-passed-as-dependency** — service locator anti-pattern                  | **<span class="g">5/5</span>** | **<span class="r">2/5</span>**                                    |
| 3.1  | Advises against passing the injector/container as a dependency                            | <span class="g">✓</span>       | <span class="r">✗</span> accepts passing injector                 |
| 3.2  | Identifies this as the service locator anti-pattern                                       | <span class="g">✓</span>       | <span class="r">✗</span> not identified                           |
| 3.3  | Shows that the Injector should only exist at the composition root                         | <span class="g">✓</span>       | <span class="r">✗</span> injector used throughout                 |
| 3.4  | Shows UserService receiving Database and Mailer directly as constructor parameters        | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 3.5  | Shows the provider function using `do.MustInvoke` inside the provider, not inside methods | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
|      | **4. manual-di-for-small-projects** — small projects use manual DI, not a library         | **<span class="g">5/5</span>** | **<span class="r">2/5</span>**                                    |
| 4.1  | Recommends manual constructor injection for a project with only 5 services                | <span class="g">✓</span>       | <span class="r">✗</span> recommends Wire or Fx                    |
| 4.2  | Does NOT recommend a DI library as the primary approach                                   | <span class="g">✓</span>       | <span class="r">✗</span> leads with DI library                    |
| 4.3  | Shows wiring in `main()` with explicit constructor calls in dependency order              | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 4.4  | Initializes infrastructure first, then repositories, then services, then transport        | <span class="g">✓</span>       | <span class="r">✗</span> no layered ordering                      |
| 4.5  | Mentions that a DI library becomes worthwhile at 10-20+ services                          | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
|      | **5. di-library-selection-judgment** — correct library recommendation based on criteria   | **<span class="g">5/5</span>** | **<span class="r">3/5</span>**                                    |
| 5.1  | Recommends samber/do as a strong fit (generics, lifecycle, compile-time safety)           | <span class="g">✓</span>       | <span class="r">✗</span> recommends uber-go/fx                    |
| 5.2  | Explains why uber-go/fx uses reflection (runtime errors, not compile-time)                | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 5.3  | Explains why google/wire lacks built-in lifecycle management                              | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 5.4  | Mentions that samber/do requires Go 1.18+ for generics                                    | <span class="g">✓</span>       | <span class="r">✗</span> samber/do not discussed                  |
| 5.5  | Discusses at least 3 DI library options from the decision table                           | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
|      | **6. wire-build-constraint-and-codegen** — proper google/wire setup with wireinject       | **<span class="g">5/5</span>** | **<span class="r">3/5</span>**                                    |
| 6.1  | Includes `//go:build wireinject` build constraint in the wire.go file                     | <span class="g">✓</span>       | <span class="r">✗</span> omitted build constraint                 |
| 6.2  | Uses `wire.Build` with all provider functions listed                                      | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 6.3  | Shows `wire.Bind` for binding interface to implementation                                 | <span class="g">✓</span>       | <span class="r">✗</span> no wire.Bind shown                       |
| 6.4  | Explains that wire generates wire_gen.go with plain constructor calls                     | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 6.5  | Mentions that wire_gen.go must not be edited manually                                     | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
|      | **7. fx-lifecycle-hooks-pattern** — uber-go/fx OnStart/OnStop hooks for DB connection     | **<span class="g">5/5</span>** | **<span class="g">4/5</span>**                                    |
| 7.1  | Uses `fx.Lifecycle` parameter in the provider function                                    | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 7.2  | Registers OnStart hook for establishing the database connection                           | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 7.3  | Registers OnStop hook for closing the database connection                                 | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 7.4  | Uses `lc.Append(fx.Hook{...})` pattern                                                    | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 7.5  | OnStart and OnStop take `context.Context` as parameter                                    | <span class="g">✓</span>       | <span class="r">✗</span> omitted context parameter                |
|      | **8. testing-with-di-mock-injection** — inject mocks at the interface boundary            | **<span class="g">5/5</span>** | **<span class="g">4/5</span>**                                    |
| 8.1  | Creates a mock implementation of the UserStore interface                                  | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 8.2  | Injects the mock into UserService via the constructor (NewUserService)                    | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 8.3  | Tests both the success path (user found) and the error path (not found)                   | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 8.4  | Does NOT use a real database connection in the test                                       | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 8.5  | The mock is defined in the test file, not as a package-level or global variable           | <span class="g">✓</span>       | <span class="r">✗</span> mock as package-level var                |
|      | **9. shallow-dependency-graph** — deep chains are a design problem                        | **<span class="g">5/5</span>** | **<span class="r">2/5</span>**                                    |
| 9.1  | Identifies the deep dependency chain as a design problem                                  | <span class="g">✓</span>       | <span class="r">✗</span> accepts as normal layered architecture   |
| 9.2  | Recommends flattening the dependency graph                                                | <span class="g">✓</span>       | <span class="r">✗</span> no flattening suggested                  |
| 9.3  | Suggests that most services should depend on repositories and config directly             | <span class="g">✓</span>       | <span class="r">✗</span> keeps transitive chain                   |
| 9.4  | Explains negative consequences of deep chains (fragility, hard to test)                   | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 9.5  | Proposes a concrete restructuring                                                         | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
|      | **10. one-container-per-app-not-per-request** — container created once, not per request   | **<span class="g">5/5</span>** | **<span class="r">2/5</span>**                                    |
| 10.1 | Identifies creating a new container per request as a mistake                              | <span class="g">✓</span>       | <span class="r">✗</span> accepts per-request as reasonable        |
| 10.2 | Recommends one container per application created at startup                               | <span class="g">✓</span>       | <span class="r">✗</span> no single-container guidance             |
| 10.3 | Explains the performance/correctness problem (recreating singletons, no connection reuse) | <span class="g">✓</span>       | <span class="r">✗</span> no performance concern                   |
| 10.4 | Suggests using scopes for request-level isolation if needed                               | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 10.5 | Shows the container being created once in `main()` and services injected into handlers    | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
|      | **11. lazy-vs-eager-initialization** — lazy init preference, singleton vs transient       | **<span class="r">4/5</span>** | **<span class="r">1/5</span>**                                    |
| 11.1 | Recommends lazy initialization (services created on first use, not all at startup)        | <span class="g">✓</span>       | <span class="r">✗</span> recommends eager for everything          |
| 11.2 | Recommends singletons for stateful services like database connections                     | <span class="g">✓</span>       | <span class="g">✓</span>                                          |
| 11.3 | Recommends transients (or factories) for stateless request processing services            | <span class="g">✓</span>       | <span class="r">✗</span> all singletons                           |
| 11.4 | Explains why lazy loading is beneficial (unused services never created, faster startup)   | <span class="r">✗</span>       | <span class="r">✗</span> no lazy benefits explained               |
| 11.5 | Notes which DI libraries support lazy loading (samber/do, fx) vs which don't (wire)       | <span class="g">✓</span>       | <span class="r">✗</span> no library comparison for lazy           |

</details>

## `golang-dependency-management` — v1.0.0

|             | With Skill       | Without Skill   | Delta     |
| ----------- | ---------------- | --------------- | --------- |
| **Overall** | **52/52 (100%)** | **24/52 (46%)** | **+54pp** |

<details>
<summary>Full breakdown (52 assertions across 11 evals)</summary>

**Model:** Claude Opus 4.6 | **Grading:** Human-as-judge

| #    | Assertion                                                                                     | With                           | Without                                                      |
| ---- | --------------------------------------------------------------------------------------------- | ------------------------------ | ------------------------------------------------------------ |
|      | **1. ask-before-adding-dependency** — AI agent must ask before `go get`                       | **<span class="g">5/5</span>** | **<span class="r">1/5</span>**                               |
| 1.1  | Asks the user for confirmation before running `go get`                                        | <span class="g">✓</span>       | <span class="r">✗</span> runs go get immediately             |
| 1.2  | Presents the package name and import path                                                     | <span class="g">✓</span>       | <span class="r">✗</span> installs without showing path       |
| 1.3  | Mentions whether the standard library covers the use case                                     | <span class="g">✓</span>       | <span class="r">✗</span> no stdlib mention                   |
| 1.4  | Lists known alternatives                                                                      | <span class="g">✓</span>       | <span class="r">✗</span> suggests one library directly       |
| 1.5  | Does NOT silently run `go get` without asking first                                           | <span class="g">✓</span>       | <span class="g">✓</span>                                     |
|      | **2. go-sum-must-be-committed** — go.sum is critical for supply-chain security                | **<span class="g">5/5</span>** | **<span class="r">3/5</span>**                               |
| 2.1  | Strongly advises against gitignoring go.sum                                                   | <span class="g">✓</span>       | <span class="g">✓</span>                                     |
| 2.2  | Explains that go.sum contains cryptographic checksums for dependency verification             | <span class="g">✓</span>       | <span class="g">✓</span>                                     |
| 2.3  | Explains the supply-chain security risk: compromised proxy could substitute malicious code    | <span class="g">✓</span>       | <span class="r">✗</span> no supply-chain mention             |
| 2.4  | Mentions `go mod verify` as the mechanism that uses go.sum                                    | <span class="g">✓</span>       | <span class="r">✗</span> not mentioned                       |
| 2.5  | Recommends removing go.sum from .gitignore                                                    | <span class="g">✓</span>       | <span class="g">✓</span>                                     |
|      | **3. patch-only-upgrade-preference** — `go get -u=patch` safer than `go get -u`               | **<span class="g">5/5</span>** | **<span class="r">1/5</span>**                               |
| 3.1  | Recommends `go get -u=patch ./...` as the safer default                                       | <span class="g">✓</span>       | <span class="r">✗</span> recommends `go get -u ./...`        |
| 3.2  | Explains that `-u=patch` only upgrades patch versions (no API changes per semver)             | <span class="g">✓</span>       | <span class="r">✗</span> no distinction made                 |
| 3.3  | Explains that `-u` upgrades minor versions too, which can change behavior                     | <span class="g">✓</span>       | <span class="r">✗</span> no warning about minor              |
| 3.4  | Mentions running `go mod tidy` after upgrading                                                | <span class="g">✓</span>       | <span class="g">✓</span>                                     |
| 3.5  | Does NOT recommend `go get -u ./...` without warning about risk                               | <span class="g">✓</span>       | <span class="r">✗</span> recommends it as primary            |
|      | **4. mvs-algorithm-understanding** — Minimal Version Selection, not latest                    | **<span class="g">5/5</span>** | **<span class="r">3/5</span>**                               |
| 4.1  | Correctly states that Go selects v1.3.0 (not the latest available)                            | <span class="g">✓</span>       | <span class="g">✓</span>                                     |
| 4.2  | Explains MVS: Go picks the highest minimum required, not the latest available                 | <span class="g">✓</span>       | <span class="g">✓</span>                                     |
| 4.3  | Distinguishes MVS from other package managers (npm, pip, cargo)                               | <span class="g">✓</span>       | <span class="r">✗</span> no comparison to other managers     |
| 4.4  | Mentions that MVS provides deterministic builds without a lock file                           | <span class="g">✓</span>       | <span class="r">✗</span> not mentioned                       |
| 4.5  | Explains that go.sum is integrity verification, not version locking                           | <span class="g">✓</span>       | <span class="g">✓</span>                                     |
|      | **5. major-version-suffix-rule** — /v2 suffix for v2+ modules                                 | **<span class="g">5/5</span>** | **<span class="r">4/5</span>**                               |
| 5.1  | States that the module path must include `/v2` suffix                                         | <span class="g">✓</span>       | <span class="g">✓</span>                                     |
| 5.2  | States that all import paths must be updated to include `/v2`                                 | <span class="g">✓</span>       | <span class="g">✓</span>                                     |
| 5.3  | Explains this is Go's import compatibility rule                                               | <span class="g">✓</span>       | <span class="g">✓</span>                                     |
| 5.4  | Mentions that v0 and v1 do NOT have a suffix                                                  | <span class="g">✓</span>       | <span class="r">✗</span> not mentioned                       |
| 5.5  | Notes that v1 and v2 can coexist in the same build                                            | <span class="g">✓</span>       | <span class="g">✓</span>                                     |
|      | **6. replace-directive-library-warning** — replace ignored when consumed as dependency        | **<span class="g">4/4</span>** | **<span class="r">2/4</span>**                               |
| 6.1  | States that replace directives only take effect in the main module's go.mod                   | <span class="g">✓</span>       | <span class="g">✓</span>                                     |
| 6.2  | States that consumers will NOT use the fork                                                   | <span class="g">✓</span>       | <span class="g">✓</span>                                     |
| 6.3  | Recommends removing replace directives before publishing a library                            | <span class="g">✓</span>       | <span class="r">✗</span> no publish warning                  |
| 6.4  | Suggests alternative solutions (upstream the fix, publish fork as separate module)            | <span class="g">✓</span>       | <span class="r">✗</span> no alternatives offered             |
|      | **7. tools-go-pattern** — pin CLI tool versions in go.mod                                     | **<span class="g">5/5</span>** | **<span class="r">1/5</span>**                               |
| 7.1  | Recommends the tools.go pattern (file with `//go:build tools` constraint)                     | <span class="g">✓</span>       | <span class="r">✗</span> suggests `go install @latest` in CI |
| 7.2  | Uses blank imports (`_` imports) to keep tools in go.mod                                      | <span class="g">✓</span>       | <span class="r">✗</span> no blank imports                    |
| 7.3  | The build constraint ensures the file is never compiled into production code                  | <span class="g">✓</span>       | <span class="r">✗</span> no build constraint                 |
| 7.4  | Mentions running `go mod tidy` after creating the tools.go file                               | <span class="g">✓</span>       | <span class="r">✗</span> no tidy mention                     |
| 7.5  | Explains that `go install` then uses the pinned version from go.mod                           | <span class="g">✓</span>       | <span class="g">✓</span>                                     |
|      | **8. govulncheck-call-path-analysis** — static analysis traces call paths to vulnerable funcs | **<span class="g">5/5</span>** | **<span class="r">3/5</span>**                               |
| 8.1  | Recommends govulncheck to check if vulnerability is reachable                                 | <span class="g">✓</span>       | <span class="g">✓</span>                                     |
| 8.2  | Explains that govulncheck uses static analysis to trace call paths                            | <span class="g">✓</span>       | <span class="r">✗</span> no call-path explanation            |
| 8.3  | Explains that if code never calls the affected function, govulncheck will NOT flag it         | <span class="g">✓</span>       | <span class="r">✗</span> not explained                       |
| 8.4  | Shows the `govulncheck ./...` command                                                         | <span class="g">✓</span>       | <span class="g">✓</span>                                     |
| 8.5  | Distinguishes govulncheck from generic CVE scanners                                           | <span class="g">✓</span>       | <span class="g">✓</span>                                     |
|      | **9. go-work-sum-gitignore** — go.work.sum should NOT be committed                            | **<span class="g">5/5</span>** | **<span class="r">2/5</span>**                               |
| 9.1  | States that go.work.sum should NOT be committed                                               | <span class="g">✓</span>       | <span class="r">✗</span> suggests committing both            |
| 9.2  | Recommends adding go.work.sum to .gitignore                                                   | <span class="g">✓</span>       | <span class="r">✗</span> no gitignore mention                |
| 9.3  | Explains that go.work is for development only                                                 | <span class="g">✓</span>       | <span class="g">✓</span>                                     |
| 9.4  | Distinguishes this from go.sum which MUST be committed                                        | <span class="g">✓</span>       | <span class="r">✗</span> treats both the same                |
| 9.5  | May mention that go.work itself can optionally be committed                                   | <span class="g">✓</span>       | <span class="g">✓</span>                                     |
|      | **10. exclude-vs-retract-distinction** — exclude is consumer-side, retract is author-side     | **<span class="g">5/5</span>** | **<span class="r">3/5</span>**                               |
| 10.1 | Uses `retract` for the published library (author-side)                                        | <span class="g">✓</span>       | <span class="g">✓</span>                                     |
| 10.2 | Uses `exclude` for the buggy dependency (consumer-side)                                       | <span class="g">✓</span>       | <span class="r">✗</span> uses replace instead                |
| 10.3 | Explains that retract goes in the library's own go.mod                                        | <span class="g">✓</span>       | <span class="g">✓</span>                                     |
| 10.4 | Explains that exclude redirects to the next higher available version                          | <span class="g">✓</span>       | <span class="r">✗</span> no redirect behavior explained      |
| 10.5 | Notes that retracted versions are still downloadable but not selected by default              | <span class="g">✓</span>       | <span class="g">✓</span>                                     |
|      | **11. test-dependency-upgrade-flag** — `-t` flag for including test deps in upgrades          | **<span class="g">3/3</span>** | **<span class="r">1/3</span>**                               |
| 11.1 | Explains that `go get -u ./...` excludes test-only dependencies by default                    | <span class="g">✓</span>       | <span class="r">✗</span> not explained                       |
| 11.2 | Recommends `go get -u -t ./...` to include test dependencies                                  | <span class="g">✓</span>       | <span class="r">✗</span> suggests upgrading individually     |
| 11.3 | Explains the difference between `-u` and `-u -t`                                              | <span class="g">✓</span>       | <span class="g">✓</span>                                     |

</details>

## `golang-structs-interfaces` — v1.0.0

|             | With Skill       | Without Skill   | Delta     |
| ----------- | ---------------- | --------------- | --------- |
| **Overall** | **52/52 (100%)** | **34/52 (65%)** | **+35pp** |

<details>
<summary>Full breakdown (52 assertions across 11 evals)</summary>

**Model:** Claude Opus 4.6 | **Grading:** Human-as-judge

| #    | Assertion                                                                                     | With                           | Without                                                       |
| ---- | --------------------------------------------------------------------------------------------- | ------------------------------ | ------------------------------------------------------------- |
|      | **1. interface-at-consumer-not-implementor** — notification service using email client        | **<span class="g">5/5</span>** | **<span class="r">2/5</span>**                                |
| 1.1  | Interface is defined in the notification package (the consumer), NOT in the email package     | <span class="g">✓</span>       | <span class="r">✗</span> defines in email package             |
| 1.2  | Interface has only the methods the notification package needs (not the full email.Client API) | <span class="g">✓</span>       | <span class="r">✗</span> mirrors full Client API              |
| 1.3  | Email package exports a concrete Client struct, not an interface                              | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 1.4  | Explains WHY: keeps the consumer in control of the contract, avoids importing for interface   | <span class="g">✓</span>       | <span class="r">✗</span> no rationale given                   |
| 1.5  | Notification service depends on its own interface, not on email package types                 | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
|      | **2. return-structs-not-interfaces** — NewUserService constructor signature                   | **<span class="g">5/5</span>** | **<span class="r">3/5</span>**                                |
| 2.1  | Constructor returns *UserService (concrete type), NOT an interface                            | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 2.2  | Constructor accepts UserStore as an interface parameter (accept interfaces)                   | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 2.3  | Explains WHY: callers get full access to concrete type; consumers can assign to interface     | <span class="g">✓</span>       | <span class="r">✗</span> no rationale                         |
| 2.4  | Explicitly states that returning interfaces from constructors is bad practice                 | <span class="g">✓</span>       | <span class="r">✗</span> presents both as valid               |
| 2.5  | The accept-interfaces-return-structs principle is stated or demonstrated                      | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
|      | **3. premature-interface-trap** — single PostgreSQL implementation repository                 | **<span class="g">5/5</span>** | **<span class="r">1/5</span>**                                |
| 3.1  | Recommends starting with a concrete struct (not an interface) when only one implementation    | <span class="g">✓</span>       | <span class="r">✗</span> creates interface immediately        |
| 3.2  | Mentions the principle: don't design with interfaces, discover them                           | <span class="g">✓</span>       | <span class="r">✗</span> not mentioned                        |
| 3.3  | Suggests extracting an interface LATER when a second consumer or test mock demands it         | <span class="g">✓</span>       | <span class="r">✗</span> creates interface "for testability"  |
| 3.4  | Acknowledges that testability IS a valid reason but it should be a deliberate choice          | <span class="g">✓</span>       | <span class="r">✗</span> reflexively adds interface           |
| 3.5  | Does NOT reflexively recommend creating an interface just because it is a repository          | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
|      | **4. zero-value-useful-design** — Registry panics without NewRegistry                         | **<span class="g">5/5</span>** | **<span class="r">2/5</span>**                                |
| 4.1  | Recommends lazy initialization in the Register method (if r.items == nil)                     | <span class="g">✓</span>       | <span class="r">✗</span> says "always call constructor"       |
| 4.2  | Mentions the Go principle: make the zero value useful                                         | <span class="g">✓</span>       | <span class="r">✗</span> not mentioned                        |
| 4.3  | The fix allows using var r Registry without calling a constructor                             | <span class="g">✓</span>       | <span class="r">✗</span> requires constructor                 |
| 4.4  | Does NOT just say "always use the constructor" as the primary fix                             | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 4.5  | References bytes.Buffer or sync.Mutex as stdlib examples of useful zero values                | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
|      | **5. embedding-vs-named-field** — Server with http.Handler and DataStore                      | **<span class="g">5/5</span>** | **<span class="r">3/5</span>**                                |
| 5.1  | Embeds http.Handler (to promote ServeHTTP to the Server)                                      | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 5.2  | Uses a named field for DataStore (not embedded, methods should not be exposed)                | <span class="g">✓</span>       | <span class="r">✗</span> embeds both                          |
| 5.3  | Explains the embed vs named field rule: embed for "is a", named field for "has a"             | <span class="g">✓</span>       | <span class="r">✗</span> no rule articulated                  |
| 5.4  | Mentions that embedding promotes ALL methods of the inner type, which can be undesirable      | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 5.5  | Notes that the receiver of promoted methods is the inner type, not the outer type             | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
|      | **6. compile-time-interface-check** — MyBuffer implements io.ReadWriter                       | **<span class="g">4/4</span>** | **<span class="r">3/4</span>**                                |
| 6.1  | Uses var _ io.ReadWriter = (*MyBuffer)(nil) pattern                                           | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 6.2  | Places the check near the type definition                                                     | <span class="g">✓</span>       | <span class="r">✗</span> places in test file                  |
| 6.3  | Explains that this costs nothing at runtime                                                   | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 6.4  | Explains that the build fails immediately if MyBuffer stops satisfying the interface          | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
|      | **7. type-assertion-comma-ok** — check if interface{} value is a string                       | **<span class="g">4/4</span>** | **<span class="g">4/4</span>**                                |
| 7.1  | Uses the comma-ok form: s, ok := val.(string)                                                 | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 7.2  | Checks the ok value before using s                                                            | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 7.3  | Warns against bare type assertion (s := val.(string)) because it panics                       | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 7.4  | Handles the !ok case explicitly                                                               | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
|      | **8. optional-behavior-type-assertion** — flush only if writer supports it                    | **<span class="g">5/5</span>** | **<span class="r">3/5</span>**                                |
| 8.1  | Defines a separate Flusher interface with just the Flush method                               | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 8.2  | Function parameter is io.Writer (not a combined interface)                                    | <span class="g">✓</span>       | <span class="r">✗</span> requires WriteFlusher interface      |
| 8.3  | Uses type assertion (f, ok := w.(Flusher)) to check for flush capability                      | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 8.4  | Only calls Flush if the type assertion succeeds                                               | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 8.5  | Mentions this pattern is used in the standard library (e.g. http.Flusher, io.ReaderFrom)      | <span class="g">✓</span>       | <span class="r">✗</span> no stdlib reference                  |
|      | **9. nocopy-sentinel-struct** — prevent ConnPool from being passed by value                   | **<span class="g">5/5</span>** | **<span class="r">1/5</span>**                                |
| 9.1  | Recommends embedding a noCopy sentinel struct                                                 | <span class="g">✓</span>       | <span class="r">✗</span> says "always use pointers"           |
| 9.2  | noCopy implements Lock() and Unlock() methods (empty bodies)                                  | <span class="g">✓</span>       | <span class="r">✗</span> not mentioned                        |
| 9.3  | Explains that go vet will flag copies of structs containing noCopy                            | <span class="g">✓</span>       | <span class="r">✗</span> not mentioned                        |
| 9.4  | Mentions this is the same technique used by sync.WaitGroup, sync.Mutex, or strings.Builder    | <span class="g">✓</span>       | <span class="r">✗</span> not mentioned                        |
| 9.5  | Shows that the struct should be passed by pointer after adding noCopy                         | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
|      | **10. generics-over-any-interface** — generic Contains function for any comparable type       | **<span class="g">5/5</span>** | **<span class="r">4/5</span>**                                |
| 10.1 | Uses generics with a type parameter: func Contains[T comparable]                              | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 10.2 | Does NOT use []any or interface{} parameters                                                  | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 10.3 | Uses the comparable constraint for the type parameter                                         | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 10.4 | Explains WHY: generics preserve type safety, while any loses it                               | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 10.5 | Mentions that any should only be used at true boundaries where type is genuinely unknown      | <span class="g">✓</span>       | <span class="r">✗</span> no boundary guidance                 |
|      | **11. receiver-consistency-rule** — mixed pointer/value receivers on same type                | **<span class="g">4/4</span>** | **<span class="r">2/4</span>**                                |
| 11.1 | Says mixing pointer and value receivers on the same type is wrong or not recommended          | <span class="g">✓</span>       | <span class="r">✗</span> says mixing is fine per-method       |
| 11.2 | Recommends making ALL methods use pointer receivers since one needs to mutate                 | <span class="g">✓</span>       | <span class="g">✓</span>                                      |
| 11.3 | Explains WHY: consistency rule -- if any method uses a pointer receiver, all should           | <span class="g">✓</span>       | <span class="r">✗</span> no consistency principle articulated |
| 11.4 | Mentions that method sets differ for T and *T which affects interface satisfaction            | <span class="g">✓</span>       | <span class="g">✓</span>                                      |

</details>

## `golang-lint` — v1.0.0

|             | With Skill      | Without Skill   | Delta     |
| ----------- | --------------- | --------------- | --------- |
| **Overall** | **49/51 (96%)** | **28/51 (55%)** | **+41pp** |

<details>
<summary>Full breakdown (51 assertions across 11 evals)</summary>

**Model:** Claude Opus 4.6 | **Grading:** Human-as-judge

| #    | Assertion                                                                                          | With                           | Without                                                      |
| ---- | -------------------------------------------------------------------------------------------------- | ------------------------------ | ------------------------------------------------------------ |
|      | **1. nolint-directive-specificity** — linter name + justification on every //nolint                | **<span class="g">5/5</span>** | **<span class="r">3/5</span>**                               |
| 1.1  | Every //nolint specifies the linter name — no bare //nolint                                        | <span class="g">✓</span>       | <span class="r">✗</span> bare //nolint on 3 lines            |
| 1.2  | Every //nolint includes a justification comment                                                    | <span class="g">✓</span>       | <span class="r">✗</span> no justifications                   |
| 1.3  | Type assertion uses //nolint:forcetypeassert with safety explanation                               | <span class="g">✓</span>       | <span class="g">✓</span>                                     |
| 1.4  | Long test uses //nolint:funlen with table-driven justification                                     | <span class="g">✓</span>       | <span class="g">✓</span>                                     |
| 1.5  | Cyclomatic complexity uses //nolint:gocyclo with orchestration justification                       | <span class="g">✓</span>       | <span class="g">✓</span>                                     |
|      | **2. nolint-fix-vs-suppress-judgment** — fix correctness bugs, suppress style issues               | **<span class="g">6/6</span>** | **<span class="g">4/6</span>**                               |
| 2.1  | Recommends FIXING bodyclose — unclosed response bodies leak connections                            | <span class="g">✓</span>       | <span class="g">✓</span>                                     |
| 2.2  | Recommends SUPPRESSING funlen on table-driven test                                                 | <span class="g">✓</span>       | <span class="g">✓</span>                                     |
| 2.3  | Recommends FIXING errcheck on database query in request handler                                    | <span class="g">✓</span>       | <span class="r">✗</span> suppressed as "not critical"        |
| 2.4  | Recommends SUPPRESSING dupl on intentional parallel structure                                      | <span class="g">✓</span>       | <span class="g">✓</span>                                     |
| 2.5  | Recommends FIXING sqlclosecheck — unclosed sql.Rows leak connections                               | <span class="g">✓</span>       | <span class="r">✗</span> suppressed with defer comment       |
| 2.6  | Recommends SUPPRESSING goconst in tests                                                            | <span class="g">✓</span>       | <span class="g">✓</span>                                     |
|      | **3. golangci-yml-version-2-structure** — version: "2", formatters section, linters.enable         | **<span class="g">4/5</span>** | **<span class="r">1/5</span>**                               |
| 3.1  | Config has version: "2" at the top                                                                 | <span class="g">✓</span>       | <span class="r">✗</span> no version field                    |
| 3.2  | Linters listed under linters.enable (not enable-all)                                               | <span class="g">✓</span>       | <span class="r">✗</span> uses enable-all with disable list   |
| 3.3  | gofumpt under formatters.enable, NOT linters.enable                                                | <span class="g">✓</span>       | <span class="r">✗</span> gofumpt in linters.enable           |
| 3.4  | errcheck has check-type-assertions: true in linters.settings                                       | <span class="g">✓</span>       | <span class="g">✓</span>                                     |
| 3.5  | Timeout set under run.timeout: 5m                                                                  | <span class="r">✗</span>       | <span class="r">✗</span>                                     |
|      | **4. linter-categories-correctness-vs-style** — prioritize bug-finding over style                  | **<span class="g">5/5</span>** | **<span class="r">3/5</span>**                               |
| 4.1  | Includes govet and staticcheck as highest-value correctness linters                                | <span class="g">✓</span>       | <span class="g">✓</span>                                     |
| 4.2  | Includes errcheck for unchecked errors                                                             | <span class="g">✓</span>       | <span class="g">✓</span>                                     |
| 4.3  | Prioritizes correctness/safety over style linters                                                  | <span class="g">✓</span>       | <span class="r">✗</span> revive and godot ranked above gosec |
| 4.4  | Includes at least one security linter (bodyclose, gosec, sqlclosecheck)                            | <span class="g">✓</span>       | <span class="r">✗</span> no security linters in top 10       |
| 4.5  | Does NOT include redundant complexity checkers (gocyclo + cyclop)                                  | <span class="g">✓</span>       | <span class="g">✓</span>                                     |
|      | **5. legacy-codebase-incremental-adoption** — new-from-rev, not mass //nolint                      | **<span class="g">5/5</span>** | **<span class="r">3/5</span>**                               |
| 5.1  | Recommends issues.new-from-rev to only lint new/changed code                                       | <span class="g">✓</span>       | <span class="g">✓</span>                                     |
| 5.2  | Does NOT suggest adding //nolint to all 2000+ warnings                                             | <span class="g">✓</span>       | <span class="r">✗</span> suggests mass //nolint annotations  |
| 5.3  | Suggests gradual cleanup of old code over time                                                     | <span class="g">✓</span>       | <span class="g">✓</span>                                     |
| 5.4  | Suggests golangci-lint run --fix for auto-fixable issues                                           | <span class="g">✓</span>       | <span class="g">✓</span>                                     |
| 5.5  | Mentions parallel sub-agents or batching fixes by category                                         | <span class="g">✓</span>       | <span class="r">✗</span> sequential manual cleanup           |
|      | **6. interpreting-lint-output-format** — use linter name to triage fix vs suppress                 | **<span class="g">5/5</span>** | **<span class="r">3/5</span>**                               |
| 6.1  | Identifies errcheck on DB.Close as real issue to fix                                               | <span class="g">✓</span>       | <span class="g">✓</span>                                     |
| 6.2  | Identifies bodyclose as critical resource leak to fix                                              | <span class="g">✓</span>       | <span class="r">✗</span> treats all warnings equally         |
| 6.3  | Identifies unused validateToken as dead code to remove                                             | <span class="g">✓</span>       | <span class="g">✓</span>                                     |
| 6.4  | Evaluates gocyclo based on function nature (orchestration vs complex)                              | <span class="g">✓</span>       | <span class="r">✗</span> blanket "refactor" recommendation   |
| 6.5  | Identifies revive comment warning as lower-priority style issue                                    | <span class="g">✓</span>       | <span class="g">✓</span>                                     |
|      | **7. disabled-linters-with-rationale** — exhaustruct, gochecknoglobals, wrapcheck, mnd, varnamelen | **<span class="g">5/5</span>** | **<span class="r">3/5</span>**                               |
| 7.1  | Recommends AGAINST exhaustruct — breaks zero-value idiom                                           | <span class="g">✓</span>       | <span class="r">✗</span> enables it for "completeness"       |
| 7.2  | Recommends AGAINST gochecknoglobals — valid global uses exist                                      | <span class="g">✓</span>       | <span class="g">✓</span>                                     |
| 7.3  | Recommends AGAINST wrapcheck as default — too noisy                                                | <span class="g">✓</span>       | <span class="r">✗</span> enables it unconditionally          |
| 7.4  | Recommends AGAINST mnd — flags obvious constants like HTTP status codes                            | <span class="g">✓</span>       | <span class="g">✓</span>                                     |
| 7.5  | Recommends AGAINST varnamelen — conflicts with Go's short name idiom                               | <span class="g">✓</span>       | <span class="g">✓</span>                                     |
|      | **8. nolintlint-meta-linter** — enforce proper //nolint hygiene automatically                      | **<span class="g">4/4</span>** | **<span class="r">2/4</span>**                               |
| 8.1  | Recommends enabling nolintlint linter                                                              | <span class="g">✓</span>       | <span class="g">✓</span>                                     |
| 8.2  | Configures require-specific: true                                                                  | <span class="g">✓</span>       | <span class="r">✗</span> no nolintlint config                |
| 8.3  | Configures require-explanation: true                                                               | <span class="g">✓</span>       | <span class="r">✗</span> no nolintlint config                |
| 8.4  | Shows correct location: linters.settings.nolintlint                                                | <span class="g">✓</span>       | <span class="g">✓</span>                                     |
|      | **9. multiple-nolint-comma-syntax** — comma-separated linters in single directive                  | **<span class="g">3/3</span>** | **<span class="r">2/3</span>**                               |
| 9.1  | Uses comma-separated: //nolint:errcheck,gosec — not two directives                                 | <span class="g">✓</span>       | <span class="r">✗</span> two separate //nolint lines         |
| 9.2  | Includes justification explaining both false positives                                             | <span class="g">✓</span>       | <span class="g">✓</span>                                     |
| 9.3  | Directive on same line as flagged code or line above                                               | <span class="g">✓</span>       | <span class="g">✓</span>                                     |
|      | **10. common-config-issues** — timeout, v1-to-v2 migration, linter-not-found                       | **<span class="r">3/4</span>** | **<span class="r">2/4</span>**                               |
| 10.1 | Recommends increasing run.timeout for deadline exceeded                                            | <span class="g">✓</span>       | <span class="g">✓</span>                                     |
| 10.2 | Recommends golangci-lint migrate for v1 config errors                                              | <span class="g">✓</span>       | <span class="r">✗</span> suggests manual rewrite             |
| 10.3 | For linter not found: check version — modernize requires v2.6.0+                                   | <span class="g">✓</span>       | <span class="r">✗</span> suggests reinstalling               |
| 10.4 | Mentions golangci-lint linters to check available linters                                          | <span class="r">✗</span>       | <span class="g">✓</span>                                     |
|      | **11. formatter-vs-linter-distinction** — formatters section, fmt subcommand                       | **<span class="g">4/4</span>** | **<span class="r">2/4</span>**                               |
| 11.1 | gofumpt under formatters.enable, NOT linters.enable                                                | <span class="g">✓</span>       | <span class="r">✗</span> linters.enable                      |
| 11.2 | Sets gofumpt extra-rules: true under formatters.settings                                           | <span class="g">✓</span>       | <span class="g">✓</span>                                     |
| 11.3 | Mentions golangci-lint fmt ./... command for formatting                                            | <span class="g">✓</span>       | <span class="r">✗</span> only golangci-lint run              |
| 11.4 | Notes gci and goimports are redundant with gofumpt                                                 | <span class="g">✓</span>       | <span class="g">✓</span>                                     |

</details>

## `golang-popular-libraries` — v1.0.0

|             | With Skill       | Without Skill   | Delta     |
| ----------- | ---------------- | --------------- | --------- |
| **Overall** | **54/54 (100%)** | **38/54 (70%)** | **+30pp** |

<details>
<summary>Full breakdown (54 assertions across 11 evals)</summary>

**Model:** Claude Opus 4.6 | **Grading:** Human-as-judge

| #    | Assertion                                                                                | With                           | Without                                                         |
| ---- | ---------------------------------------------------------------------------------------- | ------------------------------ | --------------------------------------------------------------- |
|      | **1. stdlib-first-json** — encoding/json before third-party                              | **<span class="g">5/5</span>** | **<span class="g">5/5</span>**                                  |
| 1.1  | Recommends encoding/json as the first option                                             | <span class="g">✓</span>       | <span class="g">✓</span>                                        |
| 1.2  | Third-party alternatives only for specific performance needs                             | <span class="g">✓</span>       | <span class="g">✓</span>                                        |
| 1.3  | Explains stdlib is sufficient for most JSON use cases                                    | <span class="g">✓</span>       | <span class="g">✓</span>                                        |
| 1.4  | Alternatives presented for measured performance requirements                             | <span class="g">✓</span>       | <span class="g">✓</span>                                        |
| 1.5  | Does NOT recommend third-party without first considering stdlib                          | <span class="g">✓</span>       | <span class="g">✓</span>                                        |
|      | **2. pgx-over-lib-pq** — pgx as primary PostgreSQL driver                                | **<span class="g">5/5</span>** | **<span class="r">3/5</span>**                                  |
| 2.1  | Recommends pgx as the primary recommendation                                             | <span class="g">✓</span>       | <span class="r">✗</span> lib/pq as primary                      |
| 2.2  | Mentions pgx is faster than lib/pq                                                       | <span class="g">✓</span>       | <span class="g">✓</span>                                        |
| 2.3  | Notes pgx supports all PostgreSQL types and advanced features                            | <span class="g">✓</span>       | <span class="g">✓</span>                                        |
| 2.4  | May mention lib/pq but positions pgx as preferred                                        | <span class="g">✓</span>       | <span class="g">✓</span>                                        |
| 2.5  | Does NOT recommend lib/pq as primary without mentioning pgx                              | <span class="g">✓</span>       | <span class="r">✗</span> lib/pq recommended first               |
|      | **3. chi-for-minimal-router** — chi when staying close to net/http                       | **<span class="g">5/5</span>** | **<span class="r">3/5</span>**                                  |
| 3.1  | Recommends chi as a strong match for stated requirements                                 | <span class="g">✓</span>       | <span class="r">✗</span> recommends Gin                         |
| 3.2  | Explains chi is lightweight and composes with net/http                                   | <span class="g">✓</span>       | <span class="g">✓</span>                                        |
| 3.3  | Notes chi has minimal dependencies                                                       | <span class="g">✓</span>       | <span class="g">✓</span>                                        |
| 3.4  | May mention Gin/Echo but positions chi as better fit for net/http                        | <span class="g">✓</span>       | <span class="g">✓</span>                                        |
| 3.5  | Does NOT recommend a full framework as primary when user wants to stay close to net/http | <span class="g">✓</span>       | <span class="r">✗</span> Gin as primary recommendation          |
|      | **4. slog-over-external-loggers** — consider log/slog before zap/zerolog                 | **<span class="g">5/5</span>** | **<span class="g">4/5</span>**                                  |
| 4.1  | Mentions log/slog as standard library option (Go 1.21+)                                  | <span class="g">✓</span>       | <span class="g">✓</span>                                        |
| 4.2  | Presents slog as a viable option, not afterthought                                       | <span class="g">✓</span>       | <span class="r">✗</span> brief mention at end                   |
| 4.3  | If recommending external, explains specific value over slog                              | <span class="g">✓</span>       | <span class="g">✓</span>                                        |
| 4.4  | Does NOT skip standard library consideration entirely                                    | <span class="g">✓</span>       | <span class="g">✓</span>                                        |
| 4.5  | May mention zap/zerolog for specific use cases                                           | <span class="g">✓</span>       | <span class="g">✓</span>                                        |
|      | **5. sqlc-vs-orm-decision** — sqlc for compile-time SQL safety                           | **<span class="g">5/5</span>** | **<span class="r">2/5</span>**                                  |
| 5.1  | Recommends sqlc as a primary option for compile-time SQL safety                          | <span class="g">✓</span>       | <span class="r">✗</span> recommends GORM only                   |
| 5.2  | Explains sqlc generates type-safe code with no runtime reflection                        | <span class="g">✓</span>       | <span class="r">✗</span> no mention of sqlc                     |
| 5.3  | Mentions GORM uses runtime reflection — doesn't catch SQL errors at compile time         | <span class="g">✓</span>       | <span class="r">✗</span> GORM presented without caveat          |
| 5.4  | May also mention ent as a code-generated alternative                                     | <span class="g">✓</span>       | <span class="g">✓</span>                                        |
| 5.5  | Does NOT recommend only GORM when user asks for compile-time safety                      | <span class="g">✓</span>       | <span class="g">✓</span>                                        |
|      | **6. rate-limiter-stdlib-first** — golang.org/x/time/rate before third-party             | **<span class="g">5/5</span>** | **<span class="g">4/5</span>**                                  |
| 6.1  | Recommends golang.org/x/time/rate as official option                                     | <span class="g">✓</span>       | <span class="g">✓</span>                                        |
| 6.2  | Explains token bucket algorithm                                                          | <span class="g">✓</span>       | <span class="g">✓</span>                                        |
| 6.3  | May mention Tollbooth/limiter for HTTP middleware integration                            | <span class="g">✓</span>       | <span class="g">✓</span>                                        |
| 6.4  | Does NOT skip the official x/time/rate package                                           | <span class="g">✓</span>       | <span class="r">✗</span> no mention of x/time/rate              |
| 6.5  | Explains when third-party might be preferred (per-IP, distributed)                       | <span class="g">✓</span>       | <span class="g">✓</span>                                        |
|      | **7. franz-go-for-kafka** — franz-go over legacy sarama                                  | **<span class="g">4/4</span>** | **<span class="r">2/4</span>**                                  |
| 7.1  | Recommends franz-go as primary recommendation                                            | <span class="g">✓</span>       | <span class="r">✗</span> sarama as primary                      |
| 7.2  | Describes franz-go as modern, high-performance, feature-complete                         | <span class="g">✓</span>       | <span class="g">✓</span>                                        |
| 7.3  | Does NOT recommend only sarama without mentioning franz-go                               | <span class="g">✓</span>       | <span class="r">✗</span> only sarama mentioned                  |
| 7.4  | May mention sarama but positions franz-go as preferred modern choice                     | <span class="g">✓</span>       | <span class="g">✓</span>                                        |
|      | **8. check-maintenance-before-recommending** — Logrus deprecated, suggest alternatives   | **<span class="g">5/5</span>** | **<span class="g">4/5</span>**                                  |
| 8.1  | Mentions Logrus is deprecated or in maintenance mode                                     | <span class="g">✓</span>       | <span class="g">✓</span>                                        |
| 8.2  | Suggests alternatives: slog, zap, or zerolog                                             | <span class="g">✓</span>       | <span class="g">✓</span>                                        |
| 8.3  | Explains maintained alternatives preferred for new projects                              | <span class="g">✓</span>       | <span class="g">✓</span>                                        |
| 8.4  | Does NOT unconditionally recommend Logrus without deprecation note                       | <span class="g">✓</span>       | <span class="g">✓</span>                                        |
| 8.5  | Prioritizes maturity and maintenance status                                              | <span class="g">✓</span>       | <span class="r">✗</span> mentions deprecation but still says OK |
|      | **9. avoid-unnecessary-wrappers** — warn against thin stdlib wrappers                    | **<span class="g">5/5</span>** | **<span class="g">4/5</span>**                                  |
| 9.1  | Warns against wrapping stdlib without meaningful value                                   | <span class="g">✓</span>       | <span class="g">✓</span>                                        |
| 9.2  | Explains dependencies increase attack surface and maintenance burden                     | <span class="g">✓</span>       | <span class="r">✗</span> no mention of dependency cost          |
| 9.3  | Recommends evaluating whether net/http itself is sufficient                              | <span class="g">✓</span>       | <span class="g">✓</span>                                        |
| 9.4  | Mentions anti-pattern of adding dependencies for marginal convenience                    | <span class="g">✓</span>       | <span class="g">✓</span>                                        |
| 9.5  | Suggests considering dependency footprint relative to value                              | <span class="g">✓</span>       | <span class="g">✓</span>                                        |
|      | **10. testcontainers-for-integration** — testcontainers-go for real service testing      | **<span class="g">5/5</span>** | **<span class="g">5/5</span>**                                  |
| 10.1 | Recommends testcontainers-go for programmatic integration testing                        | <span class="g">✓</span>       | <span class="g">✓</span>                                        |
| 10.2 | Explains testcontainers-go spins up real Docker containers                               | <span class="g">✓</span>       | <span class="g">✓</span>                                        |
| 10.3 | Shows or describes container lifecycle within tests                                      | <span class="g">✓</span>       | <span class="g">✓</span>                                        |
| 10.4 | Positions it as better than manual Docker Compose for test isolation                     | <span class="g">✓</span>       | <span class="g">✓</span>                                        |
| 10.5 | May also mention go-sqlmock for unit-level database testing                              | <span class="g">✓</span>       | <span class="g">✓</span>                                        |
|      | **11. slices-maps-packages-go121** — stdlib slices/maps before external utility libs     | **<span class="g">5/5</span>** | **<span class="r">3/5</span>**                                  |
| 11.1 | Recommends stdlib slices package (Go 1.21+) for Contains, Sort, Reverse                  | <span class="g">✓</span>       | <span class="r">✗</span> recommends samber/lo for everything    |
| 11.2 | Does NOT recommend only external libs for basic slice ops                                | <span class="g">✓</span>       | <span class="r">✗</span> samber/lo as sole recommendation       |
| 11.3 | May mention samber/lo for functional ops (Map, Filter, Reduce)                           | <span class="g">✓</span>       | <span class="g">✓</span>                                        |
| 11.4 | Distinguishes stdlib-covered ops from those requiring external libs                      | <span class="g">✓</span>       | <span class="g">✓</span>                                        |
| 11.5 | Applies the 'standard library first' principle                                           | <span class="g">✓</span>       | <span class="g">✓</span>                                        |

</details>

## `golang-project-layout` — v1.0.0

|             | With Skill       | Without Skill   | Delta     |
| ----------- | ---------------- | --------------- | --------- |
| **Overall** | **55/55 (100%)** | **34/55 (62%)** | **+38pp** |

<details>
<summary>Full breakdown (55 assertions across 11 evals)</summary>

**Model:** Claude Opus 4.6 | **Grading:** Human-as-judge

| #    | Assertion                                                                                                                                 | With                           | Without                                                                                   |
| ---- | ----------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------ | ----------------------------------------------------------------------------------------- |
|      | **1. ask-architecture-before-structuring** — Tests whether the model asks the developer about architecture preference before imposing one | **<span class="g">5/5</span>** | **<span class="r">1/5</span>**                                                            |
| 1.1  | Asks the developer which software architecture they prefer (clean, hexagonal, DDD, flat, etc.)                                            | <span class="g">✓</span>       | <span class="r">✗</span> immediately generates a structure                                |
| 1.2  | Asks about the project scope/size to right-size the structure                                                                             | <span class="g">✓</span>       | <span class="r">✗</span> assumes medium-large project                                     |
| 1.3  | Does NOT immediately impose a specific architecture without asking                                                                        | <span class="g">✓</span>       | <span class="r">✗</span> imposes clean architecture                                       |
| 1.4  | Mentions dependency injection approach as a follow-up question                                                                            | <span class="g">✓</span>       | <span class="r">✗</span> no DI question                                                   |
| 1.5  | Mentions that small projects should not be over-structured                                                                                | <span class="g">✓</span>       | <span class="g">✓</span>                                                                  |
|      | **2. cmd-directory-minimal-logic** — Tests whether the model keeps cmd/ main.go minimal with no business logic                            | **<span class="g">5/5</span>** | **<span class="r">3/5</span>**                                                            |
| 2.1  | Says business logic does NOT belong in cmd/server/main.go                                                                                 | <span class="g">✓</span>       | <span class="g">✓</span>                                                                  |
| 2.2  | Says cmd/ should contain minimal logic: parse flags, wire dependencies, call Run()                                                        | <span class="g">✓</span>       | <span class="r">✗</span> says "mostly initialization" without being specific              |
| 2.3  | Recommends moving business logic to internal/ or pkg/                                                                                     | <span class="g">✓</span>       | <span class="g">✓</span>                                                                  |
| 2.4  | main.go should primarily do dependency wiring and startup                                                                                 | <span class="g">✓</span>       | <span class="g">✓</span>                                                                  |
| 2.5  | NEVER put request parsing, database queries, or response formatting in cmd/                                                               | <span class="g">✓</span>       | <span class="r">✗</span> not explicitly stated                                            |
|      | **3. no-src-utils-helpers-common** — Tests whether the model avoids Java-style src/ directory and generic package names                   | **<span class="g">6/6</span>** | **<span class="r">4/6</span>**                                                            |
| 3.1  | Rejects src/ directory (Go doesn't use /src, it's a Java pattern)                                                                         | <span class="g">✓</span>       | <span class="g">✓</span>                                                                  |
| 3.2  | Rejects utils/ as a generic package name                                                                                                  | <span class="g">✓</span>       | <span class="g">✓</span>                                                                  |
| 3.3  | Rejects helpers/ as a generic package name                                                                                                | <span class="g">✓</span>       | <span class="g">✓</span>                                                                  |
| 3.4  | Rejects common/ as a generic package name                                                                                                 | <span class="g">✓</span>       | <span class="r">✗</span> accepts common/ as reasonable                                    |
| 3.5  | Suggests domain-specific package names instead (e.g. format/, stringconv/)                                                                | <span class="g">✓</span>       | <span class="r">✗</span> suggests renaming to "shared/"                                   |
| 3.6  | Recommends putting main.go inside cmd/{name}/ not at root or in src/                                                                      | <span class="g">✓</span>       | <span class="g">✓</span>                                                                  |
|      | **4. module-naming-conventions** — Tests whether the model follows Go module naming conventions                                           | **<span class="g">5/5</span>** | **<span class="r">4/5</span>**                                                            |
| 4.1  | Identifies option 3 (github.com/jdoe/my-project) as correct                                                                               | <span class="g">✓</span>       | <span class="g">✓</span>                                                                  |
| 4.2  | Rejects option 1 (myproject) -- must match repository URL                                                                                 | <span class="g">✓</span>       | <span class="g">✓</span>                                                                  |
| 4.3  | Rejects option 2 (MyProject) -- must be lowercase only                                                                                    | <span class="g">✓</span>       | <span class="g">✓</span>                                                                  |
| 4.4  | Rejects option 4 (my_project) -- use hyphens not underscores                                                                              | <span class="g">✓</span>       | <span class="r">✗</span> accepts underscores as valid                                     |
| 4.5  | Rejects option 5 (utils) -- not semantic, doesn't match a repo URL                                                                        | <span class="g">✓</span>       | <span class="g">✓</span>                                                                  |
|      | **5. internal-vs-pkg-decision** — Tests whether the model correctly decides between internal/ and pkg/                                    | **<span class="g">5/5</span>** | **<span class="r">4/5</span>**                                                            |
| 5.1  | Puts the shared logging library in pkg/ (useful to external consumers)                                                                    | <span class="g">✓</span>       | <span class="g">✓</span>                                                                  |
| 5.2  | Puts the private request parsing code in internal/ (not exported)                                                                         | <span class="g">✓</span>       | <span class="g">✓</span>                                                                  |
| 5.3  | Explains that internal/ cannot be imported by external packages (Go enforces this)                                                        | <span class="g">✓</span>       | <span class="g">✓</span>                                                                  |
| 5.4  | Mentions that pkg/ should only be used when code is genuinely intended for external use                                                   | <span class="g">✓</span>       | <span class="r">✗</span> treats pkg/ as default location                                  |
| 5.5  | Service/business logic goes in internal/ by default                                                                                       | <span class="g">✓</span>       | <span class="g">✓</span>                                                                  |
|      | **6. workspace-when-to-use** — Tests whether the model recommends go.work only for multi-module scenarios                                 | **<span class="g">4/4</span>** | **<span class="r">3/4</span>**                                                            |
| 6.1  | Recommends AGAINST using go.work for a single-module project                                                                              | <span class="g">✓</span>       | <span class="g">✓</span>                                                                  |
| 6.2  | Explains that go.work is for multiple related Go modules that import each other                                                           | <span class="g">✓</span>       | <span class="g">✓</span>                                                                  |
| 6.3  | Mentions that a single module with multiple packages does not need a workspace                                                            | <span class="g">✓</span>       | <span class="r">✗</span> not explicitly stated                                            |
| 6.4  | Lists valid use cases: monorepo with separate modules, local cross-module development                                                     | <span class="g">✓</span>       | <span class="g">✓</span>                                                                  |
|      | **7. twelve-factor-app-conventions** — Tests whether the model applies 12-Factor App principles for Go services                           | **<span class="g">5/5</span>** | **<span class="r">3/5</span>**                                                            |
| 7.1  | Recommends reading database URL from environment variables, not a checked-in config file                                                  | <span class="g">✓</span>       | <span class="g">✓</span>                                                                  |
| 7.2  | Recommends writing logs to stdout, not to a file                                                                                          | <span class="g">✓</span>       | <span class="r">✗</span> says file logging is fine for development                        |
| 7.3  | References or describes 12-Factor App principles                                                                                          | <span class="g">✓</span>       | <span class="r">✗</span> no 12-Factor reference                                           |
| 7.4  | Mentions that sensitive values (like DB URLs) should never be in config files committed to source control                                 | <span class="g">✓</span>       | <span class="g">✓</span>                                                                  |
| 7.5  | Explains WHY: environment-based config allows different values per deployment without code changes                                        | <span class="g">✓</span>       | <span class="g">✓</span>                                                                  |
|      | **8. library-layout-no-cmd** — Tests whether the model uses the correct layout for a Go library                                           | **<span class="g">5/5</span>** | **<span class="r">2/5</span>**                                                            |
| 8.1  | Public API packages are at the root level (e.g. logger/), NOT inside pkg/ or cmd/                                                         | <span class="g">✓</span>       | <span class="r">✗</span> puts public API in pkg/                                          |
| 8.2  | No cmd/ directory (unless for example binaries)                                                                                           | <span class="g">✓</span>       | <span class="r">✗</span> includes cmd/ with example binary                                |
| 8.3  | Uses internal/ for private implementation details                                                                                         | <span class="g">✓</span>       | <span class="g">✓</span>                                                                  |
| 8.4  | Includes example/ directory for usage examples                                                                                            | <span class="g">✓</span>       | <span class="r">✗</span> no example directory                                             |
| 8.5  | Structure follows the library layout pattern, not the application layout pattern                                                          | <span class="g">✓</span>       | <span class="g">✓</span>                                                                  |
|      | **9. test-file-colocation** — Tests whether the model co-locates test files with the code they test                                       | **<span class="g">5/5</span>** | **<span class="r">3/5</span>**                                                            |
| 9.1  | Recommends co-locating test files with the code they test (same directory)                                                                | <span class="g">✓</span>       | <span class="g">✓</span>                                                                  |
| 9.2  | Test files use the _test.go suffix                                                                                                        | <span class="g">✓</span>       | <span class="g">✓</span>                                                                  |
| 9.3  | Does NOT recommend a centralized tests/ directory for unit tests                                                                          | <span class="g">✓</span>       | <span class="r">✗</span> suggests tests/ for integration tests alongside unit co-location |
| 9.4  | Mentions testdata/ directory for test fixtures                                                                                            | <span class="g">✓</span>       | <span class="r">✗</span> not mentioned                                                    |
| 9.5  | Distinguishes between white-box (same package) and black-box (package_test) testing approaches                                            | <span class="g">✓</span>       | <span class="g">✓</span>                                                                  |
|      | **10. config-sensitive-values-env-only** — Tests whether the model requires sensitive config values from env vars or secret managers      | **<span class="g">5/5</span>** | **<span class="r">3/5</span>**                                                            |
| 10.1 | Rejects putting database password, API keys, and JWT secret in config.yaml                                                                | <span class="g">✓</span>       | <span class="g">✓</span>                                                                  |
| 10.2 | Recommends environment variables for sensitive values                                                                                     | <span class="g">✓</span>       | <span class="g">✓</span>                                                                  |
| 10.3 | May suggest a secret manager as an alternative                                                                                            | <span class="g">✓</span>       | <span class="r">✗</span> only mentions env vars                                           |
| 10.4 | Config files are acceptable for non-sensitive values (port, log level, etc.)                                                              | <span class="g">✓</span>       | <span class="g">✓</span>                                                                  |
| 10.5 | Explains WHY: config files can be accidentally committed, leaked in backups, or visible to other processes                                | <span class="g">✓</span>       | <span class="r">✗</span> says "security best practice" without explaining why             |
|      | **11. multiple-binaries-cmd-structure** — Tests whether the model creates separate subdirectories in cmd/ for each binary                 | **<span class="g">5/5</span>** | **<span class="r">4/5</span>**                                                            |
| 11.1 | Creates separate subdirectories: cmd/server/, cmd/cli/, cmd/migrate/ (or similar names)                                                   | <span class="g">✓</span>       | <span class="g">✓</span>                                                                  |
| 11.2 | Each subdirectory has its own main.go with package main                                                                                   | <span class="g">✓</span>       | <span class="g">✓</span>                                                                  |
| 11.3 | Each binary can be built independently (go build ./cmd/server, etc.)                                                                      | <span class="g">✓</span>       | <span class="g">✓</span>                                                                  |
| 11.4 | Mentions go build ./cmd/... to build all binaries at once                                                                                 | <span class="g">✓</span>       | <span class="r">✗</span> only shows individual builds                                     |
| 11.5 | Business logic is in internal/, not duplicated across cmd/ directories                                                                    | <span class="g">✓</span>       | <span class="g">✓</span>                                                                  |

</details>

## `golang-stay-updated` — v1.0.0

|             | With Skill      | Without Skill   | Delta     |
| ----------- | --------------- | --------------- | --------- |
| **Overall** | **46/50 (92%)** | **18/50 (36%)** | **+56pp** |

<details>
<summary>Full breakdown (50 assertions across 10 evals)</summary>

**Model:** Claude Opus 4.6 | **Grading:** Human-as-judge

| #    | Assertion                                                                                                     | With                                                 | Without                                                  |
| ---- | ------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------- | -------------------------------------------------------- |
|      | **1. go-newsletters-recommendation** — Tests whether the model recommends specific Go newsletters             | **<span class="g">5/5</span>**                       | **<span class="r">2/5</span>**                           |
| 1.1  | Recommends Golang Weekly (golangweekly.com)                                                                   | <span class="g">✓</span>                             | <span class="g">✓</span>                                 |
| 1.2  | Recommends Awesome Go Newsletter (go.libhunt.com)                                                             | <span class="g">✓</span>                             | <span class="r">✗</span> not mentioned                   |
| 1.3  | Advises subscribing to 1-2 newsletters to avoid overload                                                      | <span class="g">✓</span>                             | <span class="r">✗</span> no quantity advice              |
| 1.4  | Mentions these provide curated content, articles, and library updates                                         | <span class="g">✓</span>                             | <span class="g">✓</span>                                 |
| 1.5  | Does not recommend more than 3-4 newsletters (quality over quantity)                                          | <span class="g">✓</span>                             | <span class="r">✗</span> lists 5+ newsletters            |
|      | **2. go-community-channels** — Tests knowledge of specific Go community channels beyond Reddit                | **<span class="g">5/5</span>**                       | **<span class="r">2/5</span>**                           |
| 2.1  | Mentions r/golang subreddit                                                                                   | <span class="g">✓</span>                             | <span class="g">✓</span>                                 |
| 2.2  | Mentions gophers.slack.com (official Go Slack)                                                                | <span class="g">✓</span>                             | <span class="r">✗</span> not mentioned                   |
| 2.3  | Mentions the Go Forum (forum.golangbridge.org)                                                                | <span class="g">✓</span>                             | <span class="r">✗</span> not mentioned                   |
| 2.4  | Mentions golang-nuts Google Group (groups.google.com/g/golang-nuts)                                           | <span class="g">✓</span>                             | <span class="r">✗</span> not mentioned                   |
| 2.5  | Mentions the official Go wiki (go.dev/wiki)                                                                   | <span class="g">✓</span>                             | <span class="g">✓</span>                                 |
|      | **3. go-youtube-channels** — Tests knowledge of specific Go YouTube channels                                  | **<span class="g">5/5</span>**                       | **<span class="r">2/5</span>**                           |
| 3.1  | Recommends the official Go YouTube channel (@golang)                                                          | <span class="g">✓</span>                             | <span class="g">✓</span>                                 |
| 3.2  | Recommends Gopher Academy                                                                                     | <span class="g">✓</span>                             | <span class="r">✗</span> not mentioned                   |
| 3.3  | Recommends GopherCon Europe or GopherCon UK channels                                                          | <span class="g">✓</span>                             | <span class="r">✗</span> only mentions generic GopherCon |
| 3.4  | Recommends Ardan Labs channel                                                                                 | <span class="g">✓</span>                             | <span class="r">✗</span> not mentioned                   |
| 3.5  | Lists at least 3 distinct Go-specific YouTube channels                                                        | <span class="g">✓</span>                             | <span class="g">✓</span>                                 |
|      | **4. famous-go-core-team-members** — Tests knowledge of Go core team members to follow                        | **<span class="g">5/6</span>**                       | **<span class="r">3/6</span>**                           |
| 4.1  | Mentions Rob Pike as a co-creator                                                                             | <span class="g">✓</span>                             | <span class="g">✓</span>                                 |
| 4.2  | Mentions Russ Cox and his role in Go                                                                          | <span class="g">✓</span>                             | <span class="g">✓</span>                                 |
| 4.3  | Mentions Brad Fitzpatrick                                                                                     | <span class="g">✓</span>                             | <span class="r">✗</span> not mentioned                   |
| 4.4  | Mentions Dave Cheney as an influential Go community member                                                    | <span class="g">✓</span>                             | <span class="g">✓</span>                                 |
| 4.5  | Mentions Robert Griesemer as a co-creator                                                                     | <span class="g">✓</span>                             | <span class="r">✗</span> not mentioned                   |
| 4.6  | Provides social media handles or GitHub usernames for at least 3 people                                       | <span class="r">✗</span> handles provided for only 2 | <span class="r">✗</span> no handles provided             |
|      | **5. go-library-authors-to-follow** — Tests knowledge of influential Go library/framework authors             | **<span class="g">5/5</span>**                       | **<span class="r">2/5</span>**                           |
| 5.1  | Mentions Steve Francia (spf13) — Cobra, Viper, Hugo                                                           | <span class="g">✓</span>                             | <span class="g">✓</span>                                 |
| 5.2  | Mentions Mitchell Hashimoto (mitchellh) — Terraform, Consul, Vault                                            | <span class="g">✓</span>                             | <span class="g">✓</span>                                 |
| 5.3  | Mentions Samuel Berthe (samber) — lo, do, oops                                                                | <span class="g">✓</span>                             | <span class="r">✗</span> not mentioned                   |
| 5.4  | Mentions Matt Holt (mholt) — Caddy                                                                            | <span class="g">✓</span>                             | <span class="r">✗</span> not mentioned                   |
| 5.5  | Provides GitHub usernames or X handles for the recommended people                                             | <span class="g">✓</span>                             | <span class="r">✗</span> names only, no handles          |
|      | **6. official-go-resources** — Tests knowledge of official Go resources and tools                             | **<span class="g">5/5</span>**                       | **<span class="r">3/5</span>**                           |
| 6.1  | Mentions go.dev as the official Go website                                                                    | <span class="g">✓</span>                             | <span class="g">✓</span>                                 |
| 6.2  | Mentions pkg.go.dev for package discovery and documentation                                                   | <span class="g">✓</span>                             | <span class="g">✓</span>                                 |
| 6.3  | Mentions tour.golang.org (Go Tour) for interactive learning                                                   | <span class="g">✓</span>                             | <span class="r">✗</span> not mentioned                   |
| 6.4  | Mentions play.golang.org (Go Playground) for testing code                                                     | <span class="g">✓</span>                             | <span class="r">✗</span> not mentioned                   |
| 6.5  | Mentions go.dev/blog (official Go blog) for announcements                                                     | <span class="g">✓</span>                             | <span class="g">✓</span>                                 |
|      | **7. go-blogs-to-follow** — Tests knowledge of must-follow Go blogs                                           | **<span class="g">4/4</span>**                       | **<span class="r">2/4</span>**                           |
| 7.1  | Mentions The Go Blog (go.dev/blog)                                                                            | <span class="g">✓</span>                             | <span class="g">✓</span>                                 |
| 7.2  | Mentions Dave Cheney's blog (dave.cheney.net)                                                                 | <span class="g">✓</span>                             | <span class="g">✓</span>                                 |
| 7.3  | Mentions Ardan Labs Blog (ardanlabs.com/blog)                                                                 | <span class="g">✓</span>                             | <span class="r">✗</span> not mentioned                   |
| 7.4  | Lists at least 3 specific blog names with URLs or authors                                                     | <span class="g">✓</span>                             | <span class="r">✗</span> only 2 blogs listed             |
|      | **8. staying-updated-strategy** — Tests the curated strategy for staying updated without information overload | **<span class="g">5/5</span>**                       | **<span class="r">0/5</span>**                           |
| 8.1  | Recommends subscribing to 1-2 newsletters specifically (not more)                                             | <span class="g">✓</span>                             | <span class="r">✗</span> no specific quantity            |
| 8.2  | Recommends following 10-20 key people on social media                                                         | <span class="g">✓</span>                             | <span class="r">✗</span> no specific number              |
| 8.3  | Recommends checking go.dev/blog weekly for official announcements                                             | <span class="g">✓</span>                             | <span class="r">✗</span> says "regularly" not "weekly"   |
| 8.4  | Recommends joining Go Slack for real-time discussions                                                         | <span class="g">✓</span>                             | <span class="r">✗</span> not mentioned                   |
| 8.5  | Recommends attending GopherCon (virtual or in-person) yearly                                                  | <span class="g">✓</span>                             | <span class="r">✗</span> not mentioned                   |
|      | **9. go-conference-speakers** — Tests knowledge of Go conference speakers and community leaders               | **<span class="g">3/5</span>**                       | **<span class="r">1/5</span>**                           |
| 9.1  | Mentions at least one of: Carlisia Campos, Erik St. Martin, Brian Ketelsen                                    | <span class="r">✗</span> none of the three mentioned | <span class="r">✗</span> none mentioned                  |
| 9.2  | Mentions Mat Ryer or Johnny Boursiquot as Go educators/speakers                                               | <span class="g">✓</span>                             | <span class="r">✗</span> not mentioned                   |
| 9.3  | Mentions GopherCon as the conference to follow                                                                | <span class="g">✓</span>                             | <span class="g">✓</span>                                 |
| 9.4  | Provides specific names with their social handles or GitHub profiles                                          | <span class="r">✗</span> names without handles       | <span class="r">✗</span> no handles                      |
| 9.5  | Lists at least 4 distinct speakers/community leaders                                                          | <span class="g">✓</span>                             | <span class="r">✗</span> only 2 named                    |
|      | **10. go-performance-experts** — Tests knowledge of Go performance and optimization experts                   | **<span class="g">4/5</span>**                       | **<span class="r">1/5</span>**                           |
| 10.1 | Mentions Dmitry Vyukov as a Go performance expert                                                             | <span class="g">✓</span>                             | <span class="r">✗</span> not mentioned                   |
| 10.2 | Mentions Dave Cheney for performance-related Go content                                                       | <span class="g">✓</span>                             | <span class="g">✓</span>                                 |
| 10.3 | Provides GitHub usernames (e.g., dvyukov, davecheney)                                                         | <span class="g">✓</span>                             | <span class="r">✗</span> no usernames                    |
| 10.4 | Mentions Bill Kennedy / Ardan Labs for Go performance training                                                | <span class="r">✗</span> not mentioned               | <span class="r">✗</span> not mentioned                   |
| 10.5 | Mentions Jaana Dogan (rakyll) for Go internals/performance                                                    | <span class="g">✓</span>                             | <span class="r">✗</span> not mentioned                   |

</details>

## `golang-database` — v1.0.0

|             | With Skill      | Without Skill   | Delta     |
| ----------- | --------------- | --------------- | --------- |
| **Overall** | **70/74 (95%)** | **42/74 (57%)** | **+38pp** |

<details>
<summary>Full breakdown (74 assertions across 15 evals)</summary>

**Model:** Claude Opus 4.6 | **Grading:** Human-as-judge

| #    | Assertion                                                                                    | With                           | Without                                                      |
| ---- | -------------------------------------------------------------------------------------------- | ------------------------------ | ------------------------------------------------------------ |
|      | **1. orm-vs-sqlx-pgx-recommendation** — sqlx/pgx over ORMs, explain why ORMs are harmful     | **<span class="g">5/5</span>** | **<span class="r">2/5</span>**                               |
| 1.1  | Recommends sqlx or pgx instead of GORM                                                       | <span class="g">✓</span>       | <span class="r">✗</span> sets up GORM as primary             |
| 1.2  | Explains why ORMs are problematic (N+1, unpredictable SQL, magic hooks, debugging)           | <span class="g">✓</span>       | <span class="r">✗</span> presents GORM positively            |
| 1.3  | Recommends pgx specifically for PostgreSQL due to performance advantage                      | <span class="g">✓</span>       | <span class="r">✗</span> no mention of pgx                   |
| 1.4  | Does NOT set up GORM or ent as the primary database library                                  | <span class="g">✓</span>       | <span class="g">✓</span>                                     |
| 1.5  | Mentions learning ORM API is harder than SQL or that ORMs hide SQL                           | <span class="g">✓</span>       | <span class="g">✓</span>                                     |
|      | **2. exec-vs-query-for-non-select** — use Exec for DELETE/INSERT/UPDATE, not Query           | **<span class="g">5/5</span>** | **<span class="r">3/5</span>**                               |
| 2.1  | Uses ExecContext (not QueryContext) for the DELETE statement                                 | <span class="g">✓</span>       | <span class="r">✗</span> db.QueryContext for DELETE          |
| 2.2  | Uses the *Context variant (ExecContext, not Exec)                                            | <span class="g">✓</span>       | <span class="g">✓</span>                                     |
| 2.3  | Passes ctx to the database call                                                              | <span class="g">✓</span>       | <span class="g">✓</span>                                     |
| 2.4  | Retrieves RowsAffected() from the result                                                     | <span class="g">✓</span>       | <span class="r">✗</span> discards result                     |
| 2.5  | Uses parameterized query (not string concatenation)                                          | <span class="g">✓</span>       | <span class="g">✓</span>                                     |
|      | **3. nullable-column-handling** — pointer fields over sql.NullXxx for NULLable columns       | **<span class="g">5/5</span>** | **<span class="r">2/5</span>**                               |
| 3.1  | Uses pointer types (*string, *time.Time) rather than sql.NullString/sql.NullTime             | <span class="g">✓</span>       | <span class="r">✗</span> sql.NullString and sql.NullTime     |
| 3.2  | Includes db struct tags for sqlx (db:"column_name")                                          | <span class="g">✓</span>       | <span class="g">✓</span>                                     |
| 3.3  | Includes json struct tags                                                                    | <span class="g">✓</span>       | <span class="g">✓</span>                                     |
| 3.4  | Uses json:"bio,omitempty" for bio (omitted when NULL)                                        | <span class="g">✓</span>       | <span class="r">✗</span> no omitempty distinction            |
| 3.5  | Uses json:"deleted_at" without omitempty (appears as null)                                   | <span class="g">✓</span>       | <span class="r">✗</span> omitempty on both nullable fields   |
|      | **4. connection-pool-configuration** — all four pool settings with reasonable values         | **<span class="g">5/5</span>** | **<span class="r">2/5</span>**                               |
| 4.1  | Calls SetMaxOpenConns                                                                        | <span class="g">✓</span>       | <span class="g">✓</span>                                     |
| 4.2  | Calls SetMaxIdleConns                                                                        | <span class="g">✓</span>       | <span class="r">✗</span> not set                             |
| 4.3  | Calls SetConnMaxLifetime                                                                     | <span class="g">✓</span>       | <span class="r">✗</span> not set                             |
| 4.4  | Calls SetConnMaxIdleTime                                                                     | <span class="g">✓</span>       | <span class="r">✗</span> not set                             |
| 4.5  | MaxIdleConns <= MaxOpenConns                                                                 | <span class="g">✓</span>       | <span class="g">✓</span>                                     |
|      | **5. rows-close-and-err-check** — defer Close and rows.Err() check after loop                | **<span class="g">5/5</span>** | **<span class="g">4/5</span>**                               |
| 5.1  | Calls defer rows.Close() immediately after QueryContext                                      | <span class="g">✓</span>       | <span class="g">✓</span>                                     |
| 5.2  | Checks rows.Err() after the for rows.Next() loop                                             | <span class="g">✓</span>       | <span class="r">✗</span> no rows.Err() check                 |
| 5.3  | Returns the error from rows.Err() if non-nil                                                 | <span class="g">✓</span>       | <span class="g">✓</span>                                     |
| 5.4  | Uses QueryContext (not Query) with a context parameter                                       | <span class="g">✓</span>       | <span class="g">✓</span>                                     |
| 5.5  | Checks the error returned by QueryContext before proceeding                                  | <span class="g">✓</span>       | <span class="g">✓</span>                                     |
|      | **6. errnorows-handling-pattern** — sql.ErrNoRows with domain error translation              | **<span class="g">5/5</span>** | **<span class="r">3/5</span>**                               |
| 6.1  | Uses errors.Is(err, sql.ErrNoRows) to check for not-found                                    | <span class="g">✓</span>       | <span class="g">✓</span>                                     |
| 6.2  | Returns a domain-specific error (ErrUserNotFound), NOT raw sql.ErrNoRows                     | <span class="g">✓</span>       | <span class="r">✗</span> returns raw sql.ErrNoRows           |
| 6.3  | Wraps non-ErrNoRows errors with context using fmt.Errorf and %w                              | <span class="g">✓</span>       | <span class="r">✗</span> bare return err                     |
| 6.4  | Uses GetContext (not Get) with the ctx parameter                                             | <span class="g">✓</span>       | <span class="g">✓</span>                                     |
| 6.5  | Uses parameterized query placeholder ($1 or ?)                                               | <span class="g">✓</span>       | <span class="g">✓</span>                                     |
|      | **7. transaction-with-defer-rollback** — BeginTxx, defer Rollback, Commit, FOR UPDATE        | **<span class="g">4/5</span>** | **<span class="r">3/5</span>**                               |
| 7.1  | Uses BeginTxx (or BeginTx) to start a transaction                                            | <span class="g">✓</span>       | <span class="g">✓</span>                                     |
| 7.2  | Calls defer tx.Rollback() immediately after BeginTxx                                         | <span class="g">✓</span>       | <span class="g">✓</span>                                     |
| 7.3  | Uses SELECT ... FOR UPDATE when reading balances                                             | <span class="g">✓</span>       | <span class="r">✗</span> plain SELECT without lock           |
| 7.4  | Sets serializable or repeatable-read isolation level                                         | <span class="r">✗</span>       | <span class="r">✗</span>                                     |
| 7.5  | Calls tx.Commit() at the end of the successful path                                          | <span class="g">✓</span>       | <span class="g">✓</span>                                     |
|      | **8. dynamic-in-clause-with-rebind** — sqlx.In + Rebind pattern                              | **<span class="g">5/5</span>** | **<span class="r">3/5</span>**                               |
| 8.1  | Uses sqlx.In() to expand the IN clause placeholders                                          | <span class="g">✓</span>       | <span class="r">✗</span> manual placeholder building         |
| 8.2  | Calls db.Rebind() after sqlx.In to adjust placeholders                                       | <span class="g">✓</span>       | <span class="r">✗</span> hardcoded $1,$2 placeholders        |
| 8.3  | Passes the expanded args from sqlx.In to the query execution                                 | <span class="g">✓</span>       | <span class="g">✓</span>                                     |
| 8.4  | Uses a *Context method variant                                                               | <span class="g">✓</span>       | <span class="g">✓</span>                                     |
| 8.5  | Handles the error from sqlx.In                                                               | <span class="g">✓</span>       | <span class="g">✓</span>                                     |
|      | **9. dynamic-column-name-allowlist** — allowlist validation, not direct interpolation        | **<span class="g">5/5</span>** | **<span class="r">3/5</span>**                               |
| 9.1  | Validates sort column against an explicit allowlist                                          | <span class="g">✓</span>       | <span class="r">✗</span> direct fmt.Sprintf interpolation    |
| 9.2  | Returns an error if column is not in the allowlist                                           | <span class="g">✓</span>       | <span class="r">✗</span> no validation                       |
| 9.3  | Does NOT pass column name as a parameterized placeholder                                     | <span class="g">✓</span>       | <span class="g">✓</span>                                     |
| 9.4  | Uses fmt.Sprintf ONLY after validation                                                       | <span class="g">✓</span>       | <span class="g">✓</span>                                     |
| 9.5  | Uses a *Context method variant for the query                                                 | <span class="g">✓</span>       | <span class="g">✓</span>                                     |
|      | **10. schema-creation-refusal** — refuse to generate database schemas                        | **<span class="r">3/4</span>** | **<span class="r">1/4</span>**                               |
| 10.1 | Does NOT generate a complete CREATE TABLE schema                                             | <span class="g">✓</span>       | <span class="r">✗</span> generates full schema               |
| 10.2 | Explains why AI-generated schemas are problematic                                            | <span class="g">✓</span>       | <span class="r">✗</span> no caveats                          |
| 10.3 | Recommends human review or dedicated tooling for schema design                               | <span class="r">✗</span>       | <span class="r">✗</span>                                     |
| 10.4 | Mentions schema design requires understanding data volumes/access patterns                   | <span class="g">✓</span>       | <span class="g">✓</span>                                     |
|      | **11. batch-processing-sweet-spot** — 100-1000 rows per batch, not row-by-row or giant batch | **<span class="g">5/5</span>** | **<span class="r">3/5</span>**                               |
| 11.1 | Uses batching with batch size between 100 and 1000 rows                                      | <span class="g">✓</span>       | <span class="r">✗</span> single giant INSERT                 |
| 11.2 | Does NOT insert all 50,000 rows in a single statement                                        | <span class="g">✓</span>       | <span class="r">✗</span> one statement with 50k value tuples |
| 11.3 | Does NOT insert one row at a time in a loop                                                  | <span class="g">✓</span>       | <span class="g">✓</span>                                     |
| 11.4 | Uses NamedExecContext or multi-row INSERT pattern                                            | <span class="g">✓</span>       | <span class="g">✓</span>                                     |
| 11.5 | Handles errors per batch with context about which batch failed                               | <span class="g">✓</span>       | <span class="g">✓</span>                                     |
|      | **12. cursor-pagination-over-offset** — cursor-based pagination instead of OFFSET            | **<span class="g">5/5</span>** | **<span class="r">2/5</span>**                               |
| 12.1 | Uses cursor-based pagination (WHERE created_at > $1) instead of OFFSET                       | <span class="g">✓</span>       | <span class="r">✗</span> OFFSET/LIMIT pattern                |
| 12.2 | Explains why OFFSET is problematic (re-scans skipped rows)                                   | <span class="g">✓</span>       | <span class="r">✗</span> no mention of OFFSET cost           |
| 12.3 | Uses LIMIT with ORDER BY for page size                                                       | <span class="g">✓</span>       | <span class="g">✓</span>                                     |
| 12.4 | Returns a cursor value for the next page                                                     | <span class="g">✓</span>       | <span class="r">✗</span> returns page number                 |
| 12.5 | Uses parameterized queries for the cursor value                                              | <span class="g">✓</span>       | <span class="g">✓</span>                                     |
|      | **13. integration-test-with-build-tags** — build tags + transaction rollback isolation       | **<span class="g">4/5</span>** | **<span class="r">3/5</span>**                               |
| 13.1 | Uses //go:build integration build tag                                                        | <span class="g">✓</span>       | <span class="r">✗</span> no build tag                        |
| 13.2 | Uses transaction-based test isolation (begin tx, rollback in teardown)                       | <span class="g">✓</span>       | <span class="r">✗</span> TRUNCATE in teardown                |
| 13.3 | Does NOT test against production database — uses test DSN or testcontainers                  | <span class="g">✓</span>       | <span class="g">✓</span>                                     |
| 13.4 | Uses testify/suite or similar setup/teardown pattern                                         | <span class="r">✗</span>       | <span class="g">✓</span>                                     |
| 13.5 | Tests actual SQL correctness (not mocked)                                                    | <span class="g">✓</span>       | <span class="g">✓</span>                                     |
|      | **14. avoid-hidden-sql-features** — no triggers, views, stored procedures                    | **<span class="g">4/5</span>** | **<span class="r">2/5</span>**                               |
| 14.1 | Advises against triggers for updated_at                                                      | <span class="g">✓</span>       | <span class="r">✗</span> recommends CREATE TRIGGER           |
| 14.2 | Recommends setting updated_at explicitly in Go code                                          | <span class="g">✓</span>       | <span class="r">✗</span> trigger approach                    |
| 14.3 | Advises against views for the complex query                                                  | <span class="g">✓</span>       | <span class="r">✗</span> recommends CREATE VIEW              |
| 14.4 | Explains hidden SQL features create invisible side effects                                   | <span class="g">✓</span>       | <span class="g">✓</span>                                     |
| 14.5 | Recommends keeping SQL explicit and visible in Go code                                       | <span class="r">✗</span>       | <span class="g">✓</span>                                     |
|      | **15. pgx-copy-for-bulk-postgres** — pgx.CopyFrom using COPY protocol                        | **<span class="g">5/5</span>** | **<span class="r">2/5</span>**                               |
| 15.1 | Recommends pgx.CopyFrom using the COPY protocol                                              | <span class="g">✓</span>       | <span class="r">✗</span> multi-row INSERT only               |
| 15.2 | Shows pgx.CopyFromRows or pgx.CopyFromSlice usage                                            | <span class="g">✓</span>       | <span class="r">✗</span> no COPY usage                       |
| 15.3 | Mentions COPY is significantly faster than multi-row INSERT                                  | <span class="g">✓</span>       | <span class="r">✗</span> no performance comparison           |
| 15.4 | Uses pgx.Identifier for the table name                                                       | <span class="g">✓</span>       | <span class="g">✓</span>                                     |
| 15.5 | Still recommends batching for extremely large datasets                                       | <span class="g">✓</span>       | <span class="g">✓</span>                                     |

</details>

## `golang-grpc` — v1.0.0

|             | With Skill      | Without Skill   | Delta     |
| ----------- | --------------- | --------------- | --------- |
| **Overall** | **53/55 (96%)** | **30/55 (55%)** | **+42pp** |

<details>
<summary>Full breakdown (55 assertions across 11 evals)</summary>

**Model:** Claude Opus 4.6 | **Grading:** Human-as-judge

| #    | Assertion                                                                                       | With                           | Without                                                            |
| ---- | ----------------------------------------------------------------------------------------------- | ------------------------------ | ------------------------------------------------------------------ |
|      | **1. raw-error-vs-status-error** — return status.Errorf with codes, not raw errors              | **<span class="g">5/5</span>** | **<span class="r">3/5</span>**                                     |
| 1.1  | Uses `status.Errorf` (or `status.Error`) for not-found case with `codes.NotFound`               | <span class="g">✓</span>       | <span class="g">✓</span>                                           |
| 1.2  | Uses `status.Errorf` with `codes.Internal` for unexpected errors                                | <span class="g">✓</span>       | <span class="g">✓</span>                                           |
| 1.3  | Does NOT return a raw `fmt.Errorf` or `errors.New` as the gRPC error                            | <span class="g">✓</span>       | <span class="r">✗</span> returns `fmt.Errorf` for fallback         |
| 1.4  | Imports `google.golang.org/grpc/status` and `google.golang.org/grpc/codes`                      | <span class="g">✓</span>       | <span class="g">✓</span>                                           |
| 1.5  | Does NOT leak internal error details in user-facing gRPC message for Internal errors            | <span class="g">✓</span>       | <span class="r">✗</span> passes `err.Error()` to client            |
|      | **2. wrapper-messages-not-bare-types** — Request/Response wrappers, not bare types              | **<span class="g">5/5</span>** | **<span class="r">3/5</span>**                                     |
| 2.1  | Uses `GetProductRequest`/`GetProductResponse` wrappers, not bare string or Product              | <span class="g">✓</span>       | <span class="g">✓</span>                                           |
| 2.2  | Uses `DeleteProductRequest`/`DeleteProductResponse`, not bare string or Empty                   | <span class="g">✓</span>       | <span class="r">✗</span> uses `google.protobuf.Empty` for response |
| 2.3  | Uses `SearchProductsRequest`/`SearchProductsResponse` wrappers                                  | <span class="g">✓</span>       | <span class="g">✓</span>                                           |
| 2.4  | Each wrapper message has properly named fields                                                  | <span class="g">✓</span>       | <span class="g">✓</span>                                           |
| 2.5  | Includes `go_package` option in the proto file                                                  | <span class="g">✓</span>       | <span class="r">✗</span> omitted go_package                        |
|      | **3. proto-directory-organization** — domain-based organization with v1 directories             | **<span class="g">5/5</span>** | **<span class="r">2/5</span>**                                     |
| 3.1  | Organizes proto files by domain (user/, order/ or similar grouping)                             | <span class="g">✓</span>       | <span class="g">✓</span>                                           |
| 3.2  | Includes version directories (v1/ under each domain)                                            | <span class="g">✓</span>       | <span class="r">✗</span> no version directories                    |
| 3.3  | Separates message definitions from service definitions                                          | <span class="g">✓</span>       | <span class="r">✗</span> all in one file per domain                |
| 3.4  | Includes a shared/ or common/ directory for shared messages                                     | <span class="g">✓</span>       | <span class="r">✗</span> no shared directory                       |
| 3.5  | Shows `buf.gen.yaml` with go and go-grpc plugins configured                                     | <span class="g">✓</span>       | <span class="g">✓</span>                                           |
|      | **4. graceful-stop-with-timeout-fallback** — GracefulStop with timeout fallback to Stop         | **<span class="g">5/5</span>** | **<span class="r">2/5</span>**                                     |
| 4.1  | Calls `srv.GracefulStop()` first to drain in-flight RPCs                                        | <span class="g">✓</span>       | <span class="g">✓</span>                                           |
| 4.2  | Has a timeout mechanism that falls back to `srv.Stop()` if GracefulStop takes too long          | <span class="g">✓</span>       | <span class="r">✗</span> only GracefulStop, no timeout fallback    |
| 4.3  | Uses a select statement or timer for the timeout                                                | <span class="g">✓</span>       | <span class="r">✗</span> no select/timer                           |
| 4.4  | Listens for OS signals (SIGINT, SIGTERM or os.Interrupt)                                        | <span class="g">✓</span>       | <span class="g">✓</span>                                           |
| 4.5  | The timeout is reasonable (5-30 seconds)                                                        | <span class="g">✓</span>       | <span class="r">✗</span> no timeout configured                     |
|      | **5. health-check-service-registration** — register health check for Kubernetes probes          | **<span class="g">5/5</span>** | **<span class="r">2/5</span>**                                     |
| 5.1  | Registers `grpc_health_v1.RegisterHealthServer` (or equivalent)                                 | <span class="g">✓</span>       | <span class="r">✗</span> no health service registered              |
| 5.2  | Uses `health.NewServer()` to create the health service                                          | <span class="g">✓</span>       | <span class="r">✗</span> no health server                          |
| 5.3  | Registers interceptors using `grpc.ChainUnaryInterceptor`                                       | <span class="g">✓</span>       | <span class="g">✓</span>                                           |
| 5.4  | Does NOT enable reflection (or explicitly disables it for production)                           | <span class="g">✓</span>       | <span class="r">✗</span> enables reflection                        |
| 5.5  | Includes graceful shutdown handling                                                             | <span class="g">✓</span>       | <span class="g">✓</span>                                           |
|      | **6. client-connection-reuse-and-deadlines** — reuse connections, set deadlines                 | **<span class="r">4/5</span>** | **<span class="r">3/5</span>**                                     |
| 6.1  | Creates the connection once and reuses it                                                       | <span class="g">✓</span>       | <span class="g">✓</span>                                           |
| 6.2  | Uses `context.WithTimeout` (or `context.WithDeadline`) for the RPC call                         | <span class="g">✓</span>       | <span class="g">✓</span>                                           |
| 6.3  | Uses `grpc.NewClient` (not the deprecated `grpc.Dial`)                                          | <span class="r">✗</span>       | <span class="r">✗</span> uses deprecated grpc.Dial                 |
| 6.4  | Includes transport credentials (TLS or explicitly insecure for dev)                             | <span class="g">✓</span>       | <span class="g">✓</span>                                           |
| 6.5  | Properly defers `cancel()` from `context.WithTimeout`                                           | <span class="g">✓</span>       | <span class="r">✗</span> no defer cancel                           |
|      | **7. bufconn-testing-pattern** — in-memory connections for gRPC tests                           | **<span class="g">5/5</span>** | **<span class="r">2/5</span>**                                     |
| 7.1  | Uses `bufconn.Listen` for an in-memory listener                                                 | <span class="g">✓</span>       | <span class="r">✗</span> starts real TCP server                    |
| 7.2  | Uses `grpc.WithContextDialer` with the bufconn dialer                                           | <span class="g">✓</span>       | <span class="r">✗</span> dials localhost TCP                       |
| 7.3  | Verifies the gRPC status code for the not-found case using `status.FromError`                   | <span class="g">✓</span>       | <span class="g">✓</span>                                           |
| 7.4  | Checks that the error code is `codes.NotFound` specifically                                     | <span class="g">✓</span>       | <span class="g">✓</span>                                           |
| 7.5  | Uses `t.Cleanup` or `defer` for cleaning up the server and connection                           | <span class="g">✓</span>       | <span class="r">✗</span> no cleanup                                |
|      | **8. error-code-selection-judgment** — correct gRPC error codes for different scenarios         | **<span class="g">5/5</span>** | **<span class="r">3/5</span>**                                     |
| 8.1  | Uses `codes.InvalidArgument` for missing user_id or empty items                                 | <span class="g">✓</span>       | <span class="g">✓</span>                                           |
| 8.2  | Uses `codes.NotFound` for user not found                                                        | <span class="g">✓</span>       | <span class="g">✓</span>                                           |
| 8.3  | Uses `codes.FailedPrecondition` for insufficient inventory                                      | <span class="g">✓</span>       | <span class="r">✗</span> uses `codes.ResourceExhausted`            |
| 8.4  | Uses `codes.Internal` only for truly unexpected errors                                          | <span class="g">✓</span>       | <span class="r">✗</span> uses Internal for inventory check         |
| 8.5  | Does NOT use `codes.Unknown` for any handled error case                                         | <span class="g">✓</span>       | <span class="g">✓</span>                                           |
|      | **9. unimplemented-server-embedding** — embed UnimplementedXxxServer, not UnsafeXxxServer       | **<span class="g">5/5</span>** | **<span class="g">4/5</span>**                                     |
| 9.1  | Embeds `UnimplementedOrderServiceServer` in the server struct                                   | <span class="g">✓</span>       | <span class="g">✓</span>                                           |
| 9.2  | Does NOT embed `UnsafeOrderServiceServer`                                                       | <span class="g">✓</span>       | <span class="g">✓</span>                                           |
| 9.3  | Implements methods with correct signatures (context, request pointer, response pointer + error) | <span class="g">✓</span>       | <span class="g">✓</span>                                           |
| 9.4  | Uses `status.Errorf` for error returns in handler methods                                       | <span class="g">✓</span>       | <span class="r">✗</span> returns raw errors in some methods        |
| 9.5  | Registers the server with `pb.RegisterOrderServiceServer`                                       | <span class="g">✓</span>       | <span class="g">✓</span>                                           |
|      | **10. client-load-balancing-and-retry** — dns:/// scheme, round_robin, retry config             | **<span class="r">4/5</span>** | **<span class="r">2/5</span>**                                     |
| 10.1 | Uses the `dns:///` scheme for service discovery with headless Kubernetes services               | <span class="g">✓</span>       | <span class="r">✗</span> uses direct address                       |
| 10.2 | Configures `round_robin` load balancing policy via service config                               | <span class="g">✓</span>       | <span class="g">✓</span>                                           |
| 10.3 | Configures retry policy with `retryableStatusCodes` containing UNAVAILABLE                      | <span class="g">✓</span>       | <span class="r">✗</span> no retry config                           |
| 10.4 | Sets `maxAttempts`, `initialBackoff`, `maxBackoff` in the retry policy                          | <span class="r">✗</span>       | <span class="r">✗</span> no retry policy                           |
| 10.5 | Does NOT suggest creating a new connection per request for load distribution                    | <span class="g">✓</span>       | <span class="g">✓</span>                                           |
|      | **11. streaming-over-large-messages** — prefer streaming over large single messages             | **<span class="g">5/5</span>** | **<span class="r">4/5</span>**                                     |
| 11.1 | Recommends server streaming RPC to send records incrementally                                   | <span class="g">✓</span>       | <span class="g">✓</span>                                           |
| 11.2 | Explains why a single large message is problematic (size limits, memory pressure)               | <span class="g">✓</span>       | <span class="g">✓</span>                                           |
| 11.3 | Shows the server streaming pattern with `stream.Send` in a loop                                 | <span class="g">✓</span>       | <span class="g">✓</span>                                           |
| 11.4 | Client reads with `stream.Recv` in a loop, checking for `io.EOF`                                | <span class="g">✓</span>       | <span class="g">✓</span>                                           |
| 11.5 | Does NOT just increase `MaxRecvMsgSize` as the primary solution                                 | <span class="g">✓</span>       | <span class="r">✗</span> suggests increasing MaxRecvMsgSize first  |

</details>

## `golang-samber-do` — v1.0.0

|             | With Skill       | Without Skill   | Delta     |
| ----------- | ---------------- | --------------- | --------- |
| **Overall** | **53/53 (100%)** | **10/53 (19%)** | **+81pp** |

<details>
<summary>Full breakdown (53 assertions across 11 evals)</summary>

**Model:** Claude Opus 4.6 | **Grading:** Human-as-judge

| #    | Assertion                                                                                                                      | With                           | Without                                                              |
| ---- | ------------------------------------------------------------------------------------------------------------------------------ | ------------------------------ | -------------------------------------------------------------------- |
|      | **1. v2-import-not-v1** — Tests whether the model uses samber/do/v2, never v1                                                  | **<span class="g">4/4</span>** | **<span class="r">1/4</span>**                                       |
| 1.1  | Uses go get github.com/samber/do/v2 (not github.com/samber/do without v2)                                                      | <span class="g">✓</span>       | <span class="r">✗</span> installs github.com/samber/do (v1)          |
| 1.2  | Import path is github.com/samber/do/v2 in the code                                                                             | <span class="g">✓</span>       | <span class="r">✗</span> imports github.com/samber/do                |
| 1.3  | Uses do.New() to create the container                                                                                          | <span class="g">✓</span>       | <span class="g">✓</span>                                             |
| 1.4  | Does NOT reference v1 API or import paths anywhere                                                                             | <span class="g">✓</span>       | <span class="r">✗</span> entire example uses v1 paths                |
|      | **2. lazy-vs-eager-vs-transient** — Tests whether the model correctly chooses between lazy, eager, and transient service types | **<span class="g">5/5</span>** | **<span class="r">0/5</span>**                                       |
| 2.1  | Uses do.Provide with do.Eager wrapper (or equivalent) for the database connection that must be ready immediately               | <span class="g">✓</span>       | <span class="r">✗</span> uses do.Provide for all three               |
| 2.2  | Uses do.Provide (lazy, the default) for the user repository that's only needed on demand                                       | <span class="g">✓</span>       | <span class="r">✗</span> does not distinguish lifecycle              |
| 2.3  | Uses do.ProvideTransient for the request logger that needs a fresh instance each time                                          | <span class="g">✓</span>       | <span class="r">✗</span> uses do.Provide for the logger              |
| 2.4  | Correctly distinguishes between the three service lifecycle types                                                              | <span class="g">✓</span>       | <span class="r">✗</span> treats all as lazy                          |
| 2.5  | Does NOT register all three services with the same registration function                                                       | <span class="g">✓</span>       | <span class="r">✗</span> all use do.Provide                          |
|      | **3. implicit-aliasing-invokeAs** — Tests whether the model uses InvokeAs for implicit aliasing instead of explicit aliasing   | **<span class="g">5/5</span>** | **<span class="r">1/5</span>**                                       |
| 3.1  | Registers the concrete type *PostgreSQLDatabase with do.Provide                                                                | <span class="g">✓</span>       | <span class="g">✓</span>                                             |
| 3.2  | Uses do.MustInvokeAs[Database] or do.InvokeAs[Database] to invoke as the interface                                             | <span class="g">✓</span>       | <span class="r">✗</span> uses do.MustAs explicit aliasing            |
| 3.3  | Prefers implicit aliasing (InvokeAs) over explicit aliasing (As/MustAs)                                                        | <span class="g">✓</span>       | <span class="r">✗</span> uses explicit aliasing                      |
| 3.4  | Does NOT require a separate alias registration step for this basic case                                                        | <span class="g">✓</span>       | <span class="r">✗</span> adds do.MustAs step                         |
| 3.5  | The provider function returns the concrete type, not the interface                                                             | <span class="g">✓</span>       | <span class="r">✗</span> returns the interface type                  |
|      | **4. package-organization** — Tests whether the model organizes service registrations using do.Package                         | **<span class="g">5/5</span>** | **<span class="r">0/5</span>**                                       |
| 4.1  | Uses do.Package to group related service registrations into separate packages/modules                                          | <span class="g">✓</span>       | <span class="r">✗</span> registers all in main()                     |
| 4.2  | Creates separate package variables (e.g., infrastructure.Package, service.Package, transport.Package)                          | <span class="g">✓</span>       | <span class="r">✗</span> no package organization                     |
| 4.3  | Passes all packages to do.New() in main.go: do.New(infrastructure.Package, service.Package, transport.Package)                 | <span class="g">✓</span>       | <span class="r">✗</span> uses do.New() then sequential Provide calls |
| 4.4  | Each package groups related services (infra, domain, transport) rather than one giant registration list                        | <span class="g">✓</span>       | <span class="r">✗</span> flat list in main                           |
| 4.5  | Uses do.Lazy wrapper inside do.Package for lazy service registration                                                           | <span class="g">✓</span>       | <span class="r">✗</span> no do.Package usage                         |
|      | **5. scopes-for-lifecycle** — Tests whether the model uses scopes to organize services by lifecycle and visibility             | **<span class="g">5/5</span>** | **<span class="r">1/5</span>**                                       |
| 5.1  | Uses do.Scope to create child scopes for per-request services                                                                  | <span class="g">✓</span>       | <span class="r">✗</span> no scoping used                             |
| 5.2  | Registers global/stateless services (config, logger) in the root container                                                     | <span class="g">✓</span>       | <span class="g">✓</span>                                             |
| 5.3  | Creates a new scope per request for request-scoped services                                                                    | <span class="g">✓</span>       | <span class="r">✗</span> all services in root                        |
| 5.4  | Child scope services can access parent (root) services                                                                         | <span class="g">✓</span>       | <span class="r">✗</span> not demonstrated                            |
| 5.5  | Does NOT register request-scoped services in the root container                                                                | <span class="g">✓</span>       | <span class="r">✗</span> request context in root                     |
|      | **6. testing-clone-override** — Tests whether the model uses container cloning and overrides for testing                       | **<span class="g">5/5</span>** | **<span class="r">1/5</span>**                                       |
| 6.1  | Uses injector.Clone() or do.Clone() to clone the production container                                                          | <span class="g">✓</span>       | <span class="r">✗</span> creates new container from scratch          |
| 6.2  | Uses do.Override or do.OverrideValue to replace the Database with a mock                                                       | <span class="g">✓</span>       | <span class="r">✗</span> uses do.Provide with mock                   |
| 6.3  | Invokes the service under test from the cloned container                                                                       | <span class="g">✓</span>       | <span class="r">✗</span> invokes from fresh container                |
| 6.4  | Does NOT build a completely new container from scratch for each test (unless justified)                                        | <span class="g">✓</span>       | <span class="r">✗</span> builds new container                        |
| 6.5  | The test is isolated — changes to the cloned container don't affect the original                                               | <span class="g">✓</span>       | <span class="g">✓</span>                                             |
|      | **7. health-check-interface** — Tests whether the model implements the Healthchecker interface for service health checks       | **<span class="g">5/5</span>** | **<span class="r">1/5</span>**                                       |
| 7.1  | Implements a HealthCheck() method on the database service struct                                                               | <span class="g">✓</span>       | <span class="r">✗</span> writes standalone healthCheck function      |
| 7.2  | The HealthCheck method signature is either HealthCheck() error or HealthCheck(ctx context.Context) error                       | <span class="g">✓</span>       | <span class="r">✗</span> wrong signature                             |
| 7.3  | Uses do.HealthCheck[Database](injector) to invoke the health check through the container                                       | <span class="g">✓</span>       | <span class="r">✗</span> calls db.Ping() directly                    |
| 7.4  | Does NOT write a standalone function that manually fetches the service and pings it                                            | <span class="g">✓</span>       | <span class="r">✗</span> manual fetch and ping                       |
| 7.5  | The health check actually tests connectivity (e.g., conn.Ping())                                                               | <span class="g">✓</span>       | <span class="g">✓</span>                                             |
|      | **8. graceful-shutdown-interface** — Tests whether the model implements the Shutdowner interface for graceful shutdown         | **<span class="g">5/5</span>** | **<span class="r">1/5</span>**                                       |
| 8.1  | Implements Shutdown() or Shutdown(ctx context.Context) method on services that need cleanup                                    | <span class="g">✓</span>       | <span class="r">✗</span> uses defer db.Close() in main               |
| 8.2  | Uses injector.ShutdownOnSignals or injector.ShutdownOnSignalsWithContext for signal-based shutdown                             | <span class="g">✓</span>       | <span class="r">✗</span> manual signal.Notify                        |
| 8.3  | Passes os.Interrupt or syscall.SIGTERM to the shutdown function                                                                | <span class="g">✓</span>       | <span class="g">✓</span>                                             |
| 8.4  | Does NOT manually implement signal handling and iterate over services to shut them down                                        | <span class="g">✓</span>       | <span class="r">✗</span> manual signal handling loop                 |
| 8.5  | May use context.WithTimeout for shutdown deadline                                                                              | <span class="g">✓</span>       | <span class="r">✗</span> no timeout handling                         |
|      | **9. composition-root-only** — Tests that the container is only accessed at the composition root, not passed around            | **<span class="g">5/5</span>** | **<span class="r">2/5</span>**                                       |
| 9.1  | Advises against passing do.Injector into business logic or handler code                                                        | <span class="g">✓</span>       | <span class="r">✗</span> passes injector to handler                  |
| 9.2  | States that the container should only be accessed at the composition root (main/startup)                                       | <span class="g">✓</span>       | <span class="r">✗</span> no mention of composition root              |
| 9.3  | Shows resolving dependencies in the provider function using do.MustInvoke from the injector parameter                          | <span class="g">✓</span>       | <span class="g">✓</span>                                             |
| 9.4  | The UserHandler receives its dependencies as constructor parameters, not the container                                         | <span class="g">✓</span>       | <span class="r">✗</span> handler stores injector                     |
| 9.5  | Explains that passing the container creates a service locator anti-pattern that hides dependencies                             | <span class="g">✓</span>       | <span class="g">✓</span>                                             |
|      | **10. named-services-same-type** — Tests whether the model uses named services for multiple instances of the same type         | **<span class="g">5/5</span>** | **<span class="r">1/5</span>**                                       |
| 10.1 | Uses do.ProvideNamed to register each database with a distinct name (e.g., 'primary-db', 'replica-db')                         | <span class="g">✓</span>       | <span class="r">✗</span> wraps in PrimaryDB/ReplicaDB types          |
| 10.2 | Uses do.MustInvokeNamed or do.InvokeNamed to retrieve each database by name                                                    | <span class="g">✓</span>       | <span class="r">✗</span> invokes wrapper types                       |
| 10.3 | Both databases are registered as the same type (*sql.DB or a Database interface)                                               | <span class="g">✓</span>       | <span class="r">✗</span> different wrapper types                     |
| 10.4 | Does NOT create unnecessary wrapper types just to distinguish the two databases                                                | <span class="g">✓</span>       | <span class="r">✗</span> creates PrimaryDB and ReplicaDB wrappers    |
| 10.5 | Does NOT overwrite the first registration by using do.Provide twice for the same type                                          | <span class="g">✓</span>       | <span class="g">✓</span>                                             |
|      | **11. struct-injection-with-tags** — Tests knowledge of struct injection using do tags                                         | **<span class="g">4/4</span>** | **<span class="r">1/4</span>**                                       |
| 11.1 | Uses struct field tags with do:"" or do:"service-name" syntax                                                                  | <span class="g">✓</span>       | <span class="r">✗</span> manually invokes each dependency            |
| 11.2 | Uses do.MustInvokeStruct or do.InvokeStruct to populate the struct                                                             | <span class="g">✓</span>       | <span class="r">✗</span> no struct injection                         |
| 11.3 | Shows that do:"" uses the type for resolution and do:"name" uses a named service                                               | <span class="g">✓</span>       | <span class="r">✗</span> unaware of tag-based injection              |
| 11.4 | Does NOT manually call MustInvoke for each field when struct injection is available                                            | <span class="g">✓</span>       | <span class="g">✓</span>                                             |

</details>

## `golang-samber-oops` — v1.0.0

|             | With Skill      | Without Skill   | Delta     |
| ----------- | --------------- | --------------- | --------- |
| **Overall** | **49/52 (94%)** | **18/52 (35%)** | **+60pp** |

<details>
<summary>Full breakdown (52 assertions across 11 evals)</summary>

**Model:** Claude Opus 4.6 | **Grading:** Human-as-judge

| #    | Assertion                                                                                                                                           | With                                                       | Without                                                              |
| ---- | --------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------- | -------------------------------------------------------------------- |
|      | **1. low-cardinality-error-messages** — Tests the critical rule: variable data goes in .With() attributes, not interpolated into the message string | **<span class="g">5/5</span>**                             | **<span class="r">2/5</span>**                                       |
| 1.1  | Uses .With() for user_id, tenant_id, and order_id instead of interpolating them into the message                                                    | <span class="g">✓</span>                                   | <span class="r">✗</span> interpolates all IDs into Errorf            |
| 1.2  | The Errorf/Wrapf message string is static/low-cardinality (no variable interpolation for IDs)                                                       | <span class="g">✓</span>                                   | <span class="r">✗</span> "failed to process order %s for user %s"    |
| 1.3  | Uses the fluent builder pattern (chained method calls)                                                                                              | <span class="g">✓</span>                                   | <span class="g">✓</span>                                             |
| 1.4  | Does NOT use fmt.Errorf or errors.New for the error creation                                                                                        | <span class="g">✓</span>                                   | <span class="g">✓</span>                                             |
| 1.5  | Includes .In() to set the domain/feature context                                                                                                    | <span class="g">✓</span>                                   | <span class="r">✗</span> no .In() call                               |
|      | **2. wrap-nil-passthrough** — Tests that oops.Wrap returns nil if err is nil, so no nil check is needed                                             | **<span class="g">3/3</span>**                             | **<span class="r">0/3</span>**                                       |
| 2.1  | Identifies that the nil check is unnecessary because oops.Wrapf returns nil if err is nil                                                           | <span class="g">✓</span>                                   | <span class="r">✗</span> says code is fine as-is                     |
| 2.2  | Shows the simplified form: return oops.In('processor').Wrapf(err, 'fetch failed') without the if block                                              | <span class="g">✓</span>                                   | <span class="r">✗</span> keeps the if block                          |
| 2.3  | The simplified version removes both the if statement and the separate return nil                                                                    | <span class="g">✓</span>                                   | <span class="r">✗</span> no simplification suggested                 |
|      | **3. layered-error-context** — Tests that each architectural layer should add context via Wrap/Wrapf at package boundaries                          | **<span class="g">5/5</span>**                             | **<span class="r">3/5</span>**                                       |
| 3.1  | Each layer (handler, service, repository) adds its own .In() domain context                                                                         | <span class="g">✓</span>                                   | <span class="r">✗</span> only wraps at handler level                 |
| 3.2  | Each layer wraps the error from the layer below using Wrap or Wrapf                                                                                 | <span class="g">✓</span>                                   | <span class="g">✓</span>                                             |
| 3.3  | Different layers add different context attributes relevant to their scope                                                                           | <span class="g">✓</span>                                   | <span class="g">✓</span>                                             |
| 3.4  | Uses .Tags() for categorization at one or more layers                                                                                               | <span class="g">✓</span>                                   | <span class="r">✗</span> no .Tags() usage                            |
| 3.5  | Handler layer uses .Request() to attach HTTP request context                                                                                        | <span class="g">✓</span>                                   | <span class="g">✓</span>                                             |
|      | **4. public-vs-technical-messages** — Tests the separation between user-safe public messages and technical error details                            | **<span class="g">5/5</span>**                             | **<span class="r">2/5</span>**                                       |
| 4.1  | Uses .Public() to set a user-safe message (e.g., 'Not enough items in stock')                                                                       | <span class="g">✓</span>                                   | <span class="r">✗</span> puts user message in Errorf                 |
| 4.2  | Uses .Errorf() or .Wrapf() for the technical error message (separate from the public message)                                                       | <span class="g">✓</span>                                   | <span class="g">✓</span>                                             |
| 4.3  | Uses .Code() to set a machine-readable error code (e.g., 'insufficient_stock')                                                                      | <span class="g">✓</span>                                   | <span class="r">✗</span> no error code set                           |
| 4.4  | Uses .With() for structured attributes like requested quantity, available stock                                                                     | <span class="g">✓</span>                                   | <span class="r">✗</span> data interpolated into message              |
| 4.5  | Shows how to retrieve the public message using oops.GetPublic(err, fallback)                                                                        | <span class="g">✓</span>                                   | <span class="g">✓</span>                                             |
|      | **5. panic-recovery-goroutine** — Tests that oops.Recover is used at goroutine boundaries to convert panics to structured errors                    | **<span class="g">4/5</span>**                             | **<span class="r">1/5</span>**                                       |
| 5.1  | Uses oops.Recover() or the builder's .Recover() method, not a raw defer/recover                                                                     | <span class="g">✓</span>                                   | <span class="r">✗</span> uses raw defer/recover pattern              |
| 5.2  | The Recover wraps the risky operation in a function passed to Recover                                                                               | <span class="g">✓</span>                                   | <span class="r">✗</span> manual panic handling                       |
| 5.3  | Adds structured context to the recovery (e.g., .In(), .Code(), .With())                                                                             | <span class="g">✓</span>                                   | <span class="r">✗</span> no structured context on recovery           |
| 5.4  | Uses a named return value for the error so Recover can set it                                                                                       | <span class="r">✗</span> omits named return in one variant | <span class="r">✗</span> no named return                             |
| 5.5  | Includes .Hint() for debugging guidance or .Code() for identification                                                                               | <span class="g">✓</span>                                   | <span class="g">✓</span>                                             |
|      | **6. context-propagation-middleware** — Tests knowledge of oops.WithBuilder/oops.FromContext for propagating error context through Go contexts      | **<span class="g">5/5</span>**                             | **<span class="r">0/5</span>**                                       |
| 6.1  | Uses oops.WithBuilder() to store the builder in the Go context in middleware                                                                        | <span class="g">✓</span>                                   | <span class="r">✗</span> passes builder as function parameter        |
| 6.2  | Uses oops.FromContext(ctx) in downstream functions to retrieve the pre-configured builder                                                           | <span class="g">✓</span>                                   | <span class="r">✗</span> no context-based propagation                |
| 6.3  | Middleware sets trace ID, request info, and user context on the builder                                                                             | <span class="g">✓</span>                                   | <span class="r">✗</span> no middleware pattern                       |
| 6.4  | Shows the middleware pattern with http.Handler wrapping                                                                                             | <span class="g">✓</span>                                   | <span class="r">✗</span> no http.Handler wrapper                     |
| 6.5  | Downstream handlers/services can add more context (e.g., .Tags()) on top of the base builder                                                        | <span class="g">✓</span>                                   | <span class="r">✗</span> each handler builds from scratch            |
|      | **7. reusable-builder-pattern** — Tests the pattern of creating a reusable builder at the top of a function and reusing it for multiple error paths | **<span class="g">5/5</span>**                             | **<span class="r">2/5</span>**                                       |
| 7.1  | Creates a single base builder variable at the top of the function with shared context (user, tenant, domain)                                        | <span class="g">✓</span>                                   | <span class="r">✗</span> duplicates builder chain at each error site |
| 7.2  | Each error return path extends the base builder with error-specific attributes using .With() or .Code()                                             | <span class="g">✓</span>                                   | <span class="r">✗</span> full chain repeated                         |
| 7.3  | The base builder is NOT terminated (no .Errorf/.Wrap call) — it's reused                                                                            | <span class="g">✓</span>                                   | <span class="r">✗</span> no shared builder                           |
| 7.4  | Uses .In() on the shared builder for the domain/feature                                                                                             | <span class="g">✓</span>                                   | <span class="g">✓</span>                                             |
| 7.5  | Uses .User() and/or .Tenant() on the shared builder                                                                                                 | <span class="g">✓</span>                                   | <span class="g">✓</span>                                             |
|      | **8. accessing-oops-error-info** — Tests knowledge of the OopsError type assertion to access structured fields                                      | **<span class="g">6/6</span>**                             | **<span class="r">3/6</span>**                                       |
| 8.1  | Type-asserts the error to oops.OopsError                                                                                                            | <span class="g">✓</span>                                   | <span class="g">✓</span>                                             |
| 8.2  | Uses .Code() method to get the error code                                                                                                           | <span class="g">✓</span>                                   | <span class="g">✓</span>                                             |
| 8.3  | Uses .Domain() method to get the domain                                                                                                             | <span class="g">✓</span>                                   | <span class="r">✗</span> tries .In() on the error                    |
| 8.4  | Uses .Tags() method to get the tags                                                                                                                 | <span class="g">✓</span>                                   | <span class="r">✗</span> not accessed                                |
| 8.5  | Uses .Context() method to get the key-value attributes map                                                                                          | <span class="g">✓</span>                                   | <span class="r">✗</span> tries .Attributes()                         |
| 8.6  | Uses .Stacktrace() method to get the stack trace                                                                                                    | <span class="g">✓</span>                                   | <span class="g">✓</span>                                             |
|      | **9. user-and-tenant-context** — Tests the .User() and .Tenant() methods with their key-value attribute support                                     | **<span class="g">5/5</span>**                             | **<span class="r">1/5</span>**                                       |
| 9.1  | Uses .User(id, key, value) method with the user ID and additional attributes like email                                                             | <span class="g">✓</span>                                   | <span class="r">✗</span> uses .With("user_id", id)                   |
| 9.2  | Uses .Tenant(id, key, value) method with the tenant ID and additional attributes like plan                                                          | <span class="g">✓</span>                                   | <span class="r">✗</span> uses .With("tenant_id", id)                 |
| 9.3  | Does NOT just use .With() for user/tenant info when .User()/.Tenant() are available                                                                 | <span class="g">✓</span>                                   | <span class="r">✗</span> only uses .With()                           |
| 9.4  | Includes a .Code() for the permission error                                                                                                         | <span class="g">✓</span>                                   | <span class="r">✗</span> no error code                               |
| 9.5  | Uses .Public() for a user-facing permission denied message                                                                                          | <span class="g">✓</span>                                   | <span class="g">✓</span>                                             |
|      | **10. oops-assertions** — Tests knowledge of oops.Assert/oops.Assertf for invariant checks wrapped in Recover                                       | **<span class="g">3/5</span>**                             | **<span class="r">1/5</span>**                                       |
| 10.1 | Uses oops.Assertf or oops.Assert to check the invariant (amount > 0)                                                                                | <span class="g">✓</span>                                   | <span class="r">✗</span> uses if/return error pattern                |
| 10.2 | Wraps the assertion in an oops.Recover() call to convert the panic to a structured error                                                            | <span class="r">✗</span> Recover missing in one code path  | <span class="r">✗</span> no Recover wrapping                         |
| 10.3 | Uses a named error return value so Recover can set it                                                                                               | <span class="r">✗</span> omits named return                | <span class="r">✗</span> no named return                             |
| 10.4 | Notes that assertions should be rare in Go and used only for truly impossible/bug states                                                            | <span class="g">✓</span>                                   | <span class="r">✗</span> no caveat about rare usage                  |
| 10.5 | Adds structured context (.In(), .Code(), etc.) to the Recover builder                                                                               | <span class="g">✓</span>                                   | <span class="g">✓</span>                                             |
|      | **11. oops-configuration** — Tests knowledge of oops global configuration options                                                                   | **<span class="g">3/3</span>**                             | **<span class="r">3/3</span>**                                       |
| 11.1 | Uses oops.StackTraceMaxDepth to control stack trace depth                                                                                           | <span class="g">✓</span>                                   | <span class="g">✓</span>                                             |
| 11.2 | Uses oops.Local with time.LoadLocation for timezone configuration                                                                                   | <span class="g">✓</span>                                   | <span class="g">✓</span>                                             |
| 11.3 | Mentions oops.SourceFragmentsHidden as another available configuration option                                                                       | <span class="g">✓</span>                                   | <span class="g">✓</span>                                             |

</details>

## `golang-stretchr-testify` — v1.0.0

|             | With Skill       | Without Skill   | Delta     |
| ----------- | ---------------- | --------------- | --------- |
| **Overall** | **47/47 (100%)** | **25/47 (53%)** | **+47pp** |

<details>
<summary>Full breakdown (47 assertions across 11 evals)</summary>

**Model:** Claude Opus 4.6 | **Grading:** Human-as-judge

| #    | Assertion                                                                                                                                | With                           | Without                                                        |
| ---- | ---------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------ | -------------------------------------------------------------- |
|      | **1. assert-vs-require-precondition** — Tests whether the model uses require for preconditions and assert for verifications              | **<span class="g">5/5</span>** | **<span class="r">3/5</span>**                                 |
| 1.1  | Uses require (not assert) for the NoError check on parsing                                                                               | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 1.2  | Uses require (not assert) for the NotNil check on config                                                                                 | <span class="g">✓</span>       | <span class="r">✗</span> uses assert.NotNil                    |
| 1.3  | Uses assert for the subsequent value checks (Port, Host, Debug)                                                                          | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 1.4  | Does NOT use require for all assertions indiscriminately                                                                                 | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 1.5  | Argument order is (expected, actual) not (actual, expected) for Equal calls                                                              | <span class="g">✓</span>       | <span class="r">✗</span> swaps to (actual, expected)           |
|      | **2. assert-new-naming-convention** — Tests the skill's specific naming convention: 'is' for assert.New(t) and 'must' for require.New(t) | **<span class="g">5/5</span>** | **<span class="r">0/5</span>**                                 |
| 2.1  | Uses assert.New(t) to create a reusable assertion object                                                                                 | <span class="g">✓</span>       | <span class="r">✗</span> uses assert.Equal(t, ...) directly    |
| 2.2  | Uses require.New(t) to create a reusable require object                                                                                  | <span class="g">✓</span>       | <span class="r">✗</span> uses require.NoError(t, ...) directly |
| 2.3  | Names the assert.New(t) variable 'is'                                                                                                    | <span class="g">✓</span>       | <span class="r">✗</span> no New() usage                        |
| 2.4  | Names the require.New(t) variable 'must'                                                                                                 | <span class="g">✓</span>       | <span class="r">✗</span> no New() usage                        |
| 2.5  | Shows the 'is' and 'must' variables being used for different purposes (preconditions vs verifications)                                   | <span class="g">✓</span>       | <span class="r">✗</span> no differentiated naming              |
|      | **3. error-chain-assertion** — Tests knowledge that is.Equal(ErrNotFound, err) fails on wrapped errors and ErrorIs should be used        | **<span class="g">4/4</span>** | **<span class="r">2/4</span>**                                 |
| 3.1  | Uses ErrorIs (not Equal) to check the error against ErrNotFound                                                                          | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 3.2  | Does NOT use assert.Equal or is.Equal to compare errors directly                                                                         | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 3.3  | Uses require for the initial error existence check if subsequent assertions depend on it                                                 | <span class="g">✓</span>       | <span class="r">✗</span> uses assert for error check           |
| 3.4  | Argument order for ErrorIs is (err, target) not (target, err)                                                                            | <span class="g">✓</span>       | <span class="r">✗</span> swaps arguments                       |
|      | **4. mock-assert-expectations** — Tests whether AssertExpectations is called                                                             | **<span class="g">5/5</span>** | **<span class="r">3/5</span>**                                 |
| 4.1  | Mock embeds mock.Mock                                                                                                                    | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 4.2  | Mock method uses m.Called() to forward arguments                                                                                         | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 4.3  | Test calls m.AssertExpectations(t) to verify all expectations were met                                                                   | <span class="g">✓</span>       | <span class="r">✗</span> missing AssertExpectations            |
| 4.4  | Uses .Once() or equivalent call modifier to enforce exactly one call                                                                     | <span class="g">✓</span>       | <span class="r">✗</span> no call modifier                      |
| 4.5  | Uses mock.Anything for arguments that don't need specific matching (e.g., context)                                                       | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
|      | **5. mock-matched-by-predicate** — Tests knowledge of mock.MatchedBy for custom argument matching                                        | **<span class="g">5/5</span>** | **<span class="r">3/5</span>**                                 |
| 5.1  | Uses mock.MatchedBy with a predicate function for the LogEntry argument                                                                  | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 5.2  | The predicate checks Level == 'error'                                                                                                    | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 5.3  | The predicate checks that Message contains 'timeout' (using strings.Contains or similar)                                                 | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 5.4  | Uses mock.Anything for the context argument                                                                                              | <span class="g">✓</span>       | <span class="r">✗</span> passes context.Background() literally |
| 5.5  | Calls AssertExpectations at the end                                                                                                      | <span class="g">✓</span>       | <span class="r">✗</span> missing AssertExpectations            |
|      | **6. mock-retry-different-returns** — Tests knowledge of chaining .Once() calls for retry testing                                        | **<span class="g">4/4</span>** | **<span class="r">2/4</span>**                                 |
| 6.1  | Sets up first On().Return() with an error and .Once()                                                                                    | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 6.2  | Sets up second On().Return() with success data and .Once()                                                                               | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 6.3  | The two expectations are on the same method with the same arguments                                                                      | <span class="g">✓</span>       | <span class="r">✗</span> uses different argument patterns      |
| 6.4  | Calls AssertExpectations to verify both calls happened                                                                                   | <span class="g">✓</span>       | <span class="r">✗</span> missing AssertExpectations            |
|      | **7. suite-lifecycle-and-launcher** — Tests that suite requires a launcher function and understands lifecycle order                      | **<span class="g">5/5</span>** | **<span class="r">3/5</span>**                                 |
| 7.1  | Creates a suite struct embedding suite.Suite                                                                                             | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 7.2  | Uses SetupTest (not SetupSuite) for per-test mock store initialization                                                                   | <span class="g">✓</span>       | <span class="r">✗</span> uses SetupSuite for mock init         |
| 7.3  | Includes a launcher function: func TestXxxSuite(t *testing.T) with suite.Run()                                                           | <span class="g">✓</span>       | <span class="r">✗</span> missing launcher function             |
| 7.4  | Test methods are named TestXxx (starting with Test) on the suite receiver                                                                | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 7.5  | Uses SetupSuite or TearDownSuite for the shared database connection (one-time setup)                                                     | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
|      | **8. suite-require-syntax** — Tests that suite methods use s.Require().NotNil() for require behavior                                     | **<span class="g">3/3</span>** | **<span class="r">1/3</span>**                                 |
| 8.1  | Uses s.Require().NotNil() (not just s.NotNil()) for fail-fast behavior                                                                   | <span class="g">✓</span>       | <span class="r">✗</span> uses s.NotNil() thinking it's require |
| 8.2  | Explains that s.NotNil() and similar suite methods behave like assert (continue on failure)                                              | <span class="g">✓</span>       | <span class="r">✗</span> no explanation of default behavior    |
| 8.3  | Shows that s.Require() returns a require-style assertion object                                                                          | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
|      | **9. pointer-comparison-trap** — Tests awareness that is.Equal(ptr1, ptr2) compares addresses, not values                                | **<span class="g">3/3</span>** | **<span class="r">2/3</span>**                                 |
| 9.1  | Identifies that assert.Equal on pointers compares memory addresses, not struct values                                                    | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 9.2  | Recommends dereferencing the pointers or using EqualExportedValues                                                                       | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 9.3  | Mentions EqualExportedValues as an alternative for comparing only exported fields                                                        | <span class="g">✓</span>       | <span class="r">✗</span> only suggests dereferencing           |
|      | **10. eventually-with-rich-assertions** — Tests knowledge of EventuallyWithT for async polling with multiple rich assertions             | **<span class="g">5/5</span>** | **<span class="r">3/5</span>**                                 |
| 10.1 | Uses EventuallyWithT (not just Eventually) for rich assertions                                                                           | <span class="g">✓</span>       | <span class="r">✗</span> uses Eventually with bool             |
| 10.2 | The callback receives *assert.CollectT (or similar collect parameter)                                                                    | <span class="g">✓</span>       | <span class="r">✗</span> callback returns bool                 |
| 10.3 | Multiple assertions are made inside the callback (status check AND result count check)                                                   | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 10.4 | Uses assert.NoError/assert.Equal with the CollectT parameter inside the callback, not with t                                             | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 10.5 | Specifies timeout (10s) and polling interval as separate parameters                                                                      | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
|      | **11. testifylint-recommendation** — Tests whether the model recommends testifylint for catching common testify mistakes                 | **<span class="g">3/3</span>** | **<span class="r">3/3</span>**                                 |
| 11.1 | Recommends testifylint as a linter for testify-specific issues                                                                           | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 11.2 | Mentions that testifylint catches wrong argument order                                                                                   | <span class="g">✓</span>       | <span class="g">✓</span>                                       |
| 11.3 | Mentions that testifylint catches assert/require misuse                                                                                  | <span class="g">✓</span>       | <span class="g">✓</span>                                       |

</details>

## `golang-samber-mo` — v1.0.0

|             | With Skill       | Without Skill    | Delta     |
| ----------- | ---------------- | ---------------- | --------- |
| **Overall** | **95/108 (88%)** | **43/108 (40%)** | **+48pp** |

<details>
<summary>Full breakdown (108 assertions)</summary>

**Model:** Claude Opus 4.6 | **Runs:** 23 evals × 2 configs = 46 subagents | **Grading:** Human-as-Judge + LLM-as-judge

| #    | Assertion                                                                          | With                                                           | Without                                                     |
| ---- | ---------------------------------------------------------------------------------- | -------------------------------------------------------------- | ----------------------------------------------------------- |
|      | **1. option-vs-pointer-for-nullable-db-field** — Option[T] for nullable DB columns | **<span class="g">5/5</span>**                                 | **<span class="g">5/5</span>**                              |
| 1.1  | Uses mo.Option[string] for nullable fields                                         | <span class="g">✓</span>                                       | <span class="g">✓</span>                                    |
| 1.2  | Mentions sql.Scanner and driver.Valuer                                             | <span class="g">✓</span>                                       | <span class="g">✓</span>                                    |
| 1.3  | Mentions json.Marshaler/Unmarshaler                                                | <span class="g">✓</span>                                       | <span class="g">✓</span>                                    |
| 1.4  | Shows row.Scan with Option type                                                    | <span class="g">✓</span>                                       | <span class="g">✓</span>                                    |
| 1.5  | Does NOT recommend sql.NullString                                                  | <span class="g">✓</span>                                       | <span class="g">✓</span>                                    |
|      | **2. result-vs-tuple-error-boundary** — Result at API boundary vs internal         | **<span class="g">5/5</span>**                                 | **<span class="r">2/5</span>**                              |
| 2.1  | Returns (Config, error) at public boundary                                         | <span class="g">✓</span>                                       | <span class="r">✗</span> returns Result publicly            |
| 2.2  | Uses Result internally for chaining                                                | <span class="g">✓</span>                                       | <span class="r">✗</span> uses Result everywhere             |
| 2.3  | Shows TupleToResult at boundary                                                    | <span class="g">✓</span>                                       | <span class="g">✓</span>                                    |
| 2.4  | Shows .Get() at end for conversion back                                            | <span class="g">✓</span>                                       | <span class="r">✗</span> returns Result directly            |
| 2.5  | Explains Result for internal composition                                           | <span class="g">✓</span>                                       | <span class="g">✓</span>                                    |
|      | **3. either-vs-result-two-valid-types** — Either for non-error alternatives        | **<span class="g">5/5</span>**                                 | **<span class="r">2/5</span>**                              |
| 3.1  | Uses Either[CachedUser, FreshUser]                                                 | <span class="g">✓</span>                                       | <span class="r">✗</span> uses interface or Result           |
| 3.2  | Does NOT use Result                                                                | <span class="g">✓</span>                                       | <span class="r">✗</span> suggests common interface          |
| 3.3  | Explains Either vs Result                                                          | <span class="g">✓</span>                                       | <span class="r">✗</span> no distinction made                |
| 3.4  | Shows Left/Right constructors                                                      | <span class="g">✓</span>                                       | <span class="g">✓</span>                                    |
| 3.5  | Shows Match or IsLeft/IsRight                                                      | <span class="g">✓</span>                                       | <span class="g">✓</span>                                    |
|      | **4. sub-package-for-type-changing-map** — Sub-package for type-changing Map       | **<span class="g">5/5</span>**                                 | **<span class="r">1/5</span>**                              |
| 4.1  | Uses option.Map from sub-package                                                   | <span class="g">✓</span>                                       | <span class="r">✗</span> uses nonexistent `mo.Map(opt, fn)` |
| 4.2  | Does NOT use .Map for type change                                                  | <span class="g">✓</span>                                       | <span class="g">✓</span>                                    |
| 4.3  | Imports mo/option                                                                  | <span class="g">✓</span>                                       | <span class="r">✗</span> no sub-package import              |
| 4.4  | Shows curried form                                                                 | <span class="g">✓</span>                                       | <span class="r">✗</span> uses `mo.Map(opt, fn)` pattern     |
| 4.5  | Explains why sub-packages exist                                                    | <span class="g">✓</span>                                       | <span class="r">✗</span> claims `mo.Map` is package-level   |
|      | **5. do-notation-for-imperative-monadic** — mo.Do for imperative monadic code      | **<span class="g">5/5</span>**                                 | **<span class="r">0/5</span>**                              |
| 5.1  | Suggests mo.Do                                                                     | <span class="g">✓</span>                                       | <span class="r">✗</span> suggests unwrap-early pattern      |
| 5.2  | Shows MustGet inside Do                                                            | <span class="g">✓</span>                                       | <span class="r">✗</span> manual .Get() checks               |
| 5.3  | Explains panic catching                                                            | <span class="g">✓</span>                                       | <span class="r">✗</span> no mention of Do                   |
| 5.4  | Do returns Result[T]                                                               | <span class="g">✓</span>                                       | <span class="r">✗</span> no mention of Do                   |
| 5.5  | Cleaner than FlatMap chains                                                        | <span class="g">✓</span>                                       | <span class="r">✗</span> no Do alternative                  |
|      | **6. pipe-composition-multi-step** — Pipe for multi-step type-changing pipelines   | **<span class="g">5/5</span>**                                 | **<span class="r">0/5</span>**                              |
| 6.1  | Uses option.Pipe3                                                                  | <span class="g">✓</span>                                       | <span class="r">✗</span> nests function calls               |
| 6.2  | Each step uses option.Map/FlatMap                                                  | <span class="g">✓</span>                                       | <span class="r">✗</span> manual intermediate vars           |
| 6.3  | Pipeline reads top-to-bottom                                                       | <span class="g">✓</span>                                       | <span class="r">✗</span> nested calls                       |
| 6.4  | Imports mo/option sub-package                                                      | <span class="g">✓</span>                                       | <span class="r">✗</span> no sub-package awareness           |
| 6.5  | FlatMap for validation step                                                        | <span class="g">✓</span>                                       | <span class="r">✗</span> manual if/else                     |
|      | **7. future-vs-task-eager-vs-lazy** — Future (eager) vs Task (lazy)                | **<span class="g">5/5</span>**                                 | **<span class="r">4/5</span>**                              |
| 7.1  | Recommends Task                                                                    | <span class="g">✓</span>                                       | <span class="g">✓</span>                                    |
| 7.2  | Future starts immediately                                                          | <span class="g">✓</span>                                       | <span class="g">✓</span>                                    |
| 7.3  | Task runs on .Run()                                                                | <span class="g">✓</span>                                       | <span class="g">✓</span>                                    |
| 7.4  | Run returns *Future[T]                                                             | <span class="g">✓</span>                                       | <span class="g">✓</span>                                    |
| 7.5  | Deferred execution pattern                                                         | <span class="g">✓</span>                                       | <span class="r">✗</span> wrong constructor signature        |
|      | **8. tuple-to-result-wrapping-stdlib** — TupleToResult for stdlib wrapping         | **<span class="g">5/5</span>**                                 | **<span class="r">3/5</span>**                              |
| 8.1  | Uses TupleToResult(os.ReadFile(path))                                              | <span class="g">✓</span>                                       | <span class="g">✓</span>                                    |
| 8.2  | Uses TupleToResult or Try for Atoi                                                 | <span class="g">✓</span>                                       | <span class="g">✓</span>                                    |
| 8.3  | Does NOT manually check err                                                        | <span class="g">✓</span>                                       | <span class="r">✗</span> manually constructs Ok/Err         |
| 8.4  | Chains results                                                                     | <span class="g">✓</span>                                       | <span class="g">✓</span>                                    |
| 8.5  | Explains TupleToResult                                                             | <span class="g">✓</span>                                       | <span class="r">✗</span> no explanation                     |
|      | **9. when-not-to-use-monads** — Advises against monads for simple cases            | **<span class="g">4/4</span>**                                 | **<span class="g">3/4</span>**                              |
| 9.1  | Advises against Result here                                                        | <span class="g">✓</span>                                       | <span class="g">✓</span>                                    |
| 9.2  | Recommends if err != nil                                                           | <span class="g">✓</span>                                       | <span class="g">✓</span>                                    |
| 9.3  | Result shines with chains                                                          | <span class="g">✓</span>                                       | <span class="g">✓</span>                                    |
| 9.4  | Does NOT over-apply Result                                                         | <span class="g">✓</span>                                       | <span class="r">✗</span> still wraps in Result              |
|      | **10. option-json-serialization** — Option JSON marshaling behavior                | **<span class="g">5/5</span>**                                 | **<span class="r">3/5</span>**                              |
| 10.1 | Uses Option[string]                                                                | <span class="g">✓</span>                                       | <span class="g">✓</span>                                    |
| 10.2 | Some->value, None->null                                                            | <span class="g">✓</span>                                       | <span class="g">✓</span>                                    |
| 10.3 | Mentions omitzero (Go 1.24+)                                                       | <span class="g">✓</span>                                       | <span class="r">✗</span> no omitzero awareness              |
| 10.4 | Shows struct with json tag                                                         | <span class="g">✓</span>                                       | <span class="g">✓</span>                                    |
| 10.5 | No custom MarshalJSON needed                                                       | <span class="g">✓</span>                                       | <span class="r">✗</span> suggests custom marshaler          |
|      | **11. emptyable-to-option-zero-value** — EmptyableToOption for zero detection      | **<span class="g">4/4</span>**                                 | **<span class="r">0/4</span>**                              |
| 11.1 | Uses EmptyableToOption                                                             | <span class="g">✓</span>                                       | <span class="r">✗</span> manual if/else                     |
| 11.2 | None for zero, Some for non-zero                                                   | <span class="g">✓</span>                                       | <span class="r">✗</span> manual construction                |
| 11.3 | No manual check                                                                    | <span class="g">✓</span>                                       | <span class="r">✗</span> uses if/else                       |
| 11.4 | Works for any comparable type                                                      | <span class="g">✓</span>                                       | <span class="r">✗</span> only handles string                |
|      | **12. pointer-to-option-nil-handling** — PointerToOption for nil conversion        | **<span class="g">3/3</span>**                                 | **<span class="r">1/3</span>**                              |
| 12.1 | Uses PointerToOption(ptr)                                                          | <span class="g">✓</span>                                       | <span class="r">✗</span> manual nil check                   |
| 12.2 | nil->None, non-nil->Some                                                           | <span class="g">✓</span>                                       | <span class="g">✓</span>                                    |
| 12.3 | No manual nil check                                                                | <span class="g">✓</span>                                       | <span class="r">✗</span> manual check                       |
|      | **13. result-map-vs-flatmap-choice** — Map vs FlatMap on Result                    | **<span class="g">5/5</span>**                                 | **<span class="r">2/5</span>**                              |
| 13.1 | MapValue for infallible uppercase                                                  | <span class="g">✓</span>                                       | <span class="r">✗</span> uses Map for both                  |
| 13.2 | FlatMap for fallible parse                                                         | <span class="g">✓</span>                                       | <span class="g">✓</span>                                    |
| 13.3 | No FlatMap for uppercase                                                           | <span class="g">✓</span>                                       | <span class="r">✗</span> uses FlatMap for both              |
| 13.4 | Shows chain                                                                        | <span class="g">✓</span>                                       | <span class="g">✓</span>                                    |
| 13.5 | Explains distinction                                                               | <span class="g">✓</span>                                       | <span class="r">✗</span> no distinction explained           |
|      | **14. option-map-bool-semantics** — Option.Map's (T, bool) return type             | **<span class="g">4/4</span>**                                 | **<span class="r">0/4</span>**                              |
| 14.1 | Uses Map with (int, bool) return                                                   | <span class="g">✓</span>                                       | <span class="r">✗</span> claims Map can't filter            |
| 14.2 | false converts to None                                                             | <span class="g">✓</span>                                       | <span class="r">✗</span> doesn't know bool return           |
| 14.3 | Shows (T, bool) signature                                                          | <span class="g">✓</span>                                       | <span class="r">✗</span> claims func(T) T                   |
| 14.4 | No FlatMap for filtering                                                           | <span class="g">✓</span>                                       | <span class="r">✗</span> uses FlatMap                       |
|      | **15. foldable-interface-uniform-matching** — Fold across Option/Result/Either     | **<span class="r">0/5</span>**                                 | **<span class="r">0/5</span>**                              |
| 15.1 | Uses mo.Fold                                                                       | <span class="r">✗</span> not in skill                          | <span class="r">✗</span> separate switch blocks             |
| 15.2 | Shows Foldable interface                                                           | <span class="r">✗</span> not in skill                          | <span class="r">✗</span> no Foldable awareness              |
| 15.3 | successFn/failureFn callbacks                                                      | <span class="r">✗</span> not in skill                          | <span class="r">✗</span> manual matching                    |
| 15.4 | Single Fold for all types                                                          | <span class="r">✗</span> not in skill                          | <span class="r">✗</span> separate logic                     |
| 15.5 | No separate handling per type                                                      | <span class="r">✗</span> not in skill                          | <span class="r">✗</span> separate blocks                    |
|      | **16. io-for-testable-side-effects** — IO for deferring side effects               | **<span class="g">4/4</span>**                                 | **<span class="r">0/4</span>**                              |
| 16.1 | Uses IO or IOEither                                                                | <span class="g">✓</span>                                       | <span class="r">✗</span> uses interfaces/DI                 |
| 16.2 | IO is lazy, runs on Run()                                                          | <span class="g">✓</span>                                       | <span class="r">✗</span> no IO awareness                    |
| 16.3 | IO1/IO2 parameterize                                                               | <span class="g">✓</span>                                       | <span class="r">✗</span> no IO awareness                    |
| 16.4 | Composability of IO                                                                | <span class="g">✓</span>                                       | <span class="r">✗</span> no IO awareness                    |
|      | **17. result-to-either-conversion** — ToEither() conversion                        | **<span class="g">3/3</span>**                                 | **<span class="r">1/3</span>**                              |
| 17.1 | Uses result.ToEither()                                                             | <span class="g">✓</span>                                       | <span class="r">✗</span> manual IsOk + Left/Right           |
| 17.2 | Ok->Right, Err->Left                                                               | <span class="g">✓</span>                                       | <span class="g">✓</span>                                    |
| 17.3 | No manual IsOk check                                                               | <span class="g">✓</span>                                       | <span class="r">✗</span> manual check                       |
|      | **18. either3-for-multi-type-union** — Either3+ for n-ary unions                   | **<span class="g">5/5</span>**                                 | **<span class="r">2/5</span>**                              |
| 18.1 | Uses Either3                                                                       | <span class="g">✓</span>                                       | <span class="r">✗</span> uses interface or type switch      |
| 18.2 | Shows constructors                                                                 | <span class="g">✓</span>                                       | <span class="r">✗</span> no constructor awareness           |
| 18.3 | Shows Match                                                                        | <span class="g">✓</span>                                       | <span class="r">✗</span> type switch                        |
| 18.4 | No interface{}/any                                                                 | <span class="g">✓</span>                                       | <span class="g">✓</span>                                    |
| 18.5 | Mentions Either4/Either5                                                           | <span class="g">✓</span>                                       | <span class="g">✓</span>                                    |
|      | **19. option-vs-zero-value-distinction** — When Option adds value vs zero values   | **<span class="g">4/4</span>**                                 | **<span class="g">3/4</span>**                              |
| 19.1 | Plain int for count                                                                | <span class="g">✓</span>                                       | <span class="g">✓</span>                                    |
| 19.2 | Option[string] for nickname                                                        | <span class="g">✓</span>                                       | <span class="g">✓</span>                                    |
| 19.3 | Explains absence vs zero                                                           | <span class="g">✓</span>                                       | <span class="g">✓</span>                                    |
| 19.4 | No Option[int] for count                                                           | <span class="g">✓</span>                                       | <span class="r">✗</span> uses Option for both               |
|      | **20. map-lookup-to-option** — TupleToOption for map lookups                       | **<span class="g">4/4</span>**                                 | **<span class="r">1/4</span>**                              |
| 20.1 | Uses TupleToOption(m[key])                                                         | <span class="g">✓</span>                                       | <span class="r">✗</span> manual ok check                    |
| 20.2 | Chains Map/FlatMap                                                                 | <span class="g">✓</span>                                       | <span class="g">✓</span>                                    |
| 20.3 | No manual ok check                                                                 | <span class="g">✓</span>                                       | <span class="r">✗</span> manual check                       |
| 20.4 | Complete pattern                                                                   | <span class="g">✓</span>                                       | <span class="r">✗</span> manual construction                |
|      | **21. result-try-catch-panics** — Try for wrapping panicky functions               | **<span class="r">2/4</span>**                                 | **<span class="r">2/4</span>**                              |
| 21.1 | Uses mo.Try                                                                        | <span class="g">✓</span>                                       | <span class="g">✓</span>                                    |
| 21.2 | Try catches panics                                                                 | <span class="r">✗</span> skill says Do catches panics, not Try | <span class="r">✗</span> claims Try only wraps (T, error)   |
| 21.3 | Shows signature                                                                    | <span class="g">✓</span>                                       | <span class="g">✓</span>                                    |
| 21.4 | No separate defer/recover                                                          | <span class="r">✗</span> skill suggests Do for panics          | <span class="r">✗</span> adds defer/recover                 |
|      | **22. state-monad-for-accumulation** — State monad for threading state             | **<span class="g">4/4</span>**                                 | **<span class="r">0/4</span>**                              |
| 22.1 | Uses State/NewState                                                                | <span class="g">✓</span>                                       | <span class="r">✗</span> uses mutable struct                |
| 22.2 | State params = state + result                                                      | <span class="g">✓</span>                                       | <span class="r">✗</span> mutable position field             |
| 22.3 | Run(initialState)                                                                  | <span class="g">✓</span>                                       | <span class="r">✗</span> no State awareness                 |
| 22.4 | State threaded, not mutated                                                        | <span class="g">✓</span>                                       | <span class="r">✗</span> mutates struct                     |
|      | **23. result-map-signature** — Result.Map's (T, error) return type                 | **<span class="g">4/4</span>**                                 | **<span class="r">2/4</span>**                              |
| 23.1 | Map callback returns (int, error)                                                  | <span class="g">✓</span>                                       | <span class="g">✓</span>                                    |
| 23.2 | Does NOT use func(int) int                                                         | <span class="g">✓</span>                                       | <span class="g">✓</span>                                    |
| 23.3 | MapValue alternative                                                               | <span class="g">✓</span>                                       | <span class="r">✗</span> no MapValue mention                |
| 23.4 | Map vs MapValue signatures                                                         | <span class="g">✓</span>                                       | <span class="r">✗</span> no distinction                     |

</details>

## `golang-samber-hot` — v1.0.0

|             | With Skill      | Without Skill   | Delta     |
| ----------- | --------------- | --------------- | --------- |
| **Overall** | **61/65 (94%)** | **26/65 (40%)** | **+54pp** |

<details>
<summary>Full breakdown (65 assertions)</summary>

**Model:** Claude Opus 4.6 | **Runs:** 15 evals × 2 configs = 30 subagents | **Grading:** LLM-as-judge

| #    | Assertion                                                                           | With                           | Without                                              |
| ---- | ----------------------------------------------------------------------------------- | ------------------------------ | ---------------------------------------------------- |
|      | **1. algorithm-selection-default** — mixed workload, should pick W-TinyLFU over LRU | **<span class="g">6/6</span>** | **<span class="r">0/6</span>**                       |
| 1.1  | Uses hot.WTinyLFU as the eviction algorithm (not hot.LRU)                           | <span class="g">✓</span>       | <span class="r">✗</span> used hot.NewLRU             |
| 1.2  | Uses hot.NewHotCache constructor with generic type parameters                       | <span class="g">✓</span>       | <span class="r">✗</span> fabricated API              |
| 1.3  | Chains .WithTTL(10 * time.Minute) or equivalent                                     | <span class="g">✓</span>       | <span class="r">✗</span> positional arg              |
| 1.4  | Chains .WithJanitor() in the builder                                                | <span class="g">✓</span>       | <span class="r">✗</span> missing                     |
| 1.5  | Calls defer cache.StopJanitor() after Build()                                       | <span class="g">✓</span>       | <span class="r">✗</span> missing                     |
| 1.6  | Calls .Build() to finalize the cache                                                | <span class="g">✓</span>       | <span class="r">✗</span> no builder pattern          |
|      | **2. algorithm-selection-frequency** — stable power-law DNS, should pick LFU        | **<span class="g">4/4</span>** | **<span class="g">4/4</span>**                       |
| 2.1  | Recommends hot.LFU for stable-frequency workload                                    | <span class="g">✓</span>       | <span class="g">✓</span>                             |
| 2.2  | Explains why LFU fits: keeps frequently accessed items                              | <span class="g">✓</span>       | <span class="g">✓</span>                             |
| 2.3  | Mentions LFU weakness doesn't apply because rankings are stable                     | <span class="g">✓</span>       | <span class="g">✓</span>                             |
| 2.4  | Does NOT default to LRU                                                             | <span class="g">✓</span>       | <span class="g">✓</span>                             |
|      | **3. janitor-required** — simple cache with TTL must include WithJanitor()          | **<span class="g">4/4</span>** | **<span class="r">1/4</span>**                       |
| 3.1  | Includes .WithJanitor() in the builder chain                                        | <span class="g">✓</span>       | <span class="r">✗</span> fabricated config struct    |
| 3.2  | Includes defer cache.StopJanitor() for cleanup                                      | <span class="g">✓</span>       | <span class="r">✗</span> missing                     |
| 3.3  | Uses .WithTTL() for expiration                                                      | <span class="g">✓</span>       | <span class="r">✗</span> config struct field         |
| 3.4  | Does NOT call cache.Janitor() separately after Build()                              | <span class="g">✓</span>       | <span class="g">✓</span>                             |
|      | **4. missing-cache-panic-prevention** — SetMissing requires config                  | **<span class="g">4/4</span>** | **<span class="r">0/4</span>**                       |
| 4.1  | Configures WithMissingCache() or WithMissingSharedCache() in builder                | <span class="g">✓</span>       | <span class="r">✗</span> stores nil in main cache    |
| 4.2  | Uses cache.SetMissing() or cache.SetMissingWithTTL()                                | <span class="g">✓</span>       | <span class="r">✗</span> uses cache.Set(key, nil)    |
| 4.3  | Missing cache configured BEFORE Build()                                             | <span class="g">✓</span>       | <span class="r">✗</span> no config                   |
| 4.4  | Explains SetMissing without config panics                                           | <span class="g">✓</span>       | <span class="r">✗</span> unaware of SetMissing       |
|      | **5. loader-pattern-singleflight** — built-in dedup, no manual singleflight         | **<span class="g">5/5</span>** | **<span class="r">0/5</span>**                       |
| 5.1  | Uses .WithLoaders() in the builder chain                                            | <span class="g">✓</span>       | <span class="r">✗</span> manual singleflight         |
| 5.2  | Explains built-in singleflight deduplication                                        | <span class="g">✓</span>       | <span class="r">✗</span> suggests external package   |
| 5.3  | Does NOT implement manual singleflight on top                                       | <span class="g">✓</span>       | <span class="r">✗</span> uses x/sync/singleflight    |
| 5.4  | Loader signature matches func(keys []K) (map[K]V, error)                            | <span class="g">✓</span>       | <span class="r">✗</span> manual fetch pattern        |
| 5.5  | Recommends WithJitter() for additional thundering-herd mitigation                   | <span class="g">✓</span>       | <span class="r">✗</span> manual rand jitter          |
|      | **6. stale-while-revalidate** — two-threshold revalidation pattern                  | **<span class="g">5/5</span>** | **<span class="r">2/5</span>**                       |
| 6.1  | Uses .WithTTL(5 * time.Minute) for fresh duration                                   | <span class="g">✓</span>       | <span class="g">✓</span>                             |
| 6.2  | Uses .WithRevalidation(2 * time.Minute, loader)                                     | <span class="g">✓</span>       | <span class="r">✗</span> invented API                |
| 6.3  | Explains fresh -> stale -> expired model                                            | <span class="g">✓</span>       | <span class="g">✓</span>                             |
| 6.4  | Uses WithRevalidationErrorPolicy()                                                  | <span class="g">✓</span>       | <span class="r">✗</span> not mentioned               |
| 6.5  | Does NOT use a single 7min TTL                                                      | <span class="g">✓</span>       | <span class="g">✓</span>                             |
|      | **7. sharding-for-concurrency** — WithSharding for lock contention                  | **<span class="g">4/4</span>** | **<span class="r">2/4</span>**                       |
| 7.1  | Uses .WithSharding() in the builder                                                 | <span class="g">✓</span>       | <span class="r">✗</span> custom sharded wrapper      |
| 7.2  | Shard count is a power of 2                                                         | <span class="g">✓</span>       | <span class="g">✓</span>                             |
| 7.3  | Provides or discusses a hash function of type func(K) uint64                        | <span class="g">✓</span>       | <span class="g">✓</span>                             |
| 7.4  | Does NOT recommend WithoutLocking()                                                 | <span class="g">✓</span>       | <span class="g">✓</span>                             |
|      | **8. copy-on-read-mutable-values** — WithCopyOnRead for pointer safety              | **<span class="g">4/4</span>** | **<span class="r">2/4</span>**                       |
| 8.1  | Identifies callers mutating shared cached pointers                                  | <span class="g">✓</span>       | <span class="g">✓</span>                             |
| 8.2  | Uses .WithCopyOnRead(fn)                                                            | <span class="g">✓</span>       | <span class="r">✗</span> manual copy wrapper         |
| 8.3  | Copy function creates shallow or deep copy                                          | <span class="g">✓</span>       | <span class="g">✓</span>                             |
| 8.4  | Does NOT suggest only external mutexes as primary solution                          | <span class="g">✓</span>       | <span class="g">✓</span>                             |
|      | **9. loader-chain-semantics** — later overwrites earlier, error stops chain         | **<span class="g">5/5</span>** | **<span class="r">1/5</span>**                       |
| 9.1  | Later loaders overwrite earlier values (PostgreSQL wins)                            | <span class="g">✓</span>       | <span class="r">✗</span> says Redis wins             |
| 9.2  | Any loader error stops the entire chain                                             | <span class="g">✓</span>       | <span class="r">✗</span> unclear                     |
| 9.3  | Partial results from earlier loaders discarded on error                             | <span class="g">✓</span>       | <span class="r">✗</span> not mentioned               |
| 9.4  | Shows WithLoaders(redisLoader, dbLoader)                                            | <span class="g">✓</span>       | <span class="r">✗</span> invented API                |
| 9.5  | Later loaders only receive keys NOT found by previous                               | <span class="g">✓</span>       | <span class="g">✓</span>                             |
|      | **10. algorithm-scan-resistance** — LRU scan pollution, switch to scan-resistant    | **<span class="g">4/4</span>** | **<span class="g">4/4</span>**                       |
| 10.1 | Identifies LRU scan pollution problem                                               | <span class="g">✓</span>       | <span class="g">✓</span>                             |
| 10.2 | Recommends scan-resistant algorithm                                                 | <span class="g">✓</span>       | <span class="g">✓</span>                             |
| 10.3 | Explains why recommended algorithm resists scan pollution                           | <span class="g">✓</span>       | <span class="g">✓</span>                             |
| 10.4 | Does NOT suggest only increasing cache size                                         | <span class="g">✓</span>       | <span class="g">✓</span>                             |
|      | **11. withoutlocking-janitor-conflict** — mutually exclusive, panics                | **<span class="g">4/4</span>** | **<span class="r">3/4</span>**                       |
| 11.1 | Warns WithoutLocking() + WithJanitor() are mutually exclusive                       | <span class="g">✓</span>       | <span class="g">✓</span>                             |
| 11.2 | Recommends removing one of the two                                                  | <span class="g">✓</span>       | <span class="g">✓</span>                             |
| 11.3 | Suggests manual cleanup or dropping WithoutLocking()                                | <span class="g">✓</span>       | <span class="g">✓</span>                             |
| 11.4 | Does NOT produce code chaining both                                                 | <span class="g">✓</span>       | <span class="r">✗</span> initial code chains both    |
|      | **12. warmup-before-traffic** — WithWarmUp in builder                               | **<span class="g">4/4</span>** | **<span class="r">1/4</span>**                       |
| 12.1 | Uses .WithWarmUp(fn) or .WithWarmUpWithTimeout(timeout, fn)                         | <span class="g">✓</span>       | <span class="r">✗</span> wrong API guess             |
| 12.2 | Warm-up function returns (map[K]V, []K, error)                                      | <span class="g">✓</span>       | <span class="r">✗</span> wrong signature             |
| 12.3 | Warm-up happens before Build() returns                                              | <span class="g">✓</span>       | <span class="g">✓</span>                             |
| 12.4 | Does NOT manually loop calling Set()                                                | <span class="g">✓</span>       | <span class="r">✗</span> loops calling Get()         |
|      | **13. prometheus-monitoring-setup** — built-in WithPrometheusMetrics                | **<span class="g">4/4</span>** | **<span class="r">1/4</span>**                       |
| 13.1 | Uses .WithPrometheusMetrics(cacheName)                                              | <span class="g">✓</span>       | <span class="r">✗</span> custom counters             |
| 13.2 | Registers with prometheus.MustRegister(cache)                                       | <span class="g">✓</span>       | <span class="r">✗</span> registers custom metrics    |
| 13.3 | Mentions hit rate as key metric (target >80%)                                       | <span class="g">✓</span>       | <span class="g">✓</span>                             |
| 13.4 | Does NOT create custom Prometheus counters                                          | <span class="g">✓</span>       | <span class="r">✗</span> full custom instrumentation |
|      | **14. get-error-handling** — three return values (V, bool, error)                   | **<span class="g">4/4</span>** | **<span class="r">2/4</span>**                       |
| 14.1 | Get() returns (V, bool, error)                                                      | <span class="g">✓</span>       | <span class="r">✗</span> wrong semantics             |
| 14.2 | Checks error first before bool                                                      | <span class="g">✓</span>       | <span class="g">✓</span>                             |
| 14.3 | Handles all three cases: err, !found, found                                         | <span class="g">✓</span>       | <span class="r">✗</span> no not-found handling       |
| 14.4 | Does NOT ignore error return value                                                  | <span class="g">✓</span>       | <span class="g">✓</span>                             |
|      | **15. peek-vs-get-distinction** — Peek() for side-effect-free inspection            | **<span class="g">4/4</span>** | **<span class="r">3/4</span>**                       |
| 15.1 | Recommends Peek() or PeekMany()                                                     | <span class="g">✓</span>       | <span class="g">✓</span>                             |
| 15.2 | Explains Peek() does not trigger loaders                                            | <span class="g">✓</span>       | <span class="g">✓</span>                             |
| 15.3 | Explains Peek() ignores expiration (returns expired entries)                        | <span class="g">✓</span>       | <span class="r">✗</span> no expired-entry detail     |
| 15.4 | Does NOT recommend Get() for inspection                                             | <span class="g">✓</span>       | <span class="g">✓</span>                             |

</details>

## `golang-samber-lo` — v1.0.0

|             | With Skill      | Without Skill   | Delta     |
| ----------- | --------------- | --------------- | --------- |
| **Overall** | **83/86 (97%)** | **49/86 (57%)** | **+40pp** |

<details>
<summary>Full breakdown (86 assertions)</summary>

**Model:** Claude Opus 4.6 | **Runs:** 17 evals × 2 configs = 34 subagents | **Grading:** LLM-as-judge

| #    | Assertion                                                                           | With                           | Without                                                |
| ---- | ----------------------------------------------------------------------------------- | ------------------------------ | ------------------------------------------------------ |
|      | **1. lop-for-io-trap** — Should recommend errgroup over lop for HTTP fan-out        | **<span class="g">5/5</span>** | **<span class="r">1/5</span>**                         |
| 1.1  | Recommends errgroup or similar I/O concurrency pattern                              | <span class="g">✓</span>       | <span class="r">✗</span> used lop.Map as primary       |
| 1.2  | Explains lop is for CPU-bound parallelism, not I/O                                  | <span class="g">✓</span>       | <span class="r">✗</span>                               |
| 1.3  | Mentions lack of context cancellation as lop limitation                             | <span class="g">✓</span>       | <span class="r">✗</span>                               |
| 1.4  | Does NOT use lop.Map as primary HTTP fan-out solution                               | <span class="g">✓</span>       | <span class="r">✗</span>                               |
| 1.5  | Shows working Go code for concurrent fetch                                          | <span class="g">✓</span>       | <span class="g">✓</span>                               |
|      | **2. premature-lom-optimization** — Should advise profiling before switching to lom | **<span class="g">6/6</span>** | **<span class="r">3/6</span>**                         |
| 2.1  | Recommends profiling (pprof, alloc_objects) before switching                        | <span class="g">✓</span>       | <span class="g">✓</span>                               |
| 2.2  | Warns lom mutates input slice (breaks immutability)                                 | <span class="g">✓</span>       | <span class="r">✗</span> claims lom doesn't exist      |
| 2.3  | Does NOT blindly refactor all lo calls to lom                                       | <span class="g">✓</span>       | <span class="g">✓</span>                               |
| 2.4  | Explains performance issue may not be lo allocations                                | <span class="g">✓</span>       | <span class="g">✓</span>                               |
| 2.5  | Mentions lom only for hot paths confirmed by profiling                              | <span class="g">✓</span>       | <span class="r">✗</span> claims lom doesn't exist      |
| 2.6  | Warns about concurrency safety of mutable ops                                       | <span class="g">✓</span>       | <span class="r">✗</span>                               |
|      | **3. stdlib-vs-lo-preference** — Should prefer stdlib for Contains/Sort/Keys        | **<span class="g">6/6</span>** | **<span class="r">5/6</span>**                         |
| 3.1  | Recommends slices.Contains from stdlib                                              | <span class="g">✓</span>       | <span class="g">✓</span>                               |
| 3.2  | Recommends slices.Sort from stdlib                                                  | <span class="g">✓</span>       | <span class="g">✓</span>                               |
| 3.3  | Recommends maps.Keys from stdlib                                                    | <span class="g">✓</span>       | <span class="g">✓</span>                               |
| 3.4  | Mentions Go 1.21+ availability                                                      | <span class="g">✓</span>       | <span class="g">✓</span>                               |
| 3.5  | Explains rationale: prefer stdlib when available                                    | <span class="g">✓</span>       | <span class="r">✗</span> says "either works fine"      |
| 3.6  | Acknowledges lo useful for ops stdlib lacks                                         | <span class="g">✓</span>       | <span class="g">✓</span>                               |
|      | **4. loi-go-version-constraint** — Should warn lo/it requires Go 1.23+              | **<span class="g">5/5</span>** | **<span class="r">2/5</span>**                         |
| 4.1  | Warns loi requires Go 1.23+, not available in Go 1.20                               | <span class="g">✓</span>       | <span class="r">✗</span> claims lo/it doesn't exist    |
| 4.2  | Suggests upgrading Go version to 1.23+                                              | <span class="g">✓</span>       | <span class="r">✗</span>                               |
| 4.3  | Provides alternative approaches for Go 1.20                                         | <span class="g">✓</span>       | <span class="g">✓</span>                               |
| 4.4  | Does NOT provide loi code that won't compile on Go 1.20                             | <span class="g">✓</span>       | <span class="g">✓</span>                               |
| 4.5  | Mentions range-over-func as Go 1.23 feature                                         | <span class="g">✓</span>       | <span class="r">✗</span>                               |
|      | **5. must-in-production-handler** — Should warn against Must in HTTP handlers       | **<span class="g">5/5</span>** | **<span class="g">5/5</span>**                         |
| 5.1  | Warns Must panics on error, dangerous in handlers                                   | <span class="g">✓</span>       | <span class="g">✓</span>                               |
| 5.2  | Explains Must for tests/init only, not production                                   | <span class="g">✓</span>       | <span class="g">✓</span>                               |
| 5.3  | Provides refactored version with proper error handling                              | <span class="g">✓</span>       | <span class="g">✓</span>                               |
| 5.4  | Shows returning appropriate HTTP error status codes                                 | <span class="g">✓</span>       | <span class="g">✓</span>                               |
| 5.5  | Does NOT approve Must-based approach for production                                 | <span class="g">✓</span>       | <span class="g">✓</span>                               |
|      | **6. import-aliases-knowledge** — Should know lop/lom/loi aliases                   | **<span class="g">5/5</span>** | **<span class="r">2/5</span>**                         |
| 6.1  | Lists lo/parallel with alias lop                                                    | <span class="g">✓</span>       | <span class="g">✓</span>                               |
| 6.2  | Lists lo/mutable with alias lom                                                     | <span class="g">✓</span>       | <span class="r">✗</span> unaware of mutable pkg        |
| 6.3  | Lists lo/it with alias loi                                                          | <span class="g">✓</span>       | <span class="r">✗</span> unaware of iterator pkg       |
| 6.4  | Mentions lo/it requires Go 1.23+                                                    | <span class="g">✓</span>       | <span class="r">✗</span>                               |
| 6.5  | Lists core package with alias lo                                                    | <span class="g">✓</span>       | <span class="g">✓</span>                               |
|      | **7. immutability-trap** — lo.Filter does NOT modify input                          | **<span class="g">5/5</span>** | **<span class="r">3/5</span>**                         |
| 7.1  | States lo.Filter returns new slice, doesn't modify input                            | <span class="g">✓</span>       | <span class="g">✓</span>                               |
| 7.2  | Correctly says len(users) prints 2                                                  | <span class="g">✓</span>       | <span class="g">✓</span>                               |
| 7.3  | Explains lo is immutable by default as design principle                             | <span class="g">✓</span>       | <span class="r">✗</span> no design principle framing   |
| 7.4  | Points out return value of lo.Filter is discarded                                   | <span class="g">✓</span>       | <span class="g">✓</span>                               |
| 7.5  | Mentions lom.Filter as alternative for in-place mutation                            | <span class="g">✓</span>       | <span class="r">✗</span> no mention of lom             |
|      | **8. error-variant-awareness** — Should recommend lo.MapErr                         | **<span class="r">4/5</span>** | **<span class="r">1/5</span>**                         |
| 8.1  | Recommends lo.MapErr as error-aware variant                                         | <span class="g">✓</span>       | <span class="r">✗</span>                               |
| 8.2  | Explains MapErr stops on first error, returns (result, error)                       | <span class="g">✓</span>       | <span class="r">✗</span>                               |
| 8.3  | Shows MapErr usage example                                                          | <span class="g">✓</span>       | <span class="r">✗</span>                               |
| 8.4  | Mentions most lo functions have Err suffixes as pattern                             | <span class="r">✗</span>       | <span class="r">✗</span>                               |
| 8.5  | Suggests lo.FilterMap for skipping errors                                           | <span class="g">✓</span>       | <span class="g">✓</span>                               |
|      | **9. simd-production-stability** — Should warn simd is experimental                 | **<span class="r">4/5</span>** | **<span class="r">2/5</span>**                         |
| 9.1  | Warns lo/exp/simd is experimental, API may break                                    | <span class="g">✓</span>       | <span class="r">✗</span> claims simd doesn't exist     |
| 9.2  | States not covered by semver stability guarantees                                   | <span class="g">✓</span>       | <span class="r">✗</span>                               |
| 9.3  | Recommends benchmarking first                                                       | <span class="g">✓</span>       | <span class="g">✓</span>                               |
| 9.4  | Suggests version pinning if used                                                    | <span class="r">✗</span>       | <span class="r">✗</span>                               |
| 9.5  | Does NOT unconditionally recommend simd for production                              | <span class="g">✓</span>       | <span class="g">✓</span>                               |
|      | **10. streaming-redirect-to-ro** — Should redirect to samber/ro                     | **<span class="g">5/5</span>** | **<span class="r">3/5</span>**                         |
| 10.1 | Recommends samber/ro for reactive/streaming pipelines                               | <span class="g">✓</span>       | <span class="r">✗</span> suggests samber/hot instead   |
| 10.2 | Explains lo is for finite/batch, not infinite streams                               | <span class="g">✓</span>       | <span class="g">✓</span>                               |
| 10.3 | Mentions golang-samber-ro skill or samber/ro by name                                | <span class="g">✓</span>       | <span class="r">✗</span> mentions samber/hot not ro    |
| 10.4 | Does NOT attempt to use lo for infinite streaming                                   | <span class="g">✓</span>       | <span class="g">✓</span>                               |
| 10.5 | Explains conceptual difference: lo = batch, ro = reactive                           | <span class="g">✓</span>       | <span class="g">✓</span>                               |
|      | **11. lop-small-dataset-trap** — lop.Map wasteful for 10 items                      | **<span class="g">5/5</span>** | **<span class="g">5/5</span>**                         |
| 11.1 | Recommends lo.Map instead of lop.Map for 10 items                                   | <span class="g">✓</span>       | <span class="g">✓</span>                               |
| 11.2 | Explains goroutine overhead exceeds benefit                                         | <span class="g">✓</span>       | <span class="g">✓</span>                               |
| 11.3 | Mentions threshold (~1000+ items)                                                   | <span class="g">✓</span>       | <span class="g">✓</span>                               |
| 11.4 | Notes field access is trivial, no parallelism benefit                               | <span class="g">✓</span>       | <span class="g">✓</span>                               |
| 11.5 | Does NOT recommend lop.Map for this case                                            | <span class="g">✓</span>       | <span class="g">✓</span>                               |
|      | **12. filtermap-vs-filter-then-map** — Should use lo.FilterMap                      | **<span class="g">5/5</span>** | **<span class="g">5/5</span>**                         |
| 12.1 | Recommends lo.FilterMap as single-pass alternative                                  | <span class="g">✓</span>       | <span class="g">✓</span>                               |
| 12.2 | Shows FilterMap with (R, bool) return signature                                     | <span class="g">✓</span>       | <span class="g">✓</span>                               |
| 12.3 | Explains avoids intermediate filtered slice                                         | <span class="g">✓</span>       | <span class="g">✓</span>                               |
| 12.4 | Provides working code parsing strings to ints                                       | <span class="g">✓</span>       | <span class="g">✓</span>                               |
| 12.5 | Does NOT chain Filter+Map as primary solution                                       | <span class="g">✓</span>       | <span class="g">✓</span>                               |
|      | **13. channel-dispatcher-strategies** — Should list ChannelDispatcher strategies    | **<span class="g">6/6</span>** | **<span class="g">6/6</span>**                         |
| 13.1 | Mentions lo.ChannelDispatcher                                                       | <span class="g">✓</span>       | <span class="g">✓</span>                               |
| 13.2 | Lists RoundRobin strategy                                                           | <span class="g">✓</span>       | <span class="g">✓</span>                               |
| 13.3 | Lists Random strategy                                                               | <span class="g">✓</span>       | <span class="g">✓</span>                               |
| 13.4 | Lists WeightedRandom/First/Least/Most                                               | <span class="g">✓</span>       | <span class="g">✓</span>                               |
| 13.5 | Explains when to choose different strategies                                        | <span class="g">✓</span>       | <span class="g">✓</span>                               |
| 13.6 | Shows code example using ChannelDispatcher                                          | <span class="g">✓</span>       | <span class="g">✓</span>                               |
|      | **14. v2-version-trap** — Should state v2 does not exist                            | **<span class="g">4/4</span>** | **<span class="r">0/4</span>**                         |
| 14.1 | States samber/lo v2 does not exist                                                  | <span class="g">✓</span>       | <span class="r">✗</span> fabricated v2 migration guide |
| 14.2 | Mentions v1 follows semver, no breaking changes before v2                           | <span class="g">✓</span>       | <span class="r">✗</span> fabricated breaking changes   |
| 14.3 | Provides correct install: go get github.com/samber/lo@v1                            | <span class="g">✓</span>       | <span class="r">✗</span> shows go get lo/v2            |
| 14.4 | Does NOT fabricate v2 migration steps                                               | <span class="g">✓</span>       | <span class="r">✗</span> full fabricated migration     |
|      | **15. lazy-chain-intermediate-allocations** — Should recommend loi                  | **<span class="g">5/5</span>** | **<span class="r">1/5</span>**                         |
| 15.1 | Recommends lo/it (loi) for lazy evaluation                                          | <span class="g">✓</span>       | <span class="r">✗</span> claims loi doesn't exist      |
| 15.2 | Explains loi processes on-demand without buffering                                  | <span class="g">✓</span>       | <span class="r">✗</span>                               |
| 15.3 | Mentions Go 1.23+ requirement                                                       | <span class="g">✓</span>       | <span class="r">✗</span>                               |
| 15.4 | Shows lazy pipeline using loi functions                                             | <span class="g">✓</span>       | <span class="r">✗</span>                               |
| 15.5 | Contrasts eager vs lazy memory allocation                                           | <span class="g">✓</span>       | <span class="g">✓</span>                               |
|      | **16. lo-zero-dependencies** — Should state zero external deps                      | **<span class="g">4/4</span>** | **<span class="r">1/4</span>**                         |
| 16.1 | States zero external/runtime dependencies                                           | <span class="g">✓</span>       | <span class="r">✗</span> claims golang.org/x/exp dep   |
| 16.2 | Mentions relies only on Go stdlib                                                   | <span class="g">✓</span>       | <span class="r">✗</span> mentions x/exp                |
| 16.3 | Addresses supply chain concern                                                      | <span class="g">✓</span>       | <span class="g">✓</span>                               |
| 16.4 | Does NOT claim lo has external dependencies                                         | <span class="g">✓</span>       | <span class="r">✗</span> claims x/exp dependency       |
|      | **17. ternary-evaluation-trap** — lo.Ternary evaluates both branches                | **<span class="g">4/4</span>** | **<span class="g">4/4</span>**                         |
| 17.1 | Warns lo.Ternary evaluates both arguments                                           | <span class="g">✓</span>       | <span class="g">✓</span>                               |
| 17.2 | Recommends lo.TernaryF for lazy evaluation                                          | <span class="g">✓</span>       | <span class="g">✓</span>                               |
| 17.3 | Shows TernaryF usage with closures                                                  | <span class="g">✓</span>       | <span class="g">✓</span>                               |
| 17.4 | Explains expensiveCompute runs even when condition is false                         | <span class="g">✓</span>       | <span class="g">✓</span>                               |

</details>

## `golang-samber-slog` — v1.0.0

|             | With Skill      | Without Skill   | Delta     |
| ----------- | --------------- | --------------- | --------- |
| **Overall** | **57/62 (92%)** | **45/62 (73%)** | **+19pp** |

<details>
<summary>Full breakdown (62 assertions)</summary>

**Model:** Claude Opus 4.6 | **Runs:** 12 evals × 2 configs = 24 subagents | **Grading:** LLM-as-judge

| #    | Assertion                                                               | With                                       | Without                                             |
| ---- | ----------------------------------------------------------------------- | ------------------------------------------ | --------------------------------------------------- |
|      | **1. pipeline-ordering** — sampling + PII + Sentry composition          | **<span class="g">5/5</span>**             | **<span class="r">3/5</span>**                      |
| 1.1  | Sampling is outermost/first handler in pipeline                         | <span class="g">✓</span>                   | <span class="r">✗</span> PII first, sampling second |
| 1.2  | Uses slog-sampling library for sampling                                 | <span class="g">✓</span>                   | <span class="g">✓</span>                            |
| 1.3  | Uses slog-formatter for PII scrubbing                                   | <span class="g">✓</span>                   | <span class="g">✓</span>                            |
| 1.4  | Uses slogmulti.Router or Fanout for routing                             | <span class="g">✓</span>                   | <span class="g">✓</span>                            |
| 1.5  | Explains why sampling should be first                                   | <span class="g">✓</span>                   | <span class="r">✗</span> no ordering rationale      |
|      | **2. fanout-vs-router** — level-based routing to Sentry/Slack/stdout    | **<span class="g">5/5</span>**             | **<span class="g">5/5</span>**                      |
| 2.1  | Uses slogmulti.Router() for level-based routing                         | <span class="g">✓</span>                   | <span class="g">✓</span>                            |
| 2.2  | stdout receives all log levels                                          | <span class="g">✓</span>                   | <span class="g">✓</span>                            |
| 2.3  | Sentry receives only errors                                             | <span class="g">✓</span>                   | <span class="g">✓</span>                            |
| 2.4  | Slack receives only warnings                                            | <span class="g">✓</span>                   | <span class="g">✓</span>                            |
| 2.5  | Explains Router vs Fanout distinction                                   | <span class="g">✓</span>                   | <span class="g">✓</span>                            |
|      | **3. missing-close-batch** — Datadog handler graceful shutdown          | **<span class="g">5/5</span>**             | **<span class="r">4/5</span>**                      |
| 3.1  | Calls handler.Close() or defer Close()                                  | <span class="g">✓</span>                   | <span class="g">✓</span>                            |
| 3.2  | Uses Option{}.NewDatadogHandler() pattern                               | <span class="g">✓</span>                   | <span class="g">✓</span>                            |
| 3.3  | Close happens during graceful shutdown                                  | <span class="g">✓</span>                   | <span class="g">✓</span>                            |
| 3.4  | Mentions batching / data loss risk                                      | <span class="g">✓</span>                   | <span class="g">✓</span>                            |
| 3.5  | Import path uses versioned module (v2+)                                 | <span class="g">✓</span>                   | <span class="r">✗</span> unversioned import         |
|      | **4. sampling-strategy-selection** — reduce 90% volume, keep errors     | **<span class="g">5/5</span>**             | **<span class="g">5/5</span>**                      |
| 4.1  | Uses Threshold or Absolute (not Uniform)                                | <span class="g">✓</span>                   | <span class="g">✓</span>                            |
| 4.2  | Sampling only affects Debug/Info levels                                 | <span class="g">✓</span>                   | <span class="g">✓</span>                            |
| 4.3  | Warn/Error pass through unsampled                                       | <span class="g">✓</span>                   | <span class="g">✓</span>                            |
| 4.4  | Uses slog-sampling library                                              | <span class="g">✓</span>                   | <span class="g">✓</span>                            |
| 4.5  | Explains why Uniform is wrong                                           | <span class="g">✓</span>                   | <span class="g">✓</span>                            |
|      | **5. router-missing-default** — DEBUG logs disappearing                 | **<span class="g">5/5</span>**             | **<span class="g">5/5</span>**                      |
| 5.1  | Identifies missing catch-all handler                                    | <span class="g">✓</span>                   | <span class="g">✓</span>                            |
| 5.2  | Explains unmatched records silently dropped                             | <span class="g">✓</span>                   | <span class="g">✓</span>                            |
| 5.3  | Suggests adding default handler or LevelIs(Debug)                       | <span class="g">✓</span>                   | <span class="g">✓</span>                            |
| 5.4  | Uses slogmulti.Router() API correctly                                   | <span class="g">✓</span>                   | <span class="g">✓</span>                            |
| 5.5  | Does NOT suggest changing log level as fix                              | <span class="g">✓</span>                   | <span class="g">✓</span>                            |
|      | **6. http-middleware-filters** — slog-gin with path filters             | **<span class="g">5/5</span>**             | **<span class="g">5/5</span>**                      |
| 6.1  | Uses sloggin.NewWithConfig()                                            | <span class="g">✓</span>                   | <span class="g">✓</span>                            |
| 6.2  | Configures IgnorePath for /health and /metrics                          | <span class="g">✓</span>                   | <span class="g">✓</span>                            |
| 6.3  | Sets WithRequestBody: true                                              | <span class="g">✓</span>                   | <span class="g">✓</span>                            |
| 6.4  | Config includes level fields                                            | <span class="g">✓</span>                   | <span class="g">✓</span>                            |
| 6.5  | Uses IgnorePath (not custom filter)                                     | <span class="g">✓</span>                   | <span class="g">✓</span>                            |
|      | **7. pipe-middleware-chain** — trace injection + email scrubbing        | **<span class="g">5/5</span>**             | **<span class="r">4/5</span>**                      |
| 7.1  | Uses slogmulti.Pipe() for chaining                                      | <span class="g">✓</span>                   | <span class="g">✓</span>                            |
| 7.2  | Creates middleware for trace_id injection                               | <span class="g">✓</span>                   | <span class="g">✓</span>                            |
| 7.3  | Creates middleware for email scrubbing                                  | <span class="g">✓</span>                   | <span class="g">✓</span>                            |
| 7.4  | Pipe wraps the final handler                                            | <span class="g">✓</span>                   | <span class="g">✓</span>                            |
| 7.5  | Does NOT implement custom slog.Handler struct                           | <span class="g">✓</span>                   | <span class="r">✗</span> full Handler struct        |
|      | **8. failover-handler** — Loki fallback to file                         | **<span class="g">5/5</span>**             | **<span class="r">4/5</span>**                      |
| 8.1  | Uses slogmulti.Failover()                                               | <span class="g">✓</span>                   | <span class="g">✓</span>                            |
| 8.2  | Loki is primary handler                                                 | <span class="g">✓</span>                   | <span class="g">✓</span>                            |
| 8.3  | File handler is fallback                                                | <span class="g">✓</span>                   | <span class="g">✓</span>                            |
| 8.4  | Does NOT implement custom retry logic                                   | <span class="g">✓</span>                   | <span class="g">✓</span>                            |
| 8.5  | Uses slog-loki library                                                  | <span class="g">✓</span>                   | <span class="r">✗</span> placeholder function       |
|      | **9. pool-vs-fanout-latency** — fix sequential Fanout latency           | **<span class="r">2/5</span>**             | **<span class="r">2/5</span>**                      |
| 9.1  | Identifies sequential Fanout as root cause                              | <span class="g">✓</span>                   | <span class="g">✓</span>                            |
| 9.2  | Recommends slogmulti.Pool()                                             | <span class="r">✗</span> custom goroutines | <span class="r">✗</span> misuses Pool               |
| 9.3  | Explains latency reduction (sum to max)                                 | <span class="g">✓</span>                   | <span class="r">✗</span> claims 0ms latency         |
| 9.4  | Does NOT suggest raw goroutines as primary                              | <span class="r">✗</span>                   | <span class="g">✓</span>                            |
| 9.5  | Shows code change from Fanout to Pool                                   | <span class="r">✗</span>                   | <span class="r">✗</span>                            |
|      | **10. formatter-pii-scrubbing** — cross-cutting PII protection          | **<span class="g">5/5</span>**             | **<span class="r">3/5</span>**                      |
| 10.1 | Uses slog-formatter library                                             | <span class="g">✓</span>                   | <span class="r">✗</span> custom middleware          |
| 10.2 | Uses PIIFormatter and/or IPAddressFormatter                             | <span class="g">✓</span>                   | <span class="r">✗</span> custom regex               |
| 10.3 | Applied as Pipe middleware wrapping all handlers                        | <span class="g">✓</span>                   | <span class="g">✓</span>                            |
| 10.4 | Applied once before Router/Fanout                                       | <span class="g">✓</span>                   | <span class="g">✓</span>                            |
| 10.5 | Does NOT implement custom per-handler PII logic                         | <span class="g">✓</span>                   | <span class="g">✓</span>                            |
|      | **11. backend-option-pattern** — Sentry + Loki setup                    | **<span class="g">5/5</span>**             | **<span class="r">4/5</span>**                      |
| 11.1 | Uses slogsentry.Option{}.NewSentryHandler()                             | <span class="g">✓</span>                   | <span class="g">✓</span>                            |
| 11.2 | Uses slogloki.Option{}.NewLokiHandler()                                 | <span class="g">✓</span>                   | <span class="g">✓</span>                            |
| 11.3 | Uses Router for level-based routing                                     | <span class="g">✓</span>                   | <span class="r">✗</span> uses Fanout                |
| 11.4 | Versioned import paths                                                  | <span class="g">✓</span>                   | <span class="g">✓</span>                            |
| 11.5 | Calls Close() on Loki handler                                           | <span class="g">✓</span>                   | <span class="g">✓</span>                            |
|      | **12. attrfromcontext-without-middleware** — empty request_id diagnosis | **<span class="g">7/7</span>**             | **<span class="r">6/7</span>**                      |
| 12.1 | Identifies no middleware populating context                             | <span class="g">✓</span>                   | <span class="g">✓</span>                            |
| 12.2 | Recommends adding HTTP middleware                                       | <span class="g">✓</span>                   | <span class="g">✓</span>                            |
| 12.3 | Explains middleware injects attributes into context                     | <span class="g">✓</span>                   | <span class="g">✓</span>                            |
| 12.4 | Does NOT suggest changing context key as primary fix                    | <span class="g">✓</span>                   | <span class="g">✓</span>                            |
| 12.5 | Shows connection between middleware and AttrFromContext                 | <span class="g">✓</span>                   | <span class="g">✓</span>                            |
| 12.6 | Mentions WithRequestID config option                                    | <span class="g">✓</span>                   | <span class="r">✗</span>                            |
| 12.7 | Does NOT blame slog-multi/sentry config                                 | <span class="g">✓</span>                   | <span class="g">✓</span>                            |

</details>

## `golang-samber-ro` — v1.0.0

|             | With Skill         | Without Skill    | Delta     |
| ----------- | ------------------ | ---------------- | --------- |
| **Overall** | **113/113 (100%)** | **57/113 (50%)** | **+50pp** |

<details>
<summary>Full breakdown (113 assertions)</summary>

**Model:** Claude Opus 4.6 | **Runs:** 25 evals × 2 configs = 50 subagents | **Grading:** LLM-as-judge (self-grading subagents)

| #    | Assertion                                                               | With                           | Without                                                 |
| ---- | ----------------------------------------------------------------------- | ------------------------------ | ------------------------------------------------------- |
|      | **1. typed-pipe-vs-untyped** — chain 3 operators with type safety       | **<span class="g">4/4</span>** | **<span class="r">3/4</span>**                          |
| 1.1  | Uses ro.Pipe3 instead of untyped ro.Pipe for compile-time type safety   | <span class="g">✓</span>       | <span class="r">✗</span> uses untyped Pipe              |
| 1.2  | Uses ro.Filter with func(int) bool predicate                            | <span class="g">✓</span>       | <span class="g">✓</span>                                |
| 1.3  | Uses ro.Map with func(int) string transform                             | <span class="g">✓</span>       | <span class="g">✓</span>                                |
| 1.4  | Uses ro.Take[string](5) with correct generic type                       | <span class="g">✓</span>       | <span class="r">✗</span> omits generic param            |
|      | **2. lo-vs-ro-boundary** — finite slice should use lo, not ro           | **<span class="g">4/4</span>** | **<span class="r">0/4</span>**                          |
| 2.1  | Recommends samber/lo instead of samber/ro                               | <span class="g">✓</span>       | <span class="r">✗</span> uses ro Observable             |
| 2.2  | Explains WHY lo is better: synchronous, no stream overhead              | <span class="g">✓</span>       | <span class="r">✗</span>                                |
| 2.3  | Does NOT create an Observable pipeline for a slice transform            | <span class="g">✓</span>       | <span class="r">✗</span> creates Observable             |
| 2.4  | Uses lo.Filter and lo.Map                                               | <span class="g">✓</span>       | <span class="r">✗</span> uses ro operators              |
|      | **3. observer-error-handling** — full observer, not just OnNext         | **<span class="g">4/4</span>** | **<span class="r">1/4</span>**                          |
| 3.1  | Uses ro.NewObserver with all 3 callbacks                                | <span class="g">✓</span>       | <span class="r">✗</span> uses ro.OnNext                 |
| 3.2  | Includes an error handler                                               | <span class="g">✓</span>       | <span class="g">✓</span>                                |
| 3.3  | Includes a completion handler                                           | <span class="g">✓</span>       | <span class="r">✗</span> infinite stream, skipped       |
| 3.4  | Mentions risk of OnNext alone (silent error dropping)                   | <span class="g">✓</span>       | <span class="r">✗</span>                                |
|      | **4. infinite-stream-shutdown** — graceful SIGTERM shutdown             | **<span class="g">5/5</span>** | **<span class="r">0/5</span>**                          |
| 4.1  | Uses TakeUntil or context+ThrowOnContextCancel                          | <span class="g">✓</span>       | <span class="r">✗</span> generic context approach       |
| 4.2  | Mentions signal plugin (plugins/signal)                                 | <span class="g">✓</span>       | <span class="r">✗</span> uses manual os/signal          |
| 4.3  | Calls .Wait() to block until shutdown                                   | <span class="g">✓</span>       | <span class="r">✗</span> doesn't know .Wait()           |
| 4.4  | Does NOT suggest manual channel/goroutine killing                       | <span class="g">✓</span>       | <span class="r">✗</span> uses channel-based approach    |
| 4.5  | Mentions Unsubscribe() as alternative                                   | <span class="g">✓</span>       | <span class="r">✗</span> not in ro API context          |
|      | **5. subject-config-store** — BehaviorSubject for config                | **<span class="g">5/5</span>** | **<span class="r">3/5</span>**                          |
| 5.1  | Recommends BehaviorSubject                                              | <span class="g">✓</span>       | <span class="g">✓</span>                                |
| 5.2  | Explains replay of last value to new subscribers                        | <span class="g">✓</span>       | <span class="g">✓</span>                                |
| 5.3  | Shows NewBehaviorSubject[Config](initial) constructor                   | <span class="g">✓</span>       | <span class="r">✗</span> wrong constructor syntax       |
| 5.4  | Shows .Send() and .Subscribe()                                          | <span class="g">✓</span>       | <span class="r">✗</span> uses .Next() from RxJS         |
| 5.5  | Does NOT recommend PublishSubject                                       | <span class="g">✓</span>       | <span class="g">✓</span>                                |
|      | **6. subject-chat-room** — ReplaySubject for chat history               | **<span class="g">4/4</span>** | **<span class="r">3/4</span>**                          |
| 6.1  | Recommends ReplaySubject with buffer 50                                 | <span class="g">✓</span>       | <span class="g">✓</span>                                |
| 6.2  | Shows NewReplaySubject[Message](50) constructor                         | <span class="g">✓</span>       | <span class="r">✗</span> wrong constructor syntax       |
| 6.3  | Explains N-value replay for late subscribers                            | <span class="g">✓</span>       | <span class="g">✓</span>                                |
| 6.4  | Does NOT recommend BehaviorSubject                                      | <span class="g">✓</span>       | <span class="g">✓</span>                                |
|      | **7. share-websocket** — hot observable for shared WebSocket            | **<span class="g">5/5</span>** | **<span class="g">5/5</span>**                          |
| 7.1  | Uses Share() or ShareReplay()                                           | <span class="g">✓</span>       | <span class="g">✓</span>                                |
| 7.2  | Creates only ONE WebSocket connection                                   | <span class="g">✓</span>       | <span class="g">✓</span>                                |
| 7.3  | Does NOT create 3 separate connections                                  | <span class="g">✓</span>       | <span class="g">✓</span>                                |
| 7.4  | Shows 3 separate .Subscribe() calls                                     | <span class="g">✓</span>       | <span class="g">✓</span>                                |
| 7.5  | Explains cold vs hot distinction                                        | <span class="g">✓</span>       | <span class="g">✓</span>                                |
|      | **8. combinelatest-vs-zip** — latest values from different-rate sources | **<span class="g">6/6</span>** | **<span class="r">5/6</span>**                          |
| 8.1  | Recommends CombineLatest2                                               | <span class="g">✓</span>       | <span class="g">✓</span>                                |
| 8.2  | Explains re-emit on either source update                                | <span class="g">✓</span>       | <span class="g">✓</span>                                |
| 8.3  | Explains why NOT Zip                                                    | <span class="g">✓</span>       | <span class="g">✓</span>                                |
| 8.4  | Explains why NOT Merge                                                  | <span class="g">✓</span>       | <span class="g">✓</span>                                |
| 8.5  | Shows lo.Tuple2 return type                                             | <span class="g">✓</span>       | <span class="r">✗</span> generic tuple                  |
| 8.6  | Uses Map to compute product                                             | <span class="g">✓</span>       | <span class="r">✗</span> generic combiner function      |
|      | **9. retry-with-backoff** — RetryWithConfig + cached fallback           | **<span class="g">6/6</span>** | **<span class="r">1/6</span>**                          |
| 9.1  | Uses RetryWithConfig (not infinite Retry)                               | <span class="g">✓</span>       | <span class="r">✗</span> uses Retry with count param    |
| 9.2  | Sets Max: 3                                                             | <span class="g">✓</span>       | <span class="r">✗</span> wrong API                      |
| 9.3  | Sets Delay: 500ms and BackoffMultiplier: 2.0                            | <span class="g">✓</span>       | <span class="r">✗</span> wrong field names              |
| 9.4  | Sets MaxDelay: 10s                                                      | <span class="g">✓</span>       | <span class="r">✗</span> field not included             |
| 9.5  | Chains fallback after RetryWithConfig                                   | <span class="g">✓</span>       | <span class="r">✗</span> uses RxJS-style naming         |
| 9.6  | Correct operator order: retry before fallback                           | <span class="g">✓</span>       | <span class="g">✓</span>                                |
|      | **10. scan-vs-reduce** — running average for dashboard                  | **<span class="g">5/5</span>** | **<span class="g">5/5</span>**                          |
| 10.1 | Recommends Scan                                                         | <span class="g">✓</span>       | <span class="g">✓</span>                                |
| 10.2 | Explains intermediate emission                                          | <span class="g">✓</span>       | <span class="g">✓</span>                                |
| 10.3 | Explains Reduce only emits final                                        | <span class="g">✓</span>       | <span class="g">✓</span>                                |
| 10.4 | Shows accumulator with count/sum                                        | <span class="g">✓</span>       | <span class="g">✓</span>                                |
| 10.5 | Notes infinite stream + Reduce = never emits                            | <span class="g">✓</span>       | <span class="g">✓</span>                                |
|      | **11. collect-synchronous** — Collect for finite observable to slice    | **<span class="g">4/4</span>** | **<span class="r">0/4</span>**                          |
| 11.1 | Uses ro.Collect returning ([]int, error)                                | <span class="g">✓</span>       | <span class="r">✗</span> manual subscribe+accumulate    |
| 11.2 | Checks error return value                                               | <span class="g">✓</span>       | <span class="r">✗</span>                                |
| 11.3 | Does NOT manually subscribe and accumulate                              | <span class="g">✓</span>       | <span class="r">✗</span>                                |
| 11.4 | Mentions Collect blocks until complete                                  | <span class="g">✓</span>       | <span class="r">✗</span>                                |
|      | **12. context-propagation** — wire timeout into pipeline                | **<span class="g">4/4</span>** | **<span class="r">1/4</span>**                          |
| 12.1 | Uses ContextWithTimeout or ContextReset                                 | <span class="g">✓</span>       | <span class="r">✗</span> passes ctx to Subscribe        |
| 12.2 | Uses ThrowOnContextCancel                                               | <span class="g">✓</span>       | <span class="r">✗</span>                                |
| 12.3 | Chains context operators in pipeline                                    | <span class="g">✓</span>       | <span class="r">✗</span>                                |
| 12.4 | Handles cancellation error in onError                                   | <span class="g">✓</span>       | <span class="g">✓</span>                                |
|      | **13. plugin-fsnotify** — file watcher with debounce                    | **<span class="g">5/5</span>** | **<span class="r">3/5</span>**                          |
| 13.1 | Knows fsnotify plugin (plugins/fsnotify)                                | <span class="g">✓</span>       | <span class="r">✗</span> uses manual fsnotify           |
| 13.2 | Uses plugin to create observable                                        | <span class="g">✓</span>       | <span class="r">✗</span> wraps channel manually         |
| 13.3 | Uses ThrottleTime for debounce                                          | <span class="g">✓</span>       | <span class="g">✓</span>                                |
| 13.4 | Filters for Write events                                                | <span class="g">✓</span>       | <span class="g">✓</span>                                |
| 13.5 | Shows Map to reload config                                              | <span class="g">✓</span>       | <span class="g">✓</span>                                |
|      | **14. plugin-cron** — daily midnight schedule                           | **<span class="g">4/4</span>** | **<span class="r">0/4</span>**                          |
| 14.1 | Knows cron plugin (plugins/cron)                                        | <span class="g">✓</span>       | <span class="r">✗</span> uses Interval                  |
| 14.2 | Uses cron expression `0 0 * * *`                                        | <span class="g">✓</span>       | <span class="r">✗</span>                                |
| 14.3 | Shows correct import path                                               | <span class="g">✓</span>       | <span class="r">✗</span>                                |
| 14.4 | Chains with Map/FlatMap for report generation                           | <span class="g">✓</span>       | <span class="r">✗</span>                                |
|      | **15. maperr-fallible-transform** — MapErr for JSON parsing             | **<span class="g">5/5</span>** | **<span class="r">1/5</span>**                          |
| 15.1 | Uses MapErr (not Map)                                                   | <span class="g">✓</span>       | <span class="r">✗</span> uses Map                       |
| 15.2 | Shows func(string) (MyStruct, error) signature                          | <span class="g">✓</span>       | <span class="r">✗</span>                                |
| 15.3 | Explains error propagation through pipeline                             | <span class="g">✓</span>       | <span class="r">✗</span>                                |
| 15.4 | Does NOT suggest panic/recover pattern                                  | <span class="g">✓</span>       | <span class="g">✓</span>                                |
| 15.5 | Mentions JSON encoding plugin as alternative                            | <span class="g">✓</span>       | <span class="r">✗</span>                                |
|      | **16. buffer-batching** — BufferWithTimeOrCount for DB writes           | **<span class="g">4/4</span>** | **<span class="r">3/4</span>**                          |
| 16.1 | Uses BufferWithTimeOrCount                                              | <span class="g">✓</span>       | <span class="r">✗</span> generic buffer approach        |
| 16.2 | Sets count=100, duration=5s                                             | <span class="g">✓</span>       | <span class="g">✓</span>                                |
| 16.3 | Chains with Map/MapErr for batch processing                             | <span class="g">✓</span>       | <span class="g">✓</span>                                |
| 16.4 | Explains why both conditions matter                                     | <span class="g">✓</span>       | <span class="g">✓</span>                                |
|      | **17. unicast-subject-queue** — single-consumer job queue               | **<span class="g">5/5</span>** | **<span class="r">0/5</span>**                          |
| 17.1 | Recommends UnicastSubject                                               | <span class="g">✓</span>       | <span class="r">✗</span> uses channel or PublishSubject |
| 17.2 | Shows NewUnicastSubject[Task](bufferSize)                               | <span class="g">✓</span>       | <span class="r">✗</span>                                |
| 17.3 | Explains exactly one subscriber                                         | <span class="g">✓</span>       | <span class="r">✗</span>                                |
| 17.4 | Explains pre-subscribe buffering                                        | <span class="g">✓</span>       | <span class="r">✗</span>                                |
| 17.5 | Does NOT recommend PublishSubject                                       | <span class="g">✓</span>       | <span class="r">✗</span>                                |
|      | **18. share-vs-sharereplay** — late subscribers missing data            | **<span class="g">4/4</span>** | **<span class="r">3/4</span>**                          |
| 18.1 | Recommends ShareReplay(1)                                               | <span class="g">✓</span>       | <span class="g">✓</span>                                |
| 18.2 | Explains Share doesn't buffer                                           | <span class="g">✓</span>       | <span class="g">✓</span>                                |
| 18.3 | Explains ShareReplay buffers last N                                     | <span class="g">✓</span>       | <span class="g">✓</span>                                |
| 18.4 | Shows correct syntax ro.ShareReplay[T](1)                               | <span class="g">✓</span>       | <span class="r">✗</span> wrong generic syntax           |
|      | **19. error-recovery-cascade** — retry then fallback then default       | **<span class="g">5/5</span>** | **<span class="r">1/5</span>**                          |
| 19.1 | Correct order: RetryWithConfig, Catch, OnErrorReturn                    | <span class="g">✓</span>       | <span class="r">✗</span> wrong operator names           |
| 19.2 | Uses RetryWithConfig with Max: 2                                        | <span class="g">✓</span>       | <span class="r">✗</span> generic retry approach         |
| 19.3 | Uses Catch for secondary source                                         | <span class="g">✓</span>       | <span class="r">✗</span> uses RxJS-style naming         |
| 19.4 | Uses OnErrorReturn for default                                          | <span class="g">✓</span>       | <span class="r">✗</span> wrong operator name            |
| 19.5 | Correct Pipe order                                                      | <span class="g">✓</span>       | <span class="g">✓</span>                                |
|      | **20. channel-bridge** — FromChannel for legacy chan                    | **<span class="g">4/4</span>** | **<span class="g">4/4</span>**                          |
| 20.1 | Uses ro.FromChannel[Event](ch)                                          | <span class="g">✓</span>       | <span class="g">✓</span>                                |
| 20.2 | Observable completes when channel closes                                | <span class="g">✓</span>       | <span class="g">✓</span>                                |
| 20.3 | Chains standard operators                                               | <span class="g">✓</span>       | <span class="g">✓</span>                                |
| 20.4 | Does NOT create custom NewObservable                                    | <span class="g">✓</span>       | <span class="g">✓</span>                                |
|      | **21. tap-for-observability** — logging without modifying stream        | **<span class="g">5/5</span>** | **<span class="r">3/5</span>**                          |
| 21.1 | Uses Tap/TapOnNext/TapOnError/TapOnComplete                             | <span class="g">✓</span>       | <span class="g">✓</span>                                |
| 21.2 | Does NOT use Map with side effect                                       | <span class="g">✓</span>       | <span class="g">✓</span>                                |
| 21.3 | Shows TapOnError for error monitoring                                   | <span class="g">✓</span>       | <span class="r">✗</span> generic Tap only               |
| 21.4 | Explains Tap/Do observe without altering                                | <span class="g">✓</span>       | <span class="g">✓</span>                                |
| 21.5 | Mentions logging plugins (slog, zap, etc.)                              | <span class="g">✓</span>       | <span class="r">✗</span>                                |
|      | **22. connectable-precise-control** — wait for all subscribers          | **<span class="g">5/5</span>** | **<span class="r">4/5</span>**                          |
| 22.1 | Recommends Connectable                                                  | <span class="g">✓</span>       | <span class="g">✓</span>                                |
| 22.2 | Shows ro.Connectable[T](source)                                         | <span class="g">✓</span>       | <span class="r">✗</span> wrong constructor              |
| 22.3 | Sets up subscribers before Connect                                      | <span class="g">✓</span>       | <span class="g">✓</span>                                |
| 22.4 | Explains Connect() starts execution                                     | <span class="g">✓</span>       | <span class="g">✓</span>                                |
| 22.5 | Explains why Share() is wrong                                           | <span class="g">✓</span>       | <span class="g">✓</span>                                |
|      | **23. flatmap-vs-map** — flatten Observable[Observable[T]]              | **<span class="g">4/4</span>** | **<span class="r">3/4</span>**                          |
| 23.1 | Recommends FlatMap or MergeMap                                          | <span class="g">✓</span>       | <span class="g">✓</span>                                |
| 23.2 | Shows FlatMap code                                                      | <span class="g">✓</span>       | <span class="r">✗</span> wrong generic syntax           |
| 23.3 | Explains map+flatten behavior                                           | <span class="g">✓</span>       | <span class="g">✓</span>                                |
| 23.4 | Does NOT suggest Map+MergeAll as primary                                | <span class="g">✓</span>       | <span class="g">✓</span>                                |
|      | **24. async-subject-final** — last value on completion                  | **<span class="g">5/5</span>** | **<span class="r">4/5</span>**                          |
| 24.1 | Recommends AsyncSubject                                                 | <span class="g">✓</span>       | <span class="g">✓</span>                                |
| 24.2 | Shows `NewAsyncSubject[T]()` constructor                                | <span class="g">✓</span>       | <span class="r">✗</span> wrong constructor              |
| 24.3 | Explains last value only on completion                                  | <span class="g">✓</span>       | <span class="g">✓</span>                                |
| 24.4 | Does NOT recommend BehaviorSubject                                      | <span class="g">✓</span>       | <span class="g">✓</span>                                |
| 24.5 | Does NOT recommend ReplaySubject(1)                                     | <span class="g">✓</span>       | <span class="g">✓</span>                                |
|      | **25. version-stability** — v0 pre-release warnings                     | **<span class="g">4/4</span>** | **<span class="r">3/4</span>**                          |
| 25.1 | Mentions v0.x (pre-v1.0.0)                                              | <span class="g">✓</span>       | <span class="g">✓</span>                                |
| 25.2 | Warns about breaking changes                                            | <span class="g">✓</span>       | <span class="g">✓</span>                                |
| 25.3 | Mentions SemVer                                                         | <span class="g">✓</span>       | <span class="r">✗</span> not confident about SemVer     |
| 25.4 | Does NOT present as fully stable                                        | <span class="g">✓</span>       | <span class="g">✓</span>                                |

</details>

## `golang-uber-dig` — v1.0.0

|             | With Skill         | Without Skill       | Delta     |
| ----------- | ------------------ | ------------------- | --------- |
| **Overall** | **20/20 (100%)**   | **18/20 (90%)**     | **+10pp** |

<details>
<summary>Full breakdown (20 assertions)</summary>

**Model:** Claude Opus 4.7 | **Runs:** 4 evals × 2 configs = 8 subagents | **Grading:** human (assertion-by-assertion)

> **Note:** Preliminary subset of the 11-eval suite in `skills/golang-uber-dig/evals/evals.json` (53 assertions total). The remaining 7 evals cover named values, dig.As, scopes for request-locals, DryRun graph validation, RecoverFromPanics, group flatten, and the fx-vs-dig recommendation. Re-run the full suite via `/skill-creator` for a complete report.

| #    | Assertion                                                                        | With                           | Without                                          |
| ---- | -------------------------------------------------------------------------------- | ------------------------------ | ------------------------------------------------ |
|      | **1. param-objects-many-deps** — dig.In for 4+ deps                              | **<span class="g">5/5</span>** | **<span class="g">5/5</span>**                   |
| 1.1  | Embeds dig.In in the parameter struct                                            | <span class="g">✓</span>       | <span class="g">✓</span>                         |
| 1.2  | Constructor takes the params struct as a single argument                         | <span class="g">✓</span>       | <span class="g">✓</span>                         |
| 1.3  | Does NOT keep the long parameter list                                            | <span class="g">✓</span>       | <span class="g">✓</span>                         |
| 1.4  | Does NOT use a plain struct without dig.In                                       | <span class="g">✓</span>       | <span class="g">✓</span>                         |
| 1.5  | Mentions readability/maintainability benefit                                     | <span class="g">✓</span>       | <span class="g">✓</span>                         |
|      | **2. value-groups-for-handlers** — group:"routes"                                | **<span class="g">5/5</span>** | **<span class="g">5/5</span>**                   |
| 2.1  | Each handler returns dig.Out tagged group:"routes"                               | <span class="g">✓</span>       | <span class="g">✓</span>                         |
| 2.2  | NewRouter consumes dig.In with []slice tagged group:"routes"                     | <span class="g">✓</span>       | <span class="g">✓</span>                         |
| 2.3  | Handlers added with c.Provide; no manual slice in main()                         | <span class="g">✓</span>       | <span class="g">✓</span>                         |
| 2.4  | Does NOT manually assemble the handler slice                                     | <span class="g">✓</span>       | <span class="g">✓</span>                         |
| 2.5  | Mentions group order is not guaranteed                                           | <span class="g">✓</span>       | <span class="g">✓</span>                         |
|      | **6. container-not-passed-around** — composition-root only                       | **<span class="g">5/5</span>** | **<span class="g">5/5</span>**                   |
| 6.1  | Advises against passing *dig.Container into business code                        | <span class="g">✓</span>       | <span class="g">✓</span>                         |
| 6.2  | Container only at composition root (main / startup)                              | <span class="g">✓</span>       | <span class="g">✓</span>                         |
| 6.3  | UserHandler takes typed dependencies as constructor parameters                   | <span class="g">✓</span>       | <span class="g">✓</span>                         |
| 6.4  | Mentions service locator anti-pattern OR explains downside                       | <span class="g">✓</span>       | <span class="g">✓</span>                         |
| 6.5  | Does NOT show example with container injected into handler                       | <span class="g">✓</span>       | <span class="g">✓</span>                         |
|      | **8. decorate-not-rewrite** — Decorate vs scope-shadow Provide                   | **<span class="g">5/5</span>** | **<span class="r">3/5</span>**                   |
| 8.1  | Uses Decorate (c.Decorate / scope.Decorate) on *zap.Logger                       | <span class="g">✓</span>       | <span class="r">✗</span> uses scope.Provide override |
| 8.2  | Decorator returns log.Named("worker")                                            | <span class="g">✓</span>       | <span class="g">✓</span>                         |
| 8.3  | Decorate at the worker scope/module, not globally                                | <span class="g">✓</span>       | <span class="g">✓</span>                         |
| 8.4  | Does NOT modify the original NewLogger constructor                               | <span class="g">✓</span>       | <span class="g">✓</span>                         |
| 8.5  | Mentions decorator scope semantics (applies to scope and descendants)            | <span class="g">✓</span>       | <span class="r">✗</span> describes scope-override semantics instead |

**Analyst pass:** evals 1, 2, and 6 score 5/5 in both configurations — they test knowledge the base model already has, hitting the "common knowledge" anti-pattern flagged in `CLAUDE.md`. Only eval 8 differentiates the skill: the without-skill agent reaches for `scope.Provide` shadowing (which would create a circular dependency at resolution time), while the skill steers to the correct `Decorate` API. Future iterations should redesign evals 1, 2, 6 to target subtler guidance and add cases the model gets wrong without the skill.

</details>

## `golang-uber-fx` — v1.0.0

|             | With Skill         | Without Skill       | Delta     |
| ----------- | ------------------ | ------------------- | --------- |
| **Overall** | **21/21 (100%)**   | **20/21 (95%)**     | **+5pp**  |

<details>
<summary>Full breakdown (21 assertions)</summary>

**Model:** Claude Opus 4.7 | **Runs:** 4 evals × 2 configs = 8 subagents | **Grading:** human (assertion-by-assertion)

> **Note:** Preliminary subset of the 11-eval suite in `skills/golang-uber-fx/evals/evals.json` (56 assertions total). The remaining 7 evals cover fx.Annotate vs fx.Out, fx.Module organization, fx.Supply, value groups, fxevent.ZapLogger, manual lifecycle for CLI embedding, and the fx-vs-dig recommendation. Re-run the full suite via `/skill-creator` for a complete report.

| #    | Assertion                                                                        | With                           | Without                                          |
| ---- | -------------------------------------------------------------------------------- | ------------------------------ | ------------------------------------------------ |
|      | **1. lifecycle-not-init** — OnStart with goroutine                               | **<span class="g">6/6</span>** | **<span class="g">6/6</span>**                   |
| 1.1  | Injects fx.Lifecycle into NewHTTPServer                                          | <span class="g">✓</span>       | <span class="g">✓</span>                         |
| 1.2  | lc.Append with fx.Hook (OnStart starts server, OnStop calls Shutdown)            | <span class="g">✓</span>       | <span class="g">✓</span>                         |
| 1.3  | OnStart launches srv.Serve in a goroutine                                        | <span class="g">✓</span>       | <span class="g">✓</span>                         |
| 1.4  | Does NOT call srv.Serve directly inside the constructor                          | <span class="g">✓</span>       | <span class="g">✓</span>                         |
| 1.5  | Does NOT use init() to start the server                                          | <span class="g">✓</span>       | <span class="g">✓</span>                         |
| 1.6  | OnStop calls srv.Shutdown(ctx) for graceful shutdown                             | <span class="g">✓</span>       | <span class="g">✓</span>                         |
|      | **5. fxtest-with-populate** — fxtest.New + fx.Populate                           | **<span class="g">5/5</span>** | **<span class="g">5/5</span>**                   |
| 5.1  | Uses fxtest.New(t, ...) instead of fx.New                                        | <span class="g">✓</span>       | <span class="g">✓</span>                         |
| 5.2  | Uses fx.Populate(&svc) to extract *UserService                                   | <span class="g">✓</span>       | <span class="g">✓</span>                         |
| 5.3  | Calls app.RequireStart() and app.RequireStop()                                   | <span class="g">✓</span>       | <span class="g">✓</span>                         |
| 5.4  | Provides a fake Database (interface, not real DB)                                | <span class="g">✓</span>       | <span class="g">✓</span>                         |
| 5.5  | Does NOT use fx.Invoke as the primary extraction mechanism                       | <span class="g">✓</span>       | <span class="g">✓</span>                         |
|      | **6. replace-for-fakes** — fx.Replace with fx.Annotate(fx.As)                    | **<span class="g">5/5</span>** | **<span class="r">4/5</span>**                   |
| 6.1  | Uses fx.Replace (or fx.Decorate) inside fxtest.New                               | <span class="g">✓</span>       | <span class="g">✓</span> uses fx.Decorate        |
| 6.2  | Composes ProductionModule alongside the override; module unchanged               | <span class="g">✓</span>       | <span class="g">✓</span>                         |
| 6.3  | Uses fx.Annotate with fx.As(new(Database)) for interface binding                 | <span class="g">✓</span>       | <span class="r">✗</span> mentions but does not use |
| 6.4  | Does NOT modify or duplicate the production module                               | <span class="g">✓</span>       | <span class="g">✓</span>                         |
| 6.5  | Mentions Replace/Decorate is appropriate for tests                               | <span class="g">✓</span>       | <span class="g">✓</span>                         |
|      | **10. onstart-non-blocking** — long-running work in goroutine                    | **<span class="g">5/5</span>** | **<span class="g">5/5</span>**                   |
| 10.1 | OnStart launches the long-running method in a goroutine                          | <span class="g">✓</span>       | <span class="g">✓</span>                         |
| 10.2 | OnStart returns nil quickly without waiting                                      | <span class="g">✓</span>       | <span class="g">✓</span>                         |
| 10.3 | OnStop signals stop and waits for drain (with timeout)                           | <span class="g">✓</span>       | <span class="g">✓</span>                         |
| 10.4 | Does NOT call the long-running method synchronously in OnStart                   | <span class="g">✓</span>       | <span class="g">✓</span>                         |
| 10.5 | Mentions a blocking OnStart hangs the boot                                       | <span class="g">✓</span>       | <span class="g">✓</span>                         |

**Analyst pass:** 3 of 4 evals score equally with and without the skill — the model's baseline knowledge of fx is very strong (lifecycle hooks, fxtest.New, OnStart/goroutine pattern). Only eval 6 differentiates: without the skill the agent picks `fx.Decorate` and skips the `fx.As` interface binding that the production graph requires. This is consistent with a well-known framework where the skill mainly adds value on subtle API choices. Future iterations should target less common patterns: fx.Annotate vs fx.Out trade-offs, fx.Module decorator scoping, fxevent customization, manual lifecycle for CLI embedding.

</details>

## `golang-google-wire` — v1.0.0

|             | With Skill      | Without Skill   | Delta     |
| ----------- | --------------- | --------------- | --------- |
| **Overall** | **49/50 (98%)** | **41/50 (82%)** | **+16pp** |

<details>
<summary>Full breakdown (50 assertions)</summary>

**Model:** Claude Sonnet 4.6 | **Runs:** 10 evals × 2 configs = 20 subagents | **Grading:** LLM-as-Judge

| #    | Assertion                                                                                           | With                           | Without                                                                            |
| ---- | --------------------------------------------------------------------------------------------------- | ------------------------------ | ---------------------------------------------------------------------------------- |
|      | **1. build-constraint-on-injector** — missing `//go:build wireinject` causes duplicate symbols      | **<span class="g">5/5</span>** | **<span class="r">3/5</span>**                                                     |
| 1.1  | Identifies the missing `//go:build wireinject` build tag as the root cause                         | <span class="g">✓</span>       | <span class="r">✗</span> suggested `//go:build ignore` instead                    |
| 1.2  | Shows `//go:build wireinject` as the first line of the injector file                               | <span class="g">✓</span>       | <span class="r">✗</span> showed `//go:build ignore`                               |
| 1.3  | Explains that the tag prevents the stub from being compiled into the binary                        | <span class="g">✓</span>       | <span class="g">✓</span>                                                           |
| 1.4  | Does NOT suggest renaming the function or reorganizing packages as the fix                         | <span class="g">✓</span>       | <span class="g">✓</span>                                                           |
| 1.5  | Does NOT suggest deleting wire_gen.go as the fix                                                   | <span class="g">✓</span>       | <span class="g">✓</span>                                                           |
|      | **2. interface-binding-required** — `wire.Bind` must be explicit; wire never auto-resolves         | **<span class="g">5/5</span>** | **<span class="r">4/5</span>**                                                     |
| 2.1  | Explains that wire never auto-resolves interface satisfaction — bindings must be explicit          | <span class="g">✓</span>       | <span class="g">✓</span>                                                           |
| 2.2  | Shows `wire.Bind(new(UserStore), new(*PostgresUserRepo))` added to the provider set               | <span class="g">✓</span>       | <span class="g">✓</span>                                                           |
| 2.3  | Places `wire.Bind` inside the same `wire.NewSet` (or adds it to a set in `wire.Build`)            | <span class="g">✓</span>       | <span class="g">✓</span>                                                           |
| 2.4  | Explains WHY wire requires explicit bindings (predictability — avoids surprise rebinding)          | <span class="g">✓</span>       | <span class="r">✗</span> cited ambiguity concern, not predictability rationale     |
| 2.5  | Does NOT suggest changing `NewUserRepo` to return `UserStore` directly as the primary fix         | <span class="g">✓</span>       | <span class="g">✓</span>                                                           |
|      | **3. duplicate-type-named-wrapper** — named types disambiguate same underlying type               | **<span class="g">5/5</span>** | **<span class="r">4/5</span>**                                                     |
| 3.1  | Introduces distinct named types (e.g., `type PrimaryDSN string` and `type ReplicaDSN string`)    | <span class="g">✓</span>       | <span class="g">✓</span>                                                           |
| 3.2  | Updates `NewPrimaryDSN` to return `PrimaryDSN` and `NewReplicaDSN` to return `ReplicaDSN`        | <span class="g">✓</span>       | <span class="g">✓</span>                                                           |
| 3.3  | Updates `NewPrimaryDB` and `NewReplicaDB` signatures to accept the named types                    | <span class="g">✓</span>       | <span class="g">✓</span>                                                           |
| 3.4  | Explains that wire enforces one provider per type, so distinct named types are the correct fix    | <span class="g">✓</span>       | <span class="g">✓</span>                                                           |
| 3.5  | Does NOT suggest using a single Config struct with both DSNs as the primary fix                   | <span class="g">✓</span>       | <span class="r">✗</span> presented Config struct as co-primary recommendation      |
|      | **4. cleanup-signature** — `(T, func(), error)` cleanup propagated through injector              | **<span class="g">5/5</span>** | **<span class="r">4/5</span>**                                                     |
| 4.1  | Changes `NewDB` to return `(*sql.DB, func(), error)` where cleanup calls `db.Close()`            | <span class="g">✓</span>       | <span class="g">✓</span>                                                           |
| 4.2  | Changes the injector function to return `(*App, func(), error)` to propagate the cleanup chain   | <span class="g">✓</span>       | <span class="g">✓</span>                                                           |
| 4.3  | Shows main calling `defer cleanup()` after the nil-check                                          | <span class="g">✓</span>       | <span class="r">✗</span> called `defer cleanup()` directly without nil guard       |
| 4.4  | Explains that wire chains cleanup functions in reverse construction order                         | <span class="g">✓</span>       | <span class="g">✓</span>                                                           |
| 4.5  | Does NOT suggest passing db as an extra return value from InitApp alongside *App                  | <span class="g">✓</span>       | <span class="g">✓</span>                                                           |
|      | **5. no-edit-wire-gen** — never edit `wire_gen.go`; re-run `wire ./...`                           | **<span class="g">5/5</span>** | **<span class="g">5/5</span>**                                                     |
| 5.1  | Explicitly says NOT to edit wire_gen.go (it is always overwritten)                               | <span class="g">✓</span>       | <span class="g">✓</span>                                                           |
| 5.2  | Instructs running `wire ./...` to regenerate wire_gen.go                                          | <span class="g">✓</span>       | <span class="g">✓</span>                                                           |
| 5.3  | Explains that `*zap.Logger` must be provided in the graph (via a provider or `wire.Value`)       | <span class="g">✓</span>       | <span class="g">✓</span>                                                           |
| 5.4  | Shows how to add `NewLogger` (or `wire.Value`) to the appropriate `wire.NewSet`                  | <span class="g">✓</span>       | <span class="g">✓</span>                                                           |
| 5.5  | Does NOT present editing wire_gen.go as an option                                                | <span class="g">✓</span>       | <span class="g">✓</span>                                                           |
|      | **6. provider-set-organization** — per-package `wire.NewSet`, not one giant set in main          | **<span class="g">5/5</span>** | **<span class="g">5/5</span>**                                                     |
| 6.1  | Introduces per-package `wire.NewSet` variables (e.g., InfraSet, RepoSet, ServiceSet)             | <span class="g">✓</span>       | <span class="g">✓</span>                                                           |
| 6.2  | Each set lives in its own package's wire.go file (not all in main)                               | <span class="g">✓</span>       | <span class="g">✓</span>                                                           |
| 6.3  | The injector `wire.Build` references the set variables rather than individual providers           | <span class="g">✓</span>       | <span class="g">✓</span>                                                           |
| 6.4  | `wire.Bind` declarations move into the relevant package's set (not into `wire.Build` directly)   | <span class="g">✓</span>       | <span class="g">✓</span>                                                           |
| 6.5  | Explains the benefit: per-package sets are independently composable                               | <span class="g">✓</span>       | <span class="g">✓</span>                                                           |
|      | **7. injector-parameter-vs-value-provider** — injector parameters vs `wire.Value` for pre-built values | **<span class="r">4/5</span>** | **<span class="g">5/5</span>**                                                |
| 7.1  | Shows the injector-parameter approach: `func InitApp(cfg *Config) (*App, func(), error)`         | <span class="g">✓</span>       | <span class="g">✓</span>                                                           |
| 7.2  | OR shows `wire.Value(cfg)` inside `wire.Build` — both are valid answers                           | <span class="r">✗</span>       | <span class="g">✓</span>                                                           |
| 7.3  | Explains that injector parameters are treated as pre-built providers by wire                     | <span class="g">✓</span>       | <span class="g">✓</span>                                                           |
| 7.4  | Does NOT use a global variable as the recommended solution                                        | <span class="g">✓</span>       | <span class="g">✓</span>                                                           |
| 7.5  | Does NOT suggest using `init()` to set the value                                                  | <span class="g">✓</span>       | <span class="g">✓</span>                                                           |
|      | **8. fields-of-struct** — `wire.FieldsOf` promotes struct fields without manual extractors        | **<span class="g">5/5</span>** | **<span class="r">1/5</span>**                                                     |
| 8.1  | Uses `wire.FieldsOf(new(Config), "DatabaseDSN", "CacheAddress", "APIKey")` or a subset           | <span class="g">✓</span>       | <span class="r">✗</span> actively discouraged `wire.FieldsOf`                     |
| 8.2  | Places `wire.FieldsOf` inside the provider set or `wire.Build`                                   | <span class="g">✓</span>       | <span class="r">✗</span> `wire.FieldsOf` not used                                 |
| 8.3  | Updates `NewDB`, `NewCache`, `NewExternalClient` to accept the string fields as parameters        | <span class="g">✓</span>       | <span class="g">✓</span>                                                           |
| 8.4  | Explains that `wire.FieldsOf` promotes struct fields as individual graph nodes                   | <span class="g">✓</span>       | <span class="r">✗</span> dismissed rather than explained                           |
| 8.5  | Does NOT suggest three separate extractor functions as the primary recommendation                 | <span class="g">✓</span>       | <span class="r">✗</span> `ProvideDatabaseDSN` etc. were the only recommendation    |
|      | **9. test-injector-pattern** — test-only `wire.NewSet` with fake bindings                        | **<span class="g">5/5</span>** | **<span class="g">5/5</span>**                                                     |
| 9.1  | Creates a test-only provider set with `NewFakeMailer` and `wire.Bind(new(Mailer), new(*FakeMailer))` | <span class="g">✓</span>   | <span class="g">✓</span>                                                           |
| 9.2  | Creates a test injector function in a `_test.go` file with `//go:build wireinject`               | <span class="g">✓</span>       | <span class="g">✓</span>                                                           |
| 9.3  | The test injector's `wire.Build` composes production sets with the test-only set                  | <span class="g">✓</span>       | <span class="g">✓</span>                                                           |
| 9.4  | Does NOT suggest global variables, monkey-patching, or a runtime DI container for tests          | <span class="g">✓</span>       | <span class="g">✓</span>                                                           |
| 9.5  | Mentions that `wire ./...` (or `go generate`) must be run to produce the test-injector code      | <span class="g">✓</span>       | <span class="g">✓</span>                                                           |
|      | **10. wire-vs-fx-for-daemon** — wire lacks lifecycle; recommend fx for long-running services     | **<span class="g">5/5</span>** | **<span class="g">5/5</span>**                                                     |
| 10.1 | Identifies that wire has no built-in lifecycle management (no OnStart/OnStop hooks)              | <span class="g">✓</span>       | <span class="g">✓</span>                                                           |
| 10.2 | Identifies that wire has no built-in signal handling (SIGINT/SIGTERM)                            | <span class="g">✓</span>       | <span class="g">✓</span>                                                           |
| 10.3 | Recommends uber-go/fx (or flags it as the better fit) for a long-running HTTP daemon             | <span class="g">✓</span>       | <span class="g">✓</span>                                                           |
| 10.4 | Does NOT recommend wire as sufficient for a service requiring graceful shutdown                   | <span class="g">✓</span>       | <span class="g">✓</span>                                                           |
| 10.5 | Mentions that with wire the developer must implement shutdown and signal handling manually        | <span class="g">✓</span>       | <span class="g">✓</span>                                                           |

**Analyst pass:** 5 of 10 evals score equally with and without the skill — evals 5, 6, 9, 10 reflect strong model priors for well-known wire patterns (never-edit wire_gen.go, per-package sets, test injectors, fx-vs-wire comparison). The clearest skill uplift is eval 8 (`wire.FieldsOf`): without the skill, the model actively discourages `wire.FieldsOf` and recommends manual extractor functions instead. Eval 1 also differentiates: without the skill, the model suggests `//go:build ignore` rather than the correct `//go:build wireinject` tag. Eval 7 produced a false negative for the with-skill run — the skill correctly notes `wire.Value` only accepts constant expressions and rejected it for a runtime-parsed config; this is technically correct behavior but the assertion accepts both forms as valid. Future iterations should redesign assertion 7.2 to credit the correct injector-parameter approach when `wire.Value` is rightly excluded.

</details>

## `golang-spf13-cobra` — v1.0.0

|             | With Skill       | Without Skill    | Delta    |
| ----------- | ---------------- | ---------------- | -------- |
| **Overall** | **50/50 (100%)** | **49/50 (98%)**  | **+2pp** |

<details>
<summary>Full breakdown (50 assertions)</summary>

**Model:** Claude Sonnet 4.6 | **Runs:** 12 evals × 2 configs = 24 self-graded evaluations | **Grading:** self-graded (⚠️ biased — model sees assertions in prompt; without-skill baseline inflated; human-as-judge evaluation recommended for accurate uplift)

| #    | Assertion                                                                   | With                           | Without                        |
| ---- | --------------------------------------------------------------------------- | ------------------------------ | ------------------------------ |
|      | **1. rune-vs-run** — RunE vs Run, defer bypass                              | **<span class="g">5/5</span>** | **<span class="g">5/5</span>** |
| 1.1  | Identifies that Run cannot return an error                                  | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 1.2  | Explains only escape from Run is os.Exit or panic, bypassing defers         | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 1.3  | Recommends switching to RunE                                                | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 1.4  | Shows RunE signature: func(cmd *cobra.Command, args []string) error         | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 1.5  | Does NOT suggest goroutine or recover() as the fix                          | <span class="g">✓</span>       | <span class="g">✓</span>       |
|      | **2. args-validator** — len(args) in RunE vs Args field                     | **<span class="g">4/4</span>** | **<span class="r">3/4</span>** |
| 2.1  | Recommends cobra.ExactArgs(1) in the Args field                             | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 2.2  | Shows the Args field on cobra.Command, not inside RunE                      | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 2.3  | Explains cobra generates standard error messages automatically              | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 2.4  | Does NOT suggest keeping the len(args) check inside RunE                    | <span class="g">✓</span>       | <span class="r">✗</span>       |
|      | **3. outstdout** — cmd.OutOrStdout vs os.Stdout                             | **<span class="g">4/4</span>** | **<span class="g">4/4</span>** |
| 3.1  | Identifies os.Stdout (via fmt.Println) as root cause — can't redirect       | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 3.2  | Recommends cmd.OutOrStdout() as the io.Writer for output                    | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 3.3  | Shows cmd.SetOut(buf) in test setup to redirect output                      | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 3.4  | Does NOT suggest using os.Pipe() as the fix                                 | <span class="g">✓</span>       | <span class="g">✓</span>       |
|      | **4. persistentprerun-chain** — PersistentPreRunE replacement not chaining  | **<span class="g">4/4</span>** | **<span class="g">4/4</span>** |
| 4.1  | Explains cobra does NOT chain PersistentPreRunE — child replaces parent     | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 4.2  | Recommends explicitly calling parent's PersistentPreRunE from child         | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 4.3  | Shows calling parent hook: rootCmd.PersistentPreRunE(cmd, args)             | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 4.4  | Does NOT suggest using PreRunE instead as the fix                           | <span class="g">✓</span>       | <span class="g">✓</span>       |
|      | **5. silenceusage** — SilenceUsage and SilenceErrors configuration          | **<span class="g">4/4</span>** | **<span class="g">4/4</span>** |
| 5.1  | Recommends SilenceUsage: true on the root command                           | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 5.2  | Recommends SilenceErrors: true if app prints errors itself                  | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 5.3  | Explains SilenceUsage prevents full usage wall on every error               | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 5.4  | Shows setting fields on root cobra.Command struct                           | <span class="g">✓</span>       | <span class="g">✓</span>       |
|      | **6. addgroup-ordering** — AddGroup before AddCommand                       | **<span class="g">4/4</span>** | **<span class="g">4/4</span>** |
| 6.1  | Identifies root cause: AddGroup must be called BEFORE AddCommand            | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 6.2  | Explains cobra does not retroactively assign groups                         | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 6.3  | Shows correct order: AddGroup, GroupID, AddCommand                          | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 6.4  | Does NOT suggest AddCommand before AddGroup as workaround                   | <span class="g">✓</span>       | <span class="g">✓</span>       |
|      | **7. validargsfunction** — dynamic positional arg completion                | **<span class="g">4/4</span>** | **<span class="g">4/4</span>** |
| 7.1  | Uses ValidArgsFunction (not just ValidArgs []string)                        | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 7.2  | Shows correct signature with args and toComplete parameters                 | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 7.3  | Returns ShellCompDirectiveNoFileComp to suppress file fallback              | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 7.4  | Does NOT suggest parsing shell completion scripts manually                  | <span class="g">✓</span>       | <span class="g">✓</span>       |
|      | **8. registerflagcompletionfunc** — flag value completion                   | **<span class="g">4/4</span>** | **<span class="g">4/4</span>** |
| 8.1  | Uses RegisterFlagCompletionFunc (not ValidArgs on the command)              | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 8.2  | Shows function registered for the specific flag name "format"               | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 8.3  | Returns the static list ["json", "yaml", "table"]                           | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 8.4  | Does NOT suggest modifying shell rc files or completion scripts             | <span class="g">✓</span>       | <span class="g">✓</span>       |
|      | **9. test-isolation** — fresh command tree per test                         | **<span class="g">4/4</span>** | **<span class="g">4/4</span>** |
| 9.1  | Identifies cobra accumulates flag state across Execute() calls              | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 9.2  | Recommends building a fresh command tree per test                           | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 9.3  | Suggests factory function (e.g. newRootCmd()) for fresh trees               | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 9.4  | Does NOT recommend -count=1 as the primary fix                              | <span class="g">✓</span>       | <span class="g">✓</span>       |
|      | **10. matchall** — composing cobra validators                               | **<span class="g">4/4</span>** | **<span class="g">4/4</span>** |
| 10.1 | Uses cobra.MatchAll() to compose validators                                 | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 10.2 | Shows cobra.MatchAll(cobra.ExactArgs(2), cobra.OnlyValidArgs)               | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 10.3 | Sets ValidArgs on the command for OnlyValidArgs to work                     | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 10.4 | Does NOT suggest custom validator duplicating ExactArgs logic               | <span class="g">✓</span>       | <span class="g">✓</span>       |
|      | **11. cobra-vs-viper** — cobra does not handle config files                 | **<span class="g">5/5</span>** | **<span class="g">5/5</span>** |
| 11.1 | Clearly states cobra does NOT handle config file parsing                    | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 11.2 | Recommends viper (spf13/viper) for config file support                      | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 11.3 | Explains cobra handles command tree/flags, viper handles config resolution  | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 11.4 | Mentions BindPFlag as the integration point between cobra and viper         | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 11.5 | Does NOT suggest cobra alone is sufficient for YAML/JSON config files       | <span class="g">✓</span>       | <span class="g">✓</span>       |
|      | **12. cobra-cli-scaffolder** — cobra-cli scaffolding tool                   | **<span class="g">4/4</span>** | **<span class="g">4/4</span>** |
| 12.1 | Mentions cobra-cli as the scaffolding tool                                  | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 12.2 | Shows cobra-cli init or cobra-cli add commands                              | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 12.3 | Explains cobra-cli generates command boilerplate                            | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 12.4 | Does NOT suggest writing boilerplate from scratch as the only option        | <span class="g">✓</span>       | <span class="g">✓</span>       |

**Analyst pass:** Almost all 12 evals score equally with and without the skill because the model's baseline cobra knowledge is strong — RunE, Args validators, OutOrStdout, SilenceUsage, and completions are well-documented. The only differentiating eval is 2.4 (explicitly discouraging len(args) checks in RunE as a backup). The self-grading methodology inflates the without-skill baseline — a human-as-judge rerun is recommended to measure true uplift, particularly on the subtler evals (4: PersistentPreRunE non-chaining, 6: AddGroup ordering, 9: test isolation with factory function).

</details>

## `golang-spf13-viper` — v1.0.0

|             | With Skill       | Without Skill    | Delta    |
| ----------- | ---------------- | ---------------- | -------- |
| **Overall** | **52/53 (98%)**  | **53/53 (100%)** | **-2pp** |

<details>
<summary>Full breakdown (53 assertions)</summary>

**Model:** Claude Sonnet 4.6 | **Runs:** 12 evals × 2 configs = 24 self-graded evaluations | **Grading:** self-graded (⚠️ biased — model sees assertions in prompt; without-skill baseline inflated; human-as-judge evaluation recommended for accurate uplift. Negative delta on eval 8.5: with-skill model mentions GetDuration as alternative, which fails the "Does NOT suggest" assertion; without-skill model omits it, which passes.)

| #    | Assertion                                                                         | With                           | Without                        |
| ---- | --------------------------------------------------------------------------------- | ------------------------------ | ------------------------------ |
|      | **1. env-key-replacer-nested-keys** — SetEnvKeyReplacer for nested keys           | **<span class="g">5/5</span>** | **<span class="g">5/5</span>** |
| 1.1  | Identifies the root cause as missing SetEnvKeyReplacer                            | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 1.2  | Explains viper preserves the dot in 'database.host' when looking up env var       | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 1.3  | Provides the fix: viper.SetEnvKeyReplacer(strings.NewReplacer(".", "_"))          | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 1.4  | Shows full setup requires prefix + replacer + AutomaticEnv together               | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 1.5  | Does NOT suggest renaming the config key to avoid dots                            | <span class="g">✓</span>       | <span class="g">✓</span>       |
|      | **2. sub-returns-nil** — viper.Sub() returns nil for missing keys                 | **<span class="g">5/5</span>** | **<span class="g">5/5</span>** |
| 2.1  | Identifies that viper.Sub() returns nil when the key doesn't exist                | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 2.2  | Shows nil check: if sub := viper.Sub("database"); sub != nil { ... }              | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 2.3  | Suggests returning error or using defaults when sub is nil                        | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 2.4  | Does NOT suggest checking err from Sub() (returns no error, only nil)             | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 2.5  | Optionally suggests UnmarshalKey("database", &dbCfg) as an alternative           | <span class="g">✓</span>       | <span class="g">✓</span>       |
|      | **3. config-file-not-found-graceful** — ConfigFileNotFoundError handling          | **<span class="g">5/5</span>** | **<span class="g">5/5</span>** |
| 3.1  | Uses errors.As(err, &notFound) with *viper.ConfigFileNotFoundError                | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 3.2  | Only propagates errors that are NOT ConfigFileNotFoundError                       | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 3.3  | Continues execution normally when config file is not found                        | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 3.4  | Does NOT use os.Stat or file existence check as the solution                      | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 3.5  | Does NOT ignore all errors from ReadInConfig (real errors still propagate)        | <span class="g">✓</span>       | <span class="g">✓</span>       |
|      | **4. global-viper-test-pollution** — viper.New() for test isolation               | **<span class="g">5/5</span>** | **<span class="g">5/5</span>** |
| 4.1  | Identifies root cause as shared global viper state across tests                   | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 4.2  | Recommends viper.New() per test for isolated instance                             | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 4.3  | Shows v := viper.New() with v.SetConfigFile, v.ReadInConfig, etc.                 | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 4.4  | Does NOT recommend viper.Reset() as the primary solution                          | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 4.5  | Explains why tests are order-dependent (state persists to next test)              | <span class="g">✓</span>       | <span class="g">✓</span>       |
|      | **5. unmarshal-mapstructure-tags** — mapstructure struct tags required            | **<span class="g">4/4</span>** | **<span class="g">4/4</span>** |
| 5.1  | Identifies missing mapstructure struct tag as the root cause                      | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 5.2  | Shows adding `mapstructure:"max_conn"` to the MaxConn field                       | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 5.3  | Explains mapstructure does case-insensitive matching but not underscore-camelcase | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 5.4  | Does NOT suggest using viper.GetInt as the fix                                    | <span class="g">✓</span>       | <span class="g">✓</span>       |
|      | **6. bind-pflag-timing** — BindPFlag must be before Execute()                     | **<span class="g">4/4</span>** | **<span class="g">4/4</span>** |
| 6.1  | Identifies BindPFlag must be called before Execute() / before RunE runs           | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 6.2  | Recommends moving BindPFlag to init() or PersistentPreRunE                        | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 6.3  | Explains cobra parses flags before RunE — binding after misses Changed state      | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 6.4  | Shows correct pattern: define flag + BindPFlag in init()                          | <span class="g">✓</span>       | <span class="g">✓</span>       |
|      | **7. viper-key-case-insensitivity** — viper keys always lowercase                 | **<span class="g">4/4</span>** | **<span class="g">4/4</span>** |
| 7.1  | Explains viper normalizes all keys to lowercase internally                        | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 7.2  | Recommends using lowercase keys consistently in viper.Get* calls                  | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 7.3  | Identifies viper.GetString("database_host") as the correct form                   | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 7.4  | Notes DATABASE_HOST works via lowercasing but is a source of confusion            | <span class="g">✓</span>       | <span class="g">✓</span>       |
|      | **8. duration-decode-hook** — StringToTimeDurationHookFunc for time.Duration      | **<span class="r">4/5</span>** | **<span class="g">5/5</span>** |
| 8.1  | Identifies mapstructure cannot decode duration string without a hook              | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 8.2  | Shows viper.Unmarshal with DecodeHook using StringToTimeDurationHookFunc          | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 8.3  | Uses mapstructure.StringToTimeDurationHookFunc() as part of the hook              | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 8.4  | Does NOT suggest changing config value to nanoseconds                             | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 8.5  | Does NOT suggest using viper.GetDuration as a workaround                          | <span class="r">✗</span>       | <span class="g">✓</span>       |
|      | **9. watch-config-atomic-rename-trap** — fsnotify inode replacement by editors    | **<span class="g">4/4</span>** | **<span class="g">4/4</span>** |
| 9.1  | Explains vim writes atomically via rename (write-to-temp, then rename)            | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 9.2  | Explains fsnotify watches inode, replaced by rename-based writes                  | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 9.3  | Recommends testing with direct writes (os.WriteFile or echo >>) not editor saves  | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 9.4  | Does NOT suggest downgrading vim or switching editors as the fix                  | <span class="g">✓</span>       | <span class="g">✓</span>       |
|      | **10. viper-alone-no-cobra** — viper usable without cobra                         | **<span class="g">4/4</span>** | **<span class="g">4/4</span>** |
| 10.1 | Clearly states viper can be used without cobra                                    | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 10.2 | Explains cobra is for command trees/flags, not needed for HTTP service            | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 10.3 | Shows viper setup without any cobra imports                                       | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 10.4 | Does NOT recommend adding cobra just for configuration purposes                   | <span class="g">✓</span>       | <span class="g">✓</span>       |
|      | **11. unmarshal-key-vs-sub** — UnmarshalKey vs Sub+Unmarshal                      | **<span class="g">4/4</span>** | **<span class="g">4/4</span>** |
| 11.1 | Recommends viper.UnmarshalKey("database", &dbCfg) as the simpler alternative     | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 11.2 | Explains it avoids the nil check required with Sub()                              | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 11.3 | Shows correct usage: viper.UnmarshalKey("database", &dbCfg)                      | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 11.4 | If mentioning Sub+Unmarshal, notes the nil risk                                   | <span class="g">✓</span>       | <span class="g">✓</span>       |
|      | **12. allow-empty-env** — AllowEmptyEnv for empty string env vars                 | **<span class="g">4/4</span>** | **<span class="g">4/4</span>** |
| 12.1 | Explains viper treats empty string env vars as 'not set' by default               | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 12.2 | Introduces viper.AllowEmptyEnv(true) as the fix                                   | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 12.3 | Explains with AllowEmptyEnv(true), empty env var overrides config file value      | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 12.4 | Does NOT suggest using viper.Set() as a workaround                                | <span class="g">✓</span>       | <span class="g">✓</span>       |

**Analyst pass:** All 12 evals score equally or better without the skill because the model's baseline viper knowledge is strong — ConfigFileNotFoundError, viper.New() for tests, mapstructure tags, and UnmarshalKey are all well-documented. The single differentiating point is eval 8.5 (negative): the skill makes the model mention viper.GetDuration as an alternative, which fails the "Does NOT suggest" assertion. The skill's reference to the unmarshal section may be over-helpful on this eval. The self-grading methodology inflates the without-skill baseline throughout. A human-as-judge rerun is recommended targeting evals 1 (env key replacer — the subtlest viper gotcha), 8 (decode hook), and 12 (AllowEmptyEnv — lesser-known API).

</details>

## `golang-swagger` — v1.0.0

|             | With Skill      | Without Skill   | Delta     |
| ----------- | --------------- | --------------- | --------- |
| **Overall** | **58/60 (97%)** | **43/60 (72%)** | **+25pp** |

<details>
<summary>Full breakdown (60 assertions)</summary>

**Model:** Claude Sonnet 4.6 | **Runs:** 12 evals × 2 configs = 24 subagents | **Grading:** Human-as-judge

| #    | Assertion                                                                                               | With                           | Without                        |
| ---- | ------------------------------------------------------------------------------------------------------- | ------------------------------ | ------------------------------ |
|      | **1. gin-blank-import** — blank import + ginSwagger wire-up                                             | **<span class="g">5/5</span>** | **<span class="r">4/5</span>** |
| 1.1  | Adds a blank import of the docs package (e.g., `_ "<module>/docs"`)                                    | <span class="g">✓</span>       | <span class="r">✗</span>       |
| 1.2  | Imports github.com/swaggo/gin-swagger                                                                   | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 1.3  | Imports github.com/swaggo/files                                                                         | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 1.4  | Registers a GET route matching /swagger/*any using ginSwagger.WrapHandler                               | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 1.5  | Does not suggest running swag init again (it was already done)                                          | <span class="g">✓</span>       | <span class="g">✓</span>       |
|      | **2. map-response-type** — map[string]bool cannot be used directly in @Success                          | **<span class="g">5/5</span>** | **<span class="r">3/5</span>** |
| 2.1  | Does NOT use `{object} map[string]bool` directly in @Success                                           | <span class="g">✓</span>       | <span class="r">✗</span>       |
| 2.2  | Defines a named struct for the response OR acknowledges a swaggertype workaround is needed              | <span class="g">✓</span>       | <span class="r">✗</span>       |
| 2.3  | @Success annotation uses a named type (not a raw map literal)                                           | <span class="g">✓</span>       | <span class="r">✗</span>       |
| 2.4  | @Router annotation is present with [get] method                                                         | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 2.5  | @Produce annotation specifies json                                                                      | <span class="g">✓</span>       | <span class="g">✓</span>       |
|      | **3. swaggertype-overrides** — time.Time and []byte need swaggertype tags                               | **<span class="g">5/5</span>** | **<span class="r">1/5</span>** |
| 3.1  | Adds swaggertype tag to CreatedAt field                                                                 | <span class="g">✓</span>       | <span class="r">✗</span>       |
| 3.2  | Adds swaggertype tag to UpdatedAt field with the same treatment                                         | <span class="g">✓</span>       | <span class="r">✗</span>       |
| 3.3  | Adds swaggertype:"string" and format:"base64" to the Payload []byte field                               | <span class="g">✓</span>       | <span class="r">✗</span>       |
| 3.4  | Preserves the json tags (does not remove them)                                                          | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 3.5  | Does not leave time.Time fields without any swaggertype override                                        | <span class="g">✓</span>       | <span class="r">✗</span>       |
|      | **4. chi-dynamic-basepath** — Chi router + BasePath from env var                                        | **<span class="g">5/5</span>** | **<span class="g">5/5</span>** |
| 4.1  | Imports github.com/swaggo/http-swagger                                                                  | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 4.2  | Uses r.Get (chi method) to register the swagger route with a wildcard pattern                           | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 4.3  | Sets docs.SwaggerInfo.BasePath using os.Getenv("API_BASE_PATH") or equivalent                          | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 4.4  | Includes the blank docs import                                                                          | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 4.5  | Does not suggest rebuilding or running swag init per environment                                        | <span class="g">✓</span>       | <span class="g">✓</span>       |
|      | **5. and-security-condition** — && vs two separate @Security lines                                      | **<span class="g">5/5</span>** | **<span class="r">4/5</span>** |
| 5.1  | Uses && between security schemes on a single @Security annotation line                                  | <span class="g">✓</span>       | <span class="r">✗</span>       |
| 5.2  | Does NOT write two separate @Security lines for AND semantics                                           | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 5.3  | References valid security definition names (ApiKeyAuth, BasicAuth, or similar)                          | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 5.4  | Explains or implies that two separate @Security lines would mean OR, not AND                            | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 5.5  | @Security line appears inside the handler doc comment block                                             | <span class="g">✓</span>       | <span class="g">✓</span>       |
|      | **6. tag-exclusion** — swag init --tags with ! prefix to exclude tags                                   | **<span class="g">5/5</span>** | **<span class="r">4/5</span>** |
| 6.1  | Uses the --tags flag (or -t) with swag init                                                             | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 6.2  | Uses ! prefix to exclude tags (e.g., --tags '!Internal,!Admin' or similar)                              | <span class="g">✓</span>       | <span class="r">✗</span>       |
| 6.3  | Shows a complete swag init command                                                                      | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 6.4  | Does not suggest manually editing the generated swagger.json                                            | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 6.5  | Does not require writing custom Go code to filter endpoints                                             | <span class="g">✓</span>       | <span class="g">✓</span>       |
|      | **7. godoc-comment-swag-fmt** — godoc comment line required for swag fmt                                | **<span class="g">5/5</span>** | **<span class="r">4/5</span>** |
| 7.1  | Adds `// CreateOrder godoc` as the first line of the comment block                                     | <span class="g">✓</span>       | <span class="r">✗</span>       |
| 7.2  | godoc comment appears before any @ annotation                                                           | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 7.3  | At minimum includes @Summary, @Router annotations                                                       | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 7.4  | @Router specifies both path and HTTP method                                                             | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 7.5  | Annotation block is placed directly above the function signature                                        | <span class="g">✓</span>       | <span class="g">✓</span>       |
|      | **8. csv-vs-multi** — collectionFormat(multi) for ids, collectionFormat(csv) for fields                 | **<span class="r">4/5</span>** | **<span class="r">2/5</span>** |
| 8.1  | @Param for ids uses collectionFormat(multi)                                                             | <span class="g">✓</span>       | <span class="r">✗</span>       |
| 8.2  | @Param for fields uses collectionFormat(csv) or omits it (csv is the default)                           | <span class="r">✗</span>       | <span class="r">✗</span>       |
| 8.3  | Both params use []string or []int as data type                                                          | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 8.4  | Both params are marked as not required (false)                                                          | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 8.5  | @Router annotation is present with [get] method                                                         | <span class="g">✓</span>       | <span class="r">✗</span>       |
|      | **9. conditional-swagger** — env-based swagger toggle without build tags                                | **<span class="g">5/5</span>** | **<span class="g">5/5</span>** |
| 9.1  | Uses os.Getenv (or equivalent) to read APP_ENV at runtime                                               | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 9.2  | Conditionally registers the swagger route only when not in production                                   | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 9.3  | Does not require separate builds or build tags                                                          | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 9.4  | The blank docs import is still present (or acknowledged as needed)                                      | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 9.5  | Solution works without recompiling between environments                                                 | <span class="g">✓</span>       | <span class="g">✓</span>       |
|      | **10. nested-composition** — Envelope{data=model.User} nested composition syntax                        | **<span class="g">5/5</span>** | **<span class="r">3/5</span>** |
| 10.1 | @Success annotation uses nested composition syntax with curly braces (e.g., Envelope{data=model.User}) | <span class="g">✓</span>       | <span class="r">✗</span>       |
| 10.2 | The inner type is the User struct (or equivalent named type)                                            | <span class="g">✓</span>       | <span class="r">✗</span>       |
| 10.3 | Does not create a new wrapper struct just for documentation purposes                                    | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 10.4 | @Param for the id path parameter is present with path location                                          | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 10.5 | @Router specifies the correct path and [get] method                                                     | <span class="g">✓</span>       | <span class="r">✗</span>       |
|      | **11. enums-min-max-tags** — enums/minimum/maximum struct tags                                          | **<span class="r">4/5</span>** | **<span class="r">4/5</span>** |
| 11.1 | Adds `enums:"admin,editor,viewer"` struct tag to Role field                                            | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 11.2 | Adds `minimum:"0"` and `maximum:"100"` struct tags to Score field                                     | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 11.3 | Adds json tags to all fields                                                                            | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 11.4 | Adds example tags to at least one field                                                                 | <span class="r">✗</span>       | <span class="r">✗</span>       |
| 11.5 | Does not only describe constraints in a comment — they must be machine-readable struct tags              | <span class="g">✓</span>       | <span class="g">✓</span>       |
|      | **12. swaggerignore-serialization** — swaggerignore:"true" vs json:"-"                                 | **<span class="g">5/5</span>** | **<span class="r">4/5</span>** |
| 12.1 | Uses swaggerignore:"true" on the LastModified field                                                     | <span class="g">✓</span>       | <span class="r">✗</span>       |
| 12.2 | Keeps a valid json tag on LastModified (NOT json:"-")                                                   | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 12.3 | Does NOT suggest removing the field from the struct                                                     | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 12.4 | Other struct fields retain their json and swagger documentation                                         | <span class="g">✓</span>       | <span class="g">✓</span>       |
| 12.5 | Explains or implies why json:"-" would be wrong here (breaks serialization)                             | <span class="g">✓</span>       | <span class="g">✓</span>       |

**Analyst pass:** The skill shows clear uplift on annotation mechanics that require knowing non-obvious swag behaviors: blank import requirement (eval 1), map type limitations (eval 2), swaggertype overrides for time.Time and []byte (eval 3), nested composition syntax (eval 10), and swaggerignore vs json:"-" (eval 12). Evals 4 (Chi+env) and 9 (conditional toggle) scored 5/5 in both conditions — the model already knows how to read env vars and register Chi routes, so these evals test common knowledge rather than skill uplift. Eval 11 shows a consistent miss on the `example:` struct tag in both conditions, indicating a coverage gap rather than discrimination; the skill should add an explicit example on `example:` struct tag usage. Future iterations should also target less-known swag behaviors: `@extensions`, `@x-` custom properties, multi-file init patterns (`--dir` flag), and OpenAPI 3.0 output.

</details>

<!-- prettier-ignore-end -->
