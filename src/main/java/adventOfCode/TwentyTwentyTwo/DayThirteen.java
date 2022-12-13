package adventOfCode.TwentyTwentyTwo;

import java.io.BufferedReader;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class DayThirteen
{
    Path input;
    List<SignalPair> signals = new ArrayList<>();

    public DayThirteen(String input)
    {
        this.input = Path.of(input);
        readInput();
        for(SignalPair signalPair : signals)
        {
            System.out.println(signalPair.isValid());
        }
        System.out.println("check");
    }

    private void readInput()
    {
        try (BufferedReader bufferedReader = Files.newBufferedReader(input))
        {
            String line;
            SignalPair signalPair = new SignalPair();
            boolean isPairOne = true;
            while ((line = bufferedReader.readLine()) != null)
            {
                if (line.isBlank())
                {
                    signalPair = new SignalPair();
                } else
                {
                    if (isPairOne)
                    {
                        signalPair.pairOne = line;
                    } else
                    {
                        signalPair.pairTwo = line;
                        signals.add(signalPair);
                    }
                    isPairOne = !isPairOne;
                }
            }
        } catch (IOException e)
        {
            throw new RuntimeException(e);
        }
    }

    private static class SignalPair
    {
        String pairOne, pairTwo;

        boolean isValid()
        {
            
        }


//        boolean isValid()
//        {
//            // Check if amount of integers in pair 1 does not exceed pair 2
//            Pattern pattern = Pattern.compile("\\d+");
//            Matcher matcherPairOne = pattern.matcher(pairOne);
//            Matcher matcherPairTwo = pattern.matcher(pairTwo);
//
//            int pairOneNumbers = 0;
//            int pairTwoNumbers = 0;
//
//            while (matcherPairOne.find())
//            {
//                pairOneNumbers++;
//            }
//            while (matcherPairTwo.find())
//            {
//                pairTwoNumbers++;
//            }
//            if (pairOneNumbers > pairTwoNumbers)
//            {
//                return false;
//            }
//
//            if(pairOneNumbers == 0 && pairTwoNumbers == 0)
//            {
//                return pairTwo.length() > pairOne.length();
//            }
//
//            StringBuilder pairOneFixed = new StringBuilder();
//            StringBuilder pairTwoFixed = new StringBuilder();
//
//            int p1 = 0;
//            int p2 = 0;
//            while (p1 < pairOne.length() && p2 < pairTwo.length())
//            {
//                if (pairOne.charAt(p1) == pairTwo.charAt(p2))
//                {
//                    pairOneFixed.append(pairOne.charAt(p1));
//                    pairTwoFixed.append(pairTwo.charAt(p2));
//                    p1++;
//                    p2++;
//                } else
//                {
//                    if (pairOne.charAt(p1) == '[')
//                    {
//                        pairOneFixed.append(pairOne.charAt(p1));
//                        pairTwoFixed.append('[');
//                        pairTwoFixed.append(pairTwo.charAt(p2));
//                        pairTwoFixed.append(']');
//                        p1++;
//                        p2++;
//                    } else if (pairTwo.charAt(p2) == '[')
//                    {
//                        pairOneFixed.append('[');
//                        pairOneFixed.append(pairOne.charAt(p1));
//                        pairOneFixed.append(']');
//                        pairTwoFixed.append(pairTwo.charAt(p2));
//                        p2++;
//                        p1++;
//                    } else if (pairOne.charAt(p1) == ']')
//                    {
//                        pairOneFixed.append(pairOne.charAt(p1));
//                        pairTwoFixed.append(pairOne.charAt(p1));
//                        p1++;
//                    } else if (pairTwo.charAt(p2) == ']')
//                    {
//                        pairOneFixed.append(pairTwo.charAt(p2));
//                        pairTwoFixed.append(pairTwo.charAt(p2));
//                        p2++;
//                    }
//                    else
//                    {
//                        pairOneFixed.append(pairOne.charAt(p1));
//                        pairTwoFixed.append(pairTwo.charAt(p2));
//                        p1++;
//                        p2++;
//                    }
//                }
//            }
//
//            String comparePair1 = pairOneFixed.toString();
//            String comparePair2 = pairTwoFixed.toString();
//            for(int i = 0; i < comparePair1.length(); i++)
//            {
//                if(comparePair1.charAt(i) > comparePair2.charAt(i))
//                {
//                    return false;
//                }
//            }
//
//            return true;
//        }

        private void determineStructure()
        {

        }
    }
}
