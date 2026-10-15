//Randomizer, Archipelago: the DT3+ Client's session.txt: its seed line (global.rndApSession: "seed|<seed>|<slot>"), its
//DeathLink setting (rndApSessDeath), and the DT3+ world's options for a new game (from its slot data): the shops' seed
//(rndApShopSeed) and whether they're shuffled (rndApSessShops), Entrance Rando's mode, door data hash and shuffle
//(rndApSessER, rndApSessERHash, rndApSessERPart: rndERString's), Boss Rando's (rndApSessBR, rndApSessBRFight:
//rndBRString(0)'s, rndApSessBRTypes: rndBRString(1)'s) and Instrument Randomization (rndApSessIR). A session from a
//world before those options has the shops shuffled and none of the rest. Returns 1 when the client is connected to a
//multiworld. (The client and the game trade files in global.rndApPath; tools/modkit/randomizer/archipelago has the
//client, client.py, and what each file holds)
var f,l,n,tConn;
global.rndApSession=""
global.rndApSessShops=1
global.rndApSessER=0
global.rndApSessERHash=""
global.rndApSessERPart=""
global.rndApSessBR=0
global.rndApSessBRFight=""
global.rndApSessBRTypes=""
global.rndApSessIR=0
tConn=0
if !file_exists(global.rndApPath+"session.txt") {return 0}
f=file_text_open_read(global.rndApPath+"session.txt")
while !file_text_eof(f)
{
  l=file_text_read_string(f)
  file_text_readln(f)
  n=rndApSplit(l)
  if n>=2
  {
    if global.rndApPart[0]="seed" {global.rndApSession=l}
    else if global.rndApPart[0]="deathlink" {global.rndApSessDeath=real(global.rndApPart[1])}
    else if global.rndApPart[0]="shopseed" {global.rndApShopSeed=real(global.rndApPart[1])}
    else if global.rndApPart[0]="shops" {global.rndApSessShops=real(global.rndApPart[1])}
    else if global.rndApPart[0]="er" {global.rndApSessER=real(global.rndApPart[1])}
    else if global.rndApPart[0]="erhash" {global.rndApSessERHash=global.rndApPart[1]}
    else if global.rndApPart[0]="erpart" {global.rndApSessERPart=global.rndApPart[1]}
    else if global.rndApPart[0]="br" {global.rndApSessBR=real(global.rndApPart[1])}
    else if global.rndApPart[0]="brfight" {global.rndApSessBRFight=global.rndApPart[1]}
    else if global.rndApPart[0]="brtypes" {global.rndApSessBRTypes=global.rndApPart[1]}
    else if global.rndApPart[0]="ir" {global.rndApSessIR=real(global.rndApPart[1])}
    else if global.rndApPart[0]="connected" {tConn=real(global.rndApPart[1])}
  }
}
file_text_close(f)
if tConn=1 and global.rndApSession!="" {return 1}
return 0
