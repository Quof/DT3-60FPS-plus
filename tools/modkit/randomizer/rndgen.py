"""
Builds the DT3+ Randomizer mod from the project: every collectible location in the game's rooms, the item pool, what
each location needs (the room logic's) and the endgame world state, written as the mod's data scripts, with the
hand-written mod files in mod\\.

usage: python rndgen.py <output folder>
       python rndgen.py --world-from <save.dts>      (re-reads world.txt's values from a finished save)

Inputs next to this file:
  mod\\        the mod's own code (mod.ini, hooks, scripts, objects), copied to the output as is
  world.txt   the endgame world state: save file keys (loadSaveData) and their values, from a 100% save
  roomlogic\\  what each location needs, worked out from the rooms: each room's logic (rooms\\), the connections and
              the hand-made changes (overrides.txt), joined by solve.py (roomlogic\\README.txt)
  logic.txt   last-resort changes to single locations (see README.txt)
  tracker_names.txt  the Check Tracker's tabs and screens (tracker.py)
Outputs:
  <output>\\scripts\\rndData.gml    locations, items and shops
  <output>\\scripts\\rndWorld.gml   the world state
  <output>\\tracker\\data.js        the trackers' data and pictures (tracker.py; the pages are mod\\tracker's)
  locations.csv (next to this file) every location with its logic, for checking and for logic.txt
"""
import os, re, sys, csv, shutil, collections

HERE = os.path.dirname(os.path.abspath(__file__))
PROJ = os.path.normpath(os.path.join(HERE, "..", "..", ".."))
ROOMS = os.path.join(PROJ, "rooms")
sys.path.insert(0, os.path.join(HERE, "roomlogic"))
import solve   # (the room logic's: the Access Gates' rooms and their Program Chips, solve.GATE_PREFIX and CHIP_KEY)

# location types: (code, object, label). Their vanilla item is worked out per location (chests: money or equipment)
LTYPES = [
    (1, "oHeartPiece", "Heart Piece"), (2, "oMoneyChest", "Treasure Chest"), (3, "oArrowQuiver", "Arrow Quiver"),
    (4, "oHeartEnergy", "Heart Energy"), (5, "oMissilePack", "Missile Tank"), (6, "oGamePower", "Game Power"),
    (7, "oAirUpgrade", "Air Upgrade"), (8, "oWalletBoost", "Internetz Mod"), (9, "oWeaponLevelUpgrade", "Weapon Upgrade"),
    (10, "oAPBoost", "Skill Point"), (11, "oLinkBombUpgrade", "Bomb Upgrade"), (12, "oMorphBombUpgrade", "Morph Bomb Upgrade"),
    (13, "oDoorKey", "Key"), (14, "oHeartContainer", "Heart Container"), (15, "oItemFinderPickup", "Item Finder"),
    (16, "oMMBoostedCharge", "X Charge Capsule"), (17, "oMetPick_SpringBall", "Spring Ball")]
LT_BY_OBJ = {o: c for c, o, l in LTYPES}
LT_LABEL = {c: l for c, o, l in LTYPES}
LT_LABEL[18] = "Instrument"
# the story's ability pickups (oStoryObject: what a scene gave, there till the story's past it, so not in the endgame
# world): each a location of type 19 where it was placed. Its number (its own, kept: saves and the Archipelago world
# know a location by it), its room, the room editor's id and what it gave. roomlogic\roomdata.py makes each a place as
# it was placed, and the mod a pickup there (oRndStory: the roomStart hook). Four of them hold the Nightmare abilities
# (NIGHTMARE: rndGenerate). Not the old Forest Palace's (rLink2_PalaceB_5: the level the new one, rLink2_PalaceF,
# replaced), nor the Varia Suit's (rSamus5_Lv2_N: at the top of a lava shaft the endgame world has no way up)
STORY_TYPE = 19
LT_LABEL[STORY_TYPE] = "Story Item"
STORY_SPOTS = [
    (1, "rBelmont3_2B", "002D1A76", "Belmont's Dagger"), (2, "rBelmont3_3B", "003C5011", "Holy Water"),
    (3, "rBelmont3_4H", "0019F743", "Dash Boots"), (4, "rGame6_CoMB", "00297681", "Double Jump"),
    (5, "rLink2_PalaceA_6", "0025908E", "Magic Bow"), (6, "rLink2_PalaceF_9", "003D2881", "Link's Bombs"),
    (7, "rSamus5_Lv1_C", "00088447", "High Jump Boots"), (8, "rSamus5_Lv1_D", "000D09EE", "Morph Ball"),
    (9, "rSamus5_Lv1_J", "00219ECC", "Charge Beam"), (10, "rSamus5_Lv1_Y", "000B71B8", "Gravity Suit"),
    (11, "rSamus5_Lv2_F", "000BBBE2", "Dash"), (12, "rSamus5_Lv2_K", "0032E193", "Missiles"),
    (13, "rSamus5_Lv2_S", "0007C228", "Diffusion Missiles"), (14, "rSamus5_Lv3_E", "000BDDFE", "Spazer Beam"),
    (15, "rSamus5_Lv3_H", "002A0F4E", "Bombs"), (16, "rSamus5_Lv3_K", "000D4A83", "Air Dash"),
    (17, "rSamus5_Lv3_M", "00364E7A", "Super High Jump Boots")]
STORY_DEFAULT_SPRITE = "sHiJumpBoots"   # (oStoryObject's own, for one whose creation code doesn't set its look)
# the Nightmare Mode's own abilities, items in a Randomizer game (kind NM, the parameter this list's place; the mod's
# rndOwn 13-16): Link's Sword Wave, Mega Man's charge shots stored, Belmont's Dagger Spam, Samus's Power Bomb. Each is
# at one of the story's ability pickups (STORY_SPOTS: rndGenerate, the Archipelago world's pre_fill). The game's code
# for them asks global.bNightmareMode: the mod's copies of it ask the item too (SCRIPT_PATCHES, GAME_PATCHES)
NIGHTMARE = ["Sword Wave", "Charge Storage", "Dagger Spam", "Power Bomb"]
# Gate 4's stages go one way: each room's exit at its end leads into the next room, and nothing leads back. In a
# Randomizer game each of those rooms gets a way back, an exit at its edge where the player comes in (as the forward
# ones are: oExit, walked into, its arrow shown), leading to the end of the room before, beside that room's own exit and
# on its floor: (the room, where its way back is placed, the room it leads to, where the player comes out there). With
# the forward exit it makes a door Entrance Rando can shuffle (in Chaos: a stage's rooms are one area). The roomStart
# hook makes them (rndMMBack*), the room logic has them (roomlogic\roomdata.py) and the build checks each one against
# the game's own forward exit (mm_back_check). Not the boss rooms (Maoh's, the Mavericks', Bospider's, Bit & Byte's,
# Sigma's): the way into a boss room stays one way, as its fight is
MM_BACK_EXITS = [
    ("rMega4_IntroB", 0, 224, "rMega4_IntroA", 4056, 256), ("rMega4_IntroC", 0, 2800, "rMega4_IntroB", 3752, 288),
    ("rMega4_IntroD", 0, 272, "rMega4_IntroC", 440, 240),
    ("rMega4_OstrichB", 0, 208, "rMega4_OstrichA", 2968, 336), ("rMega4_OstrichC", 0, 320, "rMega4_OstrichB", 8328, 288),
    ("rMega4_OstrichD", 0, 240, "rMega4_OstrichC", 4056, 336),
    ("rMega4_StormB", 0, 384, "rMega4_StormA", 3640, 224), ("rMega4_StormC", 0, 256, "rMega4_StormB", 3896, 416),
    ("rMega4_StormD", 0, 384, "rMega4_StormC", 6104, 288),
    ("rMega4_ToxicJungleB", 0, 256, "rMega4_ToxicJungleA", 6104, 112),
    ("rMega4_ToxicJungleC", 0, 256, "rMega4_ToxicJungleB", 4056, 304),
    ("rMega4_ToxicJungleD", 0, 560, "rMega4_ToxicJungleC", 8168, 224),
    ("rMega4_SigmaA2", 0, 592, "rMega4_SigmaA1", 11480, 400), ("rMega4_SigmaA3", 0, 2976, "rMega4_SigmaA2", 3016, 160),
    ("rMega4_SigmaA4", 0, 272, "rMega4_SigmaA3", 440, 192),
    ("rMega4_SigmaB2", 0, 256, "rMega4_SigmaB1", 3928, 192), ("rMega4_SigmaB3", 0, 256, "rMega4_SigmaB2", 3288, 128),
    ("rMega4_SigmaB4", 0, 2976, "rMega4_SigmaB3", 440, 288), ("rMega4_SigmaB5", 0, 256, "rMega4_SigmaB4", 632, 192),
    ("rMega4_SigmaB6", 0, 416, "rMega4_SigmaB5", 440, 288), ("rMega4_SigmaB7", 0, 256, "rMega4_SigmaB6", 1880, 192),
    ("rMega4_SigmaC2", 0, 352, "rMega4_SigmaC1", 2776, 272), ("rMega4_SigmaC3", 0, 2016, "rMega4_SigmaC2", 3800, 384),
    ("rMega4_SigmaC4", 0, 256, "rMega4_SigmaC3", 440, 160)]
# the pause menu's Teleport in a randomizer game (rndTeleport): in a gate (an Access Gate's or a Nightmare Gate's area,
# the game's global.location), out of it, where its way out leads (its first room's exit back to its portal's room) as
# Entrance Rando has it: Gate Swap's shuffle has it lead to the portal the gate is come into by, as walking out of it
# does; outside the gates, where the game started (Central City - North). With Entrance Rando Chaos, every door
# shuffled, always where the game started. [(the gate's area, its way out: room, x, y)], checked against the
# connections (where the game has it lead) when the mod's built
TELEPORT_GATES = [(7, "rMario1_1", 88, 224), (10, "rLink2_HP", 368, 192), (15, "rBelmont3_Gate", 160, 224),
                  (29, "rMega4_Gate", 80, 208), (49, "rSamus5_Gate", 152, 208), (58, "rGame6_Gate", 288, 192),
                  (101, "rExtGateA_1", 40, 256), (102, "rExtGateB_1", 88, 384), (103, "rExtGateC_1", 8, 272),
                  (104, "rExtGateD_1", 48, 272), (105, "rExtGateE_1", 64, 256), (106, "rExtGateF_1", 64, 256),
                  (107, "rExtGateG_1", 48, 224)]
# the rooms the story has the player go through as Jeremy's mech: the Distortion's (Hexor's, at its end), which a scene
# before them makes the player (the Wasteland's first room, whose code makes them it from then on: rCh21_WastelandA), the
# Wasteland's, and Warship Z's after the Warmaster (his room's scene makes the player it: rWarshipZ_I's code does too).
# In a Randomizer game the roomStart hook makes the player it as they come into one, however they come in (Entrance
# Rando's doors, the Randomizer's warps), and leaving them for another room makes them their own character again
# (rndCharRoom). Not the Warmaster's own rooms (rWarshipZ_E1, E2: char_rooms below). Entrance Rando leaves the doors
# between the Distortion's rooms as they are (roomlogic\er.py's INSIDE_LEFT_OUT: the logic's ways through them are Jerry's
# and Claire's), its gate's door shuffled, so it's a dead end with no places behind it
MECH_ROOMS = ["rDistortionA", "rDistortionB", "rDistortionC", "rDistortionD", "rDistortionE", "rDistortionF",
              "rCh21_WastelandA", "rCh21_WastelandB", "rWarshipZ_F", "rWarshipZ_G", "rWarshipZ_H", "rWarshipZ_I"]
# location types that stay the game's own, not locations: the Item Finder (its pickup gives it, as in the game; the
# mod's oIdentifier makes Chao's alert tell the locations' items apart)
KEEP_TYPES = {15}

# item kinds (the numbers the mod's scripts use)
IK = dict(HP=1, MONEY=2, EQUIP=3, AQ=4, HE=5, MP=6, GP=7, AU=8, WB=9, WL=10, AP=11, LB=12, MB=13, KEY=14, HC=15, XF=16,
          XC=17, XS=18, JUMP=19, GDASH=20, ADASH=21, DJUMP=22, HIJUMP=23, SET=24, VARIA=25, INSTR=26, CHIP=27, NM=28,
          SNARE=29, MONEYX=2)
# (MONEYX: Internetz too, the story's ability pickups' (locations_items), which a Program Chip never takes the place of:
# chip_slots takes MONEY's)
# the Program Chips (the new game's option Chip Randomizer): chip N opens Access Gate N's portal, and the Nightmare Gate
# portal beside it, wherever Entrance Rando has them lead (roomlogic\overrides.txt's need lines for the portals; the
# mod's portals can't be used without it: portal_chips, rndPortalChip). Their item: kind CHIP, the gate's number; the
# logic's number KEY_BASE+CHIP_KEY+N. With the option on they're among the items, in the place of the six smallest
# Internetz chests (chip_slots); off, the player has them all from the start and those chests hold their Internetz
CHIP_GATES = sorted(solve.GATE_PREFIX)
# the trap items (the new game's option Traps, the Archipelago world's option traps; not the enemy traps, traps.py):
# items that look like a Weapon Upgrade (or are in a chest, which sparkles as for any item but Internetz) and spring a
# trap on the player instead (the mod's rndSnareSpring). Their item: kind SNARE, the trap's number (its place in
# SNARE_TYPES, 1 on). With the option on, SNARE_EACH of each trap are items, in the place of as many Internetz chests
# (snare_slots: the smallest ones after the Program Chips', chip_slots), each trap in turn; off, those chests hold their
# Internetz. The option is how long the timed ones last (2, 5 or 10 minutes). Darkness: Dark Mode's darkness in every
# room; Rocketeer: a CHAOS Rocketeer now and in every room come into; Teleport: back to one of the ways into a room the
# player has come in by in the run, at random; Achilles: Achilles Mode (any hit kills); Wind Orb: the Green Warmaster's
# seeker orb (his charged supermove), which can't be destroyed, after the player now and in every room come into
SNARE_TYPES = ["Darkness", "Rocketeer", "Teleport", "Achilles", "Wind Orb"]
SNARE_EACH = 6
# (the trap items of the builds before the Wind Orb, 5% of the items with the four traps before it in turn, which their
# saves have: snare_slots_old)
SNARE_TYPES_OLD = 4
SNARE_SHARE_OLD = 0.05
# the Nightmare Gates' instruments: each gate's reward (location type 18, its number the gate's, 1-8: A-H), given right
# after its boss is beaten (the mod's oRndReward; Gate H's in the mod's room for it, rRndGateH). Their item: the
# instrument (kind INSTR, the instrument's number, eGateProg's place). They need everything (a fight's reward: no
# ability or key there); with the new game's option Instrument Randomization the instruments are in the pool and these
# places hold any item, else each holds its own instrument
INSTR_TYPE = 18
GATE_ROOMS = ["rExtGateA_6", "rExtGateB_6", "rExtGateC_5", "rExtGateD_6", "rExtGateE_5", "rExtGateF_6", "rExtGateG_5", "rRndGateH"]
LT_ITEM = {1: "HP", 3: "AQ", 4: "HE", 5: "MP", 6: "GP", 7: "AU", 8: "WB", 10: "AP", 11: "LB", 12: "MB", 13: "KEY",
           14: "HC", 15: "XF", 16: "XC", 17: "XS"}

# progression: the items the logic counts (their index: the mod's rndItemProg, and the logic's numbers in rndData; a
# key is 20 + its door's objectNum). jump: had from the start (the new game gives it). mario: the Mario Ability Set
# (hasAbilToken[0]: jumping on Mario enemies, hitting blocks from below). varia: the Varia Suit (Gate 5's lava harmless:
# the mod's oMetLava). cursed: the Trial Master's three cursed equipment pieces (equipment 10-12), which the trials need on.
# instr: the instruments (only with Instrument Randomization: else each is at its gate's reward). air: the Air Upgrades
# (a second of air each underwater), which the underwater rooms need some of (roomlogic\overrides.txt's also lines);
# placed before the rest, at random, as other items are (rndGenerate), the logic counting the ones at places it's got to
PROG = ["jump", "gdash", "adash", "djump", "hijump", "mario", "link", "belmont", "megaman", "samus", "gamej", "gamec",
        "varia", "cursed", "instr", "air", "keys"]
KEY_BASE = 20
VARIA_IX, CURSED_IX, INSTR_IX, AIR_IX = 12, 13, 14, 15
CURSED = (10, 11, 12)
# how many of each there are. The ability sets' items are progressive: each one is the set's next level (hasAbilToken 2,
# 3...): Link and Belmont 3 (their three weapons; nothing uses a level 5), Mega Man 4 (the Strike Chain at 5), Samus 7
# (Arm Cannon, Morph Ball, Charge Beam, Missiles, Spazer Beam, Bombs, Diffusion Missile), the Gate 6 sets 2
PMAX = [0, 1, 1, 1, 2, 1, 3, 3, 4, 7, 2, 2, 1, 3, 8, 10, 17]
# the abilities that aren't at any location in an endgame world (the story gave them): added to the pool (not jumping:
# a new game starts with it)
EXTRA = [("GDASH", 0), ("ADASH", 0), ("DJUMP", 0), ("HIJUMP", 0), ("HIJUMP", 0)] + \
        [("SET", s) for s, n in enumerate(PMAX[5:12]) for _ in range(n)] + [("VARIA", 0)]
