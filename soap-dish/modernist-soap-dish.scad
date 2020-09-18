// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// A soap dish.
// Inspired by “Ultramodern Soap Dish”, https://www.thingiverse.com/thing:1394419
//
// © 2017 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0

rx = 63;
ry = 44;
zmin = 4;

w = 4;
g = 5;

//
r_spar = 3;
rk = 4 * rx;
zmax=30;

preview = 1; // [0:render, 1:preview]

p = w+g; // period
ms = 0.01; // Muggeseggele




// fn for differently sized objects and fs, fa; all for preview or rendering.
pna = 40;
pnb = 15;
pa = 5;
ps = 1;
rna = 180;
rnb = 30;
ra = 2;
rs = 0.2;
function na() = (preview) ? pna : rna;
function nb() = (preview) ? pnb : rnb;
$fs = (preview) ? ps : rs;
$fa = (preview) ? pa : ra;

intersection()
{
   union()
   {
      difference()
      {
         union()
         {
            for (roff =[0:p:rx])
            {
               // The main dish
               rotate_extrude()
               {
                  translate([roff, 0])
                  {
                     square([w,zmax]);
                  }
               }
            }
            // Two support members holding it together
            rotate([0, 90, 0])
            {
               cylinder(r=r_spar, h=2*rx+g, center=true);
            }
            rotate([90, 0, 0])
            {
               cylinder(r=r_spar, h=2*ry+g, center=true);
            }
            // Ad hoc supports for the three outer ring bits

            short_support_set(50, 5);
            short_support_set(75, 6);
            // short_support_set(80, 8);
         }
         // The hollow
         translate([0,0,zmin+rk])
         {
            sphere(r=rk, $fn=na());
         }
         // Cut off half of the supports
         translate([0, 0, -zmin])
         {
            cylinder(r=rx, h=zmin);
         }
      }
   }
   // Make it an ellipse
   scale([1, ry/rx, 1.01])
   {
      cylinder(r=rx+w, h=zmax);
   }
}


module short_support_set(a,o)
{
   short_support(a, o*p);
   short_support(-a, o*p);
   short_support(180-a, o*p);
   short_support(180+a, o*p);
}


module short_support(a,o)
{
   rotate(a)
   {
      translate([0, o-ms+p/2, 0])
      {
         rotate([90, 0, 0])
         {
            cylinder(r=r_spar, h=p+2*ms, center=true);
         }
      }
   }
}
