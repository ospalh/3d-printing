// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// Mitome in
//
// © 2017–2018 Roland Sieker <ospalh@gmail.com>
// All rights reserved

/* [Global] */

// … to preview. You will get all parts when you click “Create Thing”. You don’t have to print all the parts. See description for details.
part = "rubber_seal"; // [rubber_seal, grip, seal_with_grip, cap, ink_pad, foam_punch, ink_pad_cap]


// Set this to “render” and click on “Create Thing” when done with the setup.
preview = 1; // [0:render, 1:preview]

/* [Text] */
// First line of text. Leave empty for one line
line_1 = "馬";
// Single line of text. Leave empty for two line
line_2 = "";
// Second line of text. Leave empty for one line
line_3 = "鹿";

// Make sure to pick a font that a) has the characters you need and b) is available for the platform you use (Customizer or your desktop PC)
font = "IPAexGothic:style=Regular";

/* [Size] */
// Standard non-registerend seals, usually aren’t much bigger than about 12 mm high
size = 12; // [9:1:20]

/* [Tweaks] */

// Text size in mm
text_size = 4.32;  // [1:0.01:10]


// Scale characters in x direction
text_x_scale = 1.2;  // [0.3:0.01:3]
// Make the seal an ellipse, one direction
seal_x_scale = 0.7;  // [0.3:0.01:1]
// or the other. One of these should be 1.
seal_y_scale = 1;  // [0.3:0.01:1]

// Move the text around until it fits.
vertical_text_offset = 2.1;  // [-5:0.01:5]
horizontal_text_offset = 0;  // [-5:0.01:5]


/* [Hidden] */

// *******************************************************
// Extra parameters. These can be changed reasonably safely.

height = 60;  // of the seal or grip

w=1.8;  // Wall width
w2=3.2;  // Wall width for ink pad
clearance = 0.5;
bd=0.4;  // Width of the ring around the characetrs

ink_pad_height = 15;

punch_clearance = 0.1;
punch_wall = 0.4;


char_h = 2; // How much air for the characters
rubber_h = 2; // How much stuff on top to hold it together
cap_h=10;  // How high the cap should be

pad_cap_h = 5;

// Sizes for smaller parts &c.
notch_r = 0.8;
notch_a = 3;
grip_a = 3.2;
ball_df = 0.35;
connector_z=2;

// For the ink pad cap
r_f = 1.2;  // filleting radius
r_r = 0.8;  // rounding radius


// *******************************************************
// Some shortcuts. These shouldn’t be changed


// Main size
r_1y = size/2 * seal_y_scale;
r_1x = size/2 * seal_x_scale;
// r_1x = 8;

// inner print area size
r_0y = r_1y - bd;
r_0x = r_1x - bd;

// cap inner size
r_2y = r_1y + clearance;
r_2x = r_1x + clearance;

// cap outer size
r_3y = r_2y + w;
r_3x = r_2x + w;

r_1max = max(r_1x, r_1y);
r_4 = r_1max + 3*clearance;

// ink pad outer size.
r_5 = r_4 + w2;

// ink pad foam punch outer diameter
r_7 = r_4 - punch_clearance;
// inpk pad foam punch inner diameter
r_6 = r_7 - punch_wall;


r_b = 0.2*r_1y;

// for the ink pad cap
r_8 = r_4 - 0.7 * r_f;
r_9 = r_8 * 0.9;  // ex r_u

ms=0.01; // Muggeseggele

some_distance = r_5 + r_1max + w2;

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

// print_part();
preview_parts();
// stack_parts();


module print_part()
{
   if ("NN" == part)
   {
      nn();
   }
   if ("foo" == part)
   {
      foo();
   }
}

module stack_parts()
{
   // intersection()
   {
      color("yellow")
      {
         foo();
      }
      translate([0,0,30])
      {
         color("red")
         {
            NN();
         }
      }
   }
}



module preview_parts()
{
   rubber_mitome_in();
   translate([some_distance, some_distance, 0])
   {
      notched_grip();
   }
   translate([0, some_distance, 0])
   {
      notched_cap();
   }
   translate([some_distance, 0, 0])
   {
      notched_ink_pad();
   }
   translate([some_distance, 2*some_distance, 0])
   {
      ink_pad_punch();
   }
   translate([0, 2*some_distance, 0])
   {
      notched_high_mitome_in();
   }
   translate([2*some_distance, some_distance, 0])
   {
      notched_ink_pad_cap();
   }
}


// *******************************************************
// Code for the parts themselves



module notched_cap()
{
   difference()
   {
      cap();
      notches(r_3x, r_3y, notch_a);
   }
}

module notched_ink_pad()
{
   difference()
   {
      ink_pad();
      notches(r_5, r_5, notch_a);
   }
}

module notched_grip()
{
   difference()
   {
      grip();
      notches(r_1x, r_1y, grip_a);
   }
}


module notches(wx, wy, a)
{
   if (wx < wy)
   {
      notches_x(wx, a);
   }
   else
   {
      rotate(90)
      {
         notches_x(wy, a);
      }
   }
}

