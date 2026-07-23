#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
sceneProgress=0
sceneDelay=0
heightNorm=784
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if sceneProgress=0 //Start viewport rotate
{
  if oPlayer1.x<480 and oPlayer1.y>608
  {
    var tempMplay;
    tempMplay=findMusic(20)
    playMusic(tempMplay,0,0)
    sceneProgress+=1
  }
}
else if sceneProgress=1 //Viewport rotation
{
  view_angle[0]+=0.5
  sceneDelay+=1
  if sceneDelay>=100
  {
    var tempMplay;
    tempMplay=findMusic(0)
    playMusic(tempMplay,0,0)
    view_angle[0]=0
    sceneDelay=0; sceneProgress+=1
  }
}
else if sceneProgress=2 //Spawn fake Koopas
{
  if oPlayer1.y>1376
  {
    for(i=0;i<3;i+=1)
    {
      instance_create(256+(48*i),1632,oFakeKoopa)
      instance_create(288+(48*i),1664,oFakeKoopa)
      instance_create(352+(48*i),1696,oFakeKoopa)
    }
    sceneProgress+=1
  }
}
else if sceneProgress=3 //Viewport rotates with height
{
  if oPlayer1.x>1440
  {
    if oPlayer1.y<784
    {
      var heightDiff;
      heightDiff=(heightNorm-oPlayer1.y)/2.8
      view_angle[0]=heightDiff
    }
    else {view_angle[0]=0}

    if oPlayer1.x>=1664
    {
      view_angle[0]=180
      playSound(global.snd_HardHit2,0,1,1)
      myRealWall=instance_create(1632,192,oInvisibleSolid)
      myRealWall.image_yscale=8
      myRealGraphic=instance_create(1632,192,oBuggedScenery)
      myRealGraphic.drawType=4; myRealGraphic.image_yscale=8
      var tNewAttack;
      for(i=0;i<6;i+=1)
      {
        tNewAttack=instance_create(1504,208+(32*i),oPassBullet)
        tNewAttack.sprite_index=sMarioChain; tNewAttack.atkPower=0; tNewAttack.bulletSpeed=6
        tNewAttack.decayTime=-100; tNewAttack.bDealZeroDamage=1
      }
      sceneProgress+=1
    }
  }
}
else if sceneProgress=4 //Teleport player to dead end
{
  if oPlayer1.x>=3008
  {
    oPlayer1.x=1280; oPlayer1.y=832
    view_angle[0]=0
    var tNewColl;
    tNewColl=instance_create(992,1280,oInvisibleSolid)
    tNewColl.image_xscale=4
    with myRealWall {instance_destroy()}
    sceneProgress+=1
  }
}
else if sceneProgress=5 //wtf?
{
  sceneDelay+=1
  if sceneDelay=45
  {
    if global.activeCharacter=0
    {
      msgCreate(0,0,"Jerry","What the hell man?",0,1,oMessagePerson,0)
      newMessage.fadingTime=60
    }
    else if global.activeCharacter=1
    {
      msgCreate(0,0,"Claire","This is kinda bull crap here...",0,1,oMessagePerson,0)
      newMessage.fadingTime=70
    }
    sceneDelay=0; sceneProgress+=1
  }
}
else if sceneProgress=6 //Teleport player back to top
{
  if oPlayer1.y>=1344
  {
    oPlayer1.x=1576; oPlayer1.y=240
    sceneProgress+=1
  }
}
else if sceneProgress=7 //Viewport instant rotate
{
  if sceneDelay=0
  {
    if oPlayer1.x>=1728 {view_angle[0]=90; sceneDelay+=1}
  }
  else if sceneDelay=1
  {
    if oPlayer1.x>=2112 {view_angle[0]=180; sceneDelay+=1}
  }
  else if sceneDelay=2
  {
    if oPlayer1.x>=2432 {view_angle[0]=270; sceneDelay+=1}
  }
  else if sceneDelay=3
  {
    if oPlayer1.x>=2624 {view_angle[0]=0; sceneDelay=0; sceneProgress+=1}
  }
}
else if sceneProgress=8 //No teleporting
{
  if oPlayer1.x>=2720
  {
    msgCreate(0,0,"Jeremy","It shouldn't teleport you guys this time.",0,1,oMessagePerson,0)
    newMessage.fadingTime=90
    sceneProgress+=1
  }
}
