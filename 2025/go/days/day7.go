package days

import (
	"bufio"
	"bytes"
	"log"
	"regexp"
	"strings"
)

type Day7 struct{}

func RunDay7(input []byte) {
	day := new(Day7)
	log.Printf("D7P1: %d", day.part1(input))
	log.Printf("D7P2: %d", day.part2(input))
}

func (*Day7) part1(input []byte) int {
	scanner := bufio.NewScanner(bytes.NewReader(input))
	cols := 0
	var endings []bool
	re := regexp.MustCompile(`\^`)
	total := 0
	for scanner.Scan() {
		line := scanner.Text()
		if cols == 0 {
			cols = len(line)
			endings = make([]bool, cols)
			col := strings.Index(line, "S")
			endings[col] = true
		} else {
			splitterIndex := re.FindAllStringIndex(line, -1)
			for _, val := range splitterIndex {
				col := val[0]
				if endings[col] {
					total++
					endings[col-1] = true
					endings[col+1] = true
					endings[col] = false
				}
			}
		}
	}

	return total
}

func (*Day7) part2(input []byte) int {
	scanner := bufio.NewScanner(bytes.NewReader(input))
	cols := 0
	var endings []int
	re := regexp.MustCompile(`\^`)
	for scanner.Scan() {
		line := scanner.Text()
		if cols == 0 {
			cols = len(line)
			endings = make([]int, cols)
			col := strings.Index(line, "S")
			endings[col] = 1
		} else {
			splitterIndex := re.FindAllStringIndex(line, -1)
			for _, val := range splitterIndex {
				col := val[0]
				if endings[col] != 0 {
					endings[col-1] += endings[col]
					endings[col+1] += endings[col]
					endings[col] = 0
				}
			}
		}
	}

	total := 0
	for _, hits := range endings {
		total += hits
	}
	return total
}
