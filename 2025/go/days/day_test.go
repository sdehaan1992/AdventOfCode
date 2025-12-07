package days

import (
	"log"
	"os"
	"testing"
)

func BenchmarkD1P1(b *testing.B) {
	contents, err := os.ReadFile("../input/1")
	if err != nil {
		log.Fatal("Cannot open test input")
	}

	day := new(Day1)
	for b.Loop() {
		day.part1(contents)
	}
}

func BenchmarkD1P2(b *testing.B) {
	contents, err := os.ReadFile("../input/1")
	if err != nil {
		log.Fatal("Cannot open test input")
	}

	day := new(Day1)
	for b.Loop() {
		day.part2(contents)
	}
}

func BenchmarkD2P1(b *testing.B) {
	contents, err := os.ReadFile("../input/2")
	if err != nil {
		log.Fatal("Cannot open test input")
	}

	day := new(Day2)
	for b.Loop() {
		day.part1(contents)
	}
}

func BenchmarkD2P2(b *testing.B) {
	contents, err := os.ReadFile("../input/2")
	if err != nil {
		log.Fatal("Cannot open test input")
	}

	day := new(Day2)
	for b.Loop() {
		day.part2(contents)
	}
}

func BenchmarkD3P1(b *testing.B) {
	contents, err := os.ReadFile("../input/3")
	if err != nil {
		log.Fatal("Cannot open test input")
	}

	day := new(Day3)
	for b.Loop() {
		day.part1(contents)
	}
}

func BenchmarkD3P2(b *testing.B) {
	contents, err := os.ReadFile("../input/3")
	if err != nil {
		log.Fatal("Cannot open test input")
	}

	day := new(Day3)
	for b.Loop() {
		day.part2(contents)
	}
}

func BenchmarkD4P1(b *testing.B) {
	contents, err := os.ReadFile("../input/4")
	if err != nil {
		log.Fatal("Cannot open test input")
	}

	day := new(Day4)
	for b.Loop() {
		day.part1(contents)
	}
}

func BenchmarkD4P2(b *testing.B) {
	contents, err := os.ReadFile("../input/4")
	if err != nil {
		log.Fatal("Cannot open test input")
	}

	day := new(Day4)
	for b.Loop() {
		day.part2(contents)
	}
}

func BenchmarkD5P1(b *testing.B) {
	contents, err := os.ReadFile("../input/5")
	if err != nil {
		log.Fatal("Cannot open test input")
	}

	day := new(Day5)
	for b.Loop() {
		day.part1(contents)
	}
}

func BenchmarkD5P2(b *testing.B) {
	contents, err := os.ReadFile("../input/5")
	if err != nil {
		log.Fatal("Cannot open test input")
	}

	day := new(Day5)
	for b.Loop() {
		day.part2(contents)
	}
}

func BenchmarkD6P1(b *testing.B) {
	contents, err := os.ReadFile("../input/6")
	if err != nil {
		log.Fatal("Cannot open test input")
	}

	day := new(Day6)
	for b.Loop() {
		day.part1(contents)
	}
}

func BenchmarkD6P2(b *testing.B) {
	contents, err := os.ReadFile("../input/6")
	if err != nil {
		log.Fatal("Cannot open test input")
	}

	day := new(Day6)
	for b.Loop() {
		day.part2(contents)
	}
}

func BenchmarkD7P1(b *testing.B) {
	contents, err := os.ReadFile("../input/7")
	if err != nil {
		log.Fatal("Cannot open test input")
	}

	day := new(Day7)
	for b.Loop() {
		day.part1(contents)
	}
}

func BenchmarkD7P2(b *testing.B) {
	contents, err := os.ReadFile("../input/7")
	if err != nil {
		log.Fatal("Cannot open test input")
	}

	day := new(Day7)
	for b.Loop() {
		day.part2(contents)
	}
}
