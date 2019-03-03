// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// Buchse (bushing)
//
// © 2017 Roland Sieker <ospalh@gmail.com>
// Licence: CC-0 4.0


l = 10; // [5:1:15]
preview = false;

/* [Hidden] */


d_i = 3.5;
w = 2.4;
p = 2;


ms = 0.01;  // Muggeseggele

d_a = d_i + 2*w;
lg = l + d_a/2;

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
   translate([-d_a/2, -d_a/2,0])
   {
      cube([lg, d_a, p]);
   }
    translate([0,0,-ms])
    {
       cylinder(d=d_i, h=p+2*ms);
    }
}
