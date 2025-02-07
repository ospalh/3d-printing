// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// NN
//
// © 2018–2019 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0

/* [Global] */

// … to preview. You will get all parts as separate STLs when you click “Create Thing”.
part = "a"; // [s: Set, a: Part A, b: Part B]

// Set this to “render” and click on “Create Thing” when done with the setup.
preview = 1; // [0:render, 1:preview]

/* [Sizes] */

// Gap for the line
gap = 3;  // [1:0.1:10]
// Thickness of the button
th_b = 5;  // [3:1:10]
// Radius of the button
r_b = 8;   // [3:1:20]

// Tiefe, d.h. width of the bit
t = 20;  // [5:1:50]
// Länge, length of the arms
l = 20;  // [5:1:50]
// Höhe, Thickness of the window sill
h = 20;  // [5:1:50]

/* [Hidden] */

// Done with the customizer

// *******************************************************
// Extra parameters. These can be changed reasonably safely.


w = 1.8;  // Wall width
p = 1.2;  // Bottom, top plate hight
c = 0.4;  // Clearance
angle = 60; // Overhangs much below 60° are a problem for me
r_r = 0.5;  // Rounding radius

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
      hakending();
   }
   if ("b" == part)
   {
      part_b();
   }
}

module preview_parts()
{
   hakending();
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
         hakending();
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

module hakending()
{
   hakendinghull();
}


module hakendinghull()
{
   hull()
      kmirror([0,0,1]) translate([0, 0, 5])
      kmirror([0,1,0]) translate([0, 5, 0])
      kmirror([1,0,0]) translate([5, 0, 0])
   {
         sphere(r=r_r);
   }
}
