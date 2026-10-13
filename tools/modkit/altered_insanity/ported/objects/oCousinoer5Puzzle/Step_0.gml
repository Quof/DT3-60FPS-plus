if room=rBT_Cousinoer5HUB_Newer
{
    if global.cousinoer5Progress = 0
    {
        if sceneProgress < 2
        {
            global.gamePaused=true
            sceneProgress=2
        }
          if sceneProgress=2 and bWaitForInput=false
            msgCreate(0,0,"Claire","Great, we go into a door and immediately run into an impassable barrier. Welp good job team, see you next mission!",0,3,oMessageCutscene,1)
          else if sceneProgress=3 and bWaitForInput=false
            msgCreate(0,0,"Jerry","There's gotta be a switch or something around here, you can't just trap the player in a desolate room like this.",0,3,oMessageCutscene,1)
          else if sceneProgress=4 and bWaitForInput=false
            msgCreate(0,0,"Claire","Where do you see a switch, Jerry? There's no nooks, or crannies, it's an empty room.",0,3,oMessageCutscene,1)
          else if sceneProgress=5 and bWaitForInput=false
            msgCreate(0,0,"Jerry","Uh... Konami Code?",0,3,oMessageCutscene,1)
          else if sceneProgress=6 and bWaitForInput=false
            msgCreate(0,0,"Jeremy","Hold on guys... I'm getting an anonymous message... " + chr(34) + "This room was instrumental in your quest." + chr(34),0,3,oMessageCutscene,1)
          else if sceneProgress=7 and bWaitForInput=false
            msgCreate(0,0,"Jerry","Ah I knew it was a switch! It was just in a completely different area, now to solve the riddle of where it is...",0,3,oMessageCutscene,1)
          else if sceneProgress=8
          {
            global.cousinoer5Progress = 1
            global.gamePaused=false
            var file;
            file = file_text_open_write(working_directory + "\Mystery.txt");
            file_text_write_string(file, "RIDDLE: This room was instrumental in your quest.")
            file_text_close(file);
          }
    }
}

if room=rC5_Piano
{
    if global.cousinoer5Progress=1
    {
        if sceneProgress < 2
        {
            global.gamePaused=true
            sceneProgress=2
        }
          if sceneProgress=2 and bWaitForInput=false
            msgCreate(0,0,"Jerry","What's a piano doing here?",0,3,oMessageCutscene,1)
          else if sceneProgress=3 and bWaitForInput=false
            msgCreate(0,0,"Claire","Guess that's your switch. Go ahead, play me a ditty.",0,3,oMessageCutscene,1)
          else if sceneProgress=4 and bWaitForInput=false
            msgCreate(0,0,"Jerry","I don't know any ditties, I don't even know how to play a piano! Do you?",0,3,oMessageCutscene,1)
          else if sceneProgress=5 and bWaitForInput=false
            msgCreate(0,0,"Claire","Nope.",0,3,oMessageCutscene,1)
          else if sceneProgress=6 and bWaitForInput=false
            msgCreate(0,0,"Jeremy","This is an unconventional piano anyway, I'm sure no training is necessary. But what to play is a different question.",0,3,oMessageCutscene,1)
          else if sceneProgress=7 and bWaitForInput=false
            msgCreate(0,0,"Jerry","We'll probably have to find clues as to what to play.",0,3,oMessageCutscene,1)
          else if sceneProgress=8 and bWaitForInput=false
            msgCreate(0,0,"Claire","I'm sure those birds will tell us.",0,3,oMessageCutscene,1)
          else if sceneProgress=9
          {
            global.cousinoer5Progress = 6
            sceneProgress = 0
            global.gamePaused=false
            var file;
            file = file_text_open_write(working_directory + "\Mystery.txt");
            file_text_write_string(file, "RIDDLE: Learn from the birds what song to play on the piano")
            file_text_close(file);
          }
    }
    if global.cousinoer5Progress=11
    {
        if sceneProgress < 2
        {
            global.gamePaused=true
            sceneProgress=2
        }
          if sceneProgress=2 and bWaitForInput=false
            msgCreate(0,0,"Jeremy","Hey! You guys solved it, good job.",0,3,oMessageCutscene,1)
          else if sceneProgress=3 and bWaitForInput=false
            msgCreate(0,0,"Claire","I always wondered when those birds in Central City would become relevant.",0,3,oMessageCutscene,1)
          else if sceneProgress=4 and bWaitForInput=false
            msgCreate(0,0,"Jerry","It's helpful that the birds here looked like the musical birds, without knowing what to look for it'd be impossible. These birds are everywhere!",0,3,oMessageCutscene,1)
          else if sceneProgress=5 and bWaitForInput=false
            msgCreate(0,0,"Jeremy","So, ready for the next one?",0,3,oMessageCutscene,1)
          else if sceneProgress=6 and bWaitForInput=false
            msgCreate(0,0,"Jerry","More piano playing? What else would we have to play?",0,3,oMessageCutscene,1)
          else if sceneProgress=7 and bWaitForInput=false
            msgCreate(0,0,"Jeremy","No more piano, this will be more your guys' speed: A new area has opened up somewhere",0,3,oMessageCutscene,1)
          else if sceneProgress=8 and bWaitForInput=false
            msgCreate(0,0,"Jerry","Oh man, platforming stuff? Amazing! Where is 'somewhere'?",0,3,oMessageCutscene,1)
          else if sceneProgress=9 and bWaitForInput=false
            msgCreate(0,0,"Jeremy","I'm not entirely sure, the signal is obfuscated, but there's a hint.",0,3,oMessageCutscene,1)
          else if sceneProgress=10 and bWaitForInput=false
            msgCreate(0,0,"Jeremy","The song you just played, it's from a certain game franchise. Go to the area of that game franchise and find the bird's former home.",0,3,oMessageCutscene,1)
          else if sceneProgress=11 and bWaitForInput=false
            msgCreate(0,0,"Jerry","Where are you getting these cryptic clues from?",0,3,oMessageCutscene,1)
          else if sceneProgress=12 and bWaitForInput=false
            msgCreate(0,0,"Jeremy","I don't know, words just pop up on my screen, can't trace the source at all.",0,3,oMessageCutscene,1)
          else if sceneProgress=13 and bWaitForInput=false
            msgCreate(0,0,"Claire","Could it be Hex?",0,3,oMessageCutscene,1)
          else if sceneProgress=14 and bWaitForInput=false
            msgCreate(0,0,"Jeremy","Doubtful, he's retreated to his little hole where he thinks he has control. He has nothing, I can kick his ass any time, but I'm interested in where this all leads.",0,3,oMessageCutscene,1)
          else if sceneProgress=15 and bWaitForInput=false
            msgCreate(0,0,"Jerry","Same, I'm always game for some more challenges thrown my way. After you ruin Hex's day, who knows if we'll have anymore intense action like this?",0,3,oMessageCutscene,1)
          else if sceneProgress=16 and bWaitForInput=false
            msgCreate(0,0,"Claire","Ah yes, the intense action of playing a piano.",0,3,oMessageCutscene,1)
          else if sceneProgress=17 and bWaitForInput=false
            msgCreate(0,0,"Jerry","They can't all be intense, I bet wherever we're going next will be something insane though.",0,3,oMessageCutscene,1)
          else if sceneProgress=18
          {
            var file;
            file = file_text_open_write(working_directory + "\Mystery.txt");
            file_text_write_string(file, "RIDDLE: The song you just played, it's from a certain game franchise. Go to the area of that game franchise and find the bird's former home.")
            file_text_close(file);
            global.cousinoer5Progress = 22
            global.gamePaused=false
          }
    }
}

