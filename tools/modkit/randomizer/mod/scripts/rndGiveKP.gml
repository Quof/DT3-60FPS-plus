//Randomizer: the player gets an item (argument0: its kind, argument1: its parameter, as rndData's rndItemKind and
//rndItemParam), with its message and sound, as the game's own pickups give it (no message with global.rndMsgQuiet on).
//The game's own count of that kind of item (heartPiece and the rest: the pause menu's progress page and the item % count
//them) gets its next place marked (rndMarkNext)
var k,p,l,n;
k=argument0
p=argument1
if instance_exists(oIdentifier) and k!=29 {if oIdentifier.bChaoActive=1 {showEmote(oIdentifier,0,-6,sEmHappy)}}
switch (k)
{
  case 1: //Heart Piece
    playSound(global.snd_HeartPiece,0,1,1)
    awardAwesome(2500)
    global.pHeartPieces+=1
    if global.pHeartPieces>=4
    {
      global.pHeartPieces=0
      global.pMaxLife+=4
      global.pLife+=4
      if instance_exists(oPlayer1) {oPlayer1.maxLife+=4; oPlayer1.life+=4}
      rndMsg("You found a Heart Piece!#Your Max Heart Capacity increased by 1!",2)
    }
    else {rndMsg("You found a Heart Piece!#Only "+string(4-global.pHeartPieces)+" more for a full heart!",2)}
    break
  case 2: //Internetz
    playSound(global.snd_HeartPiece,0,1,1)
    awardAwesome(3000)
    global.recInterEarnTotal+=p
    global.recInterEarnChest+=p
    global.pMoney=min(global.pMoney+p,global.pMoneyMax)
    if instance_exists(oPlayer1) {oPlayer1.currentMoney=min(oPlayer1.currentMoney+p,global.pMoneyMax)}
    rndMsg("You found "+string(p)+" Internetz!",1)
    break
  case 3: //equipment
    playSound(global.snd_HeartPiece,0,1,1)
    awardAwesome(3000)
    global.equipItems=rndSetChar(global.equipItems,p,"1")
    rndMsg("You found the "+rndItemNameKP(k,p)+"!",1)
    break
  case 4:
    playSound(global.snd_HeartPiece,0,1,1)
    awardAwesome(2500)
    global.hudLink_Arrows[0]+=1
    global.hudLink_Arrows[1]+=1
    rndMsg("You found an Arrow Quiver!#Arrow capacity increased by 1!",2)
    break
  case 5:
    playSound(global.snd_CVItemGet,0,1,1)
    awardAwesome(2500)
    global.hudBelmont_WeaponEn[0]+=5
    global.hudBelmont_WeaponEn[1]+=5
    rndMsg("You found a Heart Energy Expansion!#Heart Energy capacity increased by 5!",2)
    break
  case 6:
    playSound(global.snd_MetItemGet,0,1,1)
    awardAwesome(2500)
    global.hudSamus_Missiles[0]+=1
    global.hudSamus_Missiles[1]+=1
    rndMsg("You found a Missile Expansion!#Missile capacity increased by 1!",2)
    break
  case 7:
    playSound(global.snd_RPG_ItemGrab,0,1,1)
    awardAwesome(1500)
    global.hudGame_WeaponEn[0]+=2
    global.hudGame_WeaponEn[1]+=2
    rndMsg("You found additional Game Power!#Max Power increased by 2!",2)
    break
  case 8:
    playSound(global.snd_HeartPiece,0,1,1)
    awardAwesome(2500)
    global.pBreathMax+=30
    global.pCurrBreath+=30
    rndMsg("You found an Air Upgrade!#Your air capacity has been increased by 1 second!",2)
    break
  case 9:
    playSound(global.snd_HeartPiece,0,1,1)
    awardAwesome(5000)
    rndMsg("You found an Internetz Mod!#Internetz earned from enemy drops increased by 10%!",2)
    break
  case 10:
    if p<=2 {playSound(global.snd_HeartPiece,0,1,1)}
    else if p<=5 {playSound(global.snd_CVItemGet,0,1,1)}
    else if p<=8 {playSound(global.snd_MMItemGet,0,1,1)}
    else {playSound(global.snd_MetItemGet,0,1,1)}
    awardAwesome(2500)
    if p=0 {global.stLink_Sword[0]+=1}
    else if p=1 {global.stLink_Arrow[0]+=1}
    else if p=2 {global.stLink_Bomb[0]+=1}
    else if p=3 {global.stBelmont_HairWhip[0]+=1}
    else if p=4 {global.stBelmont_Dagger[0]+=1}
    else if p=5 {global.stBelmont_Holywater[0]+=1}
    else if p=6 {global.stMega_Buster[0]+=1}
    else if p=7 {global.stMega_ShotIce[0]+=1}
    else if p=8 {global.stMega_Gravity[0]+=1}
    else if p=9 {global.stSamus_Cannon[0]+=1}
    else if p=10 {global.stSamus_Missile[0]+=1}
    else {global.stSamus_Bomb[0]+=1}
    rndMsg("You found a Weapon Upgrade!#["+rndWeaponName(p)+"] level increased by 1!",2)
    break
  case 11:
    playSound(global.snd_SkillGet,0,1,1)
    awardAwesome(2500)
    global.pAP+=1
    rndMsg("Oh snap!#You earned 1 Skill Point!",2)
    break
  case 12:
    playSound(global.snd_HeartPiece,0,1,1)
    awardAwesome(10000)
    global.linkBombUpgrade+=1
    rndMsg("You found a Bomb Upgrade!#Bomb blast radius increased by 4%!",2)
    break
  case 13:
    playSound(global.snd_MetItemGet,0,1,1)
    awardAwesome(10000)
    global.metBombUpgrade+=1
    rndMsg("You found a Morph Bomb Upgrade!#Morph Bomb blast radius increased by 7%!",2)
    break
  case 14: //a key: its own door's (p: the door's objectNum)
    playSound(global.snd_SkillCapsule,0,1,1)
    awardAwesome(200)
    global.pKeys+=1
    global.rndKeyOwn=rndSetChar(global.rndKeyOwn,p,"1")
    rndMsg("You found a Key!#It opens a door in "+global.rndDoorArea[p]+".",2)
    break
  case 15:
    playSound(global.snd_HeartPiece,0,1,1)
    awardAwesome(10000)
    global.pMaxLife+=4
    global.pLife=global.pMaxLife
    if instance_exists(oPlayer1) {oPlayer1.maxLife+=4; oPlayer1.life=oPlayer1.maxLife}
    rndMsg("You found a Heart Container!#Your Max Heart Capacity increased by 1!",2)
    break
  case 16:
    playSound(global.snd_HeartPiece,0,1,1)
    awardAwesome(100000)
    global.itemFinder=1
    rndMsg("You found the [Item Finder]!#Chao can now alert you to hidden items.",2)
    break
  case 17:
    playSound(global.snd_MMItemGet,0,1,1)
    awardAwesome(100000)
    global.hasBoostedXCharge=1
    rndMsg("You found the X-Special Charge!#You can now charge your X-Specials.",2)
    break
  case 18:
    playSound(global.snd_MetItemGet,0,1,1)
    awardAwesome(100000)
    global.metSpringBall=1
    rndMsg("You found the [Spring Ball]!#You can now jump in Morph Ball mode.",2)
    break
  case 25: //the Varia Suit: Gate 5's lava doesn't hurt (the mod's oMetLava)
    playSound(global.snd_MetItemGet,0,1,1)
    awardAwesome(10000)
    global.rndOwn[12]+=1
    rndMsg("You found the [Varia Suit]!#You no longer take damage from most lava.",2)
    break
  case 26: //an instrument (p: its place in eGateProg, 1-8): had (9). With all eight, the Abomination can be faced
    //(gateHProg 100, which the Sacred Temple's last instrument scene gives in the game)
    playSound(global.snd_SkillGet,0,1,1)
    awardAwesome(10000)
    global.eGateProg=rndSetChar(global.eGateProg,p,"9")
    rndMsg("You obtained the "+rndItemNameKP(k,p)+"!",1)
    if global.eGateProg="99999999" and global.gateHProg<100 {global.gateHProg=100}
    break
  case 27: //a Program Chip (p: its Access Gate, 1-6, Chip Randomizer): the gate's portal, and the Nightmare Gate portal
    //beside it, can be used (the mod's oAccessGate, rndPortalChip). The pause menu shows as many chips as they have
    playSound(global.snd_SkillGet,0,1,1)
    awardAwesome(10000)
    global.rndChipOwn=rndSetChar(global.rndChipOwn,p,"1")
    n=0
    for(l=1;l<=global.rndChipN;l+=1) {if string_char_at(global.rndChipOwn,l)="1" {n+=1}}
    global.programChips=n
    rndMsg("You found Program Chip "+string(p)+"!#"+global.rndGateName[p]+" is open.",2)
    break
  case 29: //a trap item (p: the trap: rndSnareSpring, the option Traps), which looked like a Weapon Upgrade
    rndSnareSpring(p)
    break
  case 28: //a Nightmare ability (p: 0 Link's Sword Wave, 1 Mega Man's charge shots stored, 2 Belmont's Dagger Spam, 3
    //Samus's Power Bomb), as Nightmare Mode has it (rndNM)
    playSound(global.snd_SkillGet,0,1,1)
    awardAwesome(10000)
    global.rndOwn[13+p]+=1
    if p=0 {rndMsg("You found the Nightmare Sword Wave!#Link's sword sends out a wave while your life is full.",2)}
    else if p=1 {rndMsg("You found the Nightmare Charge Storage!#Mega Man's buster keeps charging, storing up to three shots.",2)}
    else if p=2 {rndMsg("You found the Nightmare Dagger Spam!#Belmont: Down, Down, Forward, Forward, then the dagger.",2)}
    else {rndMsg("You found the Nightmare Power Bomb!#Samus: hold the bomb button in the Morph Ball, then let go.",2)}
    break
  case 19: case 20: case 21: case 22: case 23: case 24:
    playSound(global.snd_SkillGet,0,1,1)
    awardAwesome(10000)
    if k=24 {n=5+p} else {n=k-19}
    global.rndOwn[n]+=1
    if k=19 {if global.hasShoes[1]=0 {global.hasShoes[1]=2}; rndMsg("You can now Jump!",1)}
    else if k=20 {if global.hasShoes[2]=0 {global.hasShoes[2]=2}; rndMsg("You can now Dash!",1)}
    else if k=21 {if global.hasShoes[3]=0 {global.hasShoes[3]=2}; rndMsg("You can now Air Dash!",1)}
    else if k=22 {if global.canDoubleJump=0 {global.canDoubleJump=2}; rndMsg("You can now Double Jump!",1)}
    else if k=23
    {
      global.metJumpUpgrade=min(2,global.rndOwn[4])
      if global.metJumpUpgrade=1 {rndMsg("You found the High Jump Boots!#(Gate 5's jumps are higher)",2)}
      else {rndMsg("You found the Super High Jump Boots!#(Gate 5's jumps are higher still)",2)}
    }
    else
    {
      l=global.rndOwn[n]+1
      if p=0 {rndMsg("Jerry and Claire gained the Mario Ability Set!#They can now jump on bad guys from the Mario Universe.",2)}
      else {rndMsg("You found a new ability!#"+rndSetLevelName(p,l),2)}
      //an active set gets its new level; one the room has inactive (1) stays inactive till abilSetRemove(0)
      if global.hasAbilToken[p]=0 or global.hasAbilToken[p]>=2
      {
        if p>=5 and !rndInGate6() {global.hasAbilToken[p]=1}
        else {global.hasAbilToken[p]=l}
      }
      rndPickSets()
    }
    break
}
rndMarkNext(k)
global.rndTrackDirty=1
