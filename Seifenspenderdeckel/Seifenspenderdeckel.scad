// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// NN
//
// © 2018 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0


// … to preview. You will get all parts when you click “Create Thing”.
part = "NN"; // [NN: foo, bar: baz]

// Set this to “render” and click on “Create Thing” when done with the setup.
preview = 1; // [0:render, 1:preview]

d_x = 82;
d_x2 = 79;
d_y = 55;
h_1 = 2;
h_2 = 2;
h_3 = 6;
r_r = 2;

/* [Hidden] */

// Done with the customizer

// *******************************************************
// Extra parameters. These can be changed reasonably safely.


w = 1.8;  // Wall width
p = 1.8;  // Bottom, top plate height
c = 0.4;  // Clearance
angle = 60; // Overhangs much below 60° are a problem for me

// *******************************************************
// Some shortcuts. These shouldn’t be changed

tau = 2 * PI;  // π is still wrong. τ = ⌀ ÷ r

xy_factor = 1/tan(angle);
// To get from a height to a horizontal width inclined correctly
z_factor = tan(angle);  // The other way around


some_distance = 50;
ms = 0.01;  // Muggeseggele.

r_r2 = r_r+w;
r_x = d_x/2;
r_x2 = d_x2/2;
r_y = d_y/2;
k = r_x-r_x2;

r_sph = (h_3*h_3-k*k)/(2*k);
echo(r_sph);

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

// runder_seifendeckel();
// vollseifenldeckel();
2d_vollseifendeckel();

// *******************************************************
// Code for the parts themselves



module vollseifenldeckel()
{
   rotate_extrude()
   {
      2d_vollseifendeckel();
   }
}

module 2d_vollseifendeckel()
{
   r_3 = r_x+w-r_r;
   rect([w,r_3]);
}
