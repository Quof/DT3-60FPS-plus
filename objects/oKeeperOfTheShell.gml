#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0

//Enemy base statistics
eName="Keeper of the Shell"
eLevel=32
maxLife=400
life=maxLife
pointWorth=35
atkPower=8
for(i=0;i<6;i+=1)
{
  resType[i]=1
}
stunResist=7
baseItemChance=75
moneyWorth=5

throwTime=15
throwDelay=45
throwNum=0

jeremyText="Here's a weird one. While inside its shell, it's completely invulnerable to all damage due to it being made of Unobtainium apparently. When it opens the shell, it will throw coconuts or something at you, while doing this, it leaves itself open for attack."
chaoText="There are some really strange things out here. First the buggy and creepy penguins and now these weird guys... or girls."
devText="When putting the ice crystals that create platforms into the game, couldn't find the platform sprite ripped anywhere and for some reason none of the screenshots showed them. So instead I recreated the platform sprite. It wasn't until after this that I found a screenshot with one present. I decided to go with mine instead though because I liked it enough... and because I made it."
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
    if x<oPlayer1.x {image_xscale=1}
    else {image_xscale=-1}

    //Fire at player
    throwTime+=1
    if throwTime=throwDelay
    {
      for(i=0;i<6;i+=1)
      {
        resType[i]=3
      }
      image_index=1
    }
    else if throwTime=throwDelay+10 {image_index=2}
    else if throwTime=throwDelay+15
    {
      image_index=3
      //Check distance to player
      xThrow=point_distance(x,0,oPlayer1.x,0)/48
      if xThrow>8 {xThrow=8}
      else if xThrow<0.75 {xThrow=0.75}
      tNewAttack=instance_create(x-(16*image_xscale),y-14,oGravBulletAlt)
      tNewAttack.sprite_index=sKotS_Nut; tNewAttack.atkPower=atkPower; tNewAttack.bExplode=0
      tNewAttack.xVel=xThrow*image_xscale; tNewAttack.yVel=-8
      tNewAttack.xGrav=0; tNewAttack.yGrav=0.3-(throwNum/25)
    }
    else if throwTime=throwDelay+19
    {
      throwNum+=1
      if throwNum>=5 {image_index=1}
      else {throwTime=throwDelay+9}
    }
    else if throwTime>=throwDelay+25
    {
      for(i=0;i<6;i+=1)
      {
        resType[i]=1
      }
      image_index=0
      throwNum=0
      throwTime=0
    }
  }
  enemyStepEvent()
}
