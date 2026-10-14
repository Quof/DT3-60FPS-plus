eName=string("Lv.") +string(rpgLv) +string(" Prototype Sword Armor")
pointWorth=50+round(rpgLv/3)
if rpgLv<=9
{
  expValue=10+(rpgLv*5)
  maxLife=500+(rpgLv*10)
}
else if rpgLv>=10 and rpgLv<=24
{
  expValue=20+(rpgLv*7)
  maxLife=580+(rpgLv*14)
}
else if rpgLv>=25 and rpgLv<=49
{
  expValue=35+round(rpgLv*8)
  maxLife=660+round(rpgLv*16)
}
else if rpgLv>=50 and rpgLv<=59
{
  expValue=60+round(rpgLv*12)
  maxLife=780+round(rpgLv*20)
}
else if rpgLv>=60 and rpgLv<=99
{
  expValue=80+round(rpgLv*15)
  maxLife=920+round(rpgLv*24)
}
else if rpgLv>=100
{
  expValue=100+round(rpgLv*20)
  maxLife=1000+round(rpgLv*25)
}
life=maxLife

if global.location=107
{
  eName=string("Lv.") +string(rpgLv) +string(" Betatype Sword Armor")
  eLevel=30
  maxLife=round(maxLife*1.1)
  life=maxLife
  pointWorth=round(pointWorth*1.2)
  expValue*=10
  atkPower=9
  resType[1]=1
  resType[5]=1
  baseColor=make_color_rgb(255,190,180)
  image_blend=baseColor
  jeremyText+=" This upgraded version resists your secondary attacks and has slightly higher base stats."
}
