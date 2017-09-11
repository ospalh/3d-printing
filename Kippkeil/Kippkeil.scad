// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// NN
//
// © 2017 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0

$fn = 15;

r = 1;
kf = 0.1;
x = 30 - 2*r;
y1 = 25 - 2*r;
y2 = (25 + kf * x) - 2*r;
y3 = 19 - 2*r;
y4 = (19 + kf*x) - 2*r;
z = 30;
dy = (y1-y3)/2;

hull()
{
   translate([r, r, r])
   {
      // Unten
      sphere(r=r);
      translate([x, 0, 0])
      {
         sphere(r=r);
      }
      translate([0, y1, 0])
      {
         sphere(r=r);
      }
      translate([x, y2, 0])
      {
         sphere(r=r);
      }

      translate([0,dy,z])
      {
         // Oben
         sphere(r=r);
         translate([x, 0, 0])
         {
            sphere(r=r);
         }
         translate([0, y3, 0])
         {
            sphere(r=r);
         }
         translate([x, y4, 0])
         {
            sphere(r=r);
         }
      }
   }
}
