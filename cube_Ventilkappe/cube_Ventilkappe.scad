// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// kubische Ventilkappe. Fuer cube-Fahrraeder
//
// (c) 2017 Roland Sieker <ospalh@gmail.com>
// Licence: CC-0
// have fun

r1 = 8/2;
h1=5;
r2 = 7.4/2;
h2=10;

e = 13;
ff=6;
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
   cylinder(r=r1,h=h1, $fn=45);
   cylinder(r=r2,h=h2, $fn=45);
   translate([0, 0, -2*e])
   {
      cylinder(r=2*e, h=2*e+ms);
   }
}
