// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// Testkörper für Drehkalenderzapfen
//
// © 2017 Roland Sieker <ospalh@gmail.com>
// Licence: CC-0 4.0

ri = 4.7;
ro = 8;
h = 7.5;
hb = 3;

echo(ri*10-40);
cylinder(r=ro, h=hb, $fn=ri*10-40);
cylinder(r=ri, h=hb+h, $fn=90);
