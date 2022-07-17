function SpawnSoldiers()
{
	if (instance_exists(oSoldier)) with (oSoldier) instance_destroy()
	for (var i = 0; i < currentLevel.soldierAmount; i++)
	{
		instance_create_layer(startX*gridSize+boardTopX+gridSize/2,startY*gridSize+boardTopY+gridSize+gridSize/2,"Soldiers",oSoldier,{soldierPosition: i})
	}
}
