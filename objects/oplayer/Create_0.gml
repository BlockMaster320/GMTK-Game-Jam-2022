//test
movSpeed = 5;

alarm[0] = 120;
function spawnEnemy()
{
	instance_create_layer(random(room_width), random(room_height), "Instances", oEnemy);
	alarm[0] = 120;
}
