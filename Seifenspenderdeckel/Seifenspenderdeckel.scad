// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// NN
//
// © 2018 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0


// Set this to “render” and click on “Create Thing” when done with the setup.
preview = true; // [0:render, 1:preview]

d_x = 82;
d_x2 = 79;
d_y = 55;
h_1 = 4;
h_2 = 6;
h_3 = 2;
r_r = 2;
x_h = 5;
/* [Hidden] */

// Done with the customizer

// *******************************************************
// Extra parameters. These can be changed reasonably safely.


w = 1.8;  // Wall width
p = w;  // Bottom, top plate height
c = 0.4;  // Clearance
angle = 60; // Overhangs much below 60° are a problem for me

// *******************************************************
// Some shortcuts. These shouldn’t be changed

tau = 2 * PI;  // π is still wrong. τ = circumference ÷ r

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
h_h = p + h_3;
r_sph = (h_2*h_2-k*k)/(2*k);

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

seifendeckel();
// runder_seifendeckel();
// vollseifenldeckel();
// 2d_vollseifendeckel();

// *******************************************************
// Code for the parts themselves


module seifendeckel()
{
   scale([1, d_y/d_x, 1])
   {
      runder_seifendeckel();
   }
}


module runder_seifendeckel()
{
   difference()
   {
      vollseifendeckel();
      hohlraum();
   }
}

module vollseifendeckel()
{
   rotate_extrude()
   {
      2d_vollseifendeckel();
   }
}

module 2d_vollseifendeckel()
{
   r_3 = r_x+w-r_r2;
   square([r_3, w]);
   translate([r_3, r_r2])
   {
      difference()
      {
         circle(r_r2);
         circle(r_r);
         translate([-r_r2-ms,0])
         {
            square([2*r_r2+2*ms, r_r2+ms, ]);
         }
         translate([-r_r2-ms, -r_r2-ms])
         {
             square([r_r2+ms, 2*r_r2+2*ms]);
         }
      }
   }
   translate([r_x, r_r2])
   {
      square([w, h_1-r_r2+p]);
   }
   translate([r_x-r_sph, p+h_1])
   {
      difference()
      {
         circle(r=r_sph+w);
         circle(r=r_sph);

         translate([-r_sph-w-ms,h_2])
         {
            square([2*r_sph+2*w+2*ms, 2*r_sph+2*w+2*ms]);
         }
         translate([-r_sph-w-ms, -r_sph-w-ms])
         {
            square([2*r_sph+2*w+2*ms, r_sph+w+ms]);
         }
         translate([-r_sph-w-ms, -ms])
         {
            square([r_sph+w+ms, r_sph+w+2*ms]);
         }
      }
   }
}


module hohlraum()
{
   rotate([90,0,0])
   {
      translate([0, 0, -r_x-w-ms])
      {
         linear_extrude(d_x+2*w+2*ms)
         {
            halbhohlflaeche();
            mirror()
            {
               halbhohlflaeche();
            }
         }
      }
   }
}


module halbhohlflaeche()
{
   translate([0,h_h])
   {
      translate([r_x-x_h-r_r,r_r])
      {
         circle(r_r);
      }
      square([r_x-x_h-r_r,2*r_r]);
      translate([0,r_r])
      {
         square([r_x-x_h,h_2+r_r]);
      }
   }
}
