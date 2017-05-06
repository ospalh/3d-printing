// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// NN
//
// © 2017 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0

r = 7.4/2;
h=10;

e = 15.1;
ff=5.3;
ms=0.01;

difference()
{
   translate([0, 0, -ff])
   {
      rotate([0,-0.5*acos(-1/3), 0])
      {
         rotate([0,0, -45])
         {
            cube(e);
         }
      }
   }
   cylinder(r=r,h=h+ff, $fn=45);
   translate([0, 0, -2*e])
   {
      cylinder(r=2*e, h=2*e+ms);
   }
}
