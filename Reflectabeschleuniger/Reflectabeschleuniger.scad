// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// Holder to scan Minox film strips with a Reflecta ProScan 10T
//
// © 2018 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0


// Customizer-code rausgenommen. Hier gibt’s nicht viel zu verstellen.

// Teile wieder rein. Das preview, stack, print ist gut.
// … to preview. You will get all parts when you click “Create Thing”.
part = "halter"; // [halter: Filmhalter, einsatz: Klemmeinsatz]


// Auf false schalten, ums STL zu erzeugen
preview = true;


// Ausser vielleicht den Filmstreifengrößen.

// *******************
// These are for 135
// *******************
// Comment them out for 110
w_streifen = 35;
w_bild = 24;
l_bild = 36;



// // ********************
// // Try this set for 110
// // ********************
// // Uncomment these in for 110
// w_streifen = 16;
// w_bild = 13;
// l_bild = 17;


// Größen des Halters.

// Länge == Maß in Richtung des Filmlaus.
// Höhe == Maß normal zum Film
// Breite oder Weite == Maß in Richtung Filmkante zu Filmkante

// Die beiden wichtigen. Wenn diese falsch sind passt’s nicht oder wackelt.
h_ue_a = 5.6;  // Höhe über alles
w_gesamt = 64;  // Gesamtbreite

l_scanner = 104;  // Bestimmt die Position der Stoppnase und die Breite
// links. Nach Datenblatt
r_r = 1.5;  // Rundungsradius

l_sr = (l_scanner - l_bild)/2;


// Auch wichtig:
l_zk = 4;  // Länge Zentrierkerbe
b_zk = 4;  // Breite Zentrierkerbe
h_zk = 1.2;  // Tiefe der Zentrierkerbe
w_zk = 1;  // Wand bzw Abstand der Zentrierkerbe vom Rand

l_griff = l_bild;
w_rand = 3;


w_stop = w_gesamt + 5;  // Breite für Klotz, der Durchschieben den Halters verhindert.
l_stop = 5;  // Länge für diesen Klotz
l_er = 0; // l_stop;  // Extrabreite rechts. Dient dem Keil und dem Ausziehen des Halters.



l_filmsteg = 0.4;
// Steg zwischen zwei Bildern. Ein mal rüber mit der Düse sollte funktionieren.


// Größen der Haltemagnete
d_mag = 3.8; // großes Loch
h_mag = 1;

w_schraeg = 1.5;  // Breite der Abschrägung rund um die Filmfenster




// *******************************************************
// Extra parameters. These can be changed reasonably safely.


w = 1.8;  // Wall width
p = 1.2;  // Bottom, top plate height
c = 0.6;  // Clearance
angle = 60; // Overhangs much below 60° are a problem for me

// *******************************************************
// Some shortcuts. These shouldn’t be changed

tau = 2 * PI;  // π is still wrong. τ = ⌀ ÷ r

xy_factor = 1/tan(angle);
// To get from a height to a horizontal width inclined correctly
z_factor = tan(angle);  // The other way around

some_distance = 1.2 * w_gesamt;
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


l_ue_a =  l_sr + l_bild + l_sr + l_er;
w_einsatz = w_gesamt - 2 * w_rand;
h_bd = h_ue_a/2;  // Höhe Boden oder Deckel

h_bk = 0.2;  // Höhe Bildkerbe. 0.4 mm (dies × 2) sollte reichen. Für 1. test
w_br = 1;  // Extra Rand für Bildkerbe. (Mit der Perforation haben wir’s.)
l_br = 2;  // Extra Rand für Bildkerbe. (Mit der Perforation haben wir’s.)
h_lkl = 0.75*h_bd;

// *******************************************************
// End setup




// *******************************************************
// Generate the parts


// print_part();
// filmhalter();
// einsatz();
preview_parts();
// stack_parts();




module print_part()
{
   if ("halter" == part)
   {
      filmhalter();
   }
   if ("einsatz" == part)
   {
      einsatz();
   }
}

module preview_parts()
{
   filmhalter();
   translate([0, some_distance, 0])
   {
      einsatz();
   }
}

module stack_parts()
{
   // intersection()
   {
      // color("yellow")
      {
         filmhalter();
      }
      translate([0,0,h_ue_a + ms])
      {
         rotate([180, 0,0])
         {
            // color("red")
            {
               einsatz();
            }
         }
      }
   }
}

// *******************************************************
// Code for the parts themselves


module filmhalter()
{
   difference()
   {
      basis_filmhalter();
      fenster();
      magnetausschnitte(0);
      langnut(w_bild + 2*w_br, h_bk);
      zentrierkerbe(-1);
   }
}

