package adventOfCode.TwentyTwentyTwo;

import java.io.BufferedReader;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.function.Consumer;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class DayEleven
{
    private static final Pattern numberPattern = Pattern.compile("\\d+");
    private final Path input;
    private final List<Monkey> monkeys = new ArrayList<>();

    public DayEleven(String input)
    {
        this.input = Path.of(input);
        readInput();
        for(int i = 0; i < 20; i++)
        {
            round();
        }
        Collections.sort(monkeys);
        System.out.println(monkeys.get(0).numberOfInspections * monkeys.get(1).numberOfInspections);
    }

    private void readInput()
    {
        try (BufferedReader bufferedReader = Files.newBufferedReader(input))
        {
            String line;
            int monkeyLine = 0;
            int countMonkeys = 0;
            while ((line = bufferedReader.readLine()) != null)
            {
                if (!line.isBlank())
                {
                    monkeyLine++;
                    switch (monkeyLine)
                    {
                        case 1:
                            Monkey monkey = new Monkey();
                            monkeys.add(monkey);
                            break;
                        case 2:
                            Matcher matcher = numberPattern.matcher(line);
                            while (matcher.find())
                            {
                                monkeys.get(countMonkeys).items.add(Long.valueOf(matcher.group()));
                            }
                            break;
                        case 3:
                            String[] lineArray = line.split(" ");

                            if (!lineArray[lineArray.length - 1].equals("old"))
                            {
                                monkeys.get(monkeys.size() - 1).operationValue =
                                        Integer.parseInt(lineArray[lineArray.length - 1]);
                            }
                            monkeys.get(monkeys.size() - 1).operationSign =
                                    lineArray[lineArray.length - 2];
                            break;
                        case 4:
                            lineArray = line.split(" ");
                            monkeys.get(monkeys.size() - 1).testValue =
                                    Integer.parseInt(lineArray[lineArray.length - 1]);
                            break;
                        case 5:
                            lineArray = line.split(" ");
                            monkeys.get(monkeys.size() - 1).testTrue =
                                    Integer.parseInt(lineArray[lineArray.length - 1]);
                            break;
                        case 6:
                            lineArray = line.split(" ");
                            monkeys.get(monkeys.size() - 1).testFalse =
                                    Integer.parseInt(lineArray[lineArray.length - 1]);
                            break;
                    }
                } else
                {
                    monkeyLine = 0;
                    countMonkeys++;
                }
            }
        } catch (IOException e)
        {
            throw new RuntimeException(e);
        }
    }

    private void round()
    {
        for(Monkey monkey : monkeys)
        {
            monkey.items.forEach(monkey.testAndThrow);
            monkey.items.clear();
        }
    }

    private class Monkey implements Comparable<Monkey>
    {
        String operationSign;
        long operationValue;
        int testValue, testTrue, testFalse, numberOfInspections;
        List<Long> items = new ArrayList<>();

        Consumer<Long> testAndThrow = new Consumer<Long>()
        {
            @Override
            public void accept(Long integer)
            {
                numberOfInspections++;
                long worryValue;
                long value = operationValue == 0 ? integer : operationValue;
                if (operationSign.equals("*"))
                {
                    worryValue = (integer * value) / 3;
                } else
                {
                    worryValue = (integer + value) / 3;
                }
                Monkey throwTo;
                if (worryValue % testValue == 0)
                {
                    throwTo = DayEleven.this.monkeys.get(testTrue);
                } else
                {
                    throwTo = DayEleven.this.monkeys.get(testFalse);
                }
                throwTo.items.add(worryValue);
            }
        };

        @Override
        public int compareTo(Monkey o)
        {
            if(numberOfInspections > o.numberOfInspections)
            {
                return -1;
            }
            else {
                return 0;
            }
        }
    }
}
