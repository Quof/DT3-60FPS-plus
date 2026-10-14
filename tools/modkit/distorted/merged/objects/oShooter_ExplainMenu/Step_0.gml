if gDeltaDoTicks != 1 { exit; }

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
  //if oKeyCodes.kCodePressed[5]=1
  if oKeyCodes.kCodePressed[15]=1 //gamepad change: menu Confirm/Back (15/16: on a gamepad always A/B)
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
  //else if oKeyCodes.kCodePressed[6]=1
  else if oKeyCodes.kCodePressed[16]=1 //gamepad change: menu Confirm/Back (15/16: on a gamepad always A/B)
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
      //msgCreate(0,0,"John",string("The [Arrow Keys] or [WASD] will move the Dragoon in the direction you would imagine that key would direct it.#[") +string(global.ctrlJump) +string("] will fire the current weapon."),6,3,oMessageCutscene,1)
      msgCreate(0,0,"John","The [Arrow Keys] or [WASD] will move the Dragoon in the direction you would imagine that key would direct it.#[Jump] will fire the current weapon.",6,3,oMessageCutscene,1) //input text change: the keys as [tokens], shown as the key set for them or the gamepad button's icon (scrDrawInput)
    else if sceneProgress=2 and bWaitForInput=false
      //msgCreate(0,0,"John",string("Holding [") +string(global.ctrlActA) +string("] will cause the Dragoon to move at half speed should you desire."),6,3,oMessageCutscene,1)
      msgCreate(0,0,"John","Holding [Action A] will cause the Dragoon to move at half speed should you desire.",6,3,oMessageCutscene,1) //input text change: the keys as [tokens], shown as the key set for them or the gamepad button's icon (scrDrawInput)
    else if sceneProgress=3 and bWaitForInput=false
      //msgCreate(0,0,"John",string("Holding [") +string(global.ctrlActB) +string("] will cause the Dragoon to 'suck in' a weakened enemy. You'll be able to tell if an enemy is weakened by it turning a shade of red. An enemy is weakened when it is below 45% HP."),6,3,oMessageCutscene,1)
      msgCreate(0,0,"John","Holding [Action B] will cause the Dragoon to 'suck in' a weakened enemy. You'll be able to tell if an enemy is weakened by it turning a shade of red. An enemy is weakened when it is below 45% HP.",6,3,oMessageCutscene,1) //input text change: the keys as [tokens], shown as the key set for them or the gamepad button's icon (scrDrawInput)
    else if sceneProgress=4 and bWaitForInput=false
      msgCreate(0,0,"John","Note that when an enemy is 'sucked in' your 'sucking' ability will be disabled for about 1 second.",6,3,oMessageCutscene,1)
    else if sceneProgress=5 and bWaitForInput=false
      //msgCreate(0,0,"John",string("Press [") +string(global.ctrlCharSwap) +string("] to swap the current controller of the Dragoon. Jerry and Claire have the same control set up, however, each of them have their own weapon. (More on this in 'Suck Ability'.)"),6,3,oMessageCutscene,1)
      msgCreate(0,0,"John","Press [Character Swap] to swap the current controller of the Dragoon. Jerry and Claire have the same control set up, however, each of them have their own weapon. (More on this in 'Suck Ability'.)",6,3,oMessageCutscene,1) //input text change: the keys as [tokens], shown as the key set for them or the gamepad button's icon (scrDrawInput)
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
      msgCreate(0,0,"John","The 'Suck Ability' is the ability Kirby transferred to you. When you 'suck in' a weakened enemy, you will recover a bit of HP and restore some ammo for both Jerry and Claire. (More on weapons and ammo in 'Weapons'.)",6,3,oMessageCutscene,1)
    else if sceneProgress=2 and bWaitForInput=false
      msgCreate(0,0,"John","I don't know if you guys played 'Contra 3', but it's not like that weapon setup. Oh right, when sucking in an enemy, it won't fire at you.",6,3,oMessageCutscene,1)
    else if sceneProgress=3 {sceneProgress=0; bCanMoveCursor=1}
  }
  else if curPos=5 //Weapons
  {
    if sceneProgress=0 {bCanMoveCursor=0; sceneProgress=1}
    else if sceneProgress=1 and bWaitForInput=false
      msgCreate(0,0,"John","The Standard Shot has a power of 10 and a fire rate of 6/sec. (DPS: 60) If I knew the stats of the abilities you'll find up there, I'd tell you. Either you or Chao could possibly look that up in their scan info.",6,3,oMessageCutscene,1)
    else if sceneProgress=2 and bWaitForInput=false
      msgCreate(0,0,"John","Speaking of other weapons. Both of you have your own weapons, with individual ammo counts. When you run out of ammo, you'll revert to the peashooter until you regain ammo.",6,3,oMessageCutscene,1)
    else if sceneProgress=3 and bWaitForInput=false
      msgCreate(0,0,"John","Note that you lose ammo when you shoot a weapon, not when you hit with it.",6,3,oMessageCutscene,1)
    else if sceneProgress=4 {sceneProgress=0; bCanMoveCursor=1}
  }
  else if curPos=6 //Assists
  {
    if sceneProgress=0 {bCanMoveCursor=0; sceneProgress=1}
    else if sceneProgress=1 and bWaitForInput=false
      msgCreate(0,0,"John","You will gain these automatically as you advance. There are two types, ones that shoot and ones that cancel bullets.",6,3,oMessageCutscene,1)
    else if sceneProgress=2 and bWaitForInput=false
      msgCreate(0,0,"John","When facing enemies that shoot lots of bullets, try using the bullet cancellers proactively.",6,3,oMessageCutscene,1)      
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
