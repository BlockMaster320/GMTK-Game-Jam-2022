//Draw based on state
switch (gameState)
{
	case PHASE.shop:
	
	case PHASE.rolling:
		//Dice draw
		var xx = diceX * gridSize + boardTopX + rollPosOffsetX
		var yy = diceY * gridSize + boardTopY + rollPosOffsetY
		if (gameState == PHASE.shop) yy += gridSize
		draw_set_alpha(diceAlpha)
		draw_sprite(diceSprite,diceSubimg,xx,yy)
		draw_set_alpha(1)
		if (failedScreen) draw_text(room_width / 2, room_height / 2,"You didn't finish")
		break
		
	case PHASE.offense:
		break
}

//Draw other UI elements
var _color = make_color_rgb(156, 145, 110);
draw_sprite(sBranch, 1, 0, 5);
draw_sprite(sPhaseSign, 0, 16, 0);
draw_sprite(sPhase, gameState, 53, -1);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_font(fntDialog);
draw_text_transformed_color(11, 119, "press R to restart the game", 0.3, 0.4, 0, _color, _color, _color, _color, 1);
draw_text_transformed_color(11, 123, "number of troops: " + string(currentLevel.soldierAmount), 0.3, 0.4, 0, _color, _color, _color, _color, 1);
draw_set_font(fnt_Pixel);
