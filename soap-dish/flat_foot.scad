// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// NN
//
// © 2017 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0



h = 6;
w=5;


gr = 2;

gh=2.5;
hb=8;

module p()
{
   polygon(
      [
         [-h,-gh],
         [0,-gh],
         [0,-gh-gr],
         [hb,-gh-gr],
         [hb,gh+gr],
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
      //cylinder(r1=w/2,r2=0,h=gr);
   }
}
