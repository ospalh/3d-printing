// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// NN
//
// © 2018–2019 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0

/* [Global] */

// … to preview. You will get all parts as separate STLs when you click “Create Thing”.
part = "s"; // [s: Set, h: Haken, d: Doppelhaken, v: Verbinder, t: Test]

// Set this to “render” and click on “Create Thing” when done with the setup.
preview = 1; // [0:render, 1:preview]

/* [Sizes] */

// Tieve
size_x = 17.5;  // [1:0.25:40]

// Breite
size_y = 38;  // [1:0.25:70]

/* [Hidden] */

r_h = 2.5;
ast = 10;
// r_i = 1;

l_dhk = 50;
l_hk = 30;
l_vb1 = 120;

r_k = size_x/2 - r_h;
ast_e = ast +  2*r_h;

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

if (part == "t")
{
   nur_haken();
}

if ("st" == part)
{
   // Use "st" during development
   stack_parts();
}

module print_part()
{
   if ("h" == part)
   {
      haken();
   }
   if ("d" == part)
   {
      doppelhaken();
   }
   if ("v" == part)
   {
      verbinder();
   }
}

module preview_parts()
{
   haken();
   translate([0, some_distance, 0])
   {
      doppelhaken();
   }
   translate([0, 2*some_distance, 0])
   {
      verbinder();
   }
}

module stack_parts()
{
   // intersection()
   {
      color("yellow")
      {
         haken();
      }
      translate([0,0,30])
      {
         color("red")
         {
            doppelhaken();
         }
      }
   }
}

// *******************************************************
// Code for the parts themselves





module haken()
{
   rotate([0,90,0])
   translate([-l_hk-p,0,0])
   frame(l_hk, true);
   translate([0,size_x-r_h+w,-r_h+l_hk])
   rotate([90,0,-90])
   nur_haken();
}

module doppelhaken()
{
   rotate([0,90,0])
      translate([-l_dhk-p,0,0])
      frame(l_dhk, false);
}

module verbinder()
{
   kmirror()
      translate([-l_vb1-p, 0, 0])
      frame(l_vb1, true);
}


module frame(l, ep)
{
   le = l + (ep ? p : 0);
   lh = l + (ep ? 0 : 30);
   ext = ep ? 0 : 1;
   difference()
   {
      cube([le, size_x+2*w+2*ext, size_y+2*w+2*ext]);
      translate([-ms, w+ext, w+ext])
         cube([lh, size_x, size_y]);
      }
}

module nur_haken()
{
   cylinder(r=r_h, h=ast_e);
   translate([r_k,0,ast_e])
      rotate([90,0,0])
      rotate_extrude(angle=180)
      translate([r_k, 0])
      circle(r=r_h);
   translate([2*r_k,-r_k,ast_e])
      rotate([0,90,0])
      rotate_extrude(angle=90)
      translate([r_k, 0])
      circle(r=r_h);
   translate([2*r_k,-r_k,ast_e-r_k])
      rotate([90,0,0])
      cylinder(r=r_h, h=ast_e);
}
