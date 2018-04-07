// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// Inner tube foot for acrylic i3-style printers with 8 mm plates.
// For example GeeTech i3s.
//
// © 2018 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0


// A single plate. Millimetres
plate_width = 8.0;  // [2:0.1:15]

// Inflate it accordingly… Millimetres
inner_tube_diameter = 32;  // [20:1:50]

// … to preview. You will get all parts when you click “Create Thing”.
part = "single width ⟍ foot"; // [single width ⟍ foot: single width ⟍ foot, double width ⟍ foot: double width ⟍ foot, single width ⟋ foot: single width ⟋ foot, double width ⟋ foot: double width ⟋ foot]

// Cylinder section style. *Flat* is slightly smaller, *half* is exactly a half cylinder, *high* grabs the tube a bit
style = -0.5;  // [-0.5: flat, 0: half, 0.5 high]

// Set this to “render” and click on “Create Thing” when done with the setup.
preview = 1; // [0:render, 1:preview]



/* [Hidden] */

// Done with the customizer

w = 2.4;  // external wall width
p = 2.0;  // height of the connecting plate
ph = 10;  // Minimum height of the plate thing

// *******************************************************
// Some shortcuts. These shouldn’t be changed

tau = 2 * PI;  // π is still wrong. τ = ⌀ ÷ r
angle = 45; // The overhangs are not expected to look good here.
z_factor = tan(angle);


some_distance = 1.2*inner_tube_diameter;
ms = 0.01;  // Muggeseggele.
cs = 0.2; // clearance

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


module print_part()
{
   if ("single width ⟍ foot" == part)
   {
      foot(plate_width);
   }
   if ("double width ⟍ foot" == part)
   {
      foot(2*plate_width);
   }
   if ("single width ⟋ foot" == part)
   {
      mirror()
      {
         foot(plate_width);
      }
   }
   if ("double width ⟋ foot" == part)
   {
      mirror()
      {
         foot(2*plate_width);
      }
   }

}

module preview_parts()
{
   foot(plate_width);
   translate([some_distance, 0, 0])
   {
      foot(2*plate_width);
   }
   translate([0, some_distance, 0])
   {
      mirror()
      {
         foot(plate_width);
      }
   }
   translate([some_distance, some_distance, 0])
   {
      mirror()
      {
         foot(2*plate_width);
      }
   }
}



// *******************************************************
// Code for the parts themselves


module foot(pw)
{
   itr = inner_tube_diameter/2;
   function orm() = (style >= 0) ? w : -style*w;
   ir = itr + orm();
   or = ir*1.082;


   itt_r = itr - w;
   // how wide the inner tube thing should be in the end. The circle has
   // the radius of the inner tube, but the height is so that we get w on
   // either side.
   itt_e = sqrt(itr*itr - itt_r*itt_r);

   // The top part
   difference()
   {
      intersection()
      {
         translate([0,0,ph])
         {
            scale([1,1,(or*pw)/400])
            {
               sphere(r=or);
            }
         }
         rotate(22.5)
         {
            cylinder(r=or, h=ph, $fn=8);
         }
      }
      translate([0,0,ph/2-ms])
      {
         cube([pw+cs, 2*or+2*ms, ph+2*ms], center=true);
      }
   }

   difference()
   {
      translate([0, 0, ph-ms])
      {
         rotate(22.5)
         {
            cylinder(r=or, h=itr+p+style*itt_e+ms, $fn=8);
         }
      }
      translate([0, 0, ph+p+itr])
      {
         rotate(45)
         {
            rotate([0,90,0])
            {
               cylinder(r=itr,h=2*or+2*ms,center=true);
            }
         }
      }
   }

}
