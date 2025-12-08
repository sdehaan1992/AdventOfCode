package days

import (
	"bufio"
	"bytes"
	"cmp"
	"log"
	"math"
	"regexp"
	"slices"
	"strconv"
)

type Day8 struct{}

type Point3D struct {
	x, y, z int
	links   []*Point3D
	marked  bool
}

type distance struct {
	distance    float64
	a, b        *Point3D
	established bool
}

func RunDay8(input []byte) {
	day := new(Day8)
	log.Printf("D8P1: %d", day.part1(input))
	log.Printf("D8P2: %d", day.part2(input))
}

func (*Day8) part1(input []byte) int {
	scanner := bufio.NewScanner(bytes.NewReader(input))
	distances := make([]distance, 0)
	junctions := make([]Point3D, 0)
	re := regexp.MustCompile(`(\d+),(\d+),(\d+)`)
	for scanner.Scan() {
		values := re.FindStringSubmatch(scanner.Text())
		x, _ := strconv.Atoi(values[1])
		y, _ := strconv.Atoi(values[2])
		z, _ := strconv.Atoi(values[3])
		junctions = append(junctions, Point3D{x: x, y: y, z: z})
	}

	for i := 0; i < len(junctions); i++ {
		a := &junctions[i]
		for j := i + 1; j < len(junctions); j++ {
			b := &junctions[j]
			x := (a.x - b.x) * (a.x - b.x)
			y := (a.y - b.y) * (a.y - b.y)
			z := (a.z - b.z) * (a.z - b.z)
			dis := math.Sqrt(float64(x + y + z))
			distances = append(distances, distance{distance: dis, a: a, b: b})
		}
	}

	slices.SortFunc(distances, func(a, b distance) int {
		return cmp.Compare(a.distance, b.distance)
	})

	distances = distances[:1000]
	for idx := range distances {
		distance := &distances[idx]
		distance.a.links = append(distance.a.links, distance.b)
		distance.b.links = append(distance.b.links, distance.a)
	}

	circuits := make([]int, 0)
	for idx := range junctions {
		junction := &junctions[idx]
		if !junction.marked {
			circuit := make([]*Point3D, 0)
			toVisit := make([]*Point3D, 0)
			toVisit = append(toVisit, junction)
			seen := make(map[*Point3D]bool)
			seen[junction] = true
			for len(toVisit) != 0 {
				curr := toVisit[0]
				circuit = append(circuit, curr)
				toVisit = toVisit[1:]
				curr.marked = true
				for _, link := range curr.links {
					if !link.marked && seen[link] == false {
						toVisit = append(toVisit, link)
						seen[link] = true
					}
				}
			}
			circuits = append(circuits, len(circuit))
		}
	}

	slices.Sort(circuits)
	total := 1
	for _, val := range circuits[len(circuits)-3:] {
		total *= val
	}

	return total
}

func (*Day8) part2(input []byte) int {
	scanner := bufio.NewScanner(bytes.NewReader(input))
	distances := make([]distance, 0)
	junctions := make([]Point3D, 0)
	re := regexp.MustCompile(`(\d+),(\d+),(\d+)`)
	for scanner.Scan() {
		values := re.FindStringSubmatch(scanner.Text())
		x, _ := strconv.Atoi(values[1])
		y, _ := strconv.Atoi(values[2])
		z, _ := strconv.Atoi(values[3])
		junctions = append(junctions, Point3D{x: x, y: y, z: z})
	}

	for i := 0; i < len(junctions); i++ {
		a := &junctions[i]
		for j := i + 1; j < len(junctions); j++ {
			b := &junctions[j]
			x := (a.x - b.x) * (a.x - b.x)
			y := (a.y - b.y) * (a.y - b.y)
			z := (a.z - b.z) * (a.z - b.z)
			dis := math.Sqrt(float64(x + y + z))
			distances = append(distances, distance{distance: dis, a: a, b: b})
		}
	}

	slices.SortFunc(distances, func(a, b distance) int {
		return cmp.Compare(a.distance, b.distance)
	})

	for idx := range distances {
		distance := &distances[idx]
		distance.a.links = append(distance.a.links, distance.b)
		distance.b.links = append(distance.b.links, distance.a)
	}

	connected_nodes := make([]*Point3D, 0, len(junctions))
	for _, link := range distances {
		containsA := false
		containsB := false
		for _, node := range connected_nodes {
			if node == link.a {
				containsA = true
			} else if node == link.b {
				containsB = true
			}
		}
		if !containsA {
			connected_nodes = append(connected_nodes, link.a)
			if len(connected_nodes) == len(junctions) {
				return link.a.x * link.b.x
			}
		}
		if !containsB {
			connected_nodes = append(connected_nodes, link.b)
			if len(connected_nodes) == len(junctions) {
				return link.a.x * link.b.x
			}
		}
	}

	return 0
}
