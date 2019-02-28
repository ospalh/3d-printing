// Tea pot lid
// (c) 2017 Roland Sieker <ospalh@gmail.com> 
// Licence: CC-BY-SA 4.0

////////////////////////////////////////////
// Maker config section

// From the teapot. Radius of the neck where the lid will rest, in millimeters.
teapot_inner_radius = 35;
// And i mean radius. When you measure the diameter (with a caliper), divide by two.

// How you like it
brim_height = 11;  // height of the lange/brim
thickness = 3;  // general material thickness
sprout_width = 15;  // How wide the gap for the spourt is 
handle_radus = 5;

use_standard_handle = true;
// Set to false and add your own ornament as handle in the next step (slic3r, ...) if you like.

// How your printing works. The higher, the higher and uglier (in some sense) the lid. Too low, and you get whiskers/drooping
overhang_angle = 35;

///////////////////////////////////
// End config section


// Main
{
   translate([300, 0, 0])
   {
      brim();
   }
   
   ir = teapot_inner_radius;  // To avoid cobol fingers
   t = thickness;
   polygon();
}

module brim()
{
   difference()
   {
      // The real brim:
      rotate_extrude()
      // I wanted to use the angle argument here, but my OpenSCAD's too old.
      {
         translate([teapot_inner_radius-thickness, 0, 0])
         {
            square([thickness, brim_height]);
         }
      }

      // The gap
      translate([-0.5*sprout_width, 0.5*teapot_inner_radius, -0.5*brim_height])
      {
         cube([sprout_width, teapot_inner_radius, 2*brim_height], false);
      }
   }
}

module hat_ring()

module hat_funnel()
{
   
}

module grip_base()
{
}

module grip()
{
   
}