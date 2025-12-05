package days

import (
	"bufio"
	"bytes"
	"cmp"
	"log"
	"regexp"
	"slices"
	"strconv"
)

type Day5 struct{}

type Range struct {
	lower int
	upper int
}

func RunDay5(input []byte) {
	day := new(Day5)
	log.Printf("D5P1: %d", day.part1(input))
	log.Printf("D5P2: %d", day.part2(input))
}

func (*Day5) part1(input []byte) int {
	scanner := bufio.NewScanner(bytes.NewReader(input))
	isRange := true
	ranges := make([]Range, 0)
	re := regexp.MustCompile(`(\d+)-(\d+)`)
	fresh := 0
	for scanner.Scan() {
		line := scanner.Text()
		if isRange {
			matches := re.FindStringSubmatch(line)
			if len(matches) > 0 {
				lower, _ := strconv.Atoi(matches[1])
				upper, _ := strconv.Atoi(matches[2])
				ranges = append(ranges, Range{lower: lower, upper: upper})
			} else {
				isRange = false
			}
		} else {
			val, _ := strconv.Atoi(line)
			for _, r := range ranges {
				if val >= r.lower && val <= r.upper {
					fresh++
					break
				}
			}
		}
	}

	return fresh
}

func (*Day5) part2(input []byte) int {
	scanner := bufio.NewScanner(bytes.NewReader(input))
	isRange := true
	ranges := make([]Range, 0)
	re := regexp.MustCompile(`(\d+)-(\d+)`)
	for scanner.Scan() {
		line := scanner.Text()
		if isRange {
			matches := re.FindStringSubmatch(line)
			if len(matches) > 0 {
				lower, _ := strconv.Atoi(matches[1])
				upper, _ := strconv.Atoi(matches[2])
				ranges = append(ranges, Range{lower: lower, upper: upper})
			} else {
				break
			}
		}
	}

	slices.SortFunc(ranges, func(a Range, b Range) int {
		return cmp.Compare(a.lower, b.lower)
	})
	ranges = mergeRanges(ranges)

	answer := 0
	for _, val := range ranges {
		answer += (val.upper - val.lower) + 1
	}

	return answer
}

func mergeRanges(ranges []Range) []Range {
	result := []Range{ranges[0]}

	for _, curr := range ranges[1:] {
		last := &result[len(result)-1]

		if curr.lower <= last.upper {
			if curr.upper > last.upper {
				last.upper = curr.upper
			}
		} else {
			result = append(result, curr)
		}
	}

	return result
}
