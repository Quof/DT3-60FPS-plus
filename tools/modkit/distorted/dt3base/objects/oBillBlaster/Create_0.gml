bDestroyOnDeactivate=false
detectDistX=240
detectDistY=208
inactiveDist=detectDistX*3
if global.location=91 {shotTime=90}
else {shotTime=60}
shotDelay=95
bVert=0
warnFrm=0
bActive=false
if variable_local_exists("newDDX")
  detectDistX=newDDX
if variable_local_exists("newDDY")
  detectDistY=newDDY
if variable_local_exists("vertical")
  bVert=vertical
