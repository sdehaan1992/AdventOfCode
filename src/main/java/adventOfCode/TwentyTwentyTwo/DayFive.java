package adventOfCode.TwentyTwentyTwo;

import java.io.BufferedReader;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.List;
import java.util.Stack;

public class DayFive
{
    Path inputFile;
    List<String> crates = new ArrayList<>();
    List<String> instructions = new ArrayList<>();

    List<Stack<Character>> crateStacks = new ArrayList<>();

    public DayFive(String inputFile)
    {
        this.inputFile = Path.of(inputFile);
        readInput(this.inputFile);
        createStacks();
    }

    public List<Character> crateMover9000()
    {
        List<Character> result = new ArrayList<>();
        for (String instruction : instructions)
        {
            String[] instructionSet = instruction.split(" ");
            int numberOfCratesToMove = Integer.parseInt(instructionSet[1]);
            int indexToMoveFrom = Integer.parseInt(instructionSet[3]) - 1;
            int indexToMoveTo = Integer.parseInt(instructionSet[5]) - 1;

            for (int i = 0; i < numberOfCratesToMove; i++)
            {
                crateStacks.get(indexToMoveTo).push(crateStacks.get(indexToMoveFrom).pop());
            }
        }

        for (Stack<Character> stack : crateStacks)
        {
            result.add(stack.pop());
        }
        return result;
    }

    public List<Character> crateMover9001()
    {
        List<Character> result = new ArrayList<>();
        for (String instruction : instructions)
        {
            String[] instructionSet = instruction.split(" ");
            int numberOfCratesToMove = Integer.parseInt(instructionSet[1]);
            int indexToMoveFrom = Integer.parseInt(instructionSet[3]) - 1;
            int indexToMoveTo = Integer.parseInt(instructionSet[5]) - 1;

            Stack<Character> tempLocation = new Stack<>();

            for (int i = 0; i < numberOfCratesToMove; i++)
            {
                tempLocation.push(crateStacks.get(indexToMoveFrom).pop());
            }
            for (int i = 0; i < numberOfCratesToMove; i++)
            {
                crateStacks.get(indexToMoveTo).push(tempLocation.pop());
            }
        }

        for (Stack<Character> stack : crateStacks)
        {
            result.add(stack.pop());
        }
        return result;
    }

    private void readInput(Path inputFile)
    {
        try (BufferedReader bufferedReader = Files.newBufferedReader(inputFile))
        {
            boolean foundBlank = false;
            String line;
            while ((line = bufferedReader.readLine()) != null)
            {
                if (!foundBlank)
                {
                    if (line.isBlank())
                    {
                        foundBlank = true;
                    } else
                    {
                        crates.add(line);
                    }
                } else
                {
                    instructions.add(line);
                }
            }
        } catch (IOException e)
        {
            throw new RuntimeException(e);
        }
    }

    private void createStacks()
    {
        String crateNumbers = crates.get(crates.size() - 1).trim();
        int numberOfStacks = Integer.parseInt(String.valueOf(crateNumbers.charAt(crateNumbers.length() - 1)));
        for (int i = 0; i < numberOfStacks; i++)
        {
            crateStacks.add(new Stack<>());
        }

        for (int i = crates.size() - 2; i >= 0; i--)
        {
            String crateLine = crates.get(i);
            for (int j = 0; j < numberOfStacks; j++)
            {
                if (crateLine.length() < j * 4 + 1 || crateLine.charAt(j * 4 + 1) == ' ')
                {
                    continue;
                }
                crateStacks.get(j).push(crateLine.charAt(j * 4 + 1));
            }
        }
    }
}
