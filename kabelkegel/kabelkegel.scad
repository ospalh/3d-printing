// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// Cable cone
//
// © 2017 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0

ru = 18/2;
/* ro = 4.3/2; */
ro = 4.6/2;

h = 25;

ccr = 1;
cch = 8;
ccf = 0.8;
ccof = 0.35;

wf = 1.2;
ms = 0.01;

translate([-2.5, 0, 0])
{
   hcl();
}
translate([2.5, 0, 0])
{
   rotate(180)
   {
      hcr();
   }
}

module hcl()
{
   hc();
   translate([ccr*ccf, ro+ccof*(ru-ro), 0])
   {
      cylinder(r=ccr, h=cch, $fn=45);
   }
   translate([ccr*ccf, -ro-ccof*(ru-ro), 0])
   {
      cylinder(r=ccr, h=cch, $fn=45);
   }
}

module hcr()
{
   difference()
   {
      hc();
      translate([-ccr*ccf, ro+ccof*(ru-ro), -ms])
      {
         cylinder(r=ccr*wf, h=cch*wf+ms, $fn=45);
      }
      translate([-ccr*ccf, -ro-ccof*(ru-ro), -ms])
      {
         cylinder(r=ccr*wf, h=cch*wf+ms, $fn=45);
      }
   }
}

module hc()
{
   difference()
   {
      cylinder(r1=ru, h=h, r2=ro, $fn=45);
      translate([0, -ru-ms, -ms])
      {
         cube([ru+ms, 2*ru+2*ms, h+2*ms]);
      }
      translate([0,0,-ms])
      cylinder(r=ro, h=h+2*ms, $fn=45);
   }
}
