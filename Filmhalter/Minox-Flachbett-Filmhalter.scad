// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// Holder for Minox film strips
//
// A holder for Minox 10 picture film strips for use with generic flatbed
// scanners with a transparency unit and holder for 135 (35 mm) film.
//
// © 2018 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0


// … to preview. You will get all parts when you click “Create Thing”.
part = "Halter"; // [Halter: Halter, Klemme: Klemme]

// Set this to “render” and click on “Create Thing” when done with the setup.
preview = 1; // [0:render, 1:preview]

w_loch = 24;
w_streifen = 9.2;
w_bild = 8;
l_streifen = 131;

p_h = 2;
p_k = 3;

/* [Hidden] */

// Done with the customizer

// *******************************************************
// Extra parameters. These can be changed reasonably safely.


// w = 1.8;  // Wall width
// p = 1.2;  // Bottom, top plate height
c = 0.2;  // Clearance
angle = 60; // Overhangs much below 60° are a problem for me

// *******************************************************
// Some shortcuts. These shouldn’t be changed

tau = 2 * PI;  // π is still wrong. τ = ⌀ ÷ r

xy_factor = 1/tan(angle);
// To get from a height to a horizontal width inclined correctly
z_factor = tan(angle);  // The other way around

w_halter = w_loch - c;
w_k = w_streifen + c;
w_nut = w_k + c;
w_steg = (w_halter - 2* w_nut) / 3;
echo("w_steg", w_steg);
w_x = 1.8;
b_nase = 3;
g_nase = b_nase + c;
l_loch_k = l_streifen + c;
l_loch_h = l_loch_k + c;
l_k = l_loch_k + 2 * w_x + c;
l_halter = l_k  + c + 2 * w_x;
w_loch_h = w_bild + c;
h_halter = p_h + p_k;

y_nut = w_steg/2 + w_nut/2;

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

// print_part();
preview_parts();
// stack_parts();



module print_part()
{
   if ("Halter" == part)
   {
      halter();
   }
   if ("Klemme" == part)
   {
      klemme();
   }
}

module preview_parts()
{
   halter();
   translate([some_distance, 0, 0])
   {
      klemme();
   }
}

module stack_parts()
{
   // intersection()
   {
      color("yellow")
      {
         halter();
      }
      translate([0,-ko, p_h])
      {
         color("red")
         {
            klemme();
         }
      }
      translate([0,+ko, p_h])
      {
         color("red")
         {
            klemme();
         }
      }
   }
}

// *******************************************************
// Code for the parts themselves


module halter()
{
   difference()
   {
      translate([0, 0, h_halter/2])
      {
         cube([l_halter, w_halter, h_halter], center=true);
      }
      filmloch_halter();
      mirror([0,1,0])
      {
         filmloch_halter();
      }
   }
}

module filmloch_halter()
{
   translate([0, y_nut, 0])
   {
      cube([l_loch_h, w_loch_h, 2*h_halter+2*ms], center=true);
      translate([0,0, p_h+p_k/2+ms])
      {
         cube([l_halter+2*ms, w_nut, p_k+2*ms], center=true);
      }
   }

}

module klemme()
{}
