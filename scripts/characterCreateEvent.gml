/*
This script should be placed in the "Create Event" of the character.
It sets the variables needed for character.

You can edit the "user variables" if you don't want to use the default values.  

This script sets the collision bounds using this code: setCollisionBounds(-5,-1,5,15)
You can modify the arguments to make a collsion bounds that fits your own sprites.
If you are just going to use the default sprites, there is no reason to edit
the arguments.
*/

gameControl=instance_create(0,0,oGame) //game control
identifier=instance_create(mouse_x,mouse_y,oIdentifier) //follow mouse target
HUD=instance_create(0,0,oHUD)
//Constant states that the platform character may be (don't edit)
STANDING=10
RUNNING=11
DUCKING=12
LOOKING_UP=13
CLIMBING=14
JUMPING=15
FALLING=16
DYING=17
LEFT=18
RIGHT=19
ON_GROUND=20
IN_AIR=21
ON_LADDER=22

//Constant attack states the character may be (don't edit)
attackState=0 //The attack type the character is performing

//Constant action(attack) states
ACT_ATK=31
ACT_FIRE=32
ACT_FIRE_UP=33
ACT_FIRE_DOWN=34
BUSTER_STAND=35
BUSTER_STAND_UP=36
BUSTER_RUN=37
BUSTER_RUN_UP=38
BUSTER_JUMP=39
BUSTER_JUMP_UP=40
BUSTER_JUMP_DOWN=41
BUSTER_DUCK=42
ACT_MORPHBALL=43
ACT_IN_CANNON=44
ACT_IN_BIKE=45
ACT_BIRD_CALL=46
ACT_BLOCK=47
ACT_HIDE=48
ACT_ON_YOSHI=49

//The keys that the platform character will use (don't edit)
kLeft=0
kRight=0
kUp=0
kDown=0

kLeftPressed=0
kRightPressed=0
kUpPressed=0
kDownPressed=0

kJump=0
kJumpPressed=0
if global.optGamePad=1
{
  if scrController(5)
  {
    kJump=1
    kJumpPressed=1
  }
}

kCharSwap=0
kCharSwapPressed=0
kAbilSwap=0
kAbilSwapPressed=0

kActA=0
kActAPressed=0
kActB=0
kActBPressed=0
kActC=0
kActCPressed=0

kDashLeft=0
kDashLeftPressed=0
kDashRight=0
kDashRightPressed=0

kLeftPushedSteps=0
kRightPushedSteps=0
kUpPushedSteps=0
kDownPushedSteps=0
kRun=0

//User variables (you can edit these)
player=1                   //player number (player 2 uses different keyboard keys than player 1)
state=FALLING              //the character state, must be one of the following: STANDING, RUNNING, DUCKING, LOOKING_UP, CLIMBING, JUMPING, or FALLING
facing=RIGHT               //which direction the character is facing, must be either LEFT or RIGHT
if global.activeCharacter=0  //the running acceleration
  runAcc=6.6
else if global.activeCharacter=1
  runAcc=7.3
else if global.activeCharacter=2
  runAcc=4.5
else if global.activeCharacter=4
  runAcc=7.7
else
  runAcc=6.6
grav=1.2                   //the gravity
if global.activeCharacter=0 or global.activeCharacter=1
{
  initialJumpAcc=-7.1      //relates to how high the character will jump
  jumpTimeTotal=21         //how long the user must hold the jump button to get the maximum jump height
}
else if global.activeCharacter=2
{
  initialJumpAcc=-7        //relates to how high the character will jump
  jumpTimeTotal=60         //how long the user must hold the jump button to get the maximum jump height
}
else if global.activeCharacter=4
{
  mask_index=sJF_HitBox
  initialJumpAcc=-7.6
  jumpTimeTotal=22
}
else
{
  initialJumpAcc=-7.1
  jumpTimeTotal=21
}
doubleJumpAcc=-6.1         //relates to how high the character will jump from a double jump
climbAcc=0.8               //how fast the character will climb
runAnimSpeed=0.045         //relates to how fast the running animation should go
climbAnimSpeed=0.1         //relates to how fast the climbing animation should go
departLadderXVel=4         //how fast character should be moving horizontally when he leaves the ladder
departLadderYVel=-4        //how fast the character should be moving vertically when he leaves the ladder
maxSlope=4                 //approximately how many pixels the character can climb UPWARDS per step (a value of 5 means the character can climb up a slope of 5)
maxDownSlope=8             //approximately how many pixels the character can climb DOWNWARDS per step (a value of 5 means the character can climb down a slope of 5)
canRun=0                   //when the user presses the shift button, should the character be allowed to run?
canFly=0                   //whether the character can do a fly jump when running at full speed
canFlyJump=0               //whether the character can do continuous fly jumps (mid-air)
flyMaxJumps=5              //the maximum number of jumps the character can perform while flying
frictionAirX=0.82          //friction obtained while in the air while no keys are pressed
frictionRunningX=0.5       //friction obtained while running
frictionRunningFastX=0.98  //friction obtained while holding the shift button for some time while running
frictionClimbingX=0.5      //friction obtained while climbing
frictionClimbingY=0.8      //friction obtained while climbing
if global.activeCharacter=0  //friction obtained while ducking
  frictionDuckingX=0.87
