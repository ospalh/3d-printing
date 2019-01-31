// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// matchbox stacker with or without a perch for the one box in use
//
// © 2018–2019 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0

/* [Global] */

// Which variant of the stacker to create
variant = "s"; // [s: simple, p: with perch, c: with container]

// Set this to “render” and click on “Create Thing” when done with the setup.
preview = 1; // [0:render, 1:preview]

/* [Sizes] */

//
box_width = 53.2  // [5:0.1:150]
box_height = 16.1  // [5:0.1:30]
box_depth = 37.1  // [5:0.1:80]
boxes_per_pack = 10;  // [4:1:20]

/* [Hidden] */

// Done with the customizer

// *******************************************************
// Extra parameters. These can be changed reasonably safely.


w = 1.8;  // Wall width
// p = 1.2;  // Bottom, top plate height
p = w;  // Bottom, top plate height
c = 0.4;  // Clearance
angle = 60; // Overhangs much below 60° are a problem for me
k = 5;  // which of the remainig main plates
r_c = k/2;  // Radius of the main cuts
p_f = 0.5; // perch factor. How long the perch is as part of the width
c_f = 0.5;  // container factor. How long the perch is as part of the width
sp_w = 3.3; // How much the inner box is less wide than the outer
sp_h = 2.4; // How much the inner box is less high than the outer


// *******************************************************
// Some shortcuts. These shouldn’t be changed

tau = 2 * PI;  // π is still wrong. τ = circumference / r

xy_factor = 1/tan(angle);
// To get from a height to a horizontal width inclined correctly
z_factor = tan(angle);  // The other way around

r_r = min(w,p);
w_e = box_width + 2*c;
d_e = box_depth + 2*c;
h_e = (boxes_per_pack - ( (variant == "s") 0.5 ? : 1) ) * box_height + c;
   ( (variant == "s") 0 ? : 1);

some_distance = 1.5 * box_width;
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

// print_part();
preview_parts();
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


module main_box()
{

   // hull()
   {

   }
}
