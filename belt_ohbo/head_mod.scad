// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// Modifier for the bottle opener
//
// © 2017 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0

//import("meshes/Flaschenöffner.stl");

h=13.4;
ms = 0.1;
w=10;

translate([-w,-w,-ms])
{
   cube([w+5+2*ms, 2*w+2*ms, h+2*ms]);
}
