// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// NN
//
// © 2018–2019 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0

/* [Global] */

// … to preview. You will get all parts as separate STLs when you click “Create Thing”.
part = "a"; // [s: Set, a: Zweiteilhalter, b: Part B]

// Set this to “render” and click on “Create Thing” when done with the setup.
preview = 1; // [0:render, 1:preview]

/* [Sizes] */

//
mic_angle = 30;  // [10:2.5:60]
l_h = 40;
h_h = 50;
w_h = 5.6;
l_hc = 4;
d_mic = 6.6;
g_h = 0.8;
/* [Hidden] */

// Done with the customizer

// *******************************************************
// Extra parameters. These can be changed reasonably safely.


w = 1.8;  // Wall width
p = 1.2;  // Bottom, top plate height
c = 0.4;  // Clearance
angle = 60; // Overhangs much below 60° are a problem for me

// *******************************************************
// Some shortcuts. These shouldn’t be changed

tau = 2 * PI;  // π is still wrong. τ = circumference / r

xy_factor = 1/tan(angle);
// To get from a height to a horizontal width inclined correctly
z_factor = tan(angle);  // The other way around

r_mic = d_mic/2;

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

if ("st" == part)
{
   // Use "st" during development
   stack_parts();
}

module print_part()
{
   if ("a" == part)
   {
      zweiteil();
   }
}

module preview_parts()
{
   zweiteil();
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
         zweiteil();
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

module zweiteil()
{
   translate([0, -w_h/2, 0])
   {
      cube([h_h, w_h, w_h]);
   }
   translate([h_h, 0, 0])
   {
      rotate(90-mic_angle)
      {
         translate([-w_h/2, -w_h/2, 0])
         {
            arm();
         }
      }
   }
}


module arm()
{
   difference()
   {
      union()
      {
         cube([l_h, w_h, w_h]);
         translate([0,0,w_h-ms])
         {
            clip();
            translate([l_h-l_hc, 0, 0])
            {
               clip();
            }
         }
      }
      translate([l_hc+ms,w_h/2-0.5,-ms])
      {
         cube([l_h,1,w_h+2*r_mic+2*w+2*ms]);
      }
   }
}


module clip()
{
   translate([0,w_h/2, r_mic])
   {
      rotate([0,90,0])
      {
         difference()
         {
            cylinder(r=r_mic+w, h=l_hc);
            translate([0,0,-ms])
            {
               cylinder(r=r_mic, h=l_hc+2*ms);
               translate([-w-d_mic+g_h,0,l_hc/2+ms])
               {
                  cube([d_mic+2*w+2*ms,d_mic+2*w+2*ms, l_hc+2*ms], center=true);
               }
            }
         }
      }
   }
}
