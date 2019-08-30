// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// Murmelfänger
//
// © 2018–2019 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0

/* [Global] */

// … to preview. You will get all parts as separate STLs when you click “Create Thing”.
part = "s"; // [s: Set, a: Murmelfänger, st: Stack test, t: test]

// Set this to “render” and click on “Create Thing” when done with the setup.
preview = 1; // [0:render, 1:preview]

/* [Flasche] */

// Durchmesser des Flaschenhalses innen
d_loch = 15;  // [10:1:50]

// Durchmesser des Flansches oben am Flaschenhals
d_flansch = 25; // [10:1:50]

// Höhe (Dicke) des Flansches, aussen
h_flansch = 3;  // [10:1:50]

// Winkel des Flansches, °
a_flansch = 10;   // [0:0.25:20]

/* [Fänger] */

// Höhe der Riegelstäbe
h_stab = 3; // [1:0.5:7]

// Breite der Riegelstäbe
w_stab = 3; // [1:0.5:7]

// Abstand Querstab Unterkante Hals innen
d_unten = 5; // [1:0.5:7]


// Breite des Clips
w_clip = 3; // // [1:0.5:7]

/* [Hidden] */

// Done with the customizer

// *******************************************************
// Extra parameters. These can be changed reasonably safely.


w = 1.8;  // Wall width
p = 1.2;  // Bottom, top plate hight
c = 0.4;  // Clearance
angle = 60; // Overhangs much below 60° are a problem for me

// *******************************************************
// Some shortcuts. These shouldn’t be changed


module kmirror(maxis=[1, 0, 0])
{
   // Keep *and* mirror an object. Standard is left and right mirroring.
   children();
   mirror(maxis)
   {
      children();
   }
}

tau = 2 * PI;  // π is still wrong. τ = circumference / r

xy_factor = 1/tan(angle);
// To get from a hight to a horizontal width inclined correctly
z_factor = tan(angle);  // The other way around


some_distance = 50;
ms = 0.01;  // Muggeseggele.

// fn for differently sized objects and fs, fa; all for preview or rendering.
pna = 40;
pnb = 15;
pa = 5;
ps = 1;
rna = 180;
rnb = 30;
ra = 2;
rs = 0.25;
function na() = (preview) ? pna : rna;
function nb() = (preview) ? pnb : rnb;
$fs = (preview) ? ps : rs;
$fa = (preview) ? pa : ra;

// *******************************************************
// End setup



// *******************************************************
// Generate the parts

print_part();


if ("s" == part)
{
   preview_parts();
}

if ("t" == part)
{
   // Ad-hoc test code
   // clip_ring();
   clip_2d();
}


if ("st" == part)
{
   // Use "st" during development
   stack_parts();
}

module print_part()
{
   if ("a" == part)
   {
      faenger();
   }
   if ("b" == part)
   {
      part_b();
   }
}

module preview_parts()
{
   faenger();
   translate([some_distance, 0, 0])
   {
      part_b();
   }
}

module stack_parts()
{
   // intersection()
   {
      color("yellow")
      {
         faenger();
      }
      translate([0,0,30])
      {
         color("red")
         {
            part_b();
         }
      }
   }
}

// *******************************************************
// Code for the parts themselves

module faenger()
{
   clip_ring();
   bars();
}

module clip_ring()
{
   intersection()
   {
      rotate_extrude(convexity=6)
      {
         clip_2d();
      }
      translate([-d_flansch,-d_loch/2+d_unten,-d_flansch])
      {
         // Extra big on purpose
         cube(2*d_flansch);
      }
   }
}

module clip_2d()
{
   // sin
   rf = d_flansch/2;
   rfp = rf+w_stab;
   hf = h_stab+h_flansch;
   dco = sin(a_flansch) * w_stab;
   dci = sin(a_flansch) * w_clip;
   polygon(
      [
         [rf, 0],
         [rfp, 0],
         [rfp, hf+h_stab-dco],
         [rf-w_clip, hf+h_stab+dci],
         [rf-w_clip, hf+dco],
         [rf, hf]
         ]
      );
}

module bars()
{
   translate([0, -d_loch/2+d_unten, 0])
   {
      translate([-d_flansch/2-ms,0,0])
      {
         cube([d_flansch+2*ms, w_stab, h_stab]);
      }
      translate([-w_stab/2,ms,0])
      {
         cube([w_stab, d_flansch/2+d_loch/2-d_unten+ms, h_stab]);
      }
   }
}
