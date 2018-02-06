// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// Another ring coaster
//
// © 2017 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0


// Size of the coaster’s hole (mm)
inner_diameter = 40;  // [0:1:90]
// Size of the coaster as a whole (mm)
outer_diameter = 95;  // [20:1:100]
// Set this to “render” and click on “Create Thing” when done with the setup.
preview = 1; // [0:render, 1:preview]

module dummy()
{
   // My quick way to stop the customizer.
}

h = 1.2;
b = 0.8;
w = 1.2;
rg = 0.6+w;
r_i = inner_diameter/2;
r_o = outer_diameter/2;
tau = 2*PI;
g = 2*w;
step=5;
ends = 500;
too_many_rands = rands(0,360,501);


ms = 0.01;


dish();
stege();

module dish()
{
      if (r_i > 2*w)
      {
         difference()
         {
            union()
            {
               full_dish();
               cylinder(r=r_i+w, h=h+b, $fa=1);
            }
            translate([0,0,-ms])
            {
               cylinder(r=r_i, h=h+b+2*ms, $fa=1);
            }
         }
      }
      else
      {
         full_dish();
      }
}



module full_dish()
{
   difference()
   {
      cylinder(r=r_o, h=h+b, $fa=1);
      translate([0,0,b])
      {
         cylinder(r=r_o - w, h=h+ms, $fa=1);
      }
   }


}




module stege()
{
   difference()
   {
      intersection()
      {
         mega_stege();
         cylinder(r=r_o-rg,h=h+b+ms);
      }
      cylinder(r=r_i+rg,h=h+b+ms);

   }
}



module mega_stege()
{
   function rin(n) = (n-step) * (w+g)/tau;
   for (c = [step:step:ends])
   {
      echo(too_many_rands[c]);
      for (a = [0:360/c:360-0.001])
      {
         rotate(a+too_many_rands[c])
         {
            translate([-w/2, rin(c), b])
            {
               cube([w,(w+g)/tau*step,h]);
            }
         }
      }

   }

}

module old_bla()
{
for (a = [0:winkel:360-0.001])
{
   rotate(a)
   {
      translate([w/2, r_i+2*w, b])
      {
         cube([w,r_o-r_i-4*w ,h]);
      }
   }
}
}
