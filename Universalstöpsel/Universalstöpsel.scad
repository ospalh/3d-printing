// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// Universalstöpsel. Aus flexiblem Filament zu drucken
//
// © 2017 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0



bottle_diameter = 20;
h_k = 2;
rand = 3.2;
r_r = 0.8;
r_f = 1.6;



// TODO: Thingiverse customizerfy

notch_r = 1.2;
squeeze=0.75;


r_o = bottle_diameter/2 - 0.7 * r_f;
r_u = r_o * 0.8;
r_k = bottle_diameter/2 + rand;

h = 0.6*r_o;
h_g = h + h_k;



a_fn = 60; b_fn = 20;  // draft
// a_fn = 270; b_fn = 45;  // final

if (squeeze < 1)
{
   if (notch_r > 0)
   {
      elliptischer_stoepsel_mit_nut();
   }
   else
   {
      elliptischer_stoepsel();
   }
}
else
{
   if (notch_r > 0)
   {
      stoepsel_mit_nut();
   }
   else
   {
      stoepsel();
   }
}




module elliptischer_stoepsel_mit_nut()
{
   difference()
   {
      elliptischer_stoepsel();
      notches(r_k*squeeze);
   }
}


module elliptischer_stoepsel()
{
   scale([squeeze, 1, 1])
   {
      stoepsel();
   }
}

module stoepsel_mit_nut()
{
   difference()
   {
      elliptischer_stoepsel();
      notches(r_k);
   }
}


module stoepsel()
{
   translate([0,0,h+h_k])
   {
      mirror([0,0,1])
      {
         rotate_extrude($fn=a_fn)
         {
            stoepsel_form();
         }
      }
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
     circle(r=r_r, $fn=b_fn);
  }
  translate([r_o, h-r_f])
  {
     difference()
     {
        square([r_f, r_f]);
        translate([r_f,0])
        {
           circle(r=r_f, $fn=b_fn);
        }
     }
  }
  translate([r_k-r_r, h+r_r])
  {
     circle(r=r_r, $fn=b_fn);
  }
  translate([r_k-r_r, h+h_k-r_r])
  {
     circle(r=r_r, $fn=b_fn);
  }
}


module notches(w)
{
   rotate([0, 90, 0])
   {
      cylinder(r=notch_r, h=2*w, center=true, $fn=b_fn);
   }
   z_notch();
   mirror()
   {
      z_notch();
   }
   module z_notch()
   {
      translate([w, 0, 0])
      {
         cylinder(r=notch_r, h=h_g, $fn=b_fn);
      }
   }
}