# the room logic's names for the progression items
LOGIC_NAMES = {"gdash": 1, "adash": 2, "djump": 3, "hijump": 4, "mario": 5, "link": 6, "belmont": 7, "megaman": 8,
               "samus": 9, "gamej": 10, "gamec": 11, "varia": VARIA_IX, "cursed": CURSED_IX, "instr": INSTR_IX,
               "air": AIR_IX}
# a location that needs everything (the logic doesn't reach it, or it's a fight's or a trial's reward): it gets no
# ability or key
EVERYTHING = None
# places whose pickup only shows once something optional is done (their creation code checks the global): tower
# defense's rewards (rCCity_NorthA): need everything
COND_GLOBALS = ("gameOptTowerDef",)
# places a Trial Master trial gives (the pickup's creation code hides it till the trial's done; Central City South's
# heart container, which the mod makes, comes with the 7th): the trials need the three cursed equipment pieces on, so
# these places need them (roomlogic\overrides.txt: cursed 3; the 7th trial, five of the six others done too)
COND_TRIAL = "trialMasterQuest"
TRIAL_HC = 7


# the pickups whose events get the randomizer's part ahead of the game's own (their location type), and what that part is
SIMPLE_PICKUPS = {"oHeartPiece": 1, "oArrowQuiver": 3, "oHeartEnergy": 4, "oMissilePack": 5, "oGamePower": 6,
                  "oAirUpgrade": 7, "oWalletBoost": 8, "oWeaponLevelUpgrade": 9, "oAPBoost": 10,
                  "oLinkBombUpgrade": 11, "oMorphBombUpgrade": 12, "oHeartContainer": 14, "oDoorKey": 13}
ALARM_PREFIX = ("//Randomizer: in a randomizer game this is a location: it shows its item (rndPickupSetup), or goes if that's\n"
                "//been taken. Otherwise as the game's own\n"
                "if global.rndActive=1\n{\n  rndPickupSetup(%d)\n%s  exit\n}\n")
ALARM_EXTRA = {"oHeartContainer": "  if rndLoc>=0 {if !rndHCOpen(objectNum) {instance_destroy()}} //its boss beaten first\n",
               "oDoorKey": "  indexCheck=\"0\"\n"}
COLL_PREFIX = ("//Randomizer: in a randomizer game, the location's item. Otherwise as the game's own\n"
               "if global.rndActive=1\n{\n  if variable_local_exists(\"rndLoc\") {if rndLoc>=0 {rndCollect(rndLoc);%s instance_destroy()}}\n"
               "  exit\n}\n")
COLL_EXTRA = {"oDoorKey": " indexCheck=\"1\";"}
# other events of the game's objects the mod has its own copy of: the game's own (read when the mod's built), with one
# line changed (the original kept commented above it). The randomizer's boss fights have the boss gallery's flag on (so a
# beaten boss goes to the gallery, where rndBossEnd takes over) without its timer. Gate 5's lava hurts till the story
# gives the Varia Suit (gameProgress 2850); in a randomizer game, till the Varia Suit item's found (rndOwn[12])
GAME_PATCHES = [
    # Gate 4's stage map: a stage's "Items Obtained" counts the game's own pickups' flags, which in a Randomizer game are
    # what the player has been given, not what they've taken there: the stage's locations taken instead (rndMMStageText)
    ("oEvCh8Map", "Step_0",
     "  updateCheck=0\n",
     "  if global.rndActive=1 {text_Full=rndMMStageText(cursorPos,text_Full)} //Randomizer change (added): its locations taken\n"
     "  updateCheck=0\n"),
    ("oHUD", "Draw_0",
     "    if global.bBossGallery=1 and room!=rBossGallery //Display timer in boss gallery\n",
     "    //if global.bBossGallery=1 and room!=rBossGallery //Display timer in boss gallery\n"
     "    if global.bBossGallery=1 and room!=rBossGallery and global.rndFight<0 //Randomizer change: not in a randomizer boss fight\n"),
    # Cackletta: only the Mario Ability Set's stomp hurts her (a life of her four each, her own Collision_oPlayer1), as
    # the logic has it (roomlogic\bosses.txt); in a Randomizer game, where the player has other weapons there, a weapon's
    # hit takes more than her four lives at once and leaves her fight stuck: every damage type does nothing to her
    ("oCackletta", "Create_0",
     "stunResist=50\naffiliation=1\n",
     "stunResist=50\naffiliation=1\n"
     "if global.rndActive=1 {for(i=0;i<6;i+=1) {resType[i]=1}} //Randomizer change (added): no damage type hurts her, only the Mario Ability Set's stomp does\n"),
    # the dash meter: shown with the air dash alone too, which takes the same dash energy (a randomizer game's abilities
    # come in any order; the story gives the dash first)
    ("oHUD", "Draw_0",
     "      if global.hasShoes[2]=2\n",
     "      //if global.hasShoes[2]=2\n"
     "      if global.hasShoes[2]=2 or (global.rndActive=1 and global.hasShoes[3]=2) //Randomizer change: with the air dash alone too (it takes the same dash energy)\n"),
    ("oMetLava", "Collision_oPlayer1",
     "if global.gameProgress<=2850 {redDmgHit(0)}\n",
     "//if global.gameProgress<=2850 {redDmgHit(0)}\n"
     "if global.gameProgress<=2850 or (global.rndActive=1 and global.rndOwn[12]=0) {redDmgHit(0)} //Randomizer change: in a randomizer game, till the Varia Suit's found\n"),
    # the pause menu's Teleport: in a randomizer game it works anywhere but in a boss fight, and goes out of the gate the
    # player is in, then, outside the gates, to where the game started (Central City - North, at the door from Greatest
    # Stretch): rndTeleport, TELEPORT_GATES
    ("oPauseMenu", "Step_0",
     "    if global.mapTeleport=0 or global.bBossGallery=1 //Can't use\n",
     "    //if global.mapTeleport=0 or global.bBossGallery=1 //Can't use\n"
     "    if (global.mapTeleport=0 and global.rndActive=0) or global.bBossGallery=1 //Randomizer change: in a randomizer game, anywhere but in a boss fight\n"),
    ("oPauseMenu", "Step_0",
     "      if global.mapTeleport=1 //Gate A\n",
     "      if global.rndActive=1 //Randomizer change (added): a randomizer game's teleport goes out of the gate the player is in, else to where the game started (rndTeleport)\n"
     "      {\n"
     "        rndTeleport()\n"
     "        exit;\n"
     "      }\n"
     "      //if global.mapTeleport=1 //Gate A\n"
     "      else if global.mapTeleport=1 //Gate A (Randomizer change: after the randomizer's)\n"),
    ("oPauseMenu", "Draw_0",
     "  if global.mapTeleport=0 or global.bBossGallery=1 {draw_sprite(sPauseM_NoTeleport,0,mainMenuX+17,mainMenuY+161)}\n",
     "  //if global.mapTeleport=0 or global.bBossGallery=1 {draw_sprite(sPauseM_NoTeleport,0,mainMenuX+17,mainMenuY+161)}\n"
     "  if (global.mapTeleport=0 and global.rndActive=0) or global.bBossGallery=1 {draw_sprite(sPauseM_NoTeleport,0,mainMenuX+17,mainMenuY+161)} //Randomizer change: usable anywhere but in a boss fight\n"),
    ("oPauseMenu", "Draw_0",
     "      if global.mapTeleport=0 //Not usable\n",
     "      if global.rndActive=1 {menuInfoText=rndTeleportText()} //Randomizer change (added): where a randomizer game's teleport goes\n"
     "      //if global.mapTeleport=0 //Not usable\n"
     "      else if global.mapTeleport=0 //Not usable (Randomizer change: after the randomizer's)\n"),
    # the game's checks of one place's item having been taken (its place in the game's string for its kind), which a
    # randomizer game's items fill in their own order (rndMarkNext): there, whether the place is taken (rndPlaceGot).
    # Farreaches' ring trials (each one's Skill Point behind its barrier, objectNum itemIndex: the trial and its barrier
    # go once it's taken); the walls Farreaches' event takes away once the place past them is taken (Anticipate's way
    # to Perception: Perception's Skill Point; Contemplate's: its Heart Piece; Envisage's way to Foresight: Foresight's
    # Skill Point); Toxic Jungle B's ambush, there till its Missile Tank's taken
    ("oCh9RingManager", "Alarm_0",
     "indexCheck=string_char_at(global.apBoost,itemIndex)\n",
     "//indexCheck=string_char_at(global.apBoost,itemIndex)\n"
     "indexCheck=rndPlaceGot(global.apBoost,10,itemIndex) //Randomizer change: in a randomizer game, whether the Skill Point's place behind the rings is taken\n"),
    ("oEvCh9MainA", "Create_0",
     "  indexCheck=string_char_at(global.apBoost,29)\n",
     "  //indexCheck=string_char_at(global.apBoost,29)\n"
     "  indexCheck=rndPlaceGot(global.apBoost,10,29) //Randomizer change: in a randomizer game, whether rMain_33's Skill Point's place is taken\n"),
    ("oEvCh9MainA", "Create_0",
     "  indexCheck=string_char_at(global.heartPiece,23)\n",
     "  //indexCheck=string_char_at(global.heartPiece,23)\n"
     "  indexCheck=rndPlaceGot(global.heartPiece,1,23) //Randomizer change: in a randomizer game, whether the Heart Piece's place is taken\n"),
    ("oEvCh9MainA", "Create_0",
     "  indexCheck=string_char_at(global.apBoost,36)\n",
     "  //indexCheck=string_char_at(global.apBoost,36)\n"
     "  indexCheck=rndPlaceGot(global.apBoost,10,36) //Randomizer change: in a randomizer game, whether rMain_37's Skill Point's place is taken\n"),
    ("oEvCh8MainA", "Create_0",
     "  indexCheck=string_char_at(global.missilePack,6)\n",
     "  //indexCheck=string_char_at(global.missilePack,6)\n"
     "  indexCheck=rndPlaceGot(global.missilePack,5,6) //Randomizer change: in a randomizer game, whether the Missile Tank's place is taken\n"),
    # Gate 4's beam-downs: a Mega Man stage's (the stage intro sets global.tempAction[0] 1-3 and goes to the stage's
    # first room) and a Sigma stage's (the stage map sets 4-6 before the story's end). The game ran one wherever
    # tempAction was 1 or more, with its landing height (playerSpotY) set only for those values, so another event's left
    # over in it (the desert's directions counted in oExit, the Vault creatures' hits) crashed the room it came into:
    # "Unknown variable playerSpotY". Only for its own value in its own room now
    ("oEvCh8MainA", "Step_0",
     "if global.tempAction[0]>=1\n",
     "//if global.tempAction[0]>=1\n"
     "if (global.tempAction[0]=1 and room=rMega4_StormA) or (global.tempAction[0]=2 and room=rMega4_OstrichA) or (global.tempAction[0]=3 and room=rMega4_ToxicJungleA) //Randomizer change: only the stage intro's beam-down (playerSpotY is set for it), not another event's tempAction left over where a door or a warp brings the player in\n"),
    ("oEvCh8MainB", "Step_0",
     "if global.tempAction[0]>=1\n",
     "//if global.tempAction[0]>=1\n"
     "if (global.tempAction[0]=4 and room=rMega4_SigmaA1) or (global.tempAction[0]=5 and room=rMega4_SigmaB1) or (global.tempAction[0]=6 and room=rMega4_SigmaC1) //Randomizer change: only the stage map's beam-down (playerSpotY is set for it), not another event's tempAction left over where a door or a warp brings the player in\n"),
] + [
    # the Nightmare abilities' meters (NIGHTMARE): shown with each ability's item too (rndNM)
    ("oHUD", "Draw_0",
     "          if global.bNightmareMode=1 //Nightmare Mode - Display %s meter\n" % meter,
     "          //if global.bNightmareMode=1 //Nightmare Mode - Display %s meter\n"
     "          if global.bNightmareMode=1 or rndNM(%d) //Nightmare Mode - Display %s meter (Randomizer change: or with its item)\n"
     % (meter, k, meter))
    for k, meter in enumerate(["Sword Wave", "stored charge shots", "Dagger Spam", "Power Bomb"])]

# the game's scripts a mod can replace that the Randomizer changes: the mod's version of each is the game's own (written
# into the build whole, without its line that hands it to a mod's) with these lines changed. First the Nightmare
# abilities (NIGHTMARE): a Nightmare Mode check of an ability asks its item too (rndNM: Link's Sword Wave 0, Mega Man's
# charge shots stored 1, Belmont's Dagger Spam 2, Samus's Power Bomb 3)
SCRIPT_PATCHES = [
    ("playerTechUse",
     "  if global.bNightmareMode=1 and swordWaveCheck=0 and life=maxLife //Nightmare Only - Sword wave if at full health (Hold Down)\n",
     "  //if global.bNightmareMode=1 and swordWaveCheck=0 and life=maxLife //Nightmare Only - Sword wave if at full health (Hold Down)\n"
     "  if (global.bNightmareMode=1 or rndNM(0)) and swordWaveCheck=0 and life=maxLife //Nightmare Only - Sword wave if at full health (Hold Down) (Randomizer change: or with its item)\n"),
    ("playerTechStart",
     "            if global.bNightmareMode=0\n",
     "            //if global.bNightmareMode=0\n"
     "            if global.bNightmareMode=0 and !rndNM(1) //Randomizer change: with its item, Mega Man's charge shots are stored as in Nightmare Mode\n"),
    ("playerTechUse",
     "    if global.bNightmareMode=0\n",
     "    //if global.bNightmareMode=0\n"
     "    if global.bNightmareMode=0 and !rndNM(1) //Randomizer change: with its item, Mega Man's stored charge shots go as in Nightmare Mode\n"),
    ("playerTechStart",
     "    if global.bNightmareMode=1 //Nightmare Mode Only - Dagger Spam (Down - Down - Forward - Forward)\n",
     "    //if global.bNightmareMode=1 //Nightmare Mode Only - Dagger Spam (Down - Down - Forward - Forward)\n"
     "    if global.bNightmareMode=1 or rndNM(2) //Nightmare Mode Only - Dagger Spam (Down - Down - Forward - Forward) (Randomizer change: or with its item)\n"),
    ("playerTechUse",
     "  if global.bNightmareMode=0 {global.hudBelmont_WeaponEn[0]-=round((8-global.skillTree[3])*tMysticDagger)}\n",
     "  //if global.bNightmareMode=0 {global.hudBelmont_WeaponEn[0]-=round((8-global.skillTree[3])*tMysticDagger)}\n"
     "  if global.bNightmareMode=0 and !rndNM(2) {global.hudBelmont_WeaponEn[0]-=round((8-global.skillTree[3])*tMysticDagger)} //Randomizer change: with its item, the Dagger Spam's daggers cost as in Nightmare Mode\n"),
    ("playerTechStart",
     "          if global.bNightmareMode=1 //Nightmare Mode Only - Power Bomb (Charge)\n",
     "          //if global.bNightmareMode=1 //Nightmare Mode Only - Power Bomb (Charge)\n"
     "          if global.bNightmareMode=1 or rndNM(3) //Nightmare Mode Only - Power Bomb (Charge) (Randomizer change: or with its item)\n"),
] + [
    # the RPG level's buff: the four base sets' damage against Gate 6's enemies and bosses, 1x at level 1 up to 2x at
    # level 64 (rndG6Mult; Gate 6's own sets, whose attacks grow with the level already, as they are)
    ("takeDamage",
     "    initialDamage=tObjHit.atkPower //Initial damage\n"
     "    totalDamage=initialDamage\n",
     "    initialDamage=tObjHit.atkPower //Initial damage\n"
     "    totalDamage=initialDamage\n"
     "    totalDamage*=rndG6Mult(tObjHit) //Randomizer change (added): the RPG level's buff to the base sets against Gate 6's enemies and bosses\n"),
    # an Achilles Trap (the option Traps: rndSnareSpring) on: any hit kills, as in Achilles Mode
    ("takeDamage",
     "      if global.bOneHitKillMode=1 or global.omenActive=1 {totalDamage=irandom_range(10000,99999)} //one hit kill if playing on one hit kill mode //dark omen change: and with the New Dark Omen on (scrOmenState)\n",
     "      //if global.bOneHitKillMode=1 or global.omenActive=1 {totalDamage=irandom_range(10000,99999)} //one hit kill if playing on one hit kill mode //dark omen change: and with the New Dark Omen on (scrOmenState)\n"
     "      if global.bOneHitKillMode=1 or global.omenActive=1 or (global.rndActive=1 and global.rndSnareT[4]>0) {totalDamage=irandom_range(10000,99999)} //one hit kill if playing on one hit kill mode //dark omen change: and with the New Dark Omen on (scrOmenState) //Randomizer change: and with an Achilles Trap on (rndSnareSpring)\n"),
] + [
    # swapping between Jerry and Claire in Nightmare Gate F (location 106): the gate's own jump, its 60fps corrections
    # and its ice running stay, as each of its rooms' code sets them (charSwitcher gives the standard ones: the game
    # forces Claire there; a Randomizer game, where swapping always works and the player can come in as either, kept
    # them only till the first swap in a room)
    ("charSwitcher",
     "  oPlayer1.frictionDuckingX=%s\n" % fd,
     "  oPlayer1.frictionDuckingX=%s\n"
     "  if global.rndActive=1 and global.location=106 {oPlayer1.initialJumpAcc=-9.4; oPlayer1.jumpTimeTotal=35; oPlayer1.jumpBodge60=0.99; oPlayer1.jumpGravComp60=0; oPlayer1.doubleJumpBodge60=0.99; oPlayer1.runAcc=0.8} //Randomizer change (added): Nightmare Gate F's own jump and ice running, as its rooms' code gives them\n" % fd)
    for fd in ("0.87", "0.9")]