//start of no walk segment
if room=rC5_NoWalk1
{
    if global.cousinoer5Progress = 22
    {
        if sceneProgress < 2
          {
          charSwitcher(0)
          global.gamePaused=true
          sceneProgress=2
          }
          if sceneProgress=2 and bWaitForInput=false
            msgCreate(0,0,"Jerry","...Uh, Jeremy? I can't walk anymore.",0,3,oMessageCutscene,1)
          else if sceneProgress=3 and bWaitForInput=false
            msgCreate(0,0,"Claire","Is this Hex's virus again?",0,3,oMessageCutscene,1)
          else if sceneProgress=4 and bWaitForInput=false
            msgCreate(0,0,"Jeremy","No, you can't walk either Claire, this area surpressed that function somehow...",0,3,oMessageCutscene,1)
          else if sceneProgress=5 and bWaitForInput=false
            msgCreate(0,0,"Jerry","So what are we supposed to do? I assume something special lies at the end of this.",0,3,oMessageCutscene,1)
          else if sceneProgress=6 and bWaitForInput=false
            msgCreate(0,0,"Jeremy","Hmmm... Looks like it only took away walking, you still have dashes and jumps.",0,3,oMessageCutscene,1)
          else if sceneProgress=7 and bWaitForInput=false
            msgCreate(0,0,"Jerry","Well that's a real pain in the ass.",0,3,oMessageCutscene,1)
          else if sceneProgress=8 and bWaitForInput=false
            msgCreate(0,0,"Jeremy","Just remember, you can slow your dash in mid air by holding back. I assume you know the general naunce of your respective dashes.",0,3,oMessageCutscene,1)
          else if sceneProgress=9
          {
            //definitely test this section, either using save editing or borrowing Neil's save
            if global.pKeys > 0
            {
                sceneProgress = 10
                //Sorry Neil :(
                global.pKeys = 0
                global.lockedDoor = "11111111111111111000000000000000000000000000000000"
            }
            else
            {
                sceneProgress = 20
            }
          }
          else if sceneProgress=10 and bWaitForInput=false
            msgCreate(0,0,"Jeremy","By the way, I'm sensing some locked doors in the area.",0,3,oMessageCutscene,1)
          else if sceneProgress=11 and bWaitForInput=false
            msgCreate(0,0,"Jerry","Heh, well good thing I've got these spare keys because of my sick sequence break skills!",0,3,oMessageCutscene,1)
          else if sceneProgress=12 and bWaitForInput=false
            msgCreate(0,0,"Jeremy","Sorry to say, but those keys have been bouncing around in your pocket through all the craziness, looks like they're blunted beyond repair.",0,3,oMessageCutscene,1)
          else if sceneProgress=13 and bWaitForInput=false
            msgCreate(0,0,"Jerry","Oh damn, I knew I should've stored these elsewhere when I learned the door skips!",0,3,oMessageCutscene,1)
          else if sceneProgress=14 and bWaitForInput=false
            msgCreate(0,0,"Claire","Great, Jerry, now we can't open all the doors in the world. Goodbye 100% run...",0,3,oMessageCutscene,1)
          else if sceneProgress=15 and bWaitForInput=false
            msgCreate(0,0,"Jeremy","Nah you're good, I hacked those doors that should've been open so that they are.",0,3,oMessageCutscene,1)
          else if sceneProgress=16 and bWaitForInput=false
            msgCreate(0,0,"Claire","Well can't you just hack the doors in this area open too then?",0,3,oMessageCutscene,1)
          else if sceneProgress=17 and bWaitForInput=false
            msgCreate(0,0,"Jerry","I bet there's some sort of protection on this area.",0,3,oMessageCutscene,1)
          else if sceneProgress=18 and bWaitForInput=false
            msgCreate(0,0,"Jeremy","Nah, I just wanna watch you guys struggle to find the keys in this new area.",0,3,oMessageCutscene,1)
          else if sceneProgress=19 and bWaitForInput=false
            msgCreate(0,0,"Claire","Jerk!",0,3,oMessageCutscene,1)
          else if sceneProgress = 20
          {
          global.cousinoer5Progress = 87
            global.gamePaused=false
            var file;
            file = file_text_open_write(working_directory + "\Mystery.txt");
            file_text_write_string(file, "You have entered the No Walk zone, complete the challenges within to continue your journey")
            file_text_close(file);
          }
    }
}
//scene 2 in no walk
if room=rC5_NoWalk7
{
    if global.cousinoer5Progress = 87
    {
        if sceneProgress < 2
          {
          global.gamePaused=true
          sceneProgress=2
          }
          if sceneProgress=2 and bWaitForInput=false
            msgCreate(0,0,"Claire","So... What is this place? It's so strange.",0,3,oMessageCutscene,1)
          else if sceneProgress=3 and bWaitForInput=false
            msgCreate(0,0,"Jeremy","From what I can tell, it looks like it's data that got lost when the darkness consumed everything.",0,3,oMessageCutscene,1)
          else if sceneProgress=4 and bWaitForInput=false
            msgCreate(0,0,"Jerry","So why is it here?",0,3,oMessageCutscene,1)
          else if sceneProgress=5 and bWaitForInput=false
            msgCreate(0,0,"Jeremy","Whoever is feeding me these clues seems to be unveiling these places in remote corners of the world, but to what end? I don't know.",0,3,oMessageCutscene,1)
          else if sceneProgress=6 and bWaitForInput=false
            msgCreate(0,0,"Claire","I know Hex is moping in some little pit, but could there be someone more powerful than him?",0,3,oMessageCutscene,1)
          else if sceneProgress=7 and bWaitForInput=false
            msgCreate(0,0,"Jeremy","If there was, I'd be able to see them. Since Hex took his ball and went home I have much more access on the fourth wall.",0,3,oMessageCutscene,1)
          else if sceneProgress=8 and bWaitForInput=false
            msgCreate(0,0,"Chao","But wait, aren't you standing in the desert in your mech suit? How'd you get back to the fourth wall?",0,3,oMessageCutscene,1)
          else if sceneProgress=9 and bWaitForInput=false
            msgCreate(0,0,"Jeremy","When you go through the Video Games Pipe, I get plopped back on the fourth wall.",0,3,oMessageCutscene,1)
          else if sceneProgress=10 and bWaitForInput=false
            msgCreate(0,0,"Jerry","That sounds dubious, but who am I to question video game logic?",0,3,oMessageCutscene,1)
          else if sceneProgress=11
          {
            global.cousinoer5Progress = 88
            global.gamePaused=false
          }
    }
}
//scene 3 in no walk and split room logic
if room=rC5_NoWalk15
{
    if global.cousinoer5Progress = 88
    {
        if sceneProgress < 2
          {
          global.gamePaused=true
          sceneProgress=2
          }
          if sceneProgress=2 and bWaitForInput=false
            msgCreate(0,0,"Jerry","Woah! Why am I way over here?",0,3,oMessageCutscene,1)
          else if sceneProgress=3 and bWaitForInput=false
            msgCreate(0,0,"Jeremy","It happened so inhumanly fast... Something opened up a dimensional rift to split you two up.",0,3,oMessageCutscene,1)
          else if sceneProgress=4 and bWaitForInput=false
            msgCreate(0,0,"Jerry","Oh no, we know what that means...",0,3,oMessageCutscene,1)
          else if sceneProgress=5 and bWaitForInput=false
            msgCreate(0,0,"Claire","Keys, puzzles, and relying on Jerry to do his part.",0,3,oMessageCutscene,1)
          else if sceneProgress=6 and bWaitForInput=false
            msgCreate(0,0,"Jerry","Same to you. We're facing different directions, so that's another layer of craziness I'm just not prepared for.",0,3,oMessageCutscene,1)
          else if sceneProgress=7 and bWaitForInput=false
            msgCreate(0,0,"Claire","After 14 rooms of this we should have our limitations figured out.",0,3,oMessageCutscene,1)
          else if sceneProgress=8 and bWaitForInput=false
            msgCreate(0,0,"Jeremy","Watch out guys, as you progress through the puzzles enemies will appear.",0,3,oMessageCutscene,1)
          else if sceneProgress=9 and bWaitForInput=false
            msgCreate(0,0,"Claire","I noticed a distinct lack of insta death spikes, guess it's gotta be made up somewhere.",0,3,oMessageCutscene,1)
          else if sceneProgress=10 and bWaitForInput=false
            msgCreate(0,0,"Jerry","Haven't fought enemies in this situation... But it'll be cake with our infinite dash!",0,3,oMessageCutscene,1)
          else if sceneProgress=11 and bWaitForInput=false
            msgCreate(0,0,"Jeremy","Lest you forget the red attacks.",0,3,oMessageCutscene,1)
          else if sceneProgress=12 and bWaitForInput=false
            msgCreate(0,0,"Jerry","There's always a catch...",0,3,oMessageCutscene,1)
          else if sceneProgress=13 and bWaitForInput=false
            msgCreate(0,0,"Claire","There's also the fact that my dash takes me upward, so I can't just dash dance like you can.",0,3,oMessageCutscene,1)
          else if sceneProgress=14 and bWaitForInput=false
            msgCreate(0,0,"Jerry","And who's fault is that?",0,3,oMessageCutscene,1)
          else if sceneProgress=15 and bWaitForInput=false
            msgCreate(0,0,"Claire","Probably yours.",0,3,oMessageCutscene,1)
          else if sceneProgress=16 and bWaitForInput=false
            msgCreate(0,0,"Jerry","If you're so scared, all we can do is hope most enemy encounters happen to me.",0,3,oMessageCutscene,1)
          else if sceneProgress=17 and bWaitForInput=false
            msgCreate(0,0,"Claire","I'm going to count them, and then be really mad when I end up having more than you.",0,3,oMessageCutscene,1)
          else if sceneProgress=18
          {
            global.cousinoer5Progress = 90
            global.gamePaused=false
            sceneProgress = 0
            sceneTime = 0
          }
    }
    
    //enemy spawns throughout the puzzle
    if global.cousinoer5Progress = 90
    {
                   //sceneTime+=1
                   if sceneTime=0 {sceneTime=1-gDeltaTime} //60fps change (added): 1 on the first frame, as at 30fps
                   sceneTime+=1*gDeltaTime //60fps change
          //Claire on the way to switch 2
          if sceneProgress=0
          {
            if oPlayer1.x<=960 and oPlayer1.x >= 900 and oPlayer1.y <= 336 and oPlayer1.y >= 272 and global.activeCharacter = 1
            {
              var enemyBarrier;
              delaySpawn(1088,368,oVaultMoth,0,1,1,0.33)
              delaySpawn(1232,368,oVaultShadow,0,1,1,0.33)
              enemyBarrier=instance_create(896,208,oEnemyBarrier); enemyBarrier.image_yscale=4
              sceneProgress+=1
              sceneTime=0
            }
          }
          else if sceneProgress=1
          {
            if sceneTime > 100
            {
                if !instance_exists(oEnemyBase)
                {
                  with oEnemyBarrier {instance_destroy()}
                  sceneProgress+=1
                  sceneTime=0
                }
            }
          }
          //Jerry on the way to reverse switch
          else if sceneProgress=2
          {
            if sceneTime = 1
            {
                msgCreate(0,0,"Claire","That's 1 for me.",0,3,oMessagePerson,0)
                newMessage.fadingTime=100
            }
            if sceneTime = 100
            {
                msgCreate(0,0,"Jerry","That didn't look that tough. Let's call that a half.",0,3,oMessagePerson,0)
                newMessage.fadingTime=100
            }
            if sceneTime = 200
            {
                msgCreate(0,0,"Claire","An encounter is an encounter, Jerry. You can't say it's only half. Plus I'm sure it'll ramp up quick.",0,3,oMessagePerson,0)
                newMessage.fadingTime=100
            }
            if oPlayer1.x<=230 and oPlayer1.x >= 212 and oPlayer1.y <= 500 and oPlayer1.y >= 410 and global.activeCharacter = 0
            {
              var enemyBarrier;
              delaySpawn(304,496,oHammaHammaMain,0,1,1,0.33)
              delaySpawn(176,416,oHammaHammaMain,0,1,1,0.33)
              delaySpawn(64,368,oHammaHammaMain,0,1,1,0.33)
              enemyBarrier=instance_create(448,336,oEnemyBarrier); enemyBarrier.image_yscale=8
              enemyBarrier=instance_create(192,432,oEnemyBarrier); enemyBarrier.image_yscale=8
              enemyBarrier=instance_create(16,144,oEnemyBarrier); enemyBarrier.image_yscale=14
              sceneProgress+=1
              sceneTime=0
            }
          }
          else if sceneProgress=3
          {
            if sceneTime > 100
            {
                if !instance_exists(oEnemyBase)
                {
                  with oEnemyBarrier {instance_destroy()}
                  sceneProgress+=1
                  sceneTime=0
                }
            }
          }
          //Claire after opening skull key door (small hallway)
          else if sceneProgress=4
          {
            if sceneTime = 1
            {
                msgCreate(0,0,"Jerry","Now we're even.",0,3,oMessagePerson,0)
                newMessage.fadingTime=100
            }
            if sceneTime = 100
            {
                msgCreate(0,0,"Claire","Hopefully that's how it goes, one for me, one for you.",0,3,oMessagePerson,0)
                newMessage.fadingTime=100
            }
            if sceneTime = 200
            {
                msgCreate(0,0,"Jerry","Probably, question is who's gonna get the really rude encounter, hope it ain't me!",0,3,oMessagePerson,0)
                newMessage.fadingTime=100
            }
            if oPlayer1.x<=640 and oPlayer1.x >= 600 and oPlayer1.y <= 512 and oPlayer1.y >= 432
            {
              var enemyBarrier;
              delaySpawn(624,512,oShieldMenace,0,1,1,0.33)
              delaySpawn(768,512,oShieldMenace,0,1,1,0.33)
              enemyBarrier=instance_create(592,448,oEnemyBarrier); enemyBarrier.image_yscale=4
              enemyBarrier=instance_create(784,448,oEnemyBarrier); enemyBarrier.image_yscale=4
              sceneProgress+=1
              sceneTime=0
            }
          }
          else if sceneProgress=5
          {
            if sceneTime > 100
            {
                if !instance_exists(oEnemyBase)
                {
                  with oEnemyBarrier {instance_destroy()}
                  sceneProgress+=1
                  sceneTime=0
                }
            }
          }
          //Claire on top of area (another hallway)
          else if sceneProgress=6
          {
            if sceneTime = 1
            {
                msgCreate(0,0,"Claire","Two. That one was pretty rude, stuck in a small hallway with two spooky skeleton warriors",0,3,oMessagePerson,0)
                newMessage.fadingTime=100
            }
            if sceneTime = 100
            {
                msgCreate(0,0,"Jerry","Eh. I've seen worse. Tougher than your last one for sure though.",0,3,oMessagePerson,0)
                newMessage.fadingTime=100
            }
            if sceneTime = 200
            {
                msgCreate(0,0,"Claire","Just wait, I'm sure the worst is waiting right at the end.",0,3,oMessagePerson,0)
                newMessage.fadingTime=100
            }
            if oPlayer1.x<=700 and oPlayer1.x >= 672 and oPlayer1.y <= 112 and oPlayer1.y >= 0
            {
              var enemyBarrier;
              delaySpawn(592,112,oDragonKnight,0,1,1,0.33)
              delaySpawn(832,112,oBloodTyrant,0,1,1,0.33)
              enemyBarrier=instance_create(544,-128,oEnemyBarrier); enemyBarrier.image_yscale=15
              enemyBarrier=instance_create(880,-128,oEnemyBarrier); enemyBarrier.image_yscale=15
              sceneProgress+=1
              sceneTime=0
            }
          }
          else if sceneProgress=7
          {
            if sceneTime > 100
            {
                if !instance_exists(oEnemyBase)
                {
                  with oEnemyBarrier {instance_destroy()}
                  sceneProgress+=1
                  sceneTime=0
                }
            }
          }
          //Jerry in the top left
          else if sceneProgress=8
          {
            if sceneTime = 1
            {
                msgCreate(0,180,"Claire","Three! A Dragon Knight AND a Blood Tyrant!? That's nuts.",0,3,oMessagePerson,0)
                newMessage.fadingTime=100
            }
            if sceneTime = 100
            {
                msgCreate(0,180,"Jerry","You beat em though, that's all that matters.",0,3,oMessagePerson,0)
                newMessage.fadingTime=100
            }
            if sceneTime = 200
            {
                msgCreate(0,180,"Claire","Easy for you to say, you're sitting pretty barely fighting anything.",0,3,oMessagePerson,0)
                newMessage.fadingTime=100
            }
            if oPlayer1.x<=200 and oPlayer1.x >= 0 and oPlayer1.y <= 140 and oPlayer1.y >= 0 and global.activeCharacter = 0
            {
              var enemyBarrier, elecTrap;
              instance_create(224,-16,oHugeAssWall)
              //delaySpawn(224,-16,oHugeAssWall,0,1,1,0.33)
              enemyBarrier=instance_create(336,64,oEnemyBarrier); enemyBarrier.image_yscale=4
              enemyBarrier=instance_create(64,0,oEnemyBarrier); enemyBarrier.image_yscale=8              
              sceneProgress+=1
              sceneTime=0
            }
          }
          else if sceneProgress=9
          {
            if sceneTime > 100
            {
                if !instance_exists(oEnemyBase)
                {
                  with oEnemyBarrier {instance_destroy()}
                  with oMovingTrapRed {instance_destroy()}
                  sceneProgress+=1
                  sceneTime=0
                }
            }
          }
          //Claire in the top right
          else if sceneProgress=10
          {
            if sceneTime = 1
            {
                msgCreate(0,180,"Jerry","There you go, I'm at 2 now",0,3,oMessagePerson,0)
                newMessage.fadingTime=100
            }
            if sceneTime = 100
            {
                msgCreate(0,180,"Claire","Oh wow, one single wall with a glowing weak spot. So tough.",0,3,oMessagePerson,0)
                newMessage.fadingTime=100
            }
            if sceneTime = 200
            {
                msgCreate(0,180,"Jerry","Hey, who said you can't call it a half encounter? Two.",0,3,oMessagePerson,0)
                newMessage.fadingTime=100
            }
            if oPlayer1.x<=1248 and oPlayer1.x >= 1008 and oPlayer1.y <= 272 and oPlayer1.y >= 192 and global.activeCharacter = 1
            {
              var enemyBarrier;
              delaySpawn(1040,272,oCHAOS_Sniper,0,1,1,0.33)
              //delaySpawn(992,144,oCHAOS_Sniper,0,1,1,0.33)
              delaySpawn(1120,160,oCHAOS_Rocketeer,0,1,1,0.33)
              delaySpawn(1216,32,oCHAOS_Rocketeer,0,1,1,0.33)
              enemyBarrier=instance_create(1120,288,oEnemyBarrier); enemyBarrier.image_yscale=9; enemyBarrier.image_angle = 90
              sceneProgress+=1
              sceneTime=0
            }
          }
          else if sceneProgress=11
          {
            if sceneTime > 100
            {
                if !instance_exists(oEnemyBase)
                {
                  with oEnemyBarrier {instance_destroy()}
                  sceneProgress+=1
                  sceneTime=0
                }
            }
          }
          //Both after entering their party barriers chicken spawn
          else if sceneProgress=12
          {
            if sceneTime = 1
            {
                msgCreate(0,180,"Jerry","Wow, that one looked rough. You're taking the brunt of these encounters.",0,3,oMessagePerson,0)
                newMessage.fadingTime=100
            }
            if sceneTime = 100
            {
                msgCreate(0,180,"Claire","Glad you understand. It's 4-2 now.",0,3,oMessagePerson,0)
                newMessage.fadingTime=100
            }
            if sceneTime = 200
            {
                msgCreate(0,180,"Jerry","There's still some room left, I could get ambushed any time.",0,3,oMessagePerson,0)
                newMessage.fadingTime=100
            }
            if (478464).isActive=1 and (478465).isActive=1
            {
              sceneProgress+=1
              sceneTime=0
            }
          }
          else if sceneProgress=13
          {
            if sceneTime = 1
            {
                msgCreate(0,0,"Jeremy","A bunch of angry chickens are coming, RUN!",0,3,oMessagePerson,0)
                newMessage.fadingTime=100
                var chicky;
                chicky=instance_create(0,0,oZAggressiveChickSpawn);
                chicky.decayTime = 999999999
            }
          }
    }
}
//scene final in no walk
if room=rC5_NoWalk16
{
    if global.cousinoer5Progress = 90
    {
        if sceneProgress < 2
          {
          global.gamePaused=true
          sceneProgress=2
          }
          if global.activeCharacter = 1 //claire
          {
          if sceneProgress=2 and bWaitForInput=false
            msgCreate(0,0,"Claire","Counting me having to navigate through the chicken swarm, that makes 5 encounters for me and a measly 2 for Jerry.",0,3,oMessageCutscene,1)
          else if sceneProgress=3 and bWaitForInput=false
            msgCreate(0,0,"Jerry","The enemies were too scared of my super awesome dashing skills, they targeted you because they knew.",0,3,oMessageCutscene,1)
          else if sceneProgress=4 and bWaitForInput=false
            msgCreate(0,0,"Claire","I'm sure that's it. I expect you to pull your weight in the next encounter then.",0,3,oMessageCutscene,1)
          else if sceneProgress=5 and bWaitForInput=false
            msgCreate(0,0,"Jerry","Sounds like a plan, I bet a boss is coming up!",0,3,oMessageCutscene,1)
          if sceneProgress=6 and bWaitForInput=false
            msgCreate(0,0,"Jeremy","He's right, you've met before, and it's back for revenge. I hope you're prepared.",0,3,oMessageCutscene,1)
          }
          else
          {
          if sceneProgress=2 and bWaitForInput=false
            msgCreate(0,0,"Jerry","Well, since I had to dash through all those angry birds, let's say the encounter rate was 3 for me, 4 for you.",0,3,oMessageCutscene,1)
          else if sceneProgress=3 and bWaitForInput=false
            msgCreate(0,0,"Claire","Hmph, I had to fight so much crazier stuff, I call shenanigans!",0,3,oMessageCutscene,1)
          else if sceneProgress=4 and bWaitForInput=false
            msgCreate(0,0,"Jerry","Well, we're still alive so you did okay I guess.",0,3,oMessageCutscene,1)
          else if sceneProgress=5 and bWaitForInput=false
            msgCreate(0,0,"Claire","Shut it, Jerry, you know I carried us through that. You better pick up the slack in the next room.",0,3,oMessageCutscene,1)
          if sceneProgress=6 and bWaitForInput=false
            msgCreate(0,0,"Jeremy","You heard her Jerry, you better put in some work on this upcoming boss! You may remember this one, it's back for revenge, good luck!",0,3,oMessageCutscene,1)
          }
          
          if sceneProgress=7 and bWaitForInput=false
            msgCreate(0,0,"Jerry","Well... We're getting our movement ability back, right? Not much of a boss if we can just dash around and be invincible.",0,3,oMessageCutscene,1)
          else if sceneProgress=8 and bWaitForInput=false
            msgCreate(0,0,"Jeremy","Haha, you poor naive soul. Just drop into that pit and find out.",0,3,oMessageCutscene,1)
          else if sceneProgress=9
          {
            global.cousinoer5Progress = 91
            global.gamePaused=false
          }
    }
}
//Boss, brain machine returns
if room=rC5_NoWalkBoss
{
    if global.cousinoer5Progress=91 and oPlayer1.y > 370 and global.bossTrack = 0
    {
      //intro
    if sceneProgress=0
    {
        global.gamePaused=true
          stopPlayer()
          sceneProgress+=1
    }
    else if sceneProgress=1
    {
      //sceneTime+=1
      if sceneTime=0 {sceneTime=1-gDeltaTime} //60fps change (added): 1 on the first frame, as at 30fps
      sceneTime+=1*gDeltaTime //60fps change
      if sceneTime=1
      {
        boss=instance_create(288,272,oBrainMachine)
        boss.image_alpha=0
          grap=instance_create(288+75, 272, oStrikeChainPoint)
          grap.image_alpha=0
          grap=instance_create(288-75, 272, oStrikeChainPoint)
          grap.image_alpha=0
          grap=instance_create(288, 272+75, oStrikeChainPoint)
          grap.image_alpha=0
          grap=instance_create(288, 272-75, oStrikeChainPoint)
          grap.image_alpha=0
      }
      else if sceneTime>=21 and sceneTime<=70 
      {
          //boss.image_alpha+=0.02
          boss.image_alpha+=0.02*gDeltaTime //60fps change
          with oStrikeChainPoint
          {
            //image_alpha += 0.02
            image_alpha += 0.02*gDeltaTime //60fps change
          }
      }
      else if sceneTime>=95 {sceneTime=0; sceneProgress+=1}
      
    }
      if sceneProgress=2 and bWaitForInput=false
        msgCreate(0,0,"Jerry","Oh hell no, not this guy again!",0,3,oMessageCutscene,1)
      else if sceneProgress=3 and bWaitForInput=false
        msgCreate(0,0,"Claire","Guess you'll be pulling your weight here! It's should be sooo easy with your infinity dash!",0,3,oMessageCutscene,1)
      else if sceneProgress=4 and bWaitForInput=false
        msgCreate(0,0,"Jerry","Do you not see the floor? No one is gonna have a good time. The only saving grace is those grapple points, I'll just abuse those.",0,3,oMessageCutscene,1)
      else if sceneProgress=5 and bWaitForInput=false
        msgCreate(0,0,"Brain Machine","EXPLOIT FOUND. RECONFIGURING.",0,3,oMessageCutscene,1)
      else if sceneProgress=6
      {
        //sceneTime+=1
        sceneTime+=1*gDeltaTime //60fps change
        if sceneTime = 10
        {
           with oStrikeChainPoint {
           instance_create(x,y,oLinkBExplosion)
           instance_destroy()
           }
        }
        if sceneTime = 40
        {
            sceneTime=0; sceneProgress+=1
        }
      }
      if sceneProgress=7 and bWaitForInput=false
        msgCreate(0,0,"Jerry","Hey Claire, good news, we both have equal chance of getting stomped by this guy now. Feel free to carry me some more if you want.",0,3,oMessageCutscene,1)
      if sceneProgress=8 and bWaitForInput=false
        msgCreate(0,0,"Claire","Psh, you wish. Mayyybe if you ask nicely.",0,3,oMessageCutscene,1)
      if sceneProgress=9 and bWaitForInput=false
        msgCreate(0,0,"Jeremy","It's not waiting for your conversation anymore, it's go time.",0,3,oMessageCutscene,1)
    
      if sceneProgress=10
      {
          with oBrainMachine {instance_destroy()}
          var tBossTitle,tempMplay;
          tBossTitle=instance_create(0,0,oBossNameDisplay)
          tBossTitle.bossName="Cosmic Brain Machine"
          tBossTitle.bossTitle="200 IQ"
          global.currentBoss="Cosmic Brain Machine"
          
          viewFix=instance_create(288,288,oMisc)
          viewFix.type=0
          viewFix.sprite_index=sNull
          view_object[0]=viewFix
          var tempMplay;
          tempMplay=findMusic(2011)
          playMusic(tempMplay,0,0)
          var enemyBarrier;
          global.gamePaused=false
          //enemyBarrier=instance_create(512,224,oEnemyBarrier); enemyBarrier.image_yscale=4
          //storeStatus(1)
          boss=instance_create(288,272,oBrainMachine)
          boss.activateBoss=1
          global.bossTrack = 1
      }
    }
        else if global.bossTrack=1
      {
        if sceneProgress=1 //End Boss
        {
          stopPlayer()
          global.gamePaused=true
          view_object[0]=oPlayer1
          awardBossAP(11000)
          global.bossTrack=2
          sceneProgress=0
        }
      }
      else if global.bossTrack=2
      {
        if sceneProgress=0
        {
            sceneProgress=2
          }
          if sceneProgress=2 and bWaitForInput=false
            msgCreate(0,0,"Jerry","That was rough! Who had the bright idea of taking off the grapple points?",0,3,oMessageCutscene,1)
          else if sceneProgress=3 and bWaitForInput=false
            msgCreate(0,0,"Claire","You and your big mouth did, it heard you bragging that you'd abuse them, and so it destroyed them.",0,3,oMessageCutscene,1)
          else if sceneProgress=4 and bWaitForInput=false
            msgCreate(0,0,"Jerry","But bosses always have blatant weaknesses like that, you know, that whole 'ensuring there's always a path to victory' thing.",0,3,oMessageCutscene,1)
          else if sceneProgress=5 and bWaitForInput=false
            msgCreate(0,0,"Jeremy","I mean, there was a path to victory, you guys stumbled down it somehow!",0,3,oMessageCutscene,1)
          else if sceneProgress=6 and bWaitForInput=false
            msgCreate(0,0,"Jerry","Hey, peanut gallery, I'd love to see you handle this!",0,3,oMessageCutscene,1)
          else if sceneProgress=7 and bWaitForInput=false
            msgCreate(0,0,"Jeremy","I would, but I gotta babysit you guys from the fourth wall. Who knows what trouble you'd get into without me being like 'hey guys there's an enemy coming'.",0,3,oMessageCutscene,1)
          else if sceneProgress=8 and bWaitForInput=false
            msgCreate(0,0,"Jerry","Why I oughta...",0,3,oMessageCutscene,1)
          else if sceneProgress=9 and bWaitForInput=false
            msgCreate(0,0,"Claire","Aaaanyway, what now? This was just a dead end.",0,3,oMessageCutscene,1)
          else if sceneProgress=10 and bWaitForInput=false
            msgCreate(0,0,"Jeremy","Another cryptic riddle. 'I want dead Pixels, all of them. Complete this task and the next area shall be revealed.'",0,3,oMessageCutscene,1)
          else if sceneProgress=11 and bWaitForInput=false
            msgCreate(0,0,"Jerry","Maaan, what's with all these riddles? I want more action!",0,3,oMessageCutscene,1)
          else if sceneProgress=12 and bWaitForInput=false
            msgCreate(0,0,"Claire","Didn't you just have enough action? I'm sure we'll find something else that doesn't involve so much brain power.",0,3,oMessageCutscene,1)
          else if sceneProgress=13 and bWaitForInput=false
            msgCreate(0,0,"Jerry","Hey! I'm plenty smart!",0,3,oMessageCutscene,1)
          else if sceneProgress=14 and bWaitForInput=false
            msgCreate(0,0,"Claire","Okay then, I was gonna offer what I think the clue is leading us to, but since you're so smart, lead the way!",0,3,oMessageCutscene,1)
          else if sceneProgress=15 and bWaitForInput=false
            msgCreate(0,0,"Jeremy","You walked right into that one, Jerry. My lips are sealed too. Good luck!",0,3,oMessageCutscene,1)
          else if sceneProgress=16
          {
          newWarp=instance_create(272,384,oExit)
          with newWarp
          {
            bShowArrow=false
            exitType=0
            y+=32
            newMapX=48
            newMapY=448
            toRoom=rC5_NoWalk1
            sprite_index=sWarpGateStand
          }
          var tFullHeartDrop,tempMplay;
          tFullHeartDrop=instance_create(272,96,oHealthPickup)
          tFullHeartDrop.sprite_index=sFullHealthPickup
          tempMplay=findMusic(2012)
          playMusic(tempMplay,0,0)
          with oSmallJumper
          {
            instance_destroy();
          }
          global.gamePaused=false
          global.currentBoss=""
          global.bossTrack=0
          global.cousinoer5Progress=153
          var file;
            file = file_text_open_write(working_directory + "\Mystery.txt");
            file_text_write_string(file, "RIDDLE: I want dead Pixels, all of them. Complete this task and the next area shall be revealed.")
            file_text_close(file);
        }
      }
}

