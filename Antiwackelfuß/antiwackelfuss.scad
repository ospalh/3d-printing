// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// Antiwackelfuß
// A foot to putt on a chair leg to
//
// © 2018–2021 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0

/* [Global] */

// … to preview. You will get all parts as separate STLs when you click “Create Thing”.
part = "a"; // [s: Set, a: Part A, b: Part B]

// Set this to “render” and click on “Create Thing” when done with the setup.
preview = 1; // [0:render, 1:preview]

/* [Sizes] */

// Width
width = 15;  // [10:0.5:80]
// Length
length = 15;  // [10:0.5:80]

// Bottom plate hight, how much to anti-wobble
p = 1.2; // [0.2:0.1:10]

/* [Hidden] */

// Done with the customizer

// *******************************************************
// Extra parameters. These can be changed reasonably safely.


w = 1.8;  // Wall width
c = 0.4;  // Clearance
angle = 60; // Overhangs much below 60° are a problem for me
hight = 20;
g = 2; // gap;
r_n = 1;
r_r = 0.6;
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
      anti_wobble();
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


module anti_wobble()
{

   //base
   difference()
   {
      translate([0, 0, -p/2])
      {
         cube([width + 2*w, length + 2*w, p], center=true);
      }
      // grooves
      translate([length/2-r_r, width/2-r_r])
      {
         rotate([0, -90, 0])
         {
            cylinder(r=r_r, h=length);
         }
         rotate([90, 90, 0])
         {
            cylinder(r=r_r, h=width);
         }
      }

   }

   translate([0,0,-ms])
   {
      translate([-width/2-w, -length/2-w+ms, 0])
      {
         cube([width + w, w, hight]);
      }
      translate([-width/2-w, -length/2-w, 0])
      {
         cube([w, length + w, hight]);
      }
      translate([-width/2 + g, length/2, 0])
      {
         cube([width -2*g, w, hight]);
         translate([0, 0, hight-r_n-ms])
         {
            rotate([0, 90, 0])
            {
               cylinder(r=r_n, h=width-2*g);
            }
         }
      }
      translate([width/2, -length/2 + g, 0])
      {
         cube([w, length - 2*g, hight]);
         translate([0, 0, hight-r_n-ms])
         {
            rotate([-90, 0, 0])
            {
               cylinder(r=r_n, h=length-2*g);
            }
         }
      }
   }
}
