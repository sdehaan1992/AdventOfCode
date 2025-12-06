package days

import (
	"bufio"
	"bytes"
	"log"
	"regexp"
	"strconv"
	"strings"
)

type Day6 struct{}

func RunDay6(input []byte) {
	day := new(Day6)
	log.Printf("D6P1: %d", day.part1(input))
	log.Printf("D6P2: %d", day.part2(input))
}

func (*Day6) part1(input []byte) int {
	answer := 0
	numbers := make([][]int, 0)
	isAddition := make([]bool, 0)
	scanner := bufio.NewScanner(bytes.NewReader(input))
	re := regexp.MustCompile(`\S+`)
	for scanner.Scan() {
		line := scanner.Text()
		data := re.FindAllString(line, -1)
		for idx, val := range data {
			if len(numbers) == idx {
				numbers = append(numbers, make([]int, 0))
			}
			num, err := strconv.Atoi(val)
			if err != nil {
				if val == "+" {
					isAddition = append(isAddition, true)
				} else {
					isAddition = append(isAddition, false)
				}
			} else {
				numbers[idx] = append(numbers[idx], num)
			}
		}
	}

	for idx, nums := range numbers {
		total := 0
		if isAddition[idx] {
			for _, num := range nums {
				total += num
			}
		} else {
			total = 1
			for _, num := range nums {
				total *= num
			}
		}
		answer += total
	}
	return answer
}

func (*Day6) part2(input []byte) int {
	lines := make([]string, 0)
	colSizes := make([]int, 0)
	scanner := bufio.NewScanner(bytes.NewReader(input))
	for scanner.Scan() {
		lines = append(lines, scanner.Text())
	}

	re := regexp.MustCompile(`\S\s+`)
	sizes := re.FindAllString(lines[len(lines)-1], -1)
	for idx, size := range sizes {
		if idx != len(sizes)-1 {
			colSizes = append(colSizes, len(size)-1)
		} else {
			colSizes = append(colSizes, len(size))
		}
	}

	currIdx := 0
	answer := 0
	for _, length := range colSizes {
		values := make([]string, 0)
		actual_values := make([]string, 0)
		isAddition := true
		for _, line := range lines {
			value := line[currIdx : currIdx+length]
			values = append(values, value)
		}
		var sb strings.Builder
		for i := range length {
			for _, val := range values {
				if val[i] == '*' {
					isAddition = false
				} else if val[i] != '+' {
					sb.WriteByte(val[i])
				}
			}
			valAsString := sb.String()
			actual_values = append(actual_values, valAsString)
			sb.Reset()
		}

		total := 0
		if isAddition {
			for _, val := range actual_values {
				valInt, _ := strconv.Atoi(strings.Trim(val, " "))
				total += valInt
			}
		} else {
			total = 1
			for _, val := range actual_values {
				valInt, _ := strconv.Atoi(strings.Trim(val, " "))
				total *= valInt
			}
		}
		answer += total
		currIdx += length + 1
	}

	return answer
}
