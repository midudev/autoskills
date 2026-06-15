# Manual Constructor Injection

Manual DI is the simplest approach — pass dependencies through constructors. No library, no magic.

## Complete Application Example

```go
func main() {
    ctx, stop := signal.NotifyContext(context.Background(), os.Interrupt)
    defer stop()

    // Layer 1: Configuration
    cfg := LoadConfig()
    logger := slog.New(slog.NewJSONHandler(os.Stdout, nil))

    // Layer 2: Infrastructure
    db, err := postgres.Connect(cfg.DatabaseURL)
    if err != nil {
        logger.Error("database connection failed", "error", err)
        os.Exit(1)
    }
    defer db.Close()

    cache := redis.NewClient(cfg.RedisURL)
    defer cache.Close()

    mailer := smtp.NewMailer(cfg.SMTPAddr)

    // Layer 3: Repositories
    userRepo := postgres.NewUserRepository(db)
    orderRepo := postgres.NewOrderRepository(db)

    // Layer 4: Services
    userSvc := service.NewUserService(userRepo, cache, mailer, logger)
    orderSvc := service.NewOrderService(orderRepo, userSvc, logger)
    paymentSvc := service.NewPaymentService(orderRepo, cfg.StripeKey, logger)

    // Layer 5: Transport
    handler := http.NewHandler(userSvc, orderSvc, paymentSvc, logger)
    server := http.NewServer(cfg.Port, handler)

    // Run
    go server.ListenAndServe()
    <-ctx.Done()
    server.Shutdown(context.Background())
}
```

## When Manual DI Works Well

- Small to medium projects (< 15 services)
- Simple dependency graph with clear layering
- No need for lazy loading or lifecycle management
- Team prefers explicit, visible wiring

## When Manual DI Breaks Down

- Adding a new service means editing `main()` and getting the wiring order right
- Lifecycle management (health checks, graceful shutdown) must be hand-coded with `defer`
- No lazy initialization — all services are created at startup, even if unused
- Cross-cutting concerns (logging, tracing) must be threaded through every constructor
- With 30+ services, the wiring code becomes fragile and hard to maintain

Manual DI SHOULD be the default for small projects (< 15 services). Dependencies MUST be initialized in order — infrastructure first, then repositories, then services, then transport.
