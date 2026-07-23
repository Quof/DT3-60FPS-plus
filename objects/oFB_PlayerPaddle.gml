#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed=0

normalSpd=4
focusSpd=2
moveSpd=normalSpd

topBorder=64
bottomBorder=room_height-48
leftBorder=16
rightBorder=48

maxLife=global.pMaxLife
life=global.pLife
dashMeterMax=10000
dashEnergy=dashMeterMax
jeremySuperEnergy=global.jeremySuperEnergy
jeremySuperMax=3000
dashDelay=0

alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_create(0,0,oFinalHUD)
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=0
{
  if scrController(1)
  {
    if x>leftBorder
    {
      x-=moveSpd
      if x<leftBorder {x=leftBorder}
    }
  }
  if scrController(2)
  {
    if x<rightBorder
    {
      x+=moveSpd
      if x>rightBorder {x=rightBorder}
    }
  }
  if scrController(3)
  {
    if y>topBorder
    {
      y-=moveSpd
      if y<topBorder {y=topBorder}
    }
  }
  if scrController(4)
  {
    if y<bottomBorder
    {
      y+=moveSpd
      if y>bottomBorder {y=bottomBorder}
    }
  }

  if dashDelay=0
  {
    if scrController(5) //Focus speed
    {
      moveSpd=focusSpd
    }
    else //Normal speed
    {
      moveSpd=normalSpd
    }
  }
  else
  {
    if (!scrController(13) and !scrController(14)) {dashDelay=0}
  }

  if oKeyCodes.kCodePressed[6]=1 //Attack
  {
    if jeremySuperEnergy>=300
    {
      jeremySuperEnergy-=300
      playSound(global.snd_MarioCannon,0,0.94,30000+random(3000))
      instance_create(x+10,y,oFB_PlayerBullet)
    }
  }

  if moveSpd>4 {moveSpd-=0.1}
  if moveSpd>6.8
  {
    var tAfterI;
    tAfterI=instance_create(x,y,oEnemyAfterImage)
    tAfterI.sprite_index=sprite_index; tAfterI.image_speed=0; tAfterI.image_blend=c_blue
    tAfterI.depth=26; tAfterI.image_alpha=0.8; tAfterI.imageFade=0.1
    tAfterI.xScaling=0; tAfterI.yScaling=0; tAfterI.xShift=0; tAfterI.yShift=0
    tAfterI.bFollow=1; tAfterI.idFollow=id; tAfterI.xFollow=0; tAfterI.yFollow=0
  }

  if dashDelay>0 {dashDelay-=1}

  if (oKeyCodes.kCodePressed[13] or oKeyCodes.kCodePressed[14]) and dashEnergy>=2000 and dashDelay=0 //Dash
  {
    dashDelay=30
    moveSpd=8
    dashEnergy-=2000
  }

  if dashEnergy<dashMeterMax
  {
    dashEnergy+=5
    if dashEnergy>dashMeterMax {dashEnergy=dashMeterMax}
  }

  if jeremySuperEnergy<jeremySuperMax
  {
    jeremySuperEnergy+=10
    if jeremySuperEnergy>jeremySuperMax {jeremySuperEnergy=jeremySuperMax}
  }

  if life<=0
  {
    if global.bCanGameOver=1
    {
      if !instance_exists(oGameOver)
      {
        stopLoopingSounds()
        gameOver=instance_create(0,0,oGameOver)
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
draw_set_alpha(1)
draw_set_color(c_white)
draw_line_width(0,47,room_width,47,2)
draw_line_width(0,321,room_width,321,2)
draw_set_alpha(0.15)
draw_line_width(9,47,9,321,2)
draw_line_width(55,47,55,321,2)

draw_self()
