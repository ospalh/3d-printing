// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// NN
//
// © 2018 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0


// … to preview. You will get all parts when you click “Create Thing”.
part = "Halter"; // [Halter: Halte, Klemme: Klemme]

// Set this to “render” and click on “Create Thing” when done with the setup.
preview = 1; // [0:render, 1:preview]

w_loch = 24;
w_streifen = 9.2;
w_bild = 8;
l_streifen = 131;

p_h = 2;
p_k = 3;
h_h = p_h + p_k;

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
w_steg = (w_halter - w_nut) / 3;
echo("w_steg", w_steg);


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
   if ("NN" == part)
   {
      nn();
   }
   if ("foo" == part)
   {
      foo();
   }
}

module preview_parts()
{
   nn();
   translate([some_distance, 0, 0])
   {
      foo();
   }
}

module stack_parts()
{
   // intersection()
   {
      color("yellow")
      {
         foo();
      }
      translate([0,0,30])
      {
         color("red")
         {
            NN();
         }
      }
   }
}

// *******************************************************
// Code for the parts themselves
