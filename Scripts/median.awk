BEGIN {
	print "pophalf = " poptotal / 2
}
{
	pop = $4
	prevtemp = temp
	temp = $5

	poprun += pop

	if (poprun >= (poptotal / 2))
	{
		print "poprun " poprun " median " temp
		exit 0
	}
}