# bosses: the boss gallery's doors give each boss's type (oBossGalleryDoor's user event 0 sets its fight up), room and
# where the player starts it. One boss a room (its first type: Death, Sigma, Ridley and Decimator have a second). The
# Nightmare Gates' bosses (rooms rExtGate*) come after the others (the mod's boss numbers of the others stay as they
# were for saves); beaten, their gate counts as beaten (eGateProg 8) and its reward is there (rndBossEnd, oRndReward).
# Left to the game: the Abomination (type 58, the instrument quest's), the Warmaster EX room (type 65: the game's own
# Fedex fight), the Ridley tunnel chase (37) and the Leviathan road (41), which aren't fights a room makes (the tunnel
# chase is one of Ridley's fights: BOSS_CHAIN)
BOSS_SKIP = {37, 41, 58, 65}
# a boss whose fight is several in a row, as the story has them: after the boss's own fight, these (gallery types), each
# straight after the last one won (rndBossNextLink). Only the last one won beats the boss's place; a fight of them given
# up, the next try starts again from the first. Ridley: Ridley, Ridley (Lava) in the same room, then the tunnel chase.
# Boss Rando moves the fights together, and what they take is the boss's (roomlogic\bosses.txt: Ridley's covers all
# three)
BOSS_CHAIN = {35: (36, 37)}
BOSS_FINAL = 60          # the Warmaster: the win (at the end of the CHAOS Warship, once the Abomination is beaten)
# the bosses Boss Rando leaves in their own places: the Warmaster; The Executive, whose fight gives both characters
# Gate 6's sets, as the game's own does (the mod's rndExecFight), so it needs nothing (roomlogic\bosses.txt); and Hexor,
# an optional fight at the Distortion's dead end (in the gallery's way his fight ends with his first form)
BOSS_FIXED = {BOSS_FINAL, 63, 64}
# the boss list's types in the order saves made before they kept it (the "bosstypes" key) have their bosses in: the
# load hook reads their beaten bosses by it
BOSS_TYPES_OLD = "1,2,4,5,6,7,8,10,11,12,13,14,17,18,19,20,21,22,23,24,27,28,30,31,32,33,34,35,39,40,42,43,44,45,46,48," \
                 "49,50,51,52,53,54,55,56,59,60,61,62,63,64,3,9,16,26,29,38,47"
HC_BOSS = {1: 2, 2: 8, 3: 14, 4: 24, 5: 35, 6: 46}  # heart container (objectNum): the boss type after whose fight the game gives it
# the AP the story gives after each boss's fight (its awardBossAP: oEvCh*MainA, oEvExGates, oEvDCS), by type; the
# Randomizer's fights, the gallery's way, don't run those scenes, so the mod gives it (rndBossAPAward), and a level's
# worth on top. Hex (Vault)'s comes in the room after his (rVault_14), Ridley's in the vent shaft after his; the
# Warship's and Chapter 21's bosses (59-64) get none from the story
BOSS_AP = {1: 100, 2: 250, 3: 700, 4: 250, 5: 500, 6: 600, 7: 600, 8: 800, 9: 1500, 10: 900, 11: 1100, 12: 1500,
           13: 1600, 14: 2000, 16: 2700, 17: 2100, 18: 2200, 19: 2300, 20: 2300, 21: 2300, 22: 2400, 23: 2400, 24: 2700,
           26: 4300, 27: 3100, 28: 3200, 29: 5000, 30: 4100, 31: 4500, 32: 4500, 33: 4500, 34: 5000, 35: 6000, 38: 8000,
           39: 5000, 40: 6500, 42: 5500, 43: 5000, 44: 7000, 45: 8500, 46: 8500, 47: 13500, 48: 8500, 49: 10000,
           50: 11000, 51: 9500, 52: 10000, 53: 8000, 54: 8000, 55: 12000, 56: 17500}
# bosses whose rooms the story's exit no longer goes to in an endgame world (it goes on past them): going through that
# exit (from, to) is the way into the fight, and the player goes on to where it leads after it
BOSS_VIA = {35: ("rSamus5_Lv4_N", "rSamus5_Lv4_RidleyTunnel"), 61: ("rPttT_06", "rPttT_08")}
# a via exit whose way on isn't a room to go on into, and where the player comes back to after its fight instead (room,
# x, y). Ridley's hatch leads into the tunnel (the endgame world's exit goes there), where the story's chase and escape
# would start over: back in rSamus5_Lv4_N, where the story brings the player up from his arena. (The endgame world
# seals the hatch: the mod opens it while his place isn't beaten, the roomStart hook)
BOSS_VIA_BACK = {35: ("rSamus5_Lv4_N", 144, 272)}


def vanilla_event(obj, ev):
    """the game's own code for an object's event (objects/<obj>.gml), without the action header"""
    t = read(os.path.join(PROJ, "objects", obj + ".gml"))
    parts = re.split(r"^#define (\w+)\s*$", t, flags=re.M)
    for i in range(1, len(parts), 2):
        if parts[i] == ev:
            body = parts[i + 1]
            body = re.sub(r"^\s*/\*\"/\*'/\*\*//\* YYD ACTION.*?\*/\s*?\n", "", body, count=1, flags=re.S)
            return body.strip("\n") + "\n"
    raise SystemExit("%s has no %s event" % (obj, ev))


def object_sprite(obj):
    """an object's sprite (objects\\<obj>.txt), or None"""
    p = os.path.join(PROJ, "objects", obj + ".txt")
    if not os.path.exists(p): return None
    m = re.search(r"^sprite=(\w+)", read(p), re.M)
    return m.group(1) if m else None


def sprite_bounds(name):
    """each frame's opaque pixels, from the sprite's origin: [(left, top, right, bottom)], None for a frame with none"""
    sys.path.insert(0, os.path.dirname(HERE))
    import png
    d = os.path.join(PROJ, "sprites", name)
    info = dict(l.strip().split("=", 1) for l in open(os.path.join(d, "sprite.txt"), encoding="utf-8") if "=" in l)
    ox, oy = int(info.get("origin_x", 0)), int(info.get("origin_y", 0))
    res = []
    for i in range(int(info.get("frames", 1))):
        w, h, rows = png.read(os.path.join(d, "%d.png" % i))
        l = t = 1 << 30; r = b = -1
        for y, row in enumerate(rows):
            for x in range(w):
                if row[x * 4 + 3]:
                    if x < l: l = x
                    if x > r: r = x
                    if y < t: t = y
                    b = y
        res.append((l - ox, t - oy, r - ox, b - oy) if r >= 0 else None)
    return res


def read(p):
    return open(p, encoding="utf-8", errors="replace").read()


def room_names():
    return [l.strip() for l in open(os.path.join(ROOMS, "index.yyd"), encoding="utf-8") if l.strip()]


def area_names():
    t = read(os.path.join(PROJ, "scripts", "locationCheck.gml"))
    parts = re.split(r"global\.location=(\d+)", t)
    names = {}
    for i in range(1, len(parts), 2):
        m = re.search(r'tNewLoc="([^"]*)"', parts[i + 1])
        if m and int(parts[i]) not in names: names[int(parts[i])] = m.group(1)
    return names


def room_area(room):
    p = os.path.join(ROOMS, room, "code.gml")
    if not os.path.exists(p): return None
    m = re.search(r"locationCheck\((\d+)\)", read(p))
    return int(m.group(1)) if m else None


def room_areas(rooms):
    """each room's area. A room without its own locationCheck is in the area the game last set, its room group's
    (rMario1_1 sets Gate 1's for the rMario1 rooms after it): the group's latest in story order, to be safe"""
    own = {r: room_area(r) for r in rooms}
    group = collections.defaultdict(list)
    for r, a in own.items():
        if a is not None: group[r.split("_")[0]].append(a)
    return {r: a if a is not None else max(group[r.split("_")[0]] or [None]) for r, a in own.items()}


def instances(room):
    p = os.path.join(ROOMS, room, "instances.txt")
    if not os.path.exists(p): return
    for line in open(p, encoding="utf-8", errors="replace"):
        f = line.strip().split(",")
        if len(f) < 4: continue
        cp = os.path.join(ROOMS, room, f[3] + ".gml")
        yield f[0], int(float(f[1])), int(float(f[2])), f[3], (read(cp) if os.path.exists(cp) else "")


def portal_chips():
    """the gates' portals and the Program Chip each takes (Chip Randomizer): roomlogic\\overrides.txt's need lines whose
    requirement is a chip, each "chip N" alone on an Access Gate portal (oAccessGate) placed where its exit is (the mod
    finds a portal by its room and that place, rndPortalChip, and asks for that one chip): [(room, x, y, N, where the
    game's own connection leads)], by room and place"""
    rooms = solve.load_rooms()
    conn = solve.load_connections()
    solve.load_overrides(rooms, conn)
    out = []
    for (room, o), alts in sorted(conn.need.items()):
        chips = {k - solve.CHIP_KEY for a in alts for k in a.k if k > solve.CHIP_KEY}
        if not chips: continue
        a = alts[0]
        if len(alts) != 1 or len(chips) != 1 or len(a.k) != 1 or any(a.c) or a.o:
            raise SystemExit("overrides.txt: need %s out %s: a Program Chip there must be 'chip N' alone (a gate's portal "
                             "asks for one chip: the mod's rndPortalChip)" % (room, o))
        x, y = [int(v) for v in o.split(",")]
        if not any(obj == "oAccessGate" and (ix, iy) == (x, y) for obj, ix, iy, iid, code in instances(room)):
            raise SystemExit("overrides.txt: need %s out %s takes a Program Chip, but no Access Gate portal (oAccessGate) "
                             "is placed there: the mod only stops a portal" % (room, o))
        to = conn.links.get((room, o))
        if not to: raise SystemExit("overrides.txt: need %s out %s: connections.txt has no such exit" % (room, o))
        out.append((room, x, y, chips.pop(), to[0]))
    return out

def mm_back_check():
    """each of Gate 4's ways back (MM_BACK_EXITS) against the game's own exit it goes back through, as the room logic
    has them (roomlogic\\connections.txt: an exit the room's code makes too): the room before has one exit into this
    one, the way back is near where that one has the player come in (by the edge it comes in at), and where the way back
    has the player come out is beside that exit, clear of it; and the room logic has the way back (roomlogic.py run
    since MM_BACK_EXITS changed)"""
    links = collections.defaultdict(list)
    for line in open(os.path.join(HERE, "roomlogic", "connections.txt"), encoding="utf-8"):
        m = re.match(r"^(\w+) out (-?\d+),(-?\d+) -> (\w+) in (-?\d+),(-?\d+)\s*$", line)
        if m: links[(m.group(1), m.group(4))].append(tuple(int(m.group(k)) for k in (2, 3, 5, 6)))
    for room, x, y, to, tx, ty in MM_BACK_EXITS:
        fwd = links.get((to, room), [])
        if len(fwd) != 1: raise SystemExit("MM_BACK_EXITS: %s has %d exits into %s, not 1" % (to, len(fwd), room))
        fx, fy, nx, ny = fwd[0]
        if (x, y, tx, ty) not in links.get((room, to), []):
            raise SystemExit("MM_BACK_EXITS: the room logic hasn't %s's way back (%d,%d to %s %d,%d): run roomlogic\\"
                             "roomlogic.py" % (room, x, y, to, tx, ty))
        # (the way back: an exit 16x32 at x, y, over the feet of a player who walks to it from where they come in)
        if nx is None or ny is None or abs(nx - (x + 8)) > 64 or not (y <= ny <= y + 48):
            raise SystemExit("MM_BACK_EXITS: %s's way back (%d,%d) isn't by where %s's exit has the player come in (%s,%s)"
                             % (room, x, y, to, nx, ny))
        # (where it comes out: beside the forward exit, not on it, so the player doesn't go straight back through)
        if not (16 <= abs(tx - (fx + 8)) <= 48) or abs(ty - (fy + 32)) > 32:
            raise SystemExit("MM_BACK_EXITS: %s's way back comes out at %d,%d, not beside %s's exit (%d,%d)"
                             % (room, tx, ty, to, fx, fy))


def story_place(room, hexid):
    """a story pickup (STORY_SPOTS): where it was placed and its look (its creation code's sprite_index)"""
    for obj, x, y, hid, code in instances(room) or []:
        if hid == hexid and obj == "oStoryObject":
            m = re.search(r"sprite_index\s*=\s*(s\w+)", code)
            return x, y, m.group(1) if m else STORY_DEFAULT_SPRITE
    raise SystemExit("%s: no story pickup %s there (STORY_SPOTS)" % (room, hexid))


def num(code, var):
    m = re.search(r"\b%s\s*=\s*(-?\d+)" % var, code)
    return int(m.group(1)) if m else None


def gml_str(s):
    return '"' + s.replace('"', "'") + '"'


def main():
    if len(sys.argv) >= 3 and sys.argv[1] == "--world-from":
        return world_from(sys.argv[2])
    if len(sys.argv) < 2: raise SystemExit(__doc__)
    out = sys.argv[1]
    rooms, anames, rarea, locs, doors, shops, door_list, door_order, rows, items, drop = locations_items()
    build(out, rooms, anames, rarea, locs, doors, shops, door_list, door_order, rows, items, drop)


def locations_items():
    """the locations (rows: type, num, rooms, area, req: the logic's alternatives or EVERYTHING, item: the game's own,
    trial) and the items, with the locked doors and the equipment shops: (rooms, area names, room areas, locs, doors,
    shops, door_list, door_order, rows, items, the money chests left out)"""
    rooms = room_names()
    anames = area_names()
    rarea = room_areas(rooms)

    # ---- locations: (type, objectNum) -> rooms, vanilla item
    locs = collections.OrderedDict()
    doors = collections.defaultdict(set)
    shops = collections.OrderedDict()
    for room in rooms:
        for obj, x, y, hexid, code in instances(room) or []:
            if obj == "oLockedDoor":
                doors[num(code, "objectNum")].add(room)
            elif obj == "oNPC_Shop" and re.search(r"shopType\s*=\s*oShopWindow", code):
                # a shop: the room editor's id (a room's copies share it); the game finds it by its room and the place
                # it starts at (its instance id isn't the editor's)
                sid = int(hexid, 16)
                inv = [num(code, r"inv\[%d\]" % i) or 0 for i in range(5)]
                mx = num(code, "maxInv") or 5
                s = shops.setdefault(sid, {"rooms": [], "at": [], "inv": [v for v in inv[:mx]]})
                s["rooms"].append(room)
                s["at"].append((room, x, y))
            elif obj in LT_BY_OBJ and LT_BY_OBJ[obj] not in KEEP_TYPES:
                t = LT_BY_OBJ[obj]
                n = num(code, "objectNum")
                if t in (15, 16, 17): n = 1
                if n is None: continue
                l = locs.setdefault((t, n), {"rooms": [], "item": None})
                l["rooms"].append(room)
                for g in COND_GLOBALS:
                    if re.search(r"global\.%s\b" % g, code): l["cond"] = 1
                if re.search(r"global\.%s\b" % COND_TRIAL, code): l["trial"] = 1
                if t == 2:
                    amt = num(code, "objectAmt") or 0
                    l["item"] = ("EQUIP", amt) if num(code, "newItem") == 1 else ("MONEY", amt)
                elif t == 9:
                    l["item"] = ("WL", num(code, "image_index") or 0)
                else:
                    l["item"] = (LT_ITEM[t], 0)
        # heart containers: made by the boss rooms' own code once the boss is beaten
        cp = os.path.join(ROOMS, room, "code.gml")
        if os.path.exists(cp):
            for m in re.finditer(r"instance_create\([^)]*oHeartContainer\)\s*\n\s*\w+\.objectNum=(\d+)", read(cp)):
                l = locs.setdefault((14, int(m.group(1))), {"rooms": [], "item": ("HC", 0)})
                if room not in l["rooms"]: l["rooms"].append(room)

    # ---- logic: what the room logic says each location needs (roomlogic.txt: alternatives, each the progression items
    # and the keys it takes; each key opens its own door, the mod's oLockedDoor). The doors are listed in their areas'
    # order (for the keys' names and the Archipelago world)
    door_list = sorted((min((rarea.get(r) or 999) for r in rs), d) for d, rs in doors.items() if d is not None)
    door_order = [d for a, d in door_list]
    door_rank = {d: i for i, d in enumerate(door_order)}
    roomlogic = read_roomlogic()
    overrides, room_over = read_logic()
    why_out = read_out_of_logic()
    rows = []
    for (t, n), l in locs.items():
        areas = [rarea.get(r) for r in l["rooms"]]
        a = max((x for x in areas if x is not None), default=None) if None not in areas else None
        req = roomlogic.get((t, n), EVERYTHING)
        # (tower defense's reward: with the new game's option Skip Tower Defense it's there from the start, and the
        # logic has it as the room logic does, with the same changes to it below: req_td)
        req_td = req if l.get("cond") else None
        if t == 14 and n == TRIAL_HC: l["trial"] = 1
        if (t == 14 and n in HC_BOSS) or l.get("cond"):
            # a heart container a boss's fight gives, or tower defense's reward: no ability or key there, so a fight that
            # can't be won yet never holds the game back
            req = EVERYTHING
        for r in l["rooms"]:
            if r in room_over:
                req = room_over[r]
                if req_td is not None: req_td = room_over[r]
        if (t, n) in overrides:
            req = overrides[(t, n)]
            if req_td is not None: req_td = overrides[(t, n)]
        row = {"type": t, "num": n, "rooms": l["rooms"], "area": a, "req": req, "item": l["item"], "trial": l.get("trial", 0),
               "req_td": req_td}
        # (a place overrides.txt puts out of logic: needs everything, whatever else says, and why for the Check Tracker)
        if (t, n) in why_out:
            row["req"], row["why"] = EVERYTHING, why_out[(t, n)]
            if req_td is not None: row["req_td"] = EVERYTHING
        rows.append(row)

    # ---- items: what the locations hold, the abilities, less as many money chests as needed (the smallest)
    items = [r["item"] for r in rows if r["item"] is not None] + list(EXTRA)
    extra = len(items) - len(rows)
    money = sorted((i for i, it in enumerate(items) if it[0] == "MONEY"), key=lambda i: items[i][1])
    drop = set(money[:extra])
    dropped = sorted((items[i][1] for i in drop), reverse=True)
    items = [it for i, it in enumerate(items) if i not in drop]
    assert len(items) == len(rows), (len(items), len(rows))
    # the Nightmare Gates' rewards and their instruments, after the rest (the others' numbers stay as they were: saves
    # keep their places by number). Location 18 g's own item: the instrument g (rndVanillaPlace gives it it)
    for g, room in enumerate(GATE_ROOMS, 1):
        rows.append({"type": INSTR_TYPE, "num": g, "rooms": [room], "area": rarea.get(room), "req": EVERYTHING,
                     "item": ("INSTR", g), "trial": 0})
        items.append(("INSTR", g))
    # the story's ability pickups (STORY_SPOTS, location type 19), after those, and their items after the instruments:
    # the Nightmare abilities (NIGHTMARE: each goes to one of these places, rndGenerate) and as many Internetz as the
    # rest of them, the biggest of the money chests left out above (MONEYX: Internetz a Program Chip never takes the
    # place of, chip_slots, so the chips' items are a save's own)
    if len(dropped) < len(STORY_SPOTS) - len(NIGHTMARE): raise SystemExit("too few money chests left out for the story's places")
    for n, room, hexid, what in STORY_SPOTS:
        req = roomlogic.get((STORY_TYPE, n), EVERYTHING)
        if room in room_over: req = room_over[room]
        if (STORY_TYPE, n) in overrides: req = overrides[(STORY_TYPE, n)]
        rows.append({"type": STORY_TYPE, "num": n, "rooms": [room], "area": rarea.get(room), "req": req, "item": None,
                     "trial": 0, "story": what})
        if (STORY_TYPE, n) in why_out: rows[-1]["req"], rows[-1]["why"] = EVERYTHING, why_out[(STORY_TYPE, n)]
    items += [("NM", p) for p in range(len(NIGHTMARE))]
    items += [("MONEYX", amt) for amt in dropped[:len(STORY_SPOTS) - len(NIGHTMARE)]]
    # each key is one door's (its parameter: the door's objectNum)
    keys = [i for i, it in enumerate(items) if it[0] == "KEY"]
    if len(keys) != len(door_order) or len(keys) != PMAX[-1]:
        raise SystemExit("%d keys, %d locked doors (PMAX says %d): each key opens its own door" % (len(keys), len(door_order), PMAX[-1]))
    for i, d in zip(keys, door_order): items[i] = ("KEY", d)
    return rooms, anames, rarea, locs, doors, shops, door_list, door_order, rows, items, drop


