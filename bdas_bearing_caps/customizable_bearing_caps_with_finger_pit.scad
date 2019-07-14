// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// Comfy spinner (bearing) caps with falsework
//
// Copyright 2017-- 2018 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0
// Remix of bda's "Customizable comfy spinner caps. Cap for any bearing.", https://www.thingiverse.com/thing:2319653


// Inner (shaft) diameter of the bearing. (Sizes are in mm)
d_in   = 5;  // [5:0.1:30]
// Diameter of the cap. Match this to the bearing outer diameter, with or without gap
d_cap  = 9.5;  // [5:0.1:40]
// Thickness of the bearing. The cap shaft will be short enough to fit in two.
h_bearing = 5;  // [2:0.1:20]
// thickness of the top part of the cap
t_cap  = 2; // [1:0.1:5]

// Width of rim. Set to thickness of inner metal cylinder
w_rim  = 2.0;  // [0.4:0.1:5]
// Thickness of the rim. Enough so the outer part of the cap clears the outer part of the bearing
t_rim  = 0.6;  // [0.2:0.1:5]

// How deep the pit is. Experiment with this a bit
r_pit_sphere = 23; // [1:0.5:80]


//
number_of_caps   = 4; // [1:36]
// Create falsework and brim
falsework=1; // [1:Falsework and brim, 0: No falsework only cap]

// Set this to “render” and click on “Create Thing” when done with the setup.
preview = 1; // [0:render, 1:preview]

module dummy_mod()
{
   // Stop the thingiverse customizer
}

tau = 2 * PI;

// tolerance > 0 for snug fit
o     = -0.05;
// true for slot
slot  = true;

nozzle = 0.4;
layer  = 0.2;
t_nof = 3 * layer;  // no fillet for a bit
r_fillet = t_cap - t_nof;

stem_hight = 0.45;  // as part of bearing hight


per_per = 8;  // Period of how many nozzle sizes per support connector
per_mat = 2.5;  // How much of that is filled with material


h_stem = h_bearing * stem_hight;

r_in_e = d_in/2 + o;
r_cap = d_cap/2;

pit_depth   = 0.6*t_cap;

// $fn   = 70;
ms  = 0.01; // Muggeseggele


// fn for differently sized objects and fs, fa; all for preview or rendering.
pna = 40;
pnb = 15;
pa = 5;
ps = 1;
rna = 180;
rnb = 30;
ra = 2;
rs = 0.25;
function na() = (preview) ? pna : rna;
function nb() = (preview) ? pnb : rnb;
$fs = (preview) ? ps : rs;
$fa = (preview) ? pa : ra;


m     = ceil(sqrt(number_of_caps));
n     = ceil(number_of_caps/m);
lrc = n - ((n*m)-number_of_caps);



w_chamfer = 0.6; // chamfer width
w_slot = 0.6; // slot width
spacing = 2.5;  // Spacing
brim = 2.5;




many_caps();

module many_caps()
{
   if (m>1)
   {
   for(x=[0:m-2])
   {
      for(y=[0:n-1])
      {
         translate([x*(d_cap+spacing),y*(d_cap+spacing),0]) comfy_cap();
      }
   }
   }
   xl = m-1;
   for (yl=[0:lrc-1])
   {
      translate([xl*(d_cap+spacing),yl*(d_cap+spacing),0])
      {
         comfy_cap();
      }
   }

}


module comfy_cap()
{
   difference()
   {
      plain_cap();
      if(slot)
      {
         translate([-w_slot/2,-r_in_e-ms,-ms])
         {
            cube([w_slot,2*r_in_e+2*ms,h_stem+ms]);
         }
         translate([-r_in_e-ms,-w_slot/2,-ms])
         {
            cube([2*r_in_e+2*ms,w_slot,h_stem+ms]);
         }
      }
   }
   if(falsework)
   {
      falsework_(2*r_cap,h_stem+t_rim);
      if (r_cap > 8)
      {
         falsework_(r_cap + w_rim + r_in_e,h_stem+t_rim);
      }
      falsework_(2*r_in_e+2*w_rim,h_stem);
      difference()
      {
         cylinder(r=r_cap+brim,h=layer,$fn=30);
         translate([0,0,-ms])
         {
            cylinder(r=r_in_e+w_rim, h=layer+2*ms,$fn=30);
         }
      }
   }
}

module plain_cap()
{
   stem_poly = [
      [0, 0],
      [r_in_e-w_chamfer, 0],
      [r_in_e, w_chamfer],
      [r_in_e, h_stem],
      [r_in_e+w_rim, h_stem],
      [r_in_e+w_rim, h_stem+t_rim],
      [r_cap, h_stem+t_rim],
      [r_cap, h_stem+t_rim+t_nof],
      [0, h_stem+t_rim+t_nof],
      [0, 0]
      ];
   difference()
   {
      union()
      {
         rotate_extrude()
         {
            polygon(stem_poly);
         }
         translate([0, 0, h_stem+t_rim+t_nof])
         {
            difference()
            {
               union()
               {
                  cylinder(r=r_cap-r_fillet, h=r_fillet);
                  rotate_extrude()
                  {
                     translate([r_cap-r_fillet, 0])
                     {
                        circle(r=r_fillet);
                     }
                  }
               }
               translate([0, 0, -1.1*r_cap])
               {
               cylinder(r=1.1*r_cap,h=r_cap*1.1);
               }
            }
         }
      }
      translate([0, 0, r_pit_sphere+h_stem+t_rim+t_cap-pit_depth])
      {
         // sphere(r=r_pit_sphere,$fn=360);
         sphere(r=r_pit_sphere);
      }
   }
}

module falsework_(d,h)
{
   r = d/2;
   r_s = r - nozzle*1.4;
   c = r * tau;
   cons = floor(c / (per_per * nozzle));
   step = 360 / cons;

   difference()
   {
      cylinder(d=d, h=h-2*layer,$fn=30);
      translate([0,0,-ms])
      {
         cylinder(d=d-2*nozzle*1.1,h=h-2*layer+2*ms,$fn=30);
      }
   }
   for (a=[0:step:360])
   {
      rotate([0,0,-a])
      {
         translate([r_s, 0, h-2*layer])
         {
            cube([nozzle*1.4,nozzle*per_mat,2*layer]);
         }
      }
   }
}
