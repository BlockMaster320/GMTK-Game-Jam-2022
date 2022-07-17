if (active)
{
	var targetXcentered = targetX + (oController.gridSize-1) / 2
	var targetYcentered = targetY + (oController.gridSize-1) / 2
	
	if (point_distance(x,y,targetXcentered,targetYcentered) < turnDist)
	{
		turnDist = random_range(spd,oController.gridSize*.5)
		walkingListPosition++
		if (ds_list_size(oController.walkedOverListX) < walkingListPosition)
		{
			//Finished
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
	hsp = lengthdir_x(spd,dir)
	vsp = lengthdir_y(spd,dir)
	x += hsp
	y += vsp
}