module notches_x(w, a)
{
   rotate([0, 90, 0])
   {
      cylinder(r=notch_r, h=2*w, center=true);
   }
   z_notch();
   mirror()
   {
      z_notch();
   }
   module z_notch()
   {
      translate([w, 0, 0])
      {
         rotate([0, a, 0])
         cylinder(r=notch_r, h=height);
      }
   }
}

module notched_high_mitome_in()
{
   difference()
   {
      mitome_in(height, false, true);
      translate([0, 0, height+char_h])
      {
         rotate([180, 0, 0])
         {
            notches(r_1x, r_1y, grip_a);
         }
      }
   }
}

module rubber_mitome_in()
{
   mitome_in(rubber_h, true, false);
}


module mitome_in(sh, tp, sb)
{
   mti_h = char_h+sh;
   // rotate([180,0,0])
   union()
   {
      difference()
      {
         scale([r_1x/r_1y, 1, 1])
         {
            cylinder(r=r_1y, h=mti_h);
         }
         scale([r_0x/r_0y, 1, 1])
         {
            translate([0,0,-ms])
            {
               cylinder(r=r_0y, h=char_h+2*ms);
            }
              }
           }
        }
   intersection()
   {
      linear_extrude(height=char_h+0.5*sh, scale=1, convexity=10)
      {
         all_text();
      }
      scale([(r_1x/r_1y), 1, 1])
      {
         translate([0,0,-ms-char_h])
         {
            cylinder(r=r_1y-ms, h=2*char_h+sh);
         }
      }
   }

   if (tp)
   {
      translate([-w/2, -r_1y, mti_h-ms])
      {
         cube([w, r_1y, connector_z+ms]);
      }
   }
   if (sb)
   {
      translate([-r_1x+r_b*ball_df, 0, char_h+sh/2])
      {
         sphere(r=r_b);
      }

   }
}

module grip()
{
   // rotate([180,0,0])
    translate([0, 0, height/2])
    {
       difference()
       {
          union()
          {
             scale([r_1x/r_1y, 1, 1])
             {
                cylinder(r=r_1y, h=height, center=true);
             }

             translate([-r_1x+r_b*ball_df,0,0])
             {
                sphere(r=r_b);
             }
          }
          translate([w/2+clearance, -clearance, height/2+ms])
          {
             rotate([0, 180, 0])
             {
                cube([w+ 2*clearance, r_2y, connector_z+w+ms]);
             }
          }
       }
    }
}


module cap()
{
   difference()
    {
      scale([r_3x/r_3y, 1, 1])
      {
         cylinder(r=r_3y, h=cap_h);
      }
      translate([0,0,w])
      {
         scale([r_2x/r_2y, 1, 1])
         {
            cylinder(r=r_2y, h=cap_h);
         }
      }
    }
}
module ink_pad()
{
   difference()
   {
      cylinder(r=r_5, h=ink_pad_height);
      translate([0,0,w2])
      {
         cylinder(r=r_4, h=ink_pad_height);
      }
   }
}


module ink_pad_punch()
{
   difference()
   {
      cylinder(r=r_7, h=ink_pad_height);
      translate([0,0,w])
      {
         cylinder(r=r_6, h=ink_pad_height);
      }
   }
}


module notched_ink_pad_cap()
{
   difference()
   {
      ink_pad_cap();
      notches(r_5, r_5, notch_a);
   }
}

module ink_pad_cap()
{
   translate([0,0,pad_cap_h+w2])
   {
      mirror([0,0,1])
      {
         rotate_extrude()
         {
            2d_ink_pad_cap();
         }
      }
   }
}

module 2d_ink_pad_cap()
{
   rot_points = [
      [0, 0],
      [r_9-r_r, 0],
      [r_9-r_r, r_r],
      [r_9, r_r],
      [r_8, pad_cap_h-r_f],
      [r_8, pad_cap_h],
      [r_5-r_r, pad_cap_h],
      [r_5-r_r, pad_cap_h+r_r],
      [r_5, pad_cap_h+r_r],
      [r_5, pad_cap_h+w2-r_r],
      [r_5-r_r, pad_cap_h+w2-r_r],
      [r_5-r_r, pad_cap_h+w2],
      [0, pad_cap_h+w2],
      ];
  polygon(rot_points);
  translate([r_9-r_r, r_r])
  {
     circle(r=r_r);
  }
  translate([r_8, pad_cap_h-r_f])
  {
     difference()
     {
        square([r_f, r_f]);
        translate([r_f,0])
        {
           circle(r=r_f);
        }
     }
  }
  translate([r_5-r_r, pad_cap_h+r_r])
  {
     circle(r=r_r);
  }
  translate([r_5-r_r, pad_cap_h+w2-r_r])
  {
     circle(r=r_r);
  }
}

module all_text()
{
 one_text(line_1, horizontal_text_offset, vertical_text_offset);
 one_text(line_2, horizontal_text_offset, 0);
 one_text(line_3, horizontal_text_offset, -vertical_text_offset);
}

module one_text(t, x, y)
{
   translate([x, y])
   {
      scale([text_x_scale,1])
      {
         text(
            t, font=font, size=text_size, halign="center", valign="center");
      }
   }
}
