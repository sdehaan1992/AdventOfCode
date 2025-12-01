package days

import (
	"bufio"
	"bytes"
	"fmt"
	"regexp"
	"strconv"
)

func Day1(input []byte) {
	part1(input)
	part2(input)
}

func part1(input []byte) {
	curr_value := 50
	ticks := 0
	scanner := bufio.NewScanner(bytes.NewReader(input))
	re := regexp.MustCompile(`(\w)(\d+)`)
	for scanner.Scan() {
		line := scanner.Text()
		matches := re.FindStringSubmatch(line)
		value, _ := strconv.Atoi(matches[2])
		if matches[1] == "L" {
			value *= -1
		}

		curr_value += value
		if curr_value%100 == 0 {
			ticks++
		}
	}

	fmt.Println(ticks)
}

func part2(input []byte) {
	curr_value := 50
	ticks := 0
	scanner := bufio.NewScanner(bytes.NewReader(input))
	re := regexp.MustCompile(`(\w)(\d+)`)
	for scanner.Scan() {
		line := scanner.Text()
		matches := re.FindStringSubmatch(line)
		value, _ := strconv.Atoi(matches[2])
		increment := 1
		if matches[1] == "L" {
			increment *= -1
		}

		for range value {
			curr_value += increment
			if curr_value%100 == 0 {
				ticks++
			}
		}
	}

	fmt.Println(ticks)
}
