// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// kegelstumpfförmiger Becher für Bambusspießechen
//
// © 2018–2019 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0

/* [Global] */

// … to preview. You will get all parts as separate STLs when you click “Create Thing”.
part = "s"; // [s: simple mug, k: skewer mug, t: test shape]

// Set this to “render” and click on “Create Thing” when done with the setup.
preview = 1; // [0:render, 1:preview]

/* [Sizes] */

// Hight of the hollow
hight = 60;  // [20:1:150]

// bottom diameter
d_b = 45;  // [20:1:150]

// top diameter
d_t = 65;  // [20:1:150]


/* [Hidden] */

// Done with the customizer

// *******************************************************
// Extra parameters. These can be changed reasonably safely.


w = 1.2;  // Wall width
p = 1.2;  // Bottom, top plate hight
c = 0.4;  // Clearance
angle = 60; // Overhangs much below 60° are a problem for me
w_2 = 0.8;

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

if ("t" == part)
{

}

module print_part()
{
   if ("s" == part)
   {
      simple_mug();
   }
   if ("k" == part)
   {
      skewer_mug();
   }
}


// *******************************************************
// Code for the parts themselves

module simple_mug()
{
   cylinder(d=d_b+2*w, h=p+ms);
   difference()
   {
      cone(d_b/2+w, d_t/2+w, 0);
      cone(d_b/2, d_t/2, 2*ms);
   }
}

module skewer_mug()
{
   simple_mug();
   intersection()
   {
      cone(d_b/2+w/2, d_t/2+w/2,ms);
      union()
      {
         translate([-d_t,-w_2/2,0])
         {
            cube([2*d_t,w_2,2*hight]);
         }
         translate([-w_2/2,-d_t,0])
         {
            cube([w_2,2*d_t,2*hight]);
         }
      }
   }
}

module cone(rb, rt, o)
{
   translate([0,0,p-o])
   {
      cylinder(r1=rb, r2=rt, h=hight+2*o);
   }
}
