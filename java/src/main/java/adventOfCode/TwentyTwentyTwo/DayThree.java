package adventOfCode.TwentyTwentyTwo;

import java.io.BufferedReader;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class DayThree
{
    Path inputFile;
    List<String> rucksacks = new ArrayList<>();

    public DayThree(String inputFile)
    {
        this.inputFile = Path.of(inputFile);
        readInput(this.inputFile);
    }

    public int findCommonInRucksack()
    {
        int priorityPoints = 0;
        for (String rucksack : rucksacks)
        {
            priorityPoints += findAnswerForRucksack(rucksack);
        }
        return priorityPoints;
    }

    public int findBadgePriorities(int rucksacksInGroup)
    {
        int priorityPoints = 0;
        for (int i = 0; i < rucksacks.size(); i = i + rucksacksInGroup)
        {
            priorityPoints += findBadge(rucksacks.subList(i, i + rucksacksInGroup));
        }
        return priorityPoints;
    }

    private void readInput(Path inputFile)
    {
        try (BufferedReader bufferedReader = Files.newBufferedReader(inputFile))
        {
            String line;
            while ((line = bufferedReader.readLine()) != null)
            {
                this.rucksacks.add(line);
            }
        } catch (IOException e)
        {
            throw new RuntimeException(e);
        }
    }

    private int findBadge(List<String> rucksacks)
    {
        char badgeCandidate;
        for (int i = 0; i < rucksacks.get(0).length(); i++)
        {
            for (int j = 1; j < rucksacks.size(); j++)
            {
                badgeCandidate = rucksacks.get(0).charAt(i);
                if (!rucksacks.get(j).contains(Character.toString(badgeCandidate)))
                {
                    break;
                }
                if (j + 1 == rucksacks.size())
                {
                    return getCharacterValue(badgeCandidate);
                }
            }
        }
        return 0;
    }

    private int getCharacterValue(char character)
    {
        return character > 90 ? character - 96 : character - 38;
    }

    private int findAnswerForRucksack(String rucksack)
    {
        String compartment1 = rucksack.substring(0, rucksack.length() / 2);
        String compartment2 = rucksack.substring(rucksack.length() / 2);

        return findBadge(Arrays.asList(compartment1, compartment2));
    }
}