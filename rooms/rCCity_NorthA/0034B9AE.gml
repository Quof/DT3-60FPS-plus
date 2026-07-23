sprite_index=sNPC_Gary_Idle
talker="Gary"
if global.gameProgress<=1760
  stringToShow="Not everyone has come out of hiding yet. Once we get word out that the city is safe, it will be a lot more lively. There's a lot going on here."
else if global.gameProgress>=1770 and global.gameProgress<=2560
  stringToShow="That sucks what happened to X. I know he really wanted to help, but he was a badass bot. I hope you won't put his gift to shame."
else if global.gameProgress>=2570 and global.gameProgress<=3900
  stringToShow="We finally got that bridge fixed. You might not believe this, but we don't stand here all day. When you're out there, we're pretty active."
else if global.gameProgress>=3910 and global.gameProgress<=4500
  stringToShow="I watched you fight off CHAOS. Maaan, that was awesome how they gave the white flag and ran."
else if global.gameProgress>=4510
  stringToShow="Was that CHAOS that launched that ship earlier? I really hope not. That thing looks like bad news for all of us."
boxSize=2

if global.gameProgress<=980 {instance_destroy()}
