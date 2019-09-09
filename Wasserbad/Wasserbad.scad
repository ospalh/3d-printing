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
// p = 1.2;  // Bottom, top plate hight
c = 0.4;  // Clearance

r_r = 2;  // rounding radius

// *******************************************************
// Some shortcuts. These shouldn’t be changed

tau = 2 * PI;  // π is still wrong. τ = circumference / r

xy_factor = 1/tan(bath_angle);
// To get from a hight to a horizontal width inclined correctly
z_factor = tan(bath_angle);  // The other way around

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


x_k = r_m * sin(bath_angle);
h_k = r_m * (1 - cos(bath_angle));
h_r = bath_h - h_k - w;
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

bain_marie();
// 2d_bath();

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
   difference()
   {
      translate([0,0,2*ms])
      {
         cylinder(r=r_p+w+c, h=h_c_e, $fn=na());
      }
      translate([0,0,ms])
      {
         cylinder(r=r_p+c, h=h_c_e+4*ms, $fn=na());
      }
   }
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
      cylinder(r=r_rs, h=w_water+w-ms);
   }
}

module 2d_bath()
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
         rotate(bath_angle)
         {
            translate([0,-r_r-w-ms])
            {
               square([r_a+ms,r_r+r_a+w+ms]);
            }
         }
      }
   }

   translate([r_z+x_k, w/2+h_k])
   {
      rotate(bath_angle)
      {
         translate([-ms, -w/2])
         {
            square([l_r+2*ms,w]);
         }
      }
   }
   translate([r_d,bath_h-w/2])
   {
      circle(r=w/2);
   }
}
