// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// shower gel shelf
//
// © 2018 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0


// … to preview. You will get all parts when you click “Create Thing”.
part = "tray"; // [tray: shower tray, fastener: mushroom head fastener, big fastener: big mushroom head fastener]


// Set this to “render” and click on “Create Thing” when done with the setup.
preview = 1; // [0:render, 1:preview]

r_main = 155;  // main radius of the tray
r_corner = 10;  // space for silicone joint


/* [Hidden] */

// Done with the customizer

w = 2.1;  // external wall width
p_1 = 0.6;  // height of the bottomt plate with the cylindrical holes
p_2 = 1.2;  // height of the bottomt plate with the conical shapes
p_3 = 1.8;  // height of the bottomt plate with the conical shapes
x_step = 14.1;  // hole to hole distance
r_hole = 1.5;  // drain holes

w_f = 20;  // width of the fastener
l_f = 40;  // its length
w_bf = 41; // big fastener
l_bf = 60;  //

h=22; // Height (inner)
r_slot = 3.5;
r_keyhole = 5.0;
l_fs = 3;
r_ff = 1.8;  // fastener (bottom) fillet radius

f_cs = 3;  // clearance for the third fastener

// *******************************************************
// Some shortcuts. These shouldn’t be changed

tau = 2 * PI;  // π is still wrong. τ = circumference ÷ r
angle = 35; // Overhangs much below 60° are a problem for me
xy_factor = 1/tan(angle);  // To get from a height to a horizontal width
                           // inclined correctly
z_factor = tan(angle);  // the other way around

p = p_1 + p_2;
h_msh = p_3+r_ff+l_fs+z_factor*(r_keyhole-r_slot)+p_3;
thf = sqrt(3)/2;  // (equilateral) triangle height factor
y_step = x_step * thf;

some_distance = 1.2 * r_main;
ms = 0.01;  // Muggeseggele.
cs = 0.2;

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


// *******************************************************
// End setup



// *******************************************************
// Generate the parts

print_part();
// preview_parts();
// stack_parts();

module print_part()
{
   if ("tray" == part)
   {
      tray();
   }
   if ("fastener" == part)
   {
      fastener();
   }
   if ("big fastener" == part)
   {
      big_fastener();
   }
}

module preview_parts()
{
   tray();
   translate([some_distance, 0, 0])
   {
      fastener();
   }
   translate([some_distance, 2*w_bf, 0])
   {
      big_fastener();
   }
}

module stack_parts()
{
   //  intersection()
   {
      color("yellow")
      {
         tray();
      }
      union()
      {
         moved_fastener(w_f, l_f);
         translate([-r_main+4.5*r_keyhole+r_corner, 0, 0])
         {
            moved_fastener(w_f, l_f);
         }
         mirror([1,-1,0])
         {
            moved_fastener(w_bf, l_bf);
         }
      }

   }
}


// *******************************************************
// Code for the parts themselves

module tray()
{
   difference()
   {
      union()
      {
         plate();
         railing();
      }
      keyholes();
   }
}


module railing()
{
   round_railing(r_main);
   round_railing(r_corner+w);
   translate([0, r_corner, 0])
   {
      cube([w, r_main-r_corner, h+p]);
   }
   translate([r_corner, 0, 0])
   {
      cube([r_main-r_corner, w, h+p]);
   }

}



module round_railing(r)
{
   intersection()
   {
      difference()
      {
         cylinder(r=r, h=h+p);
         translate([0,0,-ms])
         {
            cylinder(r=r-w, h=h+p+2*ms);
         }
      }
      translate([0,0,-2*ms])
      {
          cube(r_main, r_main, h+p+4*ms);
      }
   }
}


module plate()
{
   intersection()
   {
      plate_quarter_circle();
      plate_square();
   }
}

module plate_quarter_circle()
{
   difference()
   {
      intersection()
      {
         translate([0,0,-2*ms])
         {
            cube([r_main, r_main, p+4*ms]);
         }
         translate([0,0,-ms])
         {
            cylinder(r=r_main, p+2*ms);
         }
      }
      translate([0,0,-2*ms])
      {
         cylinder(r=r_corner, h=p+4*ms);
      }

   }
}

module plate_square()
{
   p_xy = r_main+2*x_step+2*ms;
   difference()
   {
      translate([-x_step, -x_step, 0])
      {
         cube([p_xy, p_xy, p]);
      }
      rotate(45)
      {
         plate_holes();
      }
   }
}

