// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// Inner tube foot
//
// A foot to mount a Replicator/Duplicator/Bizer/&cator on a
// half-inflated bicycle inner tube.  You’ll need four.
//
// © 2017 Roland Sieker <ospalh@gmail.com>
// Based on Replicator Isolator Feet by Gary Crowell Sr. https://www.thingiverse.com/thing:42124
// © 2013 Gary Crowell Sr. <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0


translate([0,0,8])
rotate([180,0,0])
{
   {
      foot();
   }
}

module foot ()
{
//  Replicator foot for gripper pad
   difference ()
   {
      translate ([ 15, 15, -12]) cylinder (h=20, r=15, $fn=100);

      translate ([-10,6,1])
         cube (size = [60,5.65,15], center = false);
      rotate ([0,0,270])
         translate ([-50,6,1])
         cube (size = [60,5.65,15], center = false);

      translate ([0,0,1])
      {
         cube (size = [10, 10,15], center = false);
      }
      translate ([-10,-36,-10])
      {
         rotate([0,30,45])
         {
            cube (size = [30, 30,30], center = false);
         }
      }
      rotate([90,0,45])
      {
         translate([15*sqrt(2), -12.5, -20])
         {
            cylinder(r=12.5, h=40,$fn=100);
         }
      }
   } // difference


// Strakes to make it grib the frame better
   translate ([14,11.9,0])
      rotate ([-4,0,0])
      cylinder (h=8, r=.8, $fn=20);

   translate ([24, 11.9,0])
      rotate ([-4,0,0])
      cylinder (h=8, r=.8, $fn=20);

   translate ([11.9,14,0])
      rotate ([0,4,0])
      cylinder (h=8, r=.8, $fn=20);

   translate ([11.9,24,0])
      rotate ([0,4,0])
      cylinder (h=8, r=.8, $fn=20);
}
