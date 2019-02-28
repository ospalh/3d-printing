// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// Buchse (bushing)
//
// (c) 2017 Roland Sieker <ospalh@gmail.com>
// Licence: CC-0 4.0

d_i = 4.2;
d_a = 5;
h = 4.5;
d_k = 6;
h_k = 0.4;

preview = true;

ms = 0.1;  // Muggeseggele



pa = 5;
ps = 1;
ra = 1;
rs = 0.1;
$fs = (preview) ? ps : rs;
$fa = (preview) ? pa : ra;



difference()
{
   union()
   {
      cylinder(d=d_k, h=h_k);
      cylinder(d=d_a, h=h);
   }
   translate([0,0,-ms])
   {
      cylinder(d=d_i, h=h+2*ms);
   }
}
