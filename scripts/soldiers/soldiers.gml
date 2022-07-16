function SpawnSoldiers()
{
	if (instance_exists(oSoldier)) with (oSoldier) instance_destroy()
	for (var i = 0; i < currentLevel.soldierAmount; i++)
	{
		instance_create_layer(0,0,"Soldiers",oSoldier,{soldierPosition: i})
	}
}