package adventOfCode.TwentyTwentyTwo;

import java.awt.*;
import java.io.BufferedReader;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.HashSet;
import java.util.Set;

public class DayNine
{
    Path input;
    Knot head = new Knot(0,0);
    Knot tail = new Knot(0,0);

    public DayNine(String input)
    {
        this.input = Path.of(input);
        readInput();
        System.out.println(tail.visitedLocations.size());
    }

    private void readInput()
    {
        try (BufferedReader bufferedReader = Files.newBufferedReader(input))
        {
            String line;
            while ((line = bufferedReader.readLine()) != null)
            {
                String[] instruction = line.split(" ");
                performInstruction(instruction[0], Integer.parseInt(instruction[1]));
            }
        } catch (IOException e)
        {
            e.printStackTrace();
        }
    }

    private void performInstruction(String direction, int times)
    {
        for(int i = 0; i < times; i++)
        {
            move(direction);
        }
    }

    private void move(String direction)
    {
        switch(direction)
        {
            case "U":
                head.translate(0, 1);
                break;
            case "D":
                head.translate(0, -1);
                break;
            case "L":
                head.translate(-1,0);
                break;
            case "R":
                head.translate(1, 0);
                break;
        }

        moveTail();
    }

    private void moveTail()
    {
        int distance = Math.abs(head.x - tail.x);
        distance += Math.abs(head.y - tail.y);
        switch (distance)
        {
            case 0:
            case 1:
                // do nothing
                break;
            case 2:
                if(head.x - tail.x != 0 && head.y - tail.y != 0)
                {
                    break;
                }
                else if(head.x - tail.x != 0)
                {
                    if(head.x - tail.x > 0)
                    {
                        tail.translate(1, 0);
                    }
                    else
                    {
                        tail.translate(-1, 0);
                    }
                }
                else
                {
                    if (head.y > tail.y)
                    {
                        tail.translate(0, 1);
                    }
                    else
                    {
                        tail.translate(0, -1);
                    }
                }
                tail.visitedLocations.add(new Point(tail.x, tail.y));
                break;
            case 3:
                if(Math.abs(head.x - tail.x) > Math.abs(head.y - tail.y))
                {
                    if(head.x - tail.x > 0)
                    {
                        tail.translate(1, head.y - tail.y);
                    }
                    else
                    {
                        tail.translate(-1, head.y - tail.y);
                    }
                }
                else
                {
                    if (head.y > tail.y)
                    {
                        tail.translate(head.x - tail.x, 1);
                    }
                    else
                    {
                        tail.translate(head.x - tail.x, -1);
                    }
                }
                tail.visitedLocations.add(new Point(tail.x, tail.y));
                break;
            default:
                System.out.println("Rope broke...");
        }
    }

    private static class Knot extends Point
    {
        Set<Point> visitedLocations = new HashSet<>();

        public Knot(int x, int y)
        {
            super(x, y);
            visitedLocations.add(new Point(x, y));
        }
    }
}
