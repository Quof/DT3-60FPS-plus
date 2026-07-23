// fptoif(x): "fractional part to integer fraction" (y + x/n -> y + 1/n rounding)
var f, i, s, m;
s = sign(argument0)
m = abs(argument0)
f = frac(m)
i = m-f
if f == 0 { return argument0; }
f = 1.0/round(1.0/f)
return s*(i+f)
