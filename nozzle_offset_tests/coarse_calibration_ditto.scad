// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// Rough extruder offest calibration
// Extruder one part
// Just a few simple blocks
//
// © 2017 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0



// Change this to fit your actual printer, as well as you know
nozzle_offset_x = 36;
nozzle_offset_y = 0.0;



font_name = "Demos LT";
// font_name = "Palatino";
// font_name = "serif";
// font_name = "bugger, haven’t got this one";
font_name_2 = "Demos X";
font_name_3 = "serif";
some_distance = 40;



// Y
translate([-15, 0, 0])
{
   cube([10,10,10]);
   translate([5, 2, 10])
   {
      linear_extrude(1)
      {
         text(text="y", size=3, font=font_name, halign="center",
              valgin="center");
      }
   }
}
translate([5, 0, 0])
{
   cube([10,10,10]);
   translate([5, 2, 10])
   {
      linear_extrude(1)
      {
         text(text=str(nozzle_offset_y), size=6, font=font_name_2,
              halign="center", valgin="center");
      }
   }
}


translate([nozzle_offset_x, nozzle_offset_y, 0])
{
   translate([-5, 0, 0])
   {
      cube([10,10,10]);
      translate([5, 2, 10])
      {
         linear_extrude(1)
         {
            text("↕", 6, font=font_name_3, halign="center", valgin="center");
         }
      }
   }
}


// X


translate([0, some_distance,0])
{
   translate([0, -15, 0])
   {
      cube([10,10,10]);
      translate([5, 2, 10])
      {
         linear_extrude(1)
         {
            text("x", 6, font=font_name, halign="center", valgin="center");
         }
      }
   }
   translate([0, 5, 0])
   {
      cube([10,10,10]);
      translate([5, 2, 10])
      {
         linear_extrude(1)
         {
            text(text=str(nozzle_offset_x), size=3, font=font_name_2,
                 halign="center", valgin="center");
         }
      }
   }

   translate([nozzle_offset_x, nozzle_offset_y, 0])
   {
      translate([0, -5, 0])
      {
         cube([10,10,10]);
         translate([5, 2, 10])
         {
            linear_extrude(1)
            {
               text("↔", 6, font=font_name_3, halign="center", valgin="center");
            }
         }
      }
   }
}
