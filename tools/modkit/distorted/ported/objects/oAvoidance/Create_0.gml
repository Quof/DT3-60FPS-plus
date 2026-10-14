oPlayer1.image_yscale=0.5

sceneProgress=0
sceneDelay=0
var ijk;
for(ijk=0;ijk<5;ijk+=1) {atkTime[ijk]=0}
t=0
sp=0
tempDir=0
bowap=0
bowap_speed=6
bcount=0
bowap_arc=0
stutter=0

start_extra=0.45
start_dist=7.49
beat_d=30/32
dance_beat=0.9356

// top corner left: 80,64; right: 400,64

// ----------------------------------------- song timings in frames double seconds
// start
// specials: 19 - 34
var i;
start[0]=1.1
start[1]=2.03
start[2]=2.74
start[3]=4.37
start[4]=4.86
start[5]=6.27
start[6]=6.54
start[7]=6.96
start[8]=7.23
start[9]=7.66
for(i=0;i<10;i+=1) {start[i+10]=start[i]+start_dist}
for(i=0;i<10;i+=1) {start[i+20]=start[i]+2*start_dist}
for(i=0;i<10;i+=1) {start[i+30]=start[i]+3*start_dist}
// specials 12 - 16 - 26 - 33
start[40]=31.1
for(i=1;i<62;i+=1) {start[i+40]=start[40]+i*beat_d}
// 102: start of BoWaP
start[102]=91
start[103]=98.5 // "arc"
start[104]=106 //stutter start
start[105]=120 //end
start[106]=121.3 // DANCE
for(i=1;i<32;i+=1) {start[i+106]=start[106]+i*dance_beat} //done including 122

for(i=0;i<138;i+=1) {start[i]=round(start[i]*15)} // 15 = *30/2
