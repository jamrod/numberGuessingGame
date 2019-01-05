@ECHO OFF
setlocal EnableDelayedExpansion
REM A number guessing game

:STARTGAME
SET /a NUMBER = (%RANDOM%*1000/32768)+1
ECHO I've picked a number between 1 and 1000
SET /p GUESS="Enter a number and I'll tell you higher or lower:"
SET NUMGUESSES=0
CALL :CHECKGUESS
Exit Sub

:CHECKGUESS
SET /A NUMGUESSES+=1
IF !NUMBER! EQU !GUESS! (
    SET ANSWER=1
    CALL :ENDGAME
    Exit Sub
)
IF !NUMBER! GTR !GUESS! ECHO Higher
IF !NUMBER! LSS !GUESS! ECHO Lower
IF !NUMGUESSES! GTR 9 (
    SET ANSWER=0
    CALL :ENDGAME
    Exit Sub
)
ECHO You used !NUMGUESSES! out of 10 guesses.
SET /p GUESS="Enter a number and I'll tell you higher or lower:"
GOTO :CHECKGUESS

:ENDGAME
IF !ANSWER!==1 (
	ECHO You Won in !NUMGUESSES! Guesses!
	SET/p NAME="Enter your name for the scoreboard"
	ECHO "!NAME! Got !NUMBER! in !NUMGUESSES! guesses" >> scoreboard.txt
)
IF !ANSWER!==0 ECHO Sorry, You Lose. The number was %NUMBER%.
SET /p TRYAGAIN=Play Again? enter y or n:
IF  %TRYAGAIN%==y (CALL :STARTGAME)
ECHO BYE!
END
