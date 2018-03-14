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


month =
   ["Nullvember",  // month[0]
      "Jan",  // month[1] = Januar(y) &c.
      "Feb",
      "Mär",
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

// Set this to “render” and click on “Create Thing” when done with the setup.
preview = 1; // [0:render, 1:preview]


p = 0.8;  // height of the edge
d = 0.4;  // Depth of the text

// font = "Praxis LT:style=Regular";
font = "Praxis LT:style=Regular";
pw = 17;  // month plate width
ph = 18; // month plate height
gap = 3;
lh = 6.5;  // Text height

// *******************************************************
// Some shortcuts. These shouldn’t be changed

// Not really needed.

tau = 2 * PI;  // π is still wrong. τ = ⌀ ÷ r
ms = 0.01;  // Muggeseggele.

pwb = pw + 2 * p;
phb = ph + 2 * p;
gx = pwb + gap;
gy = phb + gap;

cpr = 3; // cards per column

twelve_months();

module twelve_months()
{
   translate([-2.5*gx + gap/2, 1*gy + gap/2, 0])
   {
      for (c=[0:cpr:11])
      {
         for (r=[1:cpr])
         {
            m = r+c;
            translate([r*gx, -c*gy/cpr, 0])
            {
               echo(r*gx/cpr, c*gy);
               month_card(m);
            }
         }
      }
   }
}

module month_card(m)
{
   difference()
   {
      plain_month_card();
      month_text(m);
   }
}

module plain_month_card()
{
   cube([pwb, phb, p]);
   translate([p, p, p-ms])
   {
      cube([pw, ph, p+ms]);
   }

}

module month_text(m)
{
   translate([pwb/2,phb/2, 2*p-d])
   {
      linear_extrude(d+ms)
      {
         text(
            text=month[m], halign="center", valign="center", font=font,
            size=lh, $fs=0.1, $fa=1);
      }
   }
}
