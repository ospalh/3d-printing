// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// ringförmiger Damestein
// annular draughts piece
//
// © 2018 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0

/* [Global] */


// Set this to “render” and click on “Create Thing” when done with the setup.
preview = 1; // [0:render, 1:preview]

/* [Sizes] */

d_g = 30;  // Gesamtdurchmesser
h_g = 10;  // Gesamthöhe
w_h = 5;  // Hauptwandstärke
d_m = 16.25;  // Münzdurchmesser. 1 ¢ (€) (Sollte ≤ d_g-2×w_h sein)
h_m = 1.67;  // Münzdicke oder -höhe (Sollte ≤ h_g/2 sein. Kein Problem)
d_r = 0.4;  // Dicke Riffelung
n_r = 42;  // Anzahl Riffelungen
r_vr = 2.4;  // Radius der Verrundung. Sollte < w_h/2 sein, der Einfachheit halber.
b_al = 1.5;  // Breite der Auflage für die Münze
r_wnk = 45;  // Winkel der Riffelung


/* [Hidden] */

// Done with the customizer

// *******************************************************
// Extra parameters. These can be changed reasonably safely.


c = 0.4;  // Clearance
angle = 60; // Overhangs much below 60° are a problem for me

// *******************************************************
// Some shortcuts. These shouldn’t be changed

tau = 2 * PI;  // π is still wrong. τ = circumference / r

xy_factor = 1/tan(angle);
// To get from a height to a horizontal width inclined correctly
z_factor = tan(angle);  // The other way around


some_distance = 50;
ms = 0.01;  // Muggeseggele.

r_g = d_g/2;
r_m = d_m/2;
r_ml = r_m + c; // Münzlochradius


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

stein();
// steinschnitt();
// stack_parts();  // Mit Testmünze


module stack_parts()
{
   // intersection()
   {
      color("yellow")
      {
         stein();
      }
      translate([0,0,h_g/2-h_m+ms])
      {
         color("red")
         {
            testmuenze();
         }
      }
   }
}

// *******************************************************
// Code for the parts themselves


module stein()
{
   difference()
   {
      rohstein();
      riffelung();
   }
}

module rohstein()
{
   rotate_extrude()
   {
      steinschnitt();
   }
}

module riffelung()
{
   halbriffelung(r_wnk);
   halbriffelung(-r_wnk);

}

module halbriffelung(wnk)
{
   w_sch = 360 / n_r;
   for(i=[0 : w_sch : 360-ms])
   {
      rotate(i)
      {
         riff(wnk);
      }
   }
}

module riff(wnk)
{
   translate([r_g+ms, 0, h_g/2])
   {
      rotate([wnk, 0,0])
      {
         rotate([0,0,45])
         {
            cube([d_r,d_r, 2*h_g+10*ms], center=true);
         }
      }
   }
}

module steinschnitt()
{
   rot_points = [
      [r_m-b_al, 0],
      [r_g-r_vr+ms, 0],
      [r_g-r_vr+ms, r_vr-ms],
      [r_g, r_vr-ms],
      [r_g, h_g-r_vr+ms],
      [r_g-r_vr+ms, h_g-r_vr+ms],
      [r_g-r_vr+ms, h_g],
      [r_g-w_h, h_g],
      [r_g-w_h, h_g/2],
      [r_ml, h_g/2],
      [r_ml, h_g/2-h_m],
      [r_m-b_al, h_g/2-h_m],
      ];
  polygon(rot_points);
  translate([r_g-r_vr, r_vr])
  {
     circle(r=r_vr);
     translate([0, h_g-2*r_vr])
     {
        circle(r=r_vr);
     }
  }
}

module testmuenze()
{
   cylinder(r=r_m, h=h_m);
}
