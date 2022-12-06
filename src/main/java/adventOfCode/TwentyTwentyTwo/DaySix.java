package adventOfCode.TwentyTwentyTwo;

import java.io.BufferedReader;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

public class DaySix
{
    Path input;
    private String inputString;

    public DaySix(String inputFile)
    {
        input = Path.of(inputFile);
    }

    public int readInput(int uniqueNumbers)
    {
        try (BufferedReader bufferedReader = Files.newBufferedReader(input))
        {
            inputString = bufferedReader.readLine();
        } catch (IOException e)
        {
            throw new RuntimeException(e);
        }

        Set<Character> currentSet = new HashSet<>();
        int count = uniqueNumbers - 1;
        while(currentSet.size() != uniqueNumbers)
        {
            currentSet.clear();
            for(int i = count - (uniqueNumbers - 1); i <= count; i++)
            {
                currentSet.add(inputString.charAt(i));
            }
            count++;
        }

        return count;
    }
}