module plate_holes()
{
   p_xy = r_main+2*x_step+2*ms;
   x_count = ceil(p_xy/x_step);
   y_count = ceil(p_xy/y_step);

   // Partly cut-and-pasted from my tight bottle tray
   for (y_c = [-y_count:y_count])
   {
      if (y_c%2==0)
      {
         // Even, long row
         for (x_c = [-x_count+1:x_count-1])
         {
            a_plate_hole(x_c*x_step, y_c*y_step);
         }
      }
      else
      {
         // Odd, short row
         for (x_c = [-x_count+2:x_count-2])
         {
            a_plate_hole((x_c+0.5)*x_step, y_c*y_step);
         }
      }
   }
}


module a_plate_hole(dx, dy)
{
   translate([dx, dy, -ms])
   {
      rotate(30)
      {
         cylinder(r=r_hole, h=p+2*ms, $fn=6);  // Or h=p_1+2*ms
         translate([0, 0, p_1])
         {
            cylinder(r1=r_hole-ms, r2=y_step/sqrt(2)-0.8*w, h=p_2+2*ms, $fn=6);
            // The sqrt(2) is … experimental math.
         }
      }
   }

}


module keyholes()
{
   keyhole(false);
   translate([-r_main+4.5*r_keyhole+r_corner, 0, 0])
   {
      keyhole(false);
   }
   mirror([1,-1,0])
   {
      keyhole(true);
   }

}

module keyhole(bc)
{
   translate([r_main-2*r_keyhole,w,p_1+p_2+1.05*r_keyhole])
   {
      rotate([90,0,0])
      {
         simple_keyhole();
         if (bc)
         {
            echo("hey");
            keyhole_bottom_cut();
         }
      }
   }
}

module simple_keyhole()
{
   translate([0,0,-ms])
   {
      cylinder(r=r_keyhole, h=w+2*ms);
      translate([-r_slot,0,0])
      {
         cube([2*r_slot, 1.5*r_keyhole, w+2*ms]);
      }
      translate([0,1.5*r_keyhole,0])
      {
         cylinder(r=r_slot, h=w+2*ms);
      }
   }
}

module keyhole_bottom_cut()
{
   translate([0,0,-h_msh-f_cs-ms])
   {
      translate([-r_keyhole,-h,0])
      {
         cube([2*r_keyhole, h,h_msh+f_cs+w+2*ms]);
      }
   }

}


module moved_fastener(ww, ll)
{

   translate([r_main-2*r_keyhole,-w,p_1+p_2+2.25*r_keyhole])
   {
      rotate([90,0,180])
      {
         fastener(ww, ll);
      }
   }
}

module fastener()
{
   generic_fastener(w_f, l_f);
}

module big_fastener()
{
   generic_fastener(w_bf, l_bf);
}

module generic_fastener(ww, ll)
{
   translate([-ww/2, -ww/2, 0])
   {
      cube([ww, ll, p_3]);
   }
   translate([-ww/2+r_ff, -ww/2+r_ff, p_3])
   {
      sphere(r=r_ff);
      rotate([0,90,0])
      {
         cylinder(r=r_ff, h=ww-2*r_ff);
      }
      rotate([-90,0,0])
      {
         cylinder(r=r_ff, h=ll-2*r_ff);
      }
   }
   translate([-ww/2+r_ff, -ww/2-r_ff+ll, p_3])
   {
      sphere(r=r_ff);
      rotate([0,90,0])
      {
         cylinder(r=r_ff, h=ww-2*r_ff);
      }
   }
   translate([+ww/2-r_ff, -ww/2+r_ff, p_3])
   {
      sphere(r=r_ff);
      rotate([-90,0,0])
      {
         cylinder(r=r_ff, h=ll-2*r_ff);
      }
   }
   translate([+ww/2-r_ff, -ww/2-r_ff+ll, p_3])
   {
      sphere(r=r_ff);
   }
   rotate_extrude()
   {
      2d_fastener();
   }
}


module 2d_fastener()
{
   difference()
   {
      polygon(
         [
            [0, 0],
            [r_slot, 0],
            [r_slot+r_ff, p_3],
            [r_slot, p_3+r_ff],
            [r_slot, p_3+r_ff+l_fs],
            [r_keyhole, h_msh-p_3],
            [r_keyhole, h_msh],
            [0, h_msh]
            ]);
         translate([r_slot+r_ff, p_3+r_ff])
         {
           circle(r=r_ff);
         }
      }
}
