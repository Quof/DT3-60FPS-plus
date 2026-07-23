/*
This script is used to give AP to the player and checks if the AP level increases
argument0: AP awarded
*/
var tAPaward;
tAPaward=argument0

global.recTotalAP+=tAPaward
global.pAPExp+=tAPaward

if global.pAPLevel<40
{
  while global.pAPExp>=global.pAPNext
  {
    if !instance_exists(oLevelUpNotice)
      instance_create(oPlayer1.x,oPlayer1.y-42,oLevelUpNotice)

    global.pAP+=5
    global.pAPLevel+=1
    global.pAPExp-=global.pAPNext

    if global.pAPLevel=1 {global.pAPNext=200}
    else if global.pAPLevel=2 {global.pAPNext=300}
    else if global.pAPLevel=3 {global.pAPNext=400}
    else if global.pAPLevel=4 {global.pAPNext=500}
    else if global.pAPLevel=5 {global.pAPNext=600}
    else if global.pAPLevel=6 {global.pAPNext=800}
    else if global.pAPLevel=7 {global.pAPNext=1000}
    else if global.pAPLevel=8 {global.pAPNext=1200}
    else if global.pAPLevel=9 {global.pAPNext=1500}
    else if global.pAPLevel=10 {global.pAPNext=1800}
    else if global.pAPLevel=11 {global.pAPNext=2200}
    else if global.pAPLevel=12 {global.pAPNext=2500}
    else if global.pAPLevel=13 {global.pAPNext=3000}
    else if global.pAPLevel=14 {global.pAPNext=3500}
    else if global.pAPLevel=15 {global.pAPNext=4000}
    else if global.pAPLevel=16 {global.pAPNext=4800}
    else if global.pAPLevel=17 {global.pAPNext=5700}
    else if global.pAPLevel=18 {global.pAPNext=6600}
    else if global.pAPLevel=19 {global.pAPNext=7400}
    else if global.pAPLevel=20 {global.pAPNext=8500}
    else if global.pAPLevel=21 {global.pAPNext=9000}
    else if global.pAPLevel=22 {global.pAPNext=9500}
    else if global.pAPLevel=23 {global.pAPNext=10000}
    else if global.pAPLevel=24 {global.pAPNext=11000}
    else if global.pAPLevel=25 {global.pAPNext=12500}
    else if global.pAPLevel=26 {global.pAPNext=13000}
    else if global.pAPLevel=27 {global.pAPNext=14000}
    else if global.pAPLevel=28 {global.pAPNext=15000}
    else if global.pAPLevel=29 {global.pAPNext=16000}
    else if global.pAPLevel=30 {global.pAPNext=17500}
    else if global.pAPLevel=31 {global.pAPNext=18500}
    else if global.pAPLevel=32 {global.pAPNext=20000}
    else if global.pAPLevel=33 {global.pAPNext=21000}
    else if global.pAPLevel=34 {global.pAPNext=22500}
    else if global.pAPLevel=35 {global.pAPNext=24000}
    else if global.pAPLevel=36 {global.pAPNext=25500}
    else if global.pAPLevel=37 {global.pAPNext=26500}
    else if global.pAPLevel=38 {global.pAPNext=28000}
    else if global.pAPLevel=39 {global.pAPNext=30000}
    else if global.pAPLevel=40 {global.pAPNext=100000}
  }
}
