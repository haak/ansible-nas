# accespt user input from command line
# ask user what word they guessed and what letters were which colour

# import modules
import inquirer
import re
from pprint import pprint
from inquirer import errors


def answer_valdation(answers, current):
    # TODO get length of word from user input and check if the length of the string is the same

    if not re.match('[bgy]{5}', current):
        raise errors.ValidationError(
            '', reason='I don\'t like your wordle guess!')


def main():
    questions = [
        inquirer.Text('guess', message="enter your guess"),
        inquirer.Text(
            'colours', message="enter the colour of each letter"),
    ]

    answers = inquirer.prompt(questions)

    # print(answers)
    pprint(answers)
    return

# for your guess entery b g y for each letter if its black, greeen or yellow
# if its black, add it to the list of black letters
# if its green, add it to the list of green letters
# if its yellow, add it to the list of yellow letters


# main
if __name__ == "__main__":
    main()
