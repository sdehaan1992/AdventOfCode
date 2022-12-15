package adventOfCode.TwentyTwentyTwo;

import java.awt.*;
import java.io.BufferedReader;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class DayFifteen
{
    Path input;
    List<Sensor> sensorList = new ArrayList<>();

    public DayFifteen(String input)
    {
        this.input = Path.of(input);
        readInput();

        answerPart1();
        answerPart2();
    }

    private void answerPart1()
    {
        List<Pair<Integer, Integer>> pairs = new ArrayList<>();
        Map<Point, Object> beaconsOnRow = new HashMap<>();
        for (Sensor sensor : sensorList)
        {
            if(sensor.closestBeacon.y == 2_000_000)
            {
                beaconsOnRow.put(sensor.closestBeacon, new Object());
            }
            Pair<Integer, Integer> pair = sensor.getRangeOfPointsScannedForY(2_000_000);
            if(pair != null)
            {
                pairs.add(sensor.getRangeOfPointsScannedForY(2_000_000));
            }
        }

        pairs.sort((o1, o2) ->
            {
            if (o1.key.equals(o2.key))
            {
                return Integer.compare(o1.value, o2.value);
            }
            return Integer.compare(o1.key, o2.key);
            });

        Pair<Integer, Integer> pair = mergePairs(pairs);
        System.out.printf("Answer part 1 is %d\n", (pair.value - pair.key) + 1 - beaconsOnRow.size());
    }

    private Pair<Integer, Integer> mergePairs(List<Pair<Integer, Integer>> pairs)
    {
        if (pairs.size() > 1)
        {
            Pair<Integer, Integer> firstPair = pairs.get(0);
            Pair<Integer, Integer> combinedPair;
            Pair<Integer, Integer> potentialPair = null;
            int i = 1;
            while (i < pairs.size())
            {
                Pair<Integer, Integer> pair = pairs.get(i);
                if (pair.key <= firstPair.value + 1)
                {
                    if (potentialPair == null)
                    {
                        potentialPair = pair;
                    } else if (potentialPair.value < pair.value)
                    {
                        potentialPair = pair;
                    }
                } else
                {
                    break;
                }
                i++;
            }

            combinedPair = new Pair<>(firstPair.key, potentialPair.value);
            List<Pair<Integer, Integer>> newList = new ArrayList<>();
            newList.add(combinedPair);
            newList.addAll(pairs.subList(i, pairs.size()));
            return mergePairs(newList);
        }

        return pairs.get(0);
    }

    private void answerPart2()
    {
        for (int i = 0; i < 4_000_000; i++)
        {
            List<Pair<Integer, Integer>> pairs = new ArrayList<>();
            for (Sensor sensor : sensorList)
            {
                Pair<Integer, Integer> pair = sensor.getRangeOfPointsScannedForY(i);
                if (pair != null)
                {
                    if (pair.key < 0)
                    {
                        pair.key = 0;
                    }
                    if (pair.value > 4_000_000)
                    {
                        pair.value = 4_000_000;
                    }
                    pairs.add(pair);
                }
            }

            pairs.sort((o1, o2) ->
                {
                if (o1.key.equals(o2.key))
                {
                    return Integer.compare(o1.value, o2.value);
                }
                return Integer.compare(o1.key, o2.key);
                });
            long XLocationOfBeacon = doSomethingTerrible(pairs);
            if (XLocationOfBeacon != -1)
            {
                System.out.printf("Answer part 2 is %d\n", XLocationOfBeacon * 4_000_000 + i);
                break;
            }
        }
    }

    private long doSomethingTerrible(List<Pair<Integer, Integer>> pairs)
    {
        if (pairs.size() > 1)
        {
            Pair<Integer, Integer> firstPair = pairs.get(0);
            Pair<Integer, Integer> combinedPair;
            Pair<Integer, Integer> potentialPair = null;
            int i = 1;
            while (i < pairs.size())
            {
                Pair<Integer, Integer> pair = pairs.get(i);
                if (pair.key <= firstPair.value + 1)
                {
                    if (potentialPair == null)
                    {
                        potentialPair = pair;
                    } else if (potentialPair.value < pair.value)
                    {
                        potentialPair = pair;
                    }
                } else
                {
                    break;
                }
                i++;
            }

            if (potentialPair == null)
            {
                return firstPair.value + 1;
            }
            combinedPair = new Pair<>(firstPair.key, potentialPair.value);
            List<Pair<Integer, Integer>> newList = new ArrayList<>();
            newList.add(combinedPair);
            newList.addAll(pairs.subList(i, pairs.size()));
            return doSomethingTerrible(newList);
        }

        return -1;
    }

    private void readInput()
    {
        try (BufferedReader bufferedReader = Files.newBufferedReader(input))
        {
            String line;
            while ((line = bufferedReader.readLine()) != null)
            {
                Pattern pattern = Pattern.compile("-?\\d+");
                Matcher matcher = pattern.matcher(line);
                List<Integer> numbers = new ArrayList<>();
                while (matcher.find())
                {
                    numbers.add(Integer.valueOf(matcher.group()));
                }
                sensorList.add(new Sensor(new Point(numbers.get(0), numbers.get(1)), new Point(numbers.get(2),
                        numbers.get(3))));
            }
        } catch (IOException e)
        {
            throw new RuntimeException(e);
        }
    }

    private static class Sensor
    {
        Point position;
        Point closestBeacon;
        int distanceToBeacon;

        public Sensor(Point position, Point closestBeacon)
        {
            this.position = position;
            this.closestBeacon = closestBeacon;

            distanceToBeacon = Math.abs(position.x - closestBeacon.x) + Math.abs(position.y - closestBeacon.y);
        }

        Pair<Integer, Integer> getRangeOfPointsScannedForY(int y)
        {
            if (Math.abs(position.y - y) > distanceToBeacon)
            {
                return null;
            }

            int rangeOverY = distanceToBeacon - Math.abs(position.y - y);
            int numberOfPointsScanned = rangeOverY * 2 + 1;
            return new Pair<>(position.x - numberOfPointsScanned / 2, position.x + numberOfPointsScanned / 2);
        }
    }

    private static class Pair<K, V>
    {
        K key;
        V value;

        Pair(K key, V value)
        {
            this.key = key;
            this.value = value;
        }


    }
}
