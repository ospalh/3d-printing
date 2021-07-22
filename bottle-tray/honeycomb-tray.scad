// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// Parametric hex-grid incense stick pack tray
//
// © 2017–2020 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0
// Loosely based on thingiverse thing  1345795,
// https://www.thingiverse.com/thing:1345795
// by Ian Pegg, https://www.thingiverse.com/deckingman/about
// CC-BY, Feb 2016
// And using an idea (the holes) by Tomas Ebringer
// https://www.thingiverse.com/Shii/about
// https://www.thingiverse.com/thing:1751410
// CC-BY, Sep 2016

/* [Sizes] */

// All length are in mm. This is the size from flat to flat
pack_diameter = 56;  // [8:0.1:90]
// TODO change

// Number of packs in a long row.  Every other row is one position shorter.
x_count = 4;  // [2:1:10]
// Number of rows.
y_count = 3;  //  [2:1:10]

// Start with short row
start_short = true;

// Hight of the walls of the holders
hight = 70; // [1:0.1:150]

// Size of the hole in the bottom of each holder. 0 for no hole, larger than the diameter for just cylinders
hole_diameter = 30; // [0:0.1:91]


/* [Hidden] */

// Done with the customizer

// *******************************************************
// Extra parameters. These can be changed reasonably safely.


w = 1.8;  // Wall width
p = 1.2;  // Bottom, top plate hight
c = 0.4;  // Clearance
angle = 60; // Overhangs much below 60° are a problem for me

// *******************************************************
// Some shortcuts. These shouldn’t be changed


module kmirror(maxis=[1, 0, 0])
{
   // Keep *and* mirror an object. Standard is left and right mirroring.
   children();
   mirror(maxis)
   {
      children();
   }
}

tau = 2 * PI;  // π is still wrong. τ = circumference / r

xy_factor = 1/tan(angle);
// To get from a hight to a horizontal width inclined correctly
z_factor = tan(angle);  // The other way around


ms = 0.01;  // Muggeseggele.

preview = false;
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



// *******************************************************
// Generate the parts

holder();

// *******************************************************
// Code for the parts themselves


// ***************************************************
// Change below only if you know what you are doing.

thf = sqrt(3)/2;  // (equilateral) triangle hight factor

// r_i = (pack_diameter/2  * thf) + c;
r_i = (pack_diameter/2 + c)/thf;
r_h = hole_diameter/2;
r_o = r_i + w;

// Some of these are redundant here, i think.
x_step = (2*r_i + w)*thf;
y_step = x_step * thf;


module holder()
{
   difference()
   {
      full_shape();
      holes();
   }
}

module full_shape()
{
   for (y_c = [0:y_count-1])
   {
      if ((y_c%2==0) != start_short)
      {
         // Even, long row
         for (x_c = [0:x_count-1])
         {
            one_cylinder(x_c*x_step, y_c*y_step);
         }
      }
      else
      {
         // Odd, short row
         for (x_c = [0:x_count-2])
         {
            one_cylinder((x_c+0.5)*x_step, y_c*y_step);
         }
      }
   }
}


module holes()
{
   for (y_c = [0:y_count-1])
   {
      if ((y_c%2==0) != start_short)
      {
         // Even, long row
         for (x_c = [0:x_count-1])
         {
            one_hole(x_c*x_step, y_c*y_step);
         }
      }
      else
      {
         // Odd, short row
         for (x_c = [0:x_count-2])
         {
            one_hole((x_c+0.5)*x_step, y_c*y_step);
         }
      }
   }
}



module one_hole(x_pos, y_pos)
{
   translate([x_pos, y_pos, 0])
   {
      translate([0, 0, p])
      {
         rotate(30)
         {
            cylinder(r=r_i, h=hight, $fn=6);
         }
      }
      if (hole_diameter)
      {
         translate([0,0, -ms])
         {
            rotate(30)
            {
               cylinder(r=r_h, h=p+2*ms, $fn=6);
            }
         }
      }
   }
}

module one_cylinder(x_pos, y_pos)
{
   translate([x_pos, y_pos, 0])
   {
      rotate(30)
      {
         cylinder(r=r_o, h=hight, $fn=6);
      }
   }
}
