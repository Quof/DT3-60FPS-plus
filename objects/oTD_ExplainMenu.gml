#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
menuSizeX=160
menuSizeY=138

curInc=13
curPos=1
curMax=10
curY=10
bCanMoveCursor=1
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if bCanMoveCursor=1
{
  if oKeyCodes.kCodePressed[3]=1
  {
    playSound(global.snd_MenuCursor,0,1,1)
    if curPos=1
    {
      curPos=curMax
      curY+=curInc*(curMax-1)
    }
    else
    {
      curPos-=1
      curY-=curInc
    }
  }
  else if oKeyCodes.kCodePressed[4]=1
  {
    playSound(global.snd_MenuCursor,0,1,1)
    if curPos=curMax
    {
      curPos=1
      curY-=curInc*(curMax-1)
    }
    else
    {
      curPos+=1
      curY+=curInc
    }
  }
  if oKeyCodes.kCodePressed[5]=1
  {
    if curPos=1
    {
      resetKeyCodes()
      global.gamePaused=false
      if type=1
      {
        oEvTowerDefense.explainMenu=1
        oEvTowerDefense.sceneProgress=0
      }
      instance_destroy()
    }
    else
    {
      bCanMoveCursor=0; sceneProgress=1
    }
  }
}
else
{
  if curPos=2 //Controls
  {
    if sceneProgress=0 {bCanMoveCursor=0; sceneProgress=1}
    else if sceneProgress=1 and bWaitForInput=false
      msgCreate(0,0,"John","I've given you access to a new Ability Set called 'Defender', which you can now swap over to. With this, you can deploy and upgrade turrets, and select the turret you want to deploy.",6,3,oMessageCutscene,1)
    else if sceneProgress=2 and bWaitForInput=false
      msgCreate(0,0,"John","[Action A]: Deploy currently selected turret.#[Action B]: Select next turret in list.#[Action C]: Select previous turret in list.#[Up+Action C]: Deconstruct nearby turret.",6,3,oMessageCutscene,1)
    else if sceneProgress=3 and bWaitForInput=false
      msgCreate(0,0,"John","Hold [Down] for 1 second (and keep holding [Down]) to cause all turrets and enemies to play out 2x faster. Performing any action, such as firing will cancel the 2x effect.",6,3,oMessageCutscene,1)
    else if sceneProgress=4 and bWaitForInput=false
      msgCreate(0,0,"Jerry","That sounds like a lot already and there's still 8 more menu selections to go through. I never did like these strategy tower rts real time shooter strategy games.",0,3,oMessageCutscene,1)
    else if sceneProgress=5 and bWaitForInput=false
      msgCreate(0,0,"Claire","If you're gonna hate, at least hate properly.",0,3,oMessageCutscene,1)
    else if sceneProgress=6 and bWaitForInput=false
      msgCreate(0,0,"John","Note that if you're using the [Hold+Direction] swap type controls, switching to the 'Defender' set is done with your [Character Swap] button.",6,3,oMessageCutscene,1)
    else if sceneProgress=7 {sceneProgress=0; bCanMoveCursor=1}
  }
  else if curPos=3 //Basic Rules
  {
    if sceneProgress=0 {bCanMoveCursor=0; sceneProgress=1}
    else if sceneProgress=1 and bWaitForInput=false
      msgCreate(0,0,"John","Your base, the flag, is what you need to protect. After every wave, you can see the countdown till the next wave. Survey the field to see where the enemy portals are located.",6,3,oMessageCutscene,1)
    else if sceneProgress=2 and bWaitForInput=false
      msgCreate(0,0,"John","The number displayed on the portal is how many enemies will come out of it. If you're ready for a new wave before the countdown is over, hold [Down] to cause the countdown to reduce 10x faster.",6,3,oMessageCutscene,1)
    else if sceneProgress=3 and bWaitForInput=false
      msgCreate(0,0,"John","If an enemy reaches your base, it will explode on it and reduce its Stability. If Stability reaches 0, they destroy the protections on the city and it's Game Over for us.",6,3,oMessageCutscene,1)
    else if sceneProgress=4 and bWaitForInput=false
      msgCreate(0,0,"John","If you need to recover stability, the icon above the flag can be used with [Action A] while Defender is active. You win this by defeating all enemy waves. Resources are earned from all enemy kills.",6,3,oMessageCutscene,1)
    else if sceneProgress=5 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Okay so just kill everything, that's easy enough.",0,3,oMessageCutscene,1)
    else if sceneProgress=6 and bWaitForInput=false
      msgCreate(0,0,"Claire","Jerry, don't use the word, kill. It isn't kid friendly.",0,3,oMessageCutscene,1)
    else if sceneProgress=7 and bWaitForInput=false
      msgCreate(0,0,"Jerry","I have nothing, Claire. So you know what? Your face isn't kid friendly.",0,3,oMessageCutscene,1)
    else if sceneProgress=8 and bWaitForInput=false
      msgCreate(0,0,"Claire","Elegant as always.",0,3,oMessageCutscene,1)
    else if sceneProgress=9 {sceneProgress=0; bCanMoveCursor=1}
  }
  else if curPos=4 //Deploy Turrets
  {
    if sceneProgress=0 {bCanMoveCursor=0; sceneProgress=1}
    else if sceneProgress=1 and bWaitForInput=false
      msgCreate(0,0,"John","With the Defender set active, you will deploy the currently selected turret in the list. By standing close enough to the deployed turret, you can view info about it as well as upgrade it.",6,3,oMessageCutscene,1)
    else if sceneProgress=2 and bWaitForInput=false
      msgCreate(0,0,"John","Note that you cannot deploy turrets too close together or too close to the base flag. Your new HUD element will display when you can deploy a turret.",6,3,oMessageCutscene,1)
    else if sceneProgress=3 and bWaitForInput=false
      msgCreate(0,0,"John","On deconstructing, you press [Up+Action C] to deconstruct a nearby turret. You will get 75% of your resources back that you spent on that turret, including resources spent on upgrading it.",6,3,oMessageCutscene,1)
    else if sceneProgress=4 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Hey look, deconstructing, a feature that maybe one person, ever, will use.",0,3,oMessageCutscene,1)
    else if sceneProgress=5 and bWaitForInput=false
      msgCreate(0,0,"Claire","Yeah, sounds about right.",0,3,oMessageCutscene,1)
    else if sceneProgress=6 {sceneProgress=0; bCanMoveCursor=1}
  }
  else if curPos=5 //Upgrade Turrets
  {
    if sceneProgress=0 {bCanMoveCursor=0; sceneProgress=1}
    else if sceneProgress=1 and bWaitForInput=false
      msgCreate(0,0,"John","If you're standing next to a turret, you can upgrade it if you have enough resources with [Action A] when Defender is active. Upgrading a turret will improve both its damage per shot and fire rate, which is displayed in 'Shots per second'.",6,3,oMessageCutscene,1)
    else if sceneProgress=2 and bWaitForInput=false
      msgCreate(0,0,"John","Some turrets have other attributes improved on upgrading as well. You may notice an effect on the turrets when either of you are close to them. You and your idle partner give all nearby turrets a 15% boost to Fire Rate.",6,3,oMessageCutscene,1)
    else if sceneProgress=3 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Benefactors to our own cause! Yay!",0,3,oMessageCutscene,1)
    else if sceneProgress=4 and bWaitForInput=false
      msgCreate(0,0,"Claire","Which means don't run off somewhere useless, Jerry.",0,3,oMessageCutscene,1)
    else if sceneProgress=5 {sceneProgress=0; bCanMoveCursor=1}
  }
  else if curPos=6 //Weapon: GROUND
  {
    if sceneProgress=0 {bCanMoveCursor=0; sceneProgress=1}
    else if sceneProgress=1 and bWaitForInput=false
      msgCreate(0,0,"John","The [GROUND] turret can only be placed on the ground and will only fire straight in the direction it was deployed. (Your facing direction.) It has exceptional damage output though. These will not fire at flying enemies.",6,3,oMessageCutscene,1)
    else if sceneProgress=2 and bWaitForInput=false
      msgCreate(0,0,"Jerry","For those playing at home, these are the most basic, boring, and therefore, most useful of all turrets. Wait wait wait, these are turrets, not towers, so it's turret defense?",0,3,oMessageCutscene,1)
    else if sceneProgress=3 and bWaitForInput=false
      msgCreate(0,0,"Claire","Same damn thing, Jerry... sorta.",0,3,oMessageCutscene,1)
    else if sceneProgress=4 {sceneProgress=0; bCanMoveCursor=1}
  }
  else if curPos=7 //Weapon: FLOAT
  {
    if sceneProgress=0 {bCanMoveCursor=0; sceneProgress=1}
    else if sceneProgress=1 and bWaitForInput=false
      msgCreate(0,0,"John","The [FLOAT] turret can be placed anywhere and will fire in any direction at the closest enemy. Its damage output isn't super great, but it makes up for that in versatility and it fires through walls.",6,3,oMessageCutscene,1)
    else if sceneProgress=2 and bWaitForInput=false
      msgCreate(0,0,"Jerry","So in a platforming game, these are the most useful when enemy units have to zig-zag.#-Me 20XX",0,3,oMessageCutscene,1)
    else if sceneProgress=3 and bWaitForInput=false
      msgCreate(0,0,"Claire","How would that be received past the year 2099?",0,3,oMessageCutscene,1)
    else if sceneProgress=4 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Will this still be around that long? I mean, even the creator won't be around for that.",0,3,oMessageCutscene,1)
    else if sceneProgress=5 and bWaitForInput=false
      msgCreate(0,0,"Claire","How deep do you wanna go with this?",0,3,oMessageCutscene,1)
    else if sceneProgress=6 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Right here is as comfortable as I can be with this.",0,3,oMessageCutscene,1)
    else if sceneProgress=7 {sceneProgress=0; bCanMoveCursor=1}
  }
  else if curPos=8 //Weapon: AIR
  {
    if sceneProgress=0 {bCanMoveCursor=0; sceneProgress=1}
    else if sceneProgress=1 and bWaitForInput=false
      msgCreate(0,0,"John","The [AIR] turret can only be placed on the ground and will only fire at air targets. It does bonus damage to air targets and fires through walls.",6,3,oMessageCutscene,1)
    else if sceneProgress=2 and bWaitForInput=false
      msgCreate(0,0,"John","These are sometimes best placed at a low elevation due to their limited range of motion. I recommend placing them on the ground and not on elevated platforms. Upgrading also slightly increases that range of motion.",6,3,oMessageCutscene,1)
    else if sceneProgress=3 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Dr. John here recommends placing them on the ground. Let me wave my elbows back and forth while I tell you how to play.",0,3,oMessageCutscene,1)
    else if sceneProgress=4 and bWaitForInput=false
      msgCreate(0,0,"John","Ouch, man. Just ouch.",6,3,oMessageCutscene,1)
    else if sceneProgress=5 and bWaitForInput=false
      msgCreate(0,0,"Claire","He's an ass sometimes, ignore him.",0,3,oMessageCutscene,1)
    else if sceneProgress=6 {sceneProgress=0; bCanMoveCursor=1}
  }
  else if curPos=9 //Weapon: SHOCK
  {
    if sceneProgress=0 {bCanMoveCursor=0; sceneProgress=1}
    else if sceneProgress=1 and bWaitForInput=false
      msgCreate(0,0,"John","The [SHOCK] turret can be placed anywhere and has extremely low damage output. However, it can damage all enemies around it and it will slow them down by 33% for 10 seconds.",6,3,oMessageCutscene,1)
    else if sceneProgress=2 and bWaitForInput=false
      msgCreate(0,0,"John","Upgrading also increases the shock radius by 30% and slow duration by 1 second per level. Don't overlook their utility.",6,3,oMessageCutscene,1)
    else if sceneProgress=3 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Debuffs in my action game!! What is this!?",0,3,oMessageCutscene,1)
    else if sceneProgress=4 and bWaitForInput=false
      msgCreate(0,0,"Claire","That's not THAT uncommon, Jerry.",0,3,oMessageCutscene,1)
    else if sceneProgress=5 {sceneProgress=0; bCanMoveCursor=1}
  }
  else if curPos=10 //Weapon: MEGA
  {
    if sceneProgress=0 {bCanMoveCursor=0; sceneProgress=1}
    else if sceneProgress=1 and bWaitForInput=false
      msgCreate(0,0,"John","The [MEGA] turret can only be placed on the ground and will fire a rocket up into the air. Afterward it will target a nearby enemy and will explode on contact with one.",6,3,oMessageCutscene,1)
    else if sceneProgress=2 and bWaitForInput=false
      msgCreate(0,0,"John","The explosion deals high damage and has an area of effect. The missiles travel through walls. Upgrading increases the explosion radius as well.",6,3,oMessageCutscene,1)
    else if sceneProgress=3 and bWaitForInput=false
      msgCreate(0,0,"John","In older versions of this game, these would sometimes cause enemies to become invulnerable. What a weird bug.",6,3,oMessageCutscene,1)
    else if sceneProgress=4 and bWaitForInput=false
      msgCreate(0,0,"Jerry","I can't tell if you mean this game we're in, as in the one WE'RE in, or the one they're in and playing, or playing us, or... Okay, I'm just gonna stop breaking the walls of the fourth.",0,3,oMessageCutscene,1)
    else if sceneProgress=5 and bWaitForInput=false
      msgCreate(0,0,"Claire","Walls of the fourth, Jerry? Really?!",0,3,oMessageCutscene,1)
    else if sceneProgress=6 {sceneProgress=0; bCanMoveCursor=1}
  }
}

