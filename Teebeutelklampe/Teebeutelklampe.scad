// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// NN
//
// © 2019 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0

/* [Global] */

// Set this to “render” and click on “Create Thing” when done with the setup.
preview = 1; // [0:render, 1:preview]

/* [Sizes] */

// Outer diameter of the tea mug
d_mug = 85;  // [40:0.1:150]

// Wall width of the tea mug
w_mug = 1.3;  // [0.4:0.1:5]

/* [Hidden] */

// Done with the customizer

// *******************************************************
// Extra parameters. These can be changed reasonably safely.


w = 1.2;  // Wall width (clamp)
h_c = 6;  // height of the clamp part
p = 1.2;  // Bottom, top plate height
l_c = 5; // length of the cleat arms
r_cf = 2;  // radius of the curve of the cleat arms
c = 0.4;  // Clearance
angle = 60; // Overhangs much below 60° are a problem for me

// *******************************************************
// Some shortcuts. These shouldn’t be changed

tau = 2 * PI;  // π is still wrong. τ = circumference / r

xy_factor = 1/tan(angle);
// To get from a height to a horizontal width inclined correctly
z_factor = tan(angle);  // The other way around


r_mug = d_mug/2;
r_me = r_mug + c/2;
w_me = w_mug + c;
w_ges = w_me + 2*c + 2*w;
r_c = w_ges/2;

some_distance = 50;
ms = 0.01;  // Muggeseggele.

// fn for differently sized objects and fs, fa; all for preview or rendering.
pna = 40;
pnb = 15;
pa = 5;
ps = 1;
rna = 180;
rnb = 30;
ra = 1;
rs = 0.1;
function na() = (preview) ? pna : rna;
function nb() = (preview) ? pnb : rnb;
$fs = (preview) ? ps : rs;
$fa = (preview) ? pa : ra;

// *******************************************************
// End setup



// *******************************************************
// Generate the parts

// tea_cleat();
mug_clamp();

// *******************************************************
// Code for the parts themselves


module tea_cleat()
{
   mug_clamp();
   cleat_arm();
   mirror([0,0,1])
   {
      cleat_arm();
   }
}

module mug_clamp()
{
   intersection()
   {
      mug_clamp_ring();
      hull()
      {
         mug_ring_cylinder(7, 0);
         mug_ring_cylinder(-7, 0);
         mug_ring_cylinder(0, 20);
      }
   }
}


module mug_ring_cylinder(xo, ey)
{
   yr = r_mug-w_mug/2;
   ye = sqrt(yr*yr-xo*xo);
   translate([xo, ye + ey,-h_c-p-ms])
   {
      cylinder(r=w_ges/2+ms, h=h_c+p+2*ms);
   }

}

module mug_clamp_ring()
{
   rotate_extrude()
   {
      mug_clamp_cross();
   }
}

module mug_clamp_cross()
{

   rot_points = [
      [r_me+c+w, 0],
      [r_me+c+w, -p-h_c],
      [r_me, -p-h_c],
      [r_me, -h_c],
      [r_me+c, -h_c],
      [r_me+c, -p],
      [r_me-c-w_me, -p],
      [r_me-c-w_me, -h_c],
      [r_me-w_me, -h_c],
      [r_me-w_me, -h_c-p],
      [r_me-w_me-w-c, -h_c-p],
      [r_me-w_me-w-c, 0],
      // [,],
      ];
  polygon(rot_points);

}
