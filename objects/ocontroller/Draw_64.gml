/*draw_text(100,5,"Moves remaining: " + string(movesRemaining))
draw_text(100,25,"Game state: " + string(gameState))*/

var _cursorSet = false;	//for reseting cursor image

//Draw the amount of coins
draw_set_halign(fa_right);
draw_set_valign(fa_bottom);
draw_set_font(fnt_Pixel);
draw_text_transformed_color(297, 22, string(coinsAmount), 1, 1, 0, c_white, c_white, c_white, c_white, 1);
draw_set_halign(fa_right);
draw_set_valign(fa_bottom);

//Draw and interact with the dice slots
var _drawOriginX = 13;
var _drawOriginY = 130;
var _slotWidth = sprite_get_width(sDiceSide);
var _drawOffset = _slotWidth + 9;
for (var _i = 0; _i < 6; _i++)
{
	//draw the slot and its ability
	var _drawX = _drawOriginX + _i * _drawOffset;
	draw_sprite(sDiceSide, 0, _drawX, _drawOriginY);
	if (abilityArray[_i] == ABILITY.none)
	{
		draw_set_alpha(0.6);
		draw_sprite(sDiceDots, _i, _drawX, _drawOriginY);
		draw_set_alpha(1);
	}
	else
		draw_sprite(sAbilityOnDice, abilityArray[_i], _drawX, _drawOriginY);
	
	//place active ability on the slot
	if (abilityActive != ABILITY.none && abilityArray[_i] == ABILITY.none && point_in_rectangle(mouse_x, mouse_y, _drawX, _drawOriginY, _drawX + _slotWidth, _drawOriginY + _slotWidth))
	{
		window_set_cursor(cr_drag);
		_cursorSet = true;
		if (mouse_check_button_pressed(mb_left) || mouse_check_button_released(mb_left))
		{
			abilityArray[_i] = abilityActive;
			abilityActive = ABILITY.none;
		}
	}
}

//Draw && interact with abilities
var _drawOriginX = 250;
var _drawOriginY = 43;
var _frameWidth = sprite_get_width(sAbility);
var _frameHeight = sprite_get_height(sAbility);
var _drawSpacingX = _frameWidth + 16;
var _drawSpacingY = _frameWidth + 16;
var _drawPriceOffsetX = sprite_get_width(sAbility) * 0.5;
var _drawPriceOffsetY = sprite_get_height(sAbility) + 9;

for (var _i = 0; _i < array_length(currentLevel.abilities); _i++)
{
	var _ability = currentLevel.abilities[_i];	//get current ability data
	var _buyable = (coinsAmount >= _ability[1]) ? true : false;
	var _alpha = _buyable ? 1 : 0.4;
	var _priceColor = (_buyable) ? c_white : make_color_hsv(0, 180, 220);
	
	var _drawX = _drawOriginX + (_i % 2) * _drawSpacingX;	//draw the ability frames
	var _drawY = _drawOriginY + (_i div 2) * _drawSpacingY
	draw_set_alpha(_alpha);
	draw_sprite(sAbilityBase, 0, _drawX, _drawY);
	draw_sprite(sAbility, _ability[0], _drawX, _drawY);
	
	draw_set_halign(fa_right);	//draw the ability prices
	draw_text_transformed_color(_drawX + _drawPriceOffsetX, _drawY + _drawPriceOffsetY, string(_ability[1]), 0.5, 0.5, 0, _priceColor, _priceColor, _priceColor, _priceColor, 1);
	draw_set_halign(fa_left);
	draw_set_alpha(1);
	draw_sprite(sCoin, 0, _drawX + _drawPriceOffsetX + 2, _drawY + _drawPriceOffsetY - 3);
	
	if (gameState == PHASE.shop && _buyable && abilityActive == ABILITY.none && point_in_rectangle(mouse_x, mouse_y, _drawX, _drawY, _drawX + _frameWidth, _drawY + _frameHeight))
	{
		window_set_cursor(cr_drag);
		_cursorSet = true;
		
		if (mouse_check_button_pressed(mb_left))
		{
			abilityActive = _ability[0];
			coinsAmount -= _ability[1];
		}
	}
}

//Draw the active ability
if (abilityActive != ABILITY.none)
{
	draw_sprite(sAbilityBase, 0,  mouse_x - _frameWidth * 0.5,  mouse_y - _frameHeight * 0.5);
	draw_sprite(sAbility, abilityActive, mouse_x - _frameWidth * 0.5,  mouse_y - _frameHeight * 0.5);
}

//Reset the cursor image
if (!_cursorSet)
	window_set_cursor(cr_default);
