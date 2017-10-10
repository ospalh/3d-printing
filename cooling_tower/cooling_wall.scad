// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
//
//
// © 2017 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0

h_top=150;
h_bottom = 10;




cylinder(r=5, h=0.2);
cube([0.4,0.4,h_top]);
translate([100,0,0])
{
   cylinder(r=5, h=0.2);
   cube([0.4,0.4,h_top]);
}
translate([0,0,h_bottom])
{
   cube([100, 0.4, h_top-h_bottom]);
}
