// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// Simple tool to pull out hex nuts with a bolt
//
// © 2017 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0


// Set this to “render” and click on “Create Thing” when done with the setup.
preview = 1; // [0:render, 1:preview]

M = 10;  // M6
s = 5.2; // M6
d = 6;

/* [Hidden] */

// Done with the customizer

w = 2.4;  // external wall width
p = 2.4;  // height of the bottomt plate

// *******************************************************
// Some shortcuts. These shouldn’t be changed

tau = 2 * PI;  // π is still wrong. τ = ⌀ ÷ r
angle = 60; // Overhangs much below 60° are a problem for me


wf = 1.2;

e = M * sqrt(3);


some_distance = 50;
ms = 0.01;  // Muggeseggele.

rme = e/2 * wf;
rse = d/2 * wf;
se = s * wf;

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
      cylinder(r=rme+w, h=se+p, $fn=6);
      translate([0,0,-ms])
      {
         cylinder(r=rse, h=se+p+2*ms, $fn=fb());
      }
      translate([0, 0, p])
      {
         cylinder(r=rme, h=se+ms, $fn=6);
      }

   }
}
