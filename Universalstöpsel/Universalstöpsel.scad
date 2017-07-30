// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// NN
//
// © 2017 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0

d_u = 43;
d_o = 45;
h= 5;
h_k = 3;
rand = 5;
r_r = 1.2;
r_f = 1.6;

r_u = d_u / 2;
r_o = d_o / 2;
r_k = d_o/2 + rand;

$fn = 30;



// stoepsel_form();
// stoepsel();
druck_stoepsel();


module druck_stoepsel()
{
   translate([0,0,h+h_k])
   {
      mirror([0,0,1])
      {
         stoepsel();
      }
   }
}

module stoepsel()
{
   rotate_extrude($fn=180)
   {
      stoepsel_form();
   }
}

module stoepsel_form()
{
   rot_points = [
      [0, 0],
      [r_u-r_r, 0],
      [r_u-r_r, r_r],
      [r_u, r_r],
      [r_o, h-r_f],
      [r_o, h],
      [r_k-r_r, h],
      [r_k-r_r, h+r_r],
      [r_k, h+r_r],
      [r_k, h+h_k-r_r],
      [r_k-r_r, h+h_k-r_r],
      [r_k-r_r, h+h_k],
      [0, h+h_k],
      ];
  polygon(rot_points);
  translate([r_u-r_r, r_r])
  {
     circle(r=r_r, $fn=30);
  }
  translate([r_o, h-r_f])
  {
     difference()
     {
        square([r_f, r_f]);
        translate([r_f,0])
        {
           circle(r=r_f, $fn=30);
        }
     }
  }
  translate([r_k-r_r, h+r_r])
  {
     circle(r=r_r, $fn=30);
  }
  translate([r_k-r_r, h+h_k-r_r])
  {
     circle(r=r_r, $fn=30);
  }
}
