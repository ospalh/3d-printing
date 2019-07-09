// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// NN
//
// © 2018–2019 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0

/* [Global] */


// … to preview. You will get all parts as separate STLs when you click “Create Thing”.
part = "a"; // [t: test, a: Badge]


// Set this to “render” and click on “Create Thing” when done with the setup.
preview = 1; // [0:render, 1:preview]

/* [Sizes] */

// Size of the completed badge. Or just scale it
badge_size = 100;  // [25:5:150]

/* [Hidden] */

f_tr = 0.65;  // factor for inner text ring
de_text = 84; // effective text diameter;

r_b = badge_size/2;
r_tr = r_b * f_tr;
txt_factor = badge_size / de_text;

h_bl = 0.4;  // hight of black pot
h_rd = 0.4;  // hight of red pot



// Done with the customizer

// *******************************************************
// Extra parameters. These can be changed reasonably safely.


w = 1.8;  // Wall width
p = 1.2;  // Bottom, top plate height
c = 0.4;  // Clearance
angle = 60; // Overhangs much below 60° are a problem for me


h_rd_t = p + h_rd;
h_t = p + h_rd + h_bl;

// *******************************************************
// Some shortcuts. These shouldn’t be changed

tau = 2 * PI;  // π is still wrong. τ = circumference / r

xy_factor = 1/tan(angle);
// To get from a height to a horizontal width inclined correctly
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


use <Barista textpfad.scad>


// *******************************************************
// Generate the parts

print_part();


if ("t" == part)
{
   barista_text_3d();
}


module print_part()
{
   if ("a" == part)
   {
      barista_barista_badge();
   }
}

// *******************************************************
// Code for the parts themselves


module barista_barista_badge()
{
   difference()
   {
      ring_badge();
      barista_text_3d();
   }


}

module ring_badge()
{
   difference()
   {
      cylinder(r=r_b, h=h_t);
      translate([0,0,p])
      {
         cylinder(r=r_tr, h=h_t);
      }

   }
}




module barista_text_3d()
{
   // [-105.0, 148.5]
   translate([0,0,p])
   {
      linear_extrude(h_rd+h_bl+ms)
      {
         scale([txt_factor, txt_factor])
         {
            translate([9,-67])
            {
               barista_barista_text();
            }
         }
      }
   }
}
