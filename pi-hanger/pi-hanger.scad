// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// Minimalist Frame to hang a Raspberry Pi on to one M3 screw.
//
// © 2017 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0


hd = 2.6; // Hole diameter, so that the screws acts thread cutting
pd = 2.5; // Post diameter. Fix so it works with your printer tolerances
xd = 49;  // Distance between the hole centers in one direction
yd = 58;  //  Distance between the hole centers in the other direction
yeb = 23.5;  // Extra board dimension
xo = 2;  // Offset of the hanger hole.
// My acrylic frame had an almost convenient hole. It was offset from
// another part of the frame by 2 mm too little for this thing to by
// symmetrical.
posts = true;  // Posts to clip the Pi on or screw holes (false)
spr = 3;  // Screw post radius. How big a cylinder to put the screws in
pbr = 2;  // Similar for the posts
aw = 2;  // Arm width
ah = 2;  // Arm hight
sph = 5;  // Hight of the screw posts
pbh = 5;  // Similar for the post bases
ph = 5;  // Post hight. Needs to be higher than the PI PCB
ms = 0.01;  // Muggeseggele. To make the diferences render nicer in preview
clear = -3.5;  // Clearnace distance

$fs=0.1;


y1 = -1 * (yeb + spr + clear);
y2 = y1 - yd;

difference()
{
   union()
   {
      pposts_or_bases();
      arms();
   }
   nposts_or_bases();
}


module pposts_or_bases()
{
   translate([xo, 0, 0])
   {
      pscrew_post();
   }
   translate([-xd/2, y1, 0])
   {
      ppost_or_base();
   }
   translate([-xd/2, y2, 0])
   {
      ppost_or_base();
   }
   translate([xd/2, y1, 0])
   {
      ppost_or_base();
   }
   translate([xd/2, y2, 0])
   {
      ppost_or_base();
   }
}
module nposts_or_bases()
{
   translate([xo, 0, 0])
   {
      nscrew_post();
   }
   translate([-xd/2, y1, 0])
   {
      npost_or_base();
   }
   translate([-xd/2, y2, 0])
   {
      npost_or_base();
   }
   translate([xd/2, y1, 0])
   {
      npost_or_base();
   }
   translate([xd/2, y2, 0])
   {
      npost_or_base();
   }
}


module ppost_or_base()
{
   // Positiv space of the hole or post
   if (posts)
   {
      ppost_base();
   }
   else
   {
      pscrew_post();
   }
}
module npost_or_base()
{
   // Negative space of the hole or post. That is, the swrew hole
   if (posts)
   {
      npost_base();
   }
   else
   {
      nscrew_post();
   }
}
module pscrew_post()
{
   cylinder(r=spr, h=sph);
}
module nscrew_post()
{
   translate([0, 0, -ms])
   {
      cylinder(r=hd/2, h=sph+2*ms);
   }
}
module ppost_base()
{
   cylinder(r=pbr, h=pbh);
   cylinder(r=pd/2, h=pbh+ph);
}
module npost_base()
{
   // The post base is cherful. That is, all positive.
}

module arms()
{
   xl = xd/2 + xo;
   xr = xo - xd/2 ;

   // The math
   // The lengths …
   l1l = sqrt(y1*y1+xl*xl);
   r1l = sqrt(y1*y1+xr*xr);
   l2l = sqrt(y2*y2+xl*xl);
   r2l = sqrt(y2*y2+xr*xr);
   // …and the angles
   l1a = atan(xl/y1);
   r1a = atan(xr/y1);
   l2a = atan(xl/y2);
   r2a = atan(xr/y2);

   translate([0, 0, ah/2])
   {
      translate([xo, 0, 0])
      {
         // The hanger arms
         rotate(l1a)
         {
            translate([0, -l1l/2, 0])
            {
               cube([aw, l1l, ah], center=true);
            }
         }
         rotate(r1a)
         {
            translate([0, -r1l/2, 0])
            {
               cube([aw, r1l, ah], center=true);
            }
         }
         rotate(l2a)
         {
            translate([0, -l2l/2, 0])
            {
               cube([aw, l2l, ah], center=true);
            }
         }
         rotate(r2a)
         {
            translate([0, -r2l/2, 0])
            {
               cube([aw, r2l, ah], center=true);
            }
         }
      }
      // And the cross beams
      translate([0, y1, 0])
      {
         cube([xd, aw, ah], center=true);
      }
      translate([0, y2, 0])
      {
         cube([xd, aw, ah], center=true);
      }
   }
}
