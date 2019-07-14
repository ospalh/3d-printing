// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// NN
//
// © 2018–2019 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0

/* [Global] */


// … to preview. You will get all parts as separate STLs when you click “Create Thing”.
part = "a"; // [t: test, a: Badge]


// Set this to “render” and click on “Create Thing” when done with the setup.
preview = 1; // [0:render, 1:preview]

/* [Sizes] */

// Size of the completed badge. Or just scale it
badge_size = 100;  // [25:5:150]

/* [Hidden] */

f_tr = 0.65;  // factor for inner text ring
de_text = 84; // effective text diameter;
bohnen_size = 115;

r_b = badge_size/2;
r_tr = r_b * f_tr;
txt_factor = badge_size / de_text;
bohnen_factor = 0.6 * badge_size / bohnen_size;

h_bl = 0.4;  // hight of black pot
h_rd = 0.4;  // hight of red pot



// Done with the customizer

// *******************************************************
// Extra parameters. These can be changed reasonably safely.


w = 1.8;  // Wall width
p = 0.8;  // Bottom, top plate hight
c = 0.4;  // Clearance
angle = 60; // Overhangs much below 60° are a problem for me


h_rd_t = p + h_rd;
h_t = p + h_rd + h_bl;

// *******************************************************
// Some shortcuts. These shouldn’t be changed

tau = 2 * PI;  // π is still wrong. τ = circumference / r

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
ra = 2;
rs = 0.25;
function na() = (preview) ? pna : rna;
function nb() = (preview) ? pnb : rnb;
$fs = (preview) ? ps : rs;
$fa = (preview) ? pa : ra;

// *******************************************************
// End setup


use <Barista textpfad.scad>
use <Vier Bohnen.scad>


// *******************************************************
// Generate the parts

print_part();


if ("t" == part)
{
   color ("red")
   {
      rote_bohnen_3d();
   }
   color("black")
   {
      schwarze_bohne_3d();
   }
   // schwarze_bohne();
   // rote_bohnen();
}


module print_part()
{
   if ("a" == part)
   {
      barista_barista_badge();
   }
}

// *******************************************************
// Code for the parts themselves


module barista_barista_badge()
{
   difference()
   {
      ring_badge();
      barista_text_3d();
   }
   translate([-0.04*r_b, 0.01*r_b,0])
   {
      bohnen();
   }
}

module ring_badge()
{
   color("white")
   {
      cylinder(r=r_b, h=p);
   }

   translate([0,0,p-ms])
   {
      difference()
      {
         color("red")
         {
            cylinder(r=r_b, h=h_rd+ms);
         }
         translate([0,0,-ms])
         {
            cylinder(r=r_tr, h=h_rd+3*ms);
         }
      }
   }
   translate([0,0,p+h_rd-ms])
   {
      difference()
      {
         color("black")
         {
            cylinder(r=r_b, h=h_bl+ms);
         }
         translate([0,0,-ms])
         {
            cylinder(r=r_tr, h=h_bl+3*ms);
         }
      }
   }



}




module barista_text_3d()
{
   // [-105.0, 148.5]
   translate([0,0,p])
   {
      linear_extrude(h_rd+h_bl+ms)
      {
         scale([txt_factor, txt_factor])
         {
            translate([8,-67])
            {
               barista_barista_text();
            }
         }
      }
   }
}

module bohnen()
{
   color ("red")
   {
      rote_bohnen_3d();
   }
   color("black")
   {
      schwarze_bohne_3d();
   }

}

module rote_bohnen_3d()
{
   translate([0,0,p-ms])
   {
      linear_extrude(h_rd+ms)
      {
         scale([bohnen_factor, bohnen_factor])
         {
            rote_bohnen();
         }
      }
   }
}

module schwarze_bohne_3d()
{
   translate([0,0,p-ms])
   {
      linear_extrude(h_rd+h_bl+ms)
      {
         scale([bohnen_factor, bohnen_factor])
         {
            schwarze_bohne();
         }
      }
   }

}
