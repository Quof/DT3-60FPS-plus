image_alpha=0.8
maxDecayTime = 240
decayTime=maxDecayTime
shotDelay=3

var tEffect,tDir;
tDir=0
for(i=0;i<24;i+=1)
{
  tEffect=instance_create(x+lengthdir_x(18,tDir),y+lengthdir_y(18,tDir),oEffect)
  tEffect.sprite_index=sEfDiffusionParticle; tEffect.followID=-1; tEffect.xFollow=0; tEffect.yFollow=0
  tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.image_alpha=0.33
  tEffect.image_speed=0.5; tEffect.speed=1.5; tEffect.direction=tDir
  tDir+=360/24
}

transformStyle = 0 //1 for attack, 2 for defense
transformColor = 0 //1 for red, 2 for blue, 3 for green, 4 for yellow
transformAddColor = 0 //1 for red, 2 for blue, 3 for green, 4 for yellow
bulletColor1 = 0 //1 for red, 2 for blue, 3 for green, 4 for yellow, 5 for cyan, 6 for orange, 7 for black, 8 for white
bulletColor2 = 0 //1 for red, 2 for blue, 3 for green, 4 for yellow, 5 for cyan, 6 for orange, 7 for black, 8 for white
bulletColor3 = 0 //1 for red, 2 for blue, 3 for green, 4 for yellow, 5 for cyan, 6 for orange, 7 for black, 8 for white

//bullet paramters
explodeLevel = 0 //exploding bullets, explode on contact with terrain (not enemy) explosion is more powerful than bullet
bounceLevel = 0 //bouncing bullets, bounce off walls, growing more powerful each time
homeLevel = 0 //homing bullets, homes in on enemies
splitLevel = 0 //split bullets, splits after a second
meleeLevel = 0 //melee bullets, short range high damage
shieldLevel = 0 //shield bullets, very weak bullets that delete enemy projectiles

arcLevel = 0 //thunder arc, aoe elec pulse every so often

atkPower = 100
maxShotDelay = 3
decayPerShot = 5
bulletSpread = 1
autoFire = false
autoAim = false
bulletSpeed = 12
image_blend=c_white
second_blend = c_white
halted = false

enemyBullets = false
