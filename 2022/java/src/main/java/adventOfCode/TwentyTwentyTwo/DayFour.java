package adventOfCode.TwentyTwentyTwo;

import java.io.BufferedReader;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.List;

public class DayFour
{
    Path inputFile;
    List<String> pairs = new ArrayList<>();

    public DayFour(String inputFile)
    {
        this.inputFile = Path.of(inputFile);
        readInput(this.inputFile);
    }

    private static boolean contains(String[] individuals)
    {
        int startElf1 = Integer.parseInt(individuals[0].split("-")[0]);
        int startElf2 = Integer.parseInt(individuals[1].split("-")[0]);
        int endElf1 = Integer.parseInt(individuals[0].split("-")[1]);
        int endElf2 = Integer.parseInt(individuals[1].split("-")[1]);

        return (startElf2 >= startElf1 && endElf2 <= endElf1) || (startElf1 >= startElf2 && endElf1 <= endElf2);
    }

    private static boolean overlaps(String[] individuals)
    {
        int startElf1 = Integer.parseInt(individuals[0].split("-")[0]);
        int startElf2 = Integer.parseInt(individuals[1].split("-")[0]);
        int endElf1 = Integer.parseInt(individuals[0].split("-")[1]);
        int endElf2 = Integer.parseInt(individuals[1].split("-")[1]);

        return (startElf2 >= startElf1 && endElf2 <= endElf1)
                || (startElf1 >= startElf2 && endElf1 <= endElf2)
                || endElf2 >= startElf1 && endElf1 >= startElf2;
    }

    public int numberOfContainingPairs()
    {
        int count = 0;
        for (String pair : pairs)
        {
            String[] individuals = pair.split(",");
            if (contains(individuals))
            {
                count++;
            }
        }
        return count;
    }

    public int numberOfOverlappingPairs()
    {
        int count = 0;
        for (String pair : pairs)
        {
            String[] individuals = pair.split(",");
            if (overlaps(individuals))
            {
                count++;
            }
        }
        return count;
    }

    private void readInput(Path inputFile)
    {
        try (BufferedReader bufferedReader = Files.newBufferedReader(inputFile))
        {
            String line;
            while ((line = bufferedReader.readLine()) != null)
            {
                this.pairs.add(line);
            }
        } catch (IOException e)
        {
            throw new RuntimeException(e);
        }
    }
}
