function saveProgress()
{
	var _saveStruct =
	{
		level: oInit.unlockedLevel
	}
	var _saveString = json_stringify(_saveStruct);
	json_string_save(_saveString, "game_data.sav");
}

/// Function saving a JSON string to a given file using a buffer.
function json_string_save(_string, _file)
{
	var _buffer = buffer_create(string_byte_length(_string) + 1, buffer_fixed, 1);
	buffer_write(_buffer, buffer_string, _string);
	buffer_save(_buffer, _file);
	buffer_delete(_buffer);
}

/// Function loading a JSON string from given file using a buffer.
function json_string_load(_file)
{
	var _buffer = buffer_load(_file);
	var _string = buffer_read(_buffer, buffer_string);
	buffer_delete(_buffer);
	return _string;
}
