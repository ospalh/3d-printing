// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// Hook for the line of IKEA window blinds.
//
// © 2017–2024  Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0

b_width = 25;
arm_length = 35;
arm_hight = 3;
gap_hight = 19;
ms=0.01;
translate([-b_width/2, 0, 0])
{
   // Base
   cube([b_width, arm_length, arm_hight]);
   translate ([0, 0, arm_hight -ms])
   cube([b_width, arm_hight, gap_hight]);
}
