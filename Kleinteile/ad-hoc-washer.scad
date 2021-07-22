// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// Buchsen oder Unterlegscheiben, nach Bedarf
//
// (c) 2017 Roland Sieker <ospalh@gmail.com>
// Licence: CC-0 4.0

d_i = 13;
r_i = d_i/2;
h = 2;
d_o = 25.7;
r_o = d_o/2;
ms = 0.01;  // Muggeseggele


preview = 0;

// fn for differently sized objects and fs, fa; all for preview or rendering.
pna = 40;
pnb = 15;
pa = 5;
ps = 1;
rna = 180;
rnb = 30;
ra = 1;
rs = 0.1;
function na() = (preview) ? pna : rna;
function nb() = (preview) ? pnb : rnb;
$fs = (preview) ? ps : rs;
$fa = (preview) ? pa : ra;


difference()
{
    cylinder(r=r_o, h=h);
    translate([0,0,-ms])
    {
        cylinder(r=r_i, h=h+2*ms);
    }
}
