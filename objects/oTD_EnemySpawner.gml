#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/*
Spawns a set number of enemies at instance x/y.

enemyType: Enemy being spawned.
enemyLevel: Level of the enemy.
spawnFreq: Frequency of the enemy being spawned.
spawnMax: Max number of enemies that will spawn.
myDir: Initial direction of the enemy.
*/
bCanSpawn=0
spawnTime=0
spawnNum=0
typeNum=0
image_xscale=0.75
image_yscale=0.75
image_alpha=0.75
image_speed=0.3
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if enemyType=oTDE_AdvanceTank {typeNum="Advance Tank"}
else if enemyType=oTDE_CrabTank {typeNum="Crab Tank"}
else if enemyType=oTDE_SteamBomb {typeNum="Steam Bomb"}
else if enemyType=oTDE_Helicopter {typeNum="Helicopter"}
else if enemyType=oTDE_GorillaTank {typeNum="Gorilla Tank"}
else if enemyType=oTDE_DozerTank {typeNum="BOSS: Dozer Tank"}
else if enemyType=oTDE_BeastTank {typeNum="BOSS: Beast Tank"}
spawnTime=spawnFreq-10
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if bCanSpawn=1
  {
    spawnTime+=1
    if spawnTime>=spawnFreq
    {
      var newSpawn;
      newSpawn=instance_create(x,y,enemyType)
      newSpawn.siegeLv=enemyLevel
      if object_is_ancestor(enemyType,oTD_Ground) {newSpawn.image_xscale=myDir}
      else if object_is_ancestor(enemyType,oTD_Flyer) {newSpawn.direction=myDir}
      spawnTime=0
      spawnNum+=1
      if spawnNum>=spawnMax {instance_destroy()}
    }
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_set_blend_mode(bm_add)
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
draw_set_blend_mode(bm_normal)

draw_set_alpha(1)
draw_set_font(fnt_PauseMenuText)
draw_set_halign(fa_middle)
textDropShadow(string(spawnMax-spawnNum) +string("#") +string(typeNum) +string("#Lv.") +string(enemyLevel),x,y-32,make_color_rgb(255,248,155),make_color_rgb(16,8,8),3)

if bCanSpawn=0
{
  var distToPlayer;
  distToPlayer=point_distance(x,y,oPlayer1.x,oPlayer1.y-26)
  if distToPlayer>160
  {
    var arrowDir;
    arrowDir=point_direction(oPlayer1.x,oPlayer1.y-26,x,y)
    draw_sprite_ext(sPauseM_Cursor,0,oPlayer1.x+lengthdir_x(72,arrowDir),oPlayer1.y-26+lengthdir_y(72,arrowDir),1,1,arrowDir,c_white,1)
  }
}