//far reaches pixel puzzle, show the door only if progresses past this part, or if the player kills all the pixels
if room=rMain_95
{
    if global.cousinoer5Progress >= 153 and ((global.cousinoer5Progress > 153) or !instance_exists(oBlownUpPixel))
    {
        (471883).x = 1072
        (471883).y = 352
    } 
}
//dialog event after killing all pixels and entering the challenge zone
if room=rC5_ChallengeHub and global.cousinoer5Progress = 153
{
  if sceneProgress < 2
  {
  global.gamePaused=true
  sceneProgress=2
  }
  if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Ha! I did it, I'm a genius!",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Claire","Good job Jerry, welcome to 10 minutes ago, I was gonna say this before you opened your big mouth.",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Well this is an interesting looking place.",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jerry","I know these doors... Oh man, more mook killing challenges!",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","I don't know about that, they seem a lot less mook-y when you're wearing that cursed gear, a couple hits and you're finished!",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Yeah yeah, we did these before, as long as there's no time limit or other gimmick to it we'll rock these as well!",0,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Claire","Jerry... Why are you jinxing this?",0,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Consider it jinxed, these challenges are different, and will have time limits and other gimmicks.",0,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Oops.",0,3,oMessageCutscene,1)
  else if sceneProgress=11 and bWaitForInput=false
    msgCreate(0,0,"Claire","Sigh... Well, we came for a challenge I suppose, it's still going to be basic enemies after all.",0,3,oMessageCutscene,1)
  else if sceneProgress=12 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Now who's jinxing things?",0,3,oMessageCutscene,1)
  else if sceneProgress=13 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Lucky for you, my scans aren't picking up anything other than basic enemies in these trials.",0,3,oMessageCutscene,1)
  else if sceneProgress=14 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Well, we can sit here and speculate all day, or we can go in there and kick some ass! Let's go!",0,3,oMessageCutscene,1)
  else if sceneProgress=15 and bWaitForInput=false
    msgCreate(0,0,"Claire","Agreed, I'll just make you take on the time trials! I hate those.",0,3,oMessageCutscene,1)
  else if sceneProgress=16
  {
    global.cousinoer5Progress = 573
    global.gamePaused=false
    var file;
            file = file_text_open_write(working_directory + "\Mystery.txt");
            file_text_write_string(file, "You found the challenge zone in the farreaches pixel room, complete all 8 challenges to move on to the next phase.")
            file_text_close(file);
  }
}
//scene upon completing all the challenges.
if room=rC5_ChallengeHub and global.cousinoer5Progress = 666
{
  if sceneProgress < 2
  {
  global.gamePaused=true
  sceneProgress=2
  }
  if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Great job guys, you did it!",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jerry","So do we fight Dr. Wily now? We beat the 8 things. Where's the way forward?",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Actually there's another clue for you guys, this is a strange riddle:",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","You know this word Subconciously, enter it on the title screen.",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Huh, that's too meta, do we even have a part in this one?",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Claire","We may be able to find a hint to what the word is.",0,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Yeah, good luck with that.",0,3,oMessageCutscene,1)
  else if sceneProgress=9
  {
    global.cousinoer5Progress = 777
    global.gamePaused=false
    var file;
            file = file_text_open_write(working_directory + "\Mystery.txt");
            file_text_write_string(file, "RIDDLE: You know this word Subconciously, enter it on the title screen.")
            file_text_close(file);
  }
}
//scene upon entering the barrier room after solving all the riddles
if room=rBT_Cousinoer5HUB_Newer
{
    if global.cousinoer5Progress = 1000
    {
      if sceneProgress < 2
      {
      global.gamePaused=true
      sceneProgress=2
      }
      if sceneProgress=2 and bWaitForInput=false
        msgCreate(0,0,"Jerry","We solved all the puzzles, right?",0,3,oMessageCutscene,1)
      else if sceneProgress=3 and bWaitForInput=false
        msgCreate(0,0,"Jeremy","Yep.",0,3,oMessageCutscene,1)
      else if sceneProgress=4 and bWaitForInput=false
        msgCreate(0,0,"Jerry","So why is this barrier still here after all that? Can't it just go away? We went through so much to get rid of it after all.",0,3,oMessageCutscene,1)
      else if sceneProgress=5 and bWaitForInput=false
        msgCreate(0,0,"Jeremy","I'm afraid it's not that simple. Just know that there are no more puzzles. The barrier is at its weakest state, and there's no getting around it. The promised land is on the other side, how will you get through?",0,3,oMessageCutscene,1)
      else if sceneProgress=6 and bWaitForInput=false
        msgCreate(0,0,"Jerry","Well, if that's the case then I guess we just tank through it. Easy enough.",0,3,oMessageCutscene,1)
      else if sceneProgress=7 and bWaitForInput=false
        msgCreate(0,0,"Claire","You do that.",0,3,oMessageCutscene,1)
      else if sceneProgress=8
      {
        global.cousinoer5Progress = 1001
        sceneProgress = 0
        global.gamePaused=false
        var file;
                file = file_text_open_write(working_directory + "\Mystery.txt");
                file_text_write_string(file, "Find a way to get through the barrier. Just know that there are no more puzzles. The barrier is at its weakest state, and there's no getting around it. The promised land is on the other side, how will you get through?")
                file_text_close(file);
      }
    }
  else if global.cousinoer5Progress = 1001
  {
    if global.rmDeaths=1
    {
          if sceneProgress < 2
          {
          global.gamePaused=true
          //sceneTime+=1
          sceneTime+=1*gDeltaTime //60fps change
            if sceneTime = 30
            {
          
                sceneProgress=2
            }
          }
          if sceneProgress=2 and bWaitForInput=false
            msgCreate(0,0,"Jerry","Yo, wtf! It still did 160 damage! And we only have... Let's see... 4, 8, 12, 16...",0,3,oMessageCutscene,1)
          if (global.bNightmareMode=0 and global.bOneHitKillMode=0)
          {
              if sceneProgress=3 and bWaitForInput=false
                msgCreate(0,0,"Claire","We have 80 hp, Jerry. Please don't strain yourself.",0,3,oMessageCutscene,1)
              else if sceneProgress=4 and bWaitForInput=false
                msgCreate(0,0,"Jerry","So, uh, are you sure there's nothing else to be done about this barrier?",0,3,oMessageCutscene,1)
              else if sceneProgress=5 and bWaitForInput=false
                msgCreate(0,0,"Jeremy","Nope, you should be able to figure out what you have to do here.",0,3,oMessageCutscene,1)
              else if sceneProgress=6
              {
                global.cousinoer5Progress = 1002
                sceneProgress = 0
                global.gamePaused=false
              }
          }
          else if global.bOneHitKillMode = 1
          {
            if sceneProgress=3 and bWaitForInput=false
                msgCreate(0,0,"Claire","Actually it did some random amount of damage because someone decided to turn on one hit kill mode!",0,3,oMessageCutscene,1)
              else if sceneProgress=4 and bWaitForInput=false
                msgCreate(0,0,"Jerry","Oh yeah, so uh, how do we get past this then???",0,3,oMessageCutscene,1)
              else if sceneProgress=5 and bWaitForInput=false
                msgCreate(0,0,"Jeremy","(oh no, this puzzle won't work...) ...Uh, look at that! It just took a second for the barrier to disappear!",0,3,oMessageCutscene,1)
                else if sceneProgress=6
              {
                with oScaledTrapZone
                {
                    instance_destroy()
                }
                global.cousinoer5Progress = 1006
                sceneProgress = 0
                global.gamePaused=false
              }
          }
          else
          {
              if sceneProgress=3 and bWaitForInput=false
                msgCreate(0,0,"Claire","We have 36 hp, Jerry. Please don't strain yourself.",0,3,oMessageCutscene,1)
              else if sceneProgress=4 and bWaitForInput=false
                msgCreate(0,0,"Jerry","So, uh, are you sure there's nothing else to be done about this barrier?",0,3,oMessageCutscene,1)
              else if sceneProgress=5 and bWaitForInput=false
                msgCreate(0,0,"Jeremy","(oh no, this puzzle won't work...) ...Uh, look at that! It just took a second for the barrier to disappear!",0,3,oMessageCutscene,1)
              else if sceneProgress=6
              {
                with oScaledTrapZone
                {
                    instance_destroy()
                }
                global.cousinoer5Progress = 1006
                sceneProgress = 0
                global.gamePaused=false
              }
          }
          
    }
  }
  else if global.cousinoer5Progress = 1002
  {
    
  }
}

