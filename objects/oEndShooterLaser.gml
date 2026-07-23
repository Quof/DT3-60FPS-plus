#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
bHit=0
playSound(global.snd_CShotB,0,0.95,30000)
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  x-=20
  if type=1 and bHit=0
  {
    if x<=oPlayer1.x+8
    {
      oEvShooter.sceneDelay=500
      oDragoonShip.bCanUseWeapon=0
      with oEndShooterLaser {bHit=1}
    }
  }
  if x<=-64 {instance_destroy()}
}
