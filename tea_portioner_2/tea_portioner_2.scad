// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// Another tea portioner.
//
// The same pot, funnel and striker, and ramp principle as the first, but
// using a number of design lessons i’ve since learned, and some new ideas.
//
// © 2017 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0

// … to preview. You will get both parts when you click “Create Thing”.
part = "cup"; // [cup: The portioner cup, funnel: The funnel and striker, stand: The stand to keep the cup clean]

// cm³
volume = 44;  // [8:1:150]
// Maybe some shark fins?
preview = 1; // [0:render, 1:preview]

// Size of the stand. Set this to 0 to just get a tray to keep the cup clean for the striking. In mm.
stand_diameter = 50;  // [0:1:80]

// Funnel diameter

/* [Hidden] */
//
h_in_r = 1;  // Height of the cylinder in radiuses. Tweaked by hand

tau = 2 * PI;  // π is still wrong. τ = ⌀ ÷ r

w = 2.2;  // funnel &c. wall width
min_stand_height = 15;
flange_height = 10;

chute_limit_diameter = 15;
chute_limit_factor = 0.3;

ms = 0.1;  // Muggeseggele

// Somewhat comprehensible math to get r from V
// V = ½ (V sphere) + V cylinder
// V = ½ × (2τ r² × ⅓ r) + ½ τ r² × h
//
// (The V = 2τ/3 × r³ can be split in 2τr² × ⅓r: think of infinitesimal
// pyramids with the base area of the surface area of a sphere, 2τr², and
// the Volume of base area × ⅓ h, with h = r.)
// (Similarly, the area of a circle can be seen as a rectangle of
// infinitesimal circle sectors, with the outer bit alternatively at the
// top and bottom. That gives the area as r × ½ circumference, or r ×
// ½τr. No argument against τ or for π.)
//
r_cm = pow(volume/(tau/3+tau/2*h_in_r),1/3);
r = r_cm * 10;  // Volume is done in cm³, the rest of OpenSCAD uses mm.
// (And you don’t uses mm³ a.k.a. µl in everyday settings.)

r_cb = max(r*chute_limit_factor, chute_limit_diameter/2);
echo(r,r_cb);

some_distance = 6 * r;

// fn for differently sized objects, for preview or rendering.
pfa = 40;
pfb = 25;
rfa = 180;
rfb = 90;
function fa() = (preview) ? pfa : rfa;
function fb() = (preview) ? pfb : rfb;


// print_part();
preview_parts();

module print_part()
{
   if ("cup" == part)
   {
      cup();
   }
   if (part == "funnel")
   {
      funnel();
   }
   if (part == "stand")
   {
      stand();
   }
}

module preview_parts()
{
   cup();
   translate([0, some_distance, 0])
   {
      funnel();
   }
   translate([some_distance, 0, 0])
   {
      stand();
   }
}


module cup()
{
   difference()
   {
      union()
      {
         cup_body();

      }
      cup_hollow();
   }
}


module funnel()
{
}


module cup_body()
{

   cylinder(r=r+3*w, h = r*(h_in_r+1)+w+flange_height, $fn=fa());
   translate([2*r+w, 0, 0])
   {
      cylinder(r=r+3*w, h = r*(h_in_r+1)+w+flange_height, $fn=fa());
   }
   translate([0, -r-3*w, 0])
   {
      cube([2*r+w, 2*r+6*w, r*(h_in_r+1)+w+flange_height]);
   }
}


module cup_hollow()
{
   // Measuring hollow
   translate([0, 0, r+w])
   {
      sphere(r=r, $fn=fa());
      cylinder(r=r, h = r*h_in_r + ms, $fn=fa());
   }
   // chute
   translate([2*r+w, 0, -ms])
   {
      cylinder(r1=r_cb, r2=r, h=r*(h_in_r+1)+w + 2*ms, $fn=fa());
   }
   // not flange hollow
   translate([0,0,r*(h_in_r+1)+w])
   {
      cylinder(r=r+2*w, h = flange_height+ms, $fn=fa());
      translate([0, -r-2*w, 0])
      {
         cube([3*r+4*w+ms, 2*r+4*w, flange_height+ms]);
      }

   }
}

module stand()
{
   difference()
   {
      full_stand();
   }
}

module full_stand()
{
   cylinder(r1=2.5*r, r2=r+w, h=r, $fn=fa());
}
