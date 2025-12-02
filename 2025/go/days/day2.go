package days

import (
	"bufio"
	"bytes"
	"log"
	"regexp"
	"strconv"
)

type Day2 struct{}

func RunDay2(input []byte) {
	day := new(Day2)
	log.Printf("D2P1: %d", day.part1(input))
	log.Printf("D2P2: %d", day.part2(input))
}

func (*Day2) part1(input []byte) int {
	scanner := bufio.NewScanner(bytes.NewReader(input))
	re := regexp.MustCompile(`(\d+)-(\d+)`)
	idSum := 0
	for scanner.Scan() {
		line := scanner.Text()
		matches := re.FindAllStringSubmatch(line, -1)
		for _, match := range matches {
			var left, right int
			lowerbound, _ := strconv.Atoi(match[1])
			upperbound, _ := strconv.Atoi(match[2])
			left, _ = strconv.Atoi(match[1][:len(match[1])/2])
			if len(match[2])%2 == 0 {
				right, _ = strconv.Atoi(match[2][:len(match[2])/2])
			} else {
				right, _ = strconv.Atoi(match[2][:len(match[2])/2+1])
			}
			for val := left; val <= right; val++ {
				valAsString := strconv.Itoa(val)
				doubledVal, _ := strconv.Atoi(valAsString + valAsString)
				if doubledVal >= lowerbound && doubledVal <= upperbound {
					idSum += doubledVal
				}
			}
		}
	}

	return idSum
}

func splitIntoParts(input string, parts int) []string {
	partsSize := len(input) / parts
	res := make([]string, parts)
	for i := range parts {
		res[i] = input[i*partsSize : (i+1)*partsSize]
	}
	return res
}

func (*Day2) part2(input []byte) int {
	scanner := bufio.NewScanner(bytes.NewReader(input))
	re := regexp.MustCompile(`(\d+)-(\d+)`)
	idSum := 0
	for scanner.Scan() {
		line := scanner.Text()
		matches := re.FindAllStringSubmatch(line, -1)
		for _, match := range matches {
			left, _ := strconv.Atoi(match[1])
			right, _ := strconv.Atoi(match[2])
			for val := left; val <= right; val++ {
				value := strconv.Itoa(val)
				length := len(value)
				for l := 2; l <= length; l++ {
					if len(value)%l == 0 {
						parts := splitIntoParts(value, l)
						equal := true
						for i := 1; i < len(parts); i++ {
							if parts[0] != parts[i] {
								equal = false
								break
							}
						}
						if equal {
							idSum += val
							break
						}
					}
				}
			}
		}
	}

	return idSum
}
