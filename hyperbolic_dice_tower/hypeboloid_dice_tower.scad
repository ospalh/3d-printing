// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// A dice tower as Vladimir Shukhov might have designed it.
//
// © 2017 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0


// These two should be somewhate save to change
w = 1.4;  // wire size
c = 20;  // count


// When you change these, you’ll have to tweak the rings below
r_t = 40;  // top (after print) radius
a_1 = 30;  // angle from vertical;
a_2 = 40;  // angle inwards;
l = 125; // lengt of a wire. the height will be slightly less


s = 360 / c;
$fn = c;


difference()
{
   union()
   {
      shell();
      mirror()
      {
         shell();
      }

   }
   translate([0, 0, -6*w])
   {
      cylinder(r=2*r_t,h=6*w);
   }
}
// These are done by hand, made to look good, rather than caluclated.
ring(h=0, r=r_t);
ring(h=26.675, r=r_t*0.81);
ring(h=53.75, r=r_t*0.78);
ring(h=80.624, r=r_t*0.934);
ring(h=107.5, r=r_t*1.19);
rotate(-16)
{
feet(1.18*r_t,40, 107.5);
}
mirror()
{
   rotate(0)
   {
      feet(1.18*r_t,40, 107.5);
   }
}
ramp(r_t, 0, 180);
ramp(0.804*r_t, 26.675, 0);
ramp(0.773*r_t, 53.75, 180);
ramp(0.926*r_t, 80.624, 0);


module shell()
{
   for (o = [0:s:360-s])
   {
      rotate(o)
      {
         translate([r_t, 0, 0])
         {
            rotate([a_1, 0, -a_2])
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
   fl = 1.1*rf;
   for (o = [0:15:180])
   {
      rotate(o + ao)
      {
         translate([rf, 0, hl])
         {
            difference(){
               rotate([0, -40, 0])
               {
                  translate([0,0, fl/2])
                  {
                     cube([w, w, fl], center=true);
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
   translate([0,0,hl+fl])  // tweak
   {
      difference()
      {
         rotate_extrude()
         {
            translate([rf-fl,w/2,0]) //tweak
            {
               square([w, w], center=true);
            }
         }
         // halber zylinder abziehen
      }
   }
}
