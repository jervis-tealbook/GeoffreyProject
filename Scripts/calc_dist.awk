function abs(v) { return v < 0 ? -v : v }
{
	lat = $1
	lng = $2

	id = $3
	pop = $4
	#temp = $5

	type = $6
	name = $7

	if (init == 0)
	{
		# first line
		init = 1
		my_lat = lat
		my_lng = lng
		my_pop = pop
		my_type = type
		my_name = name
	}
	else
	{
		dlat = abs(lat - my_lat)
		dlng = abs(lng - my_lng)

		# for now, use Manhattan distance
		# for increasing accuracy could use
		#   Euclidean distance (flat earth)
		#   Haversice distance (spherical)
		#   ellipsoid distance
		dist = dlat + dlng

		if (my_id == 0 || dist < my_dist)
		{
			# first dist, or closer
			my_id = id
			my_dist = dist
		}
		print my_lat " " my_lng " " id " " my_pop " 0  DIST " my_name " " dist

	}
}
END {
	print my_lat " " my_lng " " my_id " " my_pop " 0 " my_type " " my_name
}
