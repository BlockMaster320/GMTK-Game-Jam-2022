//test
movSpeed = 10.205;
hsp = 0
vsp = 0

//alarm[0] = 120;
function spawnEnemy()
{
	instance_create_layer(random(room_width), random(room_height), "Instances", oEnemy);
	//alarm[0] = 120;
}

spawnLoop = time_source_create(time_source_game,500,time_source_units_frames,spawnEnemy,[],-1)
time_source_start(spawnLoop)