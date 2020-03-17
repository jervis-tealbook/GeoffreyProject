{
	#lat = $1
	#lng = $2
	id = $3
	#pop = $4
	#temp = $5
	#type = $6
	#name = $7
	dist = $8

	if (id == 0)
	{
	$3 = bestid
	print $0
	bestid = 0
	}
	else
	{
	if (bestid == 0 || dist < my_dist)
	{
		# first DIST for lat/lng
		bestid = id
		my_dist = dist
	}
	}



}