def gallery_doors():
    """rBossGallery's doors: [(type, room, the gallery's x, y, name)], in type order"""
    bosses = []
    for obj, x, y, hexid, code in instances("rBossGallery"):
        if obj != "oBossGalleryDoor": continue
        t = num(code, "type"); tr = re.search(r"toRoom\s*=\s*(\w+)", code)
        if t is None or not tr: continue
        bosses.append((t, tr.group(1), num(code, "newMapX") or 0, num(code, "newMapY") or 0,
                       (re.search(r'bossName="([^"]*)"', code) or [None, "?"])[1]))
    return sorted(bosses)


def boss_list():
    """the bosses fought the randomizer's way (rBossGallery's doors): [(type, room, the gallery's x, y, name)], in
    type order (their place in it: the mod's boss numbers)"""
    seen_rooms = set()
    blist, gates = [], []
    for t, room, bx, by, name in gallery_doors():
        if t in BOSS_SKIP or room in seen_rooms: continue
        rc = os.path.join(ROOMS, room, "code.gml")
        if not os.path.exists(rc) or not re.search(r"bossTrack\s*=\s*1", read(rc)): continue
        seen_rooms.add(room)
        (gates if room.startswith("rExtGate") else blist).append((t, room, bx, by, name))
    return blist + gates


def boss_gate(room):
    """a Nightmare Gate boss's gate (1-7: A-G) by its room, or 0"""
    return GATE_ROOMS.index(room) + 1 if room in GATE_ROOMS[:7] else 0


def boss_slots(blist):
    """the bosses as the room logic has them (roomlogic\\erflat.py: Boss Rando's places): [(type, room, (the via exit's
    room, the room it leads to) or None, whether Boss Rando leaves it in its place: BOSS_FIXED)]"""
    return [(t, room, BOSS_VIA.get(t), t in BOSS_FIXED) for t, room, bx, by, name in blist]


