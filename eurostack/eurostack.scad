// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// A set of cylindrical holes to store one set of euro coins.
//
// © 2018 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0

/* [Global] */

// … to preview. You will get all parts when you click “Create Thing”.
part = "stack"; // [stacker: coin stacker, lid: lid]


// Set this to “render” and click on “Create Thing” when done with the setup.
preview = 1; // [0:render, 1:preview]


/* [Hidden] */

// Heights or thicknesses of the coins

h_001 = 1.67;
h_002 = h_001;
h_005 = h_001;
h_01 = 1.93;
h_02 = 2.14;
h_05 = 2.38;
h_1 = 2.33;
h_2 = 2.2;

// Diameters of the coins

d_001 = 16.25;
d_002 = 18.75;
d_005 = 21.2;  // !
d_01 = 19.75;  // Smaller than the 5 ¢. Things are swapped below
d_02 = 22.25;
d_05 = 24.25;  // !
d_1 = 23.25;  // Smaller than the 50 ¢. Swapped, too.
d_2 = 25.75;




// *******************************************************



w = 0.8;  // Wall width
p = 0.6;  // Bottom, top plate height
c = 0.4;  // Clearance
c_h = 0.2; //


// Some of these are from a template and not used in this design. Working out which exactly i could delete is too much work

angle = 55; // Overhangs much below 60° are a problem for me

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

// calculate some more values

// How high the whole thing
h_t = p + h_001 + c_h + h_002 + c_h + h_01 + c_h + h_005 + c_h + h_02 + c_h +
   h_1 + c_h + h_05 + c_h + h_2 + c_h + p;

// N.B.: 10 ¢ pieces have a smaller diameter than 5 ¢ pieces, as does the 1
// € coin and 50 ¢ coin. Below they are swapped. You should later
// stack them that way, too.


o_001 = p;
o_002 = o_001 + h_001 + c_h;
o_01 = o_002 + h_002 + c_h;
o_005 = o_01 + h_01 + c_h;
o_02 = o_005 + h_005 + c_h;
o_1 = o_02 + h_02 + c_h;
o_05 = o_1 + h_1 + c_h;
o_2 = o_05 + h_05 + c_h;

d_ex = 2*c+2*w;

d_o_2 = d_2 + d_ex;

d_o_05 = max(d_05+d_ex, d_o_2 - (h_05+c_h)*xy_factor);
d_o_1 = max(d_1+d_ex, d_o_05 - (h_1+c_h)*xy_factor);
d_o_02 = max(d_02+d_ex, d_o_1 - (h_02+c_h)*xy_factor);
d_o_005 = max(d_005+d_ex, d_o_02 - (h_005+c_h)*xy_factor);
d_o_01 = max(d_01+d_ex, d_o_005 - (h_01+c_h)*xy_factor);
d_o_002 = max(d_002+d_ex, d_o_01 - (h_002+c_h)*xy_factor);
d_o_001 = max(d_001+d_ex, d_o_002 - (h_001+p+c_h)*xy_factor);


// *******************************************************
// End setup

// Calculate some values

// *******************************************************
// Generate the parts

print_part();
// preview_parts();
// stack_parts();



module print_part()
{
   if ("stack" == part)
   {
      stack();
   }
   if ("lid" == part)
   {
      lid();
   }
}

module preview_parts()
{
   stack();
   translate([some_distance, 0, 0])
   {
      lid();
   }
}

module stack_parts()
{
   // intersection()
   {
      color("yellow")
      {
         stack();
      }
      translate([0,0,h_t-p])
      {
         color("red")
         {
            lid();
         }
      }
   }
}

// *******************************************************
// Code for the parts themselves


module stack()
{
   difference()
   {
      union()
      {
         cylinder(d1=d_o_001, d2=d_o_002, h=h_001+p+c_h+ms);
         translate([0,0,o_002])
         {
            cylinder(d1=d_o_002, d2=d_o_01, h=h_002+c_h+ms);
         }
         // First 10 ¢
         translate([0,0,o_01])
         {
            cylinder(d1=d_o_01, d2=d_o_005, h=h_01+c_h+ms);
         }
         // Only then the bigger 5 ¢
         translate([0,0,o_005])
         {
            cylinder(d1=d_o_005, d2=d_o_02, h=h_005+c_h+ms);
         }
         translate([0,0,o_02])
         {
            cylinder(d1=d_o_02, d2=d_o_1, h=h_02+c_h+ms);
         }
         translate([0,0,o_1])
         {
            cylinder(d1=d_o_1, d2=d_o_05, h=h_1+c_h+ms);
         }
         translate([0,0,o_05])
         {
            cylinder(d1=d_o_05, d2=d_o_2, h=h_05+c_h+ms);
         }
         translate([0,0,o_2])
         {
            cylinder(d=d_o_2, h=h_2+c_h+ms);
         }
      }
      union()  // To make debuging (%) easier
      {
         translate([0,0,o_001])
         {
            cylinder(d=d_001+2*c, h=h_t);
         }
         translate([0,0,o_002])
         {
            cylinder(d=d_002+2*c, h=h_t);
         }
         // First 10 ¢
         translate([0,0,o_01])
         {
            cylinder(d=d_01+2*c, h=h_t);
         }
         // Only then the bigger 5 ¢
         translate([0,0,o_005])
         {
            cylinder(d=d_005+2*c, h=h_t);
         }
         translate([0,0,o_02])
         {
            cylinder(d=d_02+2*c, h=h_t);
         }
         translate([0,0,o_05])
         {
            cylinder(d=d_05+2*c, h=h_t);
         }
         translate([0,0,o_1])
         {
            cylinder(d=d_1+2*c, h=h_t);
         }
         translate([0,0,o_2])
         {
            cylinder(d=d_2+2*c, h=h_t);
         }
      }
   }
}

module lid()
{
   cylinder(d=d_2, h=p);
}
