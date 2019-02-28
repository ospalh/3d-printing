// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// Quick square for calibration
//
// (c) 2017 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0


difference()
{
    cube([10,10,0.6], center=true);
    cube([8,8,0.601],center=true);
}
$fn=72;
difference()
{
    cylinder(r=1.2, h=0.6);
    translate([0, 0, -0.0005])
    {
        cylinder(r=0.6, h=0.601);
    }
}
