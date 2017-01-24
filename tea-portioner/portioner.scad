// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// Tea portioner
//
// © 2017 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0
// Using material (or inspirations) by
//  Soren_Furbo (https://www.thingiverse.com/thing:43899/)
//

// How many cm³ (ml) for one portion
volume = 55;

// Don’t
use_american_customary_units = false;

// Add three extra feet on the sides without the chute
add_feet = false;

// Should be a multiple of your nozzle diameter
wall_thickness = 1.6; // [1.2, 1.5, 1.6, 1.8]

module end_customizer()
{
   // This is a dummy module so stop users messing with the values below.
}


// TODO: labels
// TODO²: Braile labels
// label_style = 1; [0:No label, 1:Raised Text, 2:Colored Text, 3:Braile];

v_cmm = volume * 1000;

// $fa=5;  // Fewer facets than standard

// π is still wrong. Even if we use the area of a circle below. Use τ.
tau = 2 * PI;

// Curvature of sides (Sphere radius)
roundness = 5;
inner_radius = roundness-wall_thickness;

droop_tolerance = 0.1;

leg_width = 2.4;
feet_angle = 50;  // Degrees
funnel_angle = 50;

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

some_distance = 4 * inner_box_dimension;


if (use_american_customary_units)
{
   how_rude();
}
else
{
   //translate([some_distance,0,0])
   {
      measure();
      feet_and_chute();
   }
   translate([0,some_distance,0]){
   %funnel();
   }
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

// Length of the inner cube
icl_xy = inner_box_dimension - 2 * inner_radius;
// Measure shell dimension
icl_z = inner_box_dimension - inner_radius;
msd = inner_box_dimension + 2*wall_thickness;


module measure()
{
   // The precisely shaped box

   icl_z_plus =  icl_z + 2*wall_thickness+droop_tolerance;
   difference()
   {
      union()
      {
         translate([0,0,icl_z_plus/2+roundness])
         {
            difference()
            {
               union()
               {
                  minkowski()
                  {
                     // This is the outer shell
                     cube([icl_xy, icl_xy, icl_z_plus], center=true);
                     sphere(roundness);
                  }
                  // The thicker walls at the top
                  delta_x = (inner_box_dimension +4*wall_thickness)/
                     (inner_box_dimension + 2*wall_thickness);
                  translate([0,0,icl_z/2-4*wall_thickness])
                  {
                     linear_extrude(height=2*wall_thickness,scale=delta_x)
                     {
                        offset(r=roundness)
                        {
                           square([icl_xy,icl_xy],center=true);
                        }
                     }
                  }
                  translate([0,0,icl_z/2-2*wall_thickness])
                  {
                     linear_extrude(height=3*wall_thickness+droop_tolerance)
                     {
                        offset(r=roundness)
                        {
                           square([icl_xy+2*wall_thickness,icl_xy+2*wall_thickness],center=true);
                        }
                     }
                  }
               }
               minkowski()
               {
                  // This is the main hollow shell
                  cube([icl_xy, icl_xy, icl_z_plus], center=true);
                  sphere(inner_radius);
               }
               // Cut off the top. A big enough cube. important is the
               // lower face height.
               translate([-msd/2,-msd/2,icl_z_plus/2])
               {
                  cube([msd,msd,2*roundness]);
               }
            }
         }
      } // The measuring cup, with thick walls
      // Cutting out the rails for the funnel
      yl_extra = 10*wall_thickness;
      xl = inner_box_dimension+2*wall_thickness-2*roundness;
      yl = inner_box_dimension+wall_thickness-2*roundness + yl_extra;
      // Main rails
      translate([0,yl_extra/2,wall_thickness+inner_box_dimension])
      {
         linear_extrude(wall_thickness)
         {
            offset(roundness)
            {
               square([xl,yl],center=true);
            }
         }
      }
      // Space for the funnel
      translate([0,inner_box_dimension/2,1.8*wall_thickness+inner_box_dimension])
      {
         linear_extrude(2*wall_thickness)
         {
            square([inner_box_dimension,8*wall_thickness],center=true);
         }
      }
   }
      // End rails

}

module feet_and_chute()
{
   // The length were done by hand, rather than
   // calculated. looks good, is good enough.
   w = inner_box_dimension + 4*wall_thickness;
   h = inner_box_dimension + wall_thickness;
   l = h / sin(feet_angle);
   p = l * cos(feet_angle);
   o = w/2 + p/2 - leg_width;
   difference()
   {
      union()
      {
         if (add_feet)
         {
            rotate([0,0,-90])
            {
               translate([0,-o, h/2])
               {
                  rotate(a=[feet_angle, 0, 0])
                  {
                     cube([leg_width, l, leg_width], center=true);
                  }
               }
               translate([0,-o-p/2+leg_width/2,wall_thickness/2])
               {
                  cylinder(r=1.5*leg_width,h=wall_thickness,center=true);
               }
            }

            translate([0,-o, h/2])
            {
               rotate(a=[feet_angle, 0, 0])
               {
                  cube([leg_width, l, leg_width], center=true);
               }
            }
            translate([0,-o-p/2+leg_width/2,wall_thickness/2])
            {
               cylinder(r=1.5*leg_width,h=wall_thickness,center=true);
            }
            rotate([0,0,90])
            {
               translate([0,-o, h/2])
               {
                  rotate(a=[feet_angle, 0, 0])
                  {
                     cube([leg_width, l, leg_width], center=true);
                  }
               }
               translate([0,-o-p/2+leg_width/2,wall_thickness/2])
               {
                  cylinder(r=1.5*leg_width,h=wall_thickness,center=true);
               }

            }
         }
         rotate([0,0,180])
         {
            translate([0,-o, h/2])
            {
               rotate(a=[feet_angle, 0, 0])
               {
                  cube([inner_box_dimension, l, wall_thickness], center=true);
                  translate([inner_box_dimension/2-wall_thickness/2,0,2.5*wall_thickness])
                  {
                     cube([wall_thickness, 2*l, 5*wall_thickness], center=true);
                  }
                  translate([-inner_box_dimension/2+wall_thickness/2,0,2.5*wall_thickness])
                  {
                     cube([wall_thickness, 2*l, 5*wall_thickness], center=true);
                  }
               }
            }
         }

      }
      // Honking big boxes to cut off too large stuff
      translate([0,0,-10*inner_box_dimension])
      {
         cube(20*inner_box_dimension,center=true);
      }
      translate(
         [0,0,10*inner_box_dimension + inner_box_dimension -
          inner_radius +roundness])
      {
         cube(20*inner_box_dimension,center=true);
      }
      cube([inner_box_dimension+wall_thickness/2,inner_box_dimension+wall_thickness/2,3*inner_box_dimension],center=true);
   }
}

module funnel()
{
   // First the base
   xl = inner_box_dimension+2*wall_thickness;
   yl = inner_box_dimension+wall_thickness;
   translate([0,0,0.5*wall_thickness])
   {
      difference(){
         difference()
         {
            cube([xl, yl, wall_thickness], center=true);
            minkowski()
            {
               // This is the main hollow shell
               cube([icl_xy-wall_thickness, icl_xy-wall_thickness, 5*wall_thickness], center=true);
               cylinder(r=inner_radius,h=5*wall_thickness);
            }
         }
      }
   }
}
