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

text_32_1 = "🕴";
// text_32_2 = "drehen";
//text_33_1 = "u♨";
text_33_1 = "జ్ఞ‌ా";
// text_33_2 = "drehen";
text_34_1 = "☮";
// text_34_2 = "";
// text_34_1 = "";
// logo_34 = "NN.dxf";

font = "Demos LT:style=Semibold";
// font_34 = "DejaVu Sans:style=Bold";
// font_32 =  "DejaVu Sans:style=Bold";
font_32 = "Symbola";
//font_33 = "FreeSerif";
font_33 = "Lohit Telugu:style=Regular";
font_34 = "FreeSerif";

w = 50; // width of the plate
p = 3;  // height of the plate

bw = 4.3;  // Border width
nw = 1.2;
td = 0.4;  // Text depth

textsize_day = 0.55* (w-2*bw);
textsize_32 = 0.7 * (w-2*bw);
textsize_33 = 0.7 * (w-2*bw);
// textsize_34 = 0.15 * (w-2*bw);
textsize_34 = 0.7 * (w-2*bw);
spacing = 1.5;


some_distance = 55;
ms = 0.01;  // Muggeseggele.


// Generate cards from 1 through 17.
front_day = 16;

translate([0,0,p/2])
{
   calender_card(front_day);
}


module calender_card(front_day)
{
   difference()
   {
      notched_card();
      day_text(front_day);
      rotate([180,0,0])
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
   translate([0,0,p/2-td])
   {
      linear_extrude(2*td)
      {
         day_text_2d(day);
      }
   }
}


module day_text_2d(day)
{
   if (day <= 31)
   {
      big_text(day);
   }
   if (32 == day)
   {
      text_32();
   }
   if (33 == day)
   {
      text_33();
   }
   if (34 == day)
   {
      text_34();
   }
}

module big_text(day)
{
   text(
      text=str(day), halign="center", valign="center", font=font,
      size=textsize_day);
}


module text_32()
{
   // translate([0, 0.5*spacing*textsize_32])
   {
      text(
         text=text_32_1, halign="center", valign="center", font=font_32,
         size=textsize_32);
   }
}
module text_33()
{
   // translate([0, 0.5*spacing*textsize_33])
   {
      text(
         text=text_33_1, halign="center", valign="center", font=font_33,
         size=textsize_33);
   }

}

module text_34()
{
   text(
      text=text_34_1, halign="center", valign="center", font=font_34,
      size=textsize_34);
}

//module text_34()
//{
//   translate([0, 0.5*spacing*textsize_34])
//   {
//      text(
//         text=text_34_1, halign="center", valign="center", font=font,
//         size=textsize_34);
//   }
//   translate([0, -0.5*spacing*textsize_34])
//   {
//      text(
//         text=text_34_2, halign="center", valign="center", font=font,
//         size=textsize_34);
//   }
//}
