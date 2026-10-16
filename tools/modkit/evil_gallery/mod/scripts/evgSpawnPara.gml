//Evil Boss Gallery: a Paratroopa for Evil Bowser's inferno (in his instance): from the arena's sides in turn (paraSide),
//at its heights in turn (evgParaY: the first in reach of a jump from the top row, the others of a bounce), flying across
//and back till the fire's out (oEvgParatroopa)
var tPara;
paraSide=-paraSide
if paraSide=1 {tPara=instance_create(568,evgParaY[paraNum mod 3],oEvgParatroopa); tPara.flyDir=1}
else {tPara=instance_create(872,evgParaY[paraNum mod 3],oEvgParatroopa); tPara.flyDir=-1}
tPara.baseY=evgParaY[paraNum mod 3]
paraNum+=1
