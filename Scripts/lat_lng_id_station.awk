{
	lng = $1
	lat = $2
	station = $3
	id = $4
	temp = $11
	tempflag = $12

	name = gensub(/ /, "-", "g", station)

	if (temp == "" || tempflag == "M")
	{
	#print lat " " lng " " id " 0 (" temp ") STATION " name " tempflag (" tempflag ")"
	}
	else
	{
	print lat " " lng " " id " 0 0 STATION " name 
	}
}

