// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// A stand for my (Severin) milk frother.
//
// © 2018–2019 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0

/* [Global] */

// … to preview. You will get all parts as separate STLs when you click “Create Thing”.
part = "s"; // [s: set, a: upper holder, b: base, t: test, st: stack]

// Set this to “render” and click on “Create Thing” when done with the setup.
preview = 1; // [0:render, 1:preview]

/* [Sizes] */

// lower diameter
d_1 = 14;  // [5:0.5:40]

// higher diameter
d_2 = 29;  // [5:0.5:40]

// hight of the holder bar
h = 16;   // [10:0.1:40]

// diameter of the milk frother itself
d_mf = 45; // [30:1:80]

// diameter of the gap for the axle
d_a = 2;  // [1:0.25:4]

// Radius of the not quite conical wall
r_nc = 40; // [30:1:200]

/* [Hidden] */

// Done with the customizer

// *******************************************************
// Extra parameters. These can be changed reasonably safely.


w = 1.8;  // Wall width
p = 1.2;  // Bottom, top plate hight
c = 0.4;  // Clearance
angle = 60; // Overhangs much below 60° are a problem for me

// *******************************************************
// Some shortcuts. These shouldn’t be changed


module kmirror(maxis=[1, 0, 0])
{
   // Keep *and* mirror an object. Standard is left and right mirroring.
   children();
   mirror(maxis)
   {
      children();
   }
}

r_1 = d_1/2;
r_2 = d_2/2;
d_r = r_2-r_1;

r_mf = d_mf/2;
es_h = 12; // Extra support/stabilizer hight


tau = 2 * PI;  // π is still wrong. τ = circumference / r

xy_factor = 1/tan(angle);
// To get from a hight to a horizontal width inclined correctly
z_factor = tan(angle);  // The other way around


wiggle_room_factor = 1.05;

// The small radius of the support pencil, from center to center of face
r_p_s = 3.2 * wiggle_room_factor;
// The flat-to-flat diameter of a standard pencil is 6.4 mm. Do quite a
// bit more.
// The max. radius (center to edge).  Also the
// width of one pencil face.
r_p_l = r_p_s * 2 / 3 * sqrt(3);

// Used to calculate how heigh the lug that holds the handle is

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

sp_h = 4 * r_p_s;  // Hight of the sharpend pencil cylindrical connector bit
usp_h = 10 * r_p_s;  // Hight of the unsharpend pencil connector bit

// hex_r = r_mf + r_bp_l;
r_red = r_mf - r_bp_l;

bp_s_h = r_bp_s / tan(tip_a/2);


some_distance = 50;
ms = 0.01;  // Muggeseggele.

// fn for differently sized objects and fs, fa; all for preview or rendering.
pna = 40;
pnb = 15;
pa = 5;
ps = 1;
rna = 180;
rnb = 30;
ra = 2;
rs = 0.25;
function na() = (preview) ? pna : rna;
function nb() = (preview) ? pnb : rnb;
$fs = (preview) ? ps : rs;
$fa = (preview) ? pa : ra;

// *******************************************************
// End setup



// *******************************************************
// Generate the parts

print_part();


if ("s" == part)
{
   preview_parts();
}


if ("t" == part)
{
   2d_holder_shape(0);
   // holder_support();
}

if ("st" == part)
{
   // Use "st" during development
   stack_parts();
}

module print_part()
{
   if ("a" == part)
   {
      upholder();
   }
   if ("b" == part)
   {
      base();
   }
}

module preview_parts()
{
   upholder();
   translate([some_distance, 0, 0])
   {
      base();
   }
}

module stack_parts()
{
   // intersection()
   {
      translate([0,0,30])
      {
         color("yellow")
         {
            upholder();
         }
      }
      color("red")
      {
         base();
      }
   }
}

// *******************************************************
// Code for the parts themselves