def build(out, rooms, anames, rarea, locs, doors, shops, door_list, door_order, rows, items, drop):
    """the mod, in out, from the locations and items (locations_items)"""
    # ---- bosses (rBossGallery's doors)
    blist = boss_list()
    bidx = {t: i for i, (t, room, bx, by, name) in enumerate(blist)}
    if BOSS_FINAL not in bidx: raise SystemExit("the final boss (type %d) isn't in the boss list" % BOSS_FINAL)
    # where each fight starts (the room code's bossTrack part puts the player there; else the gallery's place): the
    # player walking up to it starts the fight. One outside the room (the room code moves the player in its own way)
    # starts as the room is come into
    bstart = []
    for t, room, bx, by, name in blist:
        rc = read(os.path.join(ROOMS, room, "code.gml"))
        m = re.search(r"if global\.bossTrack\s*(>=|=)\s*1", rc)
        pp = re.search(r"oPlayer1\.x\s*=\s*(-?\d+)\s*;?\s*oPlayer1\.y\s*=\s*(-?\d+)", rc[m.end():m.end() + 1500]) if m else None
        fx, fy = (int(pp.group(1)), int(pp.group(2))) if pp else (bx, by)
        rw = int(re.search(r"^width=(\d+)", read(os.path.join(ROOMS, room, "room.txt")), re.M).group(1))
        rh = int(re.search(r"^height=(\d+)", read(os.path.join(ROOMS, room, "room.txt")), re.M).group(1))
        bstart.append((fx, fy, 0 if 0 <= fx < rw and 0 <= fy <= rh else 1))
    for t, via in BOSS_VIA.items():
        if t not in bidx or any(r not in rooms for r in via): raise SystemExit("BOSS_VIA: boss %d or a room of %s isn't there" % (t, via))
    for t, back in BOSS_VIA_BACK.items():
        if t not in BOSS_VIA or back[0] not in rooms: raise SystemExit("BOSS_VIA_BACK: boss %d has no via, or %s isn't a room" % (t, back[0]))
    # the fights after a boss's own (BOSS_CHAIN): each one's gallery door (its room and where the player starts it)
    door_of = {t: (room, bx, by, name) for t, room, bx, by, name in gallery_doors()}
    for t, chain in BOSS_CHAIN.items():
        if t not in bidx or any(c not in door_of for c in chain):
            raise SystemExit("BOSS_CHAIN: boss %d isn't in the boss list, or a fight of %s has no gallery door" % (t, chain))

    # ---- write
    os.makedirs(out, exist_ok=True)
    src = os.path.join(HERE, "mod")
    for root, ds, fs in os.walk(src):
        for f in fs:
            rel = os.path.relpath(os.path.join(root, f), src)
            dst = os.path.join(out, rel)
            os.makedirs(os.path.dirname(dst), exist_ok=True)
            shutil.copyfile(os.path.join(root, f), dst)
    # the pickups' events: the randomizer's part, then the game's own (so they follow the project's code)
    for obj, lt in SIMPLE_PICKUPS.items():
        d = os.path.join(out, "objects", obj)
        os.makedirs(d, exist_ok=True)
        with open(os.path.join(d, "object.ini"), "w", encoding="utf-8", newline="\n") as f:
            f.write("[object]\nevents=replace\n")
        with open(os.path.join(d, "Alarm_0.gml"), "w", encoding="utf-8", newline="\n") as f:
            f.write(ALARM_PREFIX % (lt, ALARM_EXTRA.get(obj, "")) + vanilla_event(obj, "Alarm_0"))
        with open(os.path.join(d, "Collision_oPlayer1.gml"), "w", encoding="utf-8", newline="\n") as f:
            f.write(COLL_PREFIX % COLL_EXTRA.get(obj, "") + vanilla_event(obj, "Collision_oPlayer1"))
    patched = collections.OrderedDict()
    for obj, ev, old, new in GAME_PATCHES:
        code = patched.get((obj, ev)) or vanilla_event(obj, ev)
        if code.count(old) != 1: raise SystemExit("%s %s: the line GAME_PATCHES changes isn't there once (the game's code changed)" % (obj, ev))
        patched[(obj, ev)] = code.replace(old, new)
    for (obj, ev), code in patched.items():
        d = os.path.join(out, "objects", obj)
        os.makedirs(d, exist_ok=True)
        with open(os.path.join(d, "object.ini"), "w", encoding="utf-8", newline="\n") as f:
            f.write("[object]\nevents=replace\n")
        with open(os.path.join(d, ev + ".gml"), "w", encoding="utf-8", newline="\n") as f:
            f.write("//(the game's own %s %s, with the Randomizer's changes: rndgen.py GAME_PATCHES)\n" % (obj, ev) + code)
    # the game's scripts the Randomizer changes: the game's own, changed (SCRIPT_PATCHES), as the mod's version of each
    script_code = collections.OrderedDict()
    for script, old, new in SCRIPT_PATCHES:
        code = script_code.get(script)
        if code is None:
            # (without its line that hands it to a mod's version: this is that version)
            lines = read(os.path.join(PROJ, "scripts", script + ".gml")).split("\n")
            hand = [l for l in lines if "global.modOvr[%s]" % script in l]
            if len(hand) != 1: raise SystemExit("%s: its mod line (global.modOvr) isn't there once" % script)
            code = "\n".join(l for l in lines if l != hand[0])
        if code.count(old) != 1: raise SystemExit("%s: the line SCRIPT_PATCHES changes isn't there once (the game's code changed)" % script)
        script_code[script] = code.replace(old, new)
    for script, code in script_code.items():
        with open(os.path.join(out, "scripts", script + ".gml"), "w", encoding="utf-8", newline="\n") as f:
            f.write("//(the game's own %s as the mod's version of it, with the Randomizer's changes: rndgen.py SCRIPT_PATCHES)\n"
                    % script + code)
    # <event>.prefix.gml (mod\objects): the randomizer's part of one of the game's events, the game's own after it
    for root, ds, fs in os.walk(os.path.join(out, "objects")):
        for f in fs:
            if f.endswith(".prefix.gml"):
                obj, ev = os.path.basename(root), f[:-len(".prefix.gml")]
                with open(os.path.join(root, ev + ".gml"), "w", encoding="utf-8", newline="\n") as g:
                    g.write(read(os.path.join(root, f)).rstrip("\n") + "\n" + vanilla_event(obj, ev))
                os.remove(os.path.join(root, f))
    L = ["//Randomizer data: every location, the items and the equipment shops, made by tools/modkit/randomizer/rndgen.py",
         "//from the game's rooms (don't change it here: change rndgen.py or logic.txt and build again)",
         "var i,t;",
         "for(t=0;t<=%d;t+=1) {for(i=0;i<=130;i+=1) {global.rndLocOf[t,i]=-1}}" % STORY_TYPE,
         "global.rndLocN=%d" % len(rows)]
    # each location's logic: its alternatives (rndLocAltN, -1: it needs everything), each a list (rndLocAltLen long) of
    # what it takes: rndLocAltIx a progression item's number (rndProgOf; KEY_BASE+objectNum for a door's key) and
    # rndLocAltC how many (index a*ALT_STRIDE+j). And where it is, as the multiworld's location names have it
    # (rndLocPlace: place_of, the vending machines' hints)
    screen_of = screen_names()
    for i, r in enumerate(rows):
        a = r["area"]
        where = "%s (%s)" % (anames.get(a, "?"), r["rooms"][0]) if a else r["rooms"][0]
        name = "%s: %s %d" % (where, LT_LABEL[r["type"]], r["num"])
        if r["type"] == INSTR_TYPE: name = "Nightmare Gate %s (%s): its boss's reward" % ("ABCDEFGH"[r["num"] - 1], r["rooms"][0])
        if r["type"] == STORY_TYPE: name += " (where the story gave %s)" % r["story"]
        L.append("global.rndLocType[%d]=%d; global.rndLocNum[%d]=%d; global.rndLocOf[%d,%d]=%d; "
                 "global.rndLocName[%d]=%s; global.rndLocTrial[%d]=%d; global.rndLocPlace[%d]=%s"
                 % (i, r["type"], i, r["num"], r["type"], r["num"], i,
                    i, gml_str(name), i, r["trial"], i, gml_str(place_of(r, anames, screen_of))))
        if r["req"] is EVERYTHING:
            L.append("global.rndLocAltN[%d]=-1" % i)
            continue
        s = ["global.rndLocAltN[%d]=%d" % (i, len(r["req"]))]
        for ai, alt in enumerate(r["req"]):
            s.append("global.rndLocAltLen[%d,%d]=%d" % (i, ai, len(alt)))
            for j, (ix, c) in enumerate(sorted(alt.items())):
                s.append("global.rndLocAltIx[%d,%d]=%d; global.rndLocAltC[%d,%d]=%d" % (i, ai * ALT_STRIDE + j, ix, i, ai * ALT_STRIDE + j, c))
        L.append("; ".join(s))
    # Gate 4's stage map's "Items Obtained" (rndMMStageText): each stage's locations (its cursor place: 1-3 the
    # Mavericks' stages, 4-6 Sigma's, 7 the Robot Factory), what the menu counts in the game. Not Sigma's last room's
    # heart container (rMega4_SigmaC5), which the menu leaves out
    stage_rooms = ((1, "rMega4_Storm"), (2, "rMega4_Ostrich"), (3, "rMega4_ToxicJungle"), (4, "rMega4_SigmaA"),
                   (5, "rMega4_SigmaB"), (6, "rMega4_SigmaC"), (7, "rMega4_IntroC"))
    for s, pre in stage_rooms:
        locs = [i for i, r in enumerate(rows) if r["rooms"][0].startswith(pre) and r["rooms"][0] != "rMega4_SigmaC5"]
        L.append("; ".join(["global.rndMMStageN[%d]=%d" % (s, len(locs))] +
                           ["global.rndMMStageLoc[%d,%d]=%d" % (s, k, i) for k, i in enumerate(locs)]))
    L.append("global.rndKeyBase=%d; global.rndAltStride=%d" % (KEY_BASE, ALT_STRIDE))
    # (the movement abilities' turns, rndGenerate: MOVE_AT)
    L.append("; ".join(["global.rndMoveN=%d" % len(MOVE_AT)] + ["global.rndMoveLo[%d]=%d; global.rndMoveHi[%d]=%d" % (j, lo, j, hi)
                                                              for j, (lo, hi) in enumerate(MOVE_AT)]))
    L.append("global.rndMoneyMul=%d //(an Internetz item gives this many times its amount: rndMoneyOf, MONEY_MUL)" % MONEY_MUL)
    # the vending machines' hints (rndHintName): the progression items as the multiworld names them, the abilities and
    # sets by their numbers (rndProgOf's 1-12: "Progressive Link") and the keys by their doors ("Key: ...")
    L.append("; ".join("global.rndProgName[%d]=%s" % (n, gml_str(AP_PROG[n])) for n in range(1, VARIA_IX + 1)))
    key_hint = key_names_of(door_order, doors, anames, rarea)
    L.append("; ".join("global.rndKeyHint[%d]=%s" % (d, gml_str(key_hint[d])) for d in door_order))
    # Skip Tower Defense (the new game's option): tower defense's rewards (the locations whose pickups its progress shows:
    # COND_GLOBALS) and what getting to each takes as the room logic has it (req_td), which rndSkipTDApply puts in their
    # rndLocAlt* with the option on; off, they need everything
    td = [(i, r["req_td"]) for i, r in enumerate(rows) if r.get("req_td") is not None]
    L.append("global.rndTdN=%d" % len(td))
    for k, (i, req) in enumerate(td):
        if req is EVERYTHING:
            L.append("global.rndTdLoc[%d]=%d; global.rndTdAltN[%d]=-1" % (k, i, k))
            continue
        s = ["global.rndTdLoc[%d]=%d; global.rndTdAltN[%d]=%d" % (k, i, k, len(req))]
        for ai, alt in enumerate(req):
            s.append("global.rndTdAltLen[%d,%d]=%d" % (k, ai, len(alt)))
            for j, (ix, c) in enumerate(sorted(alt.items())):
                s.append("global.rndTdAltIx[%d,%d]=%d; global.rndTdAltC[%d,%d]=%d" % (k, ai * ALT_STRIDE + j, ix, k, ai * ALT_STRIDE + j, c))
        L.append("; ".join(s))
    L.append("global.rndItemN=%d" % len(items))
    for i, (k, p) in enumerate(items):
        L.append("global.rndItemKind[%d]=%d; global.rndItemParam[%d]=%d" % (i, IK[k], i, p))
    # the Program Chips (Chip Randomizer): the items that are them with it on (rndChipApply; off, their Internetz), the
    # logic's numbers for them (rndChipBase+gate), each gate's name and its rooms' name prefix (rndGateOf: a save from
    # before the portals took the chips goes by the gate a portal leads into), and the portals that take them, each by
    # its room and where it's placed (portal_chips: rndPortalChip)
    slots = chip_slots(items)
    L.append("global.rndChipN=%d; global.rndChipBase=%d" % (len(CHIP_GATES), KEY_BASE + solve.CHIP_KEY))
    for g in CHIP_GATES:
        grooms = [r for r in rooms if solve.gate_of(r) == g]
        gname = anames.get(rarea.get(grooms[0]), "Access Gate %d" % g)
        L.append("global.rndChipItem[%d]=%d; global.rndChipMoney[%d]=%d; global.rndGatePrefix[%d]=%s; global.rndGateName[%d]=%s"
                 % (g, slots[g], g, items[slots[g]][1], g, gml_str(solve.GATE_PREFIX[g]), g, gml_str(gname)))
    # the pause menu's Teleport (rndTeleport): each gate's area, its way out and where the game has it lead, its name
    tconn = solve.load_connections()
    L.append("global.rndTpN=%d" % len(TELEPORT_GATES))
    for i, (a, room, x, y) in enumerate(TELEPORT_GATES):
        to = tconn.links.get((room, "%d,%d" % (x, y)))
        if to is None or rarea.get(room) != a or rarea.get(to[0]) == a:
            raise SystemExit("TELEPORT_GATES: %s out %d,%d isn't area %d's way out (the connections: %s)" % (room, x, y, a, to))
        tx, ty = (int(v) for v in to[1].split(","))
        L.append("global.rndTpArea[%d]=%d; global.rndTpExRoom[%d]=%s; global.rndTpExX[%d]=%d; global.rndTpExY[%d]=%d; "
                 "global.rndTpRoom[%d]=%s; global.rndTpX[%d]=%d; global.rndTpY[%d]=%d; global.rndTpName[%d]=%s"
                 % (i, a, i, room, i, x, i, y, i, to[0], i, tx, i, ty, i, gml_str(anames.get(a, "the gate"))))
    portals = portal_chips()
    L.append("global.rndPortalN=%d" % len(portals))
    for i, (room, x, y, g, to) in enumerate(portals):
        L.append("global.rndPortalRoom[%d]=%s; global.rndPortalX[%d]=%d; global.rndPortalY[%d]=%d; global.rndPortalChip[%d]=%d"
                 % (i, room, i, x, i, y, i, g))
    # the trap items (Traps): the items that are them with it on (rndSnareApply; off, their Internetz) and each one's
    # trap; and the ones a save from before the Wind Orb has (rndSnareOld*: its own, as its game was made)
    snares = snare_slots(items)
    L.append("global.rndSnareN=%d; global.rndSnareTypeN=%d" % (len(snares), len(SNARE_TYPES)))
    for k, (i, t) in enumerate(snares):
        L.append("global.rndSnareItem[%d]=%d; global.rndSnareType[%d]=%d; global.rndSnareMoney[%d]=%d" % (k, i, k, t, k, items[i][1]))
    old = snare_slots_old(items)
    L.append("global.rndSnareOldN=%d" % len(old))
    for k, (i, t) in enumerate(old):
        L.append("global.rndSnareOldItem[%d]=%d; global.rndSnareOldType[%d]=%d; global.rndSnareOldMoney[%d]=%d" % (k, i, k, t, k, items[i][1]))
    L.append("global.rndEShopN=0")
    k = 0
    for sid, s in shops.items():
        for slot, eq in enumerate(s["inv"]):
            if not eq: continue
            L.append("global.rndEShopNpc[%d]=%d; global.rndEShopSlot[%d]=%d; global.rndEShopEquip[%d]=%d; global.rndEShopRoom[%d]=%s"
                     % (k, sid, k, slot, k, eq, k, gml_str(s["rooms"][0])))
            k += 1
    L.append("global.rndEShopN=%d" % k)
    # where each shop's shopkeeper is (rndShopEquip finds the shop by its room and starting place)
    j = 0
    for sid, s in shops.items():
        for room, x, y in s["at"]:
            L.append("global.rndEShopAtRoom[%d]=%s; global.rndEShopAtX[%d]=%d; global.rndEShopAtY[%d]=%d; global.rndEShopAtNpc[%d]=%d"
                     % (j, room, j, x, j, y, j, sid))
            j += 1
    L.append("global.rndEShopAtN=%d" % j)
    L.append("global.rndBossN=%d" % len(blist))
    for i, (t, room, bx, by, name) in enumerate(blist):
        L.append("global.rndBossType[%d]=%d; global.rndBossRoom[%d]=%s; global.rndBossX[%d]=%d; global.rndBossY[%d]=%d; "
                 "global.rndBossName[%d]=%s" % (i, t, i, room, i, bx, i, by, i, gml_str(name)))
        vf, vt = BOSS_VIA.get(t, ("-1", "-1"))
        L.append("global.rndBossViaFrom[%d]=%s; global.rndBossViaTo[%d]=%s" % (i, vf, i, vt))
        vb, vbx, vby = BOSS_VIA_BACK.get(t, ("-1", -1, -1))
        L.append("global.rndBossViaBackRoom[%d]=%s; global.rndBossViaBackX[%d]=%d; global.rndBossViaBackY[%d]=%d"
                 % (i, vb, i, vbx, i, vby))
        chain = BOSS_CHAIN.get(t, ())
        s = ["global.rndBossChainN[%d]=%d" % (i, len(chain))]
        for k, c in enumerate(chain):
            croom, cx, cy, cname = door_of[c]
            s.append("global.rndBossChainType[%d,%d]=%d; global.rndBossChainRoom[%d,%d]=%s; global.rndBossChainX[%d,%d]=%d; "
                     "global.rndBossChainY[%d,%d]=%d" % (i, k, c, i, k, croom, i, k, cx, i, k, cy))
        L.append("; ".join(s))
        fx, fy, fe = bstart[i]
        L.append("global.rndBossFX[%d]=%d; global.rndBossFY[%d]=%d; global.rndBossOnEntry[%d]=%d; global.rndBossGate[%d]=%d; "
                 "global.rndBossAP[%d]=%d" % (i, fx, i, fy, i, fe, i, boss_gate(room), i, BOSS_AP.get(t, 0)))
    # the enemy traps (traps.py): each one's room, its object (made here, from the game's code) and name
    import traps
    trap_list = traps.all_traps()
    L += traps.write_mod(out, trap_list)
    L.append("global.rndApBase=%d //Archipelago: a location's id is this+type*1000+objectNum, an item's this+kind*10000+parameter" % AP_BASE)
    L.append("global.rndBossFinal=%d" % bidx[BOSS_FINAL])
    # (the boss list's types, as saves keep them: a save's beaten bosses are read back by type; one from before they
    # were kept, by the list then)
    L.append("global.rndBossTypes=%s; global.rndBossTypesOld=%s"
             % (gml_str("," + ",".join(str(t) for t, room, bx, by, name in blist) + ","), gml_str("," + BOSS_TYPES_OLD + ",")))
    for n in range(8):
        L.append("global.rndHCBoss[%d]=%d" % (n, bidx.get(HC_BOSS.get(n, -1), -1)))
    # the rooms whose code makes the player a character other than Jerry or Claire (2 Jeremy's mech, 3 the Abomination's
    # fights', 4 and 5 the Distortion's end): one carried out of them into another room goes back (the roomStart hook)
    # (not the CHAOS Warmaster's room or the one before it: their code makes the player Jeremy's mech only once the story's
    # past the Warmaster, who is the Randomizer's last fight; the roomStart hook keeps the player's own character there)
    char_rooms = []
    for room in rooms:
        cp = os.path.join(ROOMS, room, "code.gml")
        if not os.path.exists(cp) or room in ("rWarshipZ_E1", "rWarshipZ_E2"): continue
        code = read(cp)
        chs = {int(c) for c in re.findall(r"charSwitcher\(\s*([2-9])\s*\)", code)}
        # (an assignment starting a statement: "if global.activeCharacter=2" is a comparison)
        chs |= {int(c) for c in re.findall(r"(?:^|[;{])\s*global\.activeCharacter\s*=\s*([2-9])\b", code, re.M)}
        char_rooms += [(room, c) for c in sorted(chs)]
    # (and the rooms the story has the player go through as Jeremy's mech, made so by a scene before them: a Randomizer
    # game makes the player it as they come in, the roomStart hook, MECH_ROOMS)
    char_rooms += [(room, 2) for room in MECH_ROOMS if (room, 2) not in char_rooms]
    L.append("global.rndCharRoomN=%d" % len(char_rooms))
    for i, (room, c) in enumerate(char_rooms):
        L.append("global.rndCharRoom[%d]=%s; global.rndCharRoomCh[%d]=%d" % (i, room, i, c))
    L.append("global.rndMechRoomN=%d" % len(MECH_ROOMS))
    for i, room in enumerate(MECH_ROOMS): L.append("global.rndMechRoom[%d]=%s" % (i, room))
    # the story's ability pickups (STORY_SPOTS, location type 19): each one's room, where it was placed and its look (its
    # creation code's sprite), for its pickup (oRndStory, which the roomStart hook makes)
    # (rndStoryN: the highest number; a number not used has no room)
    L.append("global.rndStoryN=%d" % max(n for n, room, hexid, what in STORY_SPOTS))
    L.append("for(i=0;i<=global.rndStoryN;i+=1) {global.rndStoryRoom[i]=-1}")
    for n, room, hexid, what in STORY_SPOTS:
        x, y, spr = story_place(room, hexid)
        L.append("global.rndStoryRoom[%d]=%s; global.rndStoryX[%d]=%d; global.rndStoryY[%d]=%d; global.rndStorySpr[%d]=%s"
                 % (n, room, n, x, n, y, n, spr))
    # the rooms whose code doesn't set the area (global.location: the game keeps the one before, its rooms before being
    # in the same area there, as rMario1_1 sets Gate 1's for the rMario1 rooms after it), when every room of their group
    # that does sets the same one: theirs, which the roomStart hook sets as the player comes into one from another area
    # (Entrance Rando, the Randomizer's warps: else the area before stays, and what goes by it is that area's)
    own = {r: room_area(r) for r in rooms}
    grp = collections.defaultdict(set)
    for r, a in own.items():
        if a is not None: grp[r.split("_")[0]].add(a)
    room_loc = [(r, min(grp[r.split("_")[0]])) for r in rooms if own[r] is None and len(grp[r.split("_")[0]]) == 1]
    L.append("global.rndRoomLocN=%d" % len(room_loc))
    for i, (r, a) in enumerate(room_loc):
        L.append("global.rndRoomLocR[%d]=%s; global.rndRoomLocA[%d]=%d" % (i, r, i, a))
    # Gate 4's stages' ways back (MM_BACK_EXITS): each one's room and place, and where it leads (the roomStart hook)
    mm_back_check()
    L.append("global.rndMMBackN=%d" % len(MM_BACK_EXITS))
    for i, (room, x, y, to, tx, ty) in enumerate(MM_BACK_EXITS):
        L.append("global.rndMMBackRoom[%d]=%s; global.rndMMBackX[%d]=%d; global.rndMMBackY[%d]=%d; global.rndMMBackTo[%d]=%s; "
                 "global.rndMMBackToX[%d]=%d; global.rndMMBackToY[%d]=%d" % (i, room, i, x, i, y, i, to, i, tx, i, ty))
    # the locked doors (by objectNum): their order (the logic's) and where they are
    L.append("for(i=0;i<=50;i+=1) {global.rndDoorRank[i]=-1; global.rndDoorArea[i]=%s; global.rndDoorPlace[i]=%s}"
             % (gml_str("?"), gml_str("?")))
    L.append("global.rndDoorN=%d" % len(door_order))
    for i, d in enumerate(door_order):
        rs = sorted(doors[d])
        an = anames.get(rarea.get(rs[0]), "?")
        L.append("global.rndDoorRank[%d]=%d; global.rndDoorArea[%d]=%s; global.rndDoorPlace[%d]=%s"
                 % (d, i, d, gml_str(an), d, gml_str("%s, %s" % (an, rs[0]))))
    # the sprites of the pickups and of the items' looks (rndItemLook): their opaque pixels from the origin, of all frames
    # (rndSprU*) and of each (rndSprF*), for rndItemFit
    sprs = sorted(set(re.findall(r"sprite_index=(s\w+)", read(os.path.join(HERE, "mod", "scripts", "rndItemLookKP.gml")))) |
                  {object_sprite(o) for c, o, l in LTYPES if object_sprite(o)} |
                  {story_place(room, hexid)[2] for n, room, hexid, what in STORY_SPOTS})
    # the bosses' previews in their rooms (bosspv.py: each boss's look and the smoke, the mod's own sprites, and each boss
    # place's arena middle), and the places Boss Rando leaves their own bosses in (rndBossFixed: no smoke there)
    import bosspv
    L += bosspv.write_mod(out, blist, bstart, BOSS_VIA)
    for i, (t, room, bx, by, name) in enumerate(blist): L.append("global.rndBossFixed[%d]=%d" % (i, t in BOSS_FIXED))
    # and the Archipelago look of another world's item: the mod's own sprite (made here)
    ap_bounds = ap_sprite(os.path.join(out, "sprites"))
    sprs.append(AP_SPRITE)
    L.append("global.rndSprMax=0")
    for s in sprs: L.append("global.rndSprMax=max(global.rndSprMax,%s)" % s)
    L.append("for(i=0;i<=global.rndSprMax;i+=1) {global.rndSprK[i]=0}")
    for s in sprs:
        fr = ap_bounds if s == AP_SPRITE else sprite_bounds(s)
        known = [b for b in fr if b]
        u = (min(b[0] for b in known), min(b[1] for b in known), max(b[2] for b in known), max(b[3] for b in known))
        L.append("global.rndSprK[%s]=1; global.rndSprN[%s]=%d; global.rndSprUL[%s]=%d; global.rndSprUT[%s]=%d; global.rndSprUR[%s]=%d; "
                 "global.rndSprUB[%s]=%d" % (s, s, len(fr), s, u[0], s, u[1], s, u[2], s, u[3]))
        for i, b in enumerate(fr):
            b = b or u
            L.append("global.rndSprFL[%s,%d]=%d; global.rndSprFT[%s,%d]=%d; global.rndSprFR[%s,%d]=%d; global.rndSprFB[%s,%d]=%d"
                     % (s, i, b[0], s, i, b[1], s, i, b[2], s, i, b[3]))
    # this build's id (the trackers' data has it too: tracker.py), from the data
    import hashlib
    build_id = hashlib.md5("\n".join(L).encode("utf-8")).hexdigest()[:12]
    L.append("global.rndBuildId=%s" % gml_str(build_id))
    os.makedirs(os.path.join(out, "scripts"), exist_ok=True)
    with open(os.path.join(out, "scripts", "rndData.gml"), "w", encoding="utf-8", newline="\n") as f:
        f.write("\n".join(L) + "\n")
    with open(os.path.join(out, "scripts", "rndWorld.gml"), "w", encoding="utf-8", newline="\n") as f:
        f.write(world_gml())
    with open(os.path.join(HERE, "locations.csv"), "w", newline="", encoding="utf-8") as f:
        w = csv.writer(f)
        w.writerow(["id", "type", "num", "rooms", "area", "area name", "requires", "vanilla item"])
        for i, r in enumerate(rows):
            w.writerow([i, LT_LABEL[r["type"]].lower(), r["num"], " ".join(r["rooms"]), r["area"] or "",
                        anames.get(r["area"], ""), req_text(r["req"]), "%s %s" % r["item"] if r["item"] else ""])
    with open(os.path.join(HERE, "doors.csv"), "w", newline="", encoding="utf-8") as f:
        w = csv.writer(f)
        w.writerow(["order", "objectNum (key N in logic.txt)", "rooms", "area", "area name"])
        for i, (a, d) in enumerate(door_list):
            w.writerow([i + 1, d, " ".join(sorted(doors[d])), a if a < 999 else "", anames.get(a, "")])
    print("locations %d, items %d (%d abilities added, %d money chests left out), equipment shop slots %d, shops %d"
          % (len(rows), len(items), len(EXTRA), len(drop), k, len(shops)))
    print("locked doors (objectNum: area):", ", ".join("%d: %s" % (d, a if a < 999 else "?") for a, d in door_list))
    free = sum(1 for r in rows if r["req"] is not EVERYTHING and any(not alt for alt in r["req"]))
    some = sum(1 for r in rows if r["req"] is not EVERYTHING)
    print("locations: %d need nothing but jumping, %d can hold an ability or key, %d need everything (no ability or key)"
          % (free, some, len(rows) - some))
    print("bosses fought the randomizer's way: %d (%s)" % (len(blist), ", ".join("%d %s" % (t, n) for t, r, x, y, n in blist)))
    print("enemy traps brought back: %d in %d rooms (traps.py), %d needing nothing more than getting there"
          % (len(trap_list), len({t.room for t in trap_list}), sum(1 for t in trap_list if t.req in ("-", ""))))
    # the same placement the game makes without the room logic's data (rndGenerate with rndData's logic: the game's own
    # layout, no shares of the checks), for a few seeds with each option: it must work under the logic. With Chip
    # Randomizer, each seed is also played through, and no Program Chip may be behind a portal it opens; with Skip Tower
    # Defense (td: tower defense's rewards in the logic, skip_td_rows), played through. (The game places with the room
    # logic's reach when it has its data: er_check's seed checks)
    for label, wpn, spread, chips, td in (("default options", False, 1, False, False),
                                          ("Guarantee Early Weapons", True, 1, False, False),
                                          ("Ability Spread Near", False, 0, False, False),
                                          ("Ability Spread Far", False, 2, False, False),
                                          ("Chip Randomizer", False, 1, True, False),
                                          ("Chip Randomizer with Guarantee Early Weapons", True, 1, True, False),
                                          ("Skip Tower Defense", False, 1, False, True)):
        its = items_with_chips(items, chips)
        rws = skip_td_rows(rows) if td else rows
        results = [fill_check(rws, its, seed, door_order, wpn, SPREAD[spread], chips) for seed in range(50)]
        ok = [r for r in results if r]
        if not ok: raise SystemExit("%s: no seed could be placed: the logic asks for more than the locations allow" % label)
        if chips or td:
            for r in ok:
                if chips: chip_check(rws, its, r, label)
                if not fill_playthrough(rws, its, r, chips): raise SystemExit("%s: a seed placed can't be played through" % label)
        depth = [max(p[0] for p in r) + 1 for r in ok]
        what = " and played through, no chip behind a portal it opens" if chips else " and played through" if td else ""
        if td:
            at = {i for i, r in enumerate(rows) if r.get("req_td") is not None}
            what += ", %d with an ability or key at tower defense's rewards" % sum(1 for r in ok if any(loc in at for lay, loc, k in r))
        print("placement check without the room logic's data, %s: %d of 50 seeds placed%s, layers %d to %d (average %.1f)"
              % (label, len(ok), what, min(depth), max(depth), sum(depth) / len(depth)))
    f, bp, hv = er_check(rows, items, out, boss_slots(blist))
    ap_export(rows, items, door_order, doors, rarea, anames, out, f, bp, hv, blist)
    import tracker
    tracker.build(out, rows, items, f, bp, hv, door_order, blist, anames, rarea, rooms, build_id)


