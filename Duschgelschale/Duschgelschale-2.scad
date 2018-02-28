// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// shower gel tray
//
// © 2018 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0


// Set this to “render” and click on “Create Thing” when done with the setup.
preview = 1; // [0:render, 1:preview]

r_main = 150;  // main radius of the tray
r_corner = 3;  // space for silicone joint
h=32; // Height (inner)


/* [Hidden] */

// Done with the customizer

w = 1.8;  // external wall width
p_1 = 0.8;  // height of the bottomt plate with the cylindrical holes
p_2 = 1.8;  // height of the bottomt plate with the conical shapes
x_step = 20;  // hole to hole distance
r_hole = 2.5;  // drain holes

// *******************************************************
// Some shortcuts. These shouldn’t be changed

tau = 2 * PI;  // π is still wrong. τ = ⌀ ÷ r
angle = 60; // Overhangs much below 60° are a problem for me
xy_factor = 1/tan(angle);  // To get from a height to a horizontal width
                           // inclined correctly
z_factor = tan(angle);  // the other way around

p = p_1 + p_2;

thf = sqrt(3)/2;  // (equilateral) triangle height factor
y_step = x_step * thf;

some_distance = 50;
ms = 0.01;  // Muggeseggele.

// fn for differently sized objects, for preview or rendering.
pfa = 40;
pfb = 15;
pfc = 15;
rfa = 180;
rfb = 45;
rfc = 30;
function fa() = (preview) ? pfa : rfa;
function fb() = (preview) ? pfb : rfb;
function fc() = (preview) ? pfc : rfc;

// *******************************************************
// End setup



// *******************************************************
// Generate the parts

tray();

// *******************************************************
// Code for the parts themselves

module tray()
{
   plate();
   railing();
}


module railing()
{
   round_railing(r_main, fa());
   round_railing(r_hole+w, fb());
   translate([0, r_hole, 0])
   {
      cube([w, r_main-r_hole, h+p]);
   }
   translate([r_hole, 0, 0])
   {
      cube([r_main-r_hole, w, h+p]);
   }

}



module round_railing(r, f)
{
   intersection()
   {
      difference()
      {
         cylinder(r=r, h=h+p, $fn=f);
         translate([0,0,-ms])
         {
            cylinder(r=r-w, h=h+p+2*ms, $fn=f);
         }
      }
      translate([0,0,-2*ms])
      {
          cube(r_main, r_main, h+p+4*ms);
      }
   }
}


module plate()
{
   intersection()
   {
      plate_quarter_circle();
      plate_square();
   }
}

module plate_quarter_circle()
{
   difference()
   {
      intersection()
      {
         translate([0,0,-2*ms])
         {
            cube([r_main, r_main, p+4*ms]);
         }
         translate([0,0,-ms])
         {
            cylinder(r=r_main, p+2*ms, $fn=fa());
         }
      }
      translate([0,0,-2*ms])
      {
         cylinder(r=r_corner, h=p+4*ms, $fn=fb());

      }

   }
}

module plate_square()
{
   p_xy = r_main+2*x_step+2*ms;
   difference()
   {
      translate([-x_step, -x_step, 0])
      {
         cube([p_xy, p_xy, p]);
      }
      rotate(45)
      {
         plate_holes();
      }
   }
}

module plate_holes()
{
   p_xy = r_main+2*x_step+2*ms;
   x_count = ceil(p_xy/x_step);
   y_count = ceil(p_xy/y_step);

   // Partly cut-and-pasted from my tight bottle tray
   for (y_c = [-y_count:y_count])
   {
      if (y_c%2==0)
      {
         // Even, long row
         for (x_c = [-x_count+1:x_count-1])
         {
            a_plate_hole(x_c*x_step, y_c*y_step);
         }
      }
      else
      {
         // Odd, short row
         for (x_c = [-x_count+2:x_count-2])
         {
            a_plate_hole((x_c+0.5)*x_step, y_c*y_step);
         }
      }
   }
}


module a_plate_hole(dx, dy)
{
   translate([dx, dy, -ms])
   {
      cylinder(r=r_hole, h=p+2*ms, $fn=fc());  // Or h=p_1+2*ms
      translate([0, 0, p_1])
      {
         cylinder(r1=r_hole-ms, r2=y_step/sqrt(2), h=p_2+2*ms, $fn=fb());
         // The sqrt(2) is … experimental math.
      }
   }

}
