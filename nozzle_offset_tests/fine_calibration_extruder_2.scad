// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// Rough extruder offest calibration
// Extruder one part
// Just a few simple blocks
//
// (c) 2017 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0



// Change this to fit your actual printer, as well as you know
nozzle_offset_x = 36;
nozzle_offset_y = 0.0;

// Nozzle diameter. Set this to the nozzle size you use!
nd = 0.4;


font_name = "Demos LT";
// font_name = "Palatino";
// font_name = "serif";
// font_name = "bugger, haven't got this one";
font_name_2 = "Demos X";
font_name_3 = "serif";


fl = 30; // frame_length
some_distance = 3*fl;
fw = 2;  // frame_width
vl = 10;

vo = 0.05;

vc = ceil(2*nd / vo);
echo("doing ", vc, " lines for ", vo, " mm resulotiun");

// X


mirror([0,1,0])
{
   vernier_scale();
   frame();
}
translate([0, -0.6*fl, 0])
{
   linear_extrude(1)
   {
      text(text="x", size=10, font=font_name_2, valign="top");
   }
}



// y
translate([some_distance, 0, 0])
{

   rotate(270)
   {
      vernier_scale();
      frame();
   }
   translate([-0.6*fl, 0, 0])
   {
      linear_extrude(1)
      {
         text(text="y", size=10, font=font_name_2, halign="right");
      }
   }
}

// X
translate([0, some_distance, 0])
{
   mirror([0,1,0])
   {
      vernier_scale();
      frame();
   }
   translate([0, -0.6*fl, 0])
   {
      linear_extrude(1)
      {
         text(text="x", size=10, font=font_name_2, valign="top");
      }
   }
}


// y
translate([some_distance, some_distance, 0])
{
   rotate(270)
   {
      vernier_scale();
      frame();
   }
   translate([-0.6*fl, 0, 0])
   {
      linear_extrude(1)
      {
         text(text="y", size=10, font=font_name_2, halign="right");
      }
   }
}

// End pattern generation

module plain_scale()
{
   translate([0,vl/2, nd/2])
   {
      translate([0,fl/4-vl/2,0])
      {
         cube([nd, fl/2, nd], center=true);
      }


      for (i = [-vc+1:vc-1] )
      {
         translate([i * 2 * nd, 0 , 0])
         {
            cube([nd, vl, nd], center=true);
         }
      }
   }
}


module vernier_scale()
{
   translate([0,vl/2, nd/2])
   {
      translate([0,fl/4-vl/2,0])
      {
         cube([nd, fl/2, nd], center=true);
      }


      for (i = [-vc:vc] )
      {
         translate([i * ((2 * nd) - vo), 0 , 0])
         {
            cube([nd, vl, nd], center=true);
         }
      }
   }
}


module frame()
{
   translate([fl, 0, 0])
   {
      cube([10, fw, fw]);
   }
   translate([fl-fw, 0, 0])
   {
      cube([fw, fl/2, fw]);
   }
   mirror()
   {
      translate([fl-fw, 0, 0])
      {
         cube([fw, fl/2, fw]);
      }
      translate([fl, 0, 0])
      {
         cube([10, fw, fw]);
      }
   }

   translate([0, fl/2, fw/2])
   {
      {
         cube([2*fl, fw, fw], center=true);
      }
   }
}
