//Evil Boss Gallery: Evil Death's room (the build's copy of rBelmont3_7G): the gallery's fight as that room's code starts
//it (its barriers, the platforms and their tiles out of the way as for Death's fight, the player's status kept for
//Retry), with Evil Death. The room's story object isn't made here, only the event holder it is (oGlobalEvent)
locationCheck(15)
instance_create(0,0,oGlobalEvent)
var sceneBarr;
sceneBarr=instance_create(-16,0,oBossBarrier)
sceneBarr.image_yscale=5.5
sceneBarr=instance_create(608,0,oBossBarrier)
sceneBarr.image_yscale=5.5

tile_layer_shift(999998,0,64)
var i;
for(i=189167;i<189170;i+=1)
{
  with (GID(i)) {instance_destroy()}
}

var tempMplay;
tempMplay=findMusic(806)
oPlayer1.x=224; oPlayer1.y=304
storeStatus(1)
boss=instance_create(384,304,oEvgDeath)
boss.activateBoss=1
playMusic(tempMplay,0,0)
