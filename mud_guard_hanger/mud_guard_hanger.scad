// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// NN
//
// © 2018–2019 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0

/* [Global] */

// … to preview. You will get all parts as separate STLs when you click “Create Thing”.
part = "s"; // [s: Set, a: Part A, b: Part B]

// Set this to “render” and click on “Create Thing” when done with the setup.
preview = 1; // [0:render, 1:preview]

/* [Sizes] */

// bla bla
b=38;
h=7.46;
pw=20;
ph=24;
rh=3.2;
l_s=11.4;
h_lh=3.65;
ed=23;
r_hk=1.7;
w_hk=1.8;

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

r = b*b/(8*h) + h/2;

haw = asin(b/(2*r));



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
      part_a();
   }

}

module preview_parts()
{
   part_a();
}

module stack_parts()
{
   // intersection()
   {
      color("yellow")
      {
         part_a();
      }

   }
}

// *******************************************************
// Code for the parts themselves
module part_t()
   {plate();}

module part_a()
{
   difference()
   {
      union()
      {
         sarc();
         linear_extrude(w)
         {
            plate();
         }
      }
      harc();
   }
   kmirror()
   {
      // translate([b/2,-r_hk+ms])
      translate([b/2+r_hk+1,0])
      linear_extrude(ed)
      {
         difference()
            {
               circle(r_hk+w_hk);
               circle(r_hk);
               translate([-r_hk-w_hk-w_hk*0.2,-r_hk-w_hk])
               {
                  square([r_hk+w_hk,r_hk+w_hk]);
               }
            }
      }
   }
}


module sarc()
{
   intersection()
   {
      translate([0,-r+h, 0])
      {
         linear_extrude(ed)
         {
            circle(r+w);
         }
      }
      translate([-b/2, -r, -ms])
      cube([b, 2*r, 25]);
   }
}


module harc()
{
   translate([0,-r+h, -ms])
   {
      linear_extrude(ed+2*ms)
      {
         circle(r);
      }
   }

}

module plate()
{
   intersection()
   {
      difference()
      {
         translate([-pw/2, h])
         {
            square([pw, r+ph+2+w]);
         }
         translate([0,rh+h_lh+h])
         {
            circle(rh);
            translate([0,l_s])
            {
               circle(rh);
            }
         }
         translate([-rh,rh+h_lh+h])
         {
            square([2*rh,l_s]);
         }
      }
      translate([0,h+ph+w-r])
      {
         circle(r);
      }
   }
}