if room = rBT_Cousinoer5_BossHall
{
    if global.cousinoer5Progress < 1200
    {
        if sceneProgress < 2
      {
      global.gamePaused=true
      sceneProgress=2
      if (global.bNightmareMode=1 or global.bOneHitKillMode=1)
      {
        sceneProgress = 9
      }
      }
      
      if sceneProgress=2 and bWaitForInput=false
        msgCreate(0,0,"Jerry","What the heck was that puzzle!? That goes against so much of my gamer creed! We had to turn on assist mode, put on armor, take forced damage, and drink at least one potion!",0,3,oMessageCutscene,1)
      else if sceneProgress=3 and bWaitForInput=false
        msgCreate(0,0,"Claire","If it riles Jerry up that much I'm cool with it, can we have more like that?",0,3,oMessageCutscene,1)
      else if sceneProgress=4 and bWaitForInput=false
        msgCreate(0,0,"Jeremy","Is it really so bad if you had to do it to proceed?",0,3,oMessageCutscene,1)
      else if sceneProgress=5 and bWaitForInput=false
        msgCreate(0,0,"Jerry","Yeah! It's gonna be engraved forever in our stat screen now, and that's not cool!",0,3,oMessageCutscene,1)
      else if sceneProgress=6 and bWaitForInput=false
        msgCreate(0,0,"Claire","Ignoring the pout parade going on right now, what is this place? The promised land? Looks gloomy to me.",0,3,oMessageCutscene,1)
      else if sceneProgress=7 and bWaitForInput=false
        msgCreate(0,0,"Jeremy","I mean, look at those doors? Recognize them from somewhere else?",0,3,oMessageCutscene,1)
      else if sceneProgress=8 and bWaitForInput=false
        msgCreate(0,0,"Claire","Oh yeah, that strange boss gallery area back in town. Guess these are boss challenges then.",0,3,oMessageCutscene,1)
        
      else if sceneProgress=9 and bWaitForInput=false
        msgCreate(0,0,"Jerry","Boss challenges?! That rocks ass! Gotta get those gold medals!",0,3,oMessageCutscene,1)
      if (global.bNightmareMode=0 and global.bOneHitKillMode=0)
      {
          if sceneProgress=10 and bWaitForInput=false
            msgCreate(0,0,"Jeremy","Well you sure cheered up fast! Anyway yeah, welcome to the boss zone.",0,3,oMessageCutscene,1)
      }
      else
      {
          if sceneProgress=10 and bWaitForInput=false
            msgCreate(0,0,"Jeremy","Welcome to the boss zone.",0,3,oMessageCutscene,1)
      }
        
      if sceneProgress=11 and bWaitForInput=false
        msgCreate(0,0,"Claire","So I assume we have to beat all these bosses in order to proceed?",0,3,oMessageCutscene,1)
      else if sceneProgress=12 and bWaitForInput=false
        msgCreate(0,0,"Jeremy","Not at all. This is the end area, a reward so to speak. Here you can fight some challenging fights I put together.",0,3,oMessageCutscene,1)
      else if sceneProgress=13 and bWaitForInput=false
        msgCreate(0,0,"Claire","Wait, you did this?",0,3,oMessageCutscene,1)
      else if sceneProgress=14 and bWaitForInput=false
        msgCreate(0,0,"Jeremy","I made this :)#I made all of these new areas, and the puzzles too.",0,3,oMessageCutscene,1)
      else if sceneProgress=15 and bWaitForInput=false
        msgCreate(0,0,"Jerry","So you were BSing us when you were saying 'oh look guys words are popping up on my screen!'",0,3,oMessageCutscene,1)
      else if sceneProgress=16 and bWaitForInput=false
        msgCreate(0,0,"Jeremy","I don't think I said it that silly, but yep. When I activated the power of undo, it stopped time for a while, so I decided to be productive and created some challenges for you guys. Keep you sharp in case anything else happened.",0,3,oMessageCutscene,1)
      else if sceneProgress=17 and bWaitForInput=false
        msgCreate(0,0,"Jerry","So wait, you ZA WARUDO'D us???",0,3,oMessageCutscene,1)
      else if sceneProgress=18 and bWaitForInput=false
        msgCreate(0,0,"Jeremy","Not intentionally, but yes. I had a lot of other plans to test you guys, but I sensed the undo's time stop was running out so I had to wrap it up.",0,3,oMessageCutscene,1)
      else if sceneProgress=19 and bWaitForInput=false
        msgCreate(0,0,"Claire","They certainly were some interesting challenges.",0,3,oMessageCutscene,1)
      else if sceneProgress=20 and bWaitForInput=false
        msgCreate(0,0,"Jeremy","I hope you guys enjoyed them. Fun fact, I actually designed these boss encounters first, and there's a few more really special ones in the next room.",0,3,oMessageCutscene,1)
      else if sceneProgress=21 and bWaitForInput=false
        msgCreate(0,0,"Jerry","Oh boy, you spoil us! ",0,3,oMessageCutscene,1)
      else if sceneProgress=22 and bWaitForInput=false
        msgCreate(0,0,"Jeremy","Also be sure to scan the bosses, there's new dev commentary. Okay that's all, go kick some ass!",0,3,oMessageCutscene,1)
      else if sceneProgress=23
      {
        global.cousinoer5Progress = 1200
        sceneProgress = 0
        global.gamePaused=false
        var file;
                file = file_text_open_write(working_directory + "\Mystery.txt");
                file_text_write_string(file, "You did it, you have unlocked the Super Boss Gallery, where you can test your mettle against truly special boss fights. Thanks for playing!")
                file_text_close(file);
      }
    }
}

