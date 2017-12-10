// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// A stand for my oil can that catches the oil dripping out the tip
//
// © 2017 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0



// Size of the can
r_can = 79/2;  // diameter of the con itself
h_tip = 133;  // height of the oiling tip above ground
x_tip = 142;  // distance of the tip from the center of the can

// sizes of the stand
clearance = 0.5;  // extra size for the can
b = 1.5;  // Thickness of the bottom plate
b_c = 4;  // Thickness of the connector
r_catcher = 10;  // radius of the oil catcher pot
w = 1.8;  // wall strength;
r_stem = 3;  // diameter of the oil catcher pot stem
h_can = 10;  // height of the can wall
h_clear = 2;  // distance from the tip to the catcher pot
pot_bottom_height = 8;  // To give the catcher got a bit of a flat bottom

// other
preview = 1; // [0:render, 1:preview]
// fn for differently sized objects, for preview or rendering.
pfa = 40;
pfb = 15;
rfa = 180;
rfb = 30;
function fa() = (preview) ? pfa : rfa;
function fb() = (preview) ? pfb : rfb;
ms = 0.1;  // Muggeseggele

// Calculated
h_ct = h_tip-h_clear+b;
h_cc = 2*r_catcher;
h_cb = h_ct - h_cc;


oilcan_stand();

module oilcan_stand()
{
   difference()
   {
      union()
      {
         solid_can_stand();
         connector();
         stem();
         solid_catcher();
      }
      can_hollow();
      catcher_hollow();
   }
}

module solid_can_stand()
{

   cylinder(r=r_can+w+clearance, h=h_can+b, $fn=fa());
}

module connector()
{
   translate([0,-r_stem,0])
   {
      cube([x_tip, 2*r_stem, b_c]);
   }
}

module stem()
{
   translate([x_tip,0,0])
   {
      cylinder(r=r_stem, h=h_ct, $fn=fb());
   }
}

module solid_catcher()
{
   translate([x_tip,0,h_cb-2*w])
   {
      cylinder(r1=ms, r2=r_catcher+w, h=h_cc+2*w, $fn=fb());
   }
}


module can_hollow()
{
   translate([0,0, b])
   {
      cylinder(r=r_can, h=h_can+ms, $fn=fa());
   }
}

module catcher_hollow()
{

   translate([x_tip,0,h_cb])
   {
      intersection()
      {
         cylinder(r1=ms, r2=r_catcher+ms, h=h_cc+2*ms, $fn=fb());
         translate([0,0,pot_bottom_height])
         {
            cylinder(r=r_catcher+2*ms, h=h_cc+2, $fn=fb());
         }
      }
   }

}
