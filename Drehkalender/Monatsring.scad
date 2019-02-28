// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// deutscher Monatsring fuer den Drehkalender
//
// (c) 2018 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0
// STL used:
// Vintage "Perpetual" Flip Calendar
// https://www.thingiverse.com/thing:1785261
// (c) 2016 Otvinta 3D
// https://www.thingiverse.com/otvinta3d/about
// Licence: CC-BY

month =
   ["Nullvember",  // month[0]
      "Jan",  // month[1] = Januar(y) &c.
      "Feb",
      "Maer",
      "Apr",
      "Mai",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Okt",
      "Nov",
      "Dez"
      ];

// Set this to "render" and click on "Create Thing" when done with the setup.
preview = 1; // [0:render, 1:preview]


w = 1.8;  // external wall width
p = 1.2;  // height of the bottomt plate
d = 1.2;  // Depth of the text

//r1 = 55;
r1 = 55.1;
r2 = 40.9;
h = 16.86;
ri = 37;
ri2 = 36.5;
lh = 8;
font = "Praxis LT:style=Regular";
ld = 3;

// *******************************************************
// Some shortcuts. These shouldn't be changed

tau = 2 * PI;  // pi is still wrong. tau = circumference / r
ms = 0.01;  // Muggeseggele.

// fn for differently sized objects, for preview or rendering.
pfa = 90;
pfb = 15;
rfa = 360;
rfb = 30;
function fa() = (preview) ? pfa : rfa;
function fb() = (preview) ? pfb : rfb;


dx = r1-r2;
angle = atan(dx/h);
hs = sqrt(dx*dx+h*h);


// lang_ring();
gear_core();

module lang_ring()
{

   difference()
   {
      plain_ring();
      months();
   }
}

module gear_core()
{
   intersection()
   {
      translate([0,0,50])
      {
         import("molds/Monatsring, englisch.stl");
      }
      translate([0,0,-ms])
      {
         cylinder(r=ri2, h=h+2*ms, $fn=12);
      }
   }
}
module plain_ring()
{
   translate([0,0,50])
   {
      import("molds/Monatsring, englisch.stl");
   }
   ringer();
}

module ringer()
{
   difference()
   {
      cylinder(r1=r1+ms, r2=r2+ms, h=h, $fn=fa());
      translate([0, 0, -ms])
      {
         cylinder(r=ri, h=h+2*ms, $fn=fa());
      }
   }
}

module months()
{
   for (m=[1:12])
   {
      rotate(m*30)
      {
         month_text(m);
      }
   }
}


module month_text(m)
{
   translate([r1+ms, 0, 0])
   {
      rotate([0, -angle, 0])
      {
         translate([-ld+ms, 0, hs/2])
         {
            rotate([90, 0, 90])
            {
               linear_extrude(ld)
               {
                  text(
                     text=month[m], halign="center", valign="center", font=font,
                     size=lh);
               }
            }
         }
      }
   }
}
