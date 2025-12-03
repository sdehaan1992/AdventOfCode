package days

import (
	"bufio"
	"bytes"
	"log"
	"strconv"
)

type Day3 struct{}

func RunDay3(input []byte) {
	day := new(Day3)
	log.Printf("D2P1: %d", day.part1(input))
	log.Printf("D2P2: %d", day.part2(input))
}

func (*Day3) part1(input []byte) int {
	scanner := bufio.NewScanner(bytes.NewReader(input))
	result := 0
	for scanner.Scan() {
		line := scanner.Text()
		result += execute(line, 2)
	}

	return result
}

func (*Day3) part2(input []byte) int {
	scanner := bufio.NewScanner(bytes.NewReader(input))
	result := 0
	for scanner.Scan() {
		line := scanner.Text()
		result += execute(line, 12)
	}

	return result
}

func execute(line string, initialBatteries int) int {
	idx, largest := -1, ""
	remainingBatteries := initialBatteries
	resString := ""
	for remainingBatteries > 0 {
		var idxSubString int
		largest, idxSubString = findLargest(line[idx+1 : len(line)-remainingBatteries+1])
		idx += idxSubString + 1
		resString += largest
		remainingBatteries--
	}
	val, _ := strconv.Atoi(resString)
	return val
}

func findLargest(line string) (string, int) {
	largest, idx := 0, 0
	for index, val := range line {
		value, _ := strconv.Atoi(string(val))
		if value > largest {
			largest = value
			idx = index
		}
	}

	return strconv.Itoa(largest), idx
}
