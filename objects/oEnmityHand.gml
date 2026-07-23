#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
bCanTakeDamage=false
image_speed=0

//Enemy base statistics
eName="Enmity Hand"
eLevel=14
maxLife=2500
life=maxLife
atkPower=5
bIsBoss=true
bNoBonus=true

atkProg=0
atkTime=250+irandom(150)
atkDelay=460
moveSpd=1

ceilingAtk=0

jeremyText="Don't bother attacking these hands, nothing works on them. Instead, focus on the body's weak point. These will go through a sequence with tracking you from the side and attacking from there. Afterwards, it will perform a few attacks from the ceiling and then repeat this process."
chaoText="A bit before the hand is ready to attack, it will start to close its fist. Look for that sign to start guiding the hand to a more optimal position for yourself.#Eww... I'm starting to word things in Jeremy's style."
devText="I love encounters with multiple parts. The tricky part for me when designing them is keeping the battle frantic, even after destroying multiple parts. The player still needs to be rewarded for doing what is expected of them though. Typically, when a weaker part is destroyed, a slight boost in other attributes for the opponent occurs, which is never as beneficial for the opponent as the missing part."
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  atkTime+=1
  if ceilingAtk=0
  {
    if oEnmity.specialAttack=0
    {
      if atkProg=0 //Find player
      {
        if y<oPlayer1.y-30 //Go down
        {
          y+=moveSpd
        }
        else if y>oPlayer1.y-22 //Go up
        {
          y-=moveSpd
        }

        if atkTime>=atkDelay-45 and atkTime<=atkDelay {image_index=1}
        else {image_index=0}

        if atkTime>=atkDelay and point_distance(x,0,oPlayer1.x,0)<260 and point_distance(0,y,0,oPlayer1.y-26)<12
        {
          atkTime=0
          atkProg+=1
        }
      }
      else if atkProg=1 //Form fist and get ready
      {
        if atkTime=1
        {
          var tEffect;
          tEffect=instance_create(x-(24*image_xscale),y,oEffect)
          tEffect.sprite_index=sMMchargeComplete; tEffect.image_speed=0.5
          tEffect.image_xscale=2; tEffect.image_yscale=2
          tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
          sprite_index=sEnmityHandB
          image_index=0
        }
        else if atkTime>=41 and atkTime<=70
        {
          if atkTime=41 {playSound(global.snd_ChargeStrike,0,0.94,1)}
          if atkTime mod 4=0 {playSound(global.snd_Bobomb,0,0.9,1)}
          var tEffect;
          tEffect=instance_create(x-((8+random(8))*image_xscale),y-18+random(36),oEffect)
          tEffect.sprite_index=sSamusSMissileHit
          tEffect.image_speed=0.5
          tEffect.image_xscale=0.7; tEffect.image_yscale=0.7
          tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0

          if image_xscale=1 {x-=12}
          else {x+=12}
        }
        else if atkTime>=90 {atkProg+=1; atkTime=0}
      }
    }

    if atkProg=2 //Return
    {
      if atkTime=1 {sprite_index=sEnmityHandA}
      else if atkTime>=2 and atkTime<=400
      {
        if image_xscale=1
        {
          x+=4
          if x>=oEnmity.x+oEnmity.roomSpan {x=oEnmity.x+oEnmity.roomSpan; atkTime=400}
        }
        else
        {
          x-=4
          if x<=oEnmity.x-oEnmity.roomSpan {x=oEnmity.x-oEnmity.roomSpan; atkTime=400}
        }
      }
      else if atkTime>=410
      {
        atkProg=0
        atkTime=0
        ceilingAtk=1
      }
    }
  }
  else if ceilingAtk>=1
  {
    if oEnmity.specialAttack=0
    {
      if atkProg=0 //Go up wall
      {
        y-=moveSpd*2
        if y<=32
        {
          y=32
          if image_xscale=1 {image_angle=90}
          else {image_angle=270}
          atkTime=0
          atkProg+=1
        }
      }
      else if atkProg=1 //Find player
      {
        if x<oPlayer1.x-4 //Go right
        {
          x+=4
        }
        else if x>oPlayer1.x+4 //Go left
        {
          x-=4
        }

        if atkTime>=45 and point_distance(x,0,oPlayer1.x,0)<12
        {
          atkTime=0
          atkProg+=1
        }
      }
      else if atkProg=2 //Form fist and get ready
      {
        if atkTime=1
        {
          var tEffect;
          tEffect=instance_create(x,y-(24*image_xscale),oEffect)
          tEffect.sprite_index=sMMchargeComplete; tEffect.image_speed=0.5
          tEffect.image_xscale=2; tEffect.image_yscale=2
          tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
          sprite_index=sEnmityHandB
        }
        else if atkTime>=41 and atkTime<=90
        {
          var tEffect;
          tEffect=instance_create(x-18+random(36),y-((8+random(8))*image_xscale),oEffect)
          tEffect.sprite_index=sSamusSMissileHit
          tEffect.image_speed=0.5; tEffect.image_xscale=0.7; tEffect.image_yscale=0.7
          tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0

          y+=16
          if y>=288
          {
            y=288
            atkTime=100
          }
        }
        else if atkTime>=110 {atkProg+=1; atkTime=0}
      }
    }

    if atkProg=3 //Return
    {
      if atkTime=1 {sprite_index=sEnmityHandA}
      else if atkTime>=2 and atkTime<=100
      {
        y-=8
        if y<=32
        {
          y=32
          atkTime=100
        }
      }
      else if atkTime>=110
      {
        atkTime=0
        ceilingAtk+=1
        if ceilingAtk=3 {atkProg+=1}
        else {atkProg=1}
      }
    }
    else if atkProg=4 //To sides
    {
      if atkTime=1 {sprite_index=sEnmityHandA; image_angle=0}
      else if atkTime>=2 and atkTime<=400
      {
        if image_xscale=1
        {
          x+=4
          if x>=oEnmity.x+oEnmity.roomSpan {x=oEnmity.x+oEnmity.roomSpan; atkTime=400}
        }
        else
        {
          x-=4
          if x<=oEnmity.x-oEnmity.roomSpan {x=oEnmity.x-oEnmity.roomSpan; atkTime=400}
        }
      }
      else if atkTime>=410
      {
        atkTime=0
        ceilingAtk=0
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
event_inherited()
