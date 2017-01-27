// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// Parametric funnel with stand
//
// © 2017 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0
//

// in cm. The neck is the thin bottom part
neck_diameter = 3;  // [0.3:0.1:8]

// in cm. This is the top part
rim_diameter = 8;  // [3:0.1:15]

// in cm.
neck_length = 4; // [0.3:0.1:8]

// Slope of the main conical part, in °. Beware of printing problems below 45°.
funnel_angle = 60;  // [30:75]

// Cut off angle to give the funnel a sharpened tip. 90° means flat bottom.
neck_tip_angle = 80;  // [45:90]

// Create just the funnel, or a stand to go with it
with_stand = 1; // [0:Just funnel, 1:Funnel and stand]

// in cm. How much the bottom of the funnel will be above ground.
funnel_bottom_height = 10; // [1:0.1:15]


// in mm. Should be a multiple of your nozzle diameter
wall_thickness = 1.6; // [1.2, 1.5, 1.6, 1.8]

module end_customizer()
{
   // This is a dummy module to stop users messing with the values below.
}

r_n = neck_diameter * 5;  // neck radius in mm
r_r = rim_diameter * 5;  // rim radius in mm
l_n = neck_length * 10;  // neck_length in mm
fb_h = funnel_bottom_height * 10;  // funnel bottom height in mm

// shorthand
w = wall_thickness;
fa = funnel_angle;
fa_b = 90 - fa;
ta_b = 90 - neck_tip_angle;
o_ta = 1 * (r_n + w) * tan(ta_b);

// π is still wrong. Even if we use the area of a circle below. Use τ.
tau = 2 * PI;

// The small radius of the support “pencil”., from center to center of face
r_p_s = 3;

// The max. radius (center to edge).  Also the
// width of one pencil face.
r_p_l = r_p_s * 2 / 3 * sqrt(3);

// Handle radius
handle_r = 10;

// Size of the “big pencil” connector. Twice the area, half of it hollow.
r_bp_s = sqrt(2) * r_p_s;
r_bp_l = r_bp_s * 2 / 3 * sqrt(3);

bp_h = 10 * r_p_s;  // Height of the “big pencil” connector
bp_s_h = r_bp_s;
// Height of the sleve at the bottom (as printed) of the “big pencil”
// connector

es_h = 15; // Extra support/stabilizer height
es_w = 0.8;
// Extra support/stabilizer width. Need not be as stable as a normal
// wall

some_distance = 2 * (r_r + w) + 10 * w;

// The actual calls to generate the objects
funnel();
translate([some_distance, 0, 0])
{
   if (with_stand)
   {
      stand();
   }
}

// And the definitions
module funnel()
{

   ch = (r_r - r_n) / tan(fa_b);
   o_rr = w / sin(fa);
   o_nl = w * tan((90-fa_b)/2);
   // Max height. I sort-of designed the funnel the right way up, but want it come out upside down.
   mh = l_n + o_nl + ch;

   // just the rotationl symmetirc part
   module rot_funnel()
   {
      f_poly = [
         [r_n,mh - 0],
         [r_n+w,mh - 0],
         [r_n+w, mh - l_n],
         [r_r + o_rr, mh - (l_n + o_nl + ch)],
         [r_r, mh - (l_n + o_nl + ch)],
         [r_n, mh - (l_n + o_nl)]
         ];
      rotate_extrude()
      {
         polygon(f_poly);
      }

   }

   // The holow core of the funnel, plus a bit of tollerance. Used as
   // difference later.
   module funnel_core()
   {
      c_poly = [
         [0 ,mh - 0],
         [r_n + w/2 ,mh - 0],
         [r_n + w/2, mh - (l_n + o_nl)],
         [r_r + w/2, mh - (l_n + o_nl + ch)],
         [0, mh - (l_n + o_nl + ch)]
         ];
      rotate_extrude()
      {
         polygon(c_poly);
      }

   }

