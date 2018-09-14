// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// Holder to scan 126 film strips with a Reflecta ProScan 10T
//
// © 2018 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0


/* [Global] */


// … to preview. You will get both parts when you click “Create Thing”.
part = "halter"; // [halter: film holder, einsatz: film holder clamp]

// Set this to “render” and click on “Create Thing” when done with the setup.
preview = 1; // [0:render, 1:preview]

/* [Holder] */

// Width of the holder. This one and the next one are the two values you do need to set up for your scanner. Preset is for a Reflecta proScan. Maybe subtract half a millimtre for a better fit.
holder_width = 58.4;  // [20:0.1:150]

// Height or thickness of the holder. See above. You know they were too high when you need a mallet to go from one image to the next…
holder_thickness = 5.6;  // [3:0.1:10]

// How many exposures on the longest strips you want to fit into this. Make sure the resulting holder still fits onto your print bed.
images_per_strip = 4;  // [1:1:8]

// Different manufacturers’ scanner place their little catches to position the holder at different sides.
position_notch_side = 90;  // [90: bottom, 0: side]

/* [Magnets] */

// Diameter of the magnet hole. Add clearance by hand here. Set to 0 for no magnet holes.
magnet_diameter = 3.8;  // [0:0.1:15]
// Height or thickness of the magnet. Make sure to use magnets flat enough to fit.
magnet_height = 1;  // [0.5:0.1:3]

/* [Hidden] */

// Das ganze Filmgrößen-Geraffel wieder verstecken: ein thing pro
// Film. Teil der Automatik (mit/ohne Stege, Lang-oder Kurzkerbe) sind so
// halbwegs inaktiv.


// Width of the film
film_width = 35;  // [8:0.1:70]
// Length from the left edge of an exposure to its right edge
image_width = 28.8; // [8:0.1:100]
image_pitch = 127/4;  // Ein Viererstreifen ist genau 127 mm lang. Das ist
// irgendwie was rundes in Zöllen. Das muss mich nicht scheren.

// Size of an exposure from bottom to top.
image_height = 28.1; // Hat sich was, »quadratishc«. Nachmessen hat ergeben, dass die Bilder etwas breiter als hoch sind.
rand_unten = 5.6;  // Könnten 7/32 Zoll sein. What TF ever. Ich könnte 118 Schweizerfranken bezahlen und es im Standard nachlesen. Oder das Geld sparen
rand_oben = film_width - image_height - rand_unten;
echo("rand_oben", rand_oben);

bildabstand = max(image_pitch, image_width);
l_filmsteg = max(0, bildabstand-image_width);
r_r = 1.0;  // Rundungsradius
// Auch wichtig:
l_zk = 4;  // Länge Zentrierkerbe
b_zk = 4;  // Breite Zentrierkerbe
h_zk = 1.2;  // Tiefe der Zentrierkerbe
w_zk = 1;  // Wand bzw Abstand der Zentrierkerbe vom Rand

min_l_ksteg = 0.8;

l_griff = 25;
o_griff = 25;
w_griff = 3;


w_schraeg = 1;  // Breite der Abschrägung rund um die Filmfenster

kurzsteg_grenze = w_schraeg;  // Weniger als 1 mm pro Seite: Kurzstege

mit_langsteg_oben = ( rand_oben >= kurzsteg_grenze);
mit_langsteg_unten = ( rand_unten >= kurzsteg_grenze);


w_steg = 2;  // Breite für Stücke, die den Film zentrieren.
l_kurzsteg = 0.4*bildabstand;  // Länge für Stücke, die den Film zentrieren,
// wenn wir keine Fensterstege machen


magnet_off_oben = -2;
magnet_off_unten = 1.2;

w_filmloch = 2.5; // Ein zehntel Zoll?
l_filmloch = 3.5; // ca. 35/254 Zoll.
// dy_fl_bl = 1.25; // Abstand Filmloch oben zum Blidbereich
dy_fl_k = 1.86;  // Abstand Filmloch unten zur Filmkante
dx_fl_rl = 1.75;  // Abstand Filmloch links zum Rahmen links

// *******************************************************
// Extra parameters. These can be changed reasonably safely.


w = 1.8;  // Wall width
p = 1.2;  // Bottom, top plate height
c = 0.5;  // Clearance
c_z = 0.3;  // Clearance in z direction. Mostly for the magnet hole and centering ridge
angle = 60; // Overhangs much below 60° are a problem for me


