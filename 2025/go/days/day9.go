package days

import (
	"bufio"
	"bytes"
	"cmp"
	"log"
	"math"
	"slices"
	"strconv"
	"strings"
)

type Day9 struct{}

type square struct {
	diagPoints [2]Point
	size       float64
}

type line2D struct {
	start, end Point
}

func RunDay9(input []byte) {
	day := new(Day9)
	log.Printf("D9P1: %d", day.part1(input))
	log.Printf("D9P2: %d", day.part2(input))
}

func (*Day9) part1(input []byte) int {
	scanner := bufio.NewScanner(bytes.NewReader(input))
	largestArea := 0.0
	redTiles := make([]Point, 0)
	for scanner.Scan() {
		coordinate := strings.Split(scanner.Text(), ",")
		row, _ := strconv.Atoi(coordinate[0])
		col, _ := strconv.Atoi(coordinate[1])
		redTiles = append(redTiles, Point{row: row, col: col})
	}

	for i := 0; i < len(redTiles); i++ {
		a := redTiles[i]
		for j := i + 1; j < len(redTiles); j++ {
			b := redTiles[j]
			area := (math.Abs(float64(a.col-b.col)) + 1) * (math.Abs(float64(a.row-b.row) + 1))
			if area > largestArea {
				largestArea = area
			}
		}
	}

	return int(largestArea)
}

func (*Day9) part2(input []byte) int {
	scanner := bufio.NewScanner(bytes.NewReader(input))
	redTiles := make([]Point, 0)
	edges := make([]line2D, 0)
	for scanner.Scan() {
		coordinate := strings.Split(scanner.Text(), ",")
		row, _ := strconv.Atoi(coordinate[1])
		col, _ := strconv.Atoi(coordinate[0])
		curr := Point{row: row, col: col}
		redTiles = append(redTiles, curr)
	}

	squares := make([]square, 0)
	for i := 0; i < len(redTiles); i++ {
		var curr, next Point
		if i == len(redTiles)-1 {
			curr, next = redTiles[i], redTiles[0]
		} else {
			curr, next = redTiles[i], redTiles[i+1]
		}
		edges = append(edges, line2D{start: curr, end: next})
	}

	for i := 0; i < len(redTiles); i++ {
		a := redTiles[i]
		for j := i + 1; j < len(redTiles); j++ {
			b := redTiles[j]
			area := (math.Abs(float64(a.col-b.col)) + 1) * (math.Abs(float64(a.row-b.row) + 1))
			squares = append(squares, square{diagPoints: [2]Point{a, b}, size: area})
		}
	}

	slices.SortFunc(squares, func(a, b square) int {
		return cmp.Compare(b.size, a.size)
	})

	for _, s := range squares {
		if validSquare(s, edges) {
			return int(s.size)
		}
	}
	return 0
}

func max(a, b int) int {
	if a > b {
		return a
	} else {
		return b
	}
}

func min(a, b int) int {
	if a > b {
		return b
	} else {
		return a
	}
}

func validSquare(s square, boundaries []line2D) bool {
	sColMin := min(s.diagPoints[0].col, s.diagPoints[1].col)
	sColMax := max(s.diagPoints[0].col, s.diagPoints[1].col)
	sRowMin := min(s.diagPoints[0].row, s.diagPoints[1].row)
	sRowMax := max(s.diagPoints[0].row, s.diagPoints[1].row)

	for _, boundary := range boundaries {
		bColMin := min(boundary.start.col, boundary.end.col)
		bColMax := max(boundary.start.col, boundary.end.col)
		bRowMin := min(boundary.start.row, boundary.end.row)
		bRowMax := max(boundary.start.row, boundary.end.row)

		if bColMin == bColMax {
			if sColMin < bColMin && bColMin < sColMax {
				if bRowMax > sRowMin && bRowMin < sRowMax {
					return false
				}
			}
		} else {
			if bRowMin > sRowMin && bRowMin < sRowMax {
				if bColMax > sColMin && bColMin < sColMax {
					return false
				}
			}
		}
	}

	return true
}
