package adventOfCode.TwentyTwentyTwo;

import java.io.BufferedReader;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class DaySeven
{
    enum Output
    {
        LISTING(Pattern.compile("(\\$ ls)"), null),
        CHANGE_DIR_TO_PARENT(Pattern.compile("(\\$ cd \\.\\.)"), null),
        CHANGE_DIR_TO_ROOT(Pattern.compile("(\\$ cd /)"), null),
        CHANGE_DIR(Pattern.compile("(\\$ cd \\w.+)"), Pattern.compile("(\\w+)$")),
        FILE(Pattern.compile("(\\d.+)"), Pattern.compile("\\d+")),
        DIRECTORY(Pattern.compile("(^dir.+)"), Pattern.compile("(\\w+)$"));

        private final Pattern pattern;
        private final Pattern dataPattern;

        Output(Pattern pattern, Pattern dataPattern)
        {
            this.pattern = pattern;
            this.dataPattern = dataPattern;
        }

        public static Output matchToValue(String stringToMatch)
        {
            for(Output output : Output.values())
            {
                Matcher matcher = output.pattern.matcher(stringToMatch);
                if(matcher.matches())
                {
                    return output;
                }
            }

            return CHANGE_DIR_TO_ROOT;
        }

        public String getData(String input)
        {
            if(dataPattern != null)
            {
                Matcher matcher = this.dataPattern.matcher(input);
                if(matcher.find())
                {
                    return matcher.group();
                }
            }
            return "";
        }
    }

    Path input;
    Directory root = new Directory("");
    List<Directory> directories = new ArrayList<>();

    int diskSpace = 70000000;
    int requiredSpace = 30000000;

    public DaySeven(String input)
    {
        this.input = Path.of(input);
        readInput();
        AnswerPart1();
        AnswerPart2();
    }

    public long AnswerPart1()
    {
        long sizes = 0;
        for(Directory directory : directories)
        {
            if(directory.getSize() < 100000)
            {
                sizes += directory.getSize();
            }
        }

        System.out.println(sizes);
        return sizes;
    }

    public long AnswerPart2()
    {
        long amountToDelete = requiredSpace - (diskSpace - root.getSize());
        long closest = root.getSize();

        for(Directory directory : directories)
        {
            long size = directory.getSize();
            if(size > amountToDelete && size < closest)
            {
                closest = size;
            }
        }

        System.out.println(closest);
        return closest;
    }

    private void readInput()
    {
        try (BufferedReader bufferedReader = Files.newBufferedReader(input))
        {
            String line;
            Directory currentDirectory = root;
            directories.add(root);
            while ((line = bufferedReader.readLine()) != null)
            {
                Output output = Output.matchToValue(line);
                String outputData = output.getData(line);

                switch (output)
                {
                    case LISTING:
                        break;
                    case CHANGE_DIR_TO_PARENT:
                        currentDirectory = currentDirectory.parent;
                        break;
                    case CHANGE_DIR_TO_ROOT:
                        currentDirectory = root;
                        break;
                    case CHANGE_DIR:
                        String directoryName = currentDirectory.name;
                        currentDirectory = directories.stream()
                                                      .filter(directory -> directory.name.equals(directoryName +
                                                              "/" + outputData))
                                                      .findFirst().get();
                        break;
                    case FILE:
                        FileThingy file = new FileThingy(Long.parseLong(outputData));
                        currentDirectory.contents.add(file);
                        break;
                    case DIRECTORY:
                        Directory directory = new Directory(currentDirectory.name + "/" + outputData);
                        directory.parent = currentDirectory;
                        directories.add(directory);
                        currentDirectory.contents.add(directory);
                        break;
                }
            }
        } catch (IOException e)
        {
            throw new RuntimeException(e);
        }
    }

    private static class Directory extends FileThingy
    {
        String name;
        List<FileThingy> contents = new ArrayList<>();
        Directory parent;

        public Directory(String name)
        {
            this.name = name;
        }

        public long getSize()
        {
            long totalSize = 0;
            for (FileThingy fileThingy : contents)
            {
                totalSize += fileThingy.getSize();
            }

            return totalSize;
        }
    }

    private static class FileThingy
    {
        private long size;

        public FileThingy()
        {
        }

        public FileThingy(long size)
        {
            this.size = size;
        }

        public long getSize()
        {
            return size;
        }
    }
}
