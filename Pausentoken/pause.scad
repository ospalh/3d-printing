// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// Pausentoken
//
// © 2017–2021 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0
// Basierend auf Rudolf Kocks Werk (D’uh!), das inzwischen gemeinfrei ist.

ms = 0.01;


// Wie groß das Ding laut slic3r ist
breite = 80;
tiefe = 33;


rand = 0;
hw = 2;  // Halter weite
hh = 0.5;

// font_name = "Praxis LT:Heavy";  // Use one you actually have …
font_name = "Demos LT:SemiBold";  // Use one you actually have …
font_size_o = 19;  // Play around with this
font_size_r = 12;  // Play around with this

token();


module token()
{
   difference()
   {
      Platte(1.6);
      translate([0, 0, -ms])
      {
         kommen(0.8+ms);
      }
   }

   translate([0,0,1.6-ms])
   {
      pause(0.8+ms);
   }
}


module pause(h)
{
   linear_extrude(h)
   {
      text("Pause", size=font_size_o,
                 font=font_name, valign="center", halign="center");
   }
}

module kommen(h)
{
   rotate(180)
   {
      mirror([0,1,0])
      {
         linear_extrude(h)
         {
            text("kommen", size=font_size_r,
                 font=font_name, valign="center", halign="center");
         }

      }
   }
}




module Platte(h)
{
   translate([0,0,h/2])
   {
      cube([breite+2*rand, tiefe+2*rand, h], center=true);
   }
}
