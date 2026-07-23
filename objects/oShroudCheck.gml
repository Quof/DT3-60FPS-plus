#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/*
shroudProg
0: Player has not come within spawning range (skip if Shrouds are following)
1: Shrouds are spawning (3 second wait time)
2: Spawn Shrouds (multiple of 2 will spawn)
3: Wait for player to kill Shrouds or leave map
4: Shrouds defeated
5: Player died
*/
shroudProg=0
spawnTime=0
blazingTime=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if shroudProg=0 //player must be in the map a bit for the spawning to occur
  {
    if global.shroudThreat>=1000
    {
      spawnTime+=1
      if spawnTime>=15
      {
        spawnTime=0
        if global.gameProgress>=251 and global.gameProgress<=260
          msgCreate("You're not getting away from the Shrouds that easy.",0,oMessagePerson,global.mainCharacters[3],0,1)
        else
          msgCreate("The Shrouds are following you.",0,oMessagePerson,global.mainCharacters[1],0,1)
        newMessage.fadingTime=90
        shroudProg=1
      }
    }
    else
    {
      if oPlayer1.x>room_width/3 and oPlayer1.x<room_width-(room_width/3)
      {
        if global.gameProgress>=251 and global.gameProgress<=260
          msgCreate("I'm feeling nice enough to give you a heads up about the Shrouds.",0,oMessagePerson,global.mainCharacters[3],0,1)
        else
          msgCreate("Careful, the Shrouds are scouting this area.",0,oMessagePerson,global.mainCharacters[1],0,1)
        newMessage.fadingTime=90
        shroudProg=1
      }
    }
  }
  else if shroudProg=1
  {
    spawnTime+=1
    if spawnTime>=120
      shroudProg=2
  }
  else if shroudProg=2 //spawn shroud
  {
    instance_create(0,0,oScreenEffect)
    x=random_range(oPlayer1.x-512,oPlayer1.x+512)
    y=random_range(oPlayer1.y-128,oPlayer1.y+64)
    var distCheck;
    distCheck=point_distance(x,0,oPlayer1.x,0)
    if distCheck<72
    {
      if oPlayer1.image_xscale=1
        x+=256
      else
        x-=256
    }
    while(collision_rectangle(x-30,y-55,x+30,y,oSolid,true,true)) //and x<16 and x>room_width-16 and y<16 and y>room_height-16)
    {
      x=random_range(oPlayer1.x-512,oPlayer1.x+512)
      y=random_range(oPlayer1.y-128,oPlayer1.y+96)
      var distCheck;
      distCheck=point_distance(x,0,oPlayer1.x,0)
      if distCheck<128
      {
        if oPlayer1.image_xscale=1
          x+=256
        else
          x-=256
      }
    }
    newShroud=instance_create(x,y,oShroud)
    newShroud.bActive=true
    newShroud.spawnCount=1
    newShroud.xSdist=0
    newShroud.ySdist=0
    newShroud.dtXpointSelf=0
    newShroud.dtYpointSelf=0
    newShroud.dtXpointOther=0
    newShroud.dtYpointOther=0
    newShroud.dtTele=false
    shroudProg=3
  }
  else if shroudProg=3 //shroud check
  {
    if global.gameProgress>=195 //Blazing
    {
      blazingTime+=1
      if blazingTime=180
        blazingBat=instance_create(x,y,oBlazingAssist)
    }
    //win/lose condition
    if instance_exists(oGameOver)
      shroudProg=5
    if !instance_exists(oShroud)
    {
      if global.gameProgress>=251 and global.gameProgress<=260
        msgCreate("You got lucky.",0,oMessagePerson,global.mainCharacters[3],0,1)
      else
        msgCreate("Wow, good job.",0,oMessagePerson,global.mainCharacters[1],0,1)
      newMessage.fadingTime=90
      if global.shroudThreat>=110
        global.shroudThreat=0
      else
      {
        global.shroudThreat-=50
        if global.shroudThreat<0
          global.shroudThreat=0
      }
      shroudProg=4
    }
  }
}
#define Other_5
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if shroudProg=3
{
  if global.shroudThreat>60 and global.shroudThreat<120 //chance that Shrouds will follow
  {
    var followChance;
    followChance=random(100)
    if global.shroudThreat>75
      followChance-=10
    else if global.shroudThreat>90
      followChance-=50

    if followChance<=15
      global.shroudThreat+=1000
  }
  if global.shroudThreat<120 //increase threat level if player runs
  {
    if global.shroudThreat<40
      global.shroudThreat+=10
    else
      global.shroudThreat+=5
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if instance_exists(oShroud)
{
  draw_set_alpha(0.5)
  draw_set_blend_mode(bm_add)
  draw_circle_color(view_xview[0]+(view_wview[0]/2),view_yview[0]+(view_hview[0]/2),576,c_black,make_color_rgb(220,0,65),0)
  draw_set_blend_mode(bm_normal)
}
