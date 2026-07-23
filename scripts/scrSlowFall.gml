/*
usage: scrSlowFall(time,effect,force)

This script starts the slow fall.
argument0: how much time to use for slow fall
argument1: how much effect to use for slow fall
argument2: force new time/effect, 0: do not force, 1: force
*/
var sfTime,sfEffect,sfForce;
sfTime=argument0
sfEffect=argument1
sfForce=argument2

if oPlayer1.slowFallTime<sfTime
{
  oPlayer1.slowFallTime=sfTime
  oPlayer1.slowFallEffect=sfEffect
}

if sfForce=1
{
  oPlayer1.slowFallTime=sfTime
  oPlayer1.slowFallEffect=sfEffect
}
