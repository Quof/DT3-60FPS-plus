/*
normalized gallery change (added): the boss gallery's normalized build for each door (oBossGalleryDoor type), worked
out from the game data as what a player would have before that boss with everything obtainable collected:
- items count from the area/level they're in (the gate item terminals' sections, the story events of each area);
  a gate's heart container counts from the boss after the one that drops it; the shop items from Central City - South
- the skill tree filled for the ability sets one would have by then (AP isn't a limit: grinding)
- weapon levels from the weapon level upgrades only
Equipment isn't part of it (sword equipment is kept off in the gallery: scrNormSwordsOff). Swift Foot is never taken
away (scrNormApply). "progress" is the gameProgress the build is for. Change a door's values here to tune it.
argument0: door type
returns 1 when the door has a build (and it's been put in), 0 when it doesn't (the player's own build is used)
  tW: weapon levels, one per character (A = 10): Link sword, arrow, bomb, Belmont whip, dagger, holy water,
      Mega Man buster, shot ice, gravity, Samus cannon, missile, bomb
  tS: skill tree levels, one per skill, skillTree[0]..[29]
*/
var tW,tS,i,c,tName;
tW=""; tS=""

if argument0=1 //Bowser (progress 230)
{
  global.pMaxLife=12; global.pHeartPieces=3
  global.hudLink_Arrows[1]=12; global.hudBelmont_WeaponEn[1]=60; global.hudSamus_Missiles[1]=12; global.hudGame_WeaponEn[1]=150; global.pBreathMax=630
  global.linkBombUpgrade=1; global.metBombUpgrade=0
  tW="211000000000"; tS="000000000000000010000000450000"
}
else if argument0=2 //Cackletta (progress 500)
{
  global.pMaxLife=16; global.pHeartPieces=0
  global.hudLink_Arrows[1]=13; global.hudBelmont_WeaponEn[1]=60; global.hudSamus_Missiles[1]=12; global.hudGame_WeaponEn[1]=150; global.pBreathMax=630
  global.linkBombUpgrade=1; global.metBombUpgrade=0
  tW="211000000000"; tS="000000000000000010000000450000"
}
else if argument0=3 //Kamek (progress 510)
{
  global.pMaxLife=20; global.pHeartPieces=1
  global.hudLink_Arrows[1]=13; global.hudBelmont_WeaponEn[1]=60; global.hudSamus_Missiles[1]=12; global.hudGame_WeaponEn[1]=150; global.pBreathMax=630
  global.linkBombUpgrade=1; global.metBombUpgrade=0
  tW="211000000000"; tS="000000000000000010000000450000"
}
else if argument0=4 //Helmethead (progress 690)
{
  global.pMaxLife=24; global.pHeartPieces=1
  global.hudLink_Arrows[1]=18; global.hudBelmont_WeaponEn[1]=65; global.hudSamus_Missiles[1]=12; global.hudGame_WeaponEn[1]=150; global.pBreathMax=630
  global.linkBombUpgrade=2; global.metBombUpgrade=0
  tW="431000011000"; tS="440000000000001010005000450000"
}
else if argument0=5 //Dead Hand (progress 730)
{
  global.pMaxLife=24; global.pHeartPieces=2
  global.hudLink_Arrows[1]=19; global.hudBelmont_WeaponEn[1]=65; global.hudSamus_Missiles[1]=12; global.hudGame_WeaponEn[1]=150; global.pBreathMax=630
  global.linkBombUpgrade=3; global.metBombUpgrade=0
  tW="432000011000"; tS="440000000000001010005000450000"
}
else if argument0=6 //Barba (progress 790)
{
  global.pMaxLife=24; global.pHeartPieces=3
  global.hudLink_Arrows[1]=23; global.hudBelmont_WeaponEn[1]=65; global.hudSamus_Missiles[1]=12; global.hudGame_WeaponEn[1]=150; global.pBreathMax=750
  global.linkBombUpgrade=4; global.metBombUpgrade=0
  tW="544000011000"; tS="440000000000001010005000450000"
}
else if argument0=7 //Thunderbird (progress 800)
{
  global.pMaxLife=24; global.pHeartPieces=3
  global.hudLink_Arrows[1]=24; global.hudBelmont_WeaponEn[1]=65; global.hudSamus_Missiles[1]=12; global.hudGame_WeaponEn[1]=150; global.pBreathMax=750
  global.linkBombUpgrade=4; global.metBombUpgrade=0
  tW="655000011000"; tS="440000000000001010005000450000"
}
else if argument0=8 //Aqua Serpent (progress 880)
{
  global.pMaxLife=24; global.pHeartPieces=3
  global.hudLink_Arrows[1]=24; global.hudBelmont_WeaponEn[1]=65; global.hudSamus_Missiles[1]=12; global.hudGame_WeaponEn[1]=150; global.pBreathMax=750
  global.linkBombUpgrade=4; global.metBombUpgrade=0
  tW="655000011000"; tS="440000000000001010005000450000"
}
else if argument0=9 //Final Nightmare (progress 910)
{
  global.pMaxLife=28; global.pHeartPieces=3
  global.hudLink_Arrows[1]=25; global.hudBelmont_WeaponEn[1]=65; global.hudSamus_Missiles[1]=12; global.hudGame_WeaponEn[1]=150; global.pBreathMax=750
  global.linkBombUpgrade=4; global.metBombUpgrade=0
  tW="766000011000"; tS="440000000000001010005000450000"
}
else if argument0=10 //Control Virus (progress 980)
{
  global.pMaxLife=28; global.pHeartPieces=3
  global.hudLink_Arrows[1]=25; global.hudBelmont_WeaponEn[1]=65; global.hudSamus_Missiles[1]=12; global.hudGame_WeaponEn[1]=150; global.pBreathMax=750
  global.linkBombUpgrade=4; global.metBombUpgrade=0
  tW="766000011000"; tS="440000000000001010005000450000"
}
else if argument0=11 //Vampire Bat (progress 1180)
{
  global.pMaxLife=32; global.pHeartPieces=2
  global.hudLink_Arrows[1]=26; global.hudBelmont_WeaponEn[1]=80; global.hudSamus_Missiles[1]=13; global.hudGame_WeaponEn[1]=150; global.pBreathMax=750
  global.linkBombUpgrade=4; global.metBombUpgrade=0
  tW="776110011000"; tS="443330000000001010005500454000"
}
else if argument0=12 //Dracula (progress 1280)
{
  global.pMaxLife=32; global.pHeartPieces=2
  global.hudLink_Arrows[1]=26; global.hudBelmont_WeaponEn[1]=100; global.hudSamus_Missiles[1]=13; global.hudGame_WeaponEn[1]=150; global.pBreathMax=750
  global.linkBombUpgrade=4; global.metBombUpgrade=0
  tW="776222011000"; tS="443330000000001010005500454000"
}
else if argument0=13 //Menace (progress 1430)
{
  global.pMaxLife=36; global.pHeartPieces=1
  global.hudLink_Arrows[1]=27; global.hudBelmont_WeaponEn[1]=150; global.hudSamus_Missiles[1]=13; global.hudGame_WeaponEn[1]=150; global.pBreathMax=780
  global.linkBombUpgrade=4; global.metBombUpgrade=0
  tW="776444011000"; tS="443330000000001010005500454000"
}
else if argument0=14 //Death (progress 1510)
{
  global.pMaxLife=36; global.pHeartPieces=1
  global.hudLink_Arrows[1]=27; global.hudBelmont_WeaponEn[1]=160; global.hudSamus_Missiles[1]=13; global.hudGame_WeaponEn[1]=150; global.pBreathMax=780
  global.linkBombUpgrade=4; global.metBombUpgrade=0
  tW="776555011000"; tS="443330000000001010005500454000"
}
else if argument0=15 //Death (second track) (progress 1510)
{
  global.pMaxLife=36; global.pHeartPieces=1
  global.hudLink_Arrows[1]=27; global.hudBelmont_WeaponEn[1]=160; global.hudSamus_Missiles[1]=13; global.hudGame_WeaponEn[1]=150; global.pBreathMax=780
  global.linkBombUpgrade=4; global.metBombUpgrade=0
  tW="776555011000"; tS="443330000000001010005500454000"
}
else if argument0=16 //Blackmoor (progress 1520)
{
  global.pMaxLife=40; global.pHeartPieces=1
  global.hudLink_Arrows[1]=27; global.hudBelmont_WeaponEn[1]=165; global.hudSamus_Missiles[1]=13; global.hudGame_WeaponEn[1]=150; global.pBreathMax=780
  global.linkBombUpgrade=4; global.metBombUpgrade=0
  tW="776666011000"; tS="443330000000001010005500454000"
}
else if argument0=17 //Enmity (progress 1680)
{
  global.pMaxLife=40; global.pHeartPieces=3
  global.hudLink_Arrows[1]=29; global.hudBelmont_WeaponEn[1]=180; global.hudSamus_Missiles[1]=13; global.hudGame_WeaponEn[1]=150; global.pBreathMax=840
  global.linkBombUpgrade=4; global.metBombUpgrade=0
  tW="777766011000"; tS="443330000000001010005500454000"
}
else if argument0=18 //Maoh (progress 1830)
{
  global.pMaxLife=44; global.pHeartPieces=0
  global.hudLink_Arrows[1]=29; global.hudBelmont_WeaponEn[1]=180; global.hudSamus_Missiles[1]=14; global.hudGame_WeaponEn[1]=150; global.pBreathMax=840
  global.linkBombUpgrade=4; global.metBombUpgrade=0
  tW="777766111000"; tS="443333300000001010005530454030"
}
else if argument0=19 //Storm Eagle (progress 1849)
{
  global.pMaxLife=44; global.pHeartPieces=3
  global.hudLink_Arrows[1]=29; global.hudBelmont_WeaponEn[1]=185; global.hudSamus_Missiles[1]=15; global.hudGame_WeaponEn[1]=150; global.pBreathMax=840
  global.linkBombUpgrade=4; global.metBombUpgrade=0
  tW="777766456000"; tS="443333300000001010005530454030"
}
else if argument0=20 //Overdrive Ostrich (progress 1849)
{
  global.pMaxLife=44; global.pHeartPieces=3
  global.hudLink_Arrows[1]=29; global.hudBelmont_WeaponEn[1]=185; global.hudSamus_Missiles[1]=15; global.hudGame_WeaponEn[1]=150; global.pBreathMax=840
  global.linkBombUpgrade=4; global.metBombUpgrade=0
  tW="777766456000"; tS="443333300000001010005530454030"
}
else if argument0=21 //Gravity Beetle (progress 1849)
{
  global.pMaxLife=44; global.pHeartPieces=3
  global.hudLink_Arrows[1]=29; global.hudBelmont_WeaponEn[1]=185; global.hudSamus_Missiles[1]=15; global.hudGame_WeaponEn[1]=150; global.pBreathMax=840
  global.linkBombUpgrade=4; global.metBombUpgrade=0
  tW="777766456000"; tS="443333300000001010005530454030"
}
else if argument0=22 //Bospider (progress 1890)
{
  global.pMaxLife=48; global.pHeartPieces=0
  global.hudLink_Arrows[1]=30; global.hudBelmont_WeaponEn[1]=185; global.hudSamus_Missiles[1]=15; global.hudGame_WeaponEn[1]=150; global.pBreathMax=840
  global.linkBombUpgrade=4; global.metBombUpgrade=0
  tW="777766456000"; tS="443333300000001010005530454030"
}
else if argument0=23 //Bit & Byte (progress 1940)
{
  global.pMaxLife=48; global.pHeartPieces=0
  global.hudLink_Arrows[1]=30; global.hudBelmont_WeaponEn[1]=185; global.hudSamus_Missiles[1]=15; global.hudGame_WeaponEn[1]=150; global.pBreathMax=840
  global.linkBombUpgrade=4; global.metBombUpgrade=0
  tW="777766556000"; tS="443333300000001010005530454030"
}
else if argument0=24 //Sigma (progress 1980)
{
  global.pMaxLife=48; global.pHeartPieces=0
  global.hudLink_Arrows[1]=30; global.hudBelmont_WeaponEn[1]=185; global.hudSamus_Missiles[1]=15; global.hudGame_WeaponEn[1]=150; global.pBreathMax=840
  global.linkBombUpgrade=4; global.metBombUpgrade=0
  tW="777766566000"; tS="443333300000001010005530454030"
}
else if argument0=25 //Sigma Epsilon (progress 1980)
{
  global.pMaxLife=48; global.pHeartPieces=0
  global.hudLink_Arrows[1]=30; global.hudBelmont_WeaponEn[1]=185; global.hudSamus_Missiles[1]=15; global.hudGame_WeaponEn[1]=150; global.pBreathMax=840
  global.linkBombUpgrade=4; global.metBombUpgrade=0
  tW="777766566000"; tS="443333300000001010005530454030"
}
else if argument0=26 //Elpizo (progress 1990)
{
  global.pMaxLife=52; global.pHeartPieces=0
  global.hudLink_Arrows[1]=30; global.hudBelmont_WeaponEn[1]=185; global.hudSamus_Missiles[1]=15; global.hudGame_WeaponEn[1]=150; global.pBreathMax=840
  global.linkBombUpgrade=4; global.metBombUpgrade=0
  tW="777766677000"; tS="443333300000001010005530454030"
}
else if argument0=27 //Army Eye (progress 2080)
{
  global.pMaxLife=52; global.pHeartPieces=2
  global.hudLink_Arrows[1]=31; global.hudBelmont_WeaponEn[1]=185; global.hudSamus_Missiles[1]=16; global.hudGame_WeaponEn[1]=150; global.pBreathMax=840
  global.linkBombUpgrade=4; global.metBombUpgrade=0
  tW="777776677000"; tS="443333300000001010005530454030"
}
else if argument0=28 //Hex (progress 2420)
{
  global.pMaxLife=52; global.pHeartPieces=3
  global.hudLink_Arrows[1]=33; global.hudBelmont_WeaponEn[1]=190; global.hudSamus_Missiles[1]=16; global.hudGame_WeaponEn[1]=150; global.pBreathMax=840
  global.linkBombUpgrade=4; global.metBombUpgrade=0
  tW="777776677000"; tS="443333300000001010005530454030"
}
else if argument0=29 //Shadow Form (progress 2540)
{
  global.pMaxLife=52; global.pHeartPieces=3
  global.hudLink_Arrows[1]=33; global.hudBelmont_WeaponEn[1]=190; global.hudSamus_Missiles[1]=16; global.hudGame_WeaponEn[1]=150; global.pBreathMax=870
  global.linkBombUpgrade=4; global.metBombUpgrade=0
  tW="777776677000"; tS="443333300000001010005530454030"
}
else if argument0=30 //Vault Demon (progress 2620)
{
  global.pMaxLife=56; global.pHeartPieces=1
  global.hudLink_Arrows[1]=35; global.hudBelmont_WeaponEn[1]=195; global.hudSamus_Missiles[1]=18; global.hudGame_WeaponEn[1]=150; global.pBreathMax=870
  global.linkBombUpgrade=4; global.metBombUpgrade=0
  tW="777776777000"; tS="443333300000001010005530454030"
}
else if argument0=31 //Arachnus (progress 2855)
{
  global.pMaxLife=60; global.pHeartPieces=0
  global.hudLink_Arrows[1]=35; global.hudBelmont_WeaponEn[1]=195; global.hudSamus_Missiles[1]=37; global.hudGame_WeaponEn[1]=150; global.pBreathMax=900
  global.linkBombUpgrade=4; global.metBombUpgrade=5
  tW="777777777555"; tS="443333330000001110055531454033"
}
else if argument0=32 //King Worm (progress 2840)
{
  global.pMaxLife=60; global.pHeartPieces=0
  global.hudLink_Arrows[1]=35; global.hudBelmont_WeaponEn[1]=195; global.hudSamus_Missiles[1]=37; global.hudGame_WeaponEn[1]=150; global.pBreathMax=900
  global.linkBombUpgrade=4; global.metBombUpgrade=5
  tW="777777777555"; tS="443333330000001110055531454033"
}
else if argument0=33 //Kraid (progress 2750)
{
  global.pMaxLife=56; global.pHeartPieces=3
  global.hudLink_Arrows[1]=35; global.hudBelmont_WeaponEn[1]=195; global.hudSamus_Missiles[1]=29; global.hudGame_WeaponEn[1]=150; global.pBreathMax=870
  global.linkBombUpgrade=4; global.metBombUpgrade=2
  tW="777777777022"; tS="443333330000001110055531454033"
}
else if argument0=34 //Mother Brain (progress 2960)
{
  global.pMaxLife=64; global.pHeartPieces=1
  global.hudLink_Arrows[1]=35; global.hudBelmont_WeaponEn[1]=195; global.hudSamus_Missiles[1]=37; global.hudGame_WeaponEn[1]=150; global.pBreathMax=900
  global.linkBombUpgrade=4; global.metBombUpgrade=5
  tW="777777777666"; tS="443333330000001110055531454033"
}
else if argument0=35 //Ridley (progress 3000)
{
  global.pMaxLife=64; global.pHeartPieces=1
  global.hudLink_Arrows[1]=35; global.hudBelmont_WeaponEn[1]=195; global.hudSamus_Missiles[1]=37; global.hudGame_WeaponEn[1]=150; global.pBreathMax=900
  global.linkBombUpgrade=4; global.metBombUpgrade=5
  tW="777777777666"; tS="443333330000001110055531454033"
}
else if argument0=36 //Ridley (lava) (progress 3000)
{
  global.pMaxLife=64; global.pHeartPieces=1
  global.hudLink_Arrows[1]=35; global.hudBelmont_WeaponEn[1]=195; global.hudSamus_Missiles[1]=37; global.hudGame_WeaponEn[1]=150; global.pBreathMax=900
  global.linkBombUpgrade=4; global.metBombUpgrade=5
  tW="777777777666"; tS="443333330000001110055531454033"
}
else if argument0=37 //Ridley (tunnel) (progress 3000)
{
  global.pMaxLife=64; global.pHeartPieces=1
  global.hudLink_Arrows[1]=35; global.hudBelmont_WeaponEn[1]=195; global.hudSamus_Missiles[1]=37; global.hudGame_WeaponEn[1]=150; global.pBreathMax=900
  global.linkBombUpgrade=4; global.metBombUpgrade=5
  tW="777777777666"; tS="443333330000001110055531454033"
}
else if argument0=38 //Nightmare (progress 3070)
{
  global.pMaxLife=64; global.pHeartPieces=1
  global.hudLink_Arrows[1]=35; global.hudBelmont_WeaponEn[1]=195; global.hudSamus_Missiles[1]=38; global.hudGame_WeaponEn[1]=150; global.pBreathMax=900
  global.linkBombUpgrade=4; global.metBombUpgrade=5
  tW="777777777777"; tS="443333330000001110055531454033"
}
else if argument0=39 //Sand Crawler (progress 3080)
{
  global.pMaxLife=64; global.pHeartPieces=1
  global.hudLink_Arrows[1]=36; global.hudBelmont_WeaponEn[1]=195; global.hudSamus_Missiles[1]=38; global.hudGame_WeaponEn[1]=150; global.pBreathMax=900
  global.linkBombUpgrade=4; global.metBombUpgrade=5
  tW="777777777777"; tS="443333330000001110055531454033"
}
else if argument0=40 //Malevolence (progress 3260)
{
  global.pMaxLife=64; global.pHeartPieces=2
  global.hudLink_Arrows[1]=37; global.hudBelmont_WeaponEn[1]=200; global.hudSamus_Missiles[1]=38; global.hudGame_WeaponEn[1]=150; global.pBreathMax=900
  global.linkBombUpgrade=5; global.metBombUpgrade=5
  tW="777777777777"; tS="443333330000001110055531454033"
}
else if argument0=41 //Leviathan (progress 3320)
{
  global.pMaxLife=64; global.pHeartPieces=2
  global.hudLink_Arrows[1]=37; global.hudBelmont_WeaponEn[1]=200; global.hudSamus_Missiles[1]=38; global.hudGame_WeaponEn[1]=150; global.pBreathMax=900
  global.linkBombUpgrade=5; global.metBombUpgrade=5
  tW="777777777777"; tS="443333330000001110055531454033"
}
else if argument0=42 //Stone Golem (progress 3470)
{
  global.pMaxLife=68; global.pHeartPieces=0
  global.hudLink_Arrows[1]=37; global.hudBelmont_WeaponEn[1]=200; global.hudSamus_Missiles[1]=38; global.hudGame_WeaponEn[1]=204; global.pBreathMax=900
  global.linkBombUpgrade=5; global.metBombUpgrade=5
  tW="777777777777"; tS="443333331432431111555531454133"
}
else if argument0=43 //Fire Elemental (progress 3503)
{
  global.pMaxLife=68; global.pHeartPieces=0
  global.hudLink_Arrows[1]=37; global.hudBelmont_WeaponEn[1]=200; global.hudSamus_Missiles[1]=38; global.hudGame_WeaponEn[1]=204; global.pBreathMax=900
  global.linkBombUpgrade=5; global.metBombUpgrade=5
  tW="777777777777"; tS="443333331432431111555531454133"
}
else if argument0=44 //High Heels Girl (progress 3550)
{
  global.pMaxLife=68; global.pHeartPieces=0
  global.hudLink_Arrows[1]=37; global.hudBelmont_WeaponEn[1]=200; global.hudSamus_Missiles[1]=38; global.hudGame_WeaponEn[1]=208; global.pBreathMax=900
  global.linkBombUpgrade=5; global.metBombUpgrade=5
  tW="777777777777"; tS="443333331432431111555531454133"
}
else if argument0=45 //Unforgotten (progress 3620)
{
  global.pMaxLife=68; global.pHeartPieces=0
  global.hudLink_Arrows[1]=37; global.hudBelmont_WeaponEn[1]=200; global.hudSamus_Missiles[1]=38; global.hudGame_WeaponEn[1]=226; global.pBreathMax=900
  global.linkBombUpgrade=5; global.metBombUpgrade=5
  tW="777777777777"; tS="443333331432431111555531454133"
}
else if argument0=46 //Chosen One (progress 3820)
{
  global.pMaxLife=68; global.pHeartPieces=0
  global.hudLink_Arrows[1]=37; global.hudBelmont_WeaponEn[1]=200; global.hudSamus_Missiles[1]=38; global.hudGame_WeaponEn[1]=250; global.pBreathMax=900
  global.linkBombUpgrade=5; global.metBombUpgrade=5
  tW="777777777777"; tS="443333331432431111555531454133"
}
else if argument0=47 //Sephiroth (progress 3870)
{
  global.pMaxLife=72; global.pHeartPieces=0
  global.hudLink_Arrows[1]=37; global.hudBelmont_WeaponEn[1]=200; global.hudSamus_Missiles[1]=38; global.hudGame_WeaponEn[1]=250; global.pBreathMax=900
  global.linkBombUpgrade=5; global.metBombUpgrade=5
  tW="777777777777"; tS="443333331432431111555531454133"
}
else if argument0=48 //Antipathy (progress 3970)
{
  global.pMaxLife=72; global.pHeartPieces=1
  global.hudLink_Arrows[1]=38; global.hudBelmont_WeaponEn[1]=200; global.hudSamus_Missiles[1]=39; global.hudGame_WeaponEn[1]=250; global.pBreathMax=900
  global.linkBombUpgrade=5; global.metBombUpgrade=5
  tW="778777777777"; tS="443333331432431111555531454133"
}
else if argument0=49 //Sera (progress 4080)
{
  global.pMaxLife=72; global.pHeartPieces=1
  global.hudLink_Arrows[1]=38; global.hudBelmont_WeaponEn[1]=200; global.hudSamus_Missiles[1]=39; global.hudGame_WeaponEn[1]=250; global.pBreathMax=900
  global.linkBombUpgrade=5; global.metBombUpgrade=5
  tW="778777777777"; tS="443333331432431111555531454133"
}
else if argument0=50 //Brain Machine (progress 4310)
{
  global.pMaxLife=72; global.pHeartPieces=2
  global.hudLink_Arrows[1]=39; global.hudBelmont_WeaponEn[1]=200; global.hudSamus_Missiles[1]=39; global.hudGame_WeaponEn[1]=250; global.pBreathMax=900
  global.linkBombUpgrade=5; global.metBombUpgrade=5
  tW="889888888878"; tS="443333331432431111555531454133"
}
else if argument0=51 //Blade Bot (progress 4390)
{
  global.pMaxLife=72; global.pHeartPieces=2
  global.hudLink_Arrows[1]=39; global.hudBelmont_WeaponEn[1]=200; global.hudSamus_Missiles[1]=39; global.hudGame_WeaponEn[1]=250; global.pBreathMax=900
  global.linkBombUpgrade=5; global.metBombUpgrade=5
  tW="889888888878"; tS="443333331432431111555531454133"
}
else if argument0=52 //Combat Apparatus (progress 4460)
{
  global.pMaxLife=72; global.pHeartPieces=2
  global.hudLink_Arrows[1]=39; global.hudBelmont_WeaponEn[1]=200; global.hudSamus_Missiles[1]=39; global.hudGame_WeaponEn[1]=250; global.pBreathMax=900
  global.linkBombUpgrade=5; global.metBombUpgrade=5
  tW="889888888878"; tS="443333331432431111555531454133"
}
else if argument0=53 //Giant Blargg (progress 4480)
{
  global.pMaxLife=72; global.pHeartPieces=3
  global.hudLink_Arrows[1]=39; global.hudBelmont_WeaponEn[1]=200; global.hudSamus_Missiles[1]=39; global.hudGame_WeaponEn[1]=250; global.pBreathMax=900
  global.linkBombUpgrade=5; global.metBombUpgrade=5
  tW="889888888878"; tS="443333331432431111555531454133"
}
else if argument0=54 //Defective (progress 4670)
{
  global.pMaxLife=72; global.pHeartPieces=3
  global.hudLink_Arrows[1]=40; global.hudBelmont_WeaponEn[1]=200; global.hudSamus_Missiles[1]=39; global.hudGame_WeaponEn[1]=250; global.pBreathMax=900
  global.linkBombUpgrade=5; global.metBombUpgrade=5
  tW="899888988888"; tS="443333331432431111555531454133"
}
else if argument0=55 //Shadow Eura (progress 4780)
{
  global.pMaxLife=72; global.pHeartPieces=3
  global.hudLink_Arrows[1]=40; global.hudBelmont_WeaponEn[1]=200; global.hudSamus_Missiles[1]=39; global.hudGame_WeaponEn[1]=250; global.pBreathMax=900
  global.linkBombUpgrade=5; global.metBombUpgrade=5
  tW="999899998999"; tS="443333331432431111555531454133"
}
else if argument0=56 //Decimator (progress 5010)
{
  global.pMaxLife=76; global.pHeartPieces=0
  global.hudLink_Arrows[1]=40; global.hudBelmont_WeaponEn[1]=200; global.hudSamus_Missiles[1]=39; global.hudGame_WeaponEn[1]=250; global.pBreathMax=900
  global.linkBombUpgrade=5; global.metBombUpgrade=5
  tW="999999999999"; tS="443333331432431111555531454133"
}
else if argument0=57 //Decimator (20000) (progress 5010)
{
  global.pMaxLife=76; global.pHeartPieces=0
  global.hudLink_Arrows[1]=40; global.hudBelmont_WeaponEn[1]=200; global.hudSamus_Missiles[1]=39; global.hudGame_WeaponEn[1]=250; global.pBreathMax=900
  global.linkBombUpgrade=5; global.metBombUpgrade=5
  tW="999999999999"; tS="443333331432431111555531454133"
}
else if argument0=58 //Abomination (progress 4950)
{
  global.pMaxLife=72; global.pHeartPieces=3
  global.hudLink_Arrows[1]=40; global.hudBelmont_WeaponEn[1]=200; global.hudSamus_Missiles[1]=39; global.hudGame_WeaponEn[1]=250; global.pBreathMax=900
  global.linkBombUpgrade=5; global.metBombUpgrade=5
  tW="999899998999"; tS="443333331432431111555531454133"
}
else if argument0=59 //Hex Final (progress 5250)
{
  global.pMaxLife=76; global.pHeartPieces=1
  global.hudLink_Arrows[1]=40; global.hudBelmont_WeaponEn[1]=200; global.hudSamus_Missiles[1]=39; global.hudGame_WeaponEn[1]=250; global.pBreathMax=900
  global.linkBombUpgrade=5; global.metBombUpgrade=5
  tW="AAAAAAAAAAAA"; tS="443333331432431111555531454133"
}
else if argument0=60 //Warmaster (progress 5305)
{
  global.pMaxLife=76; global.pHeartPieces=1
  global.hudLink_Arrows[1]=40; global.hudBelmont_WeaponEn[1]=200; global.hudSamus_Missiles[1]=39; global.hudGame_WeaponEn[1]=250; global.pBreathMax=900
  global.linkBombUpgrade=5; global.metBombUpgrade=5
  tW="AAAAAAAAAAAA"; tS="443333331432431111555531454133"
}
else if argument0=61 //Parasitic Seed (progress 5530)
{
  global.pMaxLife=76; global.pHeartPieces=1
  global.hudLink_Arrows[1]=40; global.hudBelmont_WeaponEn[1]=200; global.hudSamus_Missiles[1]=40; global.hudGame_WeaponEn[1]=250; global.pBreathMax=900
  global.linkBombUpgrade=5; global.metBombUpgrade=5
  tW="AAAAAAAAAAAA"; tS="443333331432431111555531454133"
}
else if argument0=62 //Virus Parasite (progress 5550)
{
  global.pMaxLife=76; global.pHeartPieces=1
  global.hudLink_Arrows[1]=40; global.hudBelmont_WeaponEn[1]=200; global.hudSamus_Missiles[1]=40; global.hudGame_WeaponEn[1]=250; global.pBreathMax=900
  global.linkBombUpgrade=5; global.metBombUpgrade=5
  tW="AAAAAAAAAAAA"; tS="443333331432431111555531454133"
}
else if argument0=63 //Hexor (progress 5640)
{
  global.pMaxLife=76; global.pHeartPieces=1
  global.hudLink_Arrows[1]=40; global.hudBelmont_WeaponEn[1]=200; global.hudSamus_Missiles[1]=40; global.hudGame_WeaponEn[1]=250; global.pBreathMax=900
  global.linkBombUpgrade=5; global.metBombUpgrade=5
  tW="AAAAAAAAAAAA"; tS="443333331432431111555531454133"
}
else if argument0=64 //The Executive (progress 5540)
{
  global.pMaxLife=76; global.pHeartPieces=1
  global.hudLink_Arrows[1]=40; global.hudBelmont_WeaponEn[1]=200; global.hudSamus_Missiles[1]=40; global.hudGame_WeaponEn[1]=250; global.pBreathMax=900
  global.linkBombUpgrade=5; global.metBombUpgrade=5
  tW="AAAAAAAAAAAA"; tS="443333331432431111555531454133"
}
else if argument0=65 //Warmaster EX (progress 5380)
{
  global.pMaxLife=76; global.pHeartPieces=1
  global.hudLink_Arrows[1]=40; global.hudBelmont_WeaponEn[1]=200; global.hudSamus_Missiles[1]=39; global.hudGame_WeaponEn[1]=250; global.pBreathMax=900
  global.linkBombUpgrade=5; global.metBombUpgrade=5
  tW="AAAAAAAAAAAA"; tS="443333331432431111555531454133"
}

if tW="" {return 0}

tName[0]="stLink_Sword"; tName[1]="stLink_Arrow"; tName[2]="stLink_Bomb"
tName[3]="stBelmont_HairWhip"; tName[4]="stBelmont_Dagger"; tName[5]="stBelmont_Holywater"
tName[6]="stMega_Buster"; tName[7]="stMega_ShotIce"; tName[8]="stMega_Gravity"
tName[9]="stSamus_Cannon"; tName[10]="stSamus_Missile"; tName[11]="stSamus_Bomb"
for(i=0;i<12;i+=1)
{
  c=string_char_at(tW,i+1)
  if c="A" {c=10}
  else {c=real(c)}
  variable_global_array_set(tName[i],0,c)
}
for(i=0;i<30;i+=1) {global.skillTree[i]=real(string_char_at(tS,i+1))}
return 1
