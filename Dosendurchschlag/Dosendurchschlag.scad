// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
//Title: Can Colander/Strainer
//Author: Alex English - ProtoParadigm
//Date: 8-12-2012
//License: Creative Commons

//Note: This simple strainer is meant to be pressed into the top of an open
//food can of vegetables, etc. to strain them.  The size and other
//parameters can be changed using the values below.

can_inner_d = 66;  //can inner diameter
height = 15;
wall_thick = 2;
slat_width = 2;

size = can_inner_d / 2;

can_colander();

module can_colander()
{
   //main strainer
   difference()
   {
      cylinder(r=size, height);
      translate([0,0,wall_thick])
      {
         cylinder(r=size-wall_thick, height);
      }
      intersection()
      {
         for(x = [-size : slat_width * 2 : size])
         {
            translate([x, -size, -1])
            {
               cube([slat_width, size * 2, wall_thick + 2]);
            }
         }
         translate ([0, 0, -wall_thick])
         {
            cylinder(r=size-wall_thick*2, wall_thick * 2);
         }
      }
   }

   // rim
   translate([0,0,height])
   {
      difference()
      {
         rotate_extrude()
         {
            translate([size-wall_thick, 0, 0])
            {
               circle(r=wall_thick*2);
            }
         }
         translate([0,0,-wall_thick*3])
         {
            cylinder(r=size-wall_thick, wall_thick*6);
         }
         translate([0, 0, wall_thick + height/2])
         {
            cube([size*2+4*wall_thick, size*2+4*wall_thick, height], true);
         }
      }
   }
}
