{
	city = $1
	lat = $2
	lng = $3
	pop = $8

	station_id = "0"
	temp = "0"

	name = gensub(/ /, "-", "g", city)

	print lat " " lng " " station_id " " pop " " temp " CITY " name
}

