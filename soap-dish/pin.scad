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

[gr+gh,0],

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
   translate([-w/2,0,0])
   {
      rotate([0, 90, 0])
      {
         linear_extrude(w)
         {
            p();
         }
      }
   }
}

pt();
