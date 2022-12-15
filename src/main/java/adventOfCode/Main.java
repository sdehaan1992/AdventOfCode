package adventOfCode;

import adventOfCode.TwentyTwentyTwo.*;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.file.Path;

public class Main
{
    public static void main(String[] args) throws IOException
    {
        System.out.println("Advent of Code 2022: Which day should we test? (1-25)");
        BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(System.in));
        int dayToPick = 0;
        Path inputFile = null;
        try
        {
            dayToPick = Integer.parseInt(bufferedReader.readLine());
        } catch (NumberFormatException exception)
        {
            System.out.println("Not a valid day");
            System.exit(1);
        }

        long start;

        switch (dayToPick)
        {
            case 1:
                start = System.currentTimeMillis();
                DayOne dayOne = new DayOne("C:\\Users\\san-d\\IdeaProjects\\AdventOfCode\\src\\main\\resources\\2022" +
                        "\\inputDay1.txt");
                System.out.println(dayOne.findLargestXOrCrash(1));
                System.out.println(dayOne.findLargestXOrCrash(3));
                System.out.printf("Duration approx. %d ms\n", System.currentTimeMillis() - start);
                break;
            case 2:
                start = System.currentTimeMillis();
                DayTwo dayTwo = new DayTwo("C:\\Users\\san-d\\IdeaProjects\\AdventOfCode\\src\\main\\resources\\2022" +
                        "\\inputDay2.txt");
                System.out.println(dayTwo.calculatePoints());
                System.out.println(dayTwo.calculatePointsForReal());
                System.out.printf("Duration approx. %d ms\n", System.currentTimeMillis() - start);
                break;
            case 3:
                start = System.currentTimeMillis();
                DayThree dayThree = new DayThree("C:\\Users\\san-d\\IdeaProjects\\AdventOfCode\\src\\main\\resources" +
                        "\\2022\\inputDay3.txt");
                System.out.println(dayThree.findCommonInRucksack());
                System.out.println(dayThree.findBadgePriorities(3));
                System.out.printf("Duration approx. %d ms\n", System.currentTimeMillis() - start);
                break;
            case 4:
                start = System.currentTimeMillis();
                DayFour dayFour = new DayFour("C:\\Users\\san-d\\IdeaProjects\\AdventOfCode\\src\\main\\resources" +
                        "\\2022\\inputDay4.txt");
                System.out.println(dayFour.numberOfContainingPairs());
                System.out.println(dayFour.numberOfOverlappingPairs());
                System.out.printf("Duration approx. %d ms\n", System.currentTimeMillis() - start);
                break;
            case 5:
                start = System.currentTimeMillis();
                DayFive dayFive = new DayFive("C:\\Users\\san-d\\IdeaProjects\\AdventOfCode\\src\\main\\resources" +
                        "\\2022\\inputDay5.txt");
                System.out.println(dayFive.crateMover9000());
                dayFive = new DayFive("C:\\Users\\san-d\\IdeaProjects\\AdventOfCode\\src\\main\\resources\\2022" +
                        "\\inputDay5.txt");
                System.out.println(dayFive.crateMover9001());
                System.out.printf("Duration approx. %d ms\n", System.currentTimeMillis() - start);
                break;
            case 6:
                start = System.currentTimeMillis();
                DaySix daySix = new DaySix("C:\\Users\\san-d\\IdeaProjects\\AdventOfCode\\src\\main\\resources\\2022" +
                        "\\inputDay6.txt");
                System.out.println(daySix.readInput(4));
                System.out.println(daySix.readInput(14));
                System.out.printf("Duration approx. %d ms\n", System.currentTimeMillis() - start);
                break;
            case 7:
                start = System.currentTimeMillis();
                DaySeven daySeven = new DaySeven("C:\\Users\\san-d\\IdeaProjects\\AdventOfCode\\src\\main\\resources" +
                        "\\2022\\inputDay7.txt");
                System.out.printf("Duration approx. %d ms\n", System.currentTimeMillis() - start);
                break;
            case 8:
                start = System.currentTimeMillis();
                DayEight dayEight = new DayEight("C:\\Users\\san-d\\IdeaProjects\\AdventOfCode\\src\\main" +
                        "\\resources\\2022\\inputDay8.txt");
                System.out.printf("Duration approx. %d ms\n", System.currentTimeMillis() - start);
                break;
            case 9:
                start = System.currentTimeMillis();
                DayNine dayNine = new DayNine("C:\\Users\\san-d\\IdeaProjects\\AdventOfCode\\src\\main" +
                        "\\resources\\2022\\inputDay9.txt", 2);
                DayNine dayNine2 = new DayNine("C:\\Users\\san-d\\IdeaProjects\\AdventOfCode\\src\\main" +
                        "\\resources\\2022\\inputDay9.txt", 10);
                System.out.printf("Duration approx. %d ms\n", System.currentTimeMillis() - start);
                break;
            case 10:
                start = System.currentTimeMillis();
                DayTen dayTen = new DayTen("C:\\Users\\san-d\\IdeaProjects\\AdventOfCode\\src\\main\\resources" +
                        "\\2022\\inputDay10.txt");
                System.out.printf("Duration approx. %d ms\n", System.currentTimeMillis() - start);
                break;
            case 11:
                start = System.currentTimeMillis();
                DayEleven dayEleven = new DayEleven("C:\\Users\\san-d\\IdeaProjects\\AdventOfCode\\src\\main" +
                        "\\resources\\2022\\inputDay11.txt");
                System.out.printf("Duration approx. %d ms\n", System.currentTimeMillis() - start);
                break;
            case 12:
                start = System.currentTimeMillis();
                DayTwelve dayTwelve = new DayTwelve("C:\\Users\\san-d\\IdeaProjects\\AdventOfCode\\src\\main" +
                        "\\resources\\2022\\inputDay12.txt");
                System.out.printf("Duration approx. %d ms\n", System.currentTimeMillis() - start);
                break;
            case 13:
                start = System.currentTimeMillis();
                DayThirteen dayThirteen = new DayThirteen("C:\\Users\\san-d\\IdeaProjects\\AdventOfCode\\src\\main" +
                        "\\resources\\2022\\inputDay13.txt");
                System.out.printf("Duration approx. %d ms\n", System.currentTimeMillis() - start);
                break;
            case 14:
                start = System.currentTimeMillis();
                DayFourteen dayFourteen = new DayFourteen("C:\\Users\\san-d\\IdeaProjects\\AdventOfCode\\src\\main" +
                        "\\resources\\2022\\inputDay14.txt");
                System.out.printf("Duration approx. %d ms\n", System.currentTimeMillis() - start);
                break;
            case 15:
                start = System.currentTimeMillis();
                DayFifteen dayFifteen = new DayFifteen("C:\\Users\\san-d\\IdeaProjects\\AdventOfCode\\src\\main" +
                        "\\resources\\2022\\inputDay15.txt");
                System.out.printf("Duration approx. %d ms\n", System.currentTimeMillis() - start);
                break;
            default:
                System.out.println("Day not available yet");
        }

        main(args);
    }
}