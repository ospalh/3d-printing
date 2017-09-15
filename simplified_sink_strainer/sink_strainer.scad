// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// Simplified sink strainer.
//
// Based on Customizable disposable kitchen sink strainer
// https://www.thingiverse.com/thing:351541
// © 2014 junnno
// © 2017 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0



// The main diameter of the sink’s hole, at the top
sink_hole_diameter = 44;  // [10:100:0.1]
// The depth of the sink hole, height of the body without the flange
sink_hole_depth = 12;  // [1:20:0.1]

// Add a central handle
with_handle = 1;  // [0: no handle, 1: with handle]

// Width of the flange at the top
flange_width = 2;  // [0:20:0.1]

// Set this to > 0 for a conical main part
bottom_width_reduction = 3;

side_slit_width = 2;
bottom_gap_width = 2;

// What angle to use at the bottom of the flange. Use falsework when you use 0 here.
flange_support_angle = 0; // [0, 15, 30, 45, 60]


// Advanced

// Wall width
wall = 1.8;  // [0.1:5:0.1]
// Height of the bottom rings and the top flange at the end
plates = 1.2;

//  What it says on the tin
handle_lower_diameter = 6;  // [2:20:0.1]
//  dto.
handle_upper_diameter = 9;  // [3:25:0.1]

// Change the height of the handle
handle_height_tweak = 1.0;  // [0.1:5:0.1]


// Width of the four connector beams at the bottom in wall widths
beam_strengthener = 2;  // [0.5:5:0.01]

module stop_customizer()
{
   // Dummy module to stop the customizer
}


$fs = 0.2;
$fa = 1;

flange_support_height = flange_width*sin(flange_support_angle);
handle_height = handle_height_tweak * sink_hole_depth+flange_support_height;



// The length between the centers of the bottom filter slits
filter_periodic_length = bottom_gap_width + wall;


side_slit_periodic_length = side_slit_width + wall;



r_m = sink_hole_diameter / 2;
r_m_b = r_m - bottom_width_reduction/2;
// The diameter of the inside
r_i = r_m - wall;
r_i_b = r_m_b - wall;

// The diameter of the head flange
head_diameter = 79;
r_h = r_m + flange_width;

ms = 0.1;
tau = 2*PI;  // Pi is still wrong



strainer();


module strainer()
{
   if (flange_width)
   {

      if (0 == flange_support_angle)
      {
         translate([0,0,sink_hole_depth])
         {
            flange();
         }
      }
      else
      {
         translate([0,0,sink_hole_depth])
         {
            flange_support(flange_support_height);
         }
         translate([0,0,sink_hole_depth+flange_support_height])
         {
            flange();
         }

      }
   }


   // main body with side slit pattern
   slit_count = floor(r_i_b*tau/side_slit_periodic_length);
   slit_angle_step = 360/slit_count;
   difference()
   {
      cylinder(h=sink_hole_depth, r1=r_m_b, r2=r_m);

      translate([0,0,-ms])
      {
         cylinder(h=sink_hole_depth+2*ms, r1=r_i_b, r2=r_i);
      }
      for(i=[0 : slit_angle_step : 360])
      {
         rotate(i,[0,0,1])
         {
            translate([0,0,plates])
            {
               cube([r_m+ms, side_slit_width, sink_hole_depth-plates+ms]);
            }
         }
      }
   }

   // bottom filter pattern
   if (with_handle)
   {
      for(rri=[bottom_gap_width+handle_lower_diameter/2: filter_periodic_length: r_i_b])
      {
         difference()
         {
            cylinder(h=plates, r=rri+wall);
            translate([0,0,-ms])
            {
               cylinder(h=plates+2*ms, r=rri);
            }
         }
      }
   }
   else
   {
      for(rri=[bottom_gap_width/2: filter_periodic_length: r_i_b])
      {
         difference()
         {
            cylinder(h=plates, r=rri+wall);
            translate([0,0,-ms])
            {
               cylinder(h=plates+2*ms, r=rri);
            }
         }
      }
   }
   // Bottom connector beams
   for(i=[0:90:361]) // 360 instead of 361 to avoid fence post errors
   {
      rotate(i)
      {
         if (with_handle)
         {
            translate([0,-0.5*wall*beam_strengthener,0])
            {
               cube([r_i_b + wall/2, wall*beam_strengthener, plates]);
            }
         }
         else
         {
            translate([bottom_gap_width/2+ms,-0.5*wall*beam_strengthener,0])
            {
               cube([r_i_b - bottom_gap_width/2 + wall/2, wall*beam_strengthener, plates]);
            }
         }
      }
   }


   if (with_handle)
   // center handle
   {
      cylinder(
         r1=handle_lower_diameter/2, r2=handle_upper_diameter/2,
         h=handle_height);
   }

}


module flange()
{
   difference()
   {
      cylinder(h=plates, r=r_h);
      translate([0,0,-ms])
      {
         cylinder(h=plates+2*ms, r=r_i);
      }
   }
}


module flange_support(h)
{
   // gradient under the head
   difference()
   {
      cylinder(h=h, r1=r_m, r2=r_h);
      translate([0,0,-ms])
      {
         cylinder(h=h+2*ms, r=r_i);
      }
   }
}
