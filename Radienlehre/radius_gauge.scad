// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// Radius gauge
//
// © 2015 Grant Stevens
// https://www.thingiverse.com/thing:910616
// © 2018 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0
// Modification history:
// By Grant Stevens:
// 08/01/2015 Replace WriteScad with text(); thank you roki@thingiverse!
// 08/01/2015 Strengthen hinge.
// 05/27/2016 Add "inches" version.
// By ospalh:
// 6 July 2017: Drop inch version, use “Praxis font”, put unit on there
// 3 June 2018: Use heavy font, my render/preview trick.

view = 1; // 0 = assembly view; 1 = arranged for printing
part = 1; // 1 = stationary part; 2 = moving part; 3 = both;
          // 4 = gauge w/ hole; 5 = gauge w/ pin; 6 = both gauges

preview = true; // Set this to false before you create the STL.
font_ = "Praxis LT:style=Heavy";  // Set this to a font you actually have.
// Look up which ones are available under OpenSCAD’s Help/Font List menu.

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


// Constant
CM = 10; // Convert cm to mm

// Parameters
thickness = 3;
contact_radius = 10;
contact_spread = 50;
protractor_radius = contact_spread + contact_radius;
pointer_radius = protractor_radius - 12;
pointer_width = contact_radius / 2;
hinge_cylinder_dia = 10;
hinge_clearance = 0.2;
hinge_pin_dia = hinge_cylinder_dia - hinge_clearance;
hinge_pin_wall_thickness = 4.0;
hinge_pin_nub_dia = hinge_pin_dia + 0.7;
hinge_pin_spread_gap = thickness/4 * 1.8;
concave_tick_list = [9, 10, 12, 14, 16, 18, 20, 30, 40, 50, 100];

concave_number_list = [8, 10, 20, 50];

convex_tick_list = [6, 7, 8, 9, 10, 12, 14, 16, 18, 20, 30, 40, 50, 100];
convex_number_list = [5, 10, 20, 50];

text_extrude_height = 0.9;
text_character_height = 5.5;

if ( view == 0 ) // 0 = assembly view
{
   if ( part == 1 || part == 3 )
      stationary_part();

   if ( part == 2 || part == 3 )
      moving_part();

   if ( part == 4 || part == 6 )
      stationary_part_hinge();

   if ( part == 5 || part == 6 )
      moving_part_hinge();
}
else // view == 1 // 1 = arranged for printing
{
   if ( part == 1 || part == 3 )
      stationary_part();

   if ( part == 2 || part == 3 )
      translate([- contact_spread/2, contact_radius + 3, 2 * thickness])
         rotate([180, 0, 0])
         moving_part();

   if ( part == 4 || part == 6 )
      stationary_part_hinge();

   if ( part == 5 || part == 6 )
   {
      translate([2.1 * contact_radius, 0, 2 * thickness])
         rotate([180, 0, 0])
         moving_part_hinge();
   }
}



///////////////////////////////////////////////////////////////////////////////////

module stationary_part()
{
   stationary_part_hinge();

   // Protractor arc.
   linear_extrude(height=thickness)
      difference()
   {
      // Protractor arc.
      difference()
      {
         circle(r=protractor_radius, center=true);
         translate([-999/2, 0]) square([999, 999]);
         rotate([0, 0, -60]) translate([-999/2, 0]) square([999, 999]);
      }

      // Don't let this part run into the hinge pin hole.
      circle(r=contact_radius * .9, center=true);
   }

   // Tall contact cylinder on stationary part.
   linear_extrude(height=2 * thickness)
      translate([- contact_spread, 0])
      circle(r=contact_radius, center=true);

   translate([-contact_spread, 0, 2*thickness])
   {
      color("Black")
      {
         rotate(-70)
         {
            linear_extrude(text_extrude_height)
            {
               text(
                  "cm", text_character_height, font_,
                  halign="center",
                  valign="center");
            }
         }
      }
   }


   for ( measured_radius=convex_number_list )
      number_mark(
         str(abs(measured_radius)),
         angle_for_measured_convex_radius(measured_radius * CM));

   for ( measured_radius=concave_number_list )
      number_mark(
         str(abs(measured_radius)),
         - angle_for_measured_concave_radius(
            measured_radius * CM));

