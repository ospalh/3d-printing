// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// Holder for Minox film strips
//
// A holder for Minox 11 picture film strips for use with generic flatbed
// scanners with a transparency unit and holder for 135 (35 mm) film.
//
// © 2018 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0


// … to preview. You will get all parts when you click “Create Thing”.
part = "Halter"; // [Halter: Halter, Klemme: Klemme]

// Set this to “render” and click on “Create Thing” when done with the setup.
preview = 1; // [0:render, 1:preview]
// I put this in every design, but it shouldn’t make a difference on this one.

w_loch = 26;
// w_streifen = 9.2;  // real width
w_streifen = 9.7;  // slightly more so the movable part becomes more stable
w_bild = 8;
l_bild = 13.1;
bilder_ps = 11;


p_h = 1;
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
w_steg = (w_halter - 2 * w_nut) / 3;
w_x = 1.8;
b_nase = 3;
b_nnut = b_nase + c;
l_streifen = l_bild * bilder_ps;
l_loch_k = l_streifen + c;
l_loch_h = l_loch_k + c;
l_k = l_loch_k + 2 * w_x + c;
l_halter = l_k  + c + 2 * w_x;
w_loch_h = w_bild + c;
h_halter = p_h + p_k;

y_nut = w_steg/2 + w_nut/2;

xo_o = l_k/2 - w_x - 1.5 * b_nnut;
xo_u = l_k/6;

some_distance = 0.6 * w_halter + 0.6 * w_streifen + w_steg;
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
      union()
      {
         translate([0, -y_nut, p_h+ms])
         {
            color("red")
            {
               klemme();
            }
         }
         translate([0, y_nut, p_h+ms])
         {
            color("red")
            {
               klemme();
            }
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
      filmloch_halter(true);
      filmloch_halter(false);
   }
}

module filmloch_halter(ot)
{
   yo = ot ? y_nut : -y_nut;
   translate([0, yo, 0])
   {
      cube([l_loch_h, w_loch_h, 2*h_halter+2*ms], center=true);
      translate([0,0, p_h+p_k/2+ms])
      {
         cube([l_halter+2*ms, w_nut, p_k+2*ms], center=true);
      }
      vier_nn(true);
   }
}

module eine_nn(xo, ot, nutnase)
{
   w_nn = nutnase ? b_nnut : b_nase;
   y_nn = nutnase ? w_steg + 2*ms : w_steg - c + ms;
   w_b = nutnase ? w_nut : w_streifen;
   yo = w_b/2 + y_nn/2 - ms;
   yot = ot ? yo : -yo;
   zo = nutnase ? p_h + ms : 0;
   translate([xo, yot, zo+p_k/2])
   {
      cube([w_nn, y_nn, p_k+ms], center=true);
   }
}

module vier_nn(nutnase)
{
   eine_nn(xo_o, true, nutnase);
   eine_nn(-xo_o, true, nutnase);
   eine_nn(xo_u, false, nutnase);
   eine_nn(-xo_u, false, nutnase);
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
   vier_nn(false);
}