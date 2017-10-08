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
volume = 55;  // [8:1:150]
// Set this to “render” and click on “Create Thing” when done with the setup.
preview = 1; // [0:render, 1:preview]

// Size of the stand. Set this to 0 to just get a tray to keep the cup clean for the striking. In mm.
stand_diameter = 50;  // [0:1:100]

// Funnel diameter
funnel_diameter = 90;  // [30:1:120]

/* [Hidden] */
//
h_in_r = 1;  // Height of the cylinder in radiuses. Tweaked by hand

tau = 2 * PI;  // π is still wrong. τ = ⌀ ÷ r

w = 2.2;  // funnel &c. wall width
p = 1.2;  // height of the bottomt plate
stand_height = 15;
flange_height = 10;
stand_peg_height = 2;

chute_limit_diameter = 15;
chute_limit_factor = 0.3;

ms = 0.1;  // Muggeseggele

clearance = 0.5;  // mm for the parts that should fit into each other

funnel_angle = 60;  // °

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


r_1 = r + w;  // outer diameter, striker
r_2 = r_1 + clearance; // inner size of the measure cup flange
r_3 = r_2 + w; // outer size of themeasure cup
r_4 = r_3 + clearance;  // inner size of the stand tray
r_5 = r_4 + w;  // outer size of the stand tray

d_cc = 2*r + w;  // distance cylinder cylinder

r_cb = max(r*chute_limit_factor, chute_limit_diameter/2);
r_cb_0 = r_cb - clearance;

r_f = funnel_diameter/2;
d_ftb = r_f-r_1;
h_f = d_ftb / tan(90-funnel_angle);

some_distance = max(2*r_5,stand_diameter/2+r_3) + 10;

// fn for differently sized objects, for preview or rendering.
pfa = 40;
pfb = 15;
rfa = 180;
rfb = 30;
function fa() = (preview) ? pfa : rfa;
function fb() = (preview) ? pfb : rfb;


print_part();
// preview_parts();
// stack_parts();


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
   translate([r_4+d_cc+funnel_diameter/2+10, 0, 0])
   {
      funnel();
   }
   translate([0, some_distance, 0])
   {
      stand();
   }
}

module stack_parts()
{
   // intersection()
   {
      color("yellow")
      {
         stand();
      }
      translate([0,0,w+2*ms])
      {
         color("red")
         {
            cup();
         }
      }
      translate([0,0,w+2*ms + r*(h_in_r + 1) + w + ms ])
      {
         color("black")
         {
            funnel();
         }
      }
   }
}



module cup()
{
   difference()
   {
      cup_body();
      cup_hollow();
   }
   translate([d_cc, r_2+w/2,(1+h_in_r)*r])
   {
      cylinder(d=w, h=flange_height+w, $fn=fb());
   }
}


module funnel()
{
   difference()
   {
      funnel_body();
      funnel_hollow();
   }
}


module stand()
{
   difference()
   {
      union()
      {
         stand_base();
         ccc(r_5, stand_height, 0);
      }
      ccc(r_4, stand_height, p+ms);
   }
   translate([d_cc, 0, p])
   {
      cylinder(r=r_cb_0, h=stand_peg_height, $fn=fa());
   }
}

module cup_body()
{
   ccc(r_3, r*(h_in_r+1)+w+flange_height,0);
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
   // funnel flange hollow
   ccc(r_2,flange_height+ms, r*(h_in_r+1)+w);
   translate([0,0,])
   {
      translate([d_cc, -r_5, r*(h_in_r+1)+w])
      {
          cube([2*r_2, 2*r_5, flange_height+ms]);
      }
   }
}


module funnel_body()
{
   cylinder(r=r_1, h=flange_height+clearance+ms, $fn=fa());
   translate([0, 0, flange_height+clearance])
   {
      cylinder(r1=r_1, r2=funnel_diameter/2+w, h=h_f, $fn=fa());
   }
}


module funnel_hollow()
{
   translate([0, 0, -ms])
   {
      cylinder(r=r, h=flange_height+clearance+3*ms, $fn=fa());

      translate([0, 0, flange_height+clearance])
      {
         cylinder(r1=r, r2=funnel_diameter/2, h=h_f+2*ms, $fn=fa());
      }
   }
}

module stand_base()
{
   translate([r+0.5*w, 0, 0])
   {
      cylinder(d=stand_diameter, h=p, $fn=fa());
      translate([0,0,p])
      {
         cylinder(d1=stand_diameter, d2=2*r_5, h=stand_height-w, $fn=fa());
      }
   }

}

module ccc(r_i, h_i, o)
{
   // The cylinder cube cylinder combo used several times
   translate([0,0, o])
   {
      cylinder(r=r_i, h=h_i, $fn=fa());
      translate([d_cc, 0, 0])
      {
         cylinder(r=r_i, h=h_i, $fn=fa());
      }
      translate([0, -r_i, 0])
      {
         cube([d_cc, 2*r_i, h_i]);
      }
   }
}
