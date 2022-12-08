package adventOfCode.TwentyTwentyTwo;

import java.io.BufferedReader;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;

public class DayEight
{
    private int[][] forest = new int[99][99];
    private Path input;

    public DayEight(String input) {
        this.input = Path.of(input);
        readInput();
        System.out.println(numberOfVisibleTrees());
        System.out.println(scenicScore());
    }

    public int numberOfVisibleTrees()
    {
        int count = 0;
        for(int row = 0; row < forest.length; row++)
        {
            for(int column = 0; column < forest[row].length; column++)
            {
                if(isVisible(row, column))
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
        for(int row = 0; row < forest.length; row++)
        {
            for(int column = 0; column < forest[row].length; column++)
            {
                if(!isEdge(row, column))
                {
                    int scenicScore = determineScenicScore(row, column);
                    //System.out.printf("Scenic Score of tree %d,%d is %d\n", row, column, scenicScore);
                    if(scenicScore > highestScore)
                    {
                        highestScore = scenicScore;
                    }
                }
            }
        }

        return highestScore;
    }

    private int determineScenicScore(int row, int column) {
        return treesLeft(row, column) * treesRight(row, column) * treesAbove(row, column) * treesBelow(row, column);
    }

    private int treesBelow(int row, int column)
    {
        int count = 0;
        int treeHeight = forest[row][column];
        for(int rowToCheck = row +1; rowToCheck < forest.length; rowToCheck++)
        {
            if(forest[rowToCheck][column] < treeHeight)
            {
                count++;
            }
            else
            {
                count++;
                break;
            }
        }
        return count;
    }

    private int treesAbove(int row, int column)
    {
        int count = 0;
        int treeHeight = forest[row][column];
        for(int rowToCheck = row -1; rowToCheck >= 0; rowToCheck--)
        {
            if(forest[rowToCheck][column] < treeHeight)
            {
                count++;
            }
            else
            {
                count++;
                break;
            }
        }
        return count;
    }

    private int treesRight(int row, int column)
    {
        int count = 0;
        int treeHeight = forest[row][column];
        for(int columnToCheck = column - 1; columnToCheck >= 0; columnToCheck--)
        {
            if(forest[row][columnToCheck] < treeHeight)
            {
                count++;
            }
            else
            {
                count++;
                break;
            }
        }
        return count;
    }

    private int treesLeft(int row, int column)
    {
        int count = 0;
        int treeHeight = forest[row][column];
        for(int columnToCheck = column +1; columnToCheck < forest[row].length; columnToCheck++)
        {
            if(forest[row][columnToCheck] < treeHeight)
            {
                count++;
            }
            else
            {
                count++;
                break;
            }
        }
        return count;
    }

    private boolean isVisible(int row, int column)
    {
        int treeHeight = forest[row][column];
        return isEdge(row, column) || checkBelow(row, column, treeHeight) || checkAbove(row, column, treeHeight) || checkLeft(row, column, treeHeight) || checkRight(row, column, treeHeight);
    }

    private boolean isEdge(int row, int column) {
        return row == 0 || column == 0 || row == forest.length - 1 || column == forest[row].length - 1;
    }

    private boolean checkBelow(int row, int column, int treeHeight) {
        for(int rowToCheck = row +1; rowToCheck < forest.length; rowToCheck++)
        {
            if(forest[rowToCheck][column] >= treeHeight)
            {
                return false;
            }
        }
        return true;
    }

    private boolean checkAbove(int row, int column, int treeHeight) {
        for(int rowToCheck = row -1; rowToCheck >= 0; rowToCheck--)
        {
            if(forest[rowToCheck][column] >= treeHeight)
            {
                return false;
            }
        }
        return true;
    }

    private boolean checkLeft(int row, int column, int treeHeight) {
        for(int columnToCheck = column +1; columnToCheck < forest[row].length; columnToCheck++)
        {
            if(forest[row][columnToCheck] >= treeHeight)
            {
                return false;
            }
        }
        return true;
    }

    private boolean checkRight(int row, int column, int treeHeight) {
        for(int columnToCheck = column - 1; columnToCheck >= 0; columnToCheck--)
        {
            if(forest[row][columnToCheck] >= treeHeight)
            {
                return false;
            }
        }
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
                    forest[row][column] = Integer.parseInt(tree);
                }
            }
        } catch (IOException e)
        {
            throw new RuntimeException(e);
        }
    }
}
