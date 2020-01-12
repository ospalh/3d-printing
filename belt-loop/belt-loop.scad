// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// NN
//
// © 2018–2020 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0

/* [Global] */


// Set this to “render” and click on “Create Thing” when done with the setup.
preview = 1; // [0:render, 1:preview]

/* [Sizes] */

// Width of the belt
width = 38;  // [10:1:180]

// Thickness of the single belt
thickness = 1.8;  // [1:0.1:18]

// Length in belt-direction of the loop
length = 15;   // [5:05:30]

// A closed loop or one with a gap?
with_gap = false;

/* [Extra] */

// … to preview. You will get all parts as separate STLs when you click “Create Thing”.
part = "l"; // [l: Loop, o:  Outside, i: Inside, t: Test]

gap_angle = 22.5; // Overhangs much below 60° are a problem for me

/* [Hidden] */

// Done with the customizer

// *******************************************************
// Extra parameters. These can be changed reasonably safely.


w = 1.8;  // Wall width
p = 1.2;  // Bottom, top plate hight
c = 0.4;  // Clearance
r_rb = 1;  // Rounding radius, bottom
r_rm = 1.5; // Rounding radis, main
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


if ("t" == part)
{
   loop();
}

if ("o" == part)
{
   outer_loop();
}


if ("i" == part)
{
   hole();
}

module print_part()
{
   if ("l" == part)
   {
      loop();
   }
}

// *******************************************************
// Code for the parts themselves


module loop()
{

   difference()
   {
      outer_loop();
      hole();
   }
}


module outer_loop()
{
   hull()
   {
      kmirror()
      {
         kmirror([0, 1, 0])
         {
            translate([width/2+c-r_rm, thickness+c-r_rm, length-r_rm-w])
            {
               sphere(r=r_rm+w);
            }
            translate([width/2+c+w-r_rb, thickness+c+w-r_rb, r_rb])
            {
               sphere(r=r_rb);
            }
         }
      }
   }
}


module hole()
{
   hull()
   {
      kmirror()
      {
         kmirror([0, 1, 0])
         {
            translate([width/2+c-r_rm, thickness+c-r_rm, -ms])
            {
               cylinder(r=r_rm, h=length+2*ms);
            }
         }
      }
   }
   if (with_gap)
   {
      translate([0, 0, 0.5*length])
      rotate([0,gap_angle,0])
      {
         translate([-thickness/2-c, 0, -2.5*length])
         {
            cube([thickness+2*c, 2*(width+w+c),6*length]);
         }
      }
   }
}
