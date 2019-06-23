// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// Buchse fuer M3, grob, 10 mm
//
// (c) 2017 Roland Sieker <ospalh@gmail.com>
// Licence: CC-0 4.0

d_i = 8;
r_a = d_i/sqrt(3);
echo("r_a", r_a);
h = 4;
$fn=6;

cylinder(r=r_a, h=h);
