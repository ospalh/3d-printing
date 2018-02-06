// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// Hook for the line of IKEA window blinds.
//
// © 2017 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0

b_width = 25;
arm_length = 35;
arm_height = 3;
hook_height = 25;
hook_wall = 3;
knob_thickness = 12;
knob_radius = 12;
hook_thickness = knob_thickness + 2 * hook_wall;
line_width = 6;
ms = 0.01;
h_width = 2 * (knob_radius + hook_wall);

translate([-b_width/2, -arm_length, 0])
{
   // Base
   cube([b_width, arm_length, arm_height]);
}
translate([0.5*(h_width-b_width), 0, 0])
{
   difference()
   {
      union()
      {
         // Lower part of took
         translate([-h_width/2, 0, 0])
         {
            cube([h_width, hook_thickness, hook_height-knob_radius-hook_wall]);
         }
         translate([0, 0, hook_height-knob_radius-hook_wall])
         {
            // upper part of hook
            rotate([-90, 0, 0])
            {
               cylinder(r=h_width/2, h=hook_thickness);
            }
         }
      }
      translate([0, hook_wall, hook_height-knob_radius-hook_wall])
      {
         // Space where the knob will rest
         rotate([-90, 0, 0])
         {
            cylinder(r=knob_radius, h=knob_thickness);
         }
      }
      translate([-h_width/2+hook_wall, hook_wall, -knob_radius-hook_wall])
      {
         // Space to insert the knob
         cube([2*knob_radius, knob_thickness, hook_height]);
      }
      translate([-line_width/2, hook_wall, -ms])
      {
         // space for the line
         cube([line_width, hook_thickness, hook_height+2*ms]);
      }
      translate([-h_width/2, -h_width,-h_width])
      {
         // Cut off the lower part of the upper part of the hook
         cube([2*h_width,2*h_width,h_width]);
      }
   }
}
