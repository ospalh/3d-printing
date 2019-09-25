// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// einfaches Wasserbad
// simple bain marie
//
// Ein Gefäß, in das heißes (kaltes) Wasser gefüllt wird. Ein kleineres
// Gefäß wird eingesetzt, und erwärmt oder kühlt dessen Inhalt. Einfach, da
// nichts die Tempratur stabilisiert. Das heiße Wasser kühlt ab. Oft ist
// das gut genug.
//
// © 2018–2019 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0

/* [Global] */

// Set this to “render” and click on “Create Thing” when done with the setup.
preview = 1; // [0:render, 1:preview]

// What to show.
part = "bm"; // [bm: bain marie, t: test]

/* [Sizes] */

// Diameter of the pot to heat
pot_d = 58;  // [30:0.5:240]
// Hight of the bath
bath_h = 70; // [30:1:120]

// Space for water
w_water = 10; // [5:0.5:24]

/* [Hidden] */

// Done with the customizer



// *******************************************************
// Extra parameters. These can be changed reasonably safely.

// Angle of the sides of the bath
bath_angle = 90; // [45:5:90]

w = 1.8;  // Wall width
p = 1.2;  // Bottom, top plate hight
c = 0.4;  // Clearance

r_r = 3;  // rounding radius

// *******************************************************
// Some shortcuts. These shouldn’t be changed

module kmirror(maxis=[1, 0, 0])
{
   // Keep *and* mirror an object. Standard is left and right mirroring.
   children();
   mirror(maxis)
   {
      children();
   }
}

tau = 2 * PI;  // π is still wrong. τ = circumference / r
r_p = pot_d/2;
r_d = r_p + w_water;
r_a = r_r + w;
r_m = r_r + w/2;
r_rs = r_p*0.2;

// Höhe der Zentrierstege. Siehe unten.
// h_c = 30;

// Höhe des Potts im Wasser
h_pe = bath_h - w_water;

// Volumen Wasser, das der Pott verdrängt
V_pot = r_p * r_p * tau/2 * h_pe;

// Fläche bad
A_wb = r_d * r_d * tau/2;

// Gesamtvolumen, Oberteil
V_go = A_wb * h_pe;

// Wasservolumen ist
// (Näherung: gerade Zentrierstege)
// v_wasser = v_go - v_pot - h_c * 3 * r_rs * w
// h_c bestimmt aus
// v_unten = r_d * r_d * tau_/2 * h_c - h_c * 3 * r_rs * w = w_wasser

h_c = (V_go - V_pot) / A_wb;

h_c_e = h_c + w_water - 2;


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


if ("bm" == part)
{
   bain_marie();
}
if ("t" == part)
{
   2d_bath();
   // 2d_centerer();
}


// *******************************************************
// Code for the parts themselves

module bain_marie()
{
   bath();
   pot_centerers();
   pot_raisers();
}

module bath()
{
   rotate_extrude()
   {
      2d_bath();
   }
}

module pot_centerers()
{
   intersection()
   {
      full_centerer();
      union()
      {
         for (a=[0, 120, 240])
         {
            rotate([0,0,a])
            {
               translate([0,-r_rs, ms])
               {
                  cube([r_d, 2*r_rs, 2*bath_h]);
               }
            }
         }
      }
   }
}


module full_centerer()
{
   translate([0,0,ms])
   rotate_extrude()
   {
      2d_centerer();
   }
}


module 2d_centerer()
{

   rot_points = [
      [r_d+ms, h_c_e-p-2*w_water],
      [r_d+ms, h_c_e],
      [r_p, h_c_e],
      [r_p, h_c_e-p]

      ];
   polygon(rot_points);

}

module pot_raisers()
{

   for (a=[0, 120, 240])
   {
      rotate([0, 0, a])
      {
         pot_raiser();
      }
   }
}

module pot_raiser()
{
   translate([-r_p+1.8*r_rs, 0, ms])
   {
      rotate_extrude()
      {
         2d_raiser();
      }
   }
}

module 2d_raiser()
{
   difference()
   {
      square([r_rs+r_r-ms, w_water+p]);
      hull()
      {
         translate([r_rs+r_r,r_r+p])
         {
            circle(r_r);
         }
         translate([r_rs, p+w_water+ms])
         {
            square([r_r+ms,r_r]); // the hight is so we can see it
         }
      }

   }
}

module 2d_bath()
{
   difference()
   {
      square([r_d+w, bath_h]);
      hull()
      {
         translate([r_d-r_r,r_r+p])
         {
            circle(r_r);
         }
         translate([0,p])
         {
            square([ms,ms]);
         }
         translate([0,bath_h+p+ms])
         {
            square([r_d, ms]);
         }
      }

   }
   translate([r_d+w/2, bath_h])
   {
      circle(r=w/2);
   }
}
