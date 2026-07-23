#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
bCanDealDamage=0
image_speed=0.25

//Enemy base statistics
eName="CHAOS Healer"
eLevel=36
maxLife=650
life=maxLife
pointWorth=95
atkPower=7
stunResist=50
baseItemChance=65
moneyWorth=10
affiliation=7
dieSound=0
dieEffect=0

waitTime=0
myTarget=noone
bIsHealing=0
targetTime=0
hoverNoTgt=1
tgtToUse=0
circlePlayer=0

deathAnim=0

jeremyText="Oh what...? This thing can heal any CHAOS unit, excluding itself and other support units. Though it does have a slow self-repair function. This things behavior isn't straight forward. It tends to prioritize nearby allies that have low HP%, but I'm noticing it may quickly rush to help certain allies that you engage."
chaoText="I found out something else annoying about this bot. It has an automatic self-repair function. It's only 6/sec, but over time that adds up. What do you think is the most important target?"
devText="Originally there was going to be a group of four bots all assisting one another, but this idea was changed to be more general. The big thing that changed was this bot. Originally, it could shield and heal allies, but this function was broken up into two enemy types instead. It can also assist any CHAOS unit and not just those within its group."
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if bActive=0 {makeEnemyActive(1)}
  if life>0
  {
    if bActive=true and stunnedTime=0
    {
      if myTarget=noone and instance_number(oCHAOS_Assault)>0 and waitTime=0 //Find ally with lowest HP%
      {
        targetTime=0
        event_user(0)
        speed=0
      }
      if waitTime>0 {waitTime-=1}

      if instance_exists(myTarget) //---------- Has valid target ----------
      {
        //Keep target between self and player
        tgtToUse=myTarget
        event_user(1)
        if targetDist>4 {speed=4}
        else {speed=0}

        if targetDist<160 //Check distance to target
        {
          if myTarget.life<myTarget.maxLife {bIsHealing=1}
          else {bIsHealing=0}
        }
        else {bIsHealing=0}

        if bIsHealing=1 //Heal target
        {
          if myTarget.life<myTarget.maxLife
          {
            if myTarget.life>0 {myTarget.life+=3}
            if myTarget.life>myTarget.maxLife {myTarget.life=myTarget.maxLife}
          }
        }
        if myTarget.lifePercent>=1 {myTarget=noone} //Check for new target if current target has full HP
        targetTime+=1
        if targetTime>=150 {myTarget=noone} //Check for new target after short time
      }
      else //---------- No healing target ----------
      {
        myTarget=noone; bIsHealing=0
        if instance_exists(oCHAOS_Assault)
        {
          chkClosest=instance_nearest(x,y,oCHAOS_Assault)
          if point_distance(x,y,chkClosest.x,chkClosest.y)<=432
          {
            hoverNoTgt=0
          }
          else {hoverNoTgt=1}
        }
        else
        {
          waitTime=15
          hoverNoTgt=1
        }

        if hoverNoTgt=0 //---------- Stay close to closest ally ----------
        {
          tgtToUse=chkClosest
          event_user(1)
          if targetDist>3 {speed=3}
          else {speed=0}
        }
        else //---------- Hover around player with no target ----------
        {
          //Find point x/y
          var tDirToPlayer;
          tDirToPlayer=point_direction(x,y,oPlayer1.x+lengthdir_x(100,circlePlayer),returnPlayerYCenter()+lengthdir_y(100,circlePlayer))
          circlePlayer+=2
          direction=tDirToPlayer
          speed=3.5
        }
      }

      if life<maxLife and oGame.time mod 5=0 {life+=1} //Auto-recover HP
    }
    else {speed=0}
  }
  else if life<=0
  {
    deathAnim+=1
    if deathAnim=1
    {
      playSound(global.snd_HardHit1,0,0.9,1)
      speed=0
      baseColor=c_red; image_blend=c_red
    }

    if deathAnim mod 4=0
    {
      tEffect=instance_create(x+random_range(-14,14),y+random_range(-14,14),oEffect)
      tEffect.sprite_index=sDeathFlameA; tEffect.image_speed=0.33
      tEffect.image_xscale=2; tEffect.image_yscale=2; tEffect.image_alpha=0.8
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }

    image_alpha-=0.03
    if image_alpha<0 {instance_destroy()}
  }
  enemyStepEvent()
}
else {speed=0}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/*
var i,tChkIns,tIdFind,tLowHP;
tIdFind=-1
tLowHP=1
for(i=0;i<instance_number(oCHAOS_Assault);i+=1)
{
  tChkIns[i]=instance_find(oCHAOS_Assault,i) //Check for all CHAOS enemies
  if tChkIns[i].lifePercent<tLowHP //Is HP lower than previous
  {
    tIdFind=tChkIns[i] //Set to idFind if lowest HP
    tLowHP=tChkIns[i].lifePercent //Drop Threshold
    show_debug_message(string("ID FOUND: ") +string(tIdFind))
  }
}
if myTarget=-1 {waitTime=30}
myTarget=tIdFind
*/

