#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.quickGameOver=0
{
  if oPlayer1.attackState!=oPlayer1.ACT_MORPHBALL or oPlayer1.attackState!=oPlayer1.ACT_IN_BIKE
  {
    if global.activeCharacter=0 {oPlayer1.sprite_index=sJerryDamaged}
    else if global.activeCharacter=1 {oPlayer1.sprite_index=sClaireDamaged}
  }
}
awardAwesome(500)
global.checkForDeath=1
global.hitsTaken=0
global.killStreak=0
global.desertHeat=1500
global.hudGame_WeaponEn[0]=global.hudGame_WeaponEn[1]
global.rmDeaths+=1
global.recDeathCount+=1
global.recInterLostDeath+=oPlayer1.moneyEarnedOnMap
global.gameOver=true
global.gamePaused=true
global.bCanGameOver=true
failColor=c_white

skipGameOver=global.optBitrateExplosion

noStaticTime=0 //Used if bitrate explosion is off

//Warmaster attempts (Story only)
if room=rWarshipZ_E2 and global.bBossGallery=0
{
  if global.quickGameOver=0
  {
    global.recWarmasterLoses+=1
    ini_open(global.paraString[0])
    sectionWrite="ALPHA"
    ini_write_real(sectionWrite,"406-13-1",global.recWarmasterLoses)
    ini_close()
  }
  else
  {
    global.recWarmasterResets+=1
    ini_open(global.paraString[0])
    sectionWrite="ALPHA"
    ini_write_real(sectionWrite,"406-13-2",global.recWarmasterResets)
    ini_close()
  }
}