keyWaitForInput()
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
myWinX=view_xview[0]+172
myWinY=view_yview[0]+124

draw_set_alpha(1)
draw_set_color(make_color_rgb(0,104,32))
draw_rectangle(myWinX,myWinY,myWinX+menuSizeX,myWinY+menuSizeY,0)
draw_set_color(make_color_rgb(0,104,32))
draw_rectangle(myWinX+1,myWinY+1,myWinX+menuSizeX-1,myWinY+menuSizeY-1,1)
draw_set_color(make_color_rgb(0,37,12))
draw_rectangle(myWinX,myWinY,myWinX+menuSizeX,myWinY+menuSizeY,1)

draw_set_font(fnt_EnemyName)
draw_set_halign(fa_left)
textDropShadow("[Get to the game!]",myWinX+14,myWinY+3,make_color_rgb(255,248,155),make_color_rgb(16,8,8),1)
textDropShadow("Controls",myWinX+14,myWinY+16,make_color_rgb(255,248,155),make_color_rgb(16,8,8),1)
textDropShadow("Basic Rules",myWinX+14,myWinY+29,make_color_rgb(255,248,155),make_color_rgb(16,8,8),1)
textDropShadow("Deploying/Deconstructing",myWinX+14,myWinY+42,make_color_rgb(255,248,155),make_color_rgb(16,8,8),1)
textDropShadow("Upgrading Turrets",myWinX+14,myWinY+55,make_color_rgb(255,248,155),make_color_rgb(16,8,8),1)
textDropShadow("Weapon: GROUND",myWinX+14,myWinY+68,make_color_rgb(255,248,155),make_color_rgb(16,8,8),1)
textDropShadow("Weapon: FLOAT",myWinX+14,myWinY+81,make_color_rgb(255,248,155),make_color_rgb(16,8,8),1)
textDropShadow("Weapon: AIR",myWinX+14,myWinY+94,make_color_rgb(255,248,155),make_color_rgb(16,8,8),1)
textDropShadow("Weapon: SHOCK",myWinX+14,myWinY+107,make_color_rgb(255,248,155),make_color_rgb(16,8,8),1)
textDropShadow("Weapon: MEGA",myWinX+14,myWinY+120,make_color_rgb(255,248,155),make_color_rgb(16,8,8),1)

draw_sprite(sPauseM_AbilArrow,0,myWinX+11,myWinY+curY)