myMap=ds_map_create() //Create map
var i,tChkIns,tFindKey,tKeyPrev,tAllyID,tAllyNum,tAllyMax;
tAllyNum=0
tAllyMax=instance_number(oCHAOS_Assault) //Find number of CHAOS enemies
for(i=0;i<tAllyMax;i+=1)
{
  tChkIns=instance_find(oCHAOS_Assault,i) //Check for all CHAOS enemies
  ds_map_add(myMap,tChkIns.lifePercent,tChkIns.id) //Create HP%,allyID list
}

tAllyMax=ds_map_size(myMap) //Find map size for loop restriction
for(i=0;i<tAllyMax;i+=1)
{
  if i=0 //Find lowest HP% (First pass)
  {
    tFindKey=ds_map_find_first(myMap)
    tKeyPrev=ds_map_find_first(myMap)
  }
  else
  {
    tFindKey=ds_map_find_next(myMap,tKeyPrev) //Find next available target
    tKeyPrev=tFindKey //Set previous to current
  }
  tAllyID=ds_map_find_value(myMap,tFindKey) //Find tAllyID based on lowest HP%
  if tAllyID!=0 //Be sure ID exists
  {
    if point_distance(x,y,tAllyID.x,tAllyID.y)<=544 and tAllyID.lifePercent<1 //Be sure ally is within range and has less than 100% HP
    {
      myTarget=tAllyID //Set healing target
    }
  }
  tAllyNum+=1
}

if tAllyNum>=tAllyMax //Nothing is found, wait before the next search
{
  ds_map_destroy(myMap)
  waitTime=15
}
#define Other_11
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var tMyAngle;
if tgtToUse.x<oPlayer1.x
{
  if bIsHealing=1 {tMyAngle=80}
  else {tMyAngle=180}
}
else
{
  if bIsHealing=1 {tMyAngle=-80}
  else {tMyAngle=180}
}

tarDirToPlayer=point_direction(tgtToUse.x,tgtToUse.y,oPlayer1.x,returnPlayerYCenter())+tMyAngle //Find direction to point
tarDistToPlayer=208-point_distance(tgtToUse.x,tgtToUse.y,oPlayer1.x,returnPlayerYCenter()) //Find distance to point
if tarDistToPlayer<56 {tarDistToPlayer=56} //Min dist
//Find point x/y
myPointX=tgtToUse.x+lengthdir_x(tarDistToPlayer,tarDirToPlayer)
myPointY=tgtToUse.y+lengthdir_y(tarDistToPlayer,tarDirToPlayer)
//Go to point
direction=point_direction(x,y,myPointX,myPointY)
targetDist=point_distance(x,y,myPointX,myPointY)
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if instance_exists(myTarget)
{
  if bIsHealing=1
  {
    draw_set_alpha(1)
    draw_set_color(c_teal)
    draw_line_width(x,y,myTarget.bbox_left+abs(myTarget.sprite_width)/2,myTarget.bbox_top+abs(myTarget.sprite_height)/2,3)
  }
}
event_inherited()

/*
draw_set_color(c_white)
draw_set_alpha(1)
draw_set_font(fnt_EnemyName)
draw_set_halign(fa_left)
draw_text(view_xview[0]+16,view_yview[0]+96,string("Key(HP%)  - ") +string(tFindKey))
draw_text(view_xview[0]+16,view_yview[0]+112,string("Value(ID) - ") +string(tFindID))
