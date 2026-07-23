sprite_index=sNPC_Craig_Idle
talker="Craig"
if global.gameProgress<=1080
  stringToShow="I'm pretty sure Syrus or Gene were mentioning something about an access code for gates earlier."
else if global.gameProgress>=1090 and global.gameProgress<=2540
  stringToShow="I've explored the Magical Woods a bit. Not too much, those bees are damn annoying."
else if global.gameProgress>=2550 and global.gameProgress<=3070
  stringToShow="So to the east was this LOUD sound. Like something huge moving around. I know I heard it. I think I saw something too."
else if global.gameProgress>=3080 and global.gameProgress<=3900
  stringToShow="I'm super jealous, Claire. The Metroid series is the best one out there. Except that 'other' one, we just won't talk about it."
else if global.gameProgress>=3910 and global.gameProgress<=4500
  stringToShow="If I had your abilities, Claire, I'd have been out there missiling the balls out of those tanks. Missiling is a word, right?"
else if global.gameProgress>=4510
  stringToShow="Holy balls!! Did you guys see that huge ship earlier!? DID YOU SEE THE GUNS ON THAT THING!?"
boxSize=2

if global.gameProgress<=980 {instance_destroy()}
