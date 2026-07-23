/*
Displays the timer and makes it work.
argument0: 0 - don't countdown or display timer
argument1: timer color
*/
if argument0=1 and global.gamePaused=false
{
  //count down time
  global.cTimerHundred-=3.3
  if global.cTimerHundred<=0
  {
    global.cTimerSecond-=1
    if global.cTimerSecond<=0
    {
      if global.cTimerMinute<=0 and global.cTimerSecond<=0 and global.cTimerHundred<=0
        oPlayer1.life-=oPlayer1.maxLife
      global.cTimerMinute-=1
      global.cTimerSecond+=59
    }
    global.cTimerHundred+=99
  }
  if global.cTimerSecond<10
    cTimerSecondZero=0
  else
    cTimerSecondZero=""
  if global.cTimerHundred<=9
    cTimerHundredZero=0
  else
    cTimerHundredZero=""
  //draw timer
  countdownTimerX=view_xview[0]+220
  countdownTimerY=view_yview[0]+44
  draw_set_font(fnt_Timer)
  draw_set_halign(fa_left)
  draw_set_alpha(1)
  draw_set_color(argument1)
  draw_text(countdownTimerX,countdownTimerY,string(global.cTimerMinute) +string(":") +string(cTimerSecondZero) +string(global.cTimerSecond) +string(":") +string(cTimerHundredZero) +string(round(global.cTimerHundred)))
}