module base()
{
   difference()
   {
      union()
      {
         // Construct the stand ring symmetric to xy plane …
         rotate(30)
         {
            rotate_extrude($fn=6)
            {
               translate([r_mf, 0, 0])
               {
                  circle(r=r_p_l, $fn=6);
               }
            }
         }
      }
      // … and subtract everything below the xy plane.
      translate([0,0,-some_distance-ms])
      {
         cylinder(r=some_distance, h=some_distance);
      }
   }
   // Fill the base plate
   rotate(30)
   {
      cylinder(r=r_mf, h=p, $fn=6);
   }
   translate([0,0,2*ms])
   {
      kmirror([0,1,0])
      {
         translate([0, r_mf, 0])
         {

            rotate(30)
            {
               difference()
               {
                  union()
                  {
                     cylinder(h=p+h, r=r_p_l, $fn=6);
                     translate([0,0,p])
                     {
                        cylinder(h=bp_s_h, r1=r_p_l, r2=r_bp_l,$fn=6);
                     }
                     // The shaft bit
                     translate([0, 0 , bp_s_h+p+-ms])
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
                  translate([0,0,p])
                  {
                     cylinder(h=bp_s_h, r1=ms, r2=r_p_l, $fn=6);
                  }
                  translate([0, 0 , bp_s_h+p])
                  {
                     cylinder(h=sp_h+1,r=r_p_l, $fn=6);
                  }
               }
            }
         }
      }
   }
}

module base_holder()
{
   translate([0, r_mf, 0])
   {

      rotate(30)
      {
         difference()
         {
            union()
            {
               cylinder(h=bp_s_h, r1=r_p_l, r2=r_bp_l,$fn=6);
               // The shaft bit
               translate([0, 0 , bp_s_h-ms])
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
            cylinder(h=bp_s_h, r1=0, r2=r_p_l, $fn=6);
            translate([0, 0 , bp_s_h])
            {
               cylinder(h=sp_h+1,r=r_p_l, $fn=6);
            }

         }
      }
   }

}

module extra_plate()
{
   es_s_p = [
      [0, 0],
      [es_h + r_p_l/2-ms, 0],
      [0, es_h + r_p_l/2-ms]
      ];
   rotate([90, 0, 0])
   {
      translate([r_p_s, 0.5*r_p_l, 0])
      {
         linear_extrude(p)
         {
            polygon(es_s_p);
         }
      }
   }
}


module upholder()
{
   difference()
   {
      union()
      {
         filled_holder();
         holder_arm();
      }
      holder_hollow();
   }
}

module filled_holder()
{
   holder_base_shape(w);
}

module holder_arm()
{
   kmirror([0,1,0])
   {
      holder_support();
   }
}

module holder_support()
{
   bp_s_f = (r_bp_l) / r_p_l;
   translate([0,r_mf, 0])
   {
      rotate(30)
      {
         difference()
         {
            cylinder(h=h, r=r_bp_l, $fn=6);
            // Hollow it out
            translate([0,0, -ms])
            {
               cylinder(h=h-3*p, r=r_p_l, $fn=6);
            }
         }
      }
   }
   translate([-w/2, 0, 0])
   {
      cube([w,r_red+w,h]);
   }
}

module holder_hollow()
{
   translate([0,0,-ms])
   {
      holder_base_shape(0);
      // cylinder(r1=r_1, r2=R_2, h=h+2*ms);
      translate([0, -d_a/2,0])
      {
         cube([d_2, d_a, h+2*ms]);
      }
   }

}


module holder_base_shape(ew)
{
   rotate_extrude(convexity=6)
   {
      2d_holder_shape(ew);
   }
}


module 2d_holder_shape(ew)
{
   // We cheat a bit. We ignore some angles and and stuff
   sfere_a = asin(d_r/h);
   echo("sfere_a", sfere_a);
   intersection()
   {
      square([2*r_2,h+2*ms-0.01*ew]);
      translate([r_2+ew,h/2])
      {
         rotate(-sfere_a)
         {
            translate([-r_nc,0])
            {
               circle(r=r_nc);
            }
         }
      }
   }

   // cylinder(r1=d_1/2+ew, r2=d_2/2+ew, h=h);
}
