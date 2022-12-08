package adventOfCode.TwentyTwentyTwo;

import java.io.BufferedReader;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;

public class DayEight
{
    //private int[][] forest = new int[5][5];
    private int[][] forest = new int[99][99];
    private Path input;

    public DayEight(String input) {
        this.input = Path.of(input);
        readInput();
        System.out.println(numberOfVisibleTrees());
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

    private boolean isVisible(int row, int column)
    {
        if(row == 0 || column == 0 || row == forest.length-1 || column == forest[row].length-1)
        {
            return true;
        }

        int treeHeight = forest[row][column];
        
        return checkBelow(row, column, treeHeight) || checkAbove(row, column, treeHeight) || checkLeft(row, column, treeHeight) || checkRight(row, column, treeHeight);
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
