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

// in cm. How much the bottom of the funnel will be above ground.
funnel_bottom_height = 10; // [1:0.1:15]

// Slope of the main conical part, in °. Beware of printing problems below 45°.
funnel_angle = 60;  // [30:75]

// Cut off angle to give the funnel a sharpend tip. 90° means flat bottom.
neck_tip_angle = 80;  // [45:90]

// in mm. Should be a multiple of your nozzle diameter
wall_thickness = 1.6; // [1.2, 1.5, 1.6, 1.8]

module end_customizer()
{
   // This is a dummy module to stop users messing with the values below.
}

r_n = neck_diameter * 5;  // neck radius in mm
r_r = rim_diameter * 5;  // rim radius in mm
l_n = neck_length * 10;  // neck_length in mm

// shorthand
w = wall_thickness;
fa = funnel_angle;
fa_b = 90 - fa;
ta_b = 90 - neck_tip_angle;
o_ta = 1 * (r_n + w) * tan(ta_b);

// π is still wrong. Even if we use the area of a circle below. Use τ.
tau = 2 * PI;

// The small radius, from center to center of face
r_p_s = 3;
// The max. radius (center to edge) of the support “pencil”. Also the
// width of one pencil face.
r_p_l = r_p_s * 2 / 3 * sqrt(3);

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

// The actual calls to generate the objects
funnel();


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
      [r_p_l,r_r + w - 3*w],
      [r_p_l,r_r + w + r_p_s],
      [r_p_l/2,r_r + w + 2*r_p_s],
      [-r_p_l/2,r_r + w + 2*r_p_s],
      [-r_p_l,r_r + w + r_p_s],
      [-r_p_l,r_r + w - 3*w],
      ];



   difference()
   {
      union()
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
         translate([0,r_r+w+r_p_s,0])
         {
            // holder/stand “pencil”
            linear_extrude(mh-bp_h)
            {
               circle(r=r_p_l,$fn=6);
            }
         }
      }
      funnel_core();
   }

   translate([0,r_r+w+r_p_s,mh-bp_h])
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
   bp_s_f = r_bp_l / r_p_l;
   translate([0,r_r+w+r_p_s,mh-bp_h-bp_s_h])
   {
      linear_extrude(bp_s_h, scale=bp_s_f)
      {
         circle(r=r_p_l, $fn=6);
      }
   }

}
