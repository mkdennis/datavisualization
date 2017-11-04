# -*- coding: ISO-8859-1 -*-

import requests
import json

endpoint_url_prefix = "https://us.api.battle.net/wow/character/"
endpoint_url_suffix = "?locale=en_US&apikey=e9s468vg32ey69pwq8rrf3uc6esp6em4"
name = "Chàrizard-Sargeras"
def getClass(name):
	# print(name)
	n = name.split('-')[0]
	r = name.split('-')[1]

	request_url = endpoint_url_prefix + r + "/" + n + endpoint_url_suffix 
	# print request_url
	r = requests.get(request_url)

	responseJson = r.json()
	print("OOOP")
	print(name)
	print(responseJson)

	c = responseJson['class']

	if(c == 1):
		return "WARRIOR"

	if(c == 2):
		return "PALADIN"

	if(c == 3):
		return "HUNTER"

	if(c == 4):
		return "ROGUE"

	if(c == 5):
		return "PRIEST"

	if(c == 6):
		return "DEATHKNIGHT"

	if(c == 7):
		return "SHAMAN"

	if(c == 8):
		return "MAGE"

	if(c == 9):
		return "WARLOCK"

	if(c == 10):
		return "MONK"

	if(c == 11):
		return "DRUID"

	if(c == 12):
		return "DEMONHUNTER"

getClass(name)