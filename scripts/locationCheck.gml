/*
This script will update the area the player is in and if it detects the player moved to a new one,
will display on-screen what the new area is.
Also updates the locations the player has discovered.
argument0: location index
*/
var tNewLoc,newLocation,mapIndexCheck;
tNewLoc=argument0

if room!=rTitle
{
  mapIndexCheck=string_char_at(global.mapAreas,tNewLoc)
  if mapIndexCheck="0"
  {
    var tNewString;
    tNewString=string_delete(global.mapAreas,tNewLoc,1)
    tNewString=string_insert("1",tNewString,tNewLoc)
    global.mapAreas=tNewString
  }
}

if tNewLoc!=global.location
{
  global.location=tNewLoc

  if global.location=1 {tNewLoc="Grand Rising"}
  else if global.location=2 {tNewLoc="Initiate's Pass - West"}
  else if global.location=3 {tNewLoc="Initiate's Pass - Central"}
  else if global.location=4 {tNewLoc="Initiate's Pass - East"}
  else if global.location=5 {tNewLoc="Stratum Steppe"}
  else if global.location=6 {tNewLoc="Stratum Steppe Alcove"}
  else if global.location=7
  {
    if room!=rTitle {tNewLoc="Access Gate 1: Mushroom Kingdom"}
    else {tNewLoc="Access Gate 1"}
  }
  else if global.location=8 {tNewLoc="Greatest Stretch"}
  else if global.location=9 {tNewLoc="Central City - North"}
  else if global.location=10
  {
    if room!=rTitle {tNewLoc="Access Gate 2: Hyrule"}
    else {tNewLoc="Access Gate 2"}
  }
  else if global.location=11 {tNewLoc="Magical Hills - West"}
  else if global.location=12 {tNewLoc="Magical Treetops"}
  else if global.location=13 {tNewLoc="Magical Tree Tower"}
  else if global.location=14 {tNewLoc="Magical Canopy"}
  else if global.location=15
  {
    if room!=rTitle {tNewLoc="Access Gate 3: Transylvania"}
    else {tNewLoc="Access Gate 3"}
  }
  else if global.location=16 {tNewLoc="Magical Underbrush"}
  else if global.location=17 {tNewLoc="Magical Hills - East"}
  else if global.location=18 {tNewLoc="Initiate's Overpass"}
  else if global.location=19 {tNewLoc="Lost Entrance"}
  else if global.location=20 {tNewLoc="Begonia - Beach"}
  else if global.location=21 {tNewLoc="Begonia - Dividing Pass"}
  else if global.location=22 {tNewLoc="Begonia - East Mountain"}
  else if global.location=23 {tNewLoc="Begonia - West Mountain"}
  else if global.location=24 {tNewLoc="Begonia - Mountain Temple"}
  else if global.location=25 {tNewLoc="Begonia - Waterway Passage"}
  else if global.location=26 {tNewLoc="Begonia - Watery Cave"}
  else if global.location=27 {tNewLoc="Begonia - Waterfront Blockage"}
  else if global.location=28 {tNewLoc="Begonia - Floating Isles"}
  else if global.location=29
  {
    if room!=rTitle {tNewLoc="Access Gate 4: Megapolis"}
    else {tNewLoc="Access Gate 4"}
  }
  else if global.location=30 {tNewLoc="Magical Hills - Overstep"}
  else if global.location=31 {tNewLoc="Farreaches - Extrapolate"}
  else if global.location=32 {tNewLoc="Farreaches - Anticipate"}
  else if global.location=33 {tNewLoc="Farreaches - Perception"}
  else if global.location=34 {tNewLoc="Farreaches - Bubble Tower"}
  else if global.location=35 {tNewLoc="Farreaches - Contemplate"}
  else if global.location=36 {tNewLoc="Farreaches - Envisage"}
  else if global.location=37 {tNewLoc="Farreaches - Foresight"}
  else if global.location=38 {tNewLoc="Farreaches - Conceptualize"}
  else if global.location=39 {tNewLoc="Farreaches - Consciousness"}
  else if global.location=40 {tNewLoc="The Vault"}
  else if global.location=41 {tNewLoc="Central City - South"}
  else if global.location=42 {tNewLoc="Barrens - Mid Waste"}
  else if global.location=43 {tNewLoc="Barrens - Upper Waste"}
  else if global.location=44 {tNewLoc="Barrens - Lower Waste"}
  else if global.location=45 {tNewLoc="Barrens - Twin Rocks"}
  else if global.location=46 {tNewLoc="Barrens - Simmering Stretch"}
  else if global.location=47 {tNewLoc="Barrens - Great Falloff"}
  else if global.location=48 {tNewLoc="Barrens - Oasis"}
  else if global.location=49
  {
    if room!=rTitle {tNewLoc="Access Gate 5: Research Facility"}
    else {tNewLoc="Access Gate 5"}
  }
  else if global.location=50 {tNewLoc="Barrens - Deserted Tower"}
  else if global.location=51 {tNewLoc="Burning Stretch - West"}
  else if global.location=52 {tNewLoc="Burning Stretch - Mid"}
  else if global.location=53 {tNewLoc="Neo Grime - Rooftops"}
  else if global.location=54 {tNewLoc="Neo Grime - Slums"}
  else if global.location=55 {tNewLoc="Burning Stretch - East"}
  else if global.location=56 {tNewLoc="Burning Stretch - Land's End"}
  else if global.location=57 {tNewLoc="Neo Grime City"}
  else if global.location=58
  {
    if room!=rTitle {tNewLoc="Access Gate 6: Prototype Game"}
    else {tNewLoc="Access Gate 6"}
  }
  else if global.location=59 {tNewLoc="Hidden Program Facility"}
  else if global.location=60 {tNewLoc="Initiate's Pass - Secret Land"}
  else if global.location=61 {tNewLoc="Starry Skies - Snowy Mountains"}
  else if global.location=62 {tNewLoc="Starry Skies - Windy Hills"}
  else if global.location=63 {tNewLoc="Starry Skies - Secret Mountainside"}
  else if global.location=64 {tNewLoc="Starry Skies - Rolling Hills"}
  else if global.location=65 {tNewLoc="Starry Skies - East Great Mountain"}
  else if global.location=66 {tNewLoc="Starry Skies - West Great Mountain"}
  else if global.location=67 {tNewLoc="Starry Skies - Windy Slopes"}
  else if global.location=68 {tNewLoc="Starry Skies - Fierce Skies"}
  else if global.location=69 {tNewLoc="CHAOS Weapons Facility"}
  else if global.location=70 {tNewLoc="Lava Cave"}
  else if global.location=71 {tNewLoc="Starry Skies - Lava Peak"}
  else if global.location=72 {tNewLoc="Grand Impediment"}
  else if global.location=73 {tNewLoc="Grand Lower Cavity"}
  else if global.location=74 {tNewLoc="Grand High Grounds"}
  else if global.location=75 {tNewLoc="Barrens - Colossal Encroachment"}
  else if global.location=76 {tNewLoc="Great Colossal Falloff"}
  else if global.location=77 {tNewLoc="Magical Floating Branches"}
  else if global.location=78 {tNewLoc="Magical Treeless Pass"}
  else if global.location=79 {tNewLoc="Highlands - Odyssey"}
  else if global.location=80 {tNewLoc="Highlands - Super Falls"}
  else if global.location=81 {tNewLoc="Highlands - Woods of Genesis"}
  else if global.location=82 {tNewLoc="Highlands - Forgotten Virtual Growth"}
  else if global.location=83 {tNewLoc="Highlands - Upper Dream Path"}
  else if global.location=84 {tNewLoc="Highlands - Upper Crossroad"}
  else if global.location=85 {tNewLoc="Tranquil Serenity"}
  else if global.location=86 {tNewLoc="Hidden Bot Village"}
  else if global.location=87 {tNewLoc="Barrens - Rock Blockage"}
  else if global.location=88 {tNewLoc="The Discombobulated"}
  else if global.location=89 {tNewLoc="Farreaches - Determine"}
  else if global.location=90 {tNewLoc="Displaced Construction Site"}
  else if global.location=91 {tNewLoc="Subconscious Filter"}
  else if global.location=92 {tNewLoc="Farreaches - Envision"}
  else if global.location=93 {tNewLoc="Magical Castle"}
  else if global.location=94 {tNewLoc="Skies of Dragoon"}
  else if global.location=95 {tNewLoc="Farreaches - Aversion"}
  else if global.location=96 {tNewLoc="Highlands - The One Four You"}
  else if global.location=97 {tNewLoc="Farreaches - Hypothesis"}
  else if global.location=98 {tNewLoc="Grand Not Hidden Well"}
  else if global.location=99 {tNewLoc="CHAOS Warship"}
  else if global.location=101 {tNewLoc="Nightmare Gate A"}
  else if global.location=102 {tNewLoc="Nightmare Gate B"}
  else if global.location=103 {tNewLoc="Nightmare Gate C"}
  else if global.location=104 {tNewLoc="Nightmare Gate D"}
  else if global.location=105 {tNewLoc="Nightmare Gate E"}
  else if global.location=106 {tNewLoc="Nightmare Gate F"}
  else if global.location=107 {tNewLoc="Nightmare Gate G"}
  else if global.location=108 {tNewLoc="Nightmare Gate H"}
  else if global.location=109 {tNewLoc="Sacred Temple"}
  else if global.location=110 {tNewLoc="The Distortion"}

  if room!=rTitle
  {
    if global.optShowArea=1
    {
      newLocation=instance_create(0,0,oLocationDisplay)
      newLocation.locDisplay=tNewLoc
    }
  }
}
return tNewLoc
