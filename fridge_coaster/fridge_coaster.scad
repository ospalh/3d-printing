// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// A simple “coaster” to stop condiment bottles from falling over when
// placed on the bars of a the grid in the fridge
//
// © 2018 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0


// Set this to “render” and click on “Create Thing” when done with the setup.
preview = 1; // [0:render, 1:preview]

spacing = 18.4;
bar_width = 2.8;
height = 17;
diameter = 56;
flange = 3;

count = 3;

/* [Hidden] */

// Done with the customizer

// *******************************************************
// Extra parameters. These can be changed reasonably safely.


w = 1.8;  // Wall width
p = 1.2;  // Bottom, top plate height
c = 0.4;  // Clearance
angle = 60; // Overhangs much below 60° are a problem for me

// *******************************************************
// Some shortcuts. These shouldn’t be changed

tau = 2 * PI;  // π is still wrong. τ = ⌀ ÷ r

xy_factor = 1/tan(angle);
// To get from a height to a horizontal width inclined correctly
z_factor = tan(angle);  // The other way around


rie = diameter/2 + c;

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

function fe() = (count > 1) ? flange : 0;

// *******************************************************
// End setup



// *******************************************************
// Generate the parts

fridge_coaster();

// *******************************************************
// Code for the parts themselves


module fridge_coaster()
{
   hrc = ceil((rie+w+bar_width+flange)/spacing) + 1;
   de = 2*rie+w;
   difference()
   {
      union()
      {
         for (o=[0:count-1])
         {
            translate([0,o*de,0])
            {
               echo("o",o);
               cylinder(r=rie+w, h=2*p+height);
            }
         }
         hull ()
         {
            translate([0, fe(), 0])
            {
               cylinder(r=rie+w+flange, h=2*p-ms);
            }
            translate([0, (count-1)*de -fe(),0])
            {
            cylinder(r=rie+w+flange, h=2*p-ms);
            }
         }
      }
      for (o=[0:count-1])
      {  translate([0,o*de,2*p])
         {
            cylinder(r=rie, h=height+ms);
         }
      }
      for (o=[-hrc:hrc])
      {
         echo(o);
         translate([(o+0.5)*spacing, (count-1)*de*0.5, 0])
         {
            cube([bar_width, 2*(rie+w+c+bar_width+flange+ms)+(count-1)*de, 2*p], center=true);
         }
      }
   }
}
