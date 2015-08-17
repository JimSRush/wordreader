 --A simple haskell program to open a text file, and calculate:
 --The number of lines in the file. 
 --The number of paragraphs. 
 --The number of sentences. 
 --The number of distinct words. 

 --Usage: ghc --make wordreader.hs
 -- ./wordreader YourFileNameHere.txt

import System.IO
import System.Environment
import Data.List
import Data.Text hiding (filter, length, lines, words) 


--File handling logic - needs to be in an atomic do block because i/o is dirty/impure
main = do
 [f] <- getArgs
 file <- readFile f
 putStrLn (countlines file)
 putStrLn (countParagraphs file)
 putStrLn (countSentences file)	
 putStrLn (countWords file)

--Counts the lines in the file using the higher order functions show, length, line
countlines :: String -> String
countlines [] = "Looks like there aren't any lines in your file" -- empty list
countlines l = "Lines = " ++ show (length (lines l))

----Looks for the number of linebreaks to work out how many paragraphs
countParagraphs :: String -> String
countParagraphs p = "paragraphs = " ++ show((length $ breakOnAll (pack "\n\n") (pack p))+1)

--Calculates the number of sentences by filtering on .
countSentences :: String -> String
countSentences s = "Sentences = " ++ show(length(filter(`elem` ['.']) s ))

--Splits the string into disticnt words then removes duplicates with the nub function
countWords :: String -> String
countWords w = "Distinct Words = " ++ show(length(nub(words w)))