if room = rBT_Cousinoer5_BossHall2
{
    if global.cousinoer5Progress = 1200
    {
        if sceneProgress < 2
      {
      global.gamePaused=true
      sceneProgress=2
      }
      if sceneProgress=2 and bWaitForInput=false
        msgCreate(0,0,"Jeremy","Welcome to the VIP room of the boss hall. There's some special fights in here. You've been acquainted with Cosmic Brain Machine, and I also devised a way for me and Chao to fight Warmaster and have some incredible fun!",0,3,oMessageCutscene,1)
      else if sceneProgress=3 and bWaitForInput=false
        msgCreate(0,0,"Jerry","That's cool! We get to sit back and watch you guys fight the toughest dude in the world, that'll be interesting!",0,3,oMessageCutscene,1)
      else if sceneProgress=4 and bWaitForInput=false
        msgCreate(0,0,"Claire","Wait, I understand how you'll fight, Jeremy, but how is Chao going to fight?",0,3,oMessageCutscene,1)
      else if sceneProgress=5 and bWaitForInput=false
        msgCreate(0,0,"Chao","Remember those circles I used to defeat the virus inside the Abomination? Jeremy analyzed that behaviour and hacked me in a more advanced version I can use to fight more mobile targets!",0,3,oMessageCutscene,1)
      else if sceneProgress=6 and bWaitForInput=false
        msgCreate(0,0,"Jeremy","Yep, it's pretty complex to explain, but I'll try:",0,3,oMessageCutscene,1)
      else if sceneProgress=7 and bWaitForInput=false
        msgCreate(0,0,"Jeremy","Left click will place a white circle, which will fire a stream of bullets towards the target reticule while Chao is inside of it. Right clicking away from your circles will change the location of the target reticule",0,3,oMessageCutscene,1)
      else if sceneProgress=8 and bWaitForInput=false
        msgCreate(0,0,"Jeremy","Clicking on a circle will open up an upgrade wheel within the circle, left click will give you offensive options, right click will give you defensive options. Hold the click, hover over the desired color, and let go.",0,3,oMessageCutscene,1)
      else if sceneProgress=9 and bWaitForInput=false
        msgCreate(0,0,"Jeremy","These upgrades will cost varying amounts of Mana, which has replaced the graze meter in the top right. It builds up over time, and any upgrade you can't afford will be faded out.",0,3,oMessageCutscene,1)
      else if sceneProgress=10 and bWaitForInput=false
        msgCreate(0,0,"Jeremy","Offensive Options:#Red - The circle grows in size and detonates, doing good damage.#Blue - The circle fires without Chao having to be inside.",0,3,oMessageCutscene,1)
      else if sceneProgress=11 and bWaitForInput=false
        msgCreate(0,0,"Jeremy","Offensive Options Continued:#Green - The circle targets the closest enemy#Yellow - Shoots a spread shot, middle shot aimed at reticule.",0,3,oMessageCutscene,1)
      else if sceneProgress=12 and bWaitForInput=false
        msgCreate(0,0,"Jeremy","You can further power up an offensive circle in the same way, adding another color to it with left click, combining the properties, or enhancing the properties if it's a different color. Experiment with these, this is already longwinded.",0,3,oMessageCutscene,1)
      else if sceneProgress=13 and bWaitForInput=false
        msgCreate(0,0,"Jeremy","Defensive Options:#Red - The circle will launch towards the reticule, erasing bullets and leaving explosions.",0,3,oMessageCutscene,1)
      else if sceneProgress=14 and bWaitForInput=false
        msgCreate(0,0,"Jeremy","Defensive Options Continued:#Blue - Turns projectiles into your bullets and shoots it in the opposite direction",0,3,oMessageCutscene,1)
      else if sceneProgress=15 and bWaitForInput=false
        msgCreate(0,0,"Jeremy","Defensive Options Continued:#Green - Absorbs projectiles and heals you for each one#Yellow - Complete invulnerability while inside, lasts a very short time when you go outside.",0,3,oMessageCutscene,1)
      else if sceneProgress=16 and bWaitForInput=false
        msgCreate(0,0,"Jeremy","Walls will hurt you, and Warmaster has a few extra tricks to compensate for Chao's mobility. That should be all you need to know. All this information will be stored in the Mystery.txt document as well for the player's reference.",0,3,oMessageCutscene,1)
      else if sceneProgress=17 and bWaitForInput=false
        msgCreate(0,0,"Chao","That's a lot of info to take in, I feel like it'll be easier to mess around with my powers in the real fight.",0,3,oMessageCutscene,1)
      else if sceneProgress=18 and bWaitForInput=false
        msgCreate(0,0,"Jeremy","Yeah. Since you're fighting you won't be able to scan, so it's better to get some explanations out there before you go in head first.",0,3,oMessageCutscene,1)
      else if sceneProgress=19 and bWaitForInput=false
        msgCreate(0,0,"Jerry","I know most of that went over my head, sounded like more meta stuff only the player knows about.",0,3,oMessageCutscene,1)
      else if sceneProgress=20 and bWaitForInput=false
        msgCreate(0,0,"Jeremy","Yeah, don't worry about it too much.",0,3,oMessageCutscene,1)
      else if sceneProgress=21
      {
        global.cousinoer5Progress = 1337
        sceneProgress = 0
        global.gamePaused=false
        var file;
                file = file_text_open_write(working_directory + "\Mystery.txt");
                file_text_write_string(file, "You did it, you have unlocked the Super Boss Gallery, where you can test your mettle against truly special boss fights. Thanks for playing!
                Chao mechanics:
                Left click will place a white circle, which will fire a stream of bullets towards the target reticule while Chao is inside of it. Right clicking away from your circles will change the location of the target reticule
                Clicking on a circle will open up an upgrade wheel within the circle, left click will give you offensive options, right click will give you defensive options. Hold the click, hover over the desired color, and let go.
                These upgrades will cost varying amounts of Mana, which has replaced the graze meter in the top right. It builds up over time, and any upgrade you can't afford will be faded out.
                
                Offensive Options:
                Red - The circle grows in size and detonates, doing good damage.
                Blue - The circle fires without Chao having to be inside.
                Green - The circle targets the closest enemy
                Yellow - Shoots a spread shot, middle shot aimed at reticule.
                
                You can further power up an offensive circle in the same way, adding another color to it with left click, combining the properties, or enhancing the properties if it's a different color. Experiment with these, this is already longwinded.
                
                Defensive Options:
                Red - The circle will launch towards the reticule, erasing bullets and leaving explosions.
                Blue - Turns projectiles into your bullets and shoots it in the opposite direction.
                Green - Absorbs projectiles and heals you for each one.
                Yellow - Complete invulnerability while inside, lasts a very short time when you go outside.
                
                Walls will hurt you, and Warmaster has a few extra tricks to compensate for Chao's mobility. That should be all you need to know. All this information will be stored in the Mystery.txt document as well for the player's reference... Wait you're already reading this!")
                file_text_close(file);
      }
    }
}
keyWaitForInput()
