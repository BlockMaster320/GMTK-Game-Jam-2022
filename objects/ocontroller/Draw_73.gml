//Draw based on state
switch (gameState)
{
	case PHASE.shop:
	case PHASE.rolling:
		//Dice draw
		var xx = diceX * gridSize + boardTopX + rollPosOffsetX
		var yy = diceY * gridSize + boardTopY + rollPosOffsetY
		if (gameState == PHASE.shop) yy += gridSize
		draw_sprite(diceSprite,diceSubimg,xx,yy)
		if (failedScreen) draw_text(room_width / 2, room_height / 2,"You didn't finish")
		break
		
	case PHASE.offense:
		break
}
