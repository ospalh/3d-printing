// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// Y Belt holder for the Průša-style GeeTech i3 pro C
//
// © 2017 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0


// The main dimensions of the printer
belt_bed_d = 24.5; // Distance the belt should be below the bed.
// When this is off too much, the belt tension varies, which can’t be good.
// Measure from the bed to the bottom of the belt.

hole_hole_y = 9.5;
// Distance between the mounting holes

d_screw = 3;  // M3 screws.
d_washer = 5.3;
// Use two square nuts
nut_t = 1.7;
nut_w = 5.6;
// screw_length = 10;


// Dimensions of the belt (apparently GT2)
belt_pitch = 2;
/* belt_w = 6; */
belt_w = 6;
belt_t1 = 0.7;
belt_r = 0.7;


// Dimensions of the holder
truss_r_w = 1.2;  // Width of rectancgular truss members
truss_d_w = 0.8;  // Width of diagonal truss members
belt_bracket_w = 4;  // Width of the side and lower part of the belt brackets.
// They have to be sturdier than the trusses, as they are free hanging
belt_bracket_y = 30; // Length  of one belt bracket

extra_z = 4; // for the screw holes


swf = 1.05; // (wiggle factor)
bwf = 1.10; // (wiggle factor)
ms = 0.01; // Muggeseggle

enw = nut_w * swf;
ebt = belt_t1 * bwf;
ebr = belt_r * bwf;

fz = belt_bracket_w + belt_w;
fzc = fz + extra_z;
inner_truss_y = hole_hole_y + enw + 2 * nut_t;

r_sh = d_screw/2 * swf;
r_waho = d_washer/2 * swf;

y_0 = 0; // Datum


belt_holder();
// nut_holder();


module belt_holder()
{
// Create the actual shapes
   translate([inner_truss_y/2, 0, 0])
   {
      one_bracket();
   }
   mirror()
   {
      translate([inner_truss_y/2, 0, 0])
      {
         one_bracket();
      }
   }
   center_bracket();
}

module nut_holder()
{

}

module center_bracket()
{
   difference()
   {
      p_center_bracket();
      screw_hole();
      mirror()
      {
         screw_hole();
      }
   }
   module p_center_bracket()
   {
      translate([-inner_truss_y/2, -truss_r_w, 0])
      {
         cube([inner_truss_y, truss_r_w, fzc]);
         translate([0, -belt_bed_d+ebt+ebr+belt_bracket_w,0])
         {
            cube([inner_truss_y, truss_r_w, fzc]);
         }
         translate([0, -belt_bed_d-belt_bracket_w+truss_r_w,0])
         {
            cube([inner_truss_y, truss_r_w, fzc]);
         }
      }
      translate([-inner_truss_y/2, -truss_r_w-nut_t, 0])
      {
         cube([inner_truss_y, nut_t, fzc]);
      }
      one_ot(belt_bed_d-ebt-ebr-belt_bracket_w-nut_t-0.5*truss_r_w, -1.5*truss_r_w-nut_t);
      mirror()
      {
         one_ot(belt_bed_d-ebt-ebr-belt_bracket_w-nut_t-0.5*truss_r_w, -1.5*truss_r_w-nut_t);
      }
      one_ot(
         2*belt_bracket_w+ebr+ebt-1.5*truss_r_w,
         -belt_bed_d+ebt+ebr+belt_bracket_w-1.5*truss_r_w);
      mirror()
      {
         one_ot(
            2*belt_bracket_w+ebr+ebt-1.5*truss_r_w,
            -belt_bed_d+ebt+ebr+belt_bracket_w-1.5*truss_r_w);
      }
   }
   module one_ot(zl, oz)
   {
      translate([-inner_truss_y/2, oz,0])
      {
         yl = inner_truss_y+truss_d_w;
         dl = sqrt(yl*yl+zl*zl);
         da = atan(zl/yl);
         translate([-sqrt(0.5)*truss_d_w, sqrt(0.5)*truss_d_w, 0])
         {
            rotate(-da)
               cube([dl,truss_d_w,fzc]);
         }
      }
   }
   module screw_hole()
   {
      translate([hole_hole_y/2, ms, belt_bracket_w + belt_w/2])
      {
         rotate([90, 0, 0])
         {
            cylinder(r=r_sh, h=truss_r_w+nut_t+2*ms, $fn=45);
         }
      }
      translate([hole_hole_y/2, -truss_r_w-nut_t-0.5, belt_bracket_w + belt_w/2])
      {
         rotate([90, 0, 0])
         {
            cylinder(r=r_waho, h=belt_bed_d+belt_bracket_w+ms, $fn=45);
         }
      }
   }
}

module one_bracket()
{
   ebby = belt_bracket_y + truss_r_w;
   translate([0, -truss_r_w, 0])
   {
      cube([ebby, truss_r_w, fz]);
   }
   tz = belt_bed_d + belt_bracket_w;
   truss_z_a = belt_bed_d - ebr -ebt;
   translate([0, -belt_bed_d-belt_bracket_w,0])
   {
      cube([truss_r_w+ms, belt_bed_d+belt_bracket_w, fzc]);
   }

   translate([0, -truss_z_a, 0])
   {
      translate([belt_bracket_y, 0, 0])
      {
         cube([truss_r_w, truss_z_a, fz]);
      }
   }
   truss_y = belt_bracket_y-truss_r_w;
   truss_z_m = truss_z_a  - ebt-belt_bracket_w -truss_r_w/2;
   tdl = sqrt(belt_bracket_y*belt_bracket_y+truss_z_m*truss_z_m);
   tda = atan(truss_z_m/truss_y);
   one_truss();
   translate([belt_bracket_y+truss_r_w, 0, 0])
   {
      mirror()
      {
         one_truss();
      }
   }
   module one_truss()
   {
      translate([truss_r_w, -truss_r_w/2,0])
      {
         rotate(-tda)
         {
            translate([0, -truss_d_w,  0])
            {
               cube([tdl, truss_d_w, fz]);
            }
         }
      }
   }
   bt =  ebr + ebt + 2*belt_bracket_w;
   translate([0, -tz, 0])
   {
      difference()
      {
         cube([ebby, bt, fz]);
         translate([truss_r_w, bt-belt_bracket_w - ebt,belt_bracket_w])
         {
            n_belt();
         }
      }
   }
   // bz = belt_bed_d - ebt;
   module n_belt()
   {
      cube([belt_bracket_y+ms, ebt, belt_w+ms]);
      translate([ebr, 0,0])
      {
         for (o=[0:belt_pitch:belt_bracket_y])
         {
            translate([o, 0, 0])
            {
               cylinder(r=ebr, h=belt_w+ms, $fn=45);
            }
         }
      }
   }
}
