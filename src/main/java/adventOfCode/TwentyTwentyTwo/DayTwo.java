package adventOfCode.TwentyTwentyTwo;

import java.io.BufferedReader;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.*;

public class DayTwo
{
    Path inputFile;
    Map<String, Integer> possibilities = new HashMap<>();
    Map<String, String> needToPlay = new HashMap<>();

    public DayTwo(String inputFile)
    {
        this.inputFile = Path.of(inputFile);
        possibilities.put("AX", 4);
        possibilities.put("AY", 8);
        possibilities.put("AZ", 3);
        possibilities.put("BX", 1);
        possibilities.put("BY", 5);
        possibilities.put("BZ", 9);
        possibilities.put("CX", 7);
        possibilities.put("CY", 2);
        possibilities.put("CZ", 6);

        needToPlay.put("AX", "Z");
        needToPlay.put("AY", "X");
        needToPlay.put("AZ", "Y");
        needToPlay.put("BX", "X");
        needToPlay.put("BY", "Y");
        needToPlay.put("BZ", "Z");
        needToPlay.put("CX", "Y");
        needToPlay.put("CY", "Z");
        needToPlay.put("CZ", "X");
    }

    public int calculatePoints() throws IOException
    {
        int points = 0;
        try (BufferedReader bufferedReader = Files.newBufferedReader(inputFile))
        {
            String line;
            while ((line = bufferedReader.readLine()) != null)
            {
                points += possibilities.get(line.replace(" ", ""));
            }
        }

        return points;
    }

    public int calculatePointsForReal() throws IOException
    {
        int points = 0;
        try (BufferedReader bufferedReader = Files.newBufferedReader(inputFile))
        {
            String line;
            while ((line = bufferedReader.readLine()) != null)
            {
                points += possibilities.get(line.charAt(0) + needToPlay.get(line.replace(" ", "")));
            }
        }

        return points;
    }
}
