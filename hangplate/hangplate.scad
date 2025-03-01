// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// NN
//
// © 2018–2019 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0

/* [Global] */

// … to preview. You will get all parts as separate STLs when you click “Create Thing”.
part = "s"; // [s: Set, a: Part A, b: Part B]

// Set this to “render” and click on “Create Thing” when done with the setup.
preview = 1; // [0:render, 1:preview]

/* [Sizes] */

// bla bla
size_x = 15;  // [1:0.1:40]

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


some_distance = 100;
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
      part_a();
   }
   if ("b" == part)
   {
      part_b();
   }
}

module preview_parts()
{
   part_a();
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


module part_a()
{
   linear_extrude(w)
   {
      plate_ab();
      translate([0,-ms,0])
         hanger_a();
   }
}

module part_b()
{
   linear_extrude(w)
   {
      plate_ab();
      translate([0,-ms,0])
         hanger_b();
   }
}



module plate_ab()
{
   translate([0, -45])
   {
      difference()
      {
         translate([-45,0])
         square([90,45]);
         holepair(15);
         holepair(30);
      }
   }
}

module hanger_a()
{
   translate([0,30])
   kmirror()
   {
      rotate(135)
      {
         translate([-2.5, -2.5])
         square([5,55]);
      }
   }
}


module hanger_b()
{
   translate([-35, 26])
   {
      square([70,5]);
   }
   kmirror()
   {
      translate([-35, 0])
         square([5,29]);
   }
}


module holepair(y)
{
   translate([0,y])
      {
         translate([-20,0])
            circle(r=3);
         translate([20,0])
            circle(r=3);
      }
}
