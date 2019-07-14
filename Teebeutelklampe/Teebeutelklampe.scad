// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// tea bag cleat
//
// a maritime style cleat to stick onto your tea (coffee) mug and to sailor
// like tie down your tea bag
//
// © 2018–2019 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0

/* [Global] */

// Set this to “render” and click on “Create Thing” when done with the setup.
preview = 1; // [0:render, 1:preview]

/* [Sizes] */

// Outer diameter of the tea mug
d_mug = 101.2;  // [40:0.1:150]

// Wall width of the tea mug
w_mug = 5.7;  // [0.4:0.1:10]

/* [Hidden] */

// Done with the customizer

// *******************************************************
// Extra parameters. These can be changed reasonably safely.
r_r = 1;
h_g = 10; // hight of the clamp
w = 1.2;  // Wall width (clamp)
g_cl = 5;  // gap on th cleat
p = 1.2;  // Bottom, top plate hight
l_c = 3; // length of the cleat arms
c = 0.4;  // Clearance
angle = 60; // Overhangs much below 60° are a problem for me

// *******************************************************
// Some shortcuts. These shouldn’t be changed

tau = 2 * PI;  // π is still wrong. τ = circumference / r

xy_factor = 1/tan(angle);
// To get from a hight to a horizontal width inclined correctly
z_factor = tan(angle);  // The other way around
// h_g = 0.6*w_mug;

h_c = h_g+p;  // hight of the clamp part


r_mug = d_mug/2;
r_me = r_mug + c/2;
w_me = w_mug - c;
w_ges = w_me + 2*c + 2*w;
r_c = w_ges/2;
r_cf = 2 + w_ges/2;  // radius of the curve of the cleat arms

yr = r_mug-w_mug/2;
xx = r_r + g_cl;
ye = sqrt(yr*yr-xx*xx);

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

tea_cleat();
// mug_clamp();
// cleat_cross();
// cleat_qring();
// cleat_larm();
// cleat_arm();

// *******************************************************
// Code for the parts themselves


module tea_cleat()
{
   translate([0,-ye,r_cf+r_r])
   mirror([0,0,1])
   {
      p_tea_cleat();
   }
}

module p_tea_cleat()
{

   mug_clamp();
   cleat_arm();
   mirror([1,0,0])
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
         mug_ring_cylinder(xx, 0);
         mug_ring_cylinder(-xx, 0);
         mug_ring_cylinder(0, 2*(yr-ye)); // this is a tiny bit of fudging
      }
   }
}


module mug_ring_cylinder(xo, ey)
{
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
      [r_me-w_me-w-c, 0]
      ];
   polygon(rot_points);
}


module cleat_cross()
{
   intersection()
   {
      circle(r=w_ges/2);
      translate([-w_ges/2,0])
      {
         square(w_ges,center=true);
      }
   }
   hull()
   {
      translate([0,w_ges/2-r_r])
      {
         circle(r=r_r);
      }
      translate([0, -w_ges/2+r_r,0])
      {
         circle(r=r_r);
      }
   }
}


module cleat_qring()
{
   intersection()
   {
      rotate_extrude()
      {
         translate([r_cf, 0])
         {
            cleat_cross();
         }
      }
      translate([0,0,-w_ges])
      {
         cube(2*w_ges);
      }
   }
}

module cleat_larm()
{
   linear_extrude(l_c)
   {
      cleat_cross();
   }
   translate([0,0,l_c-ms])
   {
      intersection()
      {
         sphere(w_ges/2);
         linear_extrude(w_ges)
         {
            cleat_cross();
         }
      }
   }
}

module cleat_arm()
{
   translate([-r_cf - xx, ye, 0])
   {
      rotate([90,0,0])
      {
         cleat_qring();
      }
      translate([0,0,r_cf])
      {
         rotate([0,270,0])
         {
            cleat_larm();
         }
      }
   }
}
