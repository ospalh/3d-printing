// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// deutscher Monatsring fuer den Drehkalender
//
// (c) 2018 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0
// STL used:
// Vintage "Perpetual" Flip Calendar
// https://www.thingiverse.com/thing:1785261
// (c) 2016 Otvinta 3D
// https://www.thingiverse.com/otvinta3d/about
// Licence: CC-BY

ri = 4.7;
ro = 6.5;
h = 7.5;

ms=0.01;
$fs = 0.1;
$fa = 1;

//clearance_cylinder();
arm_with_clearance();
module arm_with_clearance()
{

   difference()
   {
      translate([0,0,38.5])
      {
         import("molds/Arm.stl");
      }
      translate([0,0,4])
      {
         clearance_cylinder();
      }
   }
}

module clearance_cylinder()
{
   difference()
   {
      cylinder(r=ro, h=h);
      translate([0,0,-ms])
      {
         cylinder(r=ri, h=h+2*ms);
      }
   }
}
