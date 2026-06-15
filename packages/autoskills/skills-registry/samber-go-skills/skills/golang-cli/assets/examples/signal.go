package main

import (
	"context"
	"fmt"
	"log/slog"
	"net/http"
	"os"
	"os/signal"
	"syscall"
	"time"

	"github.com/spf13/cobra"
)

// Use signal.NotifyContext to propagate cancellation through context.
var serveWithSignalCmd = &cobra.Command{
	Use:   "serve",
	Short: "Start the server",
	RunE: func(cmd *cobra.Command, args []string) error {
		ctx, stop := signal.NotifyContext(cmd.Context(), os.Interrupt, syscall.SIGTERM)
		defer stop()

		srv := &http.Server{Addr: ":8080"}
		go func() {
			<-ctx.Done()
			shutdownCtx, cancel := context.WithTimeout(context.Background(), 10*time.Second)
			defer cancel()
			srv.Shutdown(shutdownCtx)
		}()

		slog.Info("server starting", "addr", srv.Addr)
		if err := srv.ListenAndServe(); err != http.ErrServerClosed {
			return fmt.Errorf("server failed: %w", err)
		}
		return nil
	},
}
