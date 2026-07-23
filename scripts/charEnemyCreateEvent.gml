/*
This script should be placed in the "Create Event" of the character and enemies.
It sets the default values needed for them.
Characters will set their own values for these parameters in their create event after this is set.
*/

if parent!="trap" and parent!="projectile"
{
  maxLife=1           //character's max health
  life=maxLife        //character's current health
  lifePercent=1       //character's health percent
  atkDefense=0        //general defense against attacks (percentage of damage cut)
}
atkPower=0            //base attack power
bShowDamagePopout=1   //show damage dealt to object
bDamageFlash=1        //if the enemy will blink on hit

if bPlayable=false //whether the character is playable
{
  if global.location=58 or global.location=76 or global.location=107
  {
    expValue=0             //the amount of Exp awarded in Gate 6
    bCanBeBlocked=0        //if the object can be blocked
    bParryOpp=0            //if the player can parry
    blockCost=0            //shield energy depleted for guarding (not parry)
  }
  
  if parent!="trap" and parent!="projectile"
  {
    eName=""                 //enemy name
    setNewName=0             //if new alt name was set
    eLevel=1                 //enemy level
    baseItemChance=-100      //chance the enemy will drop an item
    baseDropIndex=95         //the item type the enemy drops (>100: hearts, <100: money)
    pickupDropMod=0          //added chance to drop pickups (checked before hearts vs money)
    moneyWorth=1             //the maximum amount of money an enemy can drop
    pointWorth=0             //the amount of AP awarded when the player kills the enemy
    bNoBonus=false           //whether the enemy gives a bonus
    baseColor=c_white        //color used for sprite shading
    flashTime=1              //how long the enemy flashes red when taking damage
    stunnedTime=0            //how long the enemy is stunned
    stunResist=0             //stun duration shortened by this amount
    hitSound=global.snd_EnemyHit  //sound effect played when enemy is hit
    dieSound=1               //sound effect played when enemy is killed
    dieEffect=1              //effect shown when enemy dies (0 for custom)
    //effectXscale=1           //effect x scale
    //effectYscale=1           //effect y scale
    //effectSpeed=0.9          //effect image speed
    bShowHealthBar=false     //show the enemy health bar
    bIsBoss=false            //relates to effects shown and health meter
    questType=0              //which quest the enemy is related to. 0 is standard enemy
    bCanBeScanned=1          //if the enemy can be scanned
    jeremyText=""            //Jeremy's info on the enemy
    chaoText=""              //Chao's info on the enemy
    devText="N/A"            //My developer comments on the enemy
    hoverAlpha=0             //Alpha for Chao's hover info (Set to -1 if no hover info)
    for(i=0;i<6;i+=1)
    {
      /*
      ----- Resist Type -----
      Index
      -- 0: Normal
      -- 1: Pierce
      -- 2: Elemental
      -- 3: Shot
      -- 4: Explosion
      -- 5: Special
      Value Type
      -- 1: Resistant  > No Damage
      -- 2: Resistant  > Half Damage
      -- 3: Neutral    > Standard Change
      -- 4: Vulnerable > Double Damage
      -- 5: Vulnerable > Triple Damage
      */
      resType[i]=3
    }
    extraInfo="No extra details specified."
    affiliation=0                 //the enemy faction
    //0: Virus infected
    //1: Mario
    //2: Zelda
    //3: Castlevania
    //4: Megaman
    //5: Metroid
    //6: Game (Gate 6)
    //7: CHAOS
    //8: Hex
    bGenEnemy=0                  //if the enemy is a generated enemy
    bCenterDamageNotice=0        //if the damage shown originates from the sprite x/y
    bFixedAP=0                   //always give a set amount of AP
  }
  bDestroyOnDeactivate=false   //if the object will auto destroy when going off-screen
  damageType="NORMAL"          //the type of damage the enemy deals
  bCanDealDamage=true          //whether the enemy can cause damage to the player
  bCauseKnockback=true         //will cause the character to knock back after taking damage from the enemy
  bActive=false                //whether or not the enemy will attack the player
  findTargetX=0                //how close the enemy is to the player
  findTargetY=0                //how close the enemy is to the player
  detectDistX=264              //how close the player has to be to the enemy before it becomes active
  detectDistY=200              //how close the player has to be to the enemy before it becomes active
  if global.partySplit=1 {inactiveDist=10000} //how far till the enemy becomes inactive
  else {inactiveDist=240}
  bDealZeroDamage=0            //the object deals 0 damage (no records are counted)
  bJumpedOn=0                  //if the enemy was Mario stomped
}
else
{
  bCanTakeHit=true     //whether the character can take damage, this is used after the character is hit
  flashTime=30         //how long the character is invulverable after taking damage
  statusSpiritDrain=0
  statusSkillLock=0
}

if parent!="trap" and parent!="projectile"
{
  statusCripple=0        //-40% defense
  statusPoison=0         //-1 life every other frame (15 per second)
  weight=10000           //wind/gravity effects
  damageTime=0           //current time till the character can take damage again
}
bTakingDamage=false    //if the character is currently taking damage
bCanTakeDamage=true    //whether the character can take damage
