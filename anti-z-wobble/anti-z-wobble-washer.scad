// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// Buchse für M3, grob, 10 mm
//
// © 2017 Roland Sieker <ospalh@gmail.com>
// Licence: CC-0 4.0

d_i = 8.2;
r_i = d_i/2;
h = 0.6;
d_o = 17;
r_o = d_o/2;
ms = 0.1;  // Muggeseggele

$fn=90;

difference()
{
    cylinder(r=r_o, h=h);
    translate([0,0,-ms])
    {
        cylinder(r=r_i, h=h+2*ms);
    }
}