// Halbwegs wichtig
h_steg = 1.6;  // Höhe für Stücke, die den Film zentrieren.
h_nut = h_steg + c_z;  // Tiefe für Stücke, auf denen der Film nicht aufliegt



// *******************************************************
// Some shortcuts. These shouldn’t be changed

tau = 2 * PI;  // π is still wrong. τ = circumference ÷ r

xy_factor = 1/tan(angle);
// To get from a height to a horizontal width inclined correctly
z_factor = tan(angle);  // The other way around

some_distance = 1.2 * holder_width;
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

// l_fenster = bildabstand * images_per_strip;
l_fenster = bildabstand * (images_per_strip - 1) + image_width;
l_rand = 2 * w_steg + w_schraeg + 2;
w_rand = w_schraeg + 7;
l_ue_a =  l_fenster + 2*l_rand;
w_einsatz = image_height + 2 * w_rand;
h_bd = holder_thickness/2;  // Höhe Boden oder Deckel

to_griff = l_ue_a/2 - o_griff - l_griff/2;



// *******************************************************
// End setup




// *******************************************************
// Generate the parts


print_part();
// filmhalter();
// einsatz();
// preview_parts();
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
      translate([0,0,holder_thickness + ms])
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
      magnetausschnitte();
      kerben(false);
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
      // magnetausschnitte(magnet_diameter/2);
      magnetausschnitte();
      kerben(true);
   }

}


module basis_filmhalter()
{
   translate([0,0,h_bd])
   {
      difference()
      {
         massiver_halter();
         einsatz_ausschnitt(2*c);
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
      translate([l_ue_a/2-r_r, holder_width/2-r_r, holder_thickness/2-r_r])
      {
         sphere(r=r_r);
      }
   }
}


module einsatz_ausschnitt(ec)
{
   translate([0, 0, holder_thickness])
   {
      translate([0, rand_unten - rand_oben, 0])
      cube([l_ue_a+2*ms, w_einsatz + ec, 2*holder_thickness], center=true);
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
         cube([l_griff + ec, holder_width + 2*ms, 2*holder_thickness], center=true);
         translate([0, -holder_width/2, 0])
         {
            cube([l_griff + ec, 2*w_griff+4*ec, 4*holder_thickness], center=true);
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
            cube([l_fenster, image_height, 1], center=true);
         }
         translate([0,0,-h_bd-0.5-ms])
         {
            cube(
               [l_fenster+2*w_schraeg, image_height+2*w_schraeg, 1], center=true);
         }
      }

   }
}


module magnetausschnitte()
{
   if (magnet_diameter > 0 && magnet_height > 0)
   {
      yo_mag = w_einsatz/2 + magnet_diameter/2;
      magnetausschnitt(to_griff, yo_mag + magnet_off_unten);
      magnetausschnitt(-to_griff, yo_mag + magnet_off_unten);
      magnetausschnitt(to_griff, -yo_mag - magnet_off_oben);
      magnetausschnitt(-to_griff, -yo_mag - magnet_off_oben);
   }
}

module magnetausschnitt(exo, eyo)
{


   // Mittig in den Griffen.
   translate(
      [exo, eyo, h_bd - magnet_height-c_z + ms])
   {
      cylinder(d=magnet_diameter, h=magnet_height+c_z);
      // N.B. Spiel ist schon im magnet_diameter eingerechnet
   }
}

module bodenstege()
{
   translate([0, 0, -ms+h_steg/2+h_bd])
   {
      if (mit_langsteg_unten)
      {
         langbodensteg(rand_unten);
      }
      else
      {
         kurzbodenstege(rand_unten);
      }
      if (mit_langsteg_oben)
      {
         rotate(180)
         {
            langbodensteg(rand_oben);
         }
      }
      else
      {
         rotate(180)
         {
            kurzbodenstege(rand_oben);
         }
      }
      zentriernasen();
   }
   module langbodensteg(eo)
   {
      translate([0,w_steg/2+image_height/2+c/2+eo, 0])
      {
         cube([l_fenster, w_steg, h_steg], center=true);
      }
   }
   module kurzbodenstege(eo)
   {
      for (i=[0:images_per_strip-1])
      {
         translate([-l_fenster/2 + (0.5 + i) * bildabstand, w_steg/2+image_height/2+eo+c/2, 0])
         {
            cube([l_kurzsteg, w_steg, h_steg], center=true);
         }
      }
   }
   module zentriernasen()
   {
      for (i=[0:1:images_per_strip-1])
      {
         // Irgendwie ist »oben« und »unten« verkehrt. Für Teile unten braucht mensch positive y-Werte.
         translate(
            [-l_fenster/2 + i * bildabstand-l_filmloch+image_width+c/2-dx_fl_rl,
             +image_height/2 + rand_unten - w_filmloch -dy_fl_k+ c/2 , -h_steg/2])
         {
            cube([l_filmloch-c, w_filmloch-c, h_steg]);
         }
      }
   }
}

