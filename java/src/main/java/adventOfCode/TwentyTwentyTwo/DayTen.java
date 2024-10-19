package adventOfCode.TwentyTwentyTwo;

import java.io.BufferedReader;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.Arrays;
import java.util.SortedMap;
import java.util.TreeMap;

public class DayTen
{
    private final Path input;

    private int register = 1;
    private int cycle = 0;
    private final SortedMap<Integer, Integer> cycleToSignalStrength = new TreeMap<>();
    private String[][] screen = new String[6][40];

    public DayTen(String input)
    {
        this.input = Path.of(input);
        readInput();
        System.out.println(cycleToSignalStrength.get(20) + cycleToSignalStrength.get(60) + cycleToSignalStrength.get(100) + cycleToSignalStrength.get(140) + cycleToSignalStrength.get(180) + cycleToSignalStrength.get(220));
        for (String[] strings : screen)
        {
            String row = Arrays.toString(strings);
            System.out.println(row.replace(", ", ""));
        }
    }

    private void readInput()
    {
        try (BufferedReader bufferedReader = Files.newBufferedReader(input))
        {
            String line;
            while ((line = bufferedReader.readLine()) != null)
            {
                if (!line.equals("noop"))
                {
                    clockTick();
                    clockTick();
                    register += Integer.parseInt(line.split(" ")[1]);
                }
                else
                {
                    clockTick();
                }
            }
        } catch (IOException e)
        {
            throw new RuntimeException(e);
        }
    }

    private void clockTick()
    {
        cycle++;
        cycleToSignalStrength.put(cycle, cycle * register);
        draw();
    }

    private void draw()
    {
        int screenRow = (cycle - 1) / 40;
        int screenColumn = (cycle - 1) % 40;

        if(Math.abs(screenColumn - register) == 1 || screenColumn == register)
        {
            screen[screenRow][screenColumn] = "#";
        }
        else {
            screen[screenRow][screenColumn] = ".";
        }
    }
}
