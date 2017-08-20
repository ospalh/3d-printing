// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// Ring, um die Kette des Stöpsels am Spülbecken zu befestigen
//
// © 2017 Roland Sieker <ospalh@gmail.com>
// Licence: CC-0 4.0

d_i_u = 5;
d_i_o = 8;
r_i_u = d_i_u/2;
r_i_o = d_i_o/2;
//h = 2;

w=3.2;
r_a_u = r_i_u + w;
r_a_o = r_i_o + w;

h = 1.7;

ms = 0.1;  // Muggeseggele


r_k = 1.5;
r_k_a = r_k+w;

$fn = 90;
dr = r_a_o - r_i_o;

ms = 0.1;

rounding();
mirror()
{
   rounding();
}

module rounding()
{
   intersection()
   {
      union()
      {
         translate([1.5*w, r_i_o-ms, h+w])
         {
            difference()
            {
               translate([-w, ms, -w])
               {
                  cube([w, dr, w]);
               }
               rotate([-90, 0, 0])
               {
                  cylinder(r=w, h=dr+2*ms);
               }
            }
         }
      }
      cylinder(r=r_a_o, h=h+w);
   }
}



difference()
{
    cylinder(r1=r_a_u, r2=r_a_o, h=h);
    translate([0,0,-ms])
    {
        cylinder(r1=r_i_u, r2=r_i_o, h=h+2*ms);
    }
}

translate([0, r_i_o+r_k_a, h+r_k_a])
{
   rotate([0, 90, 0])
   {
      difference()
      {
         cylinder(r=r_k_a, h=w, center=true);
         cylinder(r=r_k, h=w+2*ms, center=true);
      }

   }
}


difference()
{
   translate([0, r_i_o+r_k_a/2, h+r_k_a/2])
   {
      cube([w, r_k_a, r_k_a], center=true);
   }
   translate([0, r_i_o+r_k_a, h+r_k_a])
   {
      rotate([0, 90, 0])
      {
         cylinder(r=r_k, h=w+2*ms, center=true);

      }
   }
}
