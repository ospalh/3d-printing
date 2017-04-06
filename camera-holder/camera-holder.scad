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
t_c = 3.5;  // Thickness of the clamp arm
w_ah = 3;  // Thickness of the cam arm
w_av = 2.4;  // Thickness of the cam arm
x_a = 60;  // length of the arm
z_a = 60;  // height of the arm
r_af = 10;  // Radius of the fillet on the arm
r_cf = 6;  // Radius of the fillet on the clamp
r_h = 2.6;  // camera holder hole radius
h_w = 1.6;  // walls around that
h_d = 13;  // camera holder hole depth

// **********************************************************
ms = 0.01;

l_ce = w_c/tan(cam_angle);

mirror()
{
   translate([-l_ce-w_c+t_c/cos(cam_angle),0,0])
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
   cube([x_a,w_ah,w_ah]);
   translate([x_a-ms, -z_a+w_av, 0])
   {
      cube([w_av,z_a,w_av]);
   }
   translate([x_a, -z_a-h_d+w_av-h_w, 0])
   {
      difference()
      {
         cube([2*r_h+2*h_w, h_d+h_w, 2*r_h+2*h_w]);
         translate([r_h+h_w, h_d-ms, r_h+h_w])
         {
            rotate([90,0,0])
            {
               cylinder(r=r_h,h=h_d, $fn=20);
            }
         }
      }
   }
   // on arm fillet
   translate([x_a-ms-r_af, -r_af, 0])
   {
      difference()
      {
         cube([r_af, r_af,w_av]);
         translate([0,0,-ms])
         {
            cylinder(r=r_af, h=w_ah+2*ms);
         }
      }
   }
}
