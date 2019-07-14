// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
//
//
// © 2017 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0

// … to preview
part = "wall"; // [wall: The cooling wall, modifier: The modifier cuboid. See description]
top_hight=150; // [0,0.1:200]
modifier_bottom_hight = 10;  // [0,0.1:200]


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
      cube([5, 0.8, top_hight]);
   }
   translate([-2.5, 50, 0])
   {
   cube([5, 0.8, top_hight]);
   }
   translate([0,0,top_hight/2])
   {
      cube([0.4, 100, top_hight], center=true);
   }
}

module modifier()
{
   translate([0,0,(top_hight-modifier_bottom_hight)/2+modifier_bottom_hight+ms])
   {
      cube([1.2, 102, top_hight-modifier_bottom_hight+2*ms], center=true);
   }

}
