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
		ticks += value / 100
		if matches[1] == "L" {
			if value%100 >= curr_value && curr_value != 0 {
				ticks++
			}
			value *= -1
		} else {
			if value%100+curr_value >= 100 {
				ticks++
			}
		}

		curr_value = (curr_value + value) % 100
		if curr_value < 0 {
			curr_value += 100
		}
	}

	fmt.Println(ticks)
}
