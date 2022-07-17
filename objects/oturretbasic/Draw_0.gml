draw_self();

//Draw reach distance warning
var _gridSize = oController.gridSize;
draw_set_alpha((sin(current_time * 0.004) * 0.5 + 0.5) * 0.3 + 0.2);
draw_rectangle_color(x + _gridSize, y, x + _gridSize * 2 - 2, y + _gridSize - 2, c_red, c_red, c_red, c_red, false);
draw_rectangle_color(x - _gridSize, y, x - 2, y + _gridSize - 2, c_red, c_red, c_red, c_red, false);
draw_rectangle_color(x, y + _gridSize, x + _gridSize - 2, y + _gridSize * 2 - 2, c_red, c_red, c_red, c_red, false);
draw_rectangle_color(x, y - _gridSize, x + _gridSize - 2, y - 2, c_red, c_red, c_red, c_red, false);
draw_set_alpha(1);
