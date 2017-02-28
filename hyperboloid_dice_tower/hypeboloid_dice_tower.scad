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


// When you change these, you’ll have to tweak the rings below
r_t = 34;  // top (after print) radius
a_1 = 30;  // angle from vertical;
a_2 = 50;  // angle inwards;
l = 125.5; // lengt of a wire. the height will be slightly less


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
      //cylinder(r=2*r_t,h=6*w);
   }
}
// These are done by hand, made to look good, rather than caluclated.
ring(h=0, r=r_t);
ring(h=26.675, r=r_t*0.72);
ring(h=53.75, r=r_t*0.68);
ring(h=80.624, r=r_t*0.91);
ring(h=107.5, r=r_t*1.275);
rotate(-18)
{
  feet(1.275*r_t,35, 107.5);
}
mirror()
{
   rotate(0)
   {
      feet(1.275*r_t,35, 107.5);
   }
}
ramp(r_t, 0, 180);
ramp(0.72*r_t, 26.675, 0);
ramp(0.68*r_t, 53.75, 180);
ramp(0.91*r_t, 80.624, 0);


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


module feet(rf, fl, hl)
{
   for (o = [0:60:300])
   {
      rotate(o)
      {
         translate([rf, 0, hl])
         {
            difference(){
               rotate([30, 0, 0])
               {
                  translate([0,0, fl/2])
                  {
                     cube([2*w, 2*w, fl], center=true);
                  }
               }
               translate([0,0, -4*w])
               {
                  cylinder(r=1.5*rf, h=4*w);
               }
               translate([0,0, 0.83*fl])  // more ad-hockery
               {
                  cylinder(r=1.5*rf, h=4*w);
               }

            }
         }
      }
   }
}

module ramp(rf, hl, ao)
{
   for (o = [0:20:160])
   {
      rotate(o + ao)
      {
         translate([rf, 0, hl+0.5*w])
         {
            rotate([0, -40, 0])
            {
               translate([0,0, 0.6*rf])
               {
                  cube([w, w, 1.2*rf], center=true);
               }
            }

         }
         rotate(10)
         {
            translate([0.2*rf, -w, hl + 0.91*rf])
            {
               cube([w, 0.086*rf, w]);
            }
            translate([0.6*rf, -0.13*rf+w/2, hl + 0.455*rf])
            {
               cube([w, 0.225*rf, w]);
            }
         }
      }
   }
   rotate(180 + ao)
   {
      translate([rf, 0, hl+0.5*w])
      {
         rotate([0, -40, 0])
         {
            translate([0,0, 0.6*rf])
            {
                  cube([w, w, 1.2*rf], center=true);
            }
         }

      }
   }

}
