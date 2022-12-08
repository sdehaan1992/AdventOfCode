package adventOfCode.TwentyTwentyTwo;

import java.io.BufferedReader;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;

public class DayEight
{
    private final ElvishTree[][] forest = new ElvishTree[99][99];
    private final Path input;

    public DayEight(String input)
    {
        this.input = Path.of(input);
        readInput();
        System.out.println(numberOfVisibleTrees());
        System.out.println(scenicScore());
    }

    public int numberOfVisibleTrees()
    {
        int count = 0;
        for (int row = 0; row < forest.length; row++)
        {
            for (int column = 0; column < forest[row].length; column++)
            {
                if (isVisible(row, column))
                {
                    count++;
                }
            }
        }

        return count;
    }

    public int scenicScore()
    {
        int highestScore = 0;
        for (int row = 0; row < forest.length; row++)
        {
            for (int column = 0; column < forest[row].length; column++)
            {
                if (forest[row][column].scenicScore > highestScore)
                {
                    highestScore = forest[row][column].scenicScore;
                }
            }
        }

        return highestScore;
    }

    private boolean isVisible(int row, int column)
    {
        int treeHeight = forest[row][column].height;
        return isEdge(row, column) || checkBelow(row, column, treeHeight) | checkAbove(row, column, treeHeight) | checkLeft(row, column, treeHeight) | checkRight(row, column, treeHeight);
    }

    private boolean isEdge(int row, int column)
    {
        return row == 0 || column == 0 || row == forest.length - 1 || column == forest[row].length - 1;
    }

    private boolean checkBelow(int row, int column, int treeHeight)
    {
        int count = 0;
        for (int rowToCheck = row + 1; rowToCheck < forest.length; rowToCheck++)
        {
            count++;
            if (forest[rowToCheck][column].height >= treeHeight)
            {
                forest[row][column].scenicScore *= count;
                return false;
            }
        }
        forest[row][column].scenicScore *= count;
        return true;
    }

    private boolean checkAbove(int row, int column, int treeHeight)
    {
        int count = 0;
        for (int rowToCheck = row - 1; rowToCheck >= 0; rowToCheck--)
        {
            count++;
            if (forest[rowToCheck][column].height >= treeHeight)
            {
                forest[row][column].scenicScore *= count;
                return false;
            }
        }
        forest[row][column].scenicScore *= count;
        return true;
    }

    private boolean checkLeft(int row, int column, int treeHeight)
    {
        int count = 0;
        for (int columnToCheck = column + 1; columnToCheck < forest[row].length; columnToCheck++)
        {
            count++;
            if (forest[row][columnToCheck].height >= treeHeight)
            {
                forest[row][column].scenicScore *= count;
                return false;
            }
        }
        forest[row][column].scenicScore *= count;
        return true;
    }

    private boolean checkRight(int row, int column, int treeHeight)
    {
        int count = 0;
        for (int columnToCheck = column - 1; columnToCheck >= 0; columnToCheck--)
        {
            count++;
            if (forest[row][columnToCheck].height >= treeHeight)
            {
                forest[row][column].scenicScore *= count;
                return false;
            }
        }
        forest[row][column].scenicScore *= count;
        return true;
    }

    private void readInput()
    {
        try (BufferedReader bufferedReader = Files.newBufferedReader(input))
        {
            String line;
            int row = -1;
            while ((line = bufferedReader.readLine()) != null)
            {
                row++;
                String[] trees = line.split("");
                for (int column = 0; column < trees.length; column++)
                {
                    String tree = trees[column];
                    forest[row][column] = new ElvishTree(Integer.parseInt(tree));
                }
            }
        } catch (IOException e)
        {
            throw new RuntimeException(e);
        }
    }

    private static class ElvishTree
    {
        int scenicScore = 1;
        int height;

        public ElvishTree(int height)
        {
            this.height = height;
        }
    }
}