else if global.activeCharacter=1
  frictionDuckingX=0.9
else if global.activeCharacter=2 or global.activeCharacter=4
  frictionDuckingX=0.5
else
  frictionDuckingX=0.87
frictionFlyingX=0.98       //friction obtained while "flying"
frictionWaterXRun=0.41     //friction obtained while running underwater
frictionWaterXDuck=0.62    //friction obtained while ducking underwater
frictionWaterYJump=0.93    //friction obtained while jumping underwater
frictionWaterYFall=0.78    //friction obtained while falling underwater
xVelLimit=16               //limits the xVel
yVelLimit=12               //limits the yVel
xAccLimit=10               //limits the xAcc
yAccLimit=10               //limits the yAcc
dashVel=14                 //the initial dash velocity
dashInvulnerability=9+global.skillTree[23]  //how long the character is invulnerable after dashing
idleAnimSpeed=0.1          //relates to how fast the idle animations should be
dashRecovery=24+(global.skillTree[22]*2)  //how much dash energy is recovered per frame

if global.activeCharacter=0
{
  for(i=0;i<3;i+=1)
    if global.equipJerry[i]=25
      dashRecovery+=4
}
else
{
  for(i=0;i<3;i+=1)
    if global.equipClaire[i]=25
      dashRecovery+=4
}
if room=rWarshipZ_E3 or room=rBT_WarmasterA
{
  if global.bBossGallery=0 {dashRecovery+=35}
  else {dashRecovery+=11}
}
atkSpdJerry=8 //11-global.skillTree[0]        //how many frames it takes to run through 1 melee attack for Jerry
atkSpdClaire=11 //14-global.skillTree[26]     //how many frames it takes to run through 1 melee attack for Claire

atkSpdJeremy=8 //how many frames it takes to run through 1 melee attack for Jeremy (Out of Mech)

//Sets the collision bounds to fit the default sprites (you can edit the arguments of the script)
setCollisionBounds(-7,-40,7,-1)

//Hidden variables (don't edit)
statePrev=state
statePrevPrev=statePrev
attackStatePrev=attackState
attackStatePrevPrev=attackStatePrev
gravityIntensity=grav      //this variable describes the current force due to gravity (this variable is altered for variable jumping)
jumpTime=jumpTimeTotal     //current time of the jump (0=start of jump, jumpTimeTotal=end of jump)
jumpButtonReleased=0       //whether the jump button was released. (Stops the user from pressing the jump button many times to get extra jumps)
ladderTimer=0              //relates to whether the character can climb a ladder
jumps=0
flySpeed=0                 //ranges between 0 and 100. When the flySpeed is approximately 100, the character can "fly"
flySpeedTimer=0
flyAccTimer=0
flyAcc2Timer=0
flyJumpsTimer=0
flyJumpWasPressed=0
dashMomentumTime=0         //holds the dash momentum for a bit
dashInvulnerabilityTime=0  //current time till character is no longer invulnerable from dashing
canAirDash=1               //whether the character can dash in the air
slowFallEffect=0           //amount of forced gravity on the character from show fall
slowFallTime=0             //amount of slow fall time
walljumpTime=0             //amount of time to disable left/right after a wall jump
wallGrabEffect=0           //time to replay the wall grab effect
bCanWallJump=0             //if the character can wall jump
bWallGrab=0                //if the character is wall grabbing
charSwapRecover=0          //time till the player can swap characters again
bubbleTime=irandom_range(10,70)  //time till a bubble appears underwater
moneyEarnedOnMap=0         //amount of money earned on a map - used for a record
busterPCheck=0             //X-Buster press check
busterLastShotTime=0       //time since last projectile was shot
specialLastShotTime=0      //time since last special shot on 2nd ability set for Claire
bikeAnimFrm=0              //animation on motor bike
bikeBoost=150              //if the bike can boost/time till/time of
bShowCharSwitchText=1      //set to show the character switch flavor text only once per map
bombJump=0                 //if the player can be given bomb boosting power (only when >0)
bombAcc=1.15               //extra jump acceleration given by the bomb boost
mobilityDisable=0          //disable double jump / air-dash for a short time after swapping characters during split party
dashRecHalt=0              //time that the dash does not recover after dashing
hatDisplayX=0              //xOffset for hats
hatDisplayY=0              //yOffset for hats
doubleTapTime=0            //Check for double tapping down to morph

