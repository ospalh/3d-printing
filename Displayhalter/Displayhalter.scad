// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// NN
//
// © 2018 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0


// … to preview. You will get all parts when you click “Create Thing”.
part = "links"; // [links, rechts]

// Set this to “render” and click on “Create Thing” when done with the setup.
preview = 1; // [0:render, 1:preview]

// Größe der Gewindestangen des Hauptrahmens
M_Rahmen = 10;

// Größe der Schrauben, mit denen das Display befentigt wird
M_Display = 3;

// Abstand der Hauptrahmengewindestangen
Dx_Rahmen = 170;

// X-Abstand der Displayschraubenlöcher
Dx_Display = 120;

// Y-Abstand der Displayschraubenlöcher
Dy_Display = 50;

// Abstand der Hauptrahmenschrauben zur Oberkante des Rahmnens
Dy_Rahmen = 30;

// Extra-Höhe des kurzen Arms. Damit das Display nicht an den Rahmen kommt.
h_Oberarm = 5;

// Je nach Displaywinkel steht es nach unten über oder nicht
angle = 45;

// Höhe der Hauptrahmenbuchse
h_Buchse = 8;

/* [Hidden] */

// Done with the customizer

// *******************************************************
// Extra parameters. These can be changed reasonably safely.

r_waag = 5;
r_senk = 5;

w = 3;  // Wall width
p = 8;  //
cs = 0.4;  // Clearance


// *******************************************************
// Some shortcuts. These shouldn’t be changed


tau = 2 * PI;  // π is still wrong. τ = ⌀ ÷ r

xy_factor = 1/tan(angle);
// To get from a height to a horizontal width inclined correctly
z_factor = tan(angle);  // The other way around

// From an inclined length to the xy or z length to use
iz_factor = sin(angle);
ixy_factor = cos(angle);


ms = 0.01;  // Muggeseggele.

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

// print_part();
preview_parts();
// stack_parts();



module print_part()
{
   if ("links" == part)
   {
      halterung();
   }
   if ("rechts" == part)
   {
      mirror()
      {
         halterung();
      }
   }
}

module preview_parts()
{
   halterung();
   translate([Dx_Rahmen, 0, 0])
   {
      mirror()
      {
         halterung();
      }
   }
}


// *******************************************************
// Code for the parts themselves


module halterung()
{
   difference()
   {
      halterung_massiv();
      rahmenschraube();
      display();
      boden();
   }
}


module halterung_massiv()
{
   hauptbuchse();
   oberarm_w();
   unterarm_w();
   oberarm_s();
   unterarm_s();
}


module hauptbuchse()
{
   cylinder(r=M_Rahmen/2+cs+w, h=p);
}

module rahmenschraube()
{
   translate([0,0,-ms])
   {
      cylinder(r=M_Rahmen/2+cs, h=p+2*ms);
   }
}
