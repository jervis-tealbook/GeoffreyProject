{
	pop = $4
	temp = $5

	poptotal += pop
	temppoptotal += ( temp * pop )

}
END {
	mean = temppoptotal / poptotal

	print "poptotal " poptotal
	print "mean " mean
}
