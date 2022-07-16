function RollAnimation()
{
	with (oController)
	{
		//if ()
		if (diceSubimg == 2)
		{
			if (finished) return noone
			time_source_start(transformAnimation)
			diceSprite = sDice
			diceSubimg = (currentNumber - 1) * 4
			//diceSubimg = 0
			return noone
		}
		diceSubimg++
	}
}

function TransformAnimation()
{
	with (oController)
	{
		diceSubimg++
	}
}

