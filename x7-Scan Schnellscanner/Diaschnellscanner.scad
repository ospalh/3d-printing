// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// Holder to scan Minox film strips with a Reflecta ProScan 10T
//
// © 2018 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0




// … to preview. You will get all parts when you click “Create Thing”.
part = "halter"; // [halter: lower part, einsatz: upper part, st: Stössel, r: Rettungsschieber, s: stack, p: preview]

// Set this to “render” and click on “Create Thing” when done with the setup.
preview = 1; // [0:render, 1:preview]





w_rahmen = 50;
w_bild = 28;
l_bild = 38;
h_rahmen = 1.7;
l_rahmen = 50;

/* [Hidden] */

// Größen des Halters.

// Länge == Maß in Richtung des Filmlaus.
// Höhe == Maß normal zum Film
// Breite oder Weite == Maß in Richtung Filmkante zu Filmkante

// Die beiden wichtigen. Wenn diese falsch sind passt’s nicht oder wackelt.
h_ue_a = 4.8;  // Höhe über alles
w_gesamt = 64;  // Gesamtbreite



l_scanner = 104;  // Bestimmt die Position der Stoppnase und die Breite
// links. Nach Datenblatt
r_r = 1.5;  // Rundungsradius

l_sr = (l_scanner - l_bild)/2;

x_t_s = -1.5; // tweak für Stößellänge
x_t_f = +0.5; // tweak für Rahmen
y_t_n = -1; // tweak nut

// Auch wichtig:
l_zk = 4;  // Länge Zentrierkerbe
b_zk = 4;  // Breite Zentrierkerbe
h_zk = 1.2;  // Tiefe der Zentrierkerbe
w_zk = 1;  // Wand bzw Abstand der Zentrierkerbe vom Rand

l_griff = l_bild;
w_rand = 3;


w_stop = w_gesamt + 5;  // Breite für Klotz, der Durchschieben den Halters verhindert.
l_stop = 5;  // Länge für diesen Klotz


w_schraeg = h_ue_a/4;

l_ueber = (3*l_rahmen - l_scanner)/2 + x_t_f ; // // Extrabreite rechts. Dient als Maß beim Einschieben
echo("l_ueber", l_ueber);

// *******************************************************
// Extra parameters. These can be changed reasonably safely.


w = 1.8;  // Wall width
p = 1.2;  // Bottom, top plate height
c = 0.4;  // Clearance
c_h = 0.2;  // Spiel in Höhe
angle = 60; // Overhangs much below 60° are a problem for me

// *******************************************************
// Some shortcuts. These shouldn’t be changed

tau = 2 * PI;  // π is still wrong. τ = circumference ÷ r

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


l_ue_a =  l_sr + l_bild + l_sr + l_ueber;
w_einsatz = w_gesamt - 2 * w_rand;
h_bd = h_ue_a/2;  // Höhe Boden oder Deckel


// h_bk = 0.2;  // Höhe Bildkerbe. 0.4 mm (dies × 2) sollte reichen. Für 1. test
// w_br = 1;  // Extra Rand für Bildkerbe. (Mit der Perforation haben wir’s.)
// l_br = 2;  // Extra Rand für Bildkerbe. (Mit der Perforation haben wir’s.)
h_lkl = 0.75*h_bd;

// *******************************************************
// End setup




// *******************************************************
// Generate the parts


print_part();
// filmhalter();
// einsatz();
// preview_parts();
// stack_parts();


if ("p" == part)
{
   preview_parts();
}

if ("s" == part)
{
   stack_parts();
}

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
   if ("st" == part)
   {
      stoessel();
   }
   if ("r" == part)
   {
      rettungsschieber();
   }
}

module preview_parts()
{
   filmhalter();
   translate([0, some_distance, 0])
   {
      einsatz();
   }
   translate([0, -some_distance, 0])
   {
      stoessel();
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
      translate([0,0,h_ue_a/2 - h_rahmen/2])
      {
         stoessel();
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
      translate([0,y_t_n,0])
      {
         langnut(w_rahmen+2*c, h_rahmen/2+c_h);
      }
      zentrierkerbe(-1);
   }
}

module einsatz()
{
   difference()
   {
      basis_einsatz();
      fenster();
      translate([0,-y_t_n,0])
      {
         langnut(w_rahmen+2*c, h_rahmen/2+c_h);
      }
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
   translate([l_ueber/2, 0, 0])
   {
      rquad(l_ue_a, w_gesamt, h_ue_a);
   }
   translate([l_scanner/2+l_stop/2, 0, 0])
   {
      rquad(l_stop, w_stop, h_ue_a);
   }
}

module rquad(xx,yy,zz)
{
   quad(xx, yy, zz, r_r);
}

module quad(xx, yy, zz, rr)
{
   echo(xx, yy, zz, rr);
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
      translate([xx/2-rr, yy/2-rr, zz/2-rr])
      {
         sphere(r=rr);
      }
   }
}

module qquad(xx, yy, zz)
{
   intersection()
   {
      translate([-zz/2,0,0])
      {
         quad(xx,yy, zz, zz/2);
      }
      {
         translate([zz/2,0,0])
         {
            cube([xx+zz,yy, zz], center=true);
         }
      }
   }

}

module einsatzausschnitt(ec)
{
   translate([0, 0, h_ue_a])
   {
      cube(
         [l_ue_a+2*ms + 2*l_ueber, w_einsatz + ec, 2*h_ue_a],
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
      cube([l_ue_a+2*ms + 2*l_ueber, kw, kh], center=true);
      // Zu lang. Kein Problem
   }

}


module stoessel()
{
   translate([0.5*l_rahmen,0, 0])
   {
      translate([+20, 0, h_rahmen/2-c_h/2])
      {
         qquad(l_rahmen+40, l_rahmen-2*c, h_rahmen-c_h);
      }
      translate([l_rahmen/2+2.5 + x_t_s, 0, h_ue_a])
      {
         rquad(5, l_rahmen - 2*c, 2*h_ue_a);
      }
   }
   translate([l_rahmen+5, -5, h_rahmen-c_h-ms])
   {
      linear_extrude(1, convexity=8)
      {
         text(
            text="🢘", font="Symbola:style=Regular",
            valign="center", halign="left", size=32);
      }
   }
}


module rettungsschieber()
{
   qquad(l_ue_a+30, l_rahmen-2*c, h_rahmen-c_h);
}
