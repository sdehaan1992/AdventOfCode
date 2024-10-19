package adventOfCode.TwentyTwentyTwo;

import java.awt.*;
import java.io.BufferedReader;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.List;

public class DayTwelve
{
    private final Path input;
    private final GridPoint[][] grid = new GridPoint[95][41];
    private GridPoint start;
    private GridPoint finish;

    public DayTwelve(String input)
    {
        this.input = Path.of(input);
        readInput();
        // Part 1
        findPath(finish);
        System.out.println(start.destinationFromSource);

        // Part 2
        int fastestToSeaLevel = Integer.MAX_VALUE;
        for (GridPoint[] gridPoints : grid)
        {
            for (GridPoint gridPoint : gridPoints)
            {
                if (gridPoint.height == 0 && gridPoint.destinationFromSource < fastestToSeaLevel)
                {
                    fastestToSeaLevel = gridPoint.destinationFromSource;
                }
            }
        }

        System.out.println(fastestToSeaLevel);
    }

    private void findPath(GridPoint from)
    {
        for (GridPoint gridPoint : getNeighbours(from))
        {
            if (isVisitable(from, gridPoint))
            {
                gridPoint.previousGridPoint = from;
                gridPoint.destinationFromSource = from.destinationFromSource + 1;
                findPath(gridPoint);
            }
        }
    }

    private List<GridPoint> getNeighbours(GridPoint from)
    {
        List<GridPoint> neighbours = new ArrayList<>();
        if (from.x != grid.length - 1)
        {
            neighbours.add(grid[from.x + 1][from.y]);
        }
        if (from.x != 0)
        {
            neighbours.add(grid[from.x - 1][from.y]);
        }
        if (from.y != grid[grid.length - 1].length - 1)
        {
            neighbours.add(grid[from.x][from.y + 1]);
        }
        if (from.y != 0)
        {
            neighbours.add(grid[from.x][from.y - 1]);
        }

        return neighbours;
    }

    private boolean isVisitable(GridPoint from, GridPoint to)
    {
        return (from.height - to.height) <= 1 && from.destinationFromSource + 1 < to.destinationFromSource;
    }

    private void readInput()
    {
        try (BufferedReader bufferedReader = Files.newBufferedReader(input))
        {
            String line;
            int yAxis = 41;
            while ((line = bufferedReader.readLine()) != null)
            {
                int xAxis = 0;
                yAxis--;
                char[] points = line.toCharArray();
                for (char point : points)
                {
                    GridPoint gridPoint = new GridPoint(xAxis, yAxis);
                    if (point == 83)
                    {
                        gridPoint.height = 0;
                        start = gridPoint;
                    } else if (point == 69)
                    {
                        gridPoint.height = 25;
                        finish = gridPoint;
                        finish.destinationFromSource = 0;
                    } else
                    {
                        gridPoint.height = point - 97;
                    }

                    grid[xAxis][yAxis] = gridPoint;
                    xAxis++;
                }
            }
        } catch (IOException e)
        {
            throw new RuntimeException(e);
        }
    }


    private static class GridPoint extends Point
    {
        int height;
        GridPoint previousGridPoint = null;
        int destinationFromSource = Integer.MAX_VALUE;

        public GridPoint(int x, int y)
        {
            super(x, y);
        }
    }
}