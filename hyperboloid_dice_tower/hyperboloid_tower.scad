// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// A dice tower as Vladimir Shukhov might have designed it. Or one that
// looks like a cooling tower.
//
// © 2017 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0


// w and c should be somewhat save to change

// Flimsy:
w = 1.2;  // wire size
c = 14;  // count

// Light～normal
//w = 1.8;
//c = 20;


// When you change these, you’ll have to tweak the rings &c. below
r_t = 34;  // Top (after print) radius
a_1 = 30;  // Angle from vertical
a_2 = 50;  // Angle inwards
l = 125.5; // Length of a wire. The hight will be slightly less + the feet.

// Tweak this so the rings are in the right hight
hs = 0.8566 * l;

s = 360 / c;
$fn = c;


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
ring(0,   r_t);
ring(0.25*hs, r_t*0.72);
ring(0.5*hs, r_t*0.68);
ring(0.75*hs, r_t*0.91);
ring(hs, r_t*1.27);
rotate(0)
{
  feet(1.27*r_t);  // Use the last rings’s r factor here
  mirror()
  {
     feet(1.27*r_t, 107.5);
  }
}

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
               cube([w, w, l], center=true );
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


module feet(rf)
{
   fl = 6.8 * rf / c;
   for (o = [0:s:360-s+0.1])
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
                     cube([w, w, fl], center=true);
                  }
               }
               translate([0,0, -3*w])
               {
                  cylinder(r=1.5*rf, h=3*w);
               }
               translate([0,0, 0.83*fl])  // more ad-hockery
               {
                  cylinder(r=1.5*rf, h=3*w);
               }

            }
         }
      }
   }
}
