//Set the position of the hat
if global.activeCharacter=0
{
  if sprite_index=sJerryIdle or sprite_index=sJerryLookUp
  {
    if image_index<=1.99 {hatDisplayX=-1; hatDisplayY=-49}
    else {hatDisplayX=-1; hatDisplayY=-50}
  }
  else if sprite_index=sJerryWalk or sprite_index=sJerryBusterRun
  {
    if image_index<=0.99 or (image_index>=4 and image_index<=4.99) {hatDisplayX=11; hatDisplayY=-35}
    else if (image_index>=1 and image_index<=1.99) or (image_index>=5 and image_index<=5.99) {hatDisplayX=7; hatDisplayY=-35}
    else if (image_index>=2 and image_index<=2.99) or (image_index>=6 and image_index<=6.99) {hatDisplayX=7; hatDisplayY=-34}
    else {hatDisplayX=8; hatDisplayY=-34}
  }
  else if sprite_index=sJerryDuck or sprite_index=sJerryBusterDuck {hatDisplayX=4; hatDisplayY=-29}
  else if sprite_index=sJerryJump or sprite_index=sJerryBusterJump {hatDisplayX=5; hatDisplayY=-43}
  else if sprite_index=sJerryJumpForward {hatDisplayX=0; hatDisplayY=-30}
  else if sprite_index=sJerryJumpBack {hatDisplayX=1; hatDisplayY=-45}
  else if sprite_index=sJerryAirDash {hatDisplayX=15; hatDisplayY=-28}
  else if sprite_index=sJerrySword
  {
    if image_index<=0.99 {hatDisplayX=0; hatDisplayY=-42}
    else if image_index>=1 and image_index<=1.99 {hatDisplayX=1; hatDisplayY=-42}
    else {hatDisplayX=-1; hatDisplayY=-42}
  }
  else if sprite_index=sJerryFire1 {hatDisplayX=-4; hatDisplayY=-40}
  else if sprite_index=sJerryFire2 {hatDisplayX=-5; hatDisplayY=-41}
  else if sprite_index=sJerryFire3 {hatDisplayX=-3; hatDisplayY=-48}
  else if sprite_index=sJerryBike {hatDisplayX=6; hatDisplayY=-36}
  else if sprite_index=sJerryCasting or sprite_index=sJerryGuard {hatDisplayX=2; hatDisplayY=-38}
  else if sprite_index=sJerryBusterStand {hatDisplayX=-3; hatDisplayY=-40}
  else if sprite_index=sJerryBusterHang {hatDisplayX=0; hatDisplayY=-49}
  else if sprite_index=sJerryBusterGrapple {hatDisplayX=-2; hatDisplayY=-46}
  else if sprite_index=sJerryHang {hatDisplayX=-1; hatDisplayY=-49}
  else if sprite_index=sJerryOnTruck {hatDisplayX=3; hatDisplayY=-44}
  else if sprite_index=sJerryDamaged {hatDisplayX=-7; hatDisplayY=-37}
  else {hatDisplayX=0; hatDisplayY=-1000}
}
else if global.activeCharacter=1
{
  if sprite_index=sClaireIdle
  {
    if image_index<=0.99 {hatDisplayX=2; hatDisplayY=-43}
    else if (image_index>=1 and image_index<=1.99) {hatDisplayX=2; hatDisplayY=-44}
    else if (image_index>=2 and image_index<=2.99) {hatDisplayX=2; hatDisplayY=-43}
    else {hatDisplayX=2; hatDisplayY=-42}
  }
  else if sprite_index=sClaireLookUp {hatDisplayX=-1; hatDisplayY=-45}
  else if sprite_index=sClaireWalk or sprite_index=sClaireCannonRunA or sprite_index=sClaireCannonRunB
  {
    if image_index<=0.99 or (image_index>=4 and image_index<=4.99) {hatDisplayX=9; hatDisplayY=-41}
    else if (image_index>=1 and image_index<=1.99) or (image_index>=5 and image_index<=5.99) {hatDisplayX=10; hatDisplayY=-41}
    else if (image_index>=2 and image_index<=2.99) or (image_index>=6 and image_index<=6.99) {hatDisplayX=10; hatDisplayY=-40}
    else {hatDisplayX=11; hatDisplayY=-40}
  }
  else if sprite_index=sClaireDuck or sprite_index=sClaireCannonDuck {hatDisplayX=0; hatDisplayY=-26}
  else if sprite_index=sClaireJump {hatDisplayX=3; hatDisplayY=-40}
  else if sprite_index=sClaireJumpForward
  {
    if image_index<=0.99 or (image_index>=4 and image_index<=4.99) {hatDisplayX=1; hatDisplayY=-43}
    else if (image_index>=1 and image_index<=1.99) or (image_index>=5 and image_index<=5.99) {hatDisplayX=-4; hatDisplayY=-47}
    else if (image_index>=2 and image_index<=2.99) or (image_index>=6 and image_index<=6.99) {hatDisplayX=2; hatDisplayY=-46}
    else {hatDisplayX=4; hatDisplayY=-47}
  }
  else if sprite_index=sClaireJumpBack {hatDisplayX=-1; hatDisplayY=-37}
  else if sprite_index=sClaireAirDash {hatDisplayX=12; hatDisplayY=-28}
  else if sprite_index=sClaireWallGrab {hatDisplayX=3; hatDisplayY=-35}
  else if sprite_index=sClaireAirRoll {hatDisplayX=0; hatDisplayY=-30}
  else if sprite_index=sClaireHang {hatDisplayX=0; hatDisplayY=-48}
  else if sprite_index=sClaireHairWhip
  {
    if image_index<=0.99 {hatDisplayX=0; hatDisplayY=0}
    else if (image_index>=1 and image_index<=1.99) {hatDisplayX=-1; hatDisplayY=-43}
    else if (image_index>=2 and image_index<=2.99) {hatDisplayX=0; hatDisplayY=-38}
    else if (image_index>=3 and image_index<=3.99) {hatDisplayX=16; hatDisplayY=-32}
    else if (image_index>=4 and image_index<=4.99) {hatDisplayX=17; hatDisplayY=-31}
    else if (image_index>=5 and image_index<=5.99) {hatDisplayX=6; hatDisplayY=-38}
    else {hatDisplayX=-17; hatDisplayY=-36}
  }
  else if sprite_index=sClaireThrow {hatDisplayX=-3; hatDisplayY=-44}
  else if sprite_index=sClaireBladeStrike
  {
    if image_index<=0.99 {hatDisplayX=10; hatDisplayY=-37}
    else if (image_index>=1 and image_index<=1.99) {hatDisplayX=11; hatDisplayY=-36}
    else {hatDisplayX=12; hatDisplayY=-33}
  }
  else if sprite_index=sClaireGuard {hatDisplayX=-1; hatDisplayY=-40}
  else if sprite_index=sClaireCasting {hatDisplayX=1; hatDisplayY=-43}
  else if sprite_index=sClaireCannonStandA {hatDisplayX=-2; hatDisplayY=-45}
  else if sprite_index=sClaireCannonStandB {hatDisplayX=-1; hatDisplayY=-45}
  else if sprite_index=sClaireCannonJumpA or sprite_index=sClaireCannonJumpB or sprite_index=sClaireCannonJumpC {hatDisplayX=1; hatDisplayY=-35}
  else if sprite_index=sClaireMorphBall {hatDisplayX=0; hatDisplayY=-14}
  else if sprite_index=sClaireDamaged {hatDisplayX=-4; hatDisplayY=-44}
  else {hatDisplayX=0; hatDisplayY=-1000}
}
