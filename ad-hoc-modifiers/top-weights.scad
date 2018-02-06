// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// NN
//
// © 2017 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0


translate([30, 30, 0])
{
for (o=[90:120:360])
{
    rotate(o)
    {
        translate([0,24,0])
        {
            cube([36,14,30], center=true);
        }

    }
}
}