grappleState=0             //the player grapple state with the Strike Chain
grappleID=0                //id of the grapple point being used
/*
-- 0: Not used
-- 1: Extending Strike Chain
-- 2: Player is being pulled toward grapple point
-- 3: Player is grappled to grapple point
*/

extForceX=0                //external force applied to xVel
extForceY=0                //external force applied to yVel

//Variables pertaining to attacking (don't edit)
global.hudLink_BombEn[0]=150 //resets Jerry's bomb time
recoverTime=17+global.skillTree[24] //time till character recovers from damage (unflinch)
global.hudSamus_Bombs[0]=0 //resets Samus' bombs
castRecovering=0           //current time till character recovers
hitCombo=0                 //current hits in combo
comboDamage=0              //total damage in a single combo
killChain=0                //current kills in chain
dashMeterMax=10000         //maximum points on dash meter
dashEnergy=dashMeterMax    //current dash energy available (2000 = 1 dash)
mechComboDamage=0          //total damage in a single combo in Jeremy's mech
tookHitAmount=0            //times character took damage in current room
groundDashRecovery=0       //continue momentum after a forward ground dash - Jerry only
backDashRecovery=0         //continue momentum after a back ground dash - Jerry only
airDashRecovery=0          //continue momentum after an airdash
claireBackDashRec=0        //used for controlling when the player can stop Claire's back dash momentum
idleTime=0                 //how long the character has not moved
blastOffRecoveryTime=0     //time till Blast Off can be used again
airDashDamage=0            //power built from air dashing
mmState=0                  //Mega Man shot state
busterAnimStay=0           //how long to stay in the buster anim
currentSpell=""            //the current spell being used
starmanTime=0              //how long the player is invincible due to using the Starman
atkAnimSpd=-1              //attack animation speed (changes)
attackCharge=0             //current built up power on chargable attacks
specAttackChargeA=0        //current built up power on special attack A
specAttackChargeB=0        //current built up power on special attack B
chargeMax=0                //max time an ability can be charged (Used for controlling the variable charge states of the X-Buster)
swapCheck=0                //1 frame offset before swapping the player object with the idle object
doubleJumpCheck=1          //if the character can double jump
doubleJumpAnim=0           //animation during double jump
lastGuardTime=30           //amount of time before guard was used last
arrowRecharge=0            //arrow recharge timer
missileRecharge=0          //missile recharge timer
arrowDelay=0               //added delay to arrow recharge
missileDelay=0             //added delay to missile recharge
blockForceTime=0           //forces the player in the block state for the parry frames
dashWarnSound=0            //if the dash warn sound can play
chargeShotsStored=0        //Mega Man charged shots stored on Nightmare mode (Max: 3)

footStepSound=0            //used to play the footstep sound with Jeremy's Mech
mechFireRate=0             //used to control Jeremy's Mech firerate
mechMaxFuel=25             //max fuel for Jeremy Mech
mechFuel=mechMaxFuel       //used for Jeremy's Mech fuel
bUseFuel=0                 //if Jeremy is using his Mech's fuel
mechBoostAcc=0.5           //Jeremy's Mech boost acceleration
mechShieldUses=2           //number of shield uses available to Jeremy's Mech
mechShieldRecover=0        //used for tracking the shield recovery
mechMissileUses=2          //number of missiles available to Jeremy's Mech
mechMissileRecover=0       //used for tracking missile recovery
mechLaserMax=240           //Max energy for Jeremy's mech laser
mechLaserEnergy=mechLaserMax //Jeremy's laser mech energy

dirPressIter=0             //Iterate through direction press array
jeremySpecMove=0           //Mark which special move Jeremy will perform
jeremyAct=0                //Jeremy's current attack (Out of Mech)
lastDirPress=0             //Counts down every time a directional key is pressed (for resetting button combo commands)
for(i=0;i<11;i+=1)
{
  myDirPress[i]=0
}
jeremySuperEnergy=global.jeremySuperEnergy //Current super energy (300=1 charge)
jeremySuperMax=3000                        //Max super energy (3 uses max from full charge)

//---------- Nightmare mode only ----------
swordWaveCheck=0           //Jerry's projectile sword attack
daggerSpamCheck=0          //Claire's dagger spam
powerBombCheck=0           //Claire's power bomb
//--------------------------------------------------

hopOnCount=0
jumpSound=0
weight=130

//Makes the object "active" (don't edit)
makeActive()
