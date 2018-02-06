// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
//
//
// © 2017 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0

// … to preview
part = "wall"; // [wall: The cooling wall, modifier: The modifier cuboid. See description]
top_height=150; // [0,0.1:200]
modifier_bottom_height = 10;  // [0,0.1:200]


/* [Hidden] */

ms = 0.01;

print_part();

module print_part()
{
   if ("wall" == part)
   {
      wall();
   }
   if ("modifier" == part)
   {
      modifier();
   }
}


module wall()
{
   translate([-2.5, -50, 0])
   {
      cube([5, 0.8, top_height]);
   }
   translate([-2.5, 50, 0])
   {
   cube([5, 0.8, top_height]);
   }
   translate([0,0,top_height/2])
   {
      cube([0.4, 100, top_height], center=true);
   }
}

module modifier()
{
   translate([0,0,(top_height-modifier_bottom_height)/2+modifier_bottom_height+ms])
   {
      cube([1.2, 102, top_height-modifier_bottom_height+2*ms], center=true);
   }

}
