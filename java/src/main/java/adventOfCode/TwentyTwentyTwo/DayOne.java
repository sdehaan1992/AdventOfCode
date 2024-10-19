package adventOfCode.TwentyTwentyTwo;

import java.io.BufferedReader;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.*;
import java.util.stream.IntStream;

public class DayOne
{
    Path inputFile;

    public DayOne(String inputFile)
    {
        this.inputFile = Path.of(inputFile);
    }

    public int findLargestXOrCrash(int x) throws IOException
    {
        List<Integer> values = new ArrayList<>();
        int current = 0;
        try(BufferedReader bufferedReader = Files.newBufferedReader(inputFile))
        {
            String line;
            while((line = bufferedReader.readLine()) != null)
            {
                if(!line.isBlank())
                {
                    current += Integer.parseInt(line);
                }
                else {
                    values.add(current);
                    current = 0;
                }
            }
        }

        Collections.sort(values);
        return IntStream.rangeClosed(1, x).map(i -> values.get(values.size() - i)).sum();
    }
}
