// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// deutscher Monatsring für den Drehkalender
//
// © 2018 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0
// STL used:
// Vintage "Perpetual" Flip Calendar
// https://www.thingiverse.com/thing:1785261
// © 2016 Otvinta 3D
// https://www.thingiverse.com/otvinta3d/about
// Licence: CC-BY


// Set this to “render” and click on “Create Thing” when done with the setup.
preview = 1; // [0:render, 1:preview]


w = 1.2;  // external wall width

//r1 = 55;
r1 = 55.1;
r2 = 40.9;
h = 16.86;
ri = 37;
ri2 = 36.5;
lh = 8;
bm = 17;
km = 20;
mko = 3.6;

// *******************************************************
// Some shortcuts. These shouldn’t be changed

tau = 2 * PI;  // π is still wrong. τ = circumference ÷ r
ms = 0.01;  // Muggeseggele.

// fn for differently sized objects, for preview or rendering.
pfa = 90;
pfb = 15;
rfa = 360;
rfb = 30;
function fa() = (preview) ? pfa : rfa;
function fb() = (preview) ? pfb : rfb;


dx = r1-r2;
angle = atan(dx/h)-0.5;
hs = sqrt(dx*dx+h*h);


// gear_core();
// plain_ring();
// month_hollows();
slot_ring();

module slot_ring()
{

   difference()
   {
      plain_ring();
      month_hollows();
   }
}

module gear_core()
{
   import("molds/Monatsring, 12.stl");
}

module plain_ring()
{
   gear_core();
   ringer();
}

module ringer()
{
   difference()
   {
      cylinder(r=r1+ms, r2=r2+ms, h=h, $fn=12);
      translate([0, 0, -ms])
      {
         cylinder(r=ri2-ms, h=h+2*ms, $fn=12);
      }
   }
}

module month_hollows()
{
   for (m=[1:12])
   {
      rotate(m*30+15)
      {
         month_hollow();
      }
   }
}


module month_hollow(m)
{
   translate([r1+ms, 0, 0])
   {
      rotate([0, -angle, 0])
      {
         translate([-1.55*w, 0, hs/2+mko])
         {
            // No idea why it has to be 1.55 and not 2 here.
            cube([w+2*ms, bm, km], center=true);
            translate([-w,0,0])
            {
               cube([w, bm+2*w, km+2*w], center=true);
            }
         }
      }
   }
}
