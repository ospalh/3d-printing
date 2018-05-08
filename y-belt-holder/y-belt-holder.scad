// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// Y Belt holder for the Průša-style GeeTech i3 pro C
//
// © 2017–18 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0

// … to preview. You will get all parts when you click “Create Thing”.
part = "holder"; // [holder: the y belt holder, square: square nut holder, hex: hex nut holder, test: test shape for sizing the belt]

// Set this to “render” and click on “Create Thing” when done with the setup.
preview = 1; // [0:render, 1:preview]


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

h_nut_t = 2.3;
h_nut_d = 5.4;
h_nut_r =  h_nut_d/sqrt(3);


// Dimensions of the belt (apparently GT2)
belt_pitch = 2;
belt_w = 6;
belt_t1 = 1.05;
belt_r = 0.7;


// Dimensions of the holder
truss_r_w = 1.2;  // Width of rectancgular truss members
truss_d_w = 0.8;  // Width of diagonal truss members
belt_bracket_w = 4;  // Width of the side and lower part of the belt brackets.
// They have to be sturdier than the trusses, as they are free hanging
belt_bracket_y = 30; // Length  of one belt bracket

extra_z = 4; // for the screw holes


swf = 1.05; // (wiggle factor)
bwf = 1.02; // (wiggle factor)
ms = 0.01; // Muggeseggle

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


enw = nut_w * swf;
ebt = belt_t1 * bwf;
ebr = belt_r * bwf;

fz = belt_bracket_w + belt_w;
fzc = fz + extra_z;
inner_truss_y = hole_hole_y + enw + 2 * nut_t;

r_sh = d_screw/2 * swf;
r_waho = d_washer/2 * swf;

y_0 = 0; // Datum

some_distance_x =  belt_bracket_y/2;
some_distance_y =  belt_bed_d/2;



print_part();
// preview_parts();



module print_part()
{
   if ("holder" == part)
   {
      belt_holder();
   }
   if ("square" == part)
   {
      square_nut_holder();
   }
   if ("hex" == part)
   {
      hex_nut_holder();
   }
   if ("test" == part)
   {
      belt_test_shape();
   }
}

module preview_parts()
{
   belt_holder();
   translate([0, some_distance_y, 0])
   {
      translate([-some_distance_x, 0, 0])
      {
         square_nut_holder();
      }
      translate([some_distance_x, 0, 0])
      {
         hex_nut_holder();
      }
   }
   translate([0, 2*some_distance_y, 0])
   {
      belt_test_shape();
   }
}





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

module square_nut_holder()
{
   difference()
   {
      translate([0,0,(truss_r_w+nut_t)/2])
      {
         cube(
            [hole_hole_y+nut_w+2*truss_r_w, nut_w+2*truss_r_w, (truss_r_w+nut_t)],
            center=true);

      }

      holes();
      mirror()
      {
         holes();
      }
   }
   module holes()
   {
      translate([hole_hole_y/2, 0, 0])
      {
         translate([0,0,-ms])
         {
            cylinder(r=r_sh, h=truss_r_w+nut_t+2*ms);
         }
         translate([0,0,truss_r_w+nut_t/2+ms])
         {
            cube([nut_w, nut_w, nut_t+ms], center=true);
         }
      }
   }
// nut_t = 1.7;
// nut_w = 5.6;
// hole_hole_y = 9.5;
}


module hex_nut_holder()
{
   difference()
   {
      translate([0,0,(truss_r_w+h_nut_t)/2])
      {
         cube(
            [hole_hole_y+h_nut_d+2*truss_r_w, nut_w+2*truss_r_w, (truss_r_w+nut_t)],
            center=true);

      }

      holes();
      mirror()
      {
         holes();
      }
   }
   module holes()
   {
      translate([hole_hole_y/2, 0, 0])
      {
         translate([0,0,-ms])
         {
            cylinder(r=r_sh, h=truss_r_w+h_nut_t+2*ms);
         }
         translate([0,0,truss_r_w])
         {
            cylinder(r=h_nut_r, h=h_nut_t+ms, $fn=6);
         }
      }
   }
// nut_t = 1.7;
// nut_w = 5.6;
// hole_hole_y = 9.5;
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
            cylinder(r=r_sh, h=truss_r_w+nut_t+2*ms);
         }
      }
      translate([hole_hole_y/2, -truss_r_w-nut_t-0.5, belt_bracket_w + belt_w/2])
      {
         rotate([90, 0, 0])
         {
            cylinder(r=r_waho, h=belt_bed_d+belt_bracket_w+ms);
         }
      }
   }
}

ebby = belt_bracket_y + truss_r_w;
tz = belt_bed_d + belt_bracket_w;
truss_z_a = belt_bed_d - ebr -ebt;
truss_y = belt_bracket_y-truss_r_w;
truss_z_m = truss_z_a  - ebt-belt_bracket_w -truss_r_w/2;
tdl = sqrt(belt_bracket_y*belt_bracket_y+truss_z_m*truss_z_m);
tda = atan(truss_z_m/truss_y);
bt =  ebr + ebt + 2*belt_bracket_w;

module one_bracket()
{

   translate([0, -truss_r_w, 0])
   {
      cube([ebby, truss_r_w, fz]);
   }
   translate([0, -belt_bed_d-belt_bracket_w,0])
   {
      cube([truss_r_w+ms, belt_bed_d+belt_bracket_w, fzc]);
   }

   translate([0, -truss_z_a, 0])
   {
      translate([belt_bracket_y, ms, 0])
      {
         cube([truss_r_w, truss_z_a-ms, fz]);
      }
   }
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
   translate([0, -tz, 0])
   {
      difference()
      {
         cube([ebby, bt, fz]);
         translate([truss_r_w+ms, bt-belt_bracket_w - ebt,belt_bracket_w])
         {
            n_belt();
         }
      }
   }
   // bz = belt_bed_d - ebt;

}


module n_belt()
{
   cube([belt_bracket_y+ms, ebt, belt_w+ms]);
   translate([ebr, 0,0])
   {
      for (o=[0:belt_pitch:belt_bracket_y])
      {
         translate([o, 0, 0])
         {
            cylinder(r=ebr, h=belt_w+ms);
         }
      }
   }
}

module belt_test_shape()
{
   difference()
   {
      cube([ebby-belt_pitch, bt, fz]);
      translate([truss_r_w-belt_pitch, bt-belt_bracket_w - ebt,belt_bracket_w])
      {
         n_belt();
      }
   }
}
