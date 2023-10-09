# TODO: ask user which of the machines in the inventory they want to run on and if there they want to limit to tags

# parse list of hosts in inventory yml file in inventories/inventory.yml
import yaml
from yaml.loader import SafeLoader
import re
import inquirer
import argparse
import os

parser = argparse.ArgumentParser(
    prog='Start',
    description='lets you customize the ansible script being run',
    epilog='Text at the bottom of help')

parser.add_argument("-c", "--clean", action="store_true", help="archive mode")

args = parser.parse_args()

# print()
# print(args.filename, args.count, args.verbose)

machines = []
with open('inventories/inventory.yml') as f:
    data = yaml.load(f, Loader=SafeLoader)
    print(data)
    for i in data['all']['hosts']:
        machines.append(i)
    print(machines)


questions = [
    inquirer.Text('tag', message="which tags do you want to limit by?"),
]
answers = inquirer.prompt(questions)
print(answers)


questions = [
    inquirer.Checkbox('machines',
                      message="Select which machines to run on?",
                      choices=machines,
                      ),
]
answers = inquirer.prompt(questions)

print(answers)


print('ansible-playbook -i inventories/inventory.yml playbook.yml --limit ' +
      ','.join(answers['machines']) + ' --tags ' + answers['tag'])
# os.system('ansible-playbook -i inventories/inventory.yml playbook.yml --limit ' + ','.join(answers['machines'] + ' --tags ' + answers['tag']))
# os.system('ansible-playbook -i inventories/inventory.yml playbook.yml -K --limit answers['machines']')


# TODO: set .env file with last used list of machines and tags
# TODO: add cli flag to delete cache
# TODO: add cli flag to run with default
# TODO: add cli flag to run with last run

# TODO: save choices to file and use as defaults next time


# TODO: call ansible playbook with limit to machines and tags
# ansible-playbook -i inventories/inventory.yml playbook.yml --limit answers['machines']
