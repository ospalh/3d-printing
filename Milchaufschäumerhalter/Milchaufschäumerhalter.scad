// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// A stand for my (Severin) milk frother.
//
// © 2018–2019 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0

/* [Global] */

// … to preview. You will get all parts as separate STLs when you click “Create Thing”.
part = "s"; // [s: set, a: upper holder, b: base, t: test, st: stack]

// Set this to “render” and click on “Create Thing” when done with the setup.
preview = 1; // [0:render, 1:preview]

/* [Sizes] */

// lower diameter
d_1 = 14;  // [5:0.5:40]

// higher diameter
d_2 = 29;  // [5:0.5:40]

// hight of the holder bar
h = 16;   // [10:1:40]

// diameter of the milk frother itself
d_mf = 50; // [30:1:80]

// diameter of the gap for the axle
d_a = 2;  // [1:0.25:4]

// Hight added  to the stand. The hight of the top of the funnel will be the length of your pencil plus this.
extra_hight = 10; // [10:5:150]

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

r_mf = d_mf/2;
heh = 5; // Half the extra hight, in mm
es_h = 15; // Extra support/stabilizer hight
es_w = 0.8;
// Extra support/stabilizer width. Need not be as stable as a normal
// wall

tau = 2 * PI;  // π is still wrong. τ = circumference / r

xy_factor = 1/tan(angle);
// To get from a hight to a horizontal width inclined correctly
z_factor = tan(angle);  // The other way around


wiggle_room_factor = 1.05;

// The small radius of the support pencil, from center to center of face
r_p_s = 3.2 * wiggle_room_factor;
// The flat-to-flat diameter of a standard pencil is 6.4 mm. Do quite a
// bit more.
// The max. radius (center to edge).  Also the
// width of one pencil face.
r_p_l = r_p_s * 2 / 3 * sqrt(3);

// Used to calculate how heigh the lug that holds the handle is

// Tip angle
tip_a = 21;  // °. Apparently standard in Germany
// tip_a = 19;  // °. There is a German »Long Point« pencil sharpnener with 19 °.
// There are also rumors that American pencil are pointier than German ones.
// tip_a = 24 // °. Special color pencil sharpener.

// The tip angle is apparently from one side to the other side, not from
// one side to the center line.


// Size of the “big pencil” connector. Twice the area, half of it hollow.
r_bp_s = sqrt(2) * r_p_s;
r_bp_l = r_bp_s * 2 / 3 * sqrt(3);

sp_h = 8 * r_p_s;  // Hight of the sharpend pencil cylindrical connector bit
usp_h = 10 * r_p_s;  // Hight of the unsharpend pencil connector bit


bp_s_h = r_bp_s / tan(tip_a/2);


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


if ("s" == part)
{
   preview_parts();
}

if ("st" == part)
{
   // Use "st" during development
   stack_parts();
}

module print_part()
{
   if ("a" == part)
   {
      upholder();
   }
   if ("b" == part)
   {
      base();
   }
}

module preview_parts()
{
   upholder();
   translate([some_distance, 0, 0])
   {
      base();
   }
}

module stack_parts()
{
   // intersection()
   {
      color("yellow")
      {
         upholder();
      }
      translate([0,0,30])
      {
         color("red")
         {
            base();
         }
      }
   }
}

// *******************************************************
// Code for the parts themselves


module base()
{
   // hex_r = r_r + w + r_p_s;
   hex_r = r_mf/2 + r_bp_l;
//   hex_r_l = hex_r_s * 2 / 3 * sqrt(3);
   difference()
   {
      union()
      {
         // Construct the stand ring symmetric to xy plane …
         rotate(30)
         {
            rotate_extrude($fn=6)
            {
               translate([hex_r, 0, 0])
               {
                  circle(r=r_p_l, $fn=6);
               }
            }
         }
      }
      // … and subtract everything below the xy plane.
      translate([0,0,-some_distance])
      {
         cylinder(r=some_distance, h=some_distance);
      }
   }
   // Fill the base plate
   rotate(30)
   {
      cylinder(r=hex_r, h=2*p, $fn=6);
   }
   kmirror([0,1,0])
   {
      translate([0, hex_r, 0])
      {

         rotate(30)
         {
            difference()
            {
               union()
               {
                  // Three segments of linear extrusion
                  // The extra
                  cylinder(h=heh, r=r_p_l,$fn=6);
                  // The sharpend bit
                  translate([0, 0 , heh])
                  {
                     cylinder(h=bp_s_h, r1=r_p_l, r2=r_bp_l,$fn=6);
                  }
                  // The shaft bit
                  translate([0, 0 , bp_s_h+heh])
                  {
                     cylinder(h=sp_h, r=r_bp_l, $fn=6);
                  }
                  // The extra plates. Should not interfere with the stand
                  // without this. Anyway.
                  rotate(-60)
                  {
                     extra_plate();
                  }
                  rotate(180)
                  {
                     extra_plate();
                  }
               }
               // Hollow it out
               translate([0, 0 , heh])
               {
                  cylinder(h=bp_s_h, r1=0, r2=r_p_l, $fn=6);
               }
               translate([0, 0 , bp_s_h+heh])
               {
                  cylinder(h=sp_h+1,r=r_p_l, $fn=6);
               }

            }
         }
      }

   }
}

module extra_plate()
{
   es_s_p = [
      [0, 0],
      [es_h + r_p_l/2, 0],
      [0, es_h + r_p_l/2]
      ];
   rotate([90, 0, 0])
   {
      translate([r_p_s, 0.5*r_p_l, 0])
      {
         linear_extrude(p)
         {
            #polygon(es_s_p);
         }
      }
   }
}
