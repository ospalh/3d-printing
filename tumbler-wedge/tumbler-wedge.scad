// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// A wedge to keep a glass angled.
//
// This is a re-imagining of Thing 2784800, matt sauter’s “Whiskey Wedge -
// Angled Ice”. (https://www.thingiverse.com/thing:2784800) This is not
// based on that thing, but a new thing to achieve the same effect.
//
// © 2018 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0


glass_diameter = 70; // [30:1:100]
glass_height = 90; // [20:1:200]
angle = 45; // [20:1:70]

// Percent of glass diameter
wedge_width = 85; // [50:1:99]

// How much border to be left
wedge_cutout_width = 10;

// Set this to “render” and click on “Create Thing” when done with the setup.
preview = 1; // [0:render, 1:preview]



/* [Hidden] */

// Done with the customizer

// *******************************************************
// Extra parameters. These can be changed reasonably safely.


w = 1.8;  // Wall width
p = 1.2;  // Bottom, top plate height
c = 0.4;  // Clearance

// *******************************************************
// Some shortcuts. These shouldn’t be changed

r_ge = glass_diameter/2 + c;
r_w = glass_diameter/2 * wedge_width/100;

tau = 2 * PI;  // π is still wrong. τ = ⌀ ÷ r

xy_factor = 1/tan(angle);
// To get from a height to a horizontal width inclined correctly
z_factor = tan(angle);  // The other way around
hb = glass_height*sin(angle);


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

glass_wedge();

// *******************************************************
// Code for the parts themselves


module glass_wedge()
{
   hc = r_ge*sin(angle) + p;
   difference()
   {
      glass_base();
      translate([0,0, hc])
      {
         glass_cutout();
      }
      inner_cutout();
   }
}

module glass_cutout()
{
   rotate([0,angle,0])
   {
      hull()
      {
         cylinder(r=r_ge, h=glass_height);
         translate([-r_ge-glass_height,0,0])
         {
            cylinder(r=r_ge, h=glass_height);
         }
      }
   }

}

module glass_base()
{
   linear_extrude(hb)
   {
      2d_glass_base();
   }
}



module 2d_glass_base()
{
   projection()
   {
      rotate([0,angle,0])
      {
         cylinder(r=r_w, h=glass_height+c);
      }
   }
}

module inner_cutout()
{
   translate([0,0,-ms])
   {
      linear_extrude(hb+2*ms)
      {
         2d_inner_cutout();
      }
   }
}

module 2d_inner_cutout()
{
   sy = (r_w-wedge_cutout_width)/r_w;
   lh = cos(angle)*(glass_height+c);
   lx = sin(angle)*r_w+lh;
   sx = (lx-2*wedge_cutout_width)/lx;

   // I think this is not really correct (or the way i wanted it), but,
   // meh, good enough.
   translate([sx*wedge_cutout_width,0])
   {
      scale([sx,sy])
      {
         2d_glass_base();
      }
   }
}
