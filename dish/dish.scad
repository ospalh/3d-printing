// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// NN
//
// © 2018–2019 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0

/* [Global] */

// Set this to “render” and click on “Create Thing” when done with the setup.
preview = 1; // [0:render, 1:preview]

/* [Sizes] */

// Diameter of the dish
dish_d = 40;  // [30:0.1:240]
// Height of the dish
dish_h = 6; // [5:0.1:24]

/* [Hidden] */

// Done with the customizer

// *******************************************************
// Extra parameters. These can be changed reasonably safely.


w = 1.8;  // Wall width
// p = 1.2;  // Bottom, top plate height
c = 0.4;  // Clearance
dish_angle = 60; // Overhangs much below 60° are a problem for me
r_r = 2;  // rounding radius

// *******************************************************
// Some shortcuts. These shouldn’t be changed

tau = 2 * PI;  // π is still wrong. τ = circumference / r

xy_factor = 1/tan(dish_angle);
// To get from a height to a horizontal width inclined correctly
z_factor = tan(dish_angle);  // The other way around

r_d = dish_d/2;
r_a = r_r + w;
r_m = r_r + w/2;

x_k = r_m * sin(dish_angle);
h_k = r_m * (1 - cos(dish_angle));
h_r = dish_h - h_k - w;
x_r = h_r * xy_factor;
l_r = sqrt(h_r*h_r+x_r*x_r);
r_z = r_d - x_r - x_k;

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

dish();
// 2d_dish();

// *******************************************************
// Code for the parts themselves

module dish()
{
   rotate_extrude()
   {
      2d_dish();
   }
}


module 2d_dish()
{
   square([r_z,w]);
   translate([r_z-ms,r_a])
   {
      difference()
      {
         circle(r=r_a);
         circle(r=r_r);
         translate([-1.5*r_a,0])
         {
            square(3*r_a, center=true);
         }
         rotate(dish_angle)
         {
            translate([0,-r_r])
            {
            square([r_a+ms,r_r+r_a+ms]);
            }
         }
      }
   }

   translate([r_z+x_k, w/2+h_k])
   {
      rotate(dish_angle)
      {
         translate([0, -w/2])
         {
            square([l_r,w]);
         }
      }
   }
   translate([r_d,dish_h-w/2])
   {
      circle(r=w/2);
   }
}
