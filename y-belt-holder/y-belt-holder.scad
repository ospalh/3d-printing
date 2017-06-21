// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// Y Belt holder for the Průša-style GeeTech i3 pro C
//
// © 2017 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0


// The main dimensions of the printer
belt_bed_d = 23; // Distance the belt should be below the bed.
// When this is off too much, the belt tension varies, which can’t be good.
// Measure from the bed to the bottom of the belt.

hole_hole_y = 9.5;
// Distance between the mounting holes

r_screw_hole = 3/2;  // M3 screws.
// Use two square nuts
nut_t = 1.7;
nut_w = 5.6;
screw_length = 10;

// Dimensions of the belt (apparently GT2)
belt_pitch = 2;
belt_w = 6;
belt_t1 = 0.7;
belt_r = 0.7;


// Dimensions of the holder
truss_r_w = 1.2;  // Width of rectancgular truss members
truss_d_w = 0.8;  // Width of diagonal truss members
belt_bracket_w = 4;  // Width of the side and lower part of the belt brackets.
// They have to be sturdier than the trusses, as they are free hanging
belt_bracket_y = 30; // Length  of one belt bracket




swf = 1.1; // (wiggle factor)
bwf = 1.1; // (wiggle factor)
ms = 0.01; // Muggeseggle

enw = nut_w * swf;
ebt = belt_t1 * bwf;
ebr = belt_r * bwf;

fz = belt_bracket_w + belt_w;
inner_truss_y = hole_hole_y + enw + 2 * nut_t;

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
         cube([inner_truss_y, truss_r_w, fz]);
         translate([0, -belt_bed_d+ebt+ebr+truss_r_w,0])
         {
            cube([inner_truss_y, truss_r_w, fz]);
         }
         translate([0, -belt_bed_d-belt_bracket_w+truss_r_w,0])
         {
            cube([inner_truss_y, truss_r_w, fz]);
         }
      }
      translate([-inner_truss_y/2, -truss_r_w-nut_t, 0])
      {
         cube([inner_truss_y, nut_t, fz]);
         translate([0,-nut_t,0])
         {
            cube([nut_t, nut_t, fz]);
            translate([enw+nut_t, 0, 0])
            {
               cube([nut_t, nut_t, fz]);
            }
            translate([inner_truss_y - enw-2*nut_t, 0, 0])
            {
               cube([nut_t, nut_t, fz]);
            }
            translate([inner_truss_y - nut_t, 0, 0])
            {
               cube([nut_t, nut_t, fz]);
            }
         }
      }
      one_ot(belt_bed_d-ebt-ebr-truss_r_w-2*nut_t, -truss_r_w-2*nut_t);
      mirror()
      {
         one_ot(belt_bed_d-ebt-ebr-truss_r_w-2*nut_t, -truss_r_w-2*nut_t);
      }
      one_ot(
         belt_bracket_w+ebr+ebt-truss_r_w/2, -belt_bed_d+ebt+ebr-truss_r_w/2);
      mirror()
      {
         one_ot(
            belt_bracket_w+ebr+ebt-truss_r_w/2,
            -belt_bed_d+ebt+ebr-truss_r_w/2);
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
               cube([dl,truss_d_w,fz]);
         }
      }
   }
   module screw_hole()
   {
      translate([hole_hole_y/2, ms, belt_bracket_w + belt_w/2])
      {
         rotate([90, 0, 0])
         {
            cylinder(r=r_screw_hole, h=screw_length, $fn=45);
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
   translate([0, -truss_z_a, 0])
   {
      cube([truss_r_w, truss_z_a, fz]);
      translate([belt_bracket_y, 0, 0])
      {
         cube([truss_r_w, truss_z_a, fz]);
      }
   }
   truss_z_m = truss_z_a  - ebt-truss_r_w;
   tdl = sqrt(belt_bracket_y*belt_bracket_y+truss_z_m*truss_z_m);
   tda = atan(truss_z_m/ebby);
   translate([truss_r_w/2, -truss_r_w/2,0])
   {
      rotate(-tda)
      {
         translate([0, -truss_d_w,  0])
         cube([tdl, truss_d_w, fz]);
      }
   }
   translate([truss_r_w/2, -truss_r_w/2-truss_z_m,0])
   {
      rotate(tda)
      {
         translate([0, -truss_d_w,  0])
         cube([tdl, truss_d_w, fz]);
      }
   }
   bt = truss_r_w + ebr + ebt + belt_bracket_w;
   translate([0, -tz, 0])
   {
      difference()
      {
         cube([ebby, bt, fz]);
         translate([truss_r_w, bt-truss_r_w - ebt, belt_bracket_w])
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
