// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// NN
//
// © 2017 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0


// … to preview. You will get all parts when you click “Create Thing”.
part = "NN"; // [NN: foo, bar: baz]

// Set this to “render” and click on “Create Thing” when done with the setup.
preview = 1; // [0:render, 1:preview]



/* [Hidden] */

// Done with the customizer

w = 1.8;  // external wall width
p = 1.2;  // height of the bottomt plate

// *******************************************************
// Some shortcuts. These shouldn’t be changed

tau = 2 * PI;  // π is still wrong. τ = ⌀ ÷ r
angle = 60; // Overhangs much below 60° are a problem for me

some_distance = 50;
ms = 0.01;  // Muggeseggele.

// fn for differently sized objects, for preview or rendering.
pfa = 40;
pfb = 15;
rfa = 180;
rfb = 30;
function fa() = (preview) ? pfa : rfa;
function fb() = (preview) ? pfb : rfb;

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
