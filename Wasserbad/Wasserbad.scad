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
pot_d = 55;  // [30:0.5:240]
// Hight of the dish
dish_h = 70; // [30:1:120]

// Space for water
w_water = 15; // [5:0.5:24]

/* [Hidden] */

// Done with the customizer



// *******************************************************
// Extra parameters. These can be changed reasonably safely.

// Angle of the sides of the dish
dish_angle = 90; // [45:5:90]

h_c = 30;

h_c_e = min(h_c, (dish_h-w_water)/2) + w_water;
w = 1.8;  // Wall width
// p = 1.2;  // Bottom, top plate hight
c = 0.4;  // Clearance

r_r = 2;  // rounding radius

// *******************************************************
// Some shortcuts. These shouldn’t be changed

tau = 2 * PI;  // π is still wrong. τ = circumference / r

xy_factor = 1/tan(dish_angle);
// To get from a hight to a horizontal width inclined correctly
z_factor = tan(dish_angle);  // The other way around

r_p = pot_d/2;
r_d = r_p + w_water;
r_a = r_r + w;
r_m = r_r + w/2;
r_rs = r_p*0.2;


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

bain_marie();
// 2d_dish();

// *******************************************************
// Code for the parts themselves

module bain_marie()
{
   dish();
   pot_centerers();
   pot_raisers();
}

module dish()
{
   rotate_extrude()
   {
      2d_dish();
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
                  cube([r_d, 2*r_rs, 2*dish_h]);
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
         cylinder(r=r_p+w+c, h=h_c_e);
      }
      translate([0,0,ms])
      {
         cylinder(r=r_p+c, h=h_c_e+4*ms);
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
   translate([-r_p+1.6*r_rs, 0, ms])
   {
      cylinder(r=r_rs, h=w_water+w-ms);
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
            translate([0,-r_r-w-ms])
            {
               square([r_a+ms,r_r+r_a+w+ms]);
            }
         }
      }
   }

   translate([r_z+x_k, w/2+h_k])
   {
      rotate(dish_angle)
      {
         translate([-ms, -w/2])
         {
            square([l_r+2*ms,w]);
         }
      }
   }
   translate([r_d,dish_h-w/2])
   {
      circle(r=w/2);
   }
}
