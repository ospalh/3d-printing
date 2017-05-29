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
rim_diameter = 9;  // [3:0.1:15]

// in cm.
neck_length = 5; // [0.3:0.1:8]

// Slope of the main conical part, in °. Beware of printing problems below 45°.
funnel_angle = 60;  // [30:75]

// Cut off angle to give the funnel a sharpened tip. 90° means flat bottom.
neck_tip_angle = 65;  // [45:90]

// Create just the funnel, or a stand to go with it, with one or three supports
stand_style = 1;  // [0:Just funnel, 1:Funnel and simple stand, 3:Funnel and tripod stand]

// Height added  to the stand, in cm. The height of the top of the funnel will be the length of your pencil plus this.
extra_height = 1; // [1:15]


module end_customizer()
{
   // This is a dummy module to stop users messing with the values below.
}

r_n = neck_diameter * 5;  // neck radius in mm
r_r = rim_diameter * 5;  // rim radius in mm
l_n = neck_length * 10;  // neck_length in mm
heh = extra_height * 5; // Half the extra height, in mm

w = 1.6;
// Wall thickness. Should be a multiple of your nozzle diameter. 1.2 may
// be enough.


fua = funnel_angle;
fua_b = 90 - fua;
ta_b = 90 - neck_tip_angle;
o_ta = 1 * (r_n + w) * tan(ta_b);


// Uncomment these when running OpenSCAD at home for a smoother
// (ronuder) funnel.
$fa= 1;
$fs=0.1;

wiggle_room_factor = 1.1;

// The small radius of the support pencil, from center to center of face
r_p_s = 3.4 * wiggle_room_factor;
// The flat-to-flat diameter of a standard pencil is 6.8 mm. Do quite a
// bit more.
// The max. radius (center to edge).  Also the
// width of one pencil face.
r_p_l = r_p_s * 2 / 3 * sqrt(3);


// Handle radius
handle_r = 10;

// Tip angle
tip_a = 21;  // °. Apparently standard in Germany
// tip_a = 19;  // °. There is a German »Long Point« pencil sharpnener with 19 °.
// There are also rumors that American pencil are pointier than German ones.
// tip_a = 24 // °. Special color pencil sharpener.

// The tip angle is apparently from one side to the other side, not from
// one side to the center line.


// Size of the “big pencil” connector. Twice the area, half of it hollow.
r_bp_s = sqrt(2) * r_p_s;
r_bp_l = r_bp_s * 2 / 3 * sqrt(3);

sp_h = 8 * r_p_s;  // Height of the sharpend pencil cylindrical connector bit
usp_h = 10 * r_p_s;  // Height of the unsharpend pencil connector bit


bp_s_h = r_bp_s / tan(tip_a/2);

// Height of the sleve at the bottom (as printed) of the “big pencil”
// connector. The length of a pencil tip. (The angle of the outer wall
// should come out slightly below tip_a, as the walls get thinner. We
// (try to) maintain cross section area, not wall strength.)
// Here we need the angle from one side to the center line.

es_h = 15; // Extra support/stabilizer height
es_w = 0.8;
// Extra support/stabilizer width. Need not be as stable as a normal
// wall
strake_r = es_w/2;

some_distance = 2 * (r_r + w) + 13 * w;

// The actual calls to generate the objects
funnel();
translate([some_distance, 0, 0])
{
   if (stand_style > 0)
   {
      stand();
   }
}

// Demo: place stand over funnel
if (false)
{
   rotate([0,180,0])
   {
      translate([0, 0, -3*l_n])
      {
         stand();
      }
   }
}

// And the definitions
module funnel()
{

   ch = (r_r - r_n) / tan(fua_b);
   o_rr = w / sin(fua);
   o_nl = w * tan((90-fua_b)/2);
   // Max height. I sort-of designed the funnel the right way up, but
   // want it come out upside down.
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

   module funnel_neck_cutoff()
   {
      // The bit that creates the slant an the neck
      translate([0, 0, mh + 6*r_n-o_ta])
      {
         rotate(a=ta_b,v=[1,1,0])
         {
            cube(size=12*r_n, center=true);
         }
      }
   }

   module funnel_support()
   {

