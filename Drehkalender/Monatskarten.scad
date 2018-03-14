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

font = "Praxis LT:style=Regular";
pw = 17;  // month plate width
ph = 18; // month plate height
gap = 3;


// *******************************************************
// Some shortcuts. These shouldn’t be changed

// Not really needed.

tau = 2 * PI;  // π is still wrong. τ = ⌀ ÷ r
ms = 0.01;  // Muggeseggele.

pwb = pw + 2 * p;
phb = ph + 2 * p;
gx = pwb + gap;
gy = phb + gap;

cpc = 4; // cards per column

twelve_months();

module twelve_months()
{
   translate([-1.5*gx + gap/2, -3*gy + gap/2, 0])
   {
      for (r=[0:cpc:11])
      {
         for (c=[1:cpc])
         {
            m = r+c;
            translate([r*gx/cpc, c*gy, 0])
            {
               echo(r*gx/cpc, c*gy);
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
   cube([pwb, phb, w]);
   translate([p, p, p-ms])
   {
      cube([pw, ph, p+ms]);
   }

}

module month_text(m)
{}
