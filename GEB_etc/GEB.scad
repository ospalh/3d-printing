// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// The GEB cube from the cover of Gödel, Escher, Bach.
// Or any other three characrter combination in the same style. EGB works, many others not.
//
// © 2018–2019 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0

/* [Global] */

// The part to create.
part = "square_test"; // [tlc: three letter cube,  square_test: squareness test]

// Set this to “render” and click on “Create Thing” when done with the setup.
preview = 1; // [0:render, 1:preview]

/* [Text] */

// Letter One. Make sure the letters fill up most of the square. Otherwise it will not work.
letter_1 = "G";

// Letter Two. Use square_test and tweak to fill the quares
letter_2 = "E";

// Letter Three. Also make sure the characters are in one piece. Otherwise the end result will fall apart
letter_3 = "B";

/* [Size and typeface] */

// Size, but rescaling should work
size = 20; // [5:1:100]

// Typeface. There is a list somewhere which ones work online, or download and use one you have on your computer.
type = "Praxis Next Dan:style=Black";

/* [Tweaks] */

// Scale letter 1 horizontally
l1_x_tweak = 1.08;  // [0.25:0.01:4]
// Shift letter 1 horizontally
l1_x_offset = 0;  // [-10:0.01:10]


// Scale letter 1 vertically
l1_y_tweak = 1.08;  // [0.25:0.01:4]
// Shift letter 1 vertically
l1_y_offset = 0;  // [-10:0.01:10]




// Scale letter 2 horizontally
l2_x_tweak = 1.08;  // [0.25:0.01:4]
// Shift letter 2 horizontally
l2_x_offset = 0;  // [-10:0.01:10]

// Scale letter 2 vertically
l2_y_tweak = 1.08;  // [0.25:0.01:4]
// Shift letter 1 vertically
l2_y_offset = 0;  // [-10:0.01:10]

// Scale letter 3 horizontally
l3_x_tweak = 1.08; // [0.25:0.01:4]
// Shift letter 3 horizontally
l3_x_offset = 0;  // [-10:0.01:10]

// Scale letter 3 vertically
l3_y_tweak = 1.08;  // [0.25:0.01:4]
// Shift letter 1 vertically
l3_y_offset = 0;  // [-10:0.01:10]

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


tau = 2 * PI;  // π is still wrong. τ = circumference / r


some_distance = 50;
ms = 0.01;  // Muggeseggele.

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

print_part();




module print_part()
{
   if (part == "tlc")
   {
      twc(letter_1, letter_2, letter_3);
   }
   else
   {
      square_test();
   }
}


// *******************************************************
// Code for the parts themselves


module twc(l1, l2, l3)
{
   intersection()
   {
      translate([0, size/2, 0])
         rotate([90,0,90])
         onel(l1, l1_x_tweak, l1_y_tweak, l1_x_offset, l1_y_offset);
      translate([size/2, size, 0])
         rotate([90,0,0])
         onel(l2, l2_x_tweak, l2_y_tweak, l2_x_offset, l2_y_offset);
      translate([size/2,0,0])
         onel(l3, l3_x_tweak, l3_y_tweak, l3_x_offset, l3_y_offset);
   }
}


module onel(tl, xtw, ytw, xoff, yoff)
{
   translate([xoff,yoff,-ms])
      scale([xtw, ytw, 1])
      linear_extrude(size+2*ms)
      text(text=tl, size=size, font=type, halign="center");

}


module square_test()
{

   color("green")
      {
         translate([size/2,0,0])
         {
         onel(letter_1, l1_x_tweak, l1_y_tweak, l1_x_offset, l1_y_offset);
         translate([1.15*size, 0, 0])
            onel(letter_2, l2_x_tweak, l2_y_tweak, l2_x_offset, l2_y_offset);
         translate([2.3*size, 0, 0])
            onel(letter_3, l3_x_tweak, l3_y_tweak, l3_x_offset, l3_y_offset);
         }
      }
   color("red")
   {
      tframe();
      translate([1.15*size, 0, 0])
         tframe();
      translate([2.3*size, 0, 0])
         tframe();
   }
}

module tframe()
{
   translate([-1, -1, 0])
   difference(){
      cube([size+2, size+2, size]);
      translate([1,1, -ms])
         cube([size, size, size+2*ms]);
      }
}