   // The funnel proper
   difference()
   {
      rot_funnel();
      translate([0, 0, mh + 2*r_n-o_ta])
      {
         rotate(a=ta_b,v=[1,1,0])
         {
            cube(size=4*r_n, center=true);
         }
      }
   }

   // The holder lug. The Poly is bigger than needed, and we
   // subtract a bit later.
   lp_poly = [
      [r_p_s,r_r + w - 3*w],
      [r_p_s,r_r + w + r_p_l + 0.5*r_p_s],
      [0,r_r + w + 2*r_p_l],
      [-r_p_s,r_r + w + r_p_l + 0.5*r_p_s],
      [-r_p_s,r_r + w - 3*w],
      ];

   //
   handle_poly = [
      [handle_r,r_r + w - 3*w],
      [handle_r,r_r + w + handle_r],
      [-handle_r,r_r + w + handle_r],
      [-handle_r,r_r + w - 3*w]
      ];


   difference()
   {
      union()
      {
         if (with_stand)
         {
            linear_extrude(w)
            {
               // Holder plate
               polygon(lp_poly);
            }
            // Extra support
            translate([-es_w/2,r_n+w,0])
            {
               cube([es_w,r_r-r_n, es_h]);
            }
            translate([0,r_r+w+r_p_l,0])
            {
               // holder/stand “pencil”
               rotate(30)
               {
                  linear_extrude(mh-bp_h)
                  {
                     circle(r=r_p_l,$fn=6);
                  }
               }
            }
         }
         else
         {
            linear_extrude(w)
            {
               // Holder plate
               polygon(handle_poly);
               translate([0,r_r+w+handle_r,0])
               {
                  circle(handle_r);
               }
            }

         }
      }
      funnel_core();
   }
   if (with_stand)
   {
      translate([0,r_r+w+r_p_l,mh-bp_h])
      {
         rotate(30)
         {
            difference()
            {
               // The main connector  bit
               linear_extrude(bp_h)
               {
                  circle(r=r_bp_l,$fn=6);
               }
               // Hollow it out
               linear_extrude(bp_h)
               {
               circle(r=r_p_l,$fn=6);
               }
            }
         }
      }
      bp_s_f = r_bp_l / r_p_l;
      translate([0,r_r+w+r_p_l,mh-bp_h-bp_s_h])
      {
         rotate(30)
         {
            linear_extrude(bp_s_h, scale=bp_s_f)
            {
               circle(r=r_p_l, $fn=6);
            }
         }
      }
   }
}

module stand()
{
   hex_r = r_r + w + r_p_s;
//   hex_r_l = hex_r_s * 2 / 3 * sqrt(3);
   difference()
   {
      union()
      {
         // Construct the stand ring symmetric to xy plane …
         rotate(30)
         {
            rotate_extrude($fn=6)
            {
               translate([hex_r, 0, 0])
               {
                  circle(r=r_p_l, $fn=6);
               }
            }
         }
      }
      // … and subtract everything below the xy plane.
      translate([0,0,-l_n])
      {
         cylinder(r=1.5*r_r, h=l_n);
      }
   }
   // Fill of the base p
   rotate(30)
   {
      cylinder(r=hex_r, h=es_w, $fn=6);
   }
   translate([0, hex_r, 0])
   {
      // The stand.
      rotate(30)
      {
         linear_extrude(fb_h + bp_h)
         {
            circle(r=r_p_l, $fn=6);
         }
      }
   }
   es_s_p = [
      [0, 0],
      [es_h + r_p_l/2, 0],
      [0, es_h + r_p_l/2]
      ];
   translate([0, hex_r, 0])
   {
      rotate([90, 0, -30])
      {
         linear_extrude(es_w)
         {
            polygon(es_s_p);
         }
      }
      mirror()
      {
         rotate([90, 0, -30])
         {
            linear_extrude(es_w)
            {
               polygon(es_s_p);
            }
         }
      }
   }
}
