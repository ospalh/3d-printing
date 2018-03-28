// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// Mitome in
//
// © 2017–2018 Roland Sieker <ospalh@gmail.com>
// All rights reserved

// … to preview. You will get all parts when you click “Create Thing”.
part = "NN"; // [NN: foo, bar: baz]

// Set this to “render” and click on “Create Thing” when done with the setup.
preview = 1; // [0:render, 1:preview]


line_1 = "馬";
line_2 = "";
line_3 = "鹿";

size = 12; // Max size for men’s Mitome-in

text_x_scale = 1.2;
seal_x_scale = 0.7;
seal_y_scale = 1;


// squeeze=0.9;  // width/height. Or give r_1x directly.
w=1.6;
w2=3.2;
clearance = 0.5;
bd=0.4;  // print border


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


// ink pad inner size. Circular.
ink_pad_height = 15;

r_1max = max(r_1x, r_1y);
r_4 = r_1max + 3*clearance;

// ink pad outer size.
r_5 = r_4 + w2;

punch_clearance = 0.1;
punch_wall = 0.4;

// ink pad foam punch outer diameter
r_7 = r_4 - punch_clearance;
// inpk pad foam punch inner diameter
r_6 = r_7 - punch_wall;



r_b = 0.2*r_1y;

// font = "Demos LT";
font = "IPAexGothic:style=Regular";

height = 60;




// ts=0.345*size;
ts = 0.72*r_1y;  // text size
ol = 0.35*r_1y;  // offset y
// ox=-0.01*r_1x; // offset x
ox = 0; // offset x


// char_h = 1; // Much less chance for the charactels to topple over
char_h = 2; // Less chance for the bridges to droop down
rubber_h = 2; // How much stuff on top to hold it together
cap_h=10;


ms=0.01; // Muggesäggele

notch_r = 0.8;
notch_a = 3;
grip_a = 3.2;
ball_df = 0.35;
connector_z=2;

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

// *******************************************************
// Code for the parts themselves



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
}

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


module all_text()
{
 one_text(line_1, ox, ol);
 one_text(line_2, ox, 0);
 one_text(line_3, ox, -ol);
}

module one_text(t, x, y)
{
   translate([x, y])
   {
      scale([text_x_scale,1])
      {
         text(
            t, font=font, size=ts, halign="center", valign="center");
      }
   }
}
