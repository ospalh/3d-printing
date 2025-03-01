// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// NN
//
// © 2018–2019 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0

/* [Global] */

// … to preview. You will get all parts as separate STLs when you click “Create Thing”.
part = "s"; // [s: Set, a: Part A, b: Part B, st: Stack]

// Set this to “render” and click on “Create Thing” when done with the setup.
preview = 1; // [0:render, 1:preview]

/* [Sizes] */

// Höhe der Latte
size_x = 37.5;  // [1:0.1:40]

// Tiefe der Latte
size_y = 17.2;  // [1:0.1:40]

// Abstand Latte-Haken
hly = 30;  // [1:0.1:40]

/* [Hidden] */

pw = 5;
pg = 10;
pr1 = pg/2;
pr2 = 2;

exl=hly-2*pw-pg;

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
      // translate([0,0,30])
      rotate([0,180,0])
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
   rahmen();
   linear_extrude(p)
   {
      translate([0,-ms,0])
         hanger_a();
   }
}

module part_b()
{
   rahmen();
   linear_extrude(p)
   {
      translate([0,-ms,0])
         hanger_b();
   }
}


module rahmen()
{
   translate([-pw -pg/2, -w-size_x, p])
      difference()
      {
         translate([0,-w,-p])
            cube([2*pw+pg, 2*w+size_x,2*p+size_y]);
         translate([-ms,0,0])
            cube([2*pw+pg+2*ms, size_x,size_y]);
         translate([pw,0,-ms-p])
            cube([pg, size_x, p+2*ms]);
         translate([pw+pg/2,-w-ms,-p-ms])
         kmirror()
         {
            rotate([0,atan(pw/(size_y)),0])
            translate([-pw-pg/2-20,0,0])
               cube([20,100,100]);
         }
      }
}


module hanger_a()
{
   difference()
   {
      union()
      {
         translate([-pw-pg/2, -ms])
            square([2*pw+pg,pw+pg+exl+2*ms]);
         translate([0,pw+pg+exl])
            circle(r=pw+pr1);
      }
      translate([0,pw+pg+exl])
         circle(r=pr1);
         translate([-pr1, -ms])
            square([pg,pw+pg+exl+2*ms]);
   }
}


module hanger_b()
{
   drr=pr1-pr2;
   difference()
   {
      union()
      {
         translate([-pw-pg/2, -ms])
            square([2*pw+pg,pw+pg+2*ms+drr+exl]);
         kmirror()
            translate([-drr,pw+pg+drr+exl])
         {

            circle(r=pw+pr2);
         }
         translate([-pg/2+drr,pg+2*pw+exl])
            square([2*drr, pw]);

      }
      translate([0,pw+pg+exl])
         kmirror()
         translate([-drr,+drr])
         {

           circle(r=pr2);
         }
         circle(r=pr1);
         translate([-pr1, -ms])
            square([pg,pw+pg+2*ms+drr+exl]);
           translate([-drr, pg+pw+exl])
            square([2*drr, pw]);
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
