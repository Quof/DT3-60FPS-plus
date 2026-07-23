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
curMax=7
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
      instance_destroy()
    }
    else
    {
      bCanMoveCursor=0; sceneProgress=1
    }
  }
  else if oKeyCodes.kCodePressed[6]=1
  {
    resetKeyCodes()
    global.gamePaused=false
    instance_destroy()
  }
}
else
{
  if curPos=2 //Controls
  {
    if sceneProgress=0 {bCanMoveCursor=0; sceneProgress=1}
    else if sceneProgress=1 and bWaitForInput=false
      msgCreate(0,0,"John",string("The [Arrow Keys] or [WASD] will move the Dragoon in the direction you would imagine that key would direct it.#[") +string(global.ctrlJump) +string("] will fire the current weapon."),6,3,oMessageCutscene,1)
    else if sceneProgress=2 and bWaitForInput=false
      msgCreate(0,0,"John",string("Holding [") +string(global.ctrlActA) +string("] will cause the Dragoon to move at half speed should you desire."),6,3,oMessageCutscene,1)
    else if sceneProgress=3 and bWaitForInput=false
      msgCreate(0,0,"John",string("Holding [") +string(global.ctrlActB) +string("] will cause the Dragoon to 'suck in' a weakened enemy. You'll be able to tell if an enemy is weakened by it turning a shade of red. An enemy is weakened when it is below 45% HP."),6,3,oMessageCutscene,1)
    else if sceneProgress=4 and bWaitForInput=false
      msgCreate(0,0,"John","Note that when an enemy is 'sucked in' your 'sucking' ability will be disabled for about 1 second.",6,3,oMessageCutscene,1)
    else if sceneProgress=5 and bWaitForInput=false
      msgCreate(0,0,"John",string("Press [") +string(global.ctrlCharSwap) +string("] to swap the current controller of the Dragoon. Jerry and Claire have the same control set up, however, each of them can store their own weapon. (More on this in 'Suck Ability'.)"),6,3,oMessageCutscene,1)
    else if sceneProgress=6 {sceneProgress=0; bCanMoveCursor=1}
  }
  else if curPos=3 //Basic Rules
  {
    if sceneProgress=0 {bCanMoveCursor=0; sceneProgress=1}
    else if sceneProgress=1 and bWaitForInput=false
      msgCreate(0,0,"John","The rules are simple. Don't get shot by enemy fire. All you need to do is get the Dragoon to the Warship, blasting your way through anything Hex throws at you... which will probably be a lot.",6,3,oMessageCutscene,1)
    else if sceneProgress=2 and bWaitForInput=false
      msgCreate(0,0,"John","The Dragoon does not have its own health system, so it will borrow that from your current hearts. You may be used to some sort of 'Bomb Ability' from other shooters. Sadly the Dragoon does not have that capability.",6,3,oMessageCutscene,1)
    else if sceneProgress=3 and bWaitForInput=false
      msgCreate(0,0,"John","Give the Dragoon a shot, I think you'll find it pretty simple to understand.",6,3,oMessageCutscene,1)
    else if sceneProgress=4 {sceneProgress=0; bCanMoveCursor=1}
  }
  else if curPos=4 //Suck Ability
  {
    if sceneProgress=0 {bCanMoveCursor=0; sceneProgress=1}
    else if sceneProgress=1 and bWaitForInput=false
      msgCreate(0,0,"John","The 'Suck Ability' is the ability Kirby transferred to you. When you 'suck in' a weakened enemy. That enemy's weapon (or at least a variation of it) will override the current weapon you are using. Both Jerry and Claire can store one weapon.",6,3,oMessageCutscene,1)
    else if sceneProgress=2 and bWaitForInput=false
      msgCreate(0,0,"John","I don't know if you guys played 'Contra 3', but it's exactly like that weapon setup. Oh right, when sucking in an enemy, it won't fire at you.",6,3,oMessageCutscene,1)
    else if sceneProgress=3 {sceneProgress=0; bCanMoveCursor=1}
  }
  else if curPos=5 //Weapons
  {
    if sceneProgress=0 {bCanMoveCursor=0; sceneProgress=1}
    else if sceneProgress=1 and bWaitForInput=false
      msgCreate(0,0,"John","The Standard Shot has a power of 10 and a fire rate of 6/sec. (DPS: 60) If I knew the stats of the abilities you'll find up there, I'd tell you. Either you or Chao could possibly look that up in their scan info.",6,3,oMessageCutscene,1)
    else if sceneProgress=2 and bWaitForInput=false
      msgCreate(0,0,"John","Speaking of other weapons. If you take damage 3 times, the current active character will lose their weapon and be brought back to the default Standard Shot.",6,3,oMessageCutscene,1)
    else if sceneProgress=3 and bWaitForInput=false
      msgCreate(0,0,"John","I'm guessing the program set Kirby to lose a copied ability after taking enough damage. Luckily there's 2 of you too.",6,3,oMessageCutscene,1)
    else if sceneProgress=4 {sceneProgress=0; bCanMoveCursor=1}
  }
  else if curPos=6 //Assists
  {
    if sceneProgress=0 {bCanMoveCursor=0; sceneProgress=1}
    else if sceneProgress=1 and bWaitForInput=false
      msgCreate(0,0,"John","These are obtained just like new weapons, except they are not a weapon. You can have up to 4 of these at a time and taking damage will remove the last one you got. It's a first in, last out type of deal.",6,3,oMessageCutscene,1)
    else if sceneProgress=2 and bWaitForInput=false
      msgCreate(0,0,"John","However, if you already have 4 of these, getting a new one will replace the first one you got, and so on. Eh... you'll understand when it happens.",6,3,oMessageCutscene,1)
    else if sceneProgress=3 {sceneProgress=0; bCanMoveCursor=1}
  }
  else if curPos=7 //Checkpoints
  {
    if sceneProgress=0 {bCanMoveCursor=0; sceneProgress=1}
    else if sceneProgress=1 and bWaitForInput=false
      msgCreate(0,0,"John","When you reach a checkpoint, that checkpoint is also a starting point for any time you return to the Dragoon. You can leave the Dragoon from the Game Over menu to return here.",6,3,oMessageCutscene,1)
    else if sceneProgress=2 and bWaitForInput=false
      msgCreate(0,0,"John","I'm sure Jeremy will figure out a way to set up a teleport from here to the Warship once you guys are up there. You just have to actually get there.",6,3,oMessageCutscene,1)
    else if sceneProgress=3 {sceneProgress=0; bCanMoveCursor=1}
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
textDropShadow("[Cool, I understand.]",myWinX+14,myWinY+3,make_color_rgb(255,248,155),make_color_rgb(16,8,8),1)
textDropShadow("Controls",myWinX+14,myWinY+16,make_color_rgb(255,248,155),make_color_rgb(16,8,8),1)
textDropShadow("Basic Rules",myWinX+14,myWinY+29,make_color_rgb(255,248,155),make_color_rgb(16,8,8),1)
textDropShadow("Suck Ability",myWinX+14,myWinY+42,make_color_rgb(255,248,155),make_color_rgb(16,8,8),1)
textDropShadow("Weapons",myWinX+14,myWinY+55,make_color_rgb(255,248,155),make_color_rgb(16,8,8),1)
textDropShadow("Assists",myWinX+14,myWinY+68,make_color_rgb(255,248,155),make_color_rgb(16,8,8),1)
textDropShadow("Checkpoints",myWinX+14,myWinY+81,make_color_rgb(255,248,155),make_color_rgb(16,8,8),1)
textDropShadow("",myWinX+14,myWinY+94,make_color_rgb(255,248,155),make_color_rgb(16,8,8),1)
textDropShadow("",myWinX+14,myWinY+107,make_color_rgb(255,248,155),make_color_rgb(16,8,8),1)
textDropShadow("",myWinX+14,myWinY+120,make_color_rgb(255,248,155),make_color_rgb(16,8,8),1)

draw_sprite(sPauseM_AbilArrow,0,myWinX+11,myWinY+curY)
