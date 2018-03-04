// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// Calender tablets for otvinta3d’s flip calender with nicer font and
// German text.
//
// © 2017 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0
//


// This part is a recreation. The rest of the calender is either modified or original.
// Sourec of the original
// © 2016 otvinta3d CC-BY
// https://www.thingiverse.com/thing:1785261
// http://www.otvinta.com/download04.html

text_32_1 = "nächster";
text_32_2 = "Monat";
text_33_1 = "Langsam";
text_33_2 = "drehen";
text_34_1 = "";
text_34_1 = "";
// logo_34 = "NN.dxf";



w = 50; // width of the plate
p = 3;  // height of the plate

bw = 4.3;  // Border width
nw = 1.2;
td = 0.4;  // Text depth

some_distance = 55;
ms = 0.01;  // Muggeseggele.

// fn for differently sized objects, for preview or rendering.
pfa = 40;
pfb = 15;
rfa = 180;
rfb = 30;
function fa() = (preview) ? pfa : rfa;
function fb() = (preview) ? pfb : rfb;

// Generate cards from 1 through 17.
front_day = 1;

calender_card(front_day);

module calender_card(front_day)
{
   difference()
   {
      notched_card();
      day_text(front_day);
      rotate([0,180,0])
      {
         day_text(front_day+17);
      }
   }
}


module notched_card()
{
   difference()
   {
      cube([w,w,p], center=true);
      notches();
      rotate([0,180,0])
      {
         notches();
      }
   }
}

module notches()
{
   for (quad=[0,90,180,270])
   {
      rotate(quad)
      {
         echo(quad);
         notch();
      }
   }
}
module notch()
{
   translate([0,w/2-bw,p/2])
   {
      cube([w-2*bw, nw, 2*td], center=true);
   }
}



module day_text(day)
{
}
