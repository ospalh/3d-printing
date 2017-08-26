// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// NN
//
// © 2017 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0

tau = 2*PI;
h = 1.2;
b = 0.8;
w = 1.2;
d_i = 20;
d_o = 49;
g = 2*w;

r_i = d_i/2;
r_o = d_o/2;



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
