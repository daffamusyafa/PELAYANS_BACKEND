package main

import (
	"fmt"
	"log"
	"os"

	"github.com/dgrijalva/jwt-go"
	"github.com/gin-gonic/gin"
	"github.com/jinzhu/gorm"
	_ "github.com/jinzhu/gorm/dialects/postgres"
	"pelayans/controllers"
	"pelayans/routes"
)

var db *gorm.DB
var err error

func main() {
	// Connect to PostgreSQL database
	dsn := "host=localhost user=postgres password=yourpassword dbname=pelayans port=5432 sslmode=disable"
	db, err = gorm.Open("postgres", dsn)
	if err != nil {
		log.Fatal("Failed to connect to database:", err)
	}
	defer db.Close()

	// Migrate the schema
	db.AutoMigrate(&controllers.User{})

	// Initialize Gin router
	r := gin.Default()

	// Setup routes
	routes.SetupRoutes(r)

	// Start server
	err = r.Run(":5000")
	if err != nil {
		log.Fatal("Unable to start server:", err)
	}
}