module einsatzausschnitte()
{
   translate([0, 0, h_bd + ms-h_nut/2])
   {
      if (mit_langsteg_unten)
      {
         langausschnitt(rand_unten);
      }
      else
      {
         kurzausschnitte(rand_unten);
      }
      if (mit_langsteg_oben)
      {
         rotate(180)
         {
            langausschnitt(rand_oben);
         }
      }
      else
      {
         rotate(180)
         {
            kurzausschnitte(rand_oben);
         }
      }
      zentrierausschnitte();
   }
   module langausschnitt(eyo)
   {
      translate([0,w_steg/2+image_height/2+eyo+c/2,0])
      {
         cube([l_fenster+6*c, w_steg+2*c, h_nut], center=true);
      }
   }
   module kurzausschnitte(eyo)
   {
      for (i=[0:images_per_strip-1])
      {
         translate(
            [-l_fenster/2 + (0.5 + i) * bildabstand,
             w_steg/2+image_height/2+eyo+c/2-film_width/4 + image_height/4, 0])
         {
            cube(
               [l_kurzsteg+2*c, w_steg+2*c+film_width/2 - image_height/2,
                h_nut], center=true);
         }
      }
   }
      module zentrierausschnitte()
   {
      for (i=[0:images_per_strip-1])
      {
         translate(
            [-l_fenster/2 + i * bildabstand-c/2+dx_fl_rl,
             +image_height/2 + rand_unten - w_filmloch -dy_fl_k- c/2 , -h_nut/2])
         {
            cube([l_filmloch+c, w_filmloch+c, h_nut]);
         }
      }
   }
}


module fensterstege()
{
   if (l_filmsteg > 0)
   {
      for (i=[0.5:1:images_per_strip-1.5])
      {
         translate([-l_fenster/2 + i * bildabstand + image_width/2, 0, 0])
         {
            if (l_filmsteg < min_l_ksteg)
            {
               quader_fenstersteg();
            }
            else
            {
               keil_fenstersteg();
            }
         }
      }
   }
   module quader_fenstersteg()
   {
      translate([0,0,h_bd/2-ms])
      {
         cube([l_filmsteg, image_height+2*w_schraeg + 2*ms ,h_bd], center=true);
      }
   }
   module keil_fenstersteg()
   {
      l_fsb = max(l_filmsteg-2*w_schraeg,min_l_ksteg);
      ihp = image_height + 2*w_schraeg + 2*ms;
      echo("fenstersteg am boden",l_fsb);
      hull()
      {
         translate([0,0,h_bd])
         {
            cube([l_filmsteg, ihp, ms], center=true);
         }
         //  translate([0,0,-ms])
         cube([l_fsb, ihp, ms], center=true);
      }
   }
}


module kerben(oben)
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
   // Die Variable heißt »position_notch_side«, und enthält einen Winkel. Funktioniert.
   dz_zk = (position_notch_side > 0) ?
      ( (oben) ? holder_thickness - h_zk + r_zk : h_zk-r_zk) :
      -ms;
   ahzk = (position_notch_side > 0) ? b_zk : holder_thickness + 2*ms;
   hk_yo = (position_notch_side > 0) ? -w_zk - b_zk : r_zk -h_zk;
   for (i=[0:images_per_strip-1])
   {
      translate(
         [-l_fenster/2 + i * bildabstand + image_width/2, -holder_width/2 -hk_yo, dz_zk])
      {
         rotate([position_notch_side,0,0])
         {
            cylinder(r=r_zk, h=ahzk);
         }
      }
   }

}
