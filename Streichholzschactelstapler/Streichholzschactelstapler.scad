// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// matchbox stacker with or without a perch for the one box in use
//
// (c) 2018-2019 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0

/* [Global] */

// Which variant of the stacker to create
variant = "s"; // [s: simple, p: with perch, c: with container]

// Set this to "render" and click on "Create Thing" when done with the setup.
preview = 1; // [0:render, 1:preview]

/* [Sizes] */

//
box_width = 53.2;  // [5:0.1:150]
box_height = 16.1;  // [5:0.1:30]
box_depth = 37.1;  // [5:0.1:80]
boxes_per_pack = 10;  // [4:1:20]

/* [Hidden] */

// Done with the customizer

// *******************************************************
// Extra parameters. These can be changed reasonably safely.


w = 1.8;  // Wall width
// p = 1.2;  // Bottom, top plate height
p = w;  // Bottom, top plate height
c = 0.4;  // Clearance
angle = 60; // Overhangs much below 60 degrees are a problem for me
k = 5;  // which of the remainig main plates
r_c = k/2;  // Radius of the main cuts
p_f = 0.5; // perch factor. How long the perch is as part of the width
c_f = 0.5;  // container factor. How long the perch is as part of the width
sp_w = 3.3; // How much the inner box is less wide than the outer
sp_h = 2.4; // How much the inner box is less high than the outer


// *******************************************************
// Some shortcuts. These shouldn't be changed

tau = 2 * PI;  // pi is still wrong. tau = circumference / r

xy_factor = 1/tan(angle);
// To get from a height to a horizontal width inclined correctly
z_factor = tan(angle);  // The other way around

r_r = min(w,p);
w_e = box_width + 2*c;
d_e = box_depth + 2*c;
h_e = (boxes_per_pack - 1) * box_height + c;


xe = w_e/2 + w - r_r;
ye = d_e/2 + w - r_r;

xex = xe - r_c - k;
yex = ye - r_c - k;



some_distance = 1.5 * box_width;
ms = 0.01;  // Muggeseggele.

h_ee = h_e + c + p + 2 * ms;
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
// preview_parts();
// stack_parts();

module print_part()
{
   if ("s" == variant)
   {
      simple_stacker();
   }
   if ("p" == variant)
   {
      stacker_with_perch();
   }
   if ("c" == variant)
   {
      stacker_with_container();
   }
}

module preview_parts()
{
   simple_stacker();
   translate([some_distance, 0, 0])
   {
      stacker_with_perch();
   }
   translate([0, some_distance, 0])
   {
      stacker_with_container();
   }
}


// *******************************************************
// Code for the parts themselves
module simple_stacker()
{
   difference()
   {
      union()
      {
         solid_main_box();
         single_matchbox_bar();
      }
      matches_hollow();
      single_matchbox_hole();
   }
}

module single_matchbox_bar()
{
   translate([-w_e/2, d_e/2-ms, p+box_height+c])
   {
      cube([w_e,w+2*ms,w]);
   }
}

module single_matchbox_hole()
{
   translate([-w_e/2, d_e/2-ms, p])
   {
      cube([w_e,w+2*ms,+box_height+c]);
   }
}

module matches_hollow()
{
   translate([0,0,h_ee/2+p])
   {
      cube([w_e, d_e, h_ee], center=true);
   }
}

module solid_main_box()
{
   difference()
   {
      simple_solid_box();
      x_cut();
      y_cut();
      rotate(180)
      {
         x_cut();
         y_cut();
      }
   }
   module x_cut()
   {
      hull()
      {
         translate([0,0,p])
         {
            translate([xex-w, yex+k, 0])
            {
               cylinder(r=r_c, h=h_ee);
            }
            translate([-xex+w, yex+k, 0])
            {
               cylinder(r=r_c, h=h_e + c + p+ 2 * ms);
            }
            translate([0, d_e, h_ee/2])
            {
               cube([2*xex-2*w+2*r_c, 1, h_ee], center=true);
            }
         }
      }
   }
   module y_cut()
   {
      hull()
      {
         translate([0,0,p])
         {
            translate([xex+k, yex-w, 0])
            {
               cylinder(r=r_c, h=h_ee);
            }
            translate([xex+k, -yex+w, 0])
            {
               cylinder(r=r_c, h=h_e + c + p+ 2 * ms);
            }
            translate([w_e, 0, h_ee/2])
            {
               cube([1, 2*yex-2*w+2*r_c, h_ee], center=true);
            }
         }
      }
   }
}

module simple_solid_box()
{
   hull()
   {
      translate([xe, ye,0])
      {
         stick();
      }
      translate([xe, -ye,0])
      {
         stick();
      }
      translate([-xe, ye,0])
      {
         stick();
      }
      translate([-xe, -ye,0])
      {
         stick();
      }
   }
   module stick()
   {
      translate([0,0,r_r])
      {
         sphere(r=r_r);
         cylinder(r=r_r, h_e);
      }
   }
}
