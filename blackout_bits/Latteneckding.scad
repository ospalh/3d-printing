// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// NN
//
// © 2018–2019 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0

/* [Global] */

// … to preview. You will get all parts as separate STLs when you click “Create Thing”.
part = "s"; // [s: Set, l: Lattenecke, m: linke Lattenecke mit Schlaufe, n: rechte Lattenecke mit Schlaufe, st: Stack]

// Set this to “render” and click on “Create Thing” when done with the setup.
preview = 1; // [0:render, 1:preview]

/* [Sizes] */

// Höhe der Latte
size_x = 37.5;  // [1:0.1:40]

// Tiefe der Latte
size_y = 17.2;  // [1:0.1:40]

// Länge der Latte im Halter
laenge = 100;  // [50:01:150]

// Abstand Latte-Haken
hly = 30;  // [1:0.1:40]

/* [Hidden] */


pw = 5;
pg = 10;
pr1 = pg/2;
pr2 = 2;

exl=hly-2*pw-pg;

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


some_distance = 150;
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
   if ("l" == part)
   {
      lattenecke();
   }
   if ("m" == part)
   {
      lattenecke_links();
   }
   if ("n" == part)
   {
      lattenecke_rechts();
   }
}

module preview_parts()
{
   lattenecke();
   translate([-0.7*some_distance, -some_distance, 0])
   {
      lattenecke_links();
   }
   translate([0.7*some_distance, -some_distance, 0])
   {
      lattenecke_rechts();
   }
}

module stack_parts()
{
   // intersection()
   {
      color("yellow")
      {
         lattenecke_links();
      }
      // translate([0,0,30])
      rotate([0,180,0])
      {
         color("red")
         {
            lattenecke_rechts();
         }
      }
   }
}

// *******************************************************
// Code for the parts themselves


module lattenecke()
{
   difference()
   {
      union()
      {

         lattending_m();
         rotate(-90)
            lattending_m();
      }
      lattending_l();
         rotate(-90)
            lattending_l();
   }
   translate([-pw/2+size_x/2,-laenge+size_x/2+pw/sqrt(2),0])
      rotate(-45)
      cube([pw,(sqrt(2)*(laenge-size_x))-w,p]);

}

module lattenecke_links()
{
   lattenecke();
   translate([laenge-pg/2-pw-size_x/2,size_x/2,0])
      hanger_a();
}

module lattenecke_rechts()
{
   rotate(270)
      lattenecke();
   translate([-laenge+pg/2+pw+size_x/2,size_x/2,0])
      hanger_b();
}


module lattending_m()
{
   translate([-size_x/2-w, -size_x/2-w,0])
   {
      cube([laenge+w, size_x+2*w, size_y+p]);
   }
}
module lattending_l()
{
   translate([-size_x/2-ms, -size_x/2,p])
   {
      cube([laenge+2*ms, size_x, size_y+ms]);
   }
}


module hanger_a()
{
   linear_extrude(p)
   {
      difference()
      {
         union()
         {
            translate([-pw-pg/2, -ms])
               square([2*pw+pg,pw+pg+exl+2*ms]);
            translate([0,pw+pg+exl])
               circle(r=pw+pr1);
         }
         translate([0,pw+pg+exl])
            circle(r=pr1);
         translate([-pr1, -ms])
            square([pg,pw+pg+exl+2*ms]);
      }
   }
}


module hanger_b()
{
   drr=pr1-pr2;
   linear_extrude(p)
   {
      difference()
      {
         union()
         {
            translate([-pw-pg/2, -ms])
               square([2*pw+pg,pw+pg+2*ms+drr+exl]);
            kmirror()
               translate([-drr,pw+pg+drr+exl])
            {
               circle(r=pw+pr2);
            }
            translate([-pg/2+drr,pg+2*pw+exl])
               square([2*drr, pw]);
         }
         translate([0,pw+pg+exl])
            kmirror()
            translate([-drr,+drr])
         {
            circle(r=pr2);
         }
         circle(r=pr1);
         translate([-pr1, -ms])
            square([pg,pw+pg+2*ms+drr+exl]);
         translate([-drr, pg+pw+exl])
            square([2*drr, pw]);
      }
   }
}
