// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
//Title: Can Colander/Strainer
//Author: Alex English - ProtoParadigm
//Date: 8-12-2012
//License: Creative Commons

//Note: This simple strainer is meant to be pressed into the top of an open
//food can of vegetables, etc. to strain them.  The size and other
//parameters can be changed using the values below.

can_diameter = 66;  //can inner diameter
height = 15;

slat_width = 2.4;

preview = 1; // [0:render, 1:preview]

/* [Hidden] */

// *******************************************************
// Some more values that can be changed

wall = 1.6;
p_h = 1.8;
r_can = can_diameter / 2;
ms = 0.05; // Muggeseggele

// fn for differently sized objects, for preview or rendering.
pfa = 40;
pfb = 15;
rfa = 180;
rfb = 30;
function fa() = (preview) ? pfa : rfa;
function fb() = (preview) ? pfb : rfb;

// *******************************************************
// End setup



// *******************************************************
// Generate the part

can_colander();

module can_colander()
{
   //main strainer
   difference()
   {
      cylinder(r=r_can, height, $fn=fa());
      translate([0,0,p_h])
      {
         cylinder(r=r_can - wall, height, $fn=fa());
      }
      for(x = [-r_can + wall: slat_width * 2 : r_can - wall])
      {
         translate([x, -r_can, -ms])
         {
            cube([slat_width, r_can * 2, height]);
         }
      }
   }

   // rim
   translate([0,0,height])
   {
      difference()
      {
         rotate_extrude($fn=fa())
         {
            translate([r_can-wall, 0, 0])
            {
               circle(r=wall*2, $fn=fb());
            }
         }
         translate([0,0,-wall*3])
         {
            cylinder(r=r_can-wall, wall*6, $fn=fa());
         }
         translate([0, 0, wall + height/2])
         {
            cube([r_can*2+4*wall, r_can*2+4*wall, height], true);
         }
      }
   }
}
