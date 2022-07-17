if (active)
{
	if (walkSoundCountdown == 0)
	{
		var snd = choose(sndWalk1,sndWalk2,sndWalk3,sndWalk4)
		audio_play_sound(snd,0,0)
		audio_sound_pitch(snd,random_range(.95,1.1))
		walkSoundCountdown = walkSoundCooldown
	}
	walkSoundCountdown--
	
	var targetXcentered = targetX + (oController.gridSize-1) / 2
	var targetYcentered = targetY + (oController.gridSize-1) / 2
	
	if (point_distance(x,y,targetXcentered,targetYcentered) < turnDist)
	{
		turnDist = random_range(spd,oController.gridSize*.5)
		walkingListPosition++
		if (ds_list_size(oController.walkedOverListX) < walkingListPosition)
		{
			//Finished
			if (oController.win == false)
				oController.win = true;
			
			instance_destroy()
		}
		if (oController.walkedOverListX[|walkingListPosition] == undefined)
		{
			targetY -= oController.gridSize
		}
		else
		{
			targetX = oController.walkedOverListX[|walkingListPosition] * oController.gridSize + oController.boardTopX
			targetY = oController.walkedOverListY[|walkingListPosition] * oController.gridSize + oController.boardTopY
		}
		targetXcentered = targetX + (oController.gridSize-1) / 2
		targetYcentered = targetY + (oController.gridSize-1) / 2
	}
	
	var dir = point_direction(x,y,targetXcentered,targetYcentered)
	image_angle = (dir-90)
	var tempSpd = spd
	
	//Odsunutí
	var nearestSoldier = instance_place(x,y,oSoldier)
	if (instance_exists(nearestSoldier) && point_distance(nearestSoldier.x,nearestSoldier.y,x,y) < 6)
	{
		if (nearestSoldier.soldierPosition > soldierPosition) tempSpd = spd * 1.2
		else tempSpd = spd * .8
	}
	
	hsp = lengthdir_x(tempSpd,dir)
	vsp = lengthdir_y(tempSpd,dir)
	
	x += hsp
	y += vsp
	
	
}