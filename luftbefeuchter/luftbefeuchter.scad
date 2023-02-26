// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// Wasserschale als Luftbefeuchter
//
// © 2018–2023 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0

/* [Global] */

// … to preview. You will get all parts as separate STLs when you click “Create Thing”.
part = "s"; // [s: Set, a: Part A, b: Part B]

// Set this to “render” and click on “Create Thing” when done with the setup.
preview = 1; // [0:render, 1:preview]

/* [Sizes] */

// Size in both directions
size_x = 150;  // [30:1:240]
size_y = 100;  // [30:1:240]
size_z = 20;  // [10:1:240]



/* [Hidden] */

// Done with the customizer

// *******************************************************
// Extra parameters. These can be changed reasonably safely.


w = 1.8;  // Wall width
p = 1.2;  // Bottom, top plate hight
c = 0.4;  // Clearance
r_k = 5;
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

if ("st" == part)
{
   // Use "st" during development
   stack_parts();
}

module print_part()
{
   if ("a" == part)
   {
      schale();
   }
   if ("b" == part)
   {
      zpin();
   }
}

module preview_parts()
{
   schale();
   translate([some_distance, 0, 0])
   {
      zpin();
   }
}

module stack_parts()
{
   // intersection()
   {
      color("yellow")
      {
         schale();
      }
      translate([0,0,30])
      {
         color("red")
         {
            zpin();
         }
      }
   }
}

// *******************************************************
// Code for the parts themselves


module schale()
{
   difference()
   {
      schalenform(size_x/2-r_k-w, size_y/2-r_k-w, r_k+w, size_z-r_k);
      translate([0,0,p])
      {
         schalenform(size_x/2-r_k-w, size_y/2-r_k-w, r_k, size_z+r_k+ms);
      }
   }
}

module schalenform(x,y,r,h)
{
   hull()
   {
      kmirror([0, 1, 0])
      {
         kmirror()
         {
            translate([x,y,0])
            {
               pin(r,h);
            }
         }
      }
   }
}

module pin(r,h)
{
   translate([0,0,r])
   {
      sphere(r=r);
      cylinder(r=r, h=h);
   }
}


module zpin()
{}
