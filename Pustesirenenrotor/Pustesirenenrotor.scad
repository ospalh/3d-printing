// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// NN
//
// © 2017 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0


h_l = 2.5;
r_l = 7/2;
ms = 0.1;
r_lh = r_l + 0.8;

$fn=90;

difference()
{
   union()
   {
      translate([-90+1.5, -90, 0])
      {
         import("siren_rotor.stl");
      }
      cylinder(r=r_lh, h=h_l);
   }
   translate([0, 0, -ms])
   {
      cylinder(r=r_l, h=h_l+2*ms);
   }
}
