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
d_loch = 45;  // [10:1:50]

// Durchmesser des Flansches oben am Flaschenhals
d_flansch = 58; // [10:1:50]

// Höhe (Dicke) des Flansches, aussen
h_flansch = 4.5;  // [10:1:50]


/* [Fänger] */

// Höhe der Riegelstäbe
h_stab = 1; // [1:0.5:7]

// Breite der Riegelstäbe
w_stab = 3; // [1:0.5:7]

// Abstand Querstab Unterkante Hals innen
d_unten = 5; // [1:0.5:7]


// Breite des Clips, d.h. des eigentlichen flansches
w_clip = 1; // [1:0.5:7]

// Breite des Rings für die clips
w_rand = 1.6;  // [1:0.5:7]

// Breite der Clips in y-Richtung
d_clip = 8; // [1:0.5:10]


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

rf = d_flansch/2;
rfp = rf+w_rand;
rl = d_loch/2;

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
}

module preview_parts()
{
   faenger();
}

module stack_parts()
{
   // intersection()
   {
      color("yellow")
      {
         faenger();
      }
   }
}

// *******************************************************
// Code for the parts themselves

module faenger()
{
   clip_ring();
   main_ring();
   bars();
}

module main_ring()
{
   difference()
   {
      rotate_extrude()
      {
         translate([rf,0])
         {
            square([w_rand, h_stab]);
         }
      }
   }
}

module clip_ring()
{
   intersection()
   {
      rotate_extrude(convexity=6)
      {
         clip_2d();
      }
      kmirror([0,1,0])
      {
         translate([-rf,rf/2,-ms])
         {
            cube([d_flansch,d_clip,2*h_stab+h_flansch]);
         }
      }
   }
}

module clip_2d()
{
   // sin
   hf = h_stab+h_flansch;

   polygon(
      [
         [rf, 0],
         [rfp, 0],
         [rfp, hf+2*w_clip+w_rand],
         [rf-w_clip, hf+w_clip],
         [rf, hf]
         ]
      );
}

module bars()
{
   intersection()
   {
      catch_rings();
      translate([0,0,-ms])
      {
         cylinder(r=rfp-ms, h=h_stab+2*ms);
      }
   }
}


module catch_rings()
{
   translate([0,-rl,0])
   {
      rotate_extrude(convexity=8)
      {
         for (rr=[d_unten:d_unten+w_stab:d_loch])
         {
            translate([rr,0])
            {
               square([w_stab, h_stab]);
            }
         }
      }
   }
   translate([-w_stab/2,-rl+d_unten+w_stab/2,0])
   {
      cube([w_stab,rf+rl-d_unten-w_stab/2+w_rand/2, h_stab]);
   }
}
