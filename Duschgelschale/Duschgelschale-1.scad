// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
//Bathroom Shelf
//07.2015
//Lukas Nedorost

$fa=0.5; // default minimum facet angle
$fs=0.5; // default minimum facet size

difference()
{
   union()
   {
      plate();
      sides();
      front();
      bottom_lines();
      hook1();
      hook2();
   }
   translate([0,0,-1])
   {
      cylinder(r=6, h=20);
   }
}

//===========Modules=============
module plate()
{
   intersection()
   {
      translate([0,0,0])
      {
         cube([40,40,4]);
      }
      translate([0,0,0])
      {
         cylinder(r=40, h=4, center=true);
      }
   }
   difference()
   {
      intersection()
      {
         translate([0,0,0])
         {
            cube([60,60,4]);
         }
         cylinder(r=60, h=4, center=true);
      }
      intersection()
      {
         translate([0,0,-0.25])
            cube([50,50,4]);
         cylinder(r=50, h=4.5, center=true);
      }
   }
   difference(){
      intersection(){
         translate([0,0,0])
            cube([85,85,4]);
         cylinder(r=85, h=4, center=true);
      }
      intersection(){
         translate([0,0,-0.25])
            cube([70,70,4]);
         cylinder(r=70, h=4.5, center=true);
      }
   }
   difference(){
      intersection(){
         translate([0,0,0])
            cube([115,115,4]);
         cylinder(r=115, h=4, center=true);
      }
      intersection(){
         translate([0,0,-0.25])
            cube([95,95,4]);
         cylinder(r=95, h=4.5, center=true);
      }
   }
   difference(){
      intersection(){
         translate([0,0,0])
            cube([150,150,4]);
         cylinder(r=150, h=4, center=true);
      }
      intersection(){
         translate([0,0,-0.25])
            cube([125,125,4]);
         cylinder(r=125, h=4.5, center=true);
      }
   }
   intersection(){
      translate([0,0,0])
         cube([20,20,15]);
     cylinder(r=8, h=30, center=true);
   }
}
module bottom_lines()
{
   difference(){
      union(){
         translate([0,-5.4,0])
			rotate([0,0,22.5])
			cube([130,10,2]);
         translate([5.4,0,0])
			rotate([0,0,67.5])
			cube([130,10,2]);
      }
      translate([-4,-5,-0.1])
         cube([4,30,16]);
      translate([-2,-6,-0.1])
         cube([15,6,16]);
   }
}
module sides()
{
   difference(){
      union(){
         translate([-0.5,0,0])
            cube([2,150,15]);
         translate([-0.5,-0.5,0])
            cube([150.5,2,15]);
      }

   }
}
module front()
{
   difference(){
      intersection(){
         translate([0,0,0])
            cube([150,150,30]);
         cylinder(r=150, h=30, center=true);
      }
      intersection(){
         translate([0,0,-0.25])
            cube([148,148,30.5]);
         cylinder(r=148, h=30.5, center=true);
      }
   }
}
module hook1()
{
   union(){
      difference(){
         translate([0,0,7.5])
			rotate([0,90,67.5])
			cylinder(d=10,h=161, center=false);
         translate([-0.1,-0.1,7.5])
			rotate([0,90,67.5])
			cylinder(d=10.5,h=149, center=false);
      }
   }
   union(){
      translate([61.7,149,7.5])
         rotate([0,90,67.5])
         resize(newsize=[15,15,3]) sphere(d=15);
   }
}
module hook2()
{
   union(){
      difference(){
         translate([0,0,7.5])
			rotate([0,90,22.5])
			cylinder(d=10,h=161, center=false);
         translate([-0.1,-0.1,7.5])
			rotate([0,90,22.5])
			cylinder(d=10.5,h=149, center=false);
      }
   }
   union(){
      translate([149,61.7,7.5])
         rotate([0,90,22.5])
         resize(newsize=[15,15,3]) sphere(d=15);
   }

}
