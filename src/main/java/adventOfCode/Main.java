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

        switch (dayToPick)
        {
            case 1:
                DayOne dayOne = new DayOne("C:\\Users\\san-d\\IdeaProjects\\AdventOfCode\\src\\main\\resources\\2022\\input2022.txt");
                System.out.println(dayOne.findLargestXOrCrash(1));
                System.out.println(dayOne.findLargestXOrCrash(3));
                break;
            case 2:
                DayTwo dayTwo = new DayTwo("C:\\Users\\san-d\\IdeaProjects\\AdventOfCode\\src\\main\\resources\\2022\\inputDay2.txt");
                System.out.println(dayTwo.calculatePoints());
                System.out.println(dayTwo.calculatePointsForReal());
                break;
            case 3:

                DayThree dayThree = new DayThree("C:\\Users\\san-d\\IdeaProjects\\AdventOfCode\\src\\main\\resources\\2022\\inputDay3.txt");
                System.out.println(dayThree.findCommonInRucksack());
                System.out.println(dayThree.findBadgePriorities(3));
                break;
            case 4:
                DayFour dayFour = new DayFour("C:\\Users\\san-d\\IdeaProjects\\AdventOfCode\\src\\main\\resources\\2022\\inputDay4.txt");
                System.out.println(dayFour.numberOfContainingPairs());
                System.out.println(dayFour.numberOfOverlappingPairs());
                break;
            case 5:
                DayFive dayFive = new DayFive("C:\\Users\\san-d\\IdeaProjects\\AdventOfCode\\src\\main\\resources\\2022\\inputDay5.txt");
                System.out.println(dayFive.crateMover9000());
                dayFive = new DayFive("C:\\Users\\san-d\\IdeaProjects\\AdventOfCode\\src\\main\\resources\\2022\\inputDay5.txt");
                System.out.println(dayFive.crateMover9001());
                break;
            case 6:
                DaySix daySix = new DaySix("C:\\Users\\san-d\\IdeaProjects\\AdventOfCode\\src\\main\\resources\\2022\\inputDay6.txt");
                System.out.println(daySix.readInput(4));
                System.out.println(daySix.readInput(14));
                break;
            case 7:
                DaySeven daySeven = new DaySeven("C:\\Users\\san-d\\IdeaProjects\\AdventOfCode\\src\\main\\resources\\2022\\inputDay7.txt");
                break;
            case 8:
                DayEight dayEight = new DayEight("C:\\Users\\sander.de.haan\\IdeaProjects\\AdventOfCode\\src\\main\\resources\\2022\\inputDay8.txt");
                break;
            default:
                System.out.println("Day not available yet");
        }
    }
}