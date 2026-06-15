# Variables, Booleans, Receivers & Acronyms

## Variables

Name length SHOULD be **proportional to scope size**. Short names for small scopes, descriptive names for large scopes.

```go
// Small scope (1-7 lines): short names are fine
for i, v := range items {
    result = append(result, v.Name)
}

// Medium scope: moderately descriptive
userCount := len(users)

// Large scope / package-level: explicit and clear
var defaultHTTPTransport = &http.Transport{
    MaxIdleConns: 100,
}
```

Common single-letter conventions:

| Letter        | Meaning                |
| ------------- | ---------------------- |
| `i`, `j`, `k` | Loop indices           |
| `n`           | Count or length        |
| `v`           | Value (in range loops) |
| `k`           | Key (in map ranges)    |
| `r`           | `io.Reader`            |
| `w`           | `io.Writer`            |
| `b`           | `[]byte` or buffer     |
| `s`           | String                 |
| `t`           | `*testing.T`           |
| `ctx`         | `context.Context`      |
| `err`         | Error                  |

### Avoid Type in the Name

The name should describe what the value represents, not its type.

```go
// Good
users := getUsers()
count := len(items)

// Bad
userSlice := getUsers()
countInt := len(items)
nameString := "hello"
```

### Avoid Repetition with Context

Omit words already clear from the enclosing function, method, or type.

```go
// Good — "user" is clear from the method receiver
func (u *UserService) Create(name string) error { ... }

// Bad — "user" is redundant
func (u *UserService) CreateUser(userName string) error { ... }
```

### Use Predictable Names

The same concept MUST always use the same name across the codebase. If a user is called `user` in one function, it should not become `account`, `person`, or `u` in another. Consistency makes code searchable and reduces cognitive load.

```go
// Good — same concept, same name everywhere
func CreateUser(user *User) error { ... }
func UpdateUser(user *User) error { ... }
func DeleteUser(userID string) error { ... }

// Bad — same concept, different names
func CreateUser(user *User) error { ... }
func UpdateAccount(acct *User) error { ... }   // why "acct"? it's a User
func RemovePerson(id string) error { ... }      // why "person"? why "remove"?
```

This applies to variables, parameters, functions, and fields. Pick one name per domain concept and stick with it: `order` not sometimes `order` / sometimes `purchase`; `userID` not sometimes `userID` / sometimes `uid` / sometimes `userId`.

### Parameters

Parameters double as documentation at the call site. When the type is descriptive, keep the name short. When the type is ambiguous, use a longer name to clarify intent.

```go
// Good — type is descriptive, short name is fine
func AfterFunc(d Duration, f func()) *Timer
func Escape(w io.Writer, s []byte)

// Good — type is ambiguous (int64, string), longer name documents meaning
func Unix(sec, nsec int64) Time
func HasPrefix(s, prefix string) bool

// Bad — ambiguous type with cryptic name
func Unix(a, b int64) Time          // what are a and b?
func HasPrefix(a, b string) bool    // which is the prefix?
```

## Booleans

Boolean variables and fields MUST read naturally as true/false questions. Use prefixes like `is`, `has`, `can`, `allow`, `should`. This applies to **both variables and struct fields**.

```go
// Good — struct fields use is/has prefix
type Client struct {
    isConnected  bool  // reads as "client is connected"
    hasPermission bool // reads as "client has permission"
}

// Good — variables
isReady := true
hasPermission := user.CanEdit(doc)

// Bad — bare adjective is ambiguous
type Client struct {
    connected  bool   // could be confused with a connection object
    permission bool   // noun, not a question
}
```

For exported boolean methods, the prefix becomes part of the method name: `IsValid()`, `HasPrefix()`, `CanRetry()`. The unexported field keeps the prefix too: `isConnected` field → `IsConnected()` method.

## Receivers

Receivers MUST be **1-2 letter abbreviations** of the type name. Use the same name across all methods of a type.

```go
// Good — short, consistent
func (s *Server) Start() error      { ... }
func (s *Server) Stop() error       { ... }
func (s *Server) Handle(r *Request) { ... }

// Bad — too long
func (server *Server) Start() error { ... }

// Bad — inconsistent names across methods
func (s *Server) Start() error      { ... }
func (srv *Server) Stop() error     { ... }

// Bad — NEVER use "this" or "self"
func (this *Server) Handle(r *Request) { ... }
```

## Acronyms and Initialisms

Acronyms MUST be **all caps or all lower**, NEVER mixed. This preserves readability in MixedCaps names.

```go
// Good
URL           // all caps
url           // all lower
HTTPServer    // HTTP is all caps
xmlParser     // xml is all lower
userID        // ID is all caps
newHTTPSURL   // both HTTPS and URL all caps

// Bad
Url           // mixed case acronym
HttpServer    // mixed case
userId        // mixed case for ID
```

When exporting a lowercase acronym, capitalize the whole thing: `url` → `URL`, `grpc` → `GRPC`, `ios` → `IOS`.
