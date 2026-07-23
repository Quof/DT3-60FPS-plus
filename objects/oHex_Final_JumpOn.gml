#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
bActive=true

//Enemy base statistics
eName="Hex"
maxLife=100
life=maxLife
stunResist=50
bIsBoss=true
bNoBonus=true
dieEffect=0
bossProgress=0
activateBoss=0
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if bCanTakeDamage=true
{
  yAdjust=0
  with oPlayer1
  {
    if platformCharacterIs(ON_GROUND) {other.yAdjust=-8}
    if platformCharacterIs(IN_AIR) {other.yAdjust=0}
  }
  veloAssist=0
  if oPlayer1.yVel>0
    veloAssist=round(oPlayer1.yVel/2)

  if bbox_bottom+yAdjust+veloAssist<oPlayer1.bbox_bottom
  {
    //Do nothing since Hex has no hurt-box
  }
  else
  {
    if global.hasAbilToken[0]>=2
    {
      if oPlayer1.bCanTakeHit=true and oPlayer1.sprite_index!=sJerryDamaged and oPlayer1.sprite_index!=sClaireDamaged
      {
        with oPlayer1
        {
          scrSlowFall(5,0.4,0)
        }

        //Damage effect
        var tFlash,tEffect;
        tFlash=instance_create(0,0,oScreenFlash)
        tFlash.image_alpha=0.5; tFlash.fadeSpeed=0.1
        oPlayer1.canAirDash=1; oPlayer1.doubleJumpCheck=1
        bCanTakeDamage=false
        hitStateTime=30
        oHex_Final_Main.bJumpedOn=1
        global.gamePaused=1
        instance_destroy()
      }
    }
  }
}
