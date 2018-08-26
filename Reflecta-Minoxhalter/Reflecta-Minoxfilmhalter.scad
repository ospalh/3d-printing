// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// Holder to scan Minox film strips with a Reflecta ProScan 10T
//
// © 2018 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0


// Customizer-code rausgenommen. Hier gibt’s nicht viel zu verstellen.

// Ausser vielleicht den Filmstreifengrößen.

// *******************
// These are for Minox
// *******************
// Comment them out for 110
w_streifen = 9.2;
w_bild = 8;
l_bild = 13.1;
bilder_ps = 10;

// // ********************
// // Try this set for 110
// // ********************
// // Uncomment these in for 110
// w_streifen = 16;
// w_bild = 14; // Nominally 13. This should work out
// l_bild = 25.4;
// // Total pitch, picture plus number and hole. Measured. Might be exactly
// // 25.4 mm, as the format was made by Americans.
// bilder_ps = 7;
// // The strips i got were all 5. Otoh, the 135 holder you get with the
// // scanner has 6 holes and the strips i have all have 4. So, +2.

// N.B.: For the 110 holder, you have to modify the second file
// “hinge/hinge.scad” and change the size (height) of the hinge.

// Größen des Halters.

// Länge == Maß in Richtung des Filmlaus.
// Höhe == Maß normal zum Film
// Breite oder Weite == Maß in Richtung Filmkante zu Filmkante

// Die beiden wichtigen. Wenn diese falsch sind passt’s nicht oder wackelt.
h_ue_a = 6;  // Höhe über alles
w_gesamt = 60;  // Gesamtbreite

// Auch wichtig:
l_zk = 4;  // Länge Zentrierkerbe
b_zk = 4;  // Breite Zentrierkerbe
h_zk = 1.2;  // Tiefe der Zentrierkerbe
w_zk = 1;  // Wand bzw Abstand der Zentrierkerbe vom Rand

// Nicht so wichtig
// l_e = 22;  // Originallänge der Endstücke.
l_e = 8;  // Länge der Endstücke. Braucht mensch nicht wirklich

// Halbwegs wichtig
h_nut = 1;  // Tiefe für Stücke, auf denen der Film nicht aufliegt
h_steg = 1;  // Höhe für Stücke, die den Film zentrieren.

w_boden = 2.4;  // Wand des Bodenteils, das der Deckel schmaler ist.
l_filmsteg = 0.4;
// Steg zwischen zwei Bildern. Ein mal rüber mit der Düse sollte funktionieren.


// Größen der Haltemagnete
d_mag = 2;
h_mag = 1;

// Zahl der Haltemagnete
n_mag_a = 7;
n_mag_i = 5;

h_ue_mag = 0.4;
// Zwei Schichten über den Magneten sollte reichen, sie im Zaum zu halten

w_schraeg = 1.5;  // Breite der Abschrägung rund um die Filmfenster

// l_scharnier = 13;  // Zielbreite für eine Scharnierstück

// Auf false schalten, ums STL zu erzeugen
preview = true;



// *******************************************************
// Extra parameters. These can be changed reasonably safely.


w = 1.8;  // Wall width
p = 1.2;  // Bottom, top plate height
c = 0.4;  // Clearance
angle = 60; // Overhangs much below 60° are a problem for me

// *******************************************************
// Some shortcuts. These shouldn’t be changed

tau = 2 * PI;  // π is still wrong. τ = ⌀ ÷ r

xy_factor = 1/tan(angle);
// To get from a height to a horizontal width inclined correctly
z_factor = tan(angle);  // The other way around

use <./hinge/hinge.scad>;
some_distance = 50;
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

l_fenster = l_bild * bilder_ps;
l_ue_a = l_e + w_schraeg + l_fenster + w_schraeg + l_e;
w_bodenwanne = w_gesamt - 1.5 * h_ue_a;
h_bd = h_ue_a/2;  // Höhe Boden oder Deckel
w_deckel = w_bodenwanne - w_boden - c;
w_offset_scharnier = h_ue_a;
x_offset_gesamt = l_ue_a/2;
w_offset_zentrum = w_gesamt/2 - h_ue_a/2;

echo("Länge über alles", l_ue_a);

// *******************************************************
// End setup



// *******************************************************
// Generate the parts

// Was wir wollen
// filmhalter(true);


// Zum Testen
// filmhalter(false);
// halterboden();
halterdeckel(true, false);


// *******************************************************
// Code for the parts themselves


module filmhalter(offen)
{
   halterboden();
   halterdeckel(offen, true);
}

module halterboden()
{
   difference()
   {
      union()
      {
         halterteil_massiv(true);
         hinge(true, false);
      }
      fenster();
      boden_ausschnitt();
      magnet_ausschnitte();
   }
   boden_stege();
   fenster_stege();
}


module halterdeckel(offen, vereint)
{
   rot_x = (offen) ? 0 : 180;
   rot_z = (vereint) ? 180 : 0;
   rotate([rot_x, 0, rot_z])
   {
      difference()
      {
         union()
         {
            halterteil_massiv(false);
            rotate(180)
            {
               hinge(false, true);
            }
         }
         fenster();
         deckel_ausschnitt();
         magnet_ausschnitte();
      }
      deckel_griff();
      fenster_stege();
   }
}


module halterteil_massiv(boden)
{
   y_l = (boden) ? w_bodenwanne : w_deckel;
   translate([-x_offset_gesamt, w_offset_scharnier, -h_bd])
   {
      cube([l_ue_a, y_l, h_bd]);
   }
}


module fenster()
{
   // Zuerst zu groß, um die Ausrichtung zu checken
   translate([0, w_offset_zentrum, 0])
   {
      hull()
      {
         translate([0,0,-0.5+ms])
         {
            cube([l_fenster, w_streifen, 1], center=true);
         }
         translate([0,0,-h_bd-0.5-ms])
         {
            cube([l_fenster+2*w_schraeg, w_streifen+2*w_schraeg, 1], center=true);
         }
      }

   }
}
