#!/bin/bash
#a number guessing game

number=0
guess=0

startGame()
{
  number=$((1 + RANDOM % 1000))
  echo "I've picked a number between 1 and 1000, see if you can guess it!"
  echo "Enter a number and I'll tell you higher or lower:"
  read guess
  checkGuess 0
}

checkGuess()
{
  numGuesses=$1
  numGuesses=$((numGuesses+1))
  if [[ $number -eq $guess ]]; then
    endGame 1 $numGuesses
  fi
  if [[ $number -gt $guess ]]; then
    echo "Higher"
  fi
  if [[ $number -lt $guess ]]; then
    echo "Lower"
  fi
  if [[ $numGuesses -ge 10 ]]; then
    endGame 2 $numGuesses
  fi
  echo "You used '$numGuesses' out of 10 guesses"
  echo "Enter a number and I'll tell you higher or lower:"
  read guess
  checkGuess $numGuesses
}

endGame()
{
  numGuesses=$2
  if [[ $1 -eq 1 ]]; then
    echo "You won! in '$numGuesses' guesses"
    echo "Enter your name for the scoreboard"
    read name
    echo "'$name' got '$number' in '$numGuesses' guesses" >> scoreboard
  fi
  if [[ $1 -eq 2 ]]; then
    echo "Sorry, you lost"
    echo "The number was '$number'"
  fi
  echo "Play again? Enter y or n:"
  read tryAgain
  if [[ $tryAgain == "y" ]]; then
    startGame
  fi
  echo "Bye!"
  exit
}
echo "start the game"
startGame
