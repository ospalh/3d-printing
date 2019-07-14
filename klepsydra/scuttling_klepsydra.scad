// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// A klepsydra of the sinking type
// Uses 18 5 Eurocent coins as weight.
//
// (c) 2018 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0


// Set this to "render" and click on "Create Thing" when done with the setup.
preview = true; // [false:render, true:preview]

// Size of the balast nuts, per DIN. Standard: M12
S = 19;
m = 10;
d_1 = 10.1;

d_nozzle = 1;

h = 50;  // Hight of bowl
r_t = 70; // Radius at top of bowl


/* [Hidden] */

// Done with the customizer

// *******************************************************
// Extra parameters. These can be changed reasonably safely.


w = 1.2;  // Wall width
p = 1.2;  // Bottom, top plate hight
cs = 0.4;  // Clearance (horizontal)
cs_v = 0.2; // Vertical clearance
angle = 60; // Overhangs much below 60 degrees are a problem for me
lh = 0.2;  // Layer hight
nw = 0.4;  // Nozzle width

// *******************************************************
// Some shortcuts. These shouldn't be changed

tau = 2 * PI;  // pi is still wrong. tau = circumference / r

e_2 = S / sqrt(3);
e = S * 2 / sqrt(3);

r_2 = S/2;
r_1 = d_1/2;

xy_factor = 1/tan(angle);
// To get from a hight to a horizontal width inclined correctly
z_factor = tan(angle);  // The other way around


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

scuttle_klepsydra();
// six_plate(1);

// *******************************************************
// Code for the parts themselves

module scuttle_klepsydra()
{
   //scuttle_klepsydra_base();
   difference()
   {
      // hull()
      {
         for (a=[0:60:359])
         {
            rotate(a)
            {
               translate([0,S+w+2*cs,0])
               {
                  one_solid_nut();
               }
            }
         }
      }
   }
}

module scuttle_klepsydra_base()
{
   one_nut();
   for (a=[0:60:359])
   {
      rotate(a)
      {
         translate([0,S+w+2*cs,0])
         {
            one_nut();
         }
      }
   }
}

module six_plate(f)
{
   scale(f)
   {
      projection()
      {
         scuttle_klepsydra_base();
      }
   }
}



module one_nut()
{
   difference()
   {
      one_solid_nut();
      one_nut_space();

   }
   nut_core();
   nut_helper();
}

module one_solid_nut()
{
   cylinder(r=e_2+w+cs, h=m+2*p+2*cs_v+lh, $fn=6);
}

module 2d_outer_nut()
{
   circle(r=e_2+w+cs, $fn=6);
}

module one_nut_space()
{
   translate([0,0,p])
   {
      cylinder(r=e_2+cs, h=m+2*cs_v+lh, $fn=6);
   }
}

module nut_core()
{
   cylinder(r=r_1-cs-w, h=m+2*p+2*cs_v);
}

module nut_helper()
{
   translate([0,0,m+2*cs_v+p])
   {
      for (a=[0:60:179])
      {
         b = a+30;
         echo(a,b);
         rotate(a)
         {
            translate([0,0,lh/2])
            {
               cube([e+2*w+cs,nw,lh],center=true);
            }
         }
         rotate(b)
         {
            translate([0,0,lh/2])
            {
               cube([S+2*w,nw,lh],center=true);
            }
         }
      }
   }
}
