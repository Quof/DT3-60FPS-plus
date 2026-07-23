/*
-- This script is called inside the HUD.
-- It displays the current life total.
-- HEARTS - One heart = 4 HP
*/
xAdjustHeart=view_xview[0]+4
yAdjustHeart=view_yview[0]+4
heartSpacing=12
draw_sprite(sHUD_LifeHold,-1,xAdjustHeart,yAdjustHeart)
xAdjustHeart=view_xview[0]+11
yAdjustHeart=view_yview[0]+14

if oPlayer1.maxLife>=12
{
  if curHeart>=4
    draw_sprite(sHUD_Heart,4,xAdjustHeart,yAdjustHeart)
  else if curHeart=3
    draw_sprite(sHUD_Heart,3,xAdjustHeart,yAdjustHeart)
  else if curHeart=2
    draw_sprite(sHUD_Heart,2,xAdjustHeart,yAdjustHeart)
  else if curHeart=1
    draw_sprite(sHUD_Heart,1,xAdjustHeart,yAdjustHeart)
  else
    draw_sprite(sHUD_Heart,0,xAdjustHeart,yAdjustHeart)
  xAdjustHeart+=heartSpacing
  if curHeart>=8
    draw_sprite(sHUD_Heart,4,xAdjustHeart,yAdjustHeart)
  else if curHeart=7
    draw_sprite(sHUD_Heart,3,xAdjustHeart,yAdjustHeart)
  else if curHeart=6
    draw_sprite(sHUD_Heart,2,xAdjustHeart,yAdjustHeart)
  else if curHeart=5
    draw_sprite(sHUD_Heart,1,xAdjustHeart,yAdjustHeart)
  else
    draw_sprite(sHUD_Heart,0,xAdjustHeart,yAdjustHeart)
  xAdjustHeart+=heartSpacing
  if curHeart>=12
    draw_sprite(sHUD_Heart,4,xAdjustHeart,yAdjustHeart)
  else if curHeart=11
    draw_sprite(sHUD_Heart,3,xAdjustHeart,yAdjustHeart)
  else if curHeart=10
    draw_sprite(sHUD_Heart,2,xAdjustHeart,yAdjustHeart)
  else if curHeart=9
    draw_sprite(sHUD_Heart,1,xAdjustHeart,yAdjustHeart)
  else
    draw_sprite(sHUD_Heart,0,xAdjustHeart,yAdjustHeart)
}
xAdjustHeart+=heartSpacing
if oPlayer1.maxLife>=16
{
  if curHeart>=16
    draw_sprite(sHUD_Heart,4,xAdjustHeart,yAdjustHeart)
  else if curHeart=15
    draw_sprite(sHUD_Heart,3,xAdjustHeart,yAdjustHeart)
  else if curHeart=14
    draw_sprite(sHUD_Heart,2,xAdjustHeart,yAdjustHeart)
  else if curHeart=13
    draw_sprite(sHUD_Heart,1,xAdjustHeart,yAdjustHeart)
  else
    draw_sprite(sHUD_Heart,0,xAdjustHeart,yAdjustHeart)
}
xAdjustHeart+=heartSpacing
if oPlayer1.maxLife>=20
{
  if curHeart>=20
    draw_sprite(sHUD_Heart,4,xAdjustHeart,yAdjustHeart)
  else if curHeart=19
    draw_sprite(sHUD_Heart,3,xAdjustHeart,yAdjustHeart)
  else if curHeart=18
    draw_sprite(sHUD_Heart,2,xAdjustHeart,yAdjustHeart)
  else if curHeart=17
    draw_sprite(sHUD_Heart,1,xAdjustHeart,yAdjustHeart)
  else
    draw_sprite(sHUD_Heart,0,xAdjustHeart,yAdjustHeart)
}
xAdjustHeart+=heartSpacing
if oPlayer1.maxLife>=24
{
  if curHeart>=24
    draw_sprite(sHUD_Heart,4,xAdjustHeart,yAdjustHeart)
  else if curHeart=23
    draw_sprite(sHUD_Heart,3,xAdjustHeart,yAdjustHeart)
  else if curHeart=22
    draw_sprite(sHUD_Heart,2,xAdjustHeart,yAdjustHeart)
  else if curHeart=21
    draw_sprite(sHUD_Heart,1,xAdjustHeart,yAdjustHeart)
  else
    draw_sprite(sHUD_Heart,0,xAdjustHeart,yAdjustHeart)
}
xAdjustHeart+=heartSpacing
if oPlayer1.maxLife>=28
{
  if curHeart>=28
    draw_sprite(sHUD_Heart,4,xAdjustHeart,yAdjustHeart)
  else if curHeart=27
    draw_sprite(sHUD_Heart,3,xAdjustHeart,yAdjustHeart)
  else if curHeart=26
    draw_sprite(sHUD_Heart,2,xAdjustHeart,yAdjustHeart)
  else if curHeart=25
    draw_sprite(sHUD_Heart,1,xAdjustHeart,yAdjustHeart)
  else
    draw_sprite(sHUD_Heart,0,xAdjustHeart,yAdjustHeart)
}
xAdjustHeart+=heartSpacing
if oPlayer1.maxLife>=32
{
  if curHeart>=32
    draw_sprite(sHUD_Heart,4,xAdjustHeart,yAdjustHeart)
  else if curHeart=31
    draw_sprite(sHUD_Heart,3,xAdjustHeart,yAdjustHeart)
  else if curHeart=30
    draw_sprite(sHUD_Heart,2,xAdjustHeart,yAdjustHeart)
  else if curHeart=29
    draw_sprite(sHUD_Heart,1,xAdjustHeart,yAdjustHeart)
  else
    draw_sprite(sHUD_Heart,0,xAdjustHeart,yAdjustHeart)
}
xAdjustHeart+=heartSpacing
if oPlayer1.maxLife>=36
{
  if curHeart>=36
    draw_sprite(sHUD_Heart,4,xAdjustHeart,yAdjustHeart)
  else if curHeart=35
    draw_sprite(sHUD_Heart,3,xAdjustHeart,yAdjustHeart)
  else if curHeart=34
    draw_sprite(sHUD_Heart,2,xAdjustHeart,yAdjustHeart)
  else if curHeart=33
    draw_sprite(sHUD_Heart,1,xAdjustHeart,yAdjustHeart)
  else
    draw_sprite(sHUD_Heart,0,xAdjustHeart,yAdjustHeart)
}
xAdjustHeart+=heartSpacing
if oPlayer1.maxLife>=40
{
  if curHeart>=40
    draw_sprite(sHUD_Heart,4,xAdjustHeart,yAdjustHeart)
  else if curHeart=39
    draw_sprite(sHUD_Heart,3,xAdjustHeart,yAdjustHeart)
  else if curHeart=38
    draw_sprite(sHUD_Heart,2,xAdjustHeart,yAdjustHeart)
  else if curHeart=37
    draw_sprite(sHUD_Heart,1,xAdjustHeart,yAdjustHeart)
  else
    draw_sprite(sHUD_Heart,0,xAdjustHeart,yAdjustHeart)
}
xAdjustHeart=view_xview[0]+11
yAdjustHeart+=heartSpacing //-------------------- NEW LINE --------------------
if oPlayer1.maxLife>=44
{
  if curHeart>=44
    draw_sprite(sHUD_Heart,4,xAdjustHeart,yAdjustHeart)
  else if curHeart=43
    draw_sprite(sHUD_Heart,3,xAdjustHeart,yAdjustHeart)
  else if curHeart=42
    draw_sprite(sHUD_Heart,2,xAdjustHeart,yAdjustHeart)
  else if curHeart=41
    draw_sprite(sHUD_Heart,1,xAdjustHeart,yAdjustHeart)
  else
    draw_sprite(sHUD_Heart,0,xAdjustHeart,yAdjustHeart)
}
xAdjustHeart+=heartSpacing
if oPlayer1.maxLife>=48
{
  if curHeart>=48
    draw_sprite(sHUD_Heart,4,xAdjustHeart,yAdjustHeart)
  else if curHeart=47
    draw_sprite(sHUD_Heart,3,xAdjustHeart,yAdjustHeart)
  else if curHeart=46
    draw_sprite(sHUD_Heart,2,xAdjustHeart,yAdjustHeart)
  else if curHeart=45
    draw_sprite(sHUD_Heart,1,xAdjustHeart,yAdjustHeart)
  else
    draw_sprite(sHUD_Heart,0,xAdjustHeart,yAdjustHeart)
}
xAdjustHeart+=heartSpacing
if oPlayer1.maxLife>=52
{
  if curHeart>=52
    draw_sprite(sHUD_Heart,4,xAdjustHeart,yAdjustHeart)
  else if curHeart=51
    draw_sprite(sHUD_Heart,3,xAdjustHeart,yAdjustHeart)
  else if curHeart=50
    draw_sprite(sHUD_Heart,2,xAdjustHeart,yAdjustHeart)
  else if curHeart=49
    draw_sprite(sHUD_Heart,1,xAdjustHeart,yAdjustHeart)
  else
    draw_sprite(sHUD_Heart,0,xAdjustHeart,yAdjustHeart)
}
xAdjustHeart+=heartSpacing
if oPlayer1.maxLife>=56
{
  if curHeart>=56
    draw_sprite(sHUD_Heart,4,xAdjustHeart,yAdjustHeart)
  else if curHeart=55
    draw_sprite(sHUD_Heart,3,xAdjustHeart,yAdjustHeart)
  else if curHeart=54
    draw_sprite(sHUD_Heart,2,xAdjustHeart,yAdjustHeart)
  else if curHeart=53
    draw_sprite(sHUD_Heart,1,xAdjustHeart,yAdjustHeart)
  else
    draw_sprite(sHUD_Heart,0,xAdjustHeart,yAdjustHeart)
}
xAdjustHeart+=heartSpacing
if oPlayer1.maxLife>=60
{
  if curHeart>=60
    draw_sprite(sHUD_Heart,4,xAdjustHeart,yAdjustHeart)
  else if curHeart=59
    draw_sprite(sHUD_Heart,3,xAdjustHeart,yAdjustHeart)
  else if curHeart=58
    draw_sprite(sHUD_Heart,2,xAdjustHeart,yAdjustHeart)
  else if curHeart=57
    draw_sprite(sHUD_Heart,1,xAdjustHeart,yAdjustHeart)
  else
    draw_sprite(sHUD_Heart,0,xAdjustHeart,yAdjustHeart)
}
xAdjustHeart+=heartSpacing
if oPlayer1.maxLife>=64
{
  if curHeart>=64
    draw_sprite(sHUD_Heart,4,xAdjustHeart,yAdjustHeart)
  else if curHeart=63
    draw_sprite(sHUD_Heart,3,xAdjustHeart,yAdjustHeart)
  else if curHeart=62
    draw_sprite(sHUD_Heart,2,xAdjustHeart,yAdjustHeart)
  else if curHeart=61
    draw_sprite(sHUD_Heart,1,xAdjustHeart,yAdjustHeart)
  else
    draw_sprite(sHUD_Heart,0,xAdjustHeart,yAdjustHeart)
}
xAdjustHeart+=heartSpacing
if oPlayer1.maxLife>=68
{
  if curHeart>=68
    draw_sprite(sHUD_Heart,4,xAdjustHeart,yAdjustHeart)
  else if curHeart=67
    draw_sprite(sHUD_Heart,3,xAdjustHeart,yAdjustHeart)
  else if curHeart=66
    draw_sprite(sHUD_Heart,2,xAdjustHeart,yAdjustHeart)
  else if curHeart=65
    draw_sprite(sHUD_Heart,1,xAdjustHeart,yAdjustHeart)
  else
    draw_sprite(sHUD_Heart,0,xAdjustHeart,yAdjustHeart)
}
xAdjustHeart+=heartSpacing
if oPlayer1.maxLife>=72
{
  if curHeart>=72
    draw_sprite(sHUD_Heart,4,xAdjustHeart,yAdjustHeart)
  else if curHeart=71
    draw_sprite(sHUD_Heart,3,xAdjustHeart,yAdjustHeart)
  else if curHeart=70
    draw_sprite(sHUD_Heart,2,xAdjustHeart,yAdjustHeart)
  else if curHeart=69
    draw_sprite(sHUD_Heart,1,xAdjustHeart,yAdjustHeart)
  else
    draw_sprite(sHUD_Heart,0,xAdjustHeart,yAdjustHeart)
}
xAdjustHeart+=heartSpacing
if oPlayer1.maxLife>=76
{
  if curHeart>=76
    draw_sprite(sHUD_Heart,4,xAdjustHeart,yAdjustHeart)
  else if curHeart=75
    draw_sprite(sHUD_Heart,3,xAdjustHeart,yAdjustHeart)
  else if curHeart=74
    draw_sprite(sHUD_Heart,2,xAdjustHeart,yAdjustHeart)
  else if curHeart=73
    draw_sprite(sHUD_Heart,1,xAdjustHeart,yAdjustHeart)
  else
    draw_sprite(sHUD_Heart,0,xAdjustHeart,yAdjustHeart)
}
xAdjustHeart+=heartSpacing
if oPlayer1.maxLife>=80
{
  if curHeart>=80
    draw_sprite(sHUD_Heart,4,xAdjustHeart,yAdjustHeart)
  else if curHeart=79
    draw_sprite(sHUD_Heart,3,xAdjustHeart,yAdjustHeart)
  else if curHeart=78
    draw_sprite(sHUD_Heart,2,xAdjustHeart,yAdjustHeart)
  else if curHeart=77
    draw_sprite(sHUD_Heart,1,xAdjustHeart,yAdjustHeart)
  else
    draw_sprite(sHUD_Heart,0,xAdjustHeart,yAdjustHeart)
}
