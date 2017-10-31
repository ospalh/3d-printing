// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// Mitome in
//
// © 2017 Roland Sieker <ospalh@gmail.com>
// All rights reserved

// preview
part = "set";

line_1 = "馬";
line_2 = "鹿";
line_3 = "";

text_size_y = 4.3;
text_y_offset = 2;
text_x_offset = 0;
text_x_scale_factor = 0.9;

style = "rubber"; // or one-part or rubber_flat
preview = 1; // [0:render, 1:preview]


// done

// Main size
r_1 = 6;


w = 1.6;
w2 = 3.2;
clearance = 0.5;
bd = 0.4;  // print border

// inner print area size
r_0 = r_1 - bd;

// cap inner size
r_2 = r_1 + clearance;

// cap outer size
r_3 = r_2 + w;


// ink pad inner size. Circular.
r_4 = r_1 + 3*clearance;

// ink pad outer size.
r_5 = r_4 + w2;

r_b = 0.2*r_1;

font = "Google Noto Japanese";

height = 60;


// fn for differently sized objects, for preview or rendering.
pfa = 30;
pfb = 30;
pfc = 20;
rfa = 180;
rfb = 60;
rfc = 45;
function fa() = (preview) ? pfa : rfa;
function fb() = (preview) ? pfb : rfb;
function fc() = (preview) ? pfc : rfc;


parts = "";


// char_h = 1; // Much less chance for the charactels to topple over
char_h = 2; // Less chance for the bridges to droop down
rubber_h = 2; // How much stuff on top to hold it together
cap_h=10;


ms=0.01; // Muggeseggele

notch_r = 0.8;
notch_a = 3;
grip_a = 3.2;
ball_df = 0.35;
connector_z=2;


sd = r_5 + r_1 + w2;

rest();
rubber_mitome_in();
// notched_high_mitome_in();
translate([0, 2*sd, 0])
{
   //notched_high_mitome_in();
}

module rest()
{
   translate([sd, sd, 0])
   {
      notched_grip();
   }
   translate([0, sd, 0])
   {
      notched_cap();
   }
   translate([sd, 0, 0])
   {
      notched_ink_pad();
   }
}

module notched_cap()
{
   difference()
   {
      cap();
      notches(r_3, notch_a);
   }
}

module notched_ink_pad()
{
   difference()
   {
      ink_pad();
      notches(r_5, notch_a);
   }
}

module notched_grip()
{
   difference()
   {
      grip();
      notches(r_1, grip_a);
   }
}


module notches(w, a)
{
   rotate([0, 90, 0])
   {
      cylinder(r=notch_r, h=2*w, center=true, $fn=fc());
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
         cylinder(r=notch_r, h=height, $fn=fc());
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
            notches(r_1, grip_a);
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
         cylinder(r=r_1, h=mti_h, $fn=fa());
         translate([0,0,-ms])
         {
            cylinder(r=r_0, h=char_h+2*ms, $fn=fa());
         }
      }
   }
   intersection()
   {
      linear_extrude(height=char_h+0.5*sh, scale=1, convexity=10)
      {
         translate([ox, ol])
         {
            scale([blow,1,1])
            {
               text(
                  char_1, font=font, size=ts, halign="center", valign="center");
            }
         }
         translate([ox, -ol])
         {
            scale([blow,1,1])
            {
               text(
                  char_2, font=font, size=ts, halign="center", valign="center");
            }
         }
      }
      translate([0,0,-ms-char_h])
      {
         cylinder(r=r_1-ms, h=2*char_h+sh, $fn=fa());
      }
   }

   if (tp)
   {
      translate([-w/2, -r_1, mti_h-ms])
      {
         cube([w, r_1, connector_z+ms]);
      }
   }
   if (sb)
   {
      translate([-r_1*ball_df, 0, char_h+sh/2])
      {
         sphere(r=r_b, $fn=fb());
      }

   }
}

module grip()
{
   translate([0, 0, height/2])
   {
      difference()
      {
         union()
         {
            cylinder(r=r_1, h=height, center=true, $fn=fa());
            translate([-r_1+r_b*ball_df,0,0])
            {
               sphere(r=r_b, $fn=fb());
            }
         }
         translate([w/2+clearance, -clearance, height/2+ms])
         {
            rotate([0, 180, 0])
            {
               cube([w+ 2*clearance, r_2, connector_z+w+ms]);
            }
         }
      }
   }
}


module cap()
{
   difference()
    {
       cylinder(r=r_3, h=cap_h, $fn=fa());
      translate([0,0,w])
      {
         cylinder(r=r_2, h=cap_h, $fn=fa());
      }
    }
}
module ink_pad()
{
   difference()
   {

      cylinder(r=r_5, h=15, $fn=fa());
      translate([0,0,w2])
      {
         cylinder(r=r_4, h=20, $fn=fa());
      }
   }
}
