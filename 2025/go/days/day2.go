package days

import (
	"bufio"
	"bytes"
	"fmt"
	"regexp"
	"strconv"
)

type Day2 struct{}

func RunDay2(input []byte) {
	day := new(Day2)
	day.part1(input)
	day.part2(input)
}

func (*Day2) part1(input []byte) {
	scanner := bufio.NewScanner(bytes.NewReader(input))
	re := regexp.MustCompile(`(\d+)-(\d+)`)
	toCheck, idSum := 0, 0
	for scanner.Scan() {
		line := scanner.Text()
		matches := re.FindAllStringSubmatch(line, -1)
		for _, match := range matches {
			left, _ := strconv.Atoi(match[1])
			right, _ := strconv.Atoi(match[2])
			toCheck += (right - left) + 2
			for val := left; val <= right; val++ {
				value := strconv.Itoa(val)
				length := len(value)
				if length%2 == 0 {
					if value[:length/2] == value[length/2:] {
						idSum += val
					}
				}
			}
		}
	}

	fmt.Println(idSum)
}

func splitIntoParts(input string, parts int) []string {
	if len(input)%parts == 0 {
		partsSize := len(input) / parts
		res := make([]string, parts)
		for i := range parts {
			res[i] = input[i*partsSize : (i+1)*partsSize]
		}
		return res
	}

	return make([]string, 0)
}

func (*Day2) part2(input []byte) {
	scanner := bufio.NewScanner(bytes.NewReader(input))
	re := regexp.MustCompile(`(\d+)-(\d+)`)
	toCheck, idSum := 0, 0
	for scanner.Scan() {
		line := scanner.Text()
		matches := re.FindAllStringSubmatch(line, -1)
		for _, match := range matches {
			left, _ := strconv.Atoi(match[1])
			right, _ := strconv.Atoi(match[2])
			toCheck += (right - left) + 2
			for val := left; val <= right; val++ {
				value := strconv.Itoa(val)
				length := len(value)
				for l := 2; l <= length; l++ {
					parts := splitIntoParts(value, l)
					equal := true
					for i := 1; i < len(parts); i++ {
						if parts[0] != parts[i] {
							equal = false
							break
						}
					}
					if len(parts) > 0 && equal {
						idSum += val
						break
					}
				}
			}
		}
	}

	fmt.Println(idSum)
}
