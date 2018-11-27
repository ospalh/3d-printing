// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// A dice tower as Vladimir Shukhov might have designed it. Or one that
// looks like a cooling tower.
//
// © 2017 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0


// c, w, and fw should be somewhat save to change. They change how
// substantial the tower is

// Flimsy:
w = 1.2;  // wire size
count = 14;  // count
fw = 1.8;  // feet width

// Light～normal
// w = 1.8;
// c = 24;
// fw = 2.4;

//  Changing this works reasonably well to scale the whole tower.
r_t = 42;  // Top (after print) radius

// When you change these, you’ll have to tweak l, the rings &c. below
a_1 = 30;  // Angle from vertical
a_2 = 40;  // Angle inwards

angle = 37; // Overhangs much below 60° are a problem for me

// *******************************************************
// Some shortcuts. These shouldn’t be changed

tau = 2 * PI;  // π is still wrong. τ = circumference / r

xy_factor = 1/tan(angle);
// To get from a height to a horizontal width inclined correctly
z_factor = tan(angle);  // The other way around



some_distance = 50;
ms = 0.01;  // Muggeseggele.

l = 3.125 * r_t; // Length of a wire. The height will be slightly less + the feet.

// Tweak this so the rings are in the right height
hs = 0.859 * l;

s = 360 / count;
$fn = count;

fl = 0.66*r_t;
fa_o = 29;

difference()
{
   union()
   {
      shell(1);
      shell(-1);
   }
   translate([0, 0, -6*w])
   {
      cylinder(r=2*r_t,h=6*w);
   }
}
// Tweak these radiuses to make it look goot
ring(0, r_t);
ring(0.25*hs, r_t*0.81);
ring(0.5*hs, r_t*0.78);
ring(0.75*hs, r_t*0.934);
rotate(s/2)
{
   ring(hs, r_t*1.195);
}
rotate(fa_o/2)
{
   feet(1.175*r_t);
   rotate(-fa_o)
   {
      mirror()
      {
         feet(1.175*r_t);
      }
   }
}
// Copy the raiuses from the rings here
ramp(0, r_t, 180);
ramp(0.25*hs, 0.81*r_t, 0);
ramp(0.5*hs, 0.78*r_t, 180);
ramp(0.75*hs, 0.934*r_t, 0);


module shell(f)
{
   for (o = [0:s:360-s+1])
   {
      // the +1 is a kludge needed when s is not an integer
      rotate(o)
      {
         translate([r_t, 0, 0])
         {
            rotate([f*a_1, 0, -1*f*a_2])
            {
               translate([0,0, l/2])
               {
                  cube([w, w, l], center=true);
               }
            }
         }
      }
   }
}


module ring(h, r)
{
   translate([0,0,h])
   {
      rotate_extrude()
      {
         translate([r,w/2,0])
         {
               square([w, w], center=true);
         }
      }
   }

}


module ramp(hl, rf, ao)
{
   for (o = [0:s:180-ms])
   {
      rotate(o + ao)
      {
         translate([-rf, 0, hl+0.5*w])
         {
            rotate([0, 90-angle, 0])
            {
               // translate([0,0, 0.5*rf])
               translate([-w/2,-w/2, 0])
               {
                  cube([w, w, rf/cos(angle)]);
               }
            }

         }
         rotate(s/2)
         {
            translate([-0.5*rf, 0, hl + 0.5*(rf)*z_factor+w*z_factor])
            {
               cube([w, 0.5*rf*tau/count, w], center=true);
            }
         }
      }
   }
   rotate(180 + ao)
   {
      translate([-rf, 0, hl+0.5*w])
      {
         rotate([0, 90-angle, 0])
         {
            translate([-w/2, -w/2, 0*rf])
            {
                  cube([w, w, rf/cos(angle)]);
            }
         }

      }
   }

}

module feet(rf)
{
   for (o = [0:60:300])
   {
      rotate(o)
      {
         translate([rf, 0, hs])
         {
            difference(){
               rotate([30, 0, 0])
               {
                  translate([0,0, fl/2])
                  {
                     cube([fw, fw, fl], center=true);
                  }
               }
               translate([0,0, -3*fw])
               {
                  cylinder(r=1.5*rf, h=3*fw);
               }
               translate([0,0, 0.83*fl])  // more ad-hockery
               {
                  cylinder(r=1.5*rf, h=3*fw);
               }

            }
         }
      }
   }
}
