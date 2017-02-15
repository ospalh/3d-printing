// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// A € 1 coin sized token to get a shopping cart.
// With a message. Standard message is for Germany
//
// © 2017 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0

message_obverse = ["AfD?", "Nee!"];
message_reverse = ["AfD?", "Nee!"];
diameter = 23.25;  // mm
thickness = 2.33;  // mm
font_name = "Praxis LT";  // Use one you actually have …

// Easy configuration section end

font_size = 6;  // Play around with this
radius = diameter/2;


depressed_message_token();


module depressed_message_token()
{

   translate([0, 0, thickness/2])
   {
      difference()
      {
         cylinder(r=radius, h=thickness, center=true);
         text_obverse();
         text_reverse();
       }
   }
}
module text_obverse()
{
   translate([0,0, 0.25*thickness])
   {
      linear_extrude(thickness/2)
      {
         translate([0, 0.6*font_size, 0])
         {
            text(text=str(message_obverse[0]), size=font_size,
                 font=font_name, valign="center", halign="center");
         }
         translate([0, -0.6 * font_size, 0])
         {
            text(text=str(message_obverse[1]), size=font_size,
                 font=font_name, valign="center", halign="center");
         }
      }
   }
}
module text_reverse()
{
   rotate([0,180,0])
   {
      translate([0,0, 0.25*thickness])
      {
         linear_extrude(thickness/2)
         {
            translate([0, 0.6*font_size, 0])
            {
               text(text=str(message_reverse[0]), size=font_size,
                    font=font_name, valign="center", halign="center");
            }
            translate([0, -0.6*font_size, 0])
            {
               text(text=str(message_reverse[1]), size=font_size,
                    font=font_name, valign="center", halign="center");
            }
         }
      }
   }
}
