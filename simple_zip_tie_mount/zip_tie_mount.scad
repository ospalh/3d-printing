// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
// ****************************************************************************
// Customizable zip tie bike mount for smartphone holders
//
// Copyright 2018-2019 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0
//
// Original author: Peter Holzwarth
// Original thing: https://www.thingiverse.com/thing:3066652
// Original licence: CC-BY

/* [Standard] */

// Diameter of the handlebar
tubeDiameter= 33; // [15:0.5:50]

// Width of the mounting ring
width= 20;  // [15:0.5:50]

// Width of the cable ties
cableTiesWidth= 3;  // [1:0.25:10]

// Plate thickness. 6 mm is enough for stability, but add here to raise your fone
p_th = 6; // [6:1:20]

// Set to "Render" and click "Create Thing" when done with the setup
preview = 1;  // [1: Preview, 0: Render]




/* [Extra] */

// Height of a M3 nut + clearance
h_n = 2.8;  // [2.4:0.05:5]

// ring thickness
d_ring = 6;

// tie groove depth
zip_gap_1 = 1;

// tie gap
zip_gap_2 = 5;

/* [Hidden] */

r_t = tubeDiameter/2;
some_distance = 50;
ms=0.01;



// fn for differently sized objects and fs, fa; all for preview or rendering.
pna = 40;
pnb = 15;
pa = 5;
ps = 1;
rna = 180;
rnb = 30;
ra = 2;
rs = 0.25;
function na() = (preview) ? pna : rna;
function nb() = (preview) ? pnb : rnb;
$fs = (preview) ? ps : rs;
$fa = (preview) ? pa : ra;



zip_tie_mount();


module zip_tie_mount()
{
   mirror([0,0,1])
   {
      intersection()
      {
         translate([-10,0,-r_t-d_ring])
         {
            BikeMountUpper();
         }
         union()
         {
            translate([0,0,-(p_th)/2+ms])
            {
               cubeR([26+ms,26+ms,p_th+2*ms],2, true);
            }
            translate([0,0,-p_th/2-2.5])
            {
               cubeR([26+ms,26+ms,p_th+5],5, true);
            }
         }
      }
   }
}






module BikeMountUpper()
{

   difference()
   {
      union()
      {
         difference()
         {
            translate([0,0,d_ring - p_th + ms])
            {
               MountBase();
            }
            // space for screw bolts
            translate([width/2,0,tubeDiameter/2+6]) mirror([0,0,1]) Plate_rem();
         }
         translate([width/2,0,tubeDiameter/2+6]) mirror([0,0,1]) Plate();
      }
      translate([width/3-cableTiesWidth/2,0, -p_th + d_ring])
      {
         ring();
      }
      translate([width*2/3-cableTiesWidth/2,0, -p_th + d_ring])
      {
         ring();
      }
   }
}

// a half ring and side wings for the screws
module MountBase()
{
   rotate([0,90,0])
   {
      emptyWheel(tubeDiameter/2+d_ring, width,d_ring/2);
   }
}

module Plate()
{
   difference()
   {
      Plate_add();
      Plate_rem();
   }
}

// the plate
module Plate_add()
{
   translate([0,0,(p_th)/2]) cubeR([26,26,p_th],2, true);
}

// space for the screws and bolts
module Plate_rem()
{
   translate([0,0,-0.01]) fourScrews(16,16,3.5,p_th+0.02);
   translate([0,0,p_th-h_n])
   {
      fourScrews(16,16,6.5,p_th+10, 6);
   }
}

// ////////////////////////////////////////////////////////////////
// cube with rounded corners
module cubeR(dims, rnd=1, centerR= false)
{
   translate(centerR?[-dims[0]/2,-dims[1]/2,-dims[2]/2]:[])
   {
      hull()
      {
         translate([rnd,rnd,rnd]) sphere(r=rnd);
         translate([dims[0]-rnd,rnd,rnd]) sphere(r=rnd);
         translate([rnd,dims[1]-rnd,rnd]) sphere(r=rnd);
         translate([dims[0]-rnd,dims[1]-rnd,rnd]) sphere(r=rnd);

         translate([rnd,rnd,dims[2]-rnd]) sphere(r=rnd);
         translate([dims[0]-rnd,rnd,dims[2]-rnd]) sphere(r=rnd);
         translate([rnd,dims[1]-rnd,dims[2]-rnd]) sphere(r=rnd);
         translate([dims[0]-rnd,dims[1]-rnd,dims[2]-rnd]) sphere(r=rnd);
      }
   }
}

// four screw nuts without threads - good for metal screws
// x, y: distances of mid points
// d: screw diameter
// h: nut height
module fourScrews(x, y, d, h, fn=nb())
{
   translate([x/2,y/2,0]) cylinder(r=d/2,h=h,$fn=fn);
   translate([-x/2,y/2,0]) cylinder(r=d/2,h=h,$fn=fn);
   translate([x/2,-y/2,0]) cylinder(r=d/2,h=h,$fn=fn);
   translate([-x/2,-y/2,0]) cylinder(r=d/2,h=h,$fn=fn);
}

// ////////////////////////////////////////////////////////////////
// rounded button - lower part is a cylinder, upper part like a filled ring
// r= outer radius
// h= height
// rr= upper rounding
// buttonRound(20,10,2);
module buttonRound(r, h, rr)
{
   hull()
   {
      translate([0,0,h-rr]) bikeWheel(r, rr);
      cylinder(r=r,h=h-rr);
   }
}



// like a bike wheel
// bikeWheel(20,10,2);
module bikeWheel(wr, rr)
{
   translate([0,0,rr]) rotate_extrude(convexity= 2) translate([wr-rr, 0, 0]) circle(r=rr);
}

// like a car wheel
// wheel(20,10,2);
module wheel(wr, h, rr)
{
   hull()
   {
      translate([0,0,rr]) rotate_extrude(convexity= 2) translate([wr-rr, 0, 0]) circle(r=rr);
      translate([0,0,h-rr]) rotate_extrude(convexity= 2) translate([wr-rr, 0, 0]) circle(r=rr);
   }
}

// like an empty car wheel
// emptyWheel(20,10,2);
module emptyWheel(wr, h, rr)
{
   translate([0,0,rr]) rotate_extrude(convexity= 2) translate([wr-rr, 0, 0]) circle(r=rr);
   translate([0,0,rr]) difference()
   {
      cylinder(r=wr,h=h-2*rr);
      translate([0,0,-0.01]) cylinder(r=wr-2*rr,h=h);
   }
   translate([0,0,h-rr]) rotate_extrude(convexity= 2) translate([wr-rr, 0, 0]) circle(r=rr);
}

// simple screw model
// Screw(4, 10, 7, 6);
module Screw(m, h, th, fn= 50)
{
   cylinder(r= m/2, h= h);
   translate([0,0,th]) cylinder(r= m, h= h-th, $fn= fn);
}

// ring space to fix zip ties
// translate([-20,0,0]) ring();
module ring()
{
   r_ring = tubeDiameter/2+d_ring-zip_gap_1;
   rotate([0,90,0])
      difference()
   {
      cylinder(r= r_ring + zip_gap_2,h=cableTiesWidth);
      translate([0,0,-0.01])
         cylinder(r= r_ring,h=cableTiesWidth+0.02);
   }
}
