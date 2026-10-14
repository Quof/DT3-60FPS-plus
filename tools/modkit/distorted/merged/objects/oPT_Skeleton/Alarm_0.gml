eName=string("Lv.") +string(rpgLv) +string(" Prototype Skeleton")
pointWorth=35+round(rpgLv/5)
if rpgLv<=9
{
  expValue=5+(rpgLv*2)
  maxLife=300+(rpgLv*7)
}
else if rpgLv>=10 and rpgLv<=25
{
  expValue=10+(rpgLv*3)
  maxLife=370+round(rpgLv*9.75)
}
else if rpgLv>=26 and rpgLv<=49
{
  expValue=15+round(rpgLv*4.25)
  maxLife=440+(rpgLv*11)
}
else if rpgLv>=50 and rpgLv<=59
{
  expValue=30+round(rpgLv*5.5)
  maxLife=520+(rpgLv*14)
}
else if rpgLv>=60
{
  expValue=40+round(rpgLv*6.75)
  maxLife=650+(rpgLv*16)
}
life=maxLife

if global.location=107
{
  eName=string("Lv.") +string(rpgLv) +string(" Betatype Skeleton")
  eLevel+=1
  maxLife=round(maxLife*1.1)
  life=maxLife
  pointWorth=round(pointWorth*1.2)
  expValue*=7
  atkPower+=1
  baseColor=make_color_rgb(255,190,180)
  image_blend=baseColor
  jeremyText+=" This upgraded version simply has slightly higher base stats."
  againMax=2 //spsp ns
  //atkDelay=20 //base: 35 //breaks?
}
