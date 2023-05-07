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

ph=1.0;
rw=2;

rh=18/2;
pl=40;
pw= 2*rh+2*w;



//
rbr=3;
wbr = 0.8;

ms=0.01;  // Muggaseggale

// When you change these, you’ll have to tweak the rings &c. below
r_t = rh+w;  // Top (after print) radius
a_1 = 15;  // Angle from vertical
a_2 = 20;  // Angle inwards
l = 100; // Length of a wire. The hight will be slightly less + the feet.

// Tweak this so the rings are in the right hight
hs = 0.955 * l;

s = 360 / c;


difference()
{
   union()
   {
      tower();
      rings();
      plate();
      brace();
   }
   translate([0,0, -ms])
   {
      cylinder(r=rh,h=ph+2*ms+1);
   }
   translate([0,0, ph-0.2])
   {
      os();
      des();
   }
   translate([0, 0, -6*w])
   {
      cylinder(r=20*r_t,h=6*w);
   }
}


module tower()
{
   shell(1);
   shell(-1);
}
module rings()
{
   // ring(0, r_t);  // plate instead
   ring(hs, 2.44*r_t);
}

module plate()
{

   cylinder(r=rh+rw,h=ph);
   translate([-rh-rw, 0, 0])
   {
      cube([2*rh+2*rw, pl+rh+rw, ph]);
   }
}

module brace()
{
   translate([0,rh, 0])
   {
      rotate([-90,0,0])
      {
         difference()
         {
            cylinder(r=rbr+wbr,h=pl+rw,$fn=20);
            translate([0,0, -ms])
            {
               cylinder(r=rbr,h=pl+rh+rw+2*ms,$fn=20);
            }
         }
     }
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
      rotate_extrude($fn = c)
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


module os()
{
   translate([7, 35,0])
      rotate([0,0,-90])
      linear_extrude(10)
   {
      text("OSP", font="Prisma", size=5.6, halign="center", valign="center");
   }
   translate([7, 20.7,0])
      rotate([0,0,-90])
      linear_extrude(10)
   {
      text("ALH", font="Prisma", size=5.6, halign="center", valign="center");
   }
}

module des()
{
   translate([-7, 30,0])
      rotate([0,0,-90])
   linear_extrude(10)
   {
      text("design", font="Neue Kabel", size=6, halign="center", valign="center");
   }
}
