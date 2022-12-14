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

public class DayFourteen
{
    Path input;
    List<String> lines = new ArrayList<>();

    Map<Point, GridObject> grid = new HashMap<>();

    public DayFourteen(String input)
    {
        this.input = Path.of(input);
        readInput();
        fillGrid();

        // Part 1
        System.out.println(answerPart1());

        // Part 2
        grid.clear();
        lines.clear();
        readInput();
        fillGrid();

    }

    private int answerPart1()
    {
        int count = 0;
        Sand sand = null;
        int gridSize = grid.size();
        while (sand == null || grid.size() == gridSize)
        {
            sand = new Sand();
            sand.flow(grid);
            grid.put(new Point(sand.position), sand);
            count++;
        }

        return --count;
    }

    private void fillGrid()
    {
        for (String line : lines)
        {
            String[] splittedLine = line.replace(" ", "").split("->");
            Point firstPoint = null;
            for (String string : splittedLine)
            {
                String[] pointValues = string.split(",");
                if (firstPoint != null)
                {
                    Point to = new Point(Integer.parseInt(pointValues[0]), Integer.parseInt(pointValues[1]));
                    List<Point> points = getAllPointsOnLine(firstPoint, to);
                    fillWithRocks(points);
                }
                firstPoint = new Point(Integer.parseInt(pointValues[0]), Integer.parseInt(pointValues[1]));
            }
        }
    }

    private void fillWithRocks(List<Point> points)
    {
        for (Point point : points)
        {
            grid.put(point, new Rock());
        }
    }

    private List<Point> getAllPointsOnLine(Point from, Point to)
    {
        List<Point> points = new ArrayList<>();
        if (from.x == to.x)
        {
            if (from.y > to.y)
            {
                for (int i = from.y; i >= to.y; i--)
                {
                    points.add(new Point(from.x, i));
                }
            } else
            {
                for (int i = from.y; i <= to.y; i++)
                {
                    points.add(new Point(from.x, i));
                }
            }
        }
        if (from.y == to.y)
        {
            if (from.x > to.x)
            {
                for (int i = from.x; i >= to.x; i--)
                {
                    points.add(new Point(i, from.y));
                }
            } else
            {
                for (int i = from.x; i <= to.x; i++)
                {
                    points.add(new Point(i, from.y));
                }
            }
        }

        return points;
    }

    private void readInput()
    {
        try (BufferedReader bufferedReader = Files.newBufferedReader(input))
        {
            String line;
            int minimumX = Integer.MAX_VALUE, maximumX = 0, maximumY = 0;
            while ((line = bufferedReader.readLine()) != null)
            {
                lines.add(line);
                String[] splittedLine = line.replace(" ", "").split("->");
                for (String string : splittedLine)
                {
                    String[] pointValues = string.split(",");
                    int x = Integer.parseInt(pointValues[0]);
                    int y = Integer.parseInt(pointValues[1]);
                    if (x > maximumX)
                    {
                        maximumX = x;
                    }
                    if (x < minimumX)
                    {
                        minimumX = x;
                    }
                    if (y > maximumY)
                    {
                        maximumY = y;
                    }
                }
            }
            for (int i = 0; i <= maximumY; i++)
            {
                List<Point> points = getAllPointsOnLine(new Point(minimumX, i), new Point(maximumX, i));
                for (Point point : points)
                {
                    grid.put(point, new Air());
                }
            }

        } catch (IOException e)
        {
            throw new RuntimeException(e);
        }
    }

    private static abstract class GridObject
    {
        String display;
    }

    private static class Rock extends GridObject
    {
        public Rock()
        {
            display = "#";
        }
    }

    private static class Air extends GridObject
    {
        public Air()
        {
            display = ".";
        }
    }

    private static class Sand extends GridObject
    {
        Point position;
        boolean isAtRest = false;

        public Sand()
        {
            position = new Point(500, 0);
            display = "+";
        }

        void flow(Map<Point, GridObject> grid)
        {
            while (!isAtRest && grid.get(position) != null)
            {
                if (grid.get(new Point(position.x, position.y + 1)) instanceof Air || grid.get(new Point(position.x,
                        position.y + 1)) == null)
                {
                    position.translate(0, 1);
                    continue;
                }
                if (grid.get(new Point(position.x - 1, position.y + 1)) instanceof Air || grid.get(new Point(position.x - 1, position.y + 1)) == null)
                {
                    position.translate(-1, 1);
                    continue;
                }
                if (grid.get(new Point(position.x + 1, position.y + 1)) instanceof Air || grid.get(new Point(position.x + 1, position.y + 1)) == null)
                {
                    position.translate(1, 1);
                } else
                {
                    isAtRest = true;
                }
            }
        }
    }
}
