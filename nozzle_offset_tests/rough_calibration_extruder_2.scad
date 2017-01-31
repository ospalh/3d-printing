// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// Rough extruder offest calibration
// Extruder one part
// Just a few simple blocks
//
// © 2017 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0


font_name = "serif";
// font_name = "bugger, haven’t got this one";

translate([-5, 0, 0])
{
   cube([10,10,10]);
   translate([5, 2, 10])
   {
      linear_extrude(1)
      {
         text("↕", 6, font=font_name, halign="center", valgin="center");
      }
   }
}
