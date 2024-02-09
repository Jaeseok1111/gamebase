package gamebase

import (
	"gamebase/ui"
	"net/http"
	"strings"

	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"
)

const trailedAdminPath = "/_/"

func Run(address string) {
	e := echo.New()

	// Middleware
	e.Use(middleware.Logger())
	e.Use(middleware.Recover())

	_BindAdminUI(e)

	e.Logger.Fatal(e.Start(address))
}

func _BindAdminUI(e *echo.Echo) {
	e.GET(
		strings.TrimRight(trailedAdminPath, "/"),
		func(c echo.Context) error {
			return c.Redirect(http.StatusTemporaryRedirect, strings.TrimLeft(trailedAdminPath, "/"))
		},
	)

	e.GET(trailedAdminPath+"*", echo.StaticDirectoryHandler(ui.DistDirFS, false))
}
