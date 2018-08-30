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
// These are for Minox
// *******************
// Comment them out for 110
w_streifen = 9.2;
w_bild = 8;
l_bild = 13;
bilder_ps = 11;
fensterstegbreit = 0.0;
// Keine Fensterstege. Für einen auf Dauer präzisen Transportmechanismus
// war in den Minoxkameras wohl kein Platz mehr. Jedenfalls schwankt der
// Abstand von Bild zu Bild bei meinen Streifen enorm.
// Die geringe Breite und die seitlichen Stege sollten reichen.

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
// l_filmsteg = 0.8;
// Steg zwischen zwei Bildern. Zwei mal rüber mit der Düse


// Größen des Halters.

// Länge == Maß in Richtung des Filmlaus.
// Höhe == Maß normal zum Film
// Breite oder Weite == Maß in Richtung Filmkante zu Filmkante

// Die beiden wichtigen. Wenn diese falsch sind passt’s nicht oder wackelt.
h_ue_a = 5.6;  // Höhe über alles. War 6
w_gesamt = 58.4;  // Gesamtbreite. Original: 59
r_r = 1.6;  // Rundungsradius

// Auch wichtig:
l_zk = 4;  // Länge Zentrierkerbe
b_zk = 4;  // Breite Zentrierkerbe
h_zk = 1.2;  // Tiefe der Zentrierkerbe
w_zk = 1;  // Wand bzw Abstand der Zentrierkerbe vom Rand

l_griff = 30;
o_griff = 20;
w_rand = 3;

// Halbwegs wichtig
h_nut = 0.8;  // Tiefe für Stücke, auf denen der Film nicht aufliegt
h_steg = 0.6;  // Höhe für Stücke, die den Film zentrieren.
w_steg = 2;  // Breite für Stücke, die den Film zentrieren.





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

l_fenster = l_bild * bilder_ps;
l_rand = 2 * w_steg + w_schraeg;
l_ue_a =  l_fenster + 2*l_rand;
w_einsatz = w_bild + 2 * l_rand;
h_bd = h_ue_a/2;  // Höhe Boden oder Deckel

to_griff = l_ue_a/2 - o_griff - l_griff/2;



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
         rotate([0,180,0])
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
      kerben();
   }
   fensterstege();
   bodenstege();
}

module einsatz()
{
   difference()
   {
      union()
      {
         difference()
         {
            basis_einsatz();
            fenster();
         }
         fensterstege();
      }
      einsatzausschnitte();
      // magnetausschnitte(d_mag/2);
      magnetausschnitte(0);
   }

}


module basis_filmhalter()
{
   translate([0,0,h_bd])
   {
      difference()
      {
         massiver_halter();
         einsatz_ausschnitt(c);
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
         rotate([0,180,0])
         {
            einsatz_ausschnitt(0);
         }
      }
   }

}

module massiver_halter()
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
      translate([l_ue_a/2-r_r, w_gesamt/2-r_r, h_ue_a/2-r_r])
      {
         sphere(r=r_r);
      }
   }
}


module einsatz_ausschnitt(ec)
{
   translate([0, 0, h_ue_a])
   {
      cube([l_ue_a+2*ms, w_einsatz + ec, 2*h_ue_a], center=true);
      grip_cut();
      mirror()
      {
         grip_cut();
      }
   }
   module grip_cut()
   {
      translate([to_griff, 0, 0])
      {
         cube([l_griff + ec, w_gesamt + 2*ms, 2*h_ue_a], center=true);
         translate([0, -w_gesamt/2, 0])
         {
            cube([l_griff + ec, 2*w_rand+2*ec, 4*h_ue_a], center=true);
         }
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
            cube([l_fenster, w_bild, 1], center=true);
         }
         translate([0,0,-h_bd-0.5-ms])
         {
            cube(
               [l_fenster+2*w_schraeg, w_bild+2*w_schraeg, 1], center=true);
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
   yo_mag = w_einsatz/2 + (w_gesamt - w_einsatz)/4;
   // Mittig in den Griffen.
   translate(
      [xf * (to_griff - mo), yf * (yo_mag-mo), h_bd - h_mag-c + ms])
   {
      cylinder(d=d_mag, h=h_mag+c);  // N.B. Spiel ist schon im d_mag
      // eingerechnet
   }
}

module bodenstege()
{
   bodensteg();
   rotate(180)
   {
      bodensteg();
   }
   module bodensteg()
   {
      translate([0, 0, -ms+h_steg/2+h_bd])
      {
         translate([0,w_steg/2+w_streifen/2+c/2,0])
         {
            cube([l_fenster, w_steg, h_steg], center=true);
         }
      }
   }
}

module einsatzausschnitte()
{
   ausschnitt();
   rotate(180)
   {
      ausschnitt();
   }
   module ausschnitt()
   {
      translate([0, 0, h_bd + ms-h_nut/2])
      {
         translate([0,w_steg/2+w_streifen/2+c/2,0])
         {
            cube([l_fenster+6*c, w_steg+1.5*c, h_nut], center=true);
         }
      }
   }
}


module fensterstege()
{
   if (fensterstegbreite > 0)
   {
      for (i=[1:bilder_ps-1])
      {
         translate([-l_fenster/2 + i * l_bild, 0, h_bd/2-ms])
         {
            cube([l_filmsteg, w_bild+2*w_schraeg + 2*ms ,h_bd], center=true);
         }
      }
   }
}

module kerben()
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
   for (i=[0:bilder_ps-1])
   {
      translate(
         [-l_fenster/2 + i * l_bild + l_bild/2, w_gesamt/2 - w_zk, h_zk-r_zk])
      {
         rotate([90,0,0])
         {
            cylinder(r=r_zk, h=b_zk);
         }
      }
   }

}
