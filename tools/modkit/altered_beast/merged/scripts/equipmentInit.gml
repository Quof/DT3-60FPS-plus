/*
This script creates the values from the specified equipment index and returns them in an array.
argument0: Which item list to look at
argument1: Which item index to look at

tEquipCheck has 4 values.
-- 0: Item Index
-- 1: Item Name
-- 2: Item Cost
-- 3: Item Description
-- 4: Item Icon
*/
var tItemList,tItemIndex;
tItemList=argument0
tItemIndex=argument1

equipCheck[0]=tItemIndex
equipCheck[1]=""
equipCheck[2]=0
equipCheck[3]=""
equipCheck[4]=0

if tItemList=1
{
  if tItemIndex=1
  {
    equipCheck[1]="Empty Bottle"
    equipCheck[2]=250
    equipCheck[3]="An empty bottle that can hold various liquids."
    equipCheck[4]=1
  }
  else if tItemIndex=2
  {
    equipCheck[1]="Empty Bottle"
    equipCheck[2]=4500
    equipCheck[3]="An empty bottle that can hold various liquids."
    equipCheck[4]=1
  }
  else if tItemIndex=3
  {
    equipCheck[1]="Empty Bottle"
    equipCheck[2]=10000
    equipCheck[3]="An empty bottle that can hold various liquids."
    equipCheck[4]=1
  }
  else if tItemIndex=4 //Player starts with this
  {
    equipCheck[1]="Equipment Slot"
    equipCheck[2]=0
    equipCheck[3]="Expands your equipment slots by 1."
    equipCheck[4]=4
  }
  else if tItemIndex=5
  {
    equipCheck[1]="Equipment Slot"
    equipCheck[2]=5000
    equipCheck[3]="Expands your equipment slots by 1."
    equipCheck[4]=4
  }
  else if tItemIndex=6
  {
    equipCheck[1]="Equipment Slot"
    equipCheck[2]=12500
    equipCheck[3]="Expands your equipment slots by 1."
    equipCheck[4]=4
  }
  else if tItemIndex=7
  {
    equipCheck[1]="Energy Drink"
    equipCheck[2]=1000
    equipCheck[3]="Restores half of your maximum hearts."
    equipCheck[4]=2
  }
  else if tItemIndex=8
  {
    equipCheck[1]="Turbo Smoothie"
    equipCheck[2]=3000
    equipCheck[3]="This amazingly tasty drink restores all of your hearts!"
    equipCheck[4]=3
  }
}
else if tItemList=2
{
  if global.alterEquip=0
{
  if tItemIndex=1
  {
    equipCheck[1]="Magic Sword"
    equipCheck[2]=2100
    equipCheck[3]="Provides a 5% damage boost to all attacks."
  }
  else if tItemIndex=2
  {
    equipCheck[1]="Sword of Bravery"
    equipCheck[2]=9000
    equipCheck[3]="Provides a 10% damage boost to all attacks."
  }
  else if tItemIndex=3
  {
    equipCheck[1]="Power Glove"
    equipCheck[2]=0
    equipCheck[3]="Provides a 15% damage boost to all attacks, but also increases damage taken by 2."
  }
  else if tItemIndex=4
  {
    equipCheck[1]="Gauntlets of Desire"
    equipCheck[2]=800
    equipCheck[3]="Boosts the item drop rate by 15%."
  }
  else if tItemIndex=5
  {
    equipCheck[1]="Gauntlets of Greed"
    equipCheck[2]=4500
    equipCheck[3]="Boosts the item drop rate by 30%."
  }
  else if tItemIndex=6
  {
    equipCheck[1]="Emerald Tiara"
    equipCheck[2]=1100
    equipCheck[3]="Boosts the chances of bigger Internetz drops by 15%."
  }
  else if tItemIndex=7
  {
    equipCheck[1]="Diamond Tiara"
    equipCheck[2]=5000
    equipCheck[3]="Boosts the chances of bigger Internetz drops by 30%."
  }
  else if tItemIndex=8
  {
    equipCheck[1]="Heart Bracelet"
    equipCheck[2]=6700
    equipCheck[3]="Increases Belmont's Heart recovery by 14%."
  }
  else if tItemIndex=9
  {
    equipCheck[1]="Energy Orb"
    equipCheck[2]=7000
    equipCheck[3]="Reduces the charge time of the X-Buster by 17.5% and X-Specials by 20%."
  }
  else if tItemIndex=10
  {
    equipCheck[1]="Cursed Helm"
    equipCheck[2]=0
    equipCheck[3]="When equipped with all 3 cursed items, a mysterious effect occurs to the wearer."
  }
  else if tItemIndex=11
  {
    equipCheck[1]="Cursed Ring"
    equipCheck[2]=0
    equipCheck[3]="When equipped with all 3 cursed items, a mysterious effect occurs to the wearer."
  }
  else if tItemIndex=12
  {
    equipCheck[1]="Cursed Pendant"
    equipCheck[2]=0
    equipCheck[3]="When equipped with all 3 cursed items, a mysterious effect occurs to the wearer."
  }
  else if tItemIndex=13
  {
    equipCheck[1]="Dragon Feather Ring"
    equipCheck[2]=8000
    equipCheck[3]="Boosts dash invulnerability time by 22%. (Two extra frames.)"
  }
  else if tItemIndex=14
  {
    equipCheck[1]="Mithril Shield"
    equipCheck[2]=2200
    equipCheck[3]="Decreases damage from Elemental sources by 1."
  }
  else if tItemIndex=15
  {
    equipCheck[1]="Kevlar Vest"
    equipCheck[2]=2200
    equipCheck[3]="Decreases damage from Explosions by 1."
  }
  else if tItemIndex=16
  {
    equipCheck[1]="Tactful Helmet"
    equipCheck[2]=3500
    equipCheck[3]="Decreases damage from direct enemy contact by 1."
  }
  else if tItemIndex=17
  {
    equipCheck[1]="Force Armor"
    equipCheck[2]=4500
    equipCheck[3]="Decreases damage from Normal type sources by 1."
  }
  else if tItemIndex=18
  {
    equipCheck[1]="Plot Armor"
    equipCheck[2]=0
    equipCheck[3]="Decreases damage from all sources by 1, but also decreases damage dealt by 10%."
  }
  else if tItemIndex=19
  {
    equipCheck[1]="Blast Cannon"
    equipCheck[2]=6500
    equipCheck[3]="Reduces the charge time of the Samus Diffusion Missiles by 25%."
  }
  else if tItemIndex=20
  {
    equipCheck[1]="Bomb Amulet"
    equipCheck[2]=5000
    equipCheck[3]="Reduce the cooldown of Link's Bombs by 16%."
  }
  else if tItemIndex=21
  {
    equipCheck[1]="Wind Orb"
    equipCheck[2]=800
    equipCheck[3]="Reduce the cost of Spam Shot by 25%."
  }
  else if tItemIndex=22
  {
    equipCheck[1]="Zephyr Amulet"
    equipCheck[2]=800
    equipCheck[3]="Reduce the cost of Bird Swarm by 33%."
  }
  else if tItemIndex=23
  {
    equipCheck[1]="Razor Blade"
    equipCheck[2]=800
    equipCheck[3]="Reduce the cost of Blade Strike by 25%."
  }
  else if tItemIndex=24
  {
    equipCheck[1]="Magic Urn"
    equipCheck[2]=800
    equipCheck[3]="Reduce the cost of Chainblade Storm by 33%."
  }
  else if tItemIndex=25
  {
    equipCheck[1]="Speed Booster"
    equipCheck[2]=6700
    equipCheck[3]="Boosts the dash recovery speed by 16%."
  }
  else if tItemIndex=26
  {
    equipCheck[1]="Durable Pants"
    equipCheck[2]=5500
    equipCheck[3]="Decreases damage from traps by 1."
  }
  else if tItemIndex=27
  {
    equipCheck[1]="Dark Omen"
    equipCheck[2]=100
    //equipCheck[3]="Doubles the damage you take from every source... This is a useless item, only use it if you want more punishment. Affects both characters."
    //dark omen change: the New Dark Omen's description (dipswitch: remasterSwitchList), or the original's with it off
    if global.newDarkOmen=1 {equipCheck[3]="Drastically weakens your weaponry and durability. Only use this item if you want more punishment... or if you are hunting for its secret purpose. Affects both characters."}
    else {equipCheck[3]="Doubles the damage you take from every source... This is a useless item, only use it if you want more punishment. Affects both characters."}
  }
  else if tItemIndex=28
  {
    equipCheck[1]="Rainbow Heart"
    equipCheck[2]=5800
    equipCheck[3]="Dealing damage with the Hair Whip will recover 3 extra Heart Energy."
  }
  else if tItemIndex=29
  {
    equipCheck[1]="Energy Gem"
    equipCheck[2]=5100
    equipCheck[3]="X-Buster always fires a mid-charged shot, but X-Buster energy drain is increased by 50%."
  }
  else if tItemIndex=30
  {
    equipCheck[1]="Golden Bow"
    equipCheck[2]=3000
    equipCheck[3]="Arrows will always pierce through enemies, regardless of charge level."
  }
  else if tItemIndex=31
  {
    equipCheck[1]="Golden Shield"
    equipCheck[2]=1200
    equipCheck[3]="Allows an additional frame to parry."
  }
  else if tItemIndex=32
  {
    equipCheck[1]="Morph Mortar"
    equipCheck[2]=2500
    equipCheck[3]="The charge time for Morph Ball Spam matches the charge time of the Spazer Beam."
  }
  else if tItemIndex=33
  {
    equipCheck[1]="Freezer Core"
    equipCheck[2]=3500
    equipCheck[3]="Shotgun Ice splits into 5 parts. There may be a hidden effect as well."
  }
  else if tItemIndex=34
  {
    equipCheck[1]="Rail Gun"
    equipCheck[2]=6000
    equipCheck[3]="All Samus missiles fired are Diffusion Missiles, but 5 missiles are consumed instead of 3, and only one can be fired at a time."
  }
  else if tItemIndex=35
  {
    equipCheck[1]="X's Headpiece"
    equipCheck[2]=4000
    equipCheck[3]="Decreases the energy usage of charged X Specials by 50%."
  }
  else if tItemIndex=36
  {
    equipCheck[1]="Crossbow"
    equipCheck[2]=5000
    equipCheck[3]="Increases the arrow damage by 50%, but only one arrow can be fired at a time."
  }
  else if tItemIndex=37
  {
    equipCheck[1]="Plasma Canister"
    equipCheck[2]=4100
    equipCheck[3]="The Spazer Beam always pierces through enemies, but it also generates 10% more heat per shot."
  }
  else if tItemIndex=38
  {
    equipCheck[1]="Mystic Dagger"
    equipCheck[2]=4800
    equipCheck[3]="The Daggers will bounce off walls toward the nearest enemy, but consumes 20% more hearts. Once deflected off the wall, they are incapable of activating switches and cutting ropes."
  }
  else if tItemIndex=39
  {
    equipCheck[1]="Blessed Vessel"
    equipCheck[2]=4100
    equipCheck[3]="Holy Water explosions trail along the ground a short distance, but consumes 20% more hearts."
  }
  else if tItemIndex=40
  {
    equipCheck[1]="Gravity Displacer"
    equipCheck[2]=5800
    equipCheck[3]="The charged Gravity Well will now aim at the nearest enemy, but consumes 25% more energy."
  }
  }
  else //alter items below here vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
  {
  if tItemIndex=1
      {
        equipCheck[1]="Master Sword"
        equipCheck[2]=2100
        equipCheck[3]="(Jerry) Enables Nightmare Sword Wave. Nightmare only: Allows Sword Wave to be used at or above 66% health." //changed and implemented on normal
      }
      else if tItemIndex=2
      {
        equipCheck[1]="Long Sword"
        equipCheck[2]=9000
        equipCheck[3]="(Jerry) Increases Link Sword range." //changed and implemented
      }
      else if tItemIndex=3
      {
        equipCheck[1]="Feral Claws"
        equipCheck[2]=0
        equipCheck[3]="(Either) Increases melee attack speed." //changed and implemented
      }
      else if tItemIndex=4
      {
        equipCheck[1]="Gauntlets of Grabbing"
        equipCheck[2]=800
        equipCheck[3]="(Jerry) Grapple works on enemies." // changed and implemented
      }
      else if tItemIndex=5
      {
        equipCheck[1]="Gauntlets of Rage"
        equipCheck[2]=4500
        equipCheck[3]="(Either) Battle Rage: Gain 15% damage for 3 seconds after killing an enemy." //changed and implemented
      }
      else if tItemIndex=6
      {
        equipCheck[1]="Gravity Tiara"
        equipCheck[2]=1100
        equipCheck[3]="(Either) Dashing into Gravity Wells extends your dash." //changed and implemented (look at physics more maybe?)
      }
      else if tItemIndex=7
      {
        equipCheck[1]="Mystery Tiara"
        equipCheck[2]=5000
        equipCheck[3]="(Either) Hold an Action button while pressing character change to do a special move (one for each damage type). Special moves cost green hearts, deal damage to turn them red again. Getting hit will remove any green hearts in addition to the normal damage."
        //hooo boy gotta make one for each of 12 attacks. Some ideas: ALL DONE!
        //Holy Water: Jerry comes out and shoots shotgun ice at it, causing sparks of green ice to shatter forward, doing good damage if shotgunned. Can also apply holy water weakness if that item is equipped.
      }
      else if tItemIndex=8
      {
        equipCheck[1]="Nightmare Bracelet"
        equipCheck[2]=6700
        equipCheck[3]="(Both) Become surrounded by a nightmare effect, slows down MOST projectiles (Activates next map). Try fighting Elpizo with this eqiupped. :^)" //changed and implemented
      }
      else if tItemIndex=9
      {
        equipCheck[1]="Lemon Orb"
        equipCheck[2]=7000
        equipCheck[3]="(Jerry) You cannot charge the megabuster. Uncharged shots do half damage, but can be spammed." //changed and implemented
      }
      else if tItemIndex=10
      {
        equipCheck[1]="Curse of Resistance"
        equipCheck[2]=0
        equipCheck[3]="(Both) Needed for cursed trials. Enemy resistances upped by one level (immune upgrades to absorb), both characters deal 50% more damage. (Activates next map)" //changed and implemented 
      }
      else if tItemIndex=11
      {
        equipCheck[1]="Curse of Armor"
        equipCheck[2]=0
        equipCheck[3]="(Both) Needed for cursed trials. Enemies gain 3 armor, making the first 3 attacks do no damage. Some enemies can gain the armor back in certain ways. (Activates next map)" //changed and implemented
      }
      else if tItemIndex=12
      {
        equipCheck[1]="Curse of Sloth"
        equipCheck[2]=0
        equipCheck[3]="(Both) Needed for cursed trials. Disables dash regen, gain 0.25% of a dash per HP damage dealt to enemies." // changed and implemented
      }
      else if tItemIndex=13
      {
        equipCheck[1]="Shadow Clone Ring"
        equipCheck[2]=8000
        equipCheck[3]="(Either) Dash after images deal a small amount of true damage."//changed and implemented
      }
      else if tItemIndex=14
      {
        equipCheck[1]="Mystery Shield"
        equipCheck[2]=2200
        equipCheck[3]="(Either) Switching to your partner causes various effects depending on the last damage type you dealt damage with." //changed and implemented
      }
      else if tItemIndex=15
      {
        equipCheck[1]="Bomber Jacket"
        equipCheck[2]=2200
        equipCheck[3]="(Either) Explosive damage on an enemy causes that enemy become Weakened, taking 15% more damage for 3 seconds." //changed and implemented, maybe add a visual indicator to weakened enemies? maybe add more time too
      }
      else if tItemIndex=16
      {
        equipCheck[1]="Phase Helmet"
        equipCheck[2]=3500
        equipCheck[3]="(Either) You take no contact damage. Take triple damage from all other sources." //changed and implemented
      }
      else if tItemIndex=17
      {
        equipCheck[1]="Focus Armor"
        equipCheck[2]=4500
        equipCheck[3]="(Either) Every 5th hit will do 150% damage (count resets on character swap)." //changed and implemented
      }
      else if tItemIndex=18
      {
        equipCheck[1]="Armor of What Could Have Been"
        equipCheck[2]=0
        equipCheck[3]="(Either) Action B on this character's melee set is different." //changed and implemented (tweak more maybe)
      }
      else if tItemIndex=19
      {
        equipCheck[1]="Payload Cannon"
        equipCheck[2]=6500
        equipCheck[3]="(Claire) Charging Missiles takes 50% longer, takes 10 missiles, and shoots a staggered line of 4 Diffusion Missles." //changed and implemented
      }
      else if tItemIndex=20
      {
        equipCheck[1]="Useless Amulet"
        equipCheck[2]=5000
        objectToSpawn = "Useless Data"
        item = global.amuletItem
        if item=0
        {
            objectToSpawn = "Useless Data"
        }
        else if item=1
        {
            objectToSpawn = "Grapple Point"
        }
        else if item=2
        {
            objectToSpawn = "Bouncer"
        }
        else if item=3
        {
            objectToSpawn = "Cannon"
        }
        else if item=4
        {
            objectToSpawn = "Toady"
        }
        else if item=5
        {
            objectToSpawn = "Rocketeer :jetpizza:"
        }
        equipCheck[3]="(Jerry) Link Bomb explosions spawn a certain object, press M to toggle.# Current object is: " + objectToSpawn + "." //changed and implemented
      }
      else if tItemIndex=21
      {
        equipCheck[1]="Wind Orb"
        equipCheck[2]=800
        equipCheck[3]="(Both) :fml:" //changed and implemented
      }
      else if tItemIndex=22
      {
        equipCheck[1]="Zephyr Amulet"
        equipCheck[2]=800
        equipCheck[3]="(Either) Friend to all birds." //changed and implemented
      }
      else if tItemIndex=23
      {
        equipCheck[1]="Razor Blade"
        equipCheck[2]=800
        red = "NO"
        if global.snakeRed=1
        {
            red = "YES"
        }
        equipCheck[3]="(Both) Ow the edge! (Activates next map) #Press " + global.ctrlCharSwap + " and " + global.ctrlAbilSwap + " to change length, " + global.ctrlDashLeft + " and " + global.ctrlDashRight + " to change delay, and M to toggle red #Length: " + string(global.snakeLength) + "  Delay: " + string(global.snakeDelay) + " Red: " + red //changed and implemented
      }
      else if tItemIndex=24
      {
        equipCheck[1]="Gunpowder Urn"
        equipCheck[2]=800
        equipCheck[3]="(Either) Doubles explosion radius, at the cost of 30% explosion damage." //changed and implemented
      }
      else if tItemIndex=25
      {
        equipCheck[1]="Speed Booster"
        equipCheck[2]=6700
        dash = "OFF"
        if global.dashOnly=1
        {
            dash = "ON"
        }
        equipCheck[3]="(Either) Dashing through a projectile gives Bloodlust, giving your next attack 50% more damage.#(Optional Both) Dash Only mode: Infinite dash energy, but you cannot walk. Press M to toggle, takes effect next map. Currently " + dash //changed and implemented
      }
      else if tItemIndex=26
      {
        equipCheck[1]="Slide Pants"
        equipCheck[2]=5500
        crouch = "OFF"
        if global.crouchOnly=1
        {
            crouch = "ON"
        }
        equipCheck[3]="(Either) Minimizes friction while ducking. #(Optional Both) Crouch Only mode, if you are walking or standing, you lose health quick! Press M to toggle, currently " + crouch //changed and implemented
      }
      else if tItemIndex=27
      {
        equipCheck[1]="Nightmare Omen"
        equipCheck[2]=100
        equipCheck[3]="(Both) What a nightmare..." //changed and implemented
      }
      else if tItemIndex=28
      {
        equipCheck[1]="Momentum Heart"
        equipCheck[2]=5800
        equipCheck[3]="(Either) Dealing melee damage grants 1 stack of momentum. Each stack increases melee damage by 2%, max 10 stacks. Stacks expire after 2 seconds of no melee damage." //changed and implemented
      }
      else if tItemIndex=29
      {
        equipCheck[1]="Moogy Gem"
        equipCheck[2]=5100
        equipCheck[3]="(Jerry) Enables Moogy Buster. If on nightmare, increases Moogy Buster stock by 1." //changed and implemented
      }
      else if tItemIndex=30
      {
        equipCheck[1]="Shotgun Bow"
        equipCheck[2]=3000
        equipCheck[3]="(Jerry) Charging the bow will shoot 5 piercing arrows in a spread, each does 60% normal damage." //changed and implemented
      }
      else if tItemIndex=31
      {
        equipCheck[1]="Sorta Cursed Shield"
        equipCheck[2]=1200
        equipCheck[3]="(Both) Enemies take 25 less damage from all attacks (Before resists) (Activates next map)." //changed and implemented
      }
      else if tItemIndex=32
      {
        equipCheck[1]="Power Mortar"
        equipCheck[2]=2500
        equipCheck[3]="(Claire) Enables Power Bomb (charge morph bomb). If on nightmare, decrease charge time and cooldown by 20%." //changed and implemented
      }
      else if tItemIndex=33
      {
        equipCheck[1]="Shotgun Core"
        equipCheck[2]=3500
        equipCheck[3]="(Jerry) Charged Shotgun Ice is now Ice Shotgun." //changed and implemented
      }
      else if tItemIndex=34
      {
        equipCheck[1]="Freezer Gun"
        equipCheck[2]=6000
        equipCheck[3]="(Claire) Diffusion missiles deal Elemental damage." //changed and implemented
      }
      else if tItemIndex=35
      {
        equipCheck[1]="Original Headpiece"
        equipCheck[2]=4000
        equipCheck[3]="(Jerry) Enabled level 4 mega buster charge (OG nightmare players will remember this)." //changed and implemented (figure out how it interacts with moogy buster, level 3 charges shouldn't come out if one charge is charged)
      }
      else if tItemIndex=36
      {
        equipCheck[1]="Grip Tip Arrow"
        equipCheck[2]=5000
        equipCheck[3]="(Jerry) I have a bomb, I have an arrow. AH. Arrow Bomb!" //changed and implemented
      }
      else if tItemIndex=37
      {
        equipCheck[1]="Plasma Canister"
        equipCheck[2]=4100
        equipCheck[3]="(Claire) Charged Spazer deals less damage at first, damage goes up with each successive hit." //changed and implemented pending balance (test more ratios)
      }
      else if tItemIndex=38
      {
        equipCheck[1]="Mystic Dagger"
        equipCheck[2]=4800
        equipCheck[3]="(Claire) Enables Nightmare Dagger Special (down down Action B). Nightmare Only increases dagger count by 2." //changed and implemented
      }
      else if tItemIndex=39
      {
        equipCheck[1]="Cursed Vessel"
        equipCheck[2]=4100
        equipCheck[3]="(Claire) Enemies hit by Holy Water explosion are Weakened, taking 15% extra damage for 3 seconds." //changed and implemented
      }
      else if tItemIndex=40
      {
        equipCheck[1]="Gravity Displacer" 
        equipCheck[2]=5800
        equipCheck[3]="(Jerry) Charged Gravity Displacer is now an expanding ring of gravity blasts." //changed and implemented
      }
  }
  
  equipCheck[4]=tItemIndex
}
