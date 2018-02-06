// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// A ring coaster
//
// © 2017 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0


// Size of the coaster’s hole (mm)
inner_diameter = 20;  // [10:1:90]
// Size of the coaster as a whole (mm)
outer_diameter = 49;  // [20:1:100]

module dummy()
{
   // My quick way to stop the customizer.
}

h = 1.2;
b = 0.8;
w = 1.2;
r_i = inner_diameter/2;
r_o = outer_diameter/2;
tau = 2*PI;
g = 2*w;

ts = [
   [r_i, 0],
   [r_o, 0],
   [r_o, h+b],
   [r_o-w, h+b],
   [r_o-w, b],
   [r_i+w, b],
   [r_i+w, h+b],
   [r_i, h+b],
   ];

stege = floor((r_i + 2*w) * tau / (w+g));
winkel = 360/stege;

rotate_extrude($fa=1)
{
   polygon(ts);
}

for (a = [0:winkel:360-0.001])
{
   rotate(a)
   {
      translate([w/2, r_i+2*w, b])
      {
         cube([w,r_o-r_i-4*w ,h]);
      }
   }
}
