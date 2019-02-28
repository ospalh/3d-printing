// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// A simple "coaster" to stop condiment bottles from falling over when
// placed on the bars of a the grid in the fridge
//
// (c) 2018 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0


// Set this to "render" and click on "Create Thing" when done with the setup.
preview = 1; // [0:render, 1:preview]

// Distance from one bar of the fridge shelf grid to the next. All sizes are in millimetres.
bar_spacing = 18.4;  // [5:0.1:30]
// Diameter of one shelf grid bar
bar_width = 2.8;  // [0.5:0.1:7]
// Height of the coaster pot.
pot_height = 20;  // [3:0.5:50]
// Diameter of the bottle to hold
bottle_diameter_y = 56.5;  // [10:0.1:80]
bottle_diameter_x = 68.3;  // [10:0.1:80]
top_bottle_diameter_x = 56.5;  // [10:0.1:80]
// Width of the flange. How much the bottom is wider than the pot on top.
flange = 3;  // [0:0.5:15]

// How many same sized bottles to store in a row
number_of_pots = 1;  // [1:1:10]

/* [Hidden] */

// Done with the customizer

// *******************************************************
// Extra parameters. These can be changed reasonably safely.


w = 1.8;  // Wall width
p = 1.2;  // Bottom, top plate pot_height
c = 0.4;  // Clearance
angle = 60; // Overhangs much below 60 degrees are a problem for me

// *******************************************************
// Some shortcuts. These shouldn't be changed

tau = 2 * PI;  // pi is still wrong. tau = circumference / r

xy_factor = 1/tan(angle);
// To get from a pot_height to a horizontal width inclined correctly
z_factor = tan(angle);  // The other way around


riex = bottle_diameter_x/2 + c;
riey = bottle_diameter_y/2 + c;
ritx = bottle_diameter_x/2 + c;
factor_in = riey/riex;
factor_out = (riey+w)/(riex+w);



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

function fe() = (number_of_pots > 1) ? flange : 0;

// *******************************************************
// End setup



// *******************************************************
// Generate the parts

fridge_coaster();

// *******************************************************
// Code for the parts themselves


module fridge_coaster()
{
   hrc = ceil((riex+w+bar_width+flange)/bar_spacing) + 1;
   de = 2*riey+w;
   difference()
   {
      union()
      {
         for (o=[0:number_of_pots-1])
         {
            translate([0,o*de,2*p-ms])
            {
               scale([1,factor_out,1])
               {
                  cylinder(r1=riex+w, r2=ritx+w, h=pot_height+ms);
               }
            }
         }
         hull ()
         {
            translate([0, fe(), 0])
            {
               scale([1,factor_out,1])
               {
                  cylinder(r=riex+w+flange, h=2*p-ms);
               }
            }
            translate([0, (number_of_pots-1)*de -fe(),0])
            {
               scale([1,factor_out,1])
               {
                  cylinder(r=riex+w+flange, h=2*p-ms);
               }
            }
         }
      }
      for (o=[0:number_of_pots-1])
      {  translate([0,o*de,2*p])
         {
            scale([1,factor_in,1])
            {
               cylinder(r1=riex, r2=ritx, h=pot_height+2*ms);
            }
         }
      }
      for (o=[-hrc:hrc])
      {
         echo(o);
         translate([(o+0.5)*bar_spacing, (number_of_pots-1)*de*0.5, 0])
         {
            cube([bar_width, 2*(riex+w+c+bar_width+flange+ms)+(number_of_pots-1)*de, 2*p], center=true);
         }
      }
   }
}
