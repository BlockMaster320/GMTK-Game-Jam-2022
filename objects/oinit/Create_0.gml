//Setup levels
levels = [rLvl1, rLvl2];
unlockedLevel = 0;
currentLevelNum = 0;

//Load the data file
if (!file_exists("game_data.sav"))
	saveProgress();
else
{
	var _dataStruct = json_parse(json_string_load("game_data.sav"))
	unlockedLevel = _dataStruct.level;
}

//CONSTANTS
enum ABILITY
{
	none,
	dash,
	diceReset,
	armor,
	bomb
}

enum PHASE
{
	shop,
	rolling,
	offense
}

enum TILE_TYPE
{
	empty,
	wall,
	numbered,
	turretBasic,
	hole
}

enum MENU_STATE
{
	main,
	levels
}

#macro BULLET_COOLDOWN 1
#macro BULLET_SPEED 40