      // The holder lug. The Poly is bigger than needed, and we
      // subtract a bit later.
      lp_poly = [
         [r_bp_s,r_r + w - 3*w],
         [r_bp_s,r_r + w + 1.5 * r_bp_l],
         [0,r_r + w + 2*r_bp_l],
         [-r_bp_s,r_r + w + 1.5 * r_bp_l],
         [-r_bp_s,r_r + w - 3*w],
         ];
      linear_extrude(w)
      {
         // Holder plate
         polygon(lp_poly);
      }
      // Extra support
      translate([-es_w/2,r_n+w+0.5*(r_bp_l-r_p_l),0])
      {
         cube([es_w,r_r-r_n, es_h]);
      }
      bp_s_f = (r_bp_l) / r_p_l;
      translate([0,r_r+w+r_bp_l, w])
      {
         rotate(30)
         {
            difference()
            {
               cylinder(h=usp_h+heh, r=r_bp_l, $fn=6);
               // Hollow it out
               translate([0,0, heh])
               {
                  cylinder(h=usp_h+1,r=r_p_l, $fn=6);
               }
            }
         }
      }

   }

   module funnel_grip()
   {
      handle_poly = [
         [handle_r,r_r + w - 3*w],
         [handle_r,r_r + w + handle_r],
         [-handle_r,r_r + w + handle_r],
         [-handle_r,r_r + w - 3*w]
         ];

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

   module funnel_strake()
   {

      translate([0, r_n+w, mh-l_n])
      {
         cylinder(r=strake_r, h=l_n);
      }
      rotate(30)
      {
         translate([-(r_r+w), 0, 0])
         {
            rotate([0,90-funnel_angle,0])
            {
               translate([0,0,w])
               {
                  // It’s possibly a rounding error, but with
                  // r=strake_r here it doesn’t perfectly
                  // align with the funnel. Use a bit more.
                  cylinder(r=es_w, h=(r_r - r_n) / cos(funnel_angle));
               }
            }
         }
      }

   }

   // The funnel proper
   difference()
   {
      rot_funnel();
      funnel_neck_cutoff();
   }

   //
   difference()
   {
      union()
      {
         if (stand_style > 0)
         {
            for (sr=[0:120:(stand_style-1)*120])
            {
               rotate(sr)
               {
                  funnel_support();
               }
            }
         }
         else
         {
            funnel_grip();
            for (i=[60, 180, 300])
            {
               rotate(i)
               {
                  funnel_strake();
               }
            }

         }
      }
      funnel_core();
      funnel_neck_cutoff();
   }
}


module stand()
{
   // hex_r = r_r + w + r_p_s;
   hex_r = r_r+ w + r_bp_l;
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
   // Fill the base plate
   rotate(30)
   {
      cylinder(r=hex_r, h=es_w, $fn=6);
   }
   for (sr=[0:120:(stand_style-1)*120])
   {
      rotate(sr)
      {
         translate([0, hex_r, 0])
         {
            // The stand.

            rotate(30)
            {
               difference()
               {
                  union()
                  {
                     // Three segments of linear extrusion
                     // The extra
                     cylinder(h=heh, r=r_p_l,$fn=6);
                     // The sharpend bit
                     translate([0, 0 , heh])
                     {
                        cylinder(h=bp_s_h, r1=r_p_l, r2=r_bp_l,$fn=6);
                     }
                     // The shaft bit
                     translate([0, 0 , bp_s_h+heh])
                     {
                        cylinder(h=sp_h, r=r_bp_l, $fn=6);
                     }
                     // The extra plates. Should not interfere with the stand
                     // without this. Anyway.
                     rotate(-60)
                     {
                        extra_plate();
                     }
                     rotate(180)
                     {
                        extra_plate();
                     }
                  }
                  // Hollow it out
                  translate([0, 0 , heh])
                  {
                     cylinder(h=bp_s_h, r1=0, r2=r_p_l, $fn=6);
                  }
                  translate([0, 0 , bp_s_h+heh])
                  {
                     cylinder(h=sp_h+1,r=r_p_l, $fn=6);
                  }

               }
            }
         }

      }
   }

   module extra_plate()
   {
      es_s_p = [
         [0, 0],
         [es_h + r_p_l/2, 0],
         [0, es_h + r_p_l/2]
         ];
      rotate([90, 0, 0])
      {
         translate([r_p_l, 0.5*r_p_l, 0])
         {
            linear_extrude(es_w)
            {
               polygon(es_s_p);
            }
         }
      }
   }
}
