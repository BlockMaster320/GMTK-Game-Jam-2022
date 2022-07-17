//Level select button
var _guiW = room_width;
var _guiH = room_height;
var _centerX = _guiW/2;
var _baseY = _guiH/2;
var _menuButtonOffset = 20;
var _menuButtonWidth = 130;
var _menuButtonHeight = sprite_get_height(sMenuButton) - 3;
var _cursorSet = false;

var _textColor = make_color_rgb(229,217,200);

switch (menuState)
{
	case MENU_STATE.main:
	{
		var _buttonWidth = 130;
		var _buttonHeight = sprite_get_height(sMenuButton) - 3;
		
		draw_sprite(sMenuButton, 0, _centerX, _baseY)
		draw_sprite(sMenuButton, 0, _centerX, _baseY + _menuButtonOffset)

		draw_set_halign(fa_center)
		draw_set_valign(fa_center)
		draw_set_font(fnt_Pixel)
		draw_text_transformed_color(_centerX, _baseY, "PLAY", 0.75, 0.75, 0, _textColor, _textColor, _textColor, _textColor, 1)
		draw_text_transformed_color(_centerX, _baseY + _menuButtonOffset, "EXIT", 0.75, 0.75, 0, _textColor, _textColor, _textColor, _textColor, 1)
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);

		//Interact with the buttons
		Input();
		if (point_in_rectangle(mouse_x, mouse_y, _centerX - _menuButtonWidth * 0.5, _baseY - _menuButtonHeight * 0.5, _centerX + _menuButtonWidth * 0.5, _baseY + _menuButtonHeight * 0.5))
		{
			window_set_cursor(cr_drag);
			_cursorSet = true;
	
			if (lmbPress)
				menuState = MENU_STATE.levels;
		}
		if (point_in_rectangle(mouse_x, mouse_y, _centerX - _menuButtonWidth * 0.5, _baseY + _menuButtonOffset - _menuButtonHeight * 0.5, _centerX + _menuButtonWidth * 0.5, _baseY + _menuButtonOffset + _menuButtonHeight * 0.5))
		{
			window_set_cursor(cr_drag);
			_cursorSet = true;
	
			if (lmbPress)
				game_end();
		}

		break;
	}
	
	case MENU_STATE.levels:
	{
		draw_set_halign(fa_center);
		draw_text_transformed_color(_centerX, 20, "LEVEL SELECTION", 1, 1, 0, _textColor, _textColor, _textColor, _textColor, 1);
		
		var _buttonWidth = 25;
		var _buttonHeight = 20;
		var _buttonSpacingX = 5;
		var _buttonSpacingY = 5;
		var _buttonsInRow = 5;
		var _startX = _centerX - (_buttonsInRow * 0.5) * (_buttonWidth + _buttonSpacingX) + _buttonSpacingX * 0.5;
		var _startY = 50;
		for (var _i = 0; _i < array_length(oInit.levels); _i++)
		{
			var _isUnlocked = (_i <= oInit.unlockedLevel) ? true : false;
			var _alpha = (_isUnlocked) ? 1 : 0.6;
			var _row = _i % _buttonsInRow;
			var _column = _i div _buttonsInRow;
			var _drawX = _startX + _row * (_buttonWidth + _buttonSpacingX);
			var _drawY = _startY + _column * (_buttonHeight + _buttonSpacingY);
			draw_set_alpha(_alpha);
			draw_sprite_stretched(sButtonNineSliceSquare, 0, _drawX, _drawY, _buttonWidth, _buttonHeight);
			draw_set_alpha(1);
			draw_text_transformed_color(_drawX + _buttonWidth * 0.5 + 1, _drawY, _i + 1, 1, 1, 0, _textColor, _textColor, _textColor, _textColor, _alpha);
			
			if (_isUnlocked && point_in_rectangle(mouse_x, mouse_y, _drawX, _drawY, _drawX + _buttonWidth, _drawY + _buttonHeight))
			{
				_cursorSet = true;
				window_set_cursor(cr_drag);
				
				if (lmbPress)
				{
					menuState = MENU_STATE.main;
					oInit.currentLevelNum = _i;
					room_goto(oInit.levels[_i]);
				}
			}
		}
		
		draw_sprite(sMenuButton, 0, _centerX, _baseY + _menuButtonOffset * 3)
		draw_set_halign(fa_center)
		draw_set_valign(fa_center)
		draw_set_font(fnt_Pixel)
		draw_text_transformed_color(_centerX, _baseY + _menuButtonOffset * 3, "MENU", 0.75, 0.75, 0, _textColor, _textColor, _textColor, _textColor, 1)
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
		
		if (point_in_rectangle(mouse_x, mouse_y, _centerX - _menuButtonWidth * 0.5, _baseY - _menuButtonHeight * 0.5 + _menuButtonOffset * 3, _centerX + _menuButtonWidth * 0.5, _baseY + _menuButtonHeight * 0.5 + _menuButtonOffset * 3))
		{
			_cursorSet = true;
			window_set_cursor(cr_drag);
				
			if (lmbPress)
				menuState = MENU_STATE.main;
		}
		
		break;
	}
}

if (!_cursorSet)
	window_set_cursor(cr_default);