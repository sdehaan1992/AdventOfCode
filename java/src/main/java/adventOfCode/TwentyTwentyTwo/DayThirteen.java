package adventOfCode.TwentyTwentyTwo;

import java.io.BufferedReader;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class DayThirteen
{
    Path input;
    List<Signal> signals = new ArrayList<>();

    public DayThirteen(String input)
    {
        this.input = Path.of(input);
        readInput();
    }

    private void readInput()
    {
        try (BufferedReader bufferedReader = Files.newBufferedReader(input))
        {
            int count = 0;
            int pairNumber = 0;
            String line;
            List<Signal> signals = new ArrayList<>();
            while ((line = bufferedReader.readLine()) != null)
            {

                if (line.isBlank())
                {
                    pairNumber++;
                    if (signals.get(0).compareTo(signals.get(1)) <= 0)
                    {
                        count += pairNumber;
                    }
                    signals.clear();
                } else
                {
                    signals.add(new Signal(line));
                    this.signals.add(new Signal(line));
                }
            }
            pairNumber++;
            if (signals.get(0).compareTo(signals.get(1)) <= 0)
            {
                count += pairNumber;
            }

            System.out.println(count);
        } catch (IOException e)
        {
            throw new RuntimeException(e);
        }

        int answer = 1;
        this.signals.add(new Signal("[[2]]"));
        this.signals.add(new Signal("[[6]]"));
        Collections.sort(this.signals);
        for (int i = 0; i < this.signals.size(); i++)
        {
            if (this.signals.get(i).line.equals("[[2]]") || this.signals.get(i).line.equals("[[6]]"))
            {
                answer *= (i + 1);
            }
        }
        System.out.println(answer);
    }


    private static class Signal implements Comparable<Signal>
    {
        int value;
        List<Signal> signals = new ArrayList<>();
        boolean isInteger = false;
        String line;

        public Signal(String signal)
        {
            line = signal;
            if (!signal.startsWith("["))
            {
                value = Integer.parseInt(signal);
                isInteger = true;
            } else if (!signal.equals("[]"))
            {
                signal = signal.substring(1, signal.length() - 1);
                int nestingLevel = 0;
                StringBuilder currentSignal = new StringBuilder();
                for (char character : signal.toCharArray())
                {
                    if (character == ',' && nestingLevel == 0)
                    {
                        signals.add(new Signal(currentSignal.toString()));
                        currentSignal = new StringBuilder();
                    } else
                    {
                        if (character == '[')
                        {
                            nestingLevel++;
                        } else if (character == ']')
                        {
                            nestingLevel--;
                        }
                        currentSignal.append(character);
                    }
                }
                if (!currentSignal.toString().equals(""))
                {
                    signals.add(new Signal(currentSignal.toString()));
                }
            }
        }

        @Override
        public int compareTo(Signal o)
        {
            if (isInteger && o.isInteger)
            {
                return Integer.compare(value, o.value);
            } else if (!isInteger && !o.isInteger)
            {
                for (int i = 0; i < Math.min(signals.size(), o.signals.size()); i++)
                {
                    int comparison = signals.get(i).compareTo(o.signals.get(i));
                    if (comparison != 0)
                    {
                        return comparison;
                    }
                }
                return Integer.compare(signals.size(), o.signals.size());
            }

            if (isInteger)
            {
                return new Signal("[" + value + "]").compareTo(o);
            }
            return this.compareTo(new Signal("[" + o.value + "]"));
        }
    }
}