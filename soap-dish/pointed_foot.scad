// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// NN
//
// © 2017 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0


zmin = 6;

h = 6;
w=6;
gr = 2.6;

gh=gr/2;

module p()
{
   polygon(
      [
         [-h,-gh],
         [0,-gh],
         [0,-gh-gr],
         [gr,-gh-gr],
         [gr,-gh],
         [gr,gh],
         [gr,gh+gr],
         [0,gh+gr],
         [0,gh],
         [-h,gh],
         ]
      );
}

module pt()
{
   linear_extrude(w)
   {
      p();
   }
}

pt();
translate([gr,0,w/2])
{
   rotate([0, 90,0])
   {
      cylinder(r1=w/2,r2=0,h=gr);
   }
}
