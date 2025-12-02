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
