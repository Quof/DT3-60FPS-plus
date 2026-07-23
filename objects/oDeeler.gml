#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0.33

//Enemy base statistics
eName="Deeler"
eLevel=6
maxLife=120
life=maxLife
pointWorth=9
atkPower=4
resType[2]=4
resType[5]=4
baseItemChance=50
affiliation=2
hitSound=global.snd_EnemyHitZelda
dieSound=3
dieEffect=3

detectDistY=288
atkDistX=8
runAcc=2.5
atkProg=0

jeremyText="I remember avoiding forests near the beginning because of these spiders. Mainly because they were usually accompanied by Moblins that gave 0 Exp and had that annoying spear. Anyway, these only go left and right and when they're close enough, they drop down on a web and come back up."
chaoText="I watched Jeremy play this game. One time he tried to combo sword bounce with the downward stab. I don't think he actually pulled it off, but he didn't try for very long."
devText="One thing I felt that was very lackluster in the first and second DT was the visuals. I wanted to step that up a bit for this one. Though that is one area I feel I'm not very strong in, so I went my own way with that. Having things like more subtle effects and unique death animations is what I felt I would be capable of delivering consistently."
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  makeEnemyActive(0)
  if bActive=true and stunnedTime=0
  {
    if atkProg=0 //Move to player's x position
    {
      if x<oPlayer1.x
        x+=runAcc
      else
        x-=runAcc
      
      findTargetX=point_distance(oPlayer1.x,0,x,0)
      if findTargetX<atkDistX and y<oPlayer1.y and findTargetY<detectDistY
      {
        image_yscale=-1
        atkProg+=1
      }
    }
    else if atkProg=1 //Attack down from string
    {
      y+=runAcc*2
      if y>=ystart+144
        atkProg+=1
    }
    else if atkProg=2 //Return
    {
      y-=runAcc*2
      if y<=ystart
      {
        y=ystart
        image_yscale=1
        atkProg=0
      }
    }
  }
  enemyStepEvent()
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if y>ystart //draw string
{
  draw_set_alpha(1)
  draw_set_color(c_white)
  draw_line(x,ystart,x,y+4)
}
event_inherited()