def er_check(rows, items, out, bosses):
    """Entrance Rando and Boss Rando: the room logic the mod works seeds out from (data\\rndER.txt: roomlogic\\erflat.py),
    and seeds made as the mod makes them (the doors shuffled, every place and the goal reached with everything, the
    bosses shuffled, the items placed with what the doors and bosses let through, the seed played through), so a mode
    whose seeds can't be made shows up here. Returns the tables, the places the game's own doors reach with everything
    and everything's numbers (the trackers': tracker.py)"""
    import random
    sys.path.insert(0, os.path.join(HERE, "roomlogic"))
    import erflat
    f, w, pairs, digest, bp, hv = erflat.build_data(rows, os.path.join(out, "data", "rndER.txt"), bosses)
    print("room logic data written: Entrance Rando %d doors, %d exits following one, %d rooms (hash %s); Boss Rando %d "
          "bosses shuffled" % (len(f.ends) // 2, sum(1 for d in f.exit_follow if d >= 0), len(f.rnames), digest,
                               sum(f.boss_shuf)))
    # the exits that are one way (er.one_way: going through one, no exit by where the player comes out leads back to it)
    # and show an arrow (an oExit whose creation code shows it): in a game with Entrance Rando the roomStart hook puts a
    # ONE WAY sign over the arrow (oRndOneWay). The mod's data script rndOneWayData, "room:x,y" each, as the exits are
    # found by (rndERApplyExit)
    import er
    ow = er.one_way(w.rooms, w.conn, pairs)
    arrows = []
    for room in sorted(w.rooms):
        for obj, x, y, iid, code in instances(room):
            if obj == "oExit" and re.search(r"\bbShowArrow\s*=\s*(true|1)\b", code) and (room, "%d,%d" % (x, y)) in ow:
                arrows.append((room, x, y))
    O = ["//Randomizer data, made by tools/modkit/randomizer/rndgen.py: the exits that are one way (roomlogic\\er.py's",
         "//one_way: going through one, no exit by where the player comes out leads back to it) and show an arrow, \"room:x,y\"",
         "//each: in a game with Entrance Rando the roomStart hook puts a ONE WAY sign over the arrow (oRndOneWay)",
         "global.rndOneWay=ds_map_create()"]
    O += ["ds_map_add(global.rndOneWay,string(%s)+\":%d,%d\",1)" % (room, x, y) for room, x, y in arrows]
    with open(os.path.join(out, "scripts", "rndOneWayData.gml"), "w", encoding="utf-8", newline="\n") as fh:
        fh.write("\n".join(O) + "\n")
    print("one way exits: %d, %d of them with an arrow (their ONE WAY signs with Entrance Rando)" % (len(ow), len(arrows)))
    # the room logic's ways into rooms (f.entries, numbered as data\rndER.txt has them), "room:x,y" each, and their
    # list's hash: in every game the mod's rndVisitArrive marks the one the player comes in by (the Check Tracker counts
    # what the ways in they've used get to as in logic), and a save keeps them with the hash (a build whose ways in are
    # others drops them). The mod's data script rndVisitData
    import hashlib
    keys = ["%s:%d,%d" % ((f.rnames[ri],) + erflat.xy_of(inid)) for ri, inid in f.entries]
    V = ["//Randomizer data, made by tools/modkit/randomizer/rndgen.py: the room logic's ways into rooms (roomlogic\\erflat.py's",
         "//entries, numbered as in data\\rndER.txt), \"room:x,y\" each, and their list's hash: rndVisitArrive marks the one",
         "//the player comes in by",
         "global.rndVisitOf=ds_map_create()",
         "global.rndVisitN=%d" % len(keys),
         "global.rndVisitHash=%s" % gml_str(hashlib.md5("|".join(keys).encode()).hexdigest()[:12])]
    done = set()
    for e, k in enumerate(keys):
        if "-99999" in k or k in done: continue
        done.add(k)
        V.append("ds_map_add(global.rndVisitOf,%s,%d)" % (gml_str(k), e))
    with open(os.path.join(out, "scripts", "rndVisitData.gml"), "w", encoding="utf-8", newline="\n") as fh:
        fh.write("\n".join(V) + "\n")
    print("ways into rooms: %d (%d by where they put the player, rndVisitData)" % (len(keys), len(done)))
    # (for the Archipelago world: the data's hash, and each door end as the spoiler log names it, rndERExitName)
    f.digest = digest
    label = {n: w.rooms[n].area.split(" (area")[0] for n in w.rooms}
    f.end_names = []
    for e in f.ends:
        ri, o = f.exits[e["exit"]]
        f.end_names.append("%s (%s) at %d,%d" % (label.get(f.rnames[ri], f.rnames[ri]), f.rnames[ri], *erflat.xy_of(o)))
    # (and the exits that follow an end, while this build's world has them, erflat's ER_FEATURES 1: [exit, its end, its
    # name], rndERExitNameX)
    f.follow_list = []
    for xi, d in enumerate(f.exit_follow):
        if d >= 0 and erflat.ER_FEATURES & 1:
            ri, o = f.exits[xi]
            f.follow_list.append([xi, d, "%s (%s) at %d,%d" % (label.get(f.rnames[ri], f.rnames[ri]), f.rnames[ri], *erflat.xy_of(o))])
    # (td: Skip Tower Defense, tower defense's rewards in the logic: skip_td_rows. Every game places its items with the
    # room logic's reach, the shares of the checks the boss fights take among it: the options with nothing shuffled too.
    # wpn: Guarantee Early Weapons; spread: Ability Spread, SPREAD's)
    for label, bit, br, ir, chips, td, wpn, spread in (
            ("default options", 0, False, False, False, False, False, 1),
            ("Guarantee Early Weapons", 0, False, False, False, False, True, 1),
            ("Ability Spread Near", 0, False, False, False, False, False, 0),
            ("Ability Spread Far", 0, False, False, False, False, False, 2),
            ("Gate Swap", 1, False, False, False, False, False, 1), ("Area", 2, False, False, False, False, False, 1),
            ("Chaos", 4, False, False, False, False, False, 1), ("Boss Rando", 0, True, False, False, False, False, 1),
            ("Instrument Randomization", 0, False, True, False, False, False, 1),
            ("Chaos with Boss Rando and Instrument Randomization", 4, True, True, False, False, False, 1),
            ("Chaos with Boss Rando, Ability Spread Far", 4, True, False, False, False, False, 2),
            ("Chip Randomizer", 0, False, False, True, False, False, 1),
            ("Gate Swap with Chip Randomizer", 1, False, False, True, False, False, 1),
            # (not Chaos with it: the Chip Randomizer is off with Entrance Rando Chaos, the options window's and the
            # Archipelago world's)
            ("Area with Chip Randomizer, Boss Rando and Instrument Randomization", 2, True, True, True, False, False, 1),
            ("Chaos with Skip Tower Defense", 4, False, False, False, True, False, 1),
            ("Boss Rando with Skip Tower Defense", 0, True, False, False, True, False, 1)):
        its = items_with_chips(items, chips)
        rws = skip_td_rows(rows) if td else rows
        tries = 0
        at_td = 0
        for seed in range(10):
            for t in range(60):
                tries += 1
                rng = random.Random(seed * 1000 + t)
                part = erflat.shuffle(f, bit, rng) if bit else [-1] * len(f.ends)
                if part is None: continue
                fight = erflat.br_shuffle(f, rng) if br else None
                if bit and not erflat.everything_ok(f, part, hv, bp, fight, ir): continue
                placed = erflat.fill(f, part, rws, its, rng, weapons=wpn, newest=SPREAD[spread], fight=fight, ir=ir, chips=chips)
                if placed is None: continue
                if not erflat.playthrough(f, part, placed, rws, its, fight, ir, chips):
                    raise SystemExit("%s: a seed made can't be played through" % label)
                if chips and not bit: chip_check(rws, its, placed, label)
                if td: at_td += any(rows[loc].get("req_td") is not None for lay, loc, k in placed)
                break
            else:
                raise SystemExit("%s: no seed worked out in 60 tries (seed %d)" % (label, seed))
        what = "%d doors shuffled; " % (sum(1 for e in f.ends if e["mode"] & bit) // 2) if bit else ""
        print("seed check, %s: %s10 seeds made in %d tries, each played through%s%s"
              % (label, what, tries, ", no chip behind a portal it opens" if chips and not bit else "",
                 ", %d with an ability or key at tower defense's rewards" % at_td if td else ""))
    return f, bp, hv


def chip_check(rows, items, placed, label):
    """a seed's Program Chips (Chip Randomizer), the game's own doors: none behind a portal it opens (in the rooms past it:
    its Access Gate's, or its Nightmare Gate's, by their names' start). It couldn't be got to: the logic already keeps it
    out, this says so plainly. (With Entrance Rando a gate's rooms can be got into another way: the seed's playthrough
    says it can be finished)"""
    behind = collections.defaultdict(set)
    for room, x, y, g, to in portal_chips(): behind[g].add(to[:to.index("_") + 1])
    for lay, loc, k in placed:
        kind, g = items[k]
        if kind == "CHIP" and any(room.startswith(p) for room in rows[loc]["rooms"] for p in behind[g]):
            raise SystemExit("%s: Program Chip %d placed behind a portal it opens (%s)" % (label, g, rows[loc]["rooms"][0]))


def skip_td_rows(rows):
    """the locations as the new game's option Skip Tower Defense has them: tower defense's rewards needing what the room
    logic has getting to them need (req_td) instead of everything (the mod's rndSkipTDApply)"""
    return [dict(r, req=r["req_td"]) if r.get("req_td") is not None else r for r in rows]


def fill_playthrough(rows, items, placed, chips):
    """fill_check's placement played through with the locations' logic: from nothing (but the chips with Chip
    Randomizer off), every progression item at a location the items so far reach taken, over and over; all of them got"""
    at = {loc: items[k] for lay, loc, k in placed}
    total = collections.Counter(prog_of(it) for it in at.values())
    have = collections.Counter(chips_had(chips))
    have[AIR_IX] = PMAX[AIR_IX]     # (as fill_check has them)
    got = set()
    while True:
        all_had = all(have[ix] >= n for ix, n in total.items())
        new = [loc for loc in at if loc not in got and reaches(rows[loc]["req"], have, all_had)]
        if not new: break
        for loc in new:
            got.add(loc); have[prog_of(at[loc])] += 1
    return len(got) == len(at)


# ---------------------------------------------------------------- Archipelago
# The DT3+ world (archipelago\dt3plus): its data (data.py, written here from the same locations, items and logic as the
# mod's), its logic for a shuffled layout (its options Entrance Rando, Boss Rando and Instrument Randomization: the room
# logic's tables, erdata.json, and erlogic.py, roomlogic\erflat.py's own code copied) and the packed world,
# dt3plus.apworld, in the build's archipelago folder. Ids: a location's AP_BASE + type*1000 + objectNum, an item's
# AP_BASE + kind*10000 + parameter (the mod's rndApBase works them out the same way)
AP_GAME = "DT3+"
AP_VERSION = 7   # (6: the trap items; 7: the Wind Orb Trap, and how long the traps last)
AP_BASE = 4454000
AP_DIR = os.path.join(HERE, "archipelago", "dt3plus")
AP_SPRITE = "sRndAPItem"
AP_WEAPONS = ["Master Sword", "Bow & Arrow", "Fuse Bomb", "Hair Whip", "Dagger", "Holy Water", "X-Buster", "Shotgun Ice",
              "Gravity Well", "Arm Cannon", "Missile", "Morph Bomb"]
AP_SETS = ["Mario Ability Set", "Progressive Link", "Progressive Belmont", "Progressive Mega Man", "Progressive Samus",
           "Progressive Jerry Game Powers", "Progressive Claire Game Powers"]
# the progression items the logic counts, in PROG's order (keys aside; the cursed equipment is three items of its own,
# CURSED_GEAR, which a trial's place needs)
AP_PROG = ["Jump", "Dash", "Air Dash", "Double Jump", "Progressive High Jump Boots"] + AP_SETS + ["Varia Suit"]
AP_SIMPLE = {"HP": "Heart Piece", "AQ": "Arrow Quiver", "HE": "Heart Energy Expansion", "MP": "Missile Expansion",
             "GP": "Game Power", "AU": "Air Upgrade", "WB": "Internetz Mod", "AP": "Skill Point", "LB": "Bomb Upgrade",
             "MB": "Morph Bomb Upgrade", "HC": "Heart Container", "XF": "Item Finder", "XC": "X-Special Charge",
             "XS": "Spring Ball", "GDASH": "Dash", "ADASH": "Air Dash", "DJUMP": "Double Jump",
             "HIJUMP": "Progressive High Jump Boots", "VARIA": "Varia Suit"}
AP_CURSED = (10, 11, 12)  # the cursed equipment the Trial Master's trials need on


def equipment_names():
    """equipmentInit's names of the equipment (its list 2), by number"""
    t = read(os.path.join(PROJ, "scripts", "equipmentInit.gml"))
    t = t[t.find("tItemList=2"):]
    return {int(m.group(1)): m.group(2) for m in re.finditer(r'tItemIndex=(\d+)\s*\{\s*equipCheck\[1\]="([^"]*)"', t)}


def ap_sprite(folder):
    """the mod's sprite for another world's item, 16x16: six coloured orbs in a ring, outlined. Returns its bounds as
    sprite_bounds does"""
    sys.path.insert(0, os.path.dirname(HERE))
    import math, png
    cols = [(232, 72, 85), (245, 152, 66), (240, 220, 80), (95, 200, 95), (80, 140, 235), (175, 105, 225)]
    centres = [(7.5 + 4.6 * math.cos(math.radians(-90 + 60 * k)), 7.5 + 4.6 * math.sin(math.radians(-90 + 60 * k))) for k in range(6)]
    rows = []
    for y in range(16):
        row = bytearray(16 * 4)
        for x in range(16):
            px = None
            for (cx, cy), col in zip(centres, cols):
                d = math.hypot(x - cx, y - cy)
                if d <= 2.1: px = col + (255,); break
                if d <= 3.0 and px is None: px = (24, 24, 32, 255)
            if px: row[x * 4:x * 4 + 4] = bytes(px)
        rows.append(row)
    os.makedirs(folder, exist_ok=True)
    png.write(os.path.join(folder, AP_SPRITE + ".png"), 16, 16, rows)
    with open(os.path.join(folder, AP_SPRITE + ".ini"), "w", encoding="utf-8", newline="\n") as f:
        f.write("[sprite]\nframes=1\nxorig=0\nyorig=0\ntransparent=0\nsmooth=0\nsepmasks=0\nbboxmode=0\nleft=0\ntop=0\n"
                "right=15\nbottom=15\nkind=0\ntolerance=0\n")
    xs = [x for y, r in enumerate(rows) for x in range(16) if r[x * 4 + 3]]
    ys = [y for y, r in enumerate(rows) for x in range(16) if r[x * 4 + 3]]
    return [(min(xs), min(ys), max(xs), max(ys))]


def instrument_names():
    """the instruments' names, 1-8, as the mod's rndItemNameKP has them (its kind 26)"""
    t = read(os.path.join(HERE, "mod", "scripts", "rndItemNameKP.gml"))
    t = t[t.index("case 26:"):]
    names = re.findall(r'return "([^"]+)"', t[:t.index("case 24:")])
    if len(names) != 8: raise SystemExit("rndItemNameKP: %d instrument names, not 8" % len(names))
    return names


# the room logic's code the world runs for a shuffled layout (roomlogic\erflat.py's, copied into erlogic.py) and the
# tables it takes (erdata.json: the Flat's lists, as the mod's data\rndER.txt has them)
AP_ER_CODE = ("Reach", "fy", "grow", "shuffle", "br_shuffle", "everything_ok")
AP_ER_TABLES = ["gmult", "gvals", "scoped", "start_gs", "gs_n", "KEY_BASE", "EV_BASE", "room_area", "room_carried",
                "room_resets", "room_scope", "room_boss", "entries", "entry_ways", "way_st", "way_rows", "row_kind",
                "row_target", "row_leave", "row_alts", "alt_first", "alt_count", "req_ix", "req_c", "exit_dest", "exit_sg",
                "exit_sdest", "exit_extra", "exit_end", "ev_ways", "goal_ev", "goal_rooms", "ends", "start", "loc_n",
                "ev_outs", "ev_locs", "boss_n", "boss_req", "boss_shuf", "room_slot", "exit_slot", "room_gate",
                "CHIP_BASE", "digest", "end_names", "follow_list", "akey_n"]
AP_ER_HEAD = '''"""
The Randomizer's room logic for a shuffled layout (the options Entrance Rando, Boss Rando and Instrument Randomization):
what a set of items reaches from the start with the doors and the bosses as shuffled (Reach), and the shuffles (shuffle,
br_shuffle, everything_ok). Copied by tools/modkit/randomizer/rndgen.py from roomlogic/erflat.py, where they're the
mod's own (its rndERReach scripts, rndERShuffle, rndBRShuffle, rndEREverything): change erflat.py, not this. The tables
are erdata.json (load)
"""
import collections

DOOR_CLASSES = %r
MODE_BITS = %r


class Flat:
    pass


def load(data):
    """the tables (erdata.json, read) as erflat's Flat"""
    f = Flat()
    for k, v in data.items():
        setattr(f, k, v)
    f.base_places = set(f.base_places)
    f.hv = {ix: n for ix, n in f.hv}
    return f
'''


def screen_names():
    """{room: its screen's name}, as the Check Tracker has them (tracker_names.txt)"""
    import tracker
    return {room: scr for room, (tab, scr) in tracker.read_names()[0].items()}


def place_of(r, anames, screen_of):
    """where a location is (the multiworld's location names, the mod's vending machine hints): its area's name and its
    screen's as the Check Tracker has it ("Access Gate 3: Transylvania - Castle Courtyard 1"), the screen's alone when
    it says the area already ("Central City - North 2", "Mountain Temple 1" in Begonia - Mountain Temple); a room the
    names file doesn't have, its area's"""
    a = r["area"]
    where = anames.get(a) if a else None
    scr = screen_of.get(r["rooms"][0])
    if not scr: return where or r["rooms"][0]
    if not where: return scr
    base = re.sub(r"\s+\d+$", "", scr.split(":")[0]).lower()
    if scr.lower().startswith(where.lower()) or re.search(r"\b%s\b" % re.escape(base), where.lower()): return scr
    return "%s - %s" % (where, scr)


def key_names_of(door_order, doors, anames, rarea):
    """the keys' names (the multiworld's items, the mod's hints), by door: "Key: " and the door's area, numbered where an
    area has several"""
    door_area_name = {d: anames.get(rarea.get(sorted(doors[d])[0]), sorted(doors[d])[0]) for d in door_order}
    out = {}
    for d in door_order:
        same = [e for e in door_order if door_area_name[e] == door_area_name[d]]
        out[d] = "Key: " + door_area_name[d] + (" %d" % (same.index(d) + 1) if len(same) > 1 else "")
    return out


def ap_export(rows, items, door_order, doors, rarea, anames, out, f, bp, hv, blist):
    """the DT3+ world: data.py, erlogic.py and erdata.json in archipelago\\dt3plus (from the locations and items, the
    room logic's tables f with the places the game's own doors reach with everything bp and everything's numbers hv,
    and the boss list), and the packed world in the build"""
    import zipfile, json, inspect
    sys.path.insert(0, os.path.join(HERE, "roomlogic"))
    import erflat
    equip = equipment_names()
    all_rows = rows
    # (the Nightmare Gates' rewards and the instruments: the world's only with its option Instrument Randomization; else
    # each gate's reward is its own instrument)
    rows = [r for r in rows if r["type"] != INSTR_TYPE]
    items = [it for it in items if it[0] != "INSTR"]
    key_names = key_names_of(door_order, doors, anames, rarea)

    def name_of(kind, p):
        if kind in AP_SIMPLE: return AP_SIMPLE[kind]
        if kind in ("MONEY", "MONEYX"): return "%d Internetz" % (MONEY_MUL * p)
        if kind == "NM": return "Nightmare " + NIGHTMARE[p]
        if kind == "EQUIP": return equip.get(p, "Equipment %d" % p)
        if kind == "WL": return "Weapon Upgrade: " + AP_WEAPONS[p]
        if kind == "KEY": return key_names[p]
        if kind == "SET": return AP_SETS[p]
        if kind == "SNARE": return SNARE_TYPES[p - 1] + " Trap"
        raise SystemExit("no Archipelago name for item %s %s" % (kind, p))

    def classification(kind, p):
        if kind in ("GDASH", "ADASH", "DJUMP", "HIJUMP", "SET", "KEY", "VARIA", "AU"): return 1  # progression
        if kind == "EQUIP" and p in AP_CURSED: return 1
        if kind in ("MONEY", "MONEYX"): return 0                                           # filler
        return 2                                                                           # useful

    ap_items = collections.OrderedDict()
    for kind, p in items:
        if kind == "NM": continue   # (the Nightmare abilities: placed at the story's places, NIGHTMARE below)
        n = name_of(kind, p)
        iid = AP_BASE + IK[kind] * 10000 + p
        if n in ap_items:
            if ap_items[n][0] != iid: raise SystemExit("two items named %r" % n)
            ap_items[n][2] += 1
        else:
            ap_items[n] = [iid, classification(kind, p), 1]
    money = sorted(p for kind, p in items if kind == "MONEY")
    filler = name_of("MONEY", money[0]) if money else "Heart Piece"
    cursed = [equip[p] for p in AP_CURSED]
    for c in cursed:
        if c not in ap_items: raise SystemExit("the cursed equipment %r isn't in the pool" % c)

    # the Program Chips (Chip Randomizer): items of their own, chip N opening Access Gate N's portal and the Nightmare
    # Gate portal beside it, in the pool in the place of the Internetz items chip_slots names (their names: chip_money);
    # off, the logic counts them as had
    chip_names = {g: "Program Chip %d" % g for g in CHIP_GATES}
    chips = collections.OrderedDict((chip_names[g], AP_BASE + IK["CHIP"] * 10000 + g) for g in CHIP_GATES)
    chip_money = [name_of("MONEY", items[i][1]) for g, i in sorted(chip_slots(items).items())]
    # the trap items (the option traps): items of their own (classification trap), in the pool in the place of the
    # Internetz items snare_slots names (trap_money), each the trap trap_items has for it
    traps = collections.OrderedDict((name_of("SNARE", t), AP_BASE + IK["SNARE"] * 10000 + t)
                                    for t in range(1, len(SNARE_TYPES) + 1))
    trap_money = [name_of("MONEY", items[i][1]) for i, t in snare_slots(items)]
    trap_items = [name_of("SNARE", t) for i, t in snare_slots(items)]

    def ap_need(ix):
        if ix > KEY_BASE + solve.CHIP_KEY: return chip_names[ix - KEY_BASE - solve.CHIP_KEY]
        if ix == AIR_IX: return AP_SIMPLE["AU"]
        return key_names[ix - KEY_BASE] if ix >= KEY_BASE else AP_PROG[ix]

    # (a location's name, what the multiworld's hints say: where it is, place_of, and its type and number)
    screen_of = screen_names()

    def loc_name(r):
        if r["type"] == INSTR_TYPE: return "Nightmare Gate %s - Reward" % "ABCDEFGH"[r["num"] - 1]
        where = place_of(r, anames, screen_of)
        if r["type"] == STORY_TYPE: return "%s - %s %d (%s)" % (where, LT_LABEL[r["type"]], r["num"], r["story"])
        return "%s - %s %d" % (where, LT_LABEL[r["type"]], r["num"])

    ap_locs = collections.OrderedDict()
    for r in rows:
        n = loc_name(r)
        if n in ap_locs: raise SystemExit("two locations named %r" % n)
        # (the cursed equipment a trial's place needs: CURSED_GEAR, by its trial flag)
        need = None if r["req"] is EVERYTHING else [[(ap_need(ix), c) for ix, c in sorted(alt.items()) if ix != CURSED_IX] for alt in r["req"]]
        ap_locs[n] = (AP_BASE + r["type"] * 1000 + r["num"], need, bool(r.get("trial")))
    # Skip Tower Defense (the option skip_tower_defense): tower defense's rewards and what each needs with it on, the room
    # logic's (req_td), as ap_locs has a requirement; off, they need everything (ap_locs' None)
    tower = collections.OrderedDict()
    for r in rows:
        if r.get("req_td") is not None and r["req_td"] is not EVERYTHING:
            tower[loc_name(r)] = [[(ap_need(ix), c) for ix, c in sorted(alt.items()) if ix != CURSED_IX] for alt in r["req_td"]]
    everything = [(AP_PROG[p], PMAX[p]) for p in range(1, VARIA_IX + 1) if PMAX[p]] + [(c, 1) for c in cursed] + \
                 [(AP_SIMPLE["AU"], PMAX[AIR_IX])] + [(key_names[d], 1) for d in door_order]
    # Instrument Randomization: the instruments (kind INSTR, the gate's number) and the gates' rewards (location type 18)
    instr = collections.OrderedDict((n, AP_BASE + IK["INSTR"] * 10000 + g) for g, n in enumerate(instrument_names(), 1))
    gate_rewards = collections.OrderedDict((loc_name(r), AP_BASE + r["type"] * 1000 + r["num"]) for r in all_rows
                                           if r["type"] == INSTR_TYPE)
    # the Nightmare abilities (useful items, NIGHTMARE): the world puts each at one of the story's ability pickups
    # (location type 19) the logic reaches, as the mod's rndGenerate does
    nightmare = collections.OrderedDict((name_of("NM", p), AP_BASE + IK["NM"] * 10000 + p) for p in range(len(NIGHTMARE)))
    story_locs = [loc_name(r) for r in rows if r["type"] == STORY_TYPE and r["req"] is not EVERYTHING]
    if len(story_locs) < len(nightmare): raise SystemExit("fewer story places the logic reaches than Nightmare abilities")
    for n in list(instr) + list(gate_rewards) + list(chips) + list(nightmare) + list(traps):
        if n in ap_items or n in ap_locs: raise SystemExit("an item or location named %r already" % n)
    # what the room logic's requirement numbers count, as items (erlogic's Reach: an ability or set's items, the Varia
    # Suit, the three cursed equipment pieces, the instruments, the Air Upgrades, a door's key)
    req_items = collections.OrderedDict((ix, [AP_PROG[ix]]) for ix in range(1, VARIA_IX + 1))
    req_items[CURSED_IX] = cursed
    req_items[INSTR_IX] = list(instr)
    req_items[AIR_IX] = [AP_SIMPLE["AU"]]
    for d in door_order: req_items[KEY_BASE + d] = [key_names[d]]
    for g in CHIP_GATES: req_items[KEY_BASE + solve.CHIP_KEY + g] = [chip_names[g]]
    # the bosses (Boss Rando): each one's name and place (as the spoiler log names them), and their types as the mod
    # checks them (rndBRString(1): two digits each)
    boss_places = [("the way from %s to %s" % BOSS_VIA[t]) if t in BOSS_VIA else room for t, room, bx, by, name in blist]
    boss_types = "".join("%02d" % t for t, room, bx, by, name in blist)

    L = ['"""DT3+ Archipelago data, made by tools/modkit/randomizer/rndgen.py from the game (change rndgen.py, not this)"""',
         "GAME = %r" % AP_GAME,
         "VERSION = %d" % AP_VERSION,
         "BASE_ID = %d" % AP_BASE,
         "# the progression items the logic counts (a new game starts with jumping)",
         "PROG_ITEMS = %r" % AP_PROG[1:],
         "SET_ITEMS = %r" % AP_SETS,
         "# the ability sets with an attack (Guarantee Early Weapons)",
         "WEAPON_SETS = %r" % AP_SETS[1:5],
         "# the keys, each its own door's",
         "DOOR_KEYS = %r" % [key_names[d] for d in door_order],
         "# what the Trial Master's trials need on",
         "CURSED_GEAR = %r" % cursed,
         "FILLER = %r" % filler,
         "# every progression item: what a location the logic doesn't reach needs, and the win (with Instrument",
         "# Randomization, the instruments too; with Chip Randomizer, the Program Chips)",
         "EVERYTHING = %r" % everything,
         "VICTORY_LOCATION = 'Defeat the CHAOS Warmaster'",
         "# name: (id, classification (0 filler, 1 progression, 2 useful), how many in the pool)",
         "ITEMS = {"]
    L += ["    %r: (%d, %d, %d)," % (n, v[0], v[1], v[2]) for n, v in ap_items.items()]
    L += ["}",
          "# name: (id, what it needs: alternatives, each [(item, count)], any one of which is enough (None: EVERYTHING),",
          "#        a Trial Master trial's (needs CURSED_GEAR too)). What they need with the game's own layout: a shuffled",
          "#        one's logic is the room logic's (erlogic.py)",
          "LOCATIONS = {"]
    L += ["    %r: (%d, %r, %r)," % (n, v[0], v[1], v[2]) for n, v in ap_locs.items()]
    L += ["}",
          "# Skip Tower Defense (the option skip_tower_defense): tower defense's rewards, there from the start, and what each",
          "# needs then (as LOCATIONS has it); without it they need EVERYTHING",
          "TOWER_DEFENSE = %r" % dict(tower),
          "# Instrument Randomization: the instruments (progression items) and the Nightmare Gates' rewards (locations",
          "# that need EVERYTHING: a fight's reward), name: id",
          "INSTRUMENTS = %r" % dict(instr),
          "GATE_REWARDS = %r" % dict(gate_rewards),
          "# Chip Randomizer: the Program Chips (progression items: chip N opens Access Gate N's portal and the Nightmare",
          "# Gate portal beside it), name: id, and the Internetz items they take the place of in the pool. Off: they aren't",
          "# items, and the logic counts them as had from the start",
          "CHIPS = %r" % dict(chips),
          "CHIP_MONEY = %r" % chip_money,
          "# Traps: the trap items (classification trap: each springs a trap on the player who gets it), name: id, the",
          "# Internetz items they take the place of in the pool, and the trap each of those is",
          "TRAPS = %r" % dict(traps),
          "TRAP_MONEY = %r" % trap_money,
          "TRAP_ITEMS = %r" % trap_items,
          "# the Nightmare abilities (useful items), name: id, each placed at one of these story places (location type 19:",
          "# where the story's ability pickups were) the logic reaches",
          "NIGHTMARE = %r" % dict(nightmare),
          "STORY_LOCATIONS = %r" % story_locs,
          "# the mod's location numbers (the room logic's places): each one's location",
          "ROW_NAMES = %r" % [loc_name(r) for r in all_rows],
          "# the room logic's requirement numbers: the items each counts",
          "REQ_ITEMS = %r" % dict(req_items),
          "# Entrance Rando: the room logic data's hash (the mod's data\\rndER.txt has the same: rndEHash)",
          "ER_HASH = %r" % f.digest,
          "# Boss Rando: the mod's bosses' names, places and types (rndBRString(1))",
          "BOSS_NAMES = %r" % [name for t, room, bx, by, name in blist],
          "BOSS_PLACES = %r" % boss_places,
          "BOSS_TYPES = %r" % boss_types]
    with open(os.path.join(AP_DIR, "data.py"), "w", encoding="utf-8", newline="\n") as fh:
        fh.write("\n".join(L) + "\n")
    # the room logic for a shuffled layout: erflat's code and its tables
    code = AP_ER_HEAD % (erflat.DOOR_CLASSES, erflat.MODE_BITS) + "".join("\n\n" + inspect.getsource(getattr(erflat, n)) for n in AP_ER_CODE)
    with open(os.path.join(AP_DIR, "erlogic.py"), "w", encoding="utf-8", newline="\n") as fh:
        fh.write(code)
    tables = {k: getattr(f, k) for k in AP_ER_TABLES}
    tables["base_places"] = sorted(bp)
    tables["hv"] = sorted(hv.items())
    with open(os.path.join(AP_DIR, "erdata.json"), "w", encoding="utf-8", newline="\n") as fh:
        json.dump(tables, fh, separators=(",", ":"))
    # (the doors' ends and the bosses as the mod has them: the shuffles the world makes are put in the game by number)
    if len(f.ends) > 9998 or len(blist) > 99 or any(t > 99 for t, room, bx, by, name in blist):
        raise SystemExit("Archipelago: the doors' ends or the bosses don't fit the mod's strings (rndERString, rndBRString)")

    # the packed world: a zip with the dt3plus folder in it
    os.makedirs(os.path.join(out, "archipelago"), exist_ok=True)
    dest = os.path.join(out, "archipelago", "dt3plus.apworld")
    with zipfile.ZipFile(dest, "w", zipfile.ZIP_DEFLATED) as z:
        for root, ds, fs in os.walk(AP_DIR):
            ds[:] = [d for d in ds if d != "__pycache__"]
            for fn in sorted(fs):
                if fn.endswith((".pyc", ".tmp")): continue
                p = os.path.join(root, fn)
                z.write(p, os.path.join("dt3plus", os.path.relpath(p, AP_DIR)).replace("\\", "/"))
    print("Archipelago: %d locations (and %d with Instrument Randomization), %d items in %d kinds (filler %r), %s"
          % (len(ap_locs), len(gate_rewards), len(items), len(ap_items), filler, dest))


def prog_of(item, ir=False):
    """an item's progression number (rndProgOf: 1-11 an ability or set, 12 the Varia Suit, 13 a cursed equipment piece,
    14 an instrument with Instrument Randomization (ir; else it stays at its gate's reward, not placed), 15 an Air
    Upgrade, KEY_BASE+objectNum a door's key), or -1"""
    k, p = item
    if k in ("JUMP", "GDASH", "ADASH", "DJUMP", "HIJUMP"): return ["JUMP", "GDASH", "ADASH", "DJUMP", "HIJUMP"].index(k)
    if k == "SET": return 5 + p
    if k == "VARIA": return VARIA_IX
    if k == "EQUIP" and p in CURSED: return CURSED_IX
    if k == "INSTR": return INSTR_IX if ir else -1
    if k == "AU": return AIR_IX
    if k == "KEY": return KEY_BASE + p
    if k == "CHIP": return KEY_BASE + solve.CHIP_KEY + p
    return -1


def chip_slots(items):
    """the items that are the Program Chips with Chip Randomizer on: the six smallest Internetz (money) items, by
    amount, then place in the list; {gate: item index}"""
    money = sorted((p, i) for i, (k, p) in enumerate(items) if k == "MONEY")
    if len(money) < len(CHIP_GATES): raise SystemExit("fewer Internetz chests than Program Chips")
    return {g: money[n][1] for n, g in enumerate(CHIP_GATES)}


def snare_slots(items):
    """the items that are trap items with Traps on: SNARE_EACH of each of SNARE_TYPES, the smallest Internetz (money)
    items after chip_slots' six (by amount, then place in the list), each one the next trap; [(item index, trap number)]"""
    money = sorted((p, i) for i, (k, p) in enumerate(items) if k == "MONEY")
    n = SNARE_EACH * len(SNARE_TYPES)
    free = money[len(CHIP_GATES):]
    if len(free) < n: raise SystemExit("fewer Internetz chests than trap items: %d, %d traps" % (len(free), n))
    return [(i, k % len(SNARE_TYPES) + 1) for k, (p, i) in enumerate(free[:n])]


def snare_slots_old(items):
    """the trap items of the builds before the Wind Orb (their saves'): SNARE_SHARE_OLD of the items (the instruments
    not counted), the same Internetz items snare_slots takes from, each one the next of the first SNARE_TYPES_OLD traps"""
    money = sorted((p, i) for i, (k, p) in enumerate(items) if k == "MONEY")
    n = int(round(len([it for it in items if it[0] != "INSTR"]) * SNARE_SHARE_OLD))
    free = money[len(CHIP_GATES):]
    return [(i, k % SNARE_TYPES_OLD + 1) for k, (p, i) in enumerate(free[:n])]


def items_with_chips(items, chips):
    """the items as a new game has them: with Chip Randomizer on (chips), the Program Chips in chip_slots' places"""
    if not chips: return items
    out = list(items)
    for g, i in chip_slots(items).items(): out[i] = ("CHIP", g)
    return out


def chips_had(chips):
    """what the logic counts the player having from the start: the Program Chips, with Chip Randomizer off"""
    return {} if chips else {KEY_BASE + solve.CHIP_KEY + g: 1 for g in CHIP_GATES}


# rndGenerate's layers: each progression item goes to a free location the items placed before it reach, in the newest
# layer (what the last item opened) with this chance, else the one before with it, and so on. The new game's options
# (oRndOptions) choose it: Ability Spread Near, Normal, Far
SPREAD = (0.3, 0.7, 1.0)
NEWEST = SPREAD[1]
# the weapons (the ability sets with an attack, the room logic's "attack": Link, Belmont, Mega Man, Samus). With the
# option Guarantee Early Weapons, every layer gets one while there are any left: the first item placed in a new layer
WEAPONS = (6, 7, 8, 9)
# the movement abilities (the dash, the air dash, the double jump, the High Jump Boots: the first of each kind) come apart:
# each waits for its turn, a place in the order of placing at random between these shares of the progression items (in
# percent: first, second, third, fourth), while another item opens something, and at its turn is the one placed if one
# opens something (which kind: at random, each alike). The second High Jump Boots go as any item
MOVE = (1, 2, 3, 4)
MOVE_AT = ((0, 12), (17, 37), (30, 50), (50, 70))
ALT_STRIDE = 40   # (rndLocAltIx/rndLocAltC: an alternative's entries are a*ALT_STRIDE+j)
# Internetz: an Internetz item (kind MONEY, its parameter the chest's amount, as the game has it) gives this many times
# its amount (the mod's rndMoneyOf, global.rndMoneyMul), and is named so ("2000 Internetz": here, the mod's
# rndItemNameKP). The parameter stays the chest's amount: the Archipelago world's item ids are kind*10000+parameter,
# which a chest's 7000 twice would overflow, and a world made before still gives its items by them
MONEY_MUL = 2


def reaches(req, have, all_had):
    if req is EVERYTHING: return all_had
    return any(all(have[ix] >= c for ix, c in alt.items()) for alt in req)


def fill_check(rows, items, seed, door_order, weapons=False, newest=NEWEST, chips=False):
    """rndGenerate's placement in Python (the same steps, Python's random numbers): the progression items one at a time,
    each one that opens a location the items so far don't reach if there is one (else any; a kind that opens fewer is
    likelier; a movement ability at its turn, MOVE_AT), at a free location they reach, by layer. weapons: Guarantee
    Early Weapons (a new layer's first item is a
    weapon); newest: Ability Spread's chance; chips: Chip Randomizer (items: items_with_chips'; else the Program Chips
    are had from the start). Returns [(layer, location, item)] for the items, or None when one had nowhere to go"""
    import random
    rnd = random.Random(seed)
    # (the Air Upgrades: placed with the rest of the items, and counted as had, as the mod does without the room logic's
    # data, which can't count the ones at places it's got to)
    prog = [i for i, it in enumerate(items) if prog_of(it) > 0 and prog_of(it) != AIR_IX]
    rnd.shuffle(prog)
    total = collections.Counter(prog_of(items[i]) for i in prog)
    have = collections.Counter(chips_had(chips))
    have[AIR_IX] = PMAX[AIR_IX]
    layer = [-1] * len(rows)
    filled = [False] * len(rows)
    # (the Nightmare abilities first, each at one of the story's places the logic reaches: rndGenerate)
    story = [i for i, r in enumerate(rows) if r["type"] == STORY_TYPE and r["req"] is not EVERYTHING]
    for _ in range(min(sum(1 for k, p in items if k == "NM"), len(story))):
        filled[story.pop(int(rnd.random() * len(story)))] = True
    armed = set()   # the layers with a weapon
    cur = 0

    def mark(lay):
        all_had = all(have[ix] >= n for ix, n in total.items())
        new = 0
        for i, r in enumerate(rows):
            if layer[i] < 0 and reaches(r["req"], have, all_had): layer[i] = lay; new += 1
        return new
    mark(0)
    placed = []
    remaining = list(prog)
    # (the movement abilities' turns: MOVE_AT)
    n = len(prog)
    move_at = [n * lo // 100 + int(rnd.random() * (n * hi // 100 - n * lo // 100 + 1)) for lo, hi in MOVE_AT]
    moved = set()
    while remaining:
        useful = collections.Counter()
        for i, r in enumerate(rows):
            if layer[i] >= 0 or r["req"] is EVERYTHING: continue
            for alt in r["req"]:
                short = [ix for ix, c in alt.items() if have[ix] < c]
                if len(short) == 1 and alt[short[0]] - have[short[0]] == 1: useful[short[0]] += 1
        pool = remaining
        force = False
        if weapons and cur not in armed and any(not filled[i] for i in range(len(rows)) if layer[i] == cur):
            pool = [k for k in remaining if prog_of(items[k]) in WEAPONS]
            if pool: force = True
            else: pool = remaining
        # (a movement ability waits for its turn, and is the one placed at it: as rndGenerate has it)
        mforce = False
        if not force and len(moved) < len(move_at):
            wait = [k for k in pool if prog_of(items[k]) in MOVE and prog_of(items[k]) not in moved]
            rest = [k for k in pool if k not in wait]
            if len(placed) < move_at[len(moved)]:
                if rest and (any(useful[prog_of(items[k])] > 0 for k in rest) or
                             sum(1 for i in range(len(rows)) if layer[i] >= 0 and not filled[i]) > move_at[len(moved)] - len(placed)):
                    pool = rest
            elif any(useful[prog_of(items[k])] > 0 for k in wait):
                mforce = True
                pool = wait
        cand = [k for k in pool if useful[prog_of(items[k])] > 0]
        if cand:
            kinds = sorted(set(prog_of(items[c]) for c in cand))
            weight = {ix: 1.0 if mforce else 1.0 / useful[ix] for ix in kinds}
            r = rnd.random() * sum(weight[ix] for ix in kinds)
            kind = kinds[-1]
            for ix in kinds:
                r -= weight[ix]
                if r <= 0: kind = ix; break
            cand = [c for c in cand if prog_of(items[c]) == kind]
        else:
            cand = list(pool)
        k = rnd.choice(cand)
        if prog_of(items[k]) in MOVE: moved.add(prog_of(items[k]))
        if force:
            pick = cur
        else:
            layers = sorted({layer[i] for i in range(len(rows)) if layer[i] >= 0 and not filled[i]}, reverse=True)
            if not layers: return None
            pick = layers[-1]
            for lay in layers:
                if rnd.random() < newest: pick = lay; break
        loc = rnd.choice([i for i in range(len(rows)) if layer[i] == pick and not filled[i]])
        filled[loc] = True
        placed.append((pick, loc, k))
        if prog_of(items[k]) in WEAPONS: armed.add(pick)
        remaining.remove(k)
        have[prog_of(items[k])] += 1
        if mark(cur + 1): cur += 1
    return placed


def alt_text(alt):
    if not alt: return "nothing"
    names = {v: k for k, v in LOGIC_NAMES.items()}
    out = []
    for ix, c in sorted(alt.items()):
        if ix > KEY_BASE + solve.CHIP_KEY: out.append("chip %d" % (ix - KEY_BASE - solve.CHIP_KEY))
        elif ix >= KEY_BASE: out.append("key %d" % (ix - KEY_BASE))
        elif PMAX[ix] == 1: out.append(names[ix])
        else: out.append("%s %d" % (names[ix], c))
    return " ".join(out)


def req_text(req):
    return "everything" if req is EVERYTHING else " | ".join(alt_text(a) for a in req)


def read_roomlogic():
    """{(type, number): alternatives} from the room logic: roomlogic\\solve.py joins each room's logic (roomlogic\\rooms\\),
    the connections and the hand-made changes (roomlogic\\overrides.txt), and writes roomlogic\\roomlogic.txt. A place it
    doesn't reach needs EVERYTHING"""
    rl = os.path.join(HERE, "roomlogic")
    if not os.path.isdir(os.path.join(rl, "rooms")):
        raise SystemExit("roomlogic\\rooms isn't there: run roomlogic\\roomlogic.py first (see roomlogic\\README.txt)")
    sys.path.insert(0, rl)
    import solve
    out = {}
    for key, alts in solve.solve_all().items():
        conv = []
        for a in alts:
            if a.o: continue   # (a way only with an option on: the mod has no such options yet)
            alt = {LOGIC_NAMES[solve.ITEMS[i]]: n for i, n in enumerate(a.c) if n}
            for k in a.k: alt[KEY_BASE + k] = 1
            conv.append(alt)
        out[key] = conv if conv else EVERYTHING
    return out


def read_out_of_logic():
    """{(type, number): why}: the places roomlogic\\overrides.txt puts out of logic (its outoflogic lines)"""
    sys.path.insert(0, os.path.join(HERE, "roomlogic"))
    import solve
    return solve.out_of_logic()


def read_logic():
    """logic.txt: '<location type> <number>: <requirements>' or 'room <room>: <requirements>', replacing the room
    logic's. Requirements: alternatives separated by |, each the items it takes (djump, samus 4, key 3: a door's key by
    its objectNum), 'nothing' or 'everything'"""
    labels = {l.lower(): c for c, l in LT_LABEL.items()}
    over, room_over = {}, {}
    p = os.path.join(HERE, "logic.txt")
    if not os.path.exists(p): return over, room_over
    for ln, line in enumerate(open(p, encoding="utf-8"), 1):
        line = line.split("#", 1)[0].strip()
        if not line: continue
        if ":" not in line: raise SystemExit("logic.txt line %d: no ':'" % ln)
        what, req = [s.strip() for s in line.split(":", 1)]
        if req.strip().lower() == "everything":
            r = EVERYTHING
        else:
            r = []
            for part in req.split("|"):
                alt = {}
                toks = part.replace(",", " ").split()
                i = 0
                while i < len(toks):
                    t = toks[i].lower()
                    if t == "nothing": i += 1; continue
                    cnt = 1
                    if i + 1 < len(toks) and toks[i + 1].isdigit(): cnt = int(toks[i + 1]); i += 1
                    if t == "key": alt[KEY_BASE + cnt] = 1
                    elif t == "chip": alt[KEY_BASE + solve.CHIP_KEY + cnt] = 1
                    elif t in LOGIC_NAMES: alt[LOGIC_NAMES[t]] = cnt
                    else: raise SystemExit("logic.txt line %d: unknown requirement %r" % (ln, t))
                    i += 1
                r.append(alt)
        if what.lower().startswith("room "):
            room_over[what[5:].strip()] = r
        else:
            m = re.match(r"(.+?)\s+(\d+)$", what)
            if not m or m.group(1).lower() not in labels: raise SystemExit("logic.txt line %d: unknown location %r" % (ln, what))
            over[(labels[m.group(1).lower()], int(m.group(2)))] = r
    return over, room_over


# ---------------------------------------------------------------- world state
#(left as a new game has them: 123iXB tower defense and 123iXC the Trial Master's trials, done again for their rewards;
#129e the shortcuts, opened again; 124 the program chips, 138 the Yoshi dolls and 144 the game completed)
WORLD_KEYS = ["123", "123iA", "123iB", "123iC", "123iD", "123iE", "123iF", "123iG", "123iH", "123iV1", "123iXA",
              "123iXE", "123iXF", "123iXG", "123iXH", "125", "129c", "129g", "134", "134we",
              "136", "140", "141a", "142sg0", "142sg1", "142sg2"]


def save_keys():
    """{save key: (global name, 'real'|'string')} from loadSaveData"""
    t = read(os.path.join(PROJ, "scripts", "loadSaveData.gml"))
    m = {}
    for g, kind, key in re.findall(r"global\.(\w+)=ini_read_(real|string)\(sectionRead,\"(\w+)\"", t):
        m[key] = (g, kind)
    for i in range(3): m["142sg%d" % i] = ("mySegmentCheck[%d]" % i, "real")
    return m


def world_from(save):
    vals = {}
    sec = None
    for line in open(save, encoding="utf-8", errors="replace"):
        line = line.strip()
        if line.startswith("["): sec = line[1:-1]; continue
        if sec == "ALPHA" and "=" in line:
            k, v = line.split("=", 1)
            vals[k] = v
    keys = save_keys()
    with open(os.path.join(HERE, "world.txt"), "w", encoding="utf-8", newline="\n") as f:
        f.write("# the endgame world state the Randomizer starts a game in: save file keys (as loadSaveData reads them) and\n"
                "# their values in a 100%% save (%s), made by rndgen.py --world-from\n" % os.path.basename(save))
        for k in WORLD_KEYS:
            if k in vals: f.write("%s=%s    # global.%s\n" % (k, vals[k], keys.get(k, ("?",))[0]))
    print("world.txt written:", sum(1 for k in WORLD_KEYS if k in vals), "values")


def world_gml():
    keys = save_keys()
    L = ["//The endgame world state (world.txt, from a 100% save), made by tools/modkit/randomizer/rndgen.py"]
    for line in open(os.path.join(HERE, "world.txt"), encoding="utf-8"):
        line = line.split("#", 1)[0].strip()
        if not line: continue
        k, v = [s.strip() for s in line.split("=", 1)]
        g, kind = keys[k]
        L.append("global.%s=%s" % (g, gml_str(v) if kind == "string" else v))
    return "\n".join(L) + "\n"


if __name__ == "__main__":
    main()
