// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// NN
//
// © 2018–2019 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0

/* [Global] */

// … to preview. You will get all parts as separate STLs when you click “Create Thing”.
part = "s"; // [s: Set, a: Stenncil, t: Test]

// Set this to “render” and click on “Create Thing” when done with the setup.
preview = 1; // [0:render, 1:preview]

/* [Sizes] */

//

// Radius of the stencil without the rounding
radius = 50;   // [20:1:140]

// Size of the handle without the rounding
handle_size = 20; // [50:1:40]

// Radius of the rounding
r_r = 2; // [0.5:0.1:10]

// bottom, top plate hight
p = 1.8;  // [0.4:0.2:4]

/* [Hidden] */

// Done with the customizer

// *******************************************************
// Extra parameters. These can be changed reasonably safely.


w = 1.8;  // Wall width

c = 0.4;  // Clearance
angle = 60; // Overhangs much below 60° are a problem for me

// *******************************************************
// Some shortcuts. These shouldn’t be changed

tau = 2 * PI;  // π is still wrong. τ = circumference / r

xy_factor = 1/tan(angle);
// To get from a height to a horizontal width inclined correctly
z_factor = tan(angle);  // The other way around

efs = 220;

flags_factor = radius/efs;

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

use <two_flags.scad>
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
   full_stencil();
}

module print_part()
{
   if ("a" == part)
   {
      stencil();
   }
   if ("b" == part)
   {
      part_b();
   }
}

module preview_parts()
{
   stencil();
}

module stack_parts()
{
   // intersection()
   {
      color("yellow")
      {
         stencil();
      }
   }
}

// *******************************************************
// Code for the parts themselves


module stencil()
{
   difference()
   {
      full_stencil();
      flags_3d();
   }
}

module full_stencil()
{
   translate([-radius-r_r,0,0])
   {
      // This did not work the way i wanted. Looks like there is no easy way to do filleting after all.
      minkowski()
      {
         translate([radius, 0, 0])
         {
            cylinder(r=r_r, h=ms);
         }
         ruf_stencil();
      }
   }
}

module ruf_stencil()
{

   cylinder(r=radius, h=p);
   translate([radius/sqrt(2), -radius/sqrt(2), 0])
   rotate([0,0,45])
   {
      translate([0,0,p/2])
      {
         cube([handle_size,2*handle_size,p], center=true);
      }
   }

}


module flags_3d()
{
   translate([0,0,-2*ms])
   {
      linear_extrude(p+4*ms)
      {
         scale([flags_factor, flags_factor])
         {
            red_flag();
            black_flag();
         }
      }
   }
}
