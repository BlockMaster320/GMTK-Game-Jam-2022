if (room != rMenu && dialogNum <= array_length(dialogArray) - 1)
{
	var _color = make_color_rgb(40, 16, 43);
	var _offset = 15;
	var _sep = 12;
	var _w = 290;
	var _width = string_width(dialogArray[dialogNum]);
	var _height = string_height(dialogArray[dialogNum]) + _sep;
	var _numOfRows = _width div _w;
	var _drawX = 95;
	var _drawY = 60;
	var _outlineWidth = 1;
	draw_rectangle_color(_drawX - _outlineWidth, _drawY - _outlineWidth, 225 + _outlineWidth, 105 + _outlineWidth, c_white, c_white, c_white, c_white, false);
	draw_rectangle_color(_drawX, _drawY, 225, 105, _color, _color, _color, _color, false);
	draw_triangle_color(280, 140, 225, 105 - _offset, 225 - _offset, 105,  _color, _color, _color, false);
	
	draw_set_valign(fa_top);
	draw_set_halign(fa_left);
	draw_set_font(fntDialog);
	draw_text_ext_transformed_color(_drawX + 5, _drawY + 5, dialogArray[dialogNum], _sep, _w, 0.4, 0.6, 0, c_white, c_white, c_white, c_white, 1);
	draw_text_ext_transformed_color(_drawX + 7, 105 - 8, "> ENTER", _sep, _w, 0.4, 0.6, 0, c_grey, c_grey, c_grey, c_grey, 1);
	draw_set_font(fnt_Pixel);
	
	if (keyboard_check_pressed(vk_enter))
		dialogNum++;
}

