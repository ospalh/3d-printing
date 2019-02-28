// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// Holder for Minox film strips
//
// A holder for Minox 11 picture film strips for use with generic flatbed
// scanners with a transparency unit and holder for 135 (35 mm) film.
//
// (c) 2018 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0


// ... to preview. You will get all parts when you click "Create Thing".
part = "Halter"; // [Halter: Halter, Klemme: Klemme]

// Set this to "render" and click on "Create Thing" when done with the setup.
preview = 1; // [0:render, 1:preview]
// I put this in every design, but it shouldn't make a difference on this one.

w_loch = 24.6;
// w_streifen = 16;  // real width
w_streifen = 16.4;  // slightly more so the movable part becomes more stable
w_bild = 14; // Nominally 13. This should work out
l_bild = 25.4;
// Total pitch, picture plus number and hole. Measured. Not too
// important. Might be exactly 25.4 mm, as the format was made by
// Americans.
bilder_ps = 5;


p_h = 1;
p_k = 3;

/* [Hidden] */

// Done with the customizer

// *******************************************************
// Extra parameters. These can be changed reasonably safely.


// w = 1.8;  // Wall width
// p = 1.2;  // Bottom, top plate height
c = 0.4;  // Clearance
c_x = 0.4;
angle = 60; // Overhangs much below 60 degrees are a problem for me

// *******************************************************
// Some shortcuts. These shouldn't be changed

tau = 2 * PI;  // pi is still wrong. tau = circumference / r

xy_factor = 1/tan(angle);
// To get from a height to a horizontal width inclined correctly
z_factor = tan(angle);  // The other way around

w_halter = w_loch - c;
w_k = w_streifen + c;
w_nut = w_k + c;
w_steg = (w_halter - w_nut) / 2;
w_x = 1.8;
b_nase = 3;
b_nnut = b_nase + c_x;
l_streifen = l_bild * bilder_ps;
l_loch_k = l_streifen + c;
l_loch_h = l_loch_k + c;
l_k = l_loch_k + 2 * w_x + c;
l_halter = l_k  + c + 2 * w_x;
w_loch_h = w_bild + c;
h_halter = p_h + p_k;

xo_o = l_k/2 - b_nase;

some_distance = 0.6 * w_halter +  w_streifen + w_steg;
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

print_part();
// preview_parts();
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
   translate([0, some_distance, 0])
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
      translate([0, 0, p_h+2*ms])
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
   }
}

module filmloch_halter()
{
   cube([l_loch_h, w_loch_h, 2*h_halter+2*ms], center=true);
   translate([0,0, p_h+p_k/2+ms])
   {
      cube([l_halter+2*ms, w_nut, p_k+2*ms], center=true);
   }
   eine_kerbe();
   mirror()
   {
      eine_kerbe();
   }
}


module klemme()
{
   difference()
   {
      translate([0,0, p_k/2])
      {
         cube([l_k, w_streifen, p_k], center=true);
      }
      cube([l_streifen, w_bild, 3*p_k], center=true);
   }
   eine_nase();
   mirror()
   {
      eine_nase();
   }
}


module eine_nase()
{
   translate([xo_o, w_streifen/2-ms, 0])
   {
      cube([b_nase, w_steg + 0.5*c, p_k+ms]);
   }
}

module eine_kerbe()
{
   translate([xo_o-c_x, w_nut/2-ms, p_h])
   {
      cube([b_nase+2*w_x+2*c_x, w_steg + c + ms, p_k+ms]);
   }
}
