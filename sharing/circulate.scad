// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// NN
//
// © 2018 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0

/* [Global] */

// Set this to “render” and click on “Create Thing” when done with the setup.
preview = 1; // [0:render, 1:preview]

/* [Sizes] */

//
text_font_size_1 = 8;  // [1:0.1:40]
text_font_size_2 = 12;  // [1:0.1:40]
arrow_font_size = 20;  // [1:0.1:40]
text_font = "Praxis LT:Heavy";
arrow_font = "Symbola";

/* [Hidden] */

// Done with the customizer

// *******************************************************
// Extra parameters. These can be changed reasonably safely.


w = 1.8;  // Wall width
p = 1.2;  // Bottom, top plate height
c = 0.4;  // Clearance
h_t = 2;
angle = 60; // Overhangs much below 60° are a problem for me

// *******************************************************
// Some shortcuts. These shouldn’t be changed

tau = 2 * PI;  // π is still wrong. τ = circumference / r

xy_factor = 1/tan(angle);
// To get from a height to a horizontal width inclined correctly
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

// circulate_stamp();
text_stamp();



// *******************************************************
// Code for the parts themselves

module text_stamp()
{
   linear_extrude(h_t+ms)
   {
      2d_text();
   }
}


module 2d_text()
{
   translate([-38,-2])
   {
      text(
         text="⮎", font=arrow_font, size=arrow_font_size,
         valign="center", halign="right");
   }
   translate([0,0.02*text_font_size_1])
   {
      text(
         text="Keep circulating", font=text_font, size=text_font_size_1,
         valign="bottom", halign="center");
   }
   translate([0,-0.02*text_font_size_2])
   {
      text(
         text="the books!", font=text_font, size=text_font_size_2,
         valign="top", halign="center");
   }
   translate([39,-1])
   {
      text(
         text="⮌", font=arrow_font, size=arrow_font_size,
         valign="center", halign="left");
   }
}
