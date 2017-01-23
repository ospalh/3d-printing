// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// Tea portioner
//
// © 2017 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0
// Using material by
//  Soren_Furbo (https://www.thingiverse.com/thing:43899/)
//

// How many cm³ (ml) for one portion
volume = 27;

// Don’t
use_american_customary_units = false;

module end_customizer()
{
   // This is a dummy module so stop users messing with the values below.
}

// TODO: labers
// TODO²: Braile labels
// label_style = 1; [0:No label, 1:Raised Text, 2:Colored Text, 3:Braile];

v_cmm = volume * 1000;

$fa=5;  // Fewer facets than standard

// pi is still wrong. Even if we use the area of a circle below.
tau = 2 * PI;

// Curvature of sides (Sphere radius)
roundness = 5;
//How thick the walls are:
thickness = 2.5;
inner_radius = roundness-thickness;


// Crazy math to get the volume with the rounding right Basically we
// have V = l³ - lost_volume with lost volume = the fillets in the
// edges and corners, ½ (cube - sphere), and a bit, depending on l,
// (square rod - cylinder), with no l² term.
// Transformed to 0 = l³ + al + b, plugged into Wolfram Alpha, put in
// here.
a = -8*(4-tau/2)*inner_radius*inner_radius;
b = -v_cmm +
      ((4-tau/3) -12 * (4 - tau/2)) * inner_radius*inner_radius*inner_radius;
// echo(a);
// echo(b);
// The solution of x³+ax+b=0, accordinrg to Wolfram alpha
cube_root_bit = pow(sqrt(3) * sqrt(4*a*a*a + 27*b*b) - 9*b, 1/3);
inner_box_dimension = cube_root_bit / (pow(2, 1/3) * pow(3, 2/3)) -
   pow(2/3, 1/3) * a / cube_root_bit;
// echo(inner_box_dimension);
// echo(pow(v_cmm,1/3));
// Quck tests showed reasonable values, so i’ll keep this version
// until somebody spots an error.

// End crazy math.




if (use_american_customary_units)
{
   how_rude();
}
else
{
//    rounded_box();
   measure();

}

module how_rude()
{
   linear_extrude(height = 0.5) {
      text(text="Please visit", size=5);
      translate([0,-5,0])
      {
         text(text="metric4us.com", size=5);
      }
   }
}

module measure()
{
   // The precisely shaped box

   // Length of the inner cube
   icl_xy = inner_box_dimension - 2 * inner_radius;
   icl_z = inner_box_dimension - inner_radius;
   // Measure shell dimension
   msd = inner_box_dimension + 2*thickness;

   translate([0,0,icl_z/2+roundness])
   {
      difference()
      {
         difference()
         {
            minkowski()
            {
               // This is the outer shell
               cube([icl_xy, icl_xy, icl_z], center=true);
               sphere(roundness);
            }
            minkowski()
             {
                // This is the main hollow shell
                cube([icl_xy, icl_xy, icl_z], center=true);
                sphere(inner_radius);
             }
         } // The measure with rounded top
         {
            // Cut off the top. A big enough cube. important is the
            // lower face height.
            translate([-msd/2,-msd/2,icl_z/2])
            {
               cube([msd,msd,2*roundness]);
            }
         }
      }
   }
   translate([0,0,inner_box_dimension+0.5*thickness])
   {
      // Stuff at the top edge: the rail for the funnel
      translate(
         [icl_xy/2+roundness+0.5*thickness,0,0])
      {
         cube([thickness, inner_box_dimension+2*thickness,
               thickness], center=true);
      }
      translate(
         [-icl_xy/2-roundness-0.5*thickness,0,0])
      {
         cube([thickness, inner_box_dimension+2*thickness,
               thickness], center=true);
      }
      // Fill in the space at the corners
      translate([+icl_xy/2,+icl_xy/2,0])
      {
         difference()
         {
            translate([+inner_radius,+inner_radius,0]){
               cube([2*thickness,2*thickness,thickness],center=true);
            }
            // The +1 is to make sure we cut off all at the top and bottom
            cylinder(h=thickness+1,r=inner_radius,center=true);
         }
      }
      translate([+icl_xy/2,-icl_xy/2,0])
      {
         difference()
         {
            translate([+inner_radius,-inner_radius,0]){
               cube([2*thickness,2*thickness,thickness],center=true);
            }
            cylinder(h=thickness+1,r=inner_radius,center=true);
         }
      }
      translate([-icl_xy/2,+icl_xy/2,0])
      {
         difference()
         {
            translate([-inner_radius,+inner_radius,0]){
               cube([2*thickness,2*thickness,thickness],center=true);
            }
            cylinder(h=thickness+1,r=inner_radius,center=true);
         }
      }
      translate([-icl_xy/2,-icl_xy/2,0])
      {
         difference()
         {
            translate([-inner_radius,-inner_radius,0]){
               cube([2*thickness,2*thickness,thickness],center=true);
            }
            cylinder(h=thickness+1,r=inner_radius,center=true);
         }
      }
      // The two end stops
      translate(
         [0,-icl_xy/2-roundness+0.5*thickness,0])
      {
         cube([inner_box_dimension+6*thickness, thickness,
               thickness], center=true);
      }

   }

}



module rounded_box()
{
   translate([-width/2+roundness,-depth/2+roundness,0])
   {
      difference()
      {
         {
            translate([0,0,roundness])
            {
               difference()
               {
                  minkowski()
                  {
                     cube(
                        [width-2*roundness,depth-2*roundness,height-2*roundness]);
                     sphere(roundness);
                  }
                  minkowski(){
                     cube(
                        [width-2*(inner_radius+thickness),
                         depth-2*(inner_radius+thickness),
                         height-2*(thickness)]);
                     sphere(inner_radius);
                  }
               }
            }
         }
         // difference
         {
            translate([-roundness,-roundness,height-roundness])
            {
               cube([width,depth,roundness+1]);
            }
         }
      }
   }
}
