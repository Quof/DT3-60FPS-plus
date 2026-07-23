#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()

//Enemy base statistics
eName="Mega Tortoise"
eLevel=20
maxLife=800
life=maxLife
pointWorth=30
atkPower=7
resType[0]=2
resType[1]=2
resType[2]=2
resType[4]=4
resType[5]=4
stunResist=5
baseItemChance=65
baseDropIndex=75
moneyWorth=5
affiliation=4
hitSound=global.snd_EnemyHitMM
dieSound=0
dieEffect=0
inactiveDist*=1.5

bombTime=56
bombDelay=79

pipeY[0]=34
pipeY[1]=34

jeremyText="This fires two bombs out, which will drop and open a parachute as they do so. The first bomb will open its parachute when it gets above you. The second one will open when it gets behind you. Looks to be some attempt at closing off your escape route, but I personally don't find it all that effective. Find a weapon that it's vulnerable to since these guys have pretty good durability."
chaoText="Jeremy's been getting more and more concerned about the Virus ever since Sigma was mentioned. He seems very sure that Sigma is in some way responsible for the Virus outbreak. I bet he's worried. You know how he gets sometimes when he gets nervous. But on a side note, aren't those little parachutes so cute?!"
devText="I was a bit apprehensive at first in using the Sigma Stage 1 theme for its counterpart in Gate 4 due to how the theme fit into the events that played out during the level. The theme was given a test run and it didn't feel awkward, even though this level doesn't carry any of the tones the original level had."
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  makeEnemyActive(0)
  if bActive=true and stunnedTime=0 and life>0
  {
    if x<oPlayer1.x {image_xscale=1}
    else {image_xscale=-1}

    bombTime+=1
    if bombTime>=bombDelay+1 and bombTime<=bombDelay+6 {pipeY[0]-=0.5}
    else if bombTime>=bombDelay+12 and bombTime<=bombDelay+14 {pipeY[0]+=1}
    else if bombTime=bombDelay+15
    {
      var tNewAttack;
      tNewAttack=instance_create(x+(6*image_xscale),y-39,oMegaTBomb); tNewAttack.type=0
      tNewAttack.atkPower=atkPower; tNewAttack.xVel=7*image_xscale; tNewAttack.yVel=-8
    }
    else if bombTime>=bombDelay+18 and bombTime<=bombDelay+23 {pipeY[1]-=0.5}
    else if bombTime>=bombDelay+27 and bombTime<=bombDelay+29 {pipeY[1]+=1}
    else if bombTime=bombDelay+30
    {
      var tNewAttack;
      tNewAttack=instance_create(x-(9*image_xscale),y-39,oMegaTBomb); tNewAttack.type=1
      tNewAttack.atkPower=atkPower; tNewAttack.xVel=7*image_xscale; tNewAttack.yVel=-8
      bombTime=0
    }
  }
  else if life<=0
  {
    playSound(global.snd_EnemyDieMM,0,1,1)
    tEffect=instance_create(x,y-24,oEffect); tEffect.sprite_index=sMMExplosion
    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    tEffect=instance_create(x-12,y-12,oEffect); tEffect.sprite_index=sMMExplosion
    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    tEffect=instance_create(x+12,y-12,oEffect); tEffect.sprite_index=sMMExplosion
    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    instance_destroy()
  }

  enemyStepEvent()
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if image_xscale=1 {offsetX[0]=-6; offsetX[1]=9}
else {offsetX[0]=-9; offsetX[1]=6}

for(i=0;i<2;i+=1)
{
  draw_sprite_ext(sMegaTortoisePipe,image_index,x+offsetX[i],y-pipeY[i],image_xscale,image_yscale,image_angle,image_blend,image_alpha)
}
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
