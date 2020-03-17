{
	lat = $1
	lng = $2
	id = $3
	pop = $4
	temp = $5

	type = $6
	name = $7

	if (type == "STATION")
	{
		idtemp[id] = temp
	}
	else
	{
		temp = idtemp[id]
		print lat " " lng " " id " " pop " " temp " " type " " name
	}

}
