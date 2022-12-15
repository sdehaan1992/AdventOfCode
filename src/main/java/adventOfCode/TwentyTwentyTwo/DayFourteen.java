package adventOfCode.TwentyTwentyTwo;

import java.awt.*;
import java.io.BufferedReader;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.List;
import java.util.*;

public class DayFourteen
{
    Path input;
    List<String> lines = new ArrayList<>();
    int maximumY = 0;

    Map<Point, GridObject> grid = new HashMap<>();

    public DayFourteen(String input)
    {
        this.input = Path.of(input);
        //        readInput(true);
        //        fillGrid();
        //
        //        // Part 1
        //        System.out.println(answerPart1());

        // Part 2
        grid.clear();
        lines.clear();
        readInput(false);
        fillGrid();
        cheat();
        //draw();
        System.out.println(answerPart2());
    }

    private void draw()
    {
        List<Point> points = new ArrayList<>(grid.keySet());
        Collections.sort(points, new Comparator<Point>()
        {
            @Override
            public int compare(Point o1, Point o2)
            {
                if (o1.y < o2.y)
                {
                    return -1;
                }
                if (o1.y > o2.y)
                {
                    return 1;
                }
                return Integer.compare(o1.x, o2.x);
            }
        });

//        int xAxisSize = 25;
        int xAxisSize = points.get(points.size() - 1).x - points.get(0).x + 1;

        for (int i = 0; i < points.size(); i++)
        {
            if (i % xAxisSize == 0)
            {
                System.out.print("\n");
            }
            System.out.print(grid.get(points.get(i)).display);
        }
    }


    private void cheat()
    {
        List<Point> points = new ArrayList<>(grid.keySet());
        Comparator<Point> pointComparator = (o1, o2) ->
            {
                if (o1.y < o2.y)
                {
                    return -1;
                }
                if (o1.y > o2.y)
                {
                    return 1;
                }
                return Integer.compare(o1.x, o2.x);
            };
        Collections.sort(points, pointComparator);

        int leftx = points.get(0).x;
        int rightx = points.get(points.size() - 1).x;

        int maxSandOnBottomRow = maximumY * 2 + 1;
        List<Point> points2 = getAllPointsOnLine(new Point(500 - (maxSandOnBottomRow / 2 + 1), maximumY + 1),
                new Point(500 + (maxSandOnBottomRow / 2 + 1), maximumY + 1));
        fillWithRocks(points2);

        points = new ArrayList<>(grid.keySet());
        Collections.sort(points, pointComparator);

        int newLeftx = 337;
//        int newLeftx = points.get(maximumY * (rightx - leftx)).x;
        int newRightx = points.get(points.size() - 1).x;

        for(int i = 0; i < leftx - newLeftx; i++)
        {
            fillWithAir(getAllPointsOnLine(new Point(newLeftx + i, 0), new Point(newLeftx + i, maximumY)));
        }
        for(int i = 0; i < newRightx - rightx; i++)
        {
            fillWithAir(getAllPointsOnLine(new Point(newRightx - i, 0), new Point(newRightx - i, maximumY)));
        }
    }

    private int answerPart1()
    {
        int count = 0;
        Sand sand = null;
        int gridSize = grid.size();
        while (sand == null || grid.size() == gridSize)
        {
            sand = new Sand();
            sand.flowWithAbyss(grid);
            grid.put(new Point(sand.position), sand);
            count++;
        }

        return --count;
    }

    private int answerPart2()
    {
        int count = 0;
        Sand sand = null;
        int gridSize = grid.size();
        while (sand == null || grid.size() == gridSize)
        {
            sand = new Sand();
            sand.flow(grid);
            grid.put(new Point(sand.position), sand);
            if (sand.position.equals(new Point(500, 0)))
            {
//                draw();
                grid.clear();
            }
            count++;
        }

        return count;
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

    private void fillWithAir(List<Point> points)
    {
        for (Point point : points)
        {
            grid.put(point, new Air());
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

    private void readInput(boolean isPartOne)
    {
        try (BufferedReader bufferedReader = Files.newBufferedReader(input))
        {
            String line;
            int minimumX = Integer.MAX_VALUE, maximumX = 0;
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
            if (!isPartOne)
            {
                maximumY++;
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

        void flowWithAbyss(Map<Point, GridObject> grid)
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

        void flow(Map<Point, GridObject> grid)
        {
            while (!isAtRest)
            {
                if (grid.get(new Point(position.x, position.y + 1)) instanceof Air)
                {
                    position.translate(0, 1);
                    continue;
                }
                if (grid.get(new Point(position.x - 1, position.y + 1)) instanceof Air)
                {
                    position.translate(-1, 1);
                    continue;
                }
                if (grid.get(new Point(position.x + 1, position.y + 1)) instanceof Air)
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
