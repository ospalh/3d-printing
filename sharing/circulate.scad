// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// A stamp
//
// © 2018–2019 Roland Sieker <ospalh@gmail.com>
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
arrow_o = 38;

/* [Hidden] */

// Done with the customizer

// *******************************************************
// Extra parameters. These can be changed reasonably safely.


w = 1.8;  // Wall width
p = 0.6;  // Bottom, top plate hight
c = 0.4;  // Clearance
h_t = 2;
h_st_1 = 20;
h_st_2 = 8;
h_st_3 = 8;
angle = 60; // Overhangs much below 60° are a problem for me

r1 = 4;
r2 = 2;
r3 = 1;
sp_2 = 12;

// *******************************************************
// Some shortcuts. These shouldn’t be changed

tau = 2 * PI;  // π is still wrong. τ = circumference / r

xy_factor = 1/tan(angle);
// To get from a hight to a horizontal width inclined correctly
z_factor = tan(angle);  // The other way around


some_distance = 50;
ms = 0.01;  // Muggeseggele.

fof = 0.25*(text_font_size_1 - text_font_size_2);

// fn for differently sized objects and fs, fa; all for preview or rendering.
pna = 40;
pnb = 15;
pa = 5;
ps = 1;
rna = 180;
rnb = 30;
ra = 1.6;
rs = 0.25;
function na() = (preview) ? pna : rna;
function nb() = (preview) ? pnb : rnb;
$fs = (preview) ? ps : rs;
$fa = (preview) ? pa : ra;

// *******************************************************
// End setup



// *******************************************************
// Generate the parts

circulate_stamp();
// stamp_grid();


// *******************************************************
// Code for the parts themselves

module circulate_stamp()
{
   text_stamp();
   stamp_back();
   stamp_grid();
   stem();
}

module stamp_back()
{
   translate([0,0,h_t])
   {
      linear_extrude(p)
      {
         hull()
         {
            2d_text();
         }
      }
   }
}



module stamp_grid()
{
   translate([0,0,h_t+p])
   {
      intersection()
      {
         linear_extrude(r1+ms)
         {
            hull()
            {
               2d_text();
            }
         }
         translate([0, fof, 0])
         {
            grid();
         }
      }
   }
}

module grid()
{
   rotate([0,90,0])
   {
      cylinder(r=r1, h=3.5*arrow_o, center=true);
   }
   rotate([90,0,0])
   {
      for (xo=[-1.75*arrow_o:sp_2:1.75*arrow_o])
      {
         translate([xo,0,0])
         {
            cylinder(r=r2, h=3*text_font_size_1, center=true);
         }
      }
   }
   rotate([0,90,0])
   {
      translate([0,0.66*text_font_size_2,0])
      {
         cylinder(r=r3, h=3.5*arrow_o, center=true);
      }
      translate([0,-0.66*text_font_size_2,0])
      {
         cylinder(r=r3, h=3.5*arrow_o, center=true);
      }

   }

}

module stem()
{
   translate([0, fof, h_t+p])
   {
      difference()
      {
         union()
         {
            cylinder(r=r1, h=h_st_1+ms);
            translate([0,0,h_st_1])
            {
               cylinder(r1=r1, r2=2*r1,h=h_st_2+ms);
            }
            translate([0,0,h_st_1+h_st_2])
            {
               cylinder(r=2*r1,h=h_st_3);
            }
         }
         translate([0,0,h_st_1+h_st_2+h_st_3-1])
         {
            linear_extrude(1+ms)
            {
               text("Kc", size=2*r1, halign="center", valign="bottom", font=text_font);
               text("tb", size=2*r1, halign="center", valign="top", font=text_font);
            }
         }
      }
   }
}

module text_stamp()
{
   linear_extrude(h_t+ms)
   {
      2d_text();
   }
}


module 2d_text()
{
   translate([-arrow_o,-2])
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
   translate([arrow_o+1,-1])
   {
      text(
         text="⮌", font=arrow_font, size=arrow_font_size,
         valign="center", halign="left");
   }
}
