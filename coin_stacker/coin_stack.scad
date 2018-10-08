// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// A set of cylindrical holes to store one set of euro coins.
//
// © 2018 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0


// … to preview. You will get all parts when you click “Create Thing”.
part = "stack"; // [stacker: coin stacker, lid: lid]



// Set this to “render” and click on “Create Thing” when done with the setup.
preview = 1; // [0:render, 1:preview]

/* [Hidden] */

p = 0.6;  // Bottom, top plate height

// *****************************************************************************
// Change the list below
// *****************************************************************************

coin_sizes = [
   // For each coin size, add a pair with diameter and stack height. Write
   // the stack height as number * height of one coin. Add p to the last
   // height to give space for the lid.
   [17, 5 * 1],  // FF 5 ¢ (centimes)
   [19.55, 6 * 2.05],  // ½ FF, kleiner als 10 ¢
   [20, 6 * 1.5],  // FF 10 ¢
   [22.9, 1 * 2.15],  // FF 10, klein für den Wert
   [23.6, 7 * 1.4],  // FF 20 ¢
   [24, 6 * 1.8],  // FF 1
   [26.3, 1 * 1.75],  // FF 2
   [28.9, 1 * 2.15 + p]  // FF 5
   ];

// *****************************************************************************
// Part to change over
// *****************************************************************************

// Change below to taste.

max_index = len(coin_sizes) - 1;


// Horizontal clearance. I use a lot here. Coins may rattle a bit in the final shape, but i am OK with that.
c = 1;  // [0.05:0.05:1.5]

// Height clearance.
ch = 0.2;  // [0.05:0.05:0.6]

/* [Hidden] */


// *******************************************************



w = 0.8;  // Wall width


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


// To make the whole no coin of this size situation easier, we just do the
// c_h for coins that are not there. I’ll call this a kludge. Whatever.

function coin_offset(n) = (n > 0) ? coin_offset(n-1) + coin_sizes[n-1][1] + ch : p;


function r_i(n) = coin_sizes[n][0]/2+c;
function h(n) = coin_sizes[n][1] + ch;

// Radius aussen unten.
function r_a_u(n) = (n > max_index-1) ? r_i(max_index) + w : max(r_i(n) + w, r_i(n+1) - h(n) * xy_factor);


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
         // Base plate. No cylindrical
         cylinder(r=r_a_u(0), h=p);
         for (i = [0 : max_index])
         {
            translate([0,0,coin_offset(i)-ms])
            {
               cylinder(r1=r_a_u(i), r2=r_a_u(i+1), h=h(i)+ms);
            }
         }
      }
      union()  // To make debuging (%) easier
      {
         for (i = [0 : max_index])
         {
            translate([0,0,coin_offset(i)-ms])
            {
               cylinder(r=r_i(i), h=h(i)+2*ms);
            }
         }
      }
   }
}

module lid()
{
   cylinder(d=coin_sizes[max_index][0], h=p);
}
