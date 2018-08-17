// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// A € 1 coin sized token to get a shopping cart.
// With a message. Standard message is for Germany
//
// © 2017 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0

// … to preview. You will get all parts when you click “Create Thing”.
part = "totone"; // [holey: holey coin, totone: coin to use filament change]


message_obverse = ["AfD?", "Nee!"];
message_reverse = ["AfD?", "Nee!"];
diameter = 23.25;  // mm
thickness = 2.33;  // mm
font_name = "Praxis LT:Heavy";  // Use one you actually have …

// Set this to “render” and click on “Create Thing” when done with the setup.
preview = 1; // [0:render, 1:preview]

// Easy configuration section end

font_size = 6;  // Play around with this
radius = diameter/2;

// fn for differently sized objects and fs, fa; all for preview or rendering.
pna = 40;
pnb = 15;
pa = 5;
ps = 1;
rna = 180;
rnb = 30;
ra = 1;
rs = 0.1;
function na() = (preview) ? pna : rna;
function nb() = (preview) ? pnb : rnb;
$fs = (preview) ? ps : rs;
$fa = (preview) ? pa : ra;

some_distance = 1.2 * diameter;


print_part();
// preview_parts();


module print_part()
{
   if ("holey" == part)
   {
      holey_message_token();
   }
   if ("totone" == part)
   {
      two_sided_message_token();
   }
}

module preview_parts()
{
   holey_message_token();
   translate([some_distance, 0, 0])
   {
      two_sided_message_token();
   }
}

module two_sided_message_token()
{
   translate([0, 0, thickness/2])
   {
      difference()
      {
         cylinder(r=radius, h=thickness, center=true);
         text_reverse();
         text_obverse();
      }
   }
}


module holey_message_token()
{
   translate([0, 0, thickness/2])
   {
      difference()
      {
         cylinder(r=radius, h=thickness, center=true);
         holey_text();
       }
      counter_holders();
   }
}
module holey_text()
{
   translate([0,0, -0.6*thickness])
   {
      linear_extrude(1.2 * thickness, convexity=8)
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
module text_obverse()
{
   translate([0,0, 0.25*thickness])
   {
      linear_extrude(0.5 * thickness, convexity=8)
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
         linear_extrude(thickness/2, convexity=8)
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
module counter_holders()
{
   // Define these based on your text. Make sure all the counters are
   // connected to the token proper.
   translate([2, 4,0])
   {
      cube([0.8, 10, 0.6], center=true); // D |
   }
   translate([2.2, 4,0])  // D -
   {
      cube([6, 0.8, 0.6], center=true);
   }
   translate([-1, -3.5, 0])
   {
      cube([0.8, 3, 0.6], center=true);  // e |
   }
   translate([3.6, -3.5, 0])
   {
      cube([0.8, 3, 0.6], center=true);  // e |
   }
   translate([-6.5, 4, 0])
   {
      cube([4, 0.8 , 0.6], center=true);
   }

}
