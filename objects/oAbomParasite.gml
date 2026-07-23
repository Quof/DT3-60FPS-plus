#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
bActive=1
image_speed=0.33

//Enemy base statistics
eName="Parasite"
eLevel=39
maxLife=3800
life=maxLife
atkPower=12
stunResist=50
affiliation=9
bIsBoss=true
bNoBonus=true

scaleWaveA=pi/2
scaleWaveB=pi/2
waveBUp=1

seqTime=0

deathAnim=0

jeremyText="It looks like we were able to force this thing out of the creature. The thing here though is we'll need all the instruments playing. The attacks are mostly the same... I think? The big thing you gotta watch out for are the weird worm things that burst out of the parasite itself. They'll stop, and then target you about a second later."
chaoText="This... parasite that Hex put into the creature has some remnants of the Virus in it. Hex probably used part of it for this since the Virus was able to alter behaviors."
devText="N/A"
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if life>0
  {
    if oEvAbom.instrumentActNum=8 {bCanTakeDamage=1}
    else {bCanTakeDamage=0}

    seqTime+=1
    if seqTime=220
    {
      var tAttack,tDir;
      tDir=0
      for(i=0;i<16;i+=1)
      {
        tAttack=instance_create(x,y,oAbomParaShot)
        tAttack.direction=tDir
        tDir+=360/16
      }
      seqTime=0
    }
  }
  enemyStepEvent()

  if life<=0
  {
    deathAnim+=1
    if deathAnim=1
    {
      with oEnemyBase {bCanDealDamage=0}
      bCanTakeDamage=0
      oAbominationMain.sequence=16
      oAbominationMain.seqTime=0
      oEvAbom.instrumentProg=3
    }
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
scaleWaveA+=pi/60
for(i=0;i<8;i+=1)
{
  draw_sprite_ext(sAbomBodyConnectorA,0,x+lengthdir_x(20+(18*i),30),y+lengthdir_y(20+(18*i),30),1.25+(sin(scaleWaveA+i)/2),1.25+(sin(scaleWaveA+i)/2),i*20,c_white,image_alpha)
  draw_sprite_ext(sAbomBodyConnectorA,0,x+lengthdir_x(20+(18*i),330),y+lengthdir_y(20+(18*i),330),1.25+(sin(scaleWaveA+i)/2),1.25+(sin(scaleWaveA+i)/2),i*20,c_white,image_alpha)
  draw_sprite_ext(sAbomBodyConnectorA,0,x+lengthdir_x(20+(18*i),150),y+lengthdir_y(20+(18*i),150),1.25+(sin(scaleWaveA+i)/2),1.25+(sin(scaleWaveA+i)/2),i*20,c_white,image_alpha)
  draw_sprite_ext(sAbomBodyConnectorA,0,x+lengthdir_x(20+(18*i),210),y+lengthdir_y(20+(18*i),210),1.25+(sin(scaleWaveA+i)/2),1.25+(sin(scaleWaveA+i)/2),i*20,c_white,image_alpha)
}

if waveBUp=1
{
  scaleWaveB+=0.004
  if scaleWaveB>=1.05 {waveBUp=0}
}
else
{
  scaleWaveB-=0.004
  if scaleWaveB<=0.95 {waveBUp=1}
}
image_xscale=1+scaleWaveB
image_yscale=1+scaleWaveB
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
