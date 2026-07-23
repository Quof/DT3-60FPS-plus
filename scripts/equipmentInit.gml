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
    equipCheck[3]="Doubles the damage you take from every source... This is a useless item, only use it if you want more punishment. Affects both characters."
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
  equipCheck[4]=tItemIndex
}