module einsatz()
{
   difference()
   {
      basis_einsatz();
      fenster();
      langnut(w_streifen+c, h_bk);
      langnut(w_bild + 2*w_br, 2*h_bk);
      magnetausschnitte(0);
      leitkeil();
      zentrierkerbe(1);
   }

}


module basis_filmhalter()
{
   translate([0,0,h_bd])
   {
      difference()
      {
         massiver_halter();
         einsatzausschnitt(c);
      }
   }
}


module basis_einsatz()
{
   translate([0,0,h_bd])
   {
      intersection()
      {
         massiver_halter();
         rotate([180, 0, 0])
         {
            einsatzausschnitt(0);
         }
      }
   }

}

module massiver_halter()
{
   translate([l_er/2, 0, 0])
   {
      rquad(l_ue_a, w_gesamt, h_ue_a);
   }
   translate([w_bild/2+l_sr+l_stop/2, 0, 0])
   {
      rquad(l_stop, w_stop, h_ue_a);
   }
   // todo: Stopper
}

module rquad(xx, yy, zz)
{
   hull()
   {
      vosp();
      mirror([0,0,1])
      {
         vosp();
      }
   }

   module vosp()
   {
      tosp();
      mirror([0,1,0])
      {
         tosp();
      }
   }
   module tosp()
   {
      osp();
      mirror([1,0,0])
      {
         osp();
      }

   }

   module osp()
   {
      translate([xx/2-r_r, yy/2-r_r, zz/2-r_r])
      {
         sphere(r=r_r);
      }
   }
}


module einsatzausschnitt(ec)
{
   translate([0, 0, h_ue_a])
   {
      cube(
         [l_ue_a+2*ms + 2*l_er, w_einsatz + ec, 2*h_ue_a],
         center=true);  // Zu lang. Kein Problem

      grip_cut();
   }
   module grip_cut()
   {
      cube([l_griff + ec, w_gesamt + 2*ms, 2*h_ue_a], center=true);
      translate([0, -w_gesamt/2, 0])
      {
         cube([l_griff + ec, 2*w_rand+2*ec, 4*h_ue_a], center=true);
      }
   }
}

module fenster()
{
   translate([0, 0, h_bd])
   {
      hull()
      {
         translate([0,0,-0.5+ms])
         {
            cube([l_bild, w_bild, 1], center=true);
         }
         translate([0,0,-h_bd-0.5-ms])
         {
            cube(
               [l_bild+2*w_schraeg, w_bild+2*w_schraeg, 1], center=true);
         }
      }

   }
}


module magnetausschnitte(mo)
{
   magnetausschnitt(1, 1, mo);
   magnetausschnitt(-1, 1, mo);
   magnetausschnitt(1, -1, mo);
   magnetausschnitt(-1, -1, mo);
}

module magnetausschnitt(xf, yf, mo)
{
   yo_mag = w_gesamt/2 - w_rand - d_mag;
   // Mittig in den Griffen.
   translate(
      [xf * (l_bild/2-d_mag) , yf * (yo_mag-mo), h_bd - h_mag-c + ms])
   {
      cylinder(d=d_mag, h=h_mag+c);  // N.B. Spiel ist schon im d_mag
      // eingerechnet
   }
}


module zentrierkerbe(sf)
{
   // Den Radius der Zentrierkerbe kann mensch per Pythagoras bestimmen.
   // Hypothenuse = r_zk
   // 1. Kathete = l_zk/2
   // 2. Kathete = r_zk - h_zk
   // h_zk > 0
   // r_zk * r_zk = l_zk * l_zk / 4 + r_zk * r_zk - 2 * r_zk * h_zk + h_zk * h_zk
   // 0 = l_zk * l_zk / 4 - 2 * r_zk * h_zk + h_zk * h_zk
   // 2 * r_zk * h_zk =
   r_zk = (l_zk * l_zk / 4 + h_zk * h_zk) / (2 * h_zk);
   translate([0, sf*(w_gesamt/2 + r_zk - h_zk), -ms])
   {
      // rotate([90,0,0])
      {
         cylinder(r=r_zk, h=h_ue_a+2*ms);
      }
   }
}


module langnut(kw, kh)
{
   translate([0, 0, h_bd-kh/2+ms])
   {
      cube([l_ue_a+2*ms + 2*l_er, kw, kh], center=true);
      // Zu lang. Kein Problem
   }

}


module leitkeil()
{
   xo = l_bild/2+l_br;
   llk = l_er+l_sr-l_br;
   translate([xo, 0, h_bd+ms])
   {
      hull()
      {
         translate([0,0,-ms/2])
         {
            cube([ms, w_streifen + c, ms], center=true);
         }
         translate([llk+ms,0,-h_lkl/2])
         {
            cube([ms, w_streifen + c, h_lkl], center=true);
         }
      }
   }
}
