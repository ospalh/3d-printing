// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// A stamp
//
// © 2018–2019 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0

/* [Global] */

// Set this to “render” and click on “Create Thing” when done with the setup.
preview = 1; // [0:render, 1:preview]

part = "s";  // [s:Stempel, h:Hilfsform, t:Text]

/* [Sizes] */

//
text_font_size = 5;  // [1:0.1:40]
text_font = "Praxis LT:Heavy";

/* [Hidden] */

// Done with the customizer

// *******************************************************
// Extra parameters. These can be changed reasonably safely.


w = 1.8;  // Wall width
p = 0.6;  // Bottom, top plate hight
c = 0.4;  // Clearance
h_t = 2;
h_st_1 = 20;
h_st_2 = 8;
h_st_3 = 8;
angle = 60; // Overhangs much below 60° are a problem for me

r1 = 4;
r2 = 2;
r3 = 1;
sp_2 = 12;
spf = 1.08;
esf = 0.3;
fw = 0.8;
stw = 11.75*text_font_size;
sth = (6*spf+4*esf-0.26)*text_font_size;

// *******************************************************
// Some shortcuts. These shouldn’t be changed

tau = 2 * PI;  // π is still wrong. τ = circumference / r

xy_factor = 1/tan(angle);
// To get from a hight to a horizontal width inclined correctly
z_factor = tan(angle);  // The other way around


some_distance = 50;
ms = 0.01;  // Muggeseggele.

fof = 1 * spf * text_font_size;

// fn for differently sized objects and fs, fa; all for preview or rendering.
pna = 40;
pnb = 15;
pa = 5;
ps = 1;
rna = 180;
rnb = 30;
ra = 1.6;
rs = 0.25;
function na() = (preview) ? pna : rna;
function nb() = (preview) ? pnb : rnb;
$fs = (preview) ? ps : rs;
$fa = (preview) ? pa : ra;

// *******************************************************
// End setup



// *******************************************************
// Generate the parts

print_part();

module print_part()
{
   if ("s" == part)
   {
      kein_verkauf_stempel();
   }
   if ("h" == part)
   {
      hilfsform();
   }
   if ("t" == part)
   {
      2d_text();
   }
}

// *******************************************************
// Code for the parts themselves

module kein_verkauf_stempel()
{
   text_stamp();
   stamp_back();
   stamp_grid();
   stem();
}

module hilfsform()
{
   translate([0,0, h_t])
   {
      linear_extrude(p + h_st_1 + h_st_2 + h_st_3 + 5)
      {
         hull()
         {
            scale(1.05)
            {
               2d_text();
            }
         }
      }
   }

}

module stamp_back()
{
   translate([0,0,h_t])
   {
      linear_extrude(p)
      {
         hull()
         {
            2d_text();
         }
      }
   }
}



module stamp_grid()
{
   translate([0,0,h_t+p])
   {
      intersection()
      {
         linear_extrude(r1+ms)
         {
            hull()
            {
               2d_text();
            }
         }
         translate([0, fof, 0])
         {
            grid();
         }
      }
   }
}

module grid()
{
   rotate([0,90,0])
   {
      cylinder(r=r1, h=1.1*stw, center=true);
   }
   rotate([90,0,0])
   {
      for (xo=[-0.6*stw:sp_2:0.6*stw])
      {
         translate([xo,0,0])
         {
            cylinder(r=r2, h=1.1*sth, center=true);
         }
      }
   }
   rotate([0,90,0])
   {
      translate([0,0.4*sth,0])
      {
         cylinder(r=r3, h=1.1*stw, center=true);
      }
      translate([0,-0.4*sth,0])
      {
         cylinder(r=r3, h=1.1*stw, center=true);
      }

   }

}

module stem()
{
   translate([0, fof, h_t+p])
   {
      difference()
      {
         union()
         {
            cylinder(r=r1, h=h_st_1+ms);
            translate([0,0,h_st_1])
            {
               cylinder(r1=r1, r2=2*r1,h=h_st_2+ms);
            }
            translate([0,0,h_st_1+h_st_2])
            {
               cylinder(r=2*r1,h=h_st_3);
            }
         }
         translate([0,0,h_st_1+h_st_2+h_st_3-1])
         {
            linear_extrude(1+ms)
            {
               text("Ts", size=2*r1, halign="center", valign="bottom", font=text_font);
               text("Wv", size=2*r1, halign="center", valign="top", font=text_font);
            }
         }
      }
   }
}

module text_stamp()
{
   linear_extrude(h_t+ms)
   {
      2d_text();
   }
}


module 2d_text()
{
   2d_text_t();
   translate([0, -0.6*esf*text_font_size])
   {
      square([stw+ms,fw], center=true);
   }
   translate([0, (2*spf-0*esf)*text_font_size])
   {
      square([stw+ms,fw], center=true);
   }
   translate([stw/2+ms,(spf)*text_font_size-fw/2])
   {

      square([fw,sth], center=true);
   }
   translate([-stw/2-ms,spf*text_font_size-fw/2])
   {

      square([fw,sth], center=true);
   }
   translate([0,(spf-0.08)*text_font_size+sth/2])
   {
      square([stw+fw,fw], center=true);
   }
   translate([0,(spf-0.08)*text_font_size-sth/2])
   {
      square([stw+fw,fw], center=true);
   }
}


module 2d_text_t()
{

   translate([0,(3+esf)*spf*text_font_size])
   {
      text(
         text="Tauschregal-", font=text_font, size=text_font_size,
         halign="center");
   }
   translate([0,(2+esf)*spf*text_font_size])
   {
      text(
         text="spende", font=text_font, size=text_font_size,
         halign="center");
   }
   translate([0,spf*text_font_size])
   {
      text(
         text="Mitnehmen, lesen,", font=text_font, size=text_font_size,
         halign="center");
   }
   //translate([0,0])
   {
      text(
         text="zurückstellen", font=text_font, size=text_font_size,
         halign="center");
   }
   translate([0,-(spf+esf)*text_font_size])
   {
      text(
         text="Weiterverkauf", font=text_font, size=text_font_size,
         halign="center");
   }
   translate([0,-(2*spf+esf)*text_font_size])
   {
      text(
         text="verboten", font=text_font, size=text_font_size,
         halign="center");
   }
}
