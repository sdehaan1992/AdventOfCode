package days

import (
	"bufio"
	"bytes"
	"log"
	"regexp"
	"strconv"
	"sync"
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

func (*Day2) part2(input []byte) int {
	scanner := bufio.NewScanner(bytes.NewReader(input))
	re := regexp.MustCompile(`(\d+)-(\d+)`)
	idSum := 0
	var wg sync.WaitGroup
	var mutex sync.Mutex
	for scanner.Scan() {
		line := scanner.Text()
		matches := re.FindAllStringSubmatch(line, -1)
		for _, match := range matches {
			wg.Add(1)
			go func(matcher []string, waitGroup *sync.WaitGroup) {
				left, _ := strconv.Atoi(match[1])
				right, _ := strconv.Atoi(match[2])
				for val := left; val <= right; val++ {
					value := strconv.Itoa(val)
					length := len(value)
					for l := 2; l <= length; l++ {
						if len(value)%l == 0 {
							partsSize := len(value) / l
							firstPart := value[:partsSize]
							equal := true
							for i := range l {
								if value[i*partsSize:(i+1)*partsSize] != firstPart {
									equal = false
									break
								}
							}
							if equal {
								mutex.Lock()
								idSum += val
								mutex.Unlock()
								break
							}
						}
					}
				}
				wg.Done()
			}(match, &wg)
		}
	}

	wg.Wait()

	return idSum
}
