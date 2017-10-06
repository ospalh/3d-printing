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
part = "cup"; // [cup: The portioner cup, funnel: The funnel and striker]

// cm³
volume = 44;  // [8:1:150]
// Maybe some shark fins?
style = 0; // [0:plain, 1:Googie]
// Use “preview” for a reasonably fast preview, set it to render and then click “Create Thing” to get your smoother finished STLs.
preview = 1; // [0:render, 1:preview]

// How wide the excess chute should be at the bottom. Thinner looks better, but it should be wide enough or your tea gets stuck. In mm.
chute_bottom_size = 10;

/* [Hidden] */
//
h_in_r = 2;  // Height of the cylinder in radiuses. Tweaked by hand

tau = 2 * PI;  // π is still wrong. τ = ⌀ ÷ r

w = 2.2;  // main wall width
w2 = 1.4;  // thinner wall width

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


some_distance = 5 * r;

// fn for differently sized objects, for preview or rendering.
pfa = 40;
pfb = 25;
rfa = 180;
rfb = 90;
function fa() = (preview) ? pfa : rfa;
function fb() = (preview) ? pfb : rfb;


// print_part();
preview_part();

module print_part()
{
   if ("cup" == part)
   {
      if (1 == style)
      {
         googie_cup();
      }
      else
      {
         cup();
      }
   }
   if (part == "funnel")
   {
      if (1 == style)
      {
         googie_funnel();
      }
      else
      {
         funnel();
      }

   }
}

module preview_part()
{
   if (1 == style)
   {
      googie_cup();
   }
   else
   {
      cup();
   }
   translate([0, some_distance, 0])
   {
      if (1 == style)
      {
         googie_funnel();
      }
      else
      {
         funnel();
      }
   }
}

module googie_cup()
{
}

module cup()
{
   difference()
   {
      union()
      {
         cup_body();
         stand();

      }
      cup_hollow();
   }
}

module googie_funnel()
{
}

module funnel()
{
}


module cup_body()
{
   translate([0, 0, r+w])
   {
      sphere(r=r+w, $fn=fa());
      cylinder(r=r+w, h = r*h_in_r, $fn=fa());
   }

}


module cup_hollow()
{
   translate([0, 0, r+w])
   {
      sphere(r=r, $fn=fa());
      cylinder(r=r, h = r*h_in_r + ms, $fn=fa());
   }
}

module googie_stand()
{
   stand();
}

module stand()
{
   difference()
   {
      full_stand();
      right_hand_cut();
   }
}

module full_stand()
{
   cylinder(r1=2.5*r, r2=r+w, h=r, $fn=fa());
}


module right_hand_cut()
{
   // Cut off material to the right of the main cup.
   translate([r+w, -5*r, -ms])
   {
      cube(10*r);
   }
}
