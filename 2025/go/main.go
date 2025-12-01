package main

import (
	"embed"
	"log"

	"advent_of_code/days"
)

//go:embed input/*
var inputs embed.FS

func main() {
	files, err := inputs.ReadDir("input")
	if err != nil {
		log.Fatal("Couldn't open input")
	}

	for _, file := range files {
		data, err := inputs.ReadFile("input/" + file.Name())
		if err != nil {
			log.Printf("Couldn't open file %s", file.Name())
			continue
		}
		switch file.Name() {
		case "1":
			days.Day1(data)
		default:
			log.Println("Unknown day")
		}
	}
}
