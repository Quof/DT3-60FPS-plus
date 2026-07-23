#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
enemyCount=-1
fadeColor=c_white
fadeAlpha=0

if global.newMapX>=512 {sceneProgress=3}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if room=rDiscoInvasion //----- Space Invader room -----
  {
    if sceneProgress=0 //Barriers
    {
      if oPlayer1.x>=304
      {
        var tBarrier;
        tBarrier=instance_create(48,224,oEnemyBarrier); tBarrier.image_yscale=4
        tBarrier=instance_create(544,224,oEnemyBarrier); tBarrier.image_yscale=4
        sceneProgress+=1
      }
    }
    else if sceneProgress=1 //Spawn Space Invaders
    {
      sceneDelay+=1
      if sceneDelay=20
      {
        var tEnemy;
        for(i=0;i<18;i+=1)
        {
          for(ii=0;ii<5;ii+=1)
          {
            tEnemy=instance_create(112+(i*18),32+(ii*14),oSpaceInvader)
            tEnemy.shotTime=(i*6)+(ii*25)
            if ii=0 {sprite_index=sSpaceInvaderC}
            if ii=1 or ii=2 {sprite_index=sSpaceInvaderB}
          }
        }
      }
      else if sceneDelay>=30 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=2 //All enemies defeated
    {
      if !instance_exists(oSpaceInvader)
      {
        with oEnemyBarrier {instance_destroy()}
        if global.gameProgress<=4630 {global.gameProgress=4635}
        sceneProgress+=1
      }
    }
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if fadeAlpha>0
{
  draw_set_alpha(fadeAlpha)
  draw_set_color(fadeColor)
  draw_rectangle(view_xview[0]-1,view_yview[0]-1,view_xview[0]+view_wview[0]+1,view_yview[0]+view_hview[0]+1,0)
}
