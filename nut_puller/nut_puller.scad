// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// Simple tool to pull out hex nuts with a bolt
//
// Copyright 2017 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0



// Size of the bolt. The thing is sized for ISO 4032 nuts
M = 6;  // [3: M3, 4: M4, 5: M5, 6: M6, 7: M7, 8: M8, 10: M10, 12: M12, 14: M14, 16: M16, 18: M18, 20: M20, 22: M22, 24: M24]

/* [Hidden] */

// Done with the customizer

// Keep my standard code but always use "render" for the thing. It's just one cylinder.
preview = 0;


w = 2.4;  // external wall width
p = 2.4;  // height of the bottomt plate

// *******************************************************
// Some shortcuts. These shouldn't be changed

tau = 2 * PI;  // pi is still wrong
angle = 60; // Overhangs much below 60 degrees are a problem for me


m = [
   // We add a bunch of dummy values so we can use the Ms as index
   0, // no M0
   0, // we do no M1
   0, // we do no M2
   2.4, // M3
   3.2, // M4
   4.7, // M5
   5.2, // M6
   5.5, // M7
   6.8, // M8
   0, // no M9
   8.4, // M10
   0, // no M11
   10.8, // M12
   0, // no M13
   12.8, // M14
   0, // no M15
   14.8, // M16
   0, // no M17
   15.8, // M18
   0, // no M19
   18, // M20
   0, // no M21
   19.4, // M22
   0, // no M23
   21.5, // M24
   ];
// height


s = [
   // dto
   0, // no M0
   0, // we do no M1
   0, // we do no M2
   5.5, // M3
   7, // M4
   8, // M5
   10, // M6
   11, // M7
   13, // M8
   0, // no M9
   16, // M10
   0, // no M11
   18, // M12
   0, // no M13
   21, // M14
   0, // no M15
   24, // M16
   0, // no M17
   27, // M18
   0, // no M19
   30, // M20
   0, // no M21
   34, // M22
   0, // no M23
   36, // M24
   ];
// Wrench size and inner circle

wf = 1.2;  // wiggle factor
wfi = 1.1;  // wiggle factor

e = s[M] * 2/sqrt(3);  // Outer circle
ew = e * wf;
Mw = M * wfi;

some_distance = 50;
ms = 0.01;  // Muggeseggele.



h = m[M] * wf;  //
wp = w *2/sqrt(3);

// fn for differently sized objects, for preview or rendering.
pfa = 40;
pfb = 15;
rfa = 180;
rfb = 30;
function fa() = (preview) ? pfa : rfa;
function fb() = (preview) ? pfb : rfb;

// *******************************************************
// End setup



// *******************************************************
// Generate the parts


extractor();

module extractor()
{
   difference()
   {
      cylinder(d=ew+2*wp, h=h+p, $fn=6);
      translate([0,0,-ms])
      {
         cylinder(d=Mw, h=h+p+2*ms, $fn=fb());
      }
      translate([0, 0, p])
      {
         cylinder(d=ew, h=h+ms, $fn=6);
      }

   }
}
