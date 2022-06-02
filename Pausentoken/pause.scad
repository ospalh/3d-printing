// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// Pausentoken
//
// © 2017–2022 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0
//

ms = 0.01;


// Wie groß das Ding laut slic3r ist
breite = 50;
tiefe = 20;

r_e = 6;

rand = 0;
hw = 2;  // Halter weite
hh = 0.5;

// font_name = "Praxis LT:Heavy";  // Use one you actually have …
font_name = "Praxis LT:SemiBold";  // Use one you actually have …
font_size_o = 12;  // Play around with this
font_size_r = 7.5;  // Play around with this

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
   // rotate(180)
   {
      mirror([0,1,0])
      {
         linear_extrude(h)
         {
            text("ans Werk", size=font_size_r,
                 font=font_name, valign="center", halign="center");
         }

      }
   }
}


module kmirror(maxis=[1, 0, 0])
{
   // Keep *and* mirror an object. Standard is left and right mirroring.
   children();
   mirror(maxis)
   {
      children();
   }
}


module Platte(h)
{
   hull()
   {
      kmirror()
      {
         kmirror([0,1,0])
         {
            translate([breite/2+rand-r_e, tiefe/2+rand-r_e,0])
            {
               cylinder(r=r_e, h=h);
            }
         }
      }
   }
   // translate([0,0,h/2])
   // cube([breite+2*rand, tiefe+2*rand, h], center=true);
}
