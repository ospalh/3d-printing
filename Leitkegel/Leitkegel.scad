// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// 50 cm Leitkegel im Maßstab 1:10
//
// © 2018 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0

/* [Global] */

// Set this to “render” and click on “Create Thing” when done with the setup.
preview = 1; // [0:render, 1:preview]

/* [Sizes] */

// Height
height = 50;  // [15:1:100]

// Diameter of the cone at the base
d_cb = 20;  // [5:0.5:40]

// Diameter of the cone at the top
d_ct = 3;  // [0.4:0.1:4]

// Width of the base
w_b = 30;    // [8:0.5:50]

// Height of the base
h_b = 4; // [0.4:0.1:10]

/* [Hidden] */

// Done with the customizer

// *******************************************************
// Extra parameters. These can be changed reasonably safely.


// w = 0.8;  // Wall width
w = 0.4;  // Wall width
r_bc = d_ct/2;



// *******************************************************
// Some shortcuts. These shouldn’t be changed

tau = 2 * PI;  // π is still wrong. τ = circumference / r

xy_b = w_b / 2 - r_bc;
hc = height - h_b;

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

cone();
echo_heights();


// *******************************************************
// Code for the parts themselves

module cone()
{
   difference()
   {
      union()
      {
         base();
         solid_cone();
      }
      stack_hole();
   }
}

module base()
{
   linear_extrude(h_b)
   {
      2d_base();
   }
}

module 2d_base()
{
   hull()
   {
      one_bc(1,1);
      one_bc(1,-1);
      one_bc(-1,-1);
      one_bc(-1,1);
   }
}

module one_bc(xs, ys)
{
   translate([xs*xy_b, ys*xy_b])
   {
      circle(r_bc);
   }
}

module solid_cone()
{
   translate([0,0,h_b-ms])
   {
      cylinder(d1=d_cb, d2=d_ct, h=hc);
   }
}

module stack_hole()
{
   d_bb = ((height+ms)/hc) * (d_cb-d_ct) + d_ct;
   echo(d_bb);
   translate([0,0,-ms])
   {
      cylinder(d1=d_bb-2*w, d2=d_ct-2*w, h=height+ms);
   }
}


module echo_heights()
{
   sw = hc/5;
   echo("red→white at ", h_b + sw);
   echo("white→red at ", h_b + 2 * sw);
   echo("red→white at ", h_b + 3 * sw);
   echo("white→red at ", h_b + 4 * sw);
}
