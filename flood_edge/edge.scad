// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// NN
//
// © 2017 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0

w = 0.8;

l1 = 10;
l2 = 10;
h = 100;


for (i=[0:90:271])
{
   rotate(i)
   {
      one_profile();
   }
}

module one_profile()
{
   translate([2*w,2*w,0])
   {
      cube([l1,w,h]);
      cube([w,l2,h]);
   }
}
