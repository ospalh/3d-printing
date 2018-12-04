// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// Damesteine
// draughts piecse
//
// © 2018 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0

/* [Global] */

// … to preview. You will get all six parts when you click “Create Thing”.
part = "black token"; // [piece: draughts piece, white token: token for white king, black token: token for black king, morris: piece for x men morris]


// Set this to “render” and click on “Create Thing” when done with the setup.
preview = 1; // [0:render, 1:preview]

/* [Sizes] */

d_g = 30;  // Gesamtdurchmesser
h_g = 10;  // Gesamthöhe
d_m = 19.75;  // Münzdurchmesser. 10 ¢ (€)
h_m = 2.0;  // Münzdicke oder -höhe. Nominell 1.93 mm
d_r = 1.2;  // Dicke Riffelung
n_r = 23;  // Anzahl Riffelungen
r_vr = 2.4;  // Radius der Verrundung.
r_wnk = 45;  // Winkel der Riffelung


/* [Hidden] */

// Done with the customizer

// *******************************************************
// Extra parameters. These can be changed reasonably safely.


c = 0.3;  // Clearance
angle = 60; // Overhangs much below 60° are a problem for me
font="Symbola:style=Regular";
ts = 0.92 * d_m;
syt = -0.5;
sxt = -0.3;
t_h = 0.4;  // Textextrusionshöhe

// *******************************************************
// Some shortcuts. These shouldn’t be changed

tau = 2 * PI;  // π is still wrong. τ = circumference / r

xy_factor = 1/tan(angle);
// To get from a height to a horizontal width inclined correctly
z_factor = tan(angle);  // The other way around


some_distance = 50;
ms = 0.01;  // Muggeseggele.

r_g = d_g/2;
r_m = d_m/2;
r_ml = r_m + c; // Münzlochradius

some_x_distance = 1.5*d_g;
some_y_distance = 0.75*(d_g+d_m);

// fn for differently sized objects and fs, fa; all for preview or rendering.
pna = 40;
pnb = 15;
pa = 5;
ps = 1;
rna = 180;
rnb = 30;
ra = 1;
rs = 0.1;
function na() = (preview) ? pna : rna;
function nb() = (preview) ? pnb : rnb;
$fs = (preview) ? ps : rs;
$fa = (preview) ? pa : ra;

// *******************************************************
// End setup



// *******************************************************
// Generate the parts

print_part();
// preview_parts();

module print_part()
{
   if ("white" == part)
   {
      weisser_stein();
   }

   if (part == "black")
   {
      schwarzer_stein();
   }
   if (part == "piece")
   {
      stein(false);
   }
   if ("white token" == part)
   {
      weisser_marker();
   }

   if (part == "black token")
   {
      schwarzer_marker();
   }
   if (part == "50 ¢")
   {
      rohtoken(false);
   }
   if (part == "morris")
   {
      muehlestein();
   }
}

module preview_parts()
{
   weisser_stein();
   translate([0, some_y_distance, 0])
   {
      weisser_marker();
   }

   translate([some_x_distance, 0, 0])
   {
      schwarzer_stein();
      translate([0, some_y_distance, 0])
      {
      schwarzer_marker();
      }
   }
   translate([2*some_x_distance, 0, 0])
   {
      stein(false);
      translate([0, some_y_distance, 0])
      {
         rohtoken(false);
      }
   }
   translate([3*some_x_distance, 0, 0])
   {
      muehlestein();
   }
}



// *******************************************************
// Code for the parts themselves


module weisser_stein()
{
   stein(true);
   translate([0, 0, h_g - t_h - h_m])
   {
      symbol("⛀");
   }
}

module schwarzer_stein()
{
   stein(true);
   translate([0, 0, h_g - t_h - h_m])
   {
      symbol("⛂");
   }
}

module weisser_marker()
{
   %rohtoken(true);
   translate([0, 0, h_m-t_h])
   {
      #symbol("⛁");
   }
}

module schwarzer_marker()
{
   %rohtoken(true);
   translate([0, 0, h_m-t_h])
   {
      #symbol("⛃");
   }
}

module stein(space_for_text)
{
   difference()
   {
      rohstein();
      riffelung();
      markerloch(space_for_text);
   }
}

module markerloch(space_for_text)
{
   hof = (space_for_text) ? h_m+t_h : h_m;
   translate([0,0,h_g-hof])
   {
      cylinder(r=r_m+c, h=h_m+ms+t_h);
   }
}

module muehlestein()
{
   difference()
   {
      rohstein();
      riffelung();
   }
}

module rohstein()
{
   rotate_extrude()
   {
      steinschnitt();
   }
}

module riffelung()
{
   halbriffelung(r_wnk);
   halbriffelung(-r_wnk);

}

module halbriffelung(wnk)
{
   w_sch = 360 / n_r;
   for(i=[0 : w_sch : 360-ms])
   {
      rotate(i)
      {
         riff(wnk);
      }
   }
}

module riff(wnk)
{
   translate([r_g+ms, 0, h_g/2])
   {
      rotate([wnk, 0,0])
      {
         rotate([0,0,45])
         {
            cube([d_r,d_r, 2*h_g+10*ms], center=true);
         }
      }
   }
}

module steinschnitt()
{
   rot_points = [
      [0, 0],
      [r_g-r_vr+ms, 0],
      [r_g-r_vr+ms, r_vr-ms],
      [r_g, r_vr-ms],
      [r_g, h_g-r_vr+ms],
      [r_g-r_vr+ms, h_g-r_vr+ms],
      [r_g-r_vr+ms, h_g],
      [0, h_g],
      ];
  polygon(rot_points);
  translate([r_g-r_vr, r_vr])
  {
     circle(r=r_vr);
     translate([0, h_g-2*r_vr])
     {
        circle(r=r_vr);
     }
  }
}

module rohtoken(space_for_text)
{
   ht = (space_for_text) ? h_m-t_h : h_m;
   cylinder(r=r_m, h=ht);
}

module symbol(tx)
{
   translate([sxt,syt,-ms])
   {
      linear_extrude(t_h+ms)
      {
         text(text=tx, font=font, valign="center", halign="center", size=ts);
      }
   }
}
