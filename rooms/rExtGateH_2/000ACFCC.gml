GID_SET(427572, self.id)
type=0

if global.gateHProg>=6 and global.gateHProg<=11 {type=1}
else if global.gateHProg>=12 and global.gateHProg<=13 {type=0}
else if global.gateHProg>=14 {type=1}
