// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// Buchse (bushing)
//
// (c) 2017 Roland Sieker <ospalh@gmail.com>
// Licence: CC-0 4.0

d_i = 4.2;
d_a = 5;
h = 10;

preview = true;

ms = 0.1;  // Muggeseggele



pa = 5;
ps = 1;
ra = 1;
rs = 0.1;
function na() = (preview) ? pna : rna;
function nb() = (preview) ? pnb : rnb;
$fs = (preview) ? ps : rs;
$fa = (preview) ? pa : ra;



difference()
{
    cylinder(d=d_a, h=h);
    translate([0,0,-ms])
    {
        cylinder(d=d_i, h=h+2*ms);
    }
}
