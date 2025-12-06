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
			days.RunDay1(data)
		case "2":
			days.RunDay2(data)
		case "3":
			days.RunDay3(data)
		case "4":
			days.RunDay4(data)
		case "5":
			days.RunDay5(data)
		case "6":
			days.RunDay6(data)
		default:
			log.Println("Unknown day")
		}
	}
}
