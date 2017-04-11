// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// Yet another Pi Camera holder
//
// © 2017 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0


// **********************************************************
// Change these to taste. Lengths are in mm.
t_b = 8.2;  // Bed thickness. I want to attach it to an 8 mm Acrylic bed carrier
cam_angle = 45;  // °
l_c = 30;  // Clamp length. How big the clamping bit will be
w_c = 20;  // Clamp width
t_c = 3.8;  // Thickness of the clamp

r_hv = 55;  // radius of the circular bit
x_a = 50;  // length of the arm
r_h = 2.9;  // camera holder hole radius
h_w = 1.6;  // walls around that
h_d = 13;  // camera holder hole depth

// **********************************************************

w_a = 2*r_h+2*h_w;  // Thickness of the cam arm
ms = 0.1;

l_ce = w_c/tan(cam_angle);

mirror()
{
   translate([-l_ce-w_c+t_c/cos(cam_angle), w_a-2*t_c-t_b,0])
   {

      clamp();
   }
   arm();
}

module clamp()
{
   h_c = t_b + 2 * t_c;
   difference()
   {
      cube([w_c+l_ce, h_c, w_c]);
      translate([w_c+l_ce, -ms,-ms])
      {
         rotate([0, -cam_angle,0])
         {
            cube([w_c, h_c+2*ms, 3*w_c]);
         }
      }
      translate([w_c+l_ce-t_c/cos(cam_angle), 0, 0])
      {
         rotate([0, -cam_angle,0])
         {
            translate([-2*w_c, t_c, -0*w_c])
            {
               cube([2*w_c, t_b, 2*w_c]);
            }
         }
      }
   }
}

module arm()
{
   {
      difference()
      {
         translate([-w_a,0,0])
         {
            cube([x_a,w_a,w_a]);
         }
         rotate([0,-cam_angle, 0])
         {
            translate([-1.5*w_a,0,0.5*w_a])
            {
               cube(3*w_a, center=true);
            }
         }
      }
   }
   translate([x_a-ms-w_a, r_hv+w_a, 0])
   {
      difference()
      {
         rotate_extrude($fn=180)
         {
            translate([r_hv,0])
            {
               square(w_a);
            }
         }
         translate([-1.25*r_hv, 0, 0.5*w_a])
         {
            cube([2.5*r_hv, 2.5*r_hv, 2*w_a], center=true);
         }
         translate([0, 1.25*r_hv, 0.5*w_a])
         {
            cube([2.5*r_hv, 2.5*r_hv, 2*w_a], center=true);
         }
      }
   }
   translate([x_a+r_hv-w_a, r_hv+w_a-ms, 0])
   {
      difference()
      {
         cube([2*r_h+2*h_w, h_d, 2*r_h+2*h_w]);
         translate([r_h+h_w, h_d+ms, r_h+h_w])
         {
            rotate([90,0,0])
            {
               cylinder(r=r_h,h=h_d+ms, $fn=20);
            }
         }
      }
   }

}
