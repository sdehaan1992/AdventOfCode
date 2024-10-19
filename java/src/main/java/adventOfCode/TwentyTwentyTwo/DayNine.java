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
    Knot head = new Knot(0, 0);

    Set<Point> tailVisits = new HashSet<>();

    public DayNine(String input, int knots)
    {
        this.input = Path.of(input);
        createRope(knots);
        readInput();
        System.out.println(tailVisits.size());
    }

    private void createRope(int knots)
    {
        Knot currentKnot = head;
        for (int i = 1; i < knots; i++)
        {
            Knot nextKnot = new Knot(0, 0);
            currentKnot.next = nextKnot;
            currentKnot = nextKnot;
        }
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
        for (int i = 0; i < times; i++)
        {
            move(direction);
        }
    }

    private void move(String direction)
    {
        switch (direction)
        {
            case "U":
                head.translate(0, 1);
                break;
            case "D":
                head.translate(0, -1);
                break;
            case "L":
                head.translate(-1, 0);
                break;
            case "R":
                head.translate(1, 0);
                break;
        }

        Knot currentKnot = head;
        while (currentKnot.next != null)
        {
            moveRope(currentKnot, currentKnot.next);
            currentKnot = currentKnot.next;
        }

        tailVisits.add(new Point(currentKnot.x, currentKnot.y));
    }

    void moveRope(Knot leader, Knot follower)
    {
        int distance = (int) leader.distanceSq(follower);

        switch (distance)
        {
            case 0:
            case 1:
            case 2:
                break;
            case 5:
                if (Math.abs(leader.x - follower.x) == 2)
                {
                    follower.setLocation((leader.x + follower.x) / 2, leader.y);
                } else
                {
                    follower.setLocation(leader.x, (leader.y + follower.y) / 2);
                }
                break;
            case 4:
            case 8:
                follower.setLocation((leader.x + follower.x) / 2, (leader.y + follower.y) / 2);
                break;
            default:
                System.out.println("impossible");
                System.exit(1);
        }
    }

    static class Knot extends Point
    {
        Knot next;

        public Knot(int x, int y)
        {
            super(x, y);
        }
    }
}
