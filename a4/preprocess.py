# -*- coding: ISO-8859-1 -*-

import random
import os.path

def main():
	classes = ["DEATHKNIGHT", "DEMONHUNTER","DRUID","HUNTER","MAGE","MONK","PALADIN","PRIEST","ROGUE","SHAMAN","WARLOCK","WARRIOR"]
	content = []
	charsSeen = set()
	targetsSeen = set()
	filename = "invasionRun.txt"
	with open(filename) as f:
		content = f.readlines()
	
	chars = []
	targets = []
	for line in content:
		if line.split(" ")[3].split(",")[0] == "SPELL_DAMAGE":
			if line.split(" ")[3].split(",")[1].split("-")[0] == "Player":
				char = line.split(",")[2].split("\"")[1].split("-")[0]
				tar = line.split(",")[6].split("\"")[1]
				if char not in charsSeen:
					if char == "Chàrizard":
						chars.append((char, "MAGE"))
					else:
						randomClass = random.choice(classes)
						chars.append((char, randomClass))

				if tar not in targetsSeen:
					targets.append(tar)

				charsSeen.add(char)
				targetsSeen.add(tar)

	sortedChars = sorted(sorted(chars, key = lambda tup:tup[0]), key = lambda tup: classes.index(tup[1]))
	sortedTars = sorted(targets)
	print(sortedChars)
	print(sortedTars)
	line_prepender("invasionRun.txt", sortedChars, sortedTars)


def line_prepender(filename, chars, tars):
	if os.path.isfile(filename.split('.')[0] + "PP.txt"):
		print "This file has already been pre-processed.\n"
		return

	charsToPrepend = ""
	tarsToPrepend = ""
	content = []
	with open(filename, 'r+') as f:
		content = f.read()
		for line in chars:
			charsToPrepend += line[0] + "-" + line[1] + '\n'
		for line in tars:
			tarsToPrepend += line + "\n"

	with open(filename.split('.')[0]+"PP.txt", 'w+') as f:
		f.write(str(len(chars)) + "\n" + charsToPrepend  + str(len(tars)) + "\n" + tarsToPrepend +  content)





if __name__ == '__main__':
	main()