//-----------------------------------------------------------------------------------
//------------------------------ Random insult message ------------------------------
//----------------------------- These appear at the top -----------------------------
//-----------------------------------------------------------------------------------
if global.quickGameOver=0
{
  var ranMessage;
  if global.recDeathCount=1 {ranMessage=0}
  else
  {
    var tExtMess;
    if global.sessionPlayTime<1800 {tExtMess=0}
    else {tExtMess=1}
    ranMessage=irandom_range(0,53+tExtMess)
  }

  if ranMessage=0 {failMessage="You failed to save the world..."}
  else if ranMessage=1 {failMessage="Just try sucking less."}
  else if ranMessage=2 {failMessage="Yep, you suck."}
  else if ranMessage=3 {failMessage="Were you even trying?"}
  else if ranMessage=4 {failMessage="It's okay, you were never that good anyway."}
  else if ranMessage=5 {failMessage="Your failures are hilarious."}
  else if ranMessage=6 {failMessage="Quoth the player, 'nevermore'."}
  else if ranMessage=7 {failMessage="You must be a vacuum, cause you suck and blow at this game."}
  else if ranMessage=8 {failMessage="You DO understand you aren't suppose to lose, right?"}
  else if ranMessage=9 {failMessage="You suck so much at this."}
  else if ranMessage=10 {failMessage="Your sorry attempt at playing this is laughable."}
  else if ranMessage=11 {failMessage="Game over... AGAIN!"}
  else if ranMessage=12 {failMessage="You tried once and failed. You tried AGAIN and failed."}
  else if ranMessage=13 {failMessage="..."}
  else if ranMessage=14 {failMessage="It's okay, you were never that good anyway."}
  else if ranMessage=15 {failMessage="You have lost " +string(global.recDeathCount) +string(" times, which is pretty funny.")}
  else if ranMessage=16 {failMessage="Not to be mean, but you suck... Actually no, that was intentionally malicious."}
  else if ranMessage=17 {failMessage="Apparently you were born to fail."}
  else if ranMessage=18 {failMessage="Most pathetic death EVER!!"}
  else if ranMessage=19 {failMessage="Well the world WAS depending on you."}
  else if ranMessage=20 {failMessage="What's really funny about this is how much you suck."}
  else if ranMessage=21 {failMessage="I can't begin to describe how much you suck."}
  else if ranMessage=22 {failMessage="You HAVE played other games, right?"}
  else if ranMessage=23 {failMessage="Eh, your loss was inevitable."}
  else if ranMessage=24 {failMessage="Quit now or forever hold your peace."} //Cirno
  else if ranMessage=25 {failMessage="You fail. But then again, what's new?"} //Cryoreaper (Youtube)
  else if ranMessage=26 {failMessage="I find your abundance of fail disturbing."} //Cryoreaper (Youtube)
  else if ranMessage=27 {failMessage="Congratulations on your recent shortcomings.#Thanks for playing Distorted Travesty."}
  else if ranMessage=28 {failMessage="You should never underestimate your incompetence."} //gprimier
  else if ranMessage=29 {failMessage="You're not really trying are you?"} //gprimier
  else if ranMessage=30 {failMessage="Maxing your deathcount I see."} //gprimier
  else if ranMessage=31 {failMessage="I expected a twist ending for once."} //gprimier
  else if ranMessage=32 {failMessage="The Konami code wouldn't be enough to save you."} //gprimier
  else if ranMessage=33 {failMessage="I wrote a book called 'You will eventually win'. It's in the fiction section."} //gprimier
  else if ranMessage=34 {failMessage="Stop using this screen as a screensaver!"} //gprimier
  else if ranMessage=35 {failMessage="Pretty rude of you to force the reaper into overtime."} //gprimier
  else if ranMessage=36 {failMessage="In this world of chaos,#it's reassuring to see that some things will always be the same.#Your incompetence."} //gprimier
  else if ranMessage=37 {failMessage="Your odds of successfully navigating this game are approximately 3720 to 1."} //NegativeZeroZ
  else if ranMessage=38 {failMessage="That's what you did with your life? That was senseless."} //NegativeZeroZ
  else if ranMessage=39 {failMessage="Remember, it's okay if you suck. Somewhere out there for you, there's a game that blows."} //NegativeZeroZ
  else if ranMessage=40 {failMessage="For the record, you ARE bad at this game, and that's terrible!"} //NegativeZeroZ
  else if ranMessage=41 {failMessage="You're no Pinball Wizard."} //LostSoldier20
  else if ranMessage=42 {failMessage="You must have a degree in dying."} //LostSoldier20
  else if ranMessage=43 {failMessage="We all agree you should stop."} //LostSoldier20
  else if ranMessage=44 {failMessage="Trying to die in every way possible?"} //LostSoldier20
  else if ranMessage=45 {failMessage="You could use a Horcrux."} //LostSoldier20
  else if ranMessage=46 {failMessage="Press J to not die."} //LostSoldier20
  else if ranMessage=47 {failMessage="Is this a comedy or a tragedy?"} //LostSoldier20
  else if ranMessage=48 {failMessage="Oh hey, failure was an option after all!"} //Cirno
  else if ranMessage=49 {failMessage="Get rekt."}
  else if ranMessage=50 {failMessage="lol u died."}
  else if ranMessage=51 {failMessage="You should have checked yourself before you wrecked yourself."} //Tea
  else if ranMessage=52 {failMessage="I guess you're going for a mulligan? ... Pfft, don't lie to yourself."}
  else if ranMessage=53 {failMessage="You should upload this to youtube so we can revisit this moment later."}
  else if ranMessage=54 {failMessage="Maybe you should stop soon, you're playing like trash."}

  //------------------------------ Gate specific insults ------------------------------
  if random(100)<=7 and global.recDeathCount>1 //NegativeZeroZ
  {
    ranMessage=irandom_range(0,2)
    if global.location=7 //Gate 1
    {
      if ranMessage=0 {failMessage="You are playing it wrong! Give me the controller!"}
      else if ranMessage=1 {failMessage="Mario says to stop-a sucking at his-a videogame."}
      else if ranMessage=2 {failMessage="Thank you for playing Super Mario Travesty. You found zero stars."}
    }
    else if global.location=10 //Gate 2
    {
      if ranMessage=0 {failMessage="No, player; you are the error."}
      else if ranMessage=1 {failMessage="HEY!! LISTEN!! ...I got nothing, sorry."}
      else if ranMessage=2 {failMessage="When using your head doesn't work, Triforce."}
    }
    else if global.location=15 //Gate 3
    {
      if ranMessage=0 {failMessage="It was not by my hand that you are once again given this screen."}
      else if ranMessage=1 {failMessage="This game ill needs a player such as you!"}
      else if ranMessage=2 {failMessage="One, two... " +string(global.recDeathCount) +string(" deaths! Ah-ha-hah!")}
    }
    else if global.location=29 //Gate 4
    {
      if ranMessage=0 {failMessage="MEGAMAN MEGAMAN!! Someone really bad at videogames is playing!!"}
      else if ranMessage=1 {failMessage="Save the E-Tank for the boss! Oh wait."}
      else if ranMessage=2 {failMessage="Stop Rushing. You're giving me the Bad Player Blues."}
    }
    else if global.location=49 //Gate 5
    {
      if ranMessage=0 {failMessage="No matter how many times you see this screen, Claire's clothes still aren't coming off."}
      else if ranMessage=1 {failMessage="The Baby Metroid will not save you."}
      else if ranMessage=2 {failMessage="Your mission is to stop sucking at videogames. Any objections, Player?"}
    }
    else if global.location=58 //Gate 6
    {
      if ranMessage=0 {failMessage="I see your complimentary amnesia made you forget how to play the game."}
      else if ranMessage=1 {failMessage="Warning: Removal of pants will not cause an increase in in-game player stats."}
      else if ranMessage=2 {failMessage="Unfortunately, our 'Stop Sucking' DLC Pack is unavailable in your copy of the game.#(Yes, yours specifically.)"}
    }
  }

  //------------------------------ Situational insults ------------------------------
  if global.levelTimeSecond<=3
  {
    failColor=c_white
    failMessage="That was a demo, wasn't it?" //NegativeZeroZ
  }

  //-----------------------------------------------------------------------------------
  //------------------------------ Scripted hint message ------------------------------
  //--------------------------- These appear at the bottom ----------------------------
  //-----------------------------------------------------------------------------------
  hintMessage=""
  if global.currentBoss=""
  {
    //Specific messages at specific locations
    event_user(0)

    //------------------------------ Water messages ------------------------------
    if global.pCurrBreath<=0
    {
      var watMessage,maxMess;
      maxMess=global.recDrowned-1
      if maxMess>3 maxMess=3
      watMessage=irandom_range(0,maxMess)
      if watMessage=0 {hintMessage="It's a good idea to come up for air."}
      else if watMessage=1 {hintMessage="Remember to mind your escape routes."}
      else if watMessage=2 {hintMessage="Keep a look out for anywhere you can grab air."}
      else if watMessage=3 {hintMessage="I sense that drowning is going to be a recurring problem with you."}

      if room=rLink2_PalaceW_1 {hintMessage="How did you drown in this room? Seriously, WTF?!"}
      else if room=rGame6_HeroPlainsD
      {
        var tCheckAchieve;
        tCheckAchieve=string_char_at(global.tokenRecognitions,27)
        if tCheckAchieve="0"
        {
          var tAchievement;
          tAchievement=instance_create(0,0,oAchievementNotice)
          tAchievement.myAchievement="Drowning in Spring"; tAchievement.checkNum=27
        }
        hintMessage="Wasn't quite expecting you to do that... or maybe I was? Oh well, here's an achievement for novelty purposes."
      }
    }

    //------------------------------ Situational messages ------------------------------
    if instance_exists(oSituationalGO_Message)
    {
      if oSituationalGO_Message.type=0 //Warmaster got too far ahead
        hintMessage="You can't let the Warmaster get too far ahead or you'll lose him."
      else if oSituationalGO_Message.type=1 //Popped Mr. Saturn's balloon
      {
        var tCheckAchieve;
        tCheckAchieve=string_char_at(global.tokenRecognitionsSetTwo,2)
        if tCheckAchieve="0"
        {
          var tAchievement;
          tAchievement=instance_create(0,0,oAchievementNoticeSS)
          tAchievement.myAchievement="Balloon Popper"; tAchievement.checkNum=2
        }
        hintMessage="That WAS pretty mean of you to do."
      }
      else if oSituationalGO_Message.type=2 //Incorrectly performed Hidden ending sequence during Abomination fight
        hintMessage="You can't go destroying the weak spots."
    }
  }
  //------------------------------ Bosses hints ------------------------------
  if global.currentBoss="Bowser"
    hintMessage="Wait until Bowser jumps before moving away from the spot you want him to butt stomp on."
  else if global.currentBoss="Cackletta"
    hintMessage="Cackletta can only be damaged when she is distracted."
  else if global.currentBoss="Helmethead"
    hintMessage="Sliding is a good way to go."
  else if global.currentBoss="Dead Hand"
    hintMessage="If it leaps out of the ground to get you while you're on a platform, your sword does more damage."
  else if global.currentBoss="Barba"
    hintMessage="Be prepared to jump if he comes up low."
  else if global.currentBoss="Thunderbird"
    hintMessage="Try trailing behind him."
  else if global.currentBoss="Aqua Serpent"
  {
    var tMsgChk;
    if instance_exists(oAquaSerpent)
    {
      if oAquaSerpent.lifePercent>=0.5 {tMsgChk=0}
      else {tMsgChk=1}
    }
    else {tMsgChk=0}
    if tMsgChk=0
      hintMessage="Watch for the body parts changing colors. They'll let you know if they're about to fire."
    else
      hintMessage="The best time to get a hit in is when it stops to fire. Focus on dodging and making sure you're not put in a bad situation while it's in motion."
  }
  else if global.currentBoss="Control Virus"
  {
    if oCh5CC_CompScr>0
      hintMessage="You should probably take note that lasers and bullets are not your friend."
    else
      hintMessage="Go after only the aerial laser bots that will potentially fire on your Pincher Bot."
  }
  else if global.currentBoss="Vampire Bat"
    hintMessage="Observe carefully how it attacks where you are."
  else if global.currentBoss="Dracula"
    hintMessage="Sometimes being too far from your opponent can be a bad thing."
  else if global.currentBoss="Menace"
    hintMessage="It may be useful to always have enough Heart Energy to take out a Menace Spawn quickly."
  else if global.currentBoss="Death"
  {
    if instance_exists(oDeath)
      hintMessage="During his scythe combo, look closely at the poses and react accordingly. Try to stay within reach at all times and be sure to keep up with his zoning."
    else
      hintMessage="Try to stay on the platforms as often as possible to direct the circle of scythes to an easier dodged location."
  }
  else if global.currentBoss="Enmity"
    hintMessage="Be sure to observe weaknesses and resistances."
  else if global.currentBoss="Maoh"
    hintMessage="If your flooring is being broken, try and lead the spiked arms away."
  else if global.currentBoss="Storm Eagle"
    hintMessage="Your ground dash beats his wind attack."
  else if global.currentBoss="Overdrive Ostrich"
    hintMessage="He may be fast, but..."
  else if global.currentBoss="Gravity Beetle"
    hintMessage="If pinned against the wall, perhaps a dash under a hop would help out."
  else if global.currentBoss="Bospider"
    hintMessage="Try catching a spider with your Gravity Well as they fall."
  else if global.currentBoss="Bit"
    hintMessage="You lost? Just uh... don't get hit."
  else if global.currentBoss="Byte"
    hintMessage="Jerry does not have the same restrictions as X, he can dash through Byte's charge attack."
  else if global.currentBoss="Bit & Byte"
    hintMessage="Try and concentrate your fire on one of them."
  else if global.currentBoss="Sigma"
    hintMessage="During Sigma's green waves, a fairly precise wall jump will be needed. Try running toward the wall with the attack."
  else if global.currentBoss="Sigma Epsilon"
    hintMessage="It may be best to not be in the air where Sigma will respawn."
  else if global.currentBoss="Army Eye"
    hintMessage="If you can't dodge in time, swap to the other character... I hope you have them on opposite sides."
  else if global.currentBoss="Hex"
    hintMessage="Don't get greedy. It is best to retreat than to put yourself in a potentially undodgable situation."
  else if global.currentBoss="Vault Demon"
    hintMessage="Try not to let your hydration meter fall below 75%. The Vault Demon may summon his fireball at any moment's notice."
  else if global.currentBoss="Arachnus"
    hintMessage="When he turns red, he won't come out of his spin on his own..."
  else if global.currentBoss="King Worm"
    hintMessage="Be sure to watch your air."
  else if global.currentBoss="Kraid"
    hintMessage="Be sure to destroy the nails, they can quickly become overwhelming."
  else if global.currentBoss="Mother Brain"
    hintMessage="Take things slow, the rings should be your priority."
  else if global.currentBoss="Ridley"
  {
    if instance_exists(oRidley)
      hintMessage="Watch his movements and predict where he'll be. Your bomb detonation time is 1 second."
    else if instance_exists(oRidleyLast)
      hintMessage="Listen for the sound on the tail swings. After the second, he'll strike."
    else if instance_exists(oRidleyTunnel)
      hintMessage="Did you know that you can leave the fight now and return to this point?"
    else if instance_exists(oRidleyFinal)
      hintMessage="Ridley cannot be defeated in the standard way. Something else must be done to 'shatter' through his near-invincible state."
  }
  else if global.currentBoss="Sand Crawler"
    hintMessage="Lure it out when you find an opening and be sure to prep your attack."
  else if global.currentBoss="Malevolence"
    hintMessage="When the lightning attack starts, the middle is your safest area."
  else if global.currentBoss="Stone Golem"
    hintMessage="Don't forget your slide gives a lot of momentum. Parry is extremely useful as well."
  else if global.currentBoss="Fire Elemental"
    hintMessage="Parry the fireballs."
  else if global.currentBoss="High Heels Girl"
    hintMessage="Learning to parry might be a good idea. That or attacking and backing off is an idea... or grinding."
  else if global.currentBoss="Unforgotten"
    hintMessage="There's a very strict pattern this sticks to. Learn it and victory is yours... well maybe."
  else if global.currentBoss="Chosen One"
    hintMessage="Don't forget that Jerry can block/parry all projectiles."
  else if global.currentBoss="Antipathy"
    hintMessage="Attempt to keep your distance as far from the two as possible."
  else if global.currentBoss="Sera"
    hintMessage="Watch the floor at times. Victory here is found with finesse and grace."
  else if global.currentBoss="Brain Machine"
    hintMessage="It's much easier to stabilize yourself to use the Strike Chain after a double jump, rather than an air-dash."
  else if global.currentBoss="Blade Bot"
    hintMessage="Probably didn't see that one coming."
  else if global.currentBoss="Combat Apparatus"
    hintMessage="Sometimes being aggressive can be a good strategy."
  else if global.currentBoss="Giant Blargg"
    hintMessage="You don't have the Zephyr wind spell to get you out of this one."
  else if global.currentBoss="Defective"
    hintMessage="....."
  else if global.currentBoss="Shadow Eura"
    hintMessage="Position yourself to lead the explosive fire."
  else if global.currentBoss="Decimator"
    hintMessage="Positioning is important. Don't forget the morph ball is great for dodging."
  else if global.currentBoss="Abomination"
    hintMessage="Focus."
  else if global.currentBoss="Hex Final"
    hintMessage="Give up, you'll never win. You're a failure and always will be."
  else if global.currentBoss="Warmaster"
    hintMessage="Determination."
  else if global.currentBoss="Kamek" or global.currentBoss="Final Nightmare" or global.currentBoss="Blackmoor" or global.currentBoss="Elpizo" or global.currentBoss="Shadow Form" or global.currentBoss="Nightmare" or global.currentBoss="Sephiroth" or global.currentBoss="Parasitic Seed" or global.currentBoss="Virus Parasite"
    hintMessage="?????"
  else if global.currentBoss="Hexor"
    hintMessage="Try again."
  else if global.currentBoss="The Executive"
    hintMessage="<Insert helpful message here>"
  else if global.currentBoss="Warmaster EX"
    hintMessage="You don't need any help if you're here."
  else if global.currentBoss="Fedex"
    hintMessage="What are you doing here?"
  else if global.currentBoss="Helmethead EX"
    hintMessage="It never ends."
}
else
{
  ranMessage=irandom_range(0,4)
  if ranMessage=0 {failMessage="Kind of a cop-out, don't you think?"}
  else if ranMessage=1 {failMessage="This still gives you a +1 to your death count. I just wanted to let you know..."}
  else if ranMessage=2 {failMessage="You might have been able to win... on second thought, nah."}
  else if ranMessage=3 {failMessage="Quitters never win."}
  else if ranMessage=4 {failMessage="You weren't looking too good there."}
  
  hintMessage=""
}

if global.recDeathCount=404 {failMessage="Death Count: 404: Player Not Found."}

//Final segments of the game have different Game Over messages
if global.currentBoss="Hex Final"
{
  var ranMessage;
  ranMessage=irandom_range(0,2)
  if ranMessage=0 {failMessage="You'll never beat me."}
  else if ranMessage=1 {failMessage="Just give up. Don't you see you'll never be as good as me."}
  else if ranMessage=2 {failMessage="You were a failure in the real world and a failure here.#How could someone so pathetic stand a chance against me?"}
}
if global.gameProgress>=5260 and global.gameProgress<=5340 //Path to Warmaster
{
  var ranMessage;
  ranMessage=irandom_range(0,2)
  if ranMessage=0 {failMessage="Keep going!"}
  else if ranMessage=1 {failMessage="You can do it!"}
  else if ranMessage=2 {failMessage="You've got this!"}
}
else if global.gameProgress>=5350 and global.gameProgress<=5490 {failMessage=""} //Warship escape

//------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------

//Reset ammo and player momentum
staticEffect=0
global.pCurrBreath=global.pBreathMax
global.hudMega_BusterEn[0]=32
global.hudMega_ShotIceEn[0]=32
global.hudMega_GravityEn[0]=32
global.hudSamus_CannonEn[0]=0
oPlayer1.xVel=0
oPlayer1.yVel=0
oPlayer1.xAcc=0
oPlayer1.yAcc=0

//Set up menu
backAlpha=0
backColor=c_white

showOptions=0
useCommands=false

GOCursorInc=34
if global.easyModeUnlocked=1 and global.bNightmareMode=0 {GOMenuMax=5}
else {GOMenuMax=4}

if global.currentBoss=""
{
  if global.bossTrack>=101 and global.bossTrack<=999
  {
    GOMenuMin=1
    GOCursorPos=1
    GOCursorY=135
  }
  else //No boss or encounter
  {
    GOMenuMin=2
    GOCursorPos=2
    GOCursorY=169
  }
}
else
{
  GOMenuMin=1
  GOCursorPos=1
  GOCursorY=135
}

stopLoopingSounds()
stopAllMusic()
if global.quickGameOver=0 {playSound(global.snd_GameOver,0,1,1)}

if skipGameOver!=2
{
  image_speed=0.2
  for (i=0;i<7;i+=1) {background_foreground[i]=false}
  background_visible[7]=true
  background_foreground[7]=true
}
view_angle[0]=0

checkQuickGO=global.quickGameOver
if global.quickGameOver=1
{
  skipGameOver=0
  global.quickGameOver=0
  staticEffect=9
  background_alpha[7]=0
  backAlpha=1
}

confirmationMenu=0
confirmMenuPos=0 //0:Confirm, 1:Cancel
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if instance_exists(oPauseMenu)
{
  with oPauseMenu
  {
    oHUD.menuOpen=false
    instance_destroy()
  }
}
global.gamePaused=true
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if skipGameOver=2 //Skip Game Over
{
  backAlpha+=0.1*gDeltaTime
  if backAlpha>=1
  {
    if GOMenuMin=1 {event_user(3)}
    else {event_user(4)}
  }
}
else //Normal
{
  if global.optBitrateExplosion=1 and checkQuickGO=0 //No static
  {
    noStaticTime+=1
    if noStaticTime=2
    {
      background_alpha[7]=0
      backColor=c_black
    }
    else if noStaticTime>=3 and noStaticTime<=99
    {
      backAlpha+=0.05
      if backAlpha>=1 {noStaticTime=100}
    }
    else if noStaticTime=101
    {
      showOptions=1
    }
  }
  else
  {
    if staticEffect>=2 //fade to black
    {
      staticEffect+=1
      if staticEffect=3
      {
        background_alpha[7]=0
        backAlpha=1
      }
      else if staticEffect=10
      {
        backColor=c_black
        if showOptions=0 {showOptions=1}
      }
    }
    else //static effect
    {
      staticEffect+=0.04
      if staticEffect>=1.4 {staticEffect=2}
      background_alpha[7]=staticEffect
    }
  }

  if showOptions>0 and useCommands=false //Start options
  {
    showOptions+=1
    if showOptions=2 {playSound(global.snd_Continue,0,1,1)}
    if showOptions=5
    {
      with oBikeDestroyer {instance_destroy()}
      useCommands=true
    }
  }

  if useCommands=true
  {
    event_user(2)
    if confirmationMenu=0
    {
      if oKeyCodes.kCodePressed[4]=1 //Down
      {
        playSound(global.snd_MenuCursor,0,1,1)
        if GOCursorPos=GOMenuMax
        {
          if global.currentBoss=""
          {
            if global.bossTrack>=101 and global.bossTrack<=999
            {
              GOCursorPos=1
              GOCursorY-=GOCursorInc*(GOMenuMax-1)
            }
            else
            {
              GOCursorPos=2
              GOCursorY-=GOCursorInc*(GOMenuMax-2)
            }
          }
          else
          {
            GOCursorPos=1
            GOCursorY-=GOCursorInc*(GOMenuMax-1)
          }
        }
        else
        {
          GOCursorPos+=1
          GOCursorY+=GOCursorInc
        }
      }
      if oKeyCodes.kCodePressed[3]=1 //Up
      {
        playSound(global.snd_MenuCursor,0,1,1)
        if GOCursorPos=GOMenuMin
        {
          if global.currentBoss=""
          {
            if global.bossTrack>=101 and global.bossTrack<=999 {GOCursorY+=GOCursorInc*(GOMenuMax-1)}
            else {GOCursorY+=GOCursorInc*(GOMenuMax-2)}
          }
          else {GOCursorY+=GOCursorInc*(GOMenuMax-1)}
          GOCursorPos=GOMenuMax

        }
        else
        {
          GOCursorPos-=1
          GOCursorY-=GOCursorInc
        }
      }
      if oKeyCodes.kCodePressed[5]=1 //Confirm
      {
        resetKeyCodes()
        if GOCursorPos=1 //Retry Boss Fight / Encounter
        {
          event_user(3)
        }
        else if GOCursorPos=2 //Retry From Checkpoint (First option when no boss option is available)
        {
          event_user(4)
        }
        else if GOCursorPos=3 //Load From Save Data
        {
          confirmationMenu=1
        }
        else if GOCursorPos=4 //Return To Title Screen
        {
          confirmationMenu=2
        }
        else if GOCursorPos=5 //Change Difficulty
        {
          playSound(global.snd_MenuConfirm,0,1,1)
          if global.difficulty=1 {global.difficulty=2}
          else {global.difficulty=1}
        }
      }
    }
  }
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///Situational Game Over Msg
//============================== Situational Game Over messages ==============================
//-------------------- Main land --------------------
if room=rSacredTemple
  hintMessage="Wow... like wow. You figured out how to Game Over yourself even in here."
else if room=rMain_4 and global.gameProgress=6
  hintMessage="Use the environment to your advantage to avoid enemies. Just because you can't jump, doesn't mean you can't outsmart them."
else if room=rBossGallery
  hintMessage="It's either funny or sad that you died here. Mostly funny because you probably did it on purpose... right? I mean... you did die here on purpose didn't you?"
else if room=rPttT_05 and oPlayer1.x>=554 and oPlayer1.x<=598 and oPlayer1.y>=room_height
  hintMessage="You're getting desperate if you thought that was a secret path."
else if room=rCh21_WarshipSkies
  hintMessage="What? I mean this IS Distorted Travesty."
else if room=rBT_BrianA
{
  if instance_exists(oBTB_GetOnYoshi)
  {
    if oBTB_GetOnYoshi.endProg=3
      hintMessage="I understand. You wanted to be with him."
  }
}

//-------------------- Gate 1 --------------------
if room=rMario1_4
  hintMessage="Get past one spike chain at a time. Make a note of which ones are rotating with or against you."
else if room=rMario1_4Boss
  hintMessage="You're not supposed to lose after the boss fight is over with."
else if room=rMario1_7 and oPlayer1.x<48
{
  hintMessage="You should've known not to do that. Remember, smileys = bad things."
  var tCheckAchieve;
  tCheckAchieve=string_char_at(global.tokenRecognitions,21)
  if tCheckAchieve="0"
  {
    var tAchievement;
    tAchievement=instance_create(0,0,oAchievementNotice)
    tAchievement.myAchievement="Should Have Known"; tAchievement.checkNum=21
  }
}

//-------------------- Gate 2 --------------------
if room=rLink2_PalaceA_8 and oPlayer1.x>=1248 and oPlayer1.x<=1696 and oPlayer1.y>=room_height
  hintMessage="What? They're not exclusive to Mario World."
else if room=rLink2_CaveP_B2 and oPlayer1.y>=room_height
  hintMessage="Just had to try it, didn't you?"
if room=rLink2_DeathMount_A and oPlayer1.x>=768 and oPlayer1.x<=1568 and oPlayer1.y>=room_height
  hintMessage="WhattayaBrian jumped down here on purpose to check it too. Disregard this if you legit failed that jump."
else if room=rLink2_PalaceW_9 and oPlayer1.x>=1216 and oPlayer1.y>=room_height
  hintMessage="Somehow, I knew you would fall there."

//-------------------- Gate 3 --------------------
if room=rBelmont3_3D and oPlayer1.x>=1312 and oPlayer1.x<=1504 and oPlayer1.y>=room_height
  hintMessage="A red herring..."
if room=rBelmont3_5H and oPlayer1.y>=room_height
  hintMessage="Did you forget about your dash energy already?"

//-------------------- Gate 4 --------------------
if room=rMega4_StormC and oPlayer1.x<=256 and oPlayer1.y>=room_height
  hintMessage="Okay okay, that was mean of me."

//-------------------- Gate 6 --------------------
if room=rGame6_WindH and oPlayer1.x<=384
  hintMessage="Yeah, that happened."
else if room=rGame6_CoDS and oPlayer1.x>=224 and oPlayer1.x<=656 and oPlayer1.y>=room_height
  hintMessage="Heh heh, death by butts. Classic."
#define Other_11
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///Leaving Boss Gallery
//============================== Leaving Boss Gallery ==============================
if global.currentBoss="Bowser" {global.newMapX=264; global.newMapY=1376; room_goto(rBossGallery)}
else if global.currentBoss="Cackletta" {global.newMapX=408; global.newMapY=1376; room_goto(rBossGallery)}
else if global.currentBoss="Kamek" {global.newMapX=552; global.newMapY=1376; room_goto(rBossGallery)}
else if global.currentBoss="Helmethead" {global.newMapX=872; global.newMapY=1376; room_goto(rBossGallery)}
else if global.currentBoss="Dead Hand" {global.newMapX=1016; global.newMapY=1376; room_goto(rBossGallery)}
else if global.currentBoss="Barba" {global.newMapX=1160; global.newMapY=1376; room_goto(rBossGallery)}
else if global.currentBoss="Thunderbird" {global.newMapX=1304; global.newMapY=1376; room_goto(rBossGallery)}
else if global.currentBoss="Aqua Serpent" {global.newMapX=1608; global.newMapY=1344; room_goto(rBossGallery)}
else if global.currentBoss="Final Nightmare" {global.newMapX=1864; global.newMapY=1280; room_goto(rBossGallery)}
else if global.currentBoss="Control Virus" {global.newMapX=2008; global.newMapY=1280; room_goto(rBossGallery)}
else if global.currentBoss="Vampire Bat" {global.newMapX=2280; global.newMapY=1312; room_goto(rBossGallery)}
else if global.currentBoss="Dracula" {global.newMapX=2424; global.newMapY=1312; room_goto(rBossGallery)}
else if global.currentBoss="Menace" {global.newMapX=2568; global.newMapY=1312; room_goto(rBossGallery)}
else if global.currentBoss="Death"
{
  if global.bossTrack=1 {global.newMapX=2712; global.newMapY=1312; room_goto(rBossGallery)}
  else if global.bossTrack=2 {global.newMapX=2856; global.newMapY=1312; room_goto(rBossGallery)}
}
else if global.currentBoss="Blackmoor" {global.newMapX=2904; global.newMapY=1024; room_goto(rBossGallery)}
else if global.currentBoss="Enmity" {global.newMapX=2760; global.newMapY=1024; room_goto(rBossGallery)}
else if global.currentBoss="Maoh" {global.newMapX=2248; global.newMapY=1024; room_goto(rBossGallery)}
else if global.currentBoss="Storm Eagle" {global.newMapX=2104; global.newMapY=1024; room_goto(rBossGallery)}
else if global.currentBoss="Overdrive Ostrich" {global.newMapX=1960; global.newMapY=1024; room_goto(rBossGallery)}
else if global.currentBoss="Gravity Beetle" {global.newMapX=1704; global.newMapY=992; room_goto(rBossGallery)}
else if global.currentBoss="Bospider" {global.newMapX=1560; global.newMapY=992; room_goto(rBossGallery)}
else if global.currentBoss="Bit & Byte" {global.newMapX=1288; global.newMapY=1056; room_goto(rBossGallery)}
else if global.currentBoss="Sigma" {global.newMapX=1144; global.newMapY=1056; room_goto(rBossGallery)}
else if global.currentBoss="Sigma Epsilon" {global.newMapX=1000; global.newMapY=1056; room_goto(rBossGallery)}
else if global.currentBoss="Elpizo" {global.newMapX=744; global.newMapY=1088; room_goto(rBossGallery)}
else if global.currentBoss="Army Eye" {global.newMapX=600; global.newMapY=1088; room_goto(rBossGallery)}
else if global.currentBoss="Hex" {global.newMapX=360; global.newMapY=848; room_goto(rBossGallery)}
else if global.currentBoss="Shadow Form" {global.newMapX=504; global.newMapY=848; room_goto(rBossGallery)}
else if global.currentBoss="Vault Demon" {global.newMapX=648; global.newMapY=848; room_goto(rBossGallery)}
else if global.currentBoss="Arachnus" {global.newMapX=792; global.newMapY=848; room_goto(rBossGallery)}
else if global.currentBoss="King Worm" {global.newMapX=1016; global.newMapY=784; room_goto(rBossGallery)}
else if global.currentBoss="Kraid" {global.newMapX=1160; global.newMapY=784; room_goto(rBossGallery)}
else if global.currentBoss="Mother Brain" {global.newMapX=1304; global.newMapY=784; room_goto(rBossGallery)}
else if global.currentBoss="Ridley"
{
  if global.bossTrack=1 {global.newMapX=1496; global.newMapY=720; room_goto(rBossGallery)}
  else if global.bossTrack=2 {global.newMapX=1640; global.newMapY=720; room_goto(rBossGallery)}
  else if global.bossTrack=3 {global.newMapX=1784; global.newMapY=720; room_goto(rBossGallery)}
}
else if global.currentBoss="Nightmare" {global.newMapX=2040; global.newMapY=752; room_goto(rBossGallery)}
else if global.currentBoss="Sand Crawler" {global.newMapX=2184; global.newMapY=752; room_goto(rBossGallery)}
else if global.currentBoss="Malevolence" {global.newMapX=2328; global.newMapY=752; room_goto(rBossGallery)}
else if global.currentBoss="Leviathan" {global.newMapX=2472; global.newMapY=752; room_goto(rBossGallery)}

else if global.currentBoss="Stone Golem" {global.newMapX=2680; global.newMapY=464; room_goto(rBossGallery)}
else if global.currentBoss="Fire Elemental" {global.newMapX=2536; global.newMapY=464; room_goto(rBossGallery)}
else if global.currentBoss="High Heels Girl" {global.newMapX=2392; global.newMapY=464; room_goto(rBossGallery)}
else if global.currentBoss="Unforgotten" {global.newMapX=2152; global.newMapY=528; room_goto(rBossGallery)}
else if global.currentBoss="Chosen One" {global.newMapX=2008; global.newMapY=528; room_goto(rBossGallery)}
else if global.currentBoss="Sephiroth" {global.newMapX=1736; global.newMapY=464; room_goto(rBossGallery)}
else if global.currentBoss="Antipathy" {global.newMapX=1592; global.newMapY=464; room_goto(rBossGallery)}
else if global.currentBoss="Sera" {global.newMapX=1320; global.newMapY=496; room_goto(rBossGallery)}
else if global.currentBoss="Brain Machine" {global.newMapX=1176; global.newMapY=496; room_goto(rBossGallery)}
else if global.currentBoss="Blade Bot" {global.newMapX=1032; global.newMapY=496; room_goto(rBossGallery)}
else if global.currentBoss="Combat Apparatus" {global.newMapX=888; global.newMapY=496; room_goto(rBossGallery)}
else if global.currentBoss="Giant Blargg" {global.newMapX=712; global.newMapY=560; room_goto(rBossGallery)}
else if global.currentBoss="Defective" {global.newMapX=568; global.newMapY=560; room_goto(rBossGallery)}
else if global.currentBoss="Shadow Eura" {global.newMapX=184; global.newMapY=560; room_goto(rBossGallery)}
else if global.currentBoss="Decimator"
{
  if global.bossTrack=1 {global.newMapX=360; global.newMapY=352; room_goto(rBossGallery)}
  else if global.bossTrack=3 {global.newMapX=504; global.newMapY=352; room_goto(rBossGallery)}
}
else if global.currentBoss="Abomination" {global.newMapX=968; global.newMapY=256; room_goto(rBossGallery)}
else if global.currentBoss="Hex Final" {global.newMapX=1240; global.newMapY=256; room_goto(rBossGallery)}
else if global.currentBoss="Warmaster" {global.newMapX=1496; global.newMapY=224; room_goto(rBossGallery)}
else if global.currentBoss="Parasitic Seed" {global.newMapX=2168; global.newMapY=224; room_goto(rBossGallery)}
else if global.currentBoss="Virus Parasite" {global.newMapX=2312; global.newMapY=224; room_goto(rBossGallery)}
else if global.currentBoss="Hexor" {global.newMapX=2456; global.newMapY=224; room_goto(rBossGallery)}
else if global.currentBoss="The Executive" {global.newMapX=2776; global.newMapY=224; room_goto(rBossGallery)}
else if global.currentBoss="Warmaster EX" {global.newMapX=2920; global.newMapY=224; room_goto(rBossGallery)}
else if global.currentBoss="Fedex" {global.newMapX=888; global.newMapY=448; room_goto(rBT_HUB)}
#define Other_12
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///Confirmation menu
//Confirmation menu for 'Reverting to previous save' and 'Return to title screen'
if confirmationMenu>0
{
  if oKeyCodes.kCodePressed[3]=1
  {
    if confirmMenuPos=1
    {
      playSound(global.snd_MenuCursor,0,1,1)
      confirmMenuPos=0
    }
  }
  else if oKeyCodes.kCodePressed[4]=1
  {
    if confirmMenuPos=0
    {
      playSound(global.snd_MenuCursor,0,1,1)
      confirmMenuPos=1
    }
  }

  if oKeyCodes.kCodePressed[5]=1
  {
    if confirmMenuPos=0
    {
      if confirmationMenu=1 //Load
      {
        global.gamePaused=false
        initGameVars()
        loadSaveData()
        global.resetMusic=true
        room_goto(roomToPlace)
      }
      else if confirmationMenu=2 //Title Screen
      {
        playSound(global.snd_MenuCancel,0,1,1)
        room_goto(rTitle)
      }
    }
    else if confirmMenuPos=1
    {
      confirmMenuPos=0
      confirmationMenu=0
      io_clear()
      resetKeyCodes()
    }
  }
  else if oKeyCodes.kCodePressed[6]=1
  {
    confirmMenuPos=0
    confirmationMenu=0
    io_clear()
    resetKeyCodes()
  }
}
#define Other_13
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///RETRY BOSS
playSound(global.snd_Retry,0,1,1)
global.gamePaused=false; global.gameOver=false
//Ammo
global.hudLink_Arrows[0]=global.hudLink_Arrows[1]
global.hudBelmont_WeaponEn[0]=global.hudBelmont_WeaponEn[1]
global.hudSamus_Missiles[0]=global.hudSamus_Missiles[1]
room_restart()
#define Other_14
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///RETRY MAP
playSound(global.snd_Retry,0,1,1)
//Minimum life
if global.pMaxLife>=12 and global.pMaxLife<=16 {if global.pLife<12 {global.pLife=12}} //(3-4) 3
else if global.pMaxLife>=20 and global.pMaxLife<=24 {if global.pLife<16 {global.pLife=16}} //(5-6) 4
else if global.pMaxLife=28 {if global.pLife<20 {global.pLife=20}} //(7) 5
else if global.pMaxLife=32 {if global.pLife<24 {global.pLife=24}} //(8) 6
else if global.pMaxLife>=36 and global.pMaxLife<=40 {if global.pLife<28 {global.pLife=28}} //(9-10) 7
else if global.pMaxLife=44 {if global.pLife<32 {global.pLife=32}} //(11) 8
else if global.pMaxLife=48 {if global.pLife<36 {global.pLife=36}} //(12) 9
else if global.pMaxLife>=52 and global.pMaxLife<=56 {if global.pLife<40 {global.pLife=40}} //(13-14) 10
else if global.pMaxLife=60 {if global.pLife<44 {global.pLife=44}} //(15) 11
else if global.pMaxLife=64 {if global.pLife<48 {global.pLife=48}} //(16) 12
else if global.pMaxLife>=68 and global.pMaxLife<=72 {if global.pLife<52 {global.pLife=52}} //(17-18) 13
else if global.pMaxLife=76 {if global.pLife<56 {global.pLife=56}} //(19) 14
else if global.pMaxLife=80 {if global.pLife<60 {global.pLife=60}} //(20) 15
//Ammo
global.hudLink_Arrows[0]=global.hudLink_Arrows[1]
global.hudBelmont_WeaponEn[0]=global.hudBelmont_WeaponEn[1]
global.hudSamus_Missiles[0]=global.hudSamus_Missiles[1]

//Boss specific respawns
global.gamePaused=false; global.gameOver=false

if global.bBossGallery=1
{
  if global.currentBoss=""
  {
    room_restart()
  }
  else {event_user(1)}
}
else //Not in boss gallery
{
  if room=rWarshipZ_E3 //Fedex
  {
    global.bossTrack=0
    global.newMapX=888
    global.newMapY=448
    room_goto(rBT_HUB)
  }
  else if room=rBT_HelmetheadEX //Helmethead EX
  {
    global.bossTrack=0
    global.newMapX=1016
    global.newMapY=448
    room_goto(rBT_HUB)
  }
  else
  {
    if global.bossTrack=102 //TD -> Central City
    {
      global.bossTrack=0
      global.newMapX=1200
      global.newMapY=288
      room_goto(rCCity_NorthA)
    }
    else if global.bossTrack=110 //Dragoon -> Castle Balcony
    {
      global.bShooter=0
      global.bossTrack=0
      global.newMapX=864
      global.newMapY=320
      room_goto(rMC_N)
    }
    else
    {
      if global.bossTrack<1000 {global.bossTrack=0}

      if global.currentBoss="Army Eye"
      {
        global.rmDeaths=0
        global.currentBoss=""
        global.newMapX=176; global.newMapY=304; room_goto(rBubbleTowerA6)
      }
      else if global.currentBoss="Storm Eagle"
      {
        global.rmDeaths=0
        global.currentBoss=""
        global.newMapX=4544; global.newMapY=176; room_goto(rMega4_StormD)
      }
      else if global.currentBoss="Overdrive Ostrich"
      {
        global.rmDeaths=0
        global.currentBoss=""
        global.newMapX=8656; global.newMapY=272; room_goto(rMega4_OstrichD)
      }
      else if global.currentBoss="Gravity Beetle"
      {
        global.rmDeaths=0
        global.currentBoss=""
        global.newMapX=3824; global.newMapY=592; room_goto(rMega4_ToxicJungleD)
      }
      else if global.currentBoss="Bospider"
      {
        global.rmDeaths=0
        global.currentBoss=""
        global.newMapX=3744; global.newMapY=224; room_goto(rMega4_SigmaA4)
      }
      else if global.currentBoss="Bit"
      {
        global.rmDeaths=0
        global.currentBoss=""
        global.newMapX=48; global.newMapY=288; room_goto(rMega4_SigmaB2)
      }
      else if global.currentBoss="Byte"
      {
        global.rmDeaths=0
        global.currentBoss=""
        global.newMapX=48; global.newMapY=3008; room_goto(rMega4_SigmaB4)
      }
      else if global.currentBoss="Bit & Byte"
      {
        global.rmDeaths=0
        global.currentBoss=""
        global.newMapX=1168; global.newMapY=288; room_goto(rMega4_SigmaB7)
      }
      else if global.currentBoss="Sigma" or global.currentBoss="Sigma Epsilon"
      {
        global.rmDeaths=0
        global.currentBoss=""
        global.newMapX=2736; global.newMapY=288; room_goto(rMega4_SigmaC4)
      }
      else if global.currentBoss="Parasitic Seed"
      {
        global.rmDeaths=0
        global.currentBoss=""
        global.newMapX=272; global.newMapY=208; room_goto(rPttT_06)
      }
      else if global.currentBoss="Virus Parasite"
      {
        global.rmDeaths=0
        global.currentBoss=""
        global.newMapX=400; global.newMapY=216; room_goto(rAbomE)
      }
      else
      {
        global.currentBoss=""
        if global.location=49 //Gate 5 retry spawn
        {
          global.pLife=global.pMaxLife
          global.hudSamus_Missiles[0]=global.hudSamus_Missiles[1]
          global.bCanSave=true
          global.newMapX=global.metCheckpoint[1]
          global.newMapY=global.metCheckpoint[2]
          room_goto(global.metCheckpoint[0])
        }
        else if room=rWarshipZ_EscapeA or room=rWarshipZ_EscapeB or room=rWarshipZ_EscapeC or room=rWarshipZ_EscapeD //Final segment
        {
          global.forceTime=3600
          global.newMapX=1392
          global.newMapY=256
          room_goto(rWarshipZ_EscapeA)
        }
        else //Normal retry spawn
        {
          room_restart()
        }
      }
    }
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Background
draw_set_alpha(backAlpha)
draw_set_color(backColor)
draw_rectangle(view_xview[0]-1,view_yview[0]-1,view_xview[0]+view_wview[0]+1,view_yview[0]+view_hview[0]+1,false)

if showOptions>0
{
  //Game Over
  draw_set_halign(fa_center)
  draw_set_color(c_white)
  draw_set_alpha(1)
  draw_set_font(fnt_GameOver)
  draw_text(view_xview[0]+240,view_yview[0]+30,"GAME OVER")
  draw_set_font(fnt_Points)
  draw_set_color(failColor)
  draw_text(view_xview[0]+240,view_yview[0]+68,failMessage)
  draw_set_font(fnt_GOoptions)
  draw_set_color(c_white)
  if global.currentBoss!="" or global.bossTrack>=101 and global.bossTrack<=999
  {
    menuStartY=135
    if global.easyModeUnlocked=1 and global.bNightmareMode=0 {menuSelections=5}
    else {menuSelections=4}

  }
  else
  {
    menuStartY=169
    if global.easyModeUnlocked=1 and global.bNightmareMode=0 {menuSelections=4}
    else {menuSelections=3}
  }

  //Display menu selection braces
  for(i=0;i<menuSelections;i+=1)
  {
    draw_sprite(sGameOverCursor,0,view_xview[0]+240,view_yview[0]+menuStartY+(i*34))
  }
  //Display cursor
  if useCommands=true
    draw_sprite(sGameOverCursor,1,view_xview[0]+240,view_yview[0]+GOCursorY)

  //Display menu selections
  if global.currentBoss!=""
    draw_text(view_xview[0]+240,view_yview[0]+126,"Retry from Checkpoint")
  else if global.bossTrack>=101 and global.bossTrack<=109
    draw_text(view_xview[0]+240,view_yview[0]+126,"Retry Encounter")
  else if global.bossTrack=110
    draw_text(view_xview[0]+240,view_yview[0]+126,"Retry from Checkpoint")

  if global.currentBoss!=""
    draw_text(view_xview[0]+240,view_yview[0]+160,"Leave Boss Encounter")
  else
  {
    if global.bossTrack=102
      draw_text(view_xview[0]+240,view_yview[0]+160,"Return to Central City")
    else if global.bossTrack=110
      draw_text(view_xview[0]+240,view_yview[0]+160,"Back to Castle Balcony")
    else if global.bossTrack=1000
      draw_text(view_xview[0]+240,view_yview[0]+160,"No Turning Back Now")
    else
      draw_text(view_xview[0]+240,view_yview[0]+160,"Retry from Checkpoint")
  }
  draw_text(view_xview[0]+240,view_yview[0]+194,"Load from Last Save")
  draw_text(view_xview[0]+240,view_yview[0]+228,"Return to Title Screen")

  if global.easyModeUnlocked=1 and global.bNightmareMode=0
  {
    draw_text(view_xview[0]+240,view_yview[0]+262,"Game Mode --")
    var tDifficulty;
    if global.difficulty=1 {tDifficulty="Assist"}
    else if global.difficulty=2 {tDifficulty="Standard"}
    draw_text(view_xview[0]+405,view_yview[0]+262,tDifficulty)
  }

  //Display hint
  draw_set_font(fnt_Points)
  draw_set_halign(fa_left)
  draw_text_ext(view_xview[0]+68,view_yview[0]+300,hintMessage,12,344)

  if confirmationMenu>0 //Confirmation menu
  {
    var tConfirmMenuX,tConfirmMenuY;
    tConfirmMenuX=view_xview[0]+195
    tConfirmMenuY=view_yview[0]+152
    draw_sprite(sMenu_ConfirmMenu,0,tConfirmMenuX,tConfirmMenuY)
    draw_sprite(sPauseM_AbilArrow,0,tConfirmMenuX+15,tConfirmMenuY+14+(confirmMenuPos*19))
  }
}
