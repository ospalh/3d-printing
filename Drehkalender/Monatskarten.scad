// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// Monatkarten fuer den Drehkalender
//
// (c) 2018 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0

// Several versions of the moth cards, in different languages or scripts
// N.B.: Pick a font you actually have!

// German (de = deutsch)
month_de =
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
font_de = "Praxis LT:style=Heavy";
lh_de = 6.5;  // Text hight


// English
month_en =
   ["Nullvember",  // month[0]
      "Jan",  // month[1] = Januar(y) &c.
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec"
      ];
font_en = "Praxis LT:style=Heavy";
lh_en = 6.5;  // Text hight

// Using European-Arabic numerals. This is easier then using str(m) later
// for only this version.
month_ea =
   ["Nullvember",  // month[0]
      "1",  // month[1] = Januar(y) &c.
      "2",
      "3",
      "4",
      "5",
      "6",
      "7",
      "8",
      "9",
      "10",
      "11",
      "12"
      ];
font_ea = "Praxis LT:style=Bold";
lh_ea = 11;  // Text hight


month_rom =
   ["Nullvember",  // month[0]
      "I",  // month[1] = Januar(y) &c.
      "II",
      "III",
      "IV",
      "V",
      "VI",
      "VII",
      "VIII",
      "IX",
      "X",
      "XI",
      "XII"
      ];
font_rom = "Praxis LT:style=Bold";
lh_rom = 8;  // Text hight

// Change here to pick the language or version you want
month = month_de;
font = font_de;
lh = lh_de;

// *****************************************************
// End language setting section

p = 0.8;  // hight of the edge
d = 0.4;  // Depth of the text

// font = "Praxis LT:style=Regular";

pw = 17;  // month plate width
ph = 18; // month plate hight
gap = 3;
tyo = -2; // Text y offset. Shif the text down slightly.



// *******************************************************
// Some shortcuts. These shouldn't be changed

ms = 0.01;  // Muggeseggele.

pwb = pw + 2 * p;
phb = ph + p;  // Grove only at the bottom
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
   translate([pwb/2, phb/2+tyo, 2*p-d])
   {
      linear_extrude(d+ms)
      {
         text(
            text=month[m], halign="center", valign="center", font=font,
            size=lh, $fs=0.1, $fa=1);
      }
   }
}
