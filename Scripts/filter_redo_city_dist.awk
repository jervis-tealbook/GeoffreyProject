{
	lat = $1
	lng = $2
	id = $3

	key = lat lng


	if (id == 0)
	{
		redo[key] = 1
	}
	else
	{
		#pop = $4
		#temp = $5
		type = $6

		if (redo[key] == 1)
		{

		if (type == "CITY")
		{
		# zero bestid
		$3 = 0
		}

		# zero temp
		$5 = 0

		print $0
		}
	}
}

