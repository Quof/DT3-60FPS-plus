event_inherited()
bCanDealDamage=false; bCanTakeDamage=false
bShowHealthBar=true
showBossHP=instance_create(0,0,oBossLifeDisplay); showBossHP.bossID=id; showBossHP.type=0

//Enemy base statistics
eName="None"
eLevel=12
maxLife=10500+1500     //spsp
life=maxLife
bIsBoss=true
bNoBonus=true
bossProgress=0
