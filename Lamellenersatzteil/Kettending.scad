// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// NN
//
// © 2018–2022 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0

/* [Global] */


// Set this to “render” and click on “Create Thing” when done with the setup.
preview = 1; // [0:render, 1:preview]

/* [Sizes] */

// distance from slat
a = 3.6;  // [1:0.1:40]

// diameter
d = 2.8;  // [1:0.1:40]

// hight of block
h = 3.9;  // [1:0.1:40]

// depth
t = 4.5;  // [1:0.1:40]

// width
w = 10;  // [1:0.1:40]

// length
l = 5;  // [1:0.1:40]



/* [Hidden] */

// Done with the customizer

// *******************************************************
// Extra parameters. These can be changed reasonably safely.


// w = 1.8;  // Wall width
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


r = d/2;
cp = a + r;

// … to preview. You will get all parts as separate STLs when you click “Create Thing”.
part = "k"; // [s: Set, a: Part A, b: Part B]


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
   if ("k" == part)
   {
      kettending();
   }
}

module preview_parts()
{
   kettending();
}

module stack_parts()
{
   // intersection()
   {
      color("yellow")
      {
         part_a();
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


module kettending()
{
   translate([-t/2, 0, 0])
   {
      cube([t,w,h]);
   }
   translate([0, a+r, h-ms])
   {
      cylinder(r=r, h=l);
   }
}
