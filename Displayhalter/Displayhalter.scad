// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// Front-Displayhalterung
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

Display_nut_d = 5.4;

// Abstand der Hauptrahmengewindestangen
Dx_Rahmen = 170;

// X-Abstand der Displayschraubenlöcher
Dx_Display = 144.3;

// Y-Abstand der Displayschraubenlöcher
Dy_Display = 49.7;

// Abstand der Hauptrahmenschrauben zur Oberkante des Rahmnens
Dy_Rahmen = 30;

// Extra-Höhe des kurzen Arms. Damit das Display nicht an den Rahmen kommt.
h_Oberarm = 17;

// Je nach Displaywinkel steht es nach unten über oder nicht
angle = 45;

// Höhe der Hauptrahmenbuchse
h_Buchse = 8;

/* [Hidden] */

// Done with the customizer

// *******************************************************
// Extra parameters. These can be changed reasonably safely.

r_waag = 6;
r_senk = 6;

w = 3;  // Wall width
p = 3;  //  Plate. Amount of material the nut works against
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

h_nut_r =  Display_nut_d/sqrt(3);



ms = 0.01;  // Muggeseggele.

// Sizes to place the parts
dy = Dy_Display * ixy_factor;
dh = Dy_Display * iz_factor;
dx = 0.5 * (Dx_Rahmen - Dx_Display);
dy_o = min(dy/2, Dy_Rahmen);
dy_u = dy - dy_o;

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
      halterung(true);
   }
   if ("rechts" == part)
   {
      halterung(false);
   }
}

module preview_parts()
{
   halterung(true);
   halterung(false);
}


// *******************************************************
// Code for the parts themselves


module halterung(links)
{
   difference()
   {
      if (links)
      {
         halterung_minus_rs();
      }
      else
      {
         mirror()
         {
            halterung_minus_rs();
         }
      }
      display();
      boden();
   }
}

module halterung_minus_rs()
{
   translate([-Dx_Rahmen/2, 0, 0])
   {
      difference()
      {
         halterung_massiv();
         rahmenschraube();
      }
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
   cylinder(r=M_Rahmen/2+cs+w, h=h_Buchse);
}

module rahmenschraube()
{
   translate([0,0,-ms-r_waag])
   {
      cylinder(r=M_Rahmen/2+cs, h=h_Buchse+2*ms+r_waag);
   }
}


module oberarm_w()
{
   hull()
   {
      sphere(r=r_waag);
      translate([dx, dy_o, 0])
      {
         sphere(r=r_waag);
      }
   }
}



module unterarm_w()
{
   hull()
   {
      sphere(r=r_waag);
      translate([dx, -dy_u, 0])
      {
         sphere(r=r_waag);
      }
   }
}

module oberarm_s()
{
   translate([dx, dy_o, 0])
   {
      cylinder(r=r_senk, h=h_Oberarm + 2*iz_factor * r_senk);
   }
}

module unterarm_s()
{
   translate([dx, -dy_u, 0])
   {
      cylinder(r=r_senk, h=h_Oberarm + 2*iz_factor * r_senk + dh);
   }
}


module display()
{
   ymax = Dy_Display * max(1, xy_factor, z_factor);
   translate([0, -dy_o+dy/2, h_Oberarm+1/2*Dy_Display * iz_factor])
   {
      rotate([-angle,0,0])
      {
         translate([0, 0, ymax/2])
         {
            cube(
               [Dx_Display + 2*r_senk+ms,
                Dy_Display + (2+2*ixy_factor)*r_senk+ms, ymax], center=true);
         }
         translate([-Dx_Display/2, -Dy_Display/2, 0])
         {
            m3_down();
         }
         translate([-Dx_Display/2, +Dy_Display/2, 0])
         {
            m3_down();
         }
         translate([+Dx_Display/2, -Dy_Display/2, 0])
         {
            m3_down();
         }
         translate([+Dx_Display/2, +Dy_Display/2, 0])
         {
            m3_down();
         }
      }
   }
}

module m3_down()
{
   translate([0,0,-ms-2*r_senk-2*r_waag])
   {
      cylinder(r=M_Display/2+cs, h=2*ms+2*r_senk+2*r_waag);
      translate([0,0,-ms])
      {
         rotate(30)
         {
            cylinder(r=h_nut_r + cs , h=2*ms+2*r_senk+2*r_waag-p, $fn=6);
         }
      }
   }

}

module boden()
{
   translate([0,0,-2*r_senk-2*r_waag])
   {
      cube([4*Dx_Rahmen, 4*Dy_Display, 4*r_senk+4*r_waag], center=true);
   }

}
