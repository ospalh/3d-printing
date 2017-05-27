// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// Cable cone
//
// © 2017 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0

ru = 18/2;
/* ro = 4.3/2; */
ro = 5/2;

h = 25;

ccr = 1.5;
ccr_o = 0.6;
cch = 6;
ccf = 0.4;
ccof = 0.35;

wf = 1.1;
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
      rotate(180)
      {
         cylinder(r1=ccr, r2=ccr_o, h=cch, $fn=3);
      }
   }
   translate([ccr*ccf, -ro-ccof*(ru-ro), 0])
   {
      rotate(180)
      {
         cylinder(r1=ccr, r2=ccr_o, h=cch, $fn=3);
      }
   }
}

module hcr()
{
   difference()
   {
      hc();
      translate([-ccr*ccf, ro+ccof*(ru-ro), -ms])
      {
         cylinder(r=ccr*wf, h=cch*wf+ms, $fn=3);
      }
      translate([-ccr*ccf, -ro-ccof*(ru-ro), -ms])
      {
         cylinder(r=ccr*wf, h=cch*wf+ms, $fn=3);
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
