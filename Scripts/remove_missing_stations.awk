{
	if (NF == 1)
	{
		id = $1
		missing[id] = 1
	}
	else
	{
		id = $3
		if (missing[id] == 1)
		{
			# the bestid is missing
		}
		else
		{
		print $0
		}
	}
}