   for ( measured_radius=convex_tick_list )
      tick_mark(angle_for_measured_convex_radius(
                    measured_radius * CM));

   for ( measured_radius=concave_tick_list )
      tick_mark(- angle_for_measured_concave_radius(
                    measured_radius * CM));
}



module stationary_part_hinge()
{
   difference()
   {
      linear_extrude(height=thickness)
         difference()
      {
         // Contact circle with hinge cylinder.
         circle(r=contact_radius, center=true);

         // Cut out hinge cylinder.
         circle(d=hinge_cylinder_dia, center=true);
      }

      // Cut out lock-bevel in hinge cylinder.
      cylinder(h=thickness/2,
                d1=hinge_cylinder_dia + thickness,
                d2=hinge_cylinder_dia);
   }
}



module number_mark(text, angle)
   color("Black")
{
   rotate(-30 + angle)
      translate([0, - protractor_radius + 1, thickness])
      linear_extrude(text_extrude_height)
      text(text, text_character_height, font_, halign="center");
   tick_mark(angle, 4);
}



module tick_mark(angle, length=2)
   color("Black")
{
   rotate(-30 + angle)
      translate([-1/2, -(length + pointer_radius + .5), thickness])
      cube([1, length, text_extrude_height]);
}



module moving_part()
//   color("Cyan")
{
   translate([0, 0, thickness])
      linear_extrude(height=thickness)
   {
      // Pointer
      rotate([0, 0, -30])
         difference()
      {
         translate([- pointer_width/2, - pointer_radius])
			square([pointer_width, pointer_radius]);

         translate([0, - pointer_radius])
			for ( a=[-45, 135] )
               rotate([0, 0, a])
                  translate([.01, .01]) // avoid rendering error
                  square([9, 9]);
      }

      // Triangular fill between pointer and moving contact.
      polygon(
         points = [
            [0, 0],
            [contact_spread + contact_radius, 0],
            [.8 * - pointer_radius * sin(30), .8 * - pointer_radius * cos(30)] ],
         paths = [ [0, 1, 2] ]);
   }

   // Tall contact cylinder on moving part.
   linear_extrude(height=2 * thickness)
      translate([contact_spread, 0, 0])
      circle(r=contact_radius, center=true);

   // Hinge pin.
   moving_part_hinge();
}



module hinge_pin_solid()
{
   // Bottom half of hinge cylinder.
   translate([0, 0, thickness / 2])
      cylinder(h=thickness / 2, d=hinge_pin_dia);

   // Bulge in the middle, that must be pressed through the hole in the matching
   // part, and will then expand to hold the pieces together.
   intersection()
   {
      union()
      {
         cylinder(h=thickness/4,
                   d1=hinge_pin_dia               - 1.0,
                   d2=hinge_pin_dia + thickness/2 - 1.0);

         translate([0, 0, thickness/4])
			cylinder(h=thickness/4,
                      d1=hinge_pin_dia + thickness/2,
                      d2=hinge_pin_dia);
      }

      // Remove the too-wide portion of the bulge.
      cylinder(h=99, d=hinge_pin_nub_dia);
   }
}



module moving_part_hinge()
   //color("Cyan")
{
   // Contact circle with hinge pin.
   translate([0, 0, thickness])
      linear_extrude(height=thickness)
      circle(r=contact_radius, center=true);

   // Hinge pin.
   difference()
   {
      hinge_pin_solid();

      scale([
                1 - hinge_pin_wall_thickness / hinge_pin_dia,
                1 - hinge_pin_wall_thickness / hinge_pin_dia,
                1])
      {
         hinge_pin_solid();
      }

      translate([- hinge_pin_spread_gap/2, -99/2, -99/2])
      {
         cube([hinge_pin_spread_gap, 99, 99]);
      }

      // Cut off the overhang on both ends.
      for ( m=[0, 1] )
      {
         mirror([0, m, 0])
         {
            translate([-9/2, hinge_pin_dia/2, -9/2])
            {
               cube([9, 9, 9]);
            }
         }
      }
   }
}



function angle_for_measured_concave_radius(measured_radius) = 2 * asin(contact_spread / 2 /(measured_radius - contact_radius));

function angle_for_measured_convex_radius(measured_radius) = 2 * asin(contact_spread / 2 /(measured_radius + contact_radius));
