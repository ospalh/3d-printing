// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// correctly sized simple shape to stack four picture 135 type film strips
//
// (c) 2018 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0


// ... to preview. You will get all parts when you click "Create Thing".
part = "rightstack"; // [stack: Stapler, lid: Deckel, leftstack, rightstack, leftlid, rightlid]

// Set this to "render" and click on "Create Thing" when done with the setup.
preview = 1; // [0:render, 1:preview]
// not needed

l1 = 200;
ex = 3;
num = 1;
lld = l1*num;
ll = lld + ex;
ey = 1;
w1 = 61.4;
wst = w1+ey; // 9.2 mm + clearance
wld = w1-ey; // Make it fit between the plates without problems
h = 80; // I have a lot of film strips i want to stack

w = 1.2;  // Wall width

epl = 15;
spl = 10;
spo = 20;
spsp = ll/4;

hl = 30;
hw = 10;

jl = 3;
rand = 5;

/* [Hidden] */

// Done with the customizer

// *******************************************************
// Extra parameters. These can be changed reasonably safely.



p = 1.8;  // Bottom, top plate height
c = 0.6;  // Clearance
angle = 60; // Overhangs much below 60 degrees are a problem for me

// *******************************************************
// Some shortcuts. These shouldn't be changed

tau = 2 * PI;  // pi is still wrong. tau = circumference / r

xy_factor = 1/tan(angle);
// To get from a height to a horizontal width inclined correctly
z_factor = tan(angle);  // The other way around

he = h + 2*p;
spo2 = ll/2 - spo - spl;

some_distance = 50;
ms = 0.01;  // Muggeseggele.

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

// *******************************************************
// End setup



// *******************************************************
// Generate the parts

print_part();
// preview_parts();
// stack_parts();
// left_stack();
// right_stack();

module print_part()
{
   if ("stack" == part)
   {
      stack();
   }
   if ("leftstack" == part)
   {
      left_stack();
   }
   if ("rightstack" == part)
   {
      right_stack();
   }
   if ("lid" == part)
   {
      lid();
   }
   if ("leftlid" == part)
   {
      left_lid();
   }
   if ("rightlid" == part)
   {
      right_lid();
   }
}

module preview_parts()
{
   stack();
   translate([0, some_distance, 0])
   {
      lid();
   }
   translate([-2*jl, 2*some_distance, 0])
   {
      left_stack();
   }
   translate([+2*jl, some_distance, 0])
   {
      right_stack();
   }
   translate([-2*jl, 3*some_distance, 0])
   {
      left_lid();
   }
   translate([+2*jl, 3*some_distance, 0])
   {
      right_lid();
   }
}

module stack_parts()
{
   // intersection()
   {
      color("yellow")
      {
         stack();
      }
      translate([0,0, 3*p])
      {
         color("red")
         {
            lid();
         }
      }
   }
}

// *******************************************************
// Code for the parts themselves

module stack()
{
   translate([0,0,p/2])
   {
      cube([ll, wst, p], center=true);
   }
   plates();
   h_cube();
   mirror()
   {
      h_cube();
   }
   module h_cube()
   {
      translate([ll/2-ms-hw/2, 0, p/2])
      {
         cube([hw, hl, p], center=true);
      }

   }
}

module left_stack()
{
   difference()
   {
      intersection(convexity=10)
      {
         stack();
         left_joint(c/2);
      }
      translate([-ll/4 ,0, 0])
      {
         cube([ll/2-2*rand - jl, wst-2*rand, h], center=true);
      }
   }
}

module right_stack()
{
   difference(convexity=10)
   {
      stack();
      left_joint(-c/2);
      translate([ll/4 ,0, 0])
      {
         cube([ll/2-2*rand - jl, wst-2*rand, h], center=true);
      }
   }
}

module lid()
{
   translate([0,0,p/2])
   {
      cube([lld, wld, p], center=true);
   }
}




module left_lid()
{
   intersection()
   {
      lid();
      left_joint(c/2);
   }
}

module right_lid()
{
   difference()
   {
      lid();
      left_joint(-c/2);
   }
}


module left_joint(jc)
{
   translate([0, 0, -h])
   {
      linear_extrude(3*h)
      {
         polygon(ljp);
      }
   }
   ljp = [
      [-jl-jc, 2*jl+jc],
      [0, jl+jc],
      [0, ll],
      [-ll, ll],
      [-ll, -ll],
      [0, -ll],
      [0, -jl-jc],
      [-jl-jc, -2*jl-jc],
      [-jl-jc, 2*jl+jc]
      ];
}

module plates()
{
   end_plate();
   side_plate(0);
   side_plate(spsp);
   // side_plate(2*spsp);
   rotate(180)
   {
      side_plate(0);
      side_plate(spsp);
      // side_plate(2*spsp);
   }
   mirror()
   {
      end_plate();
      side_plate(0);
      side_plate(spsp);
      // side_plate(2*spsp);
      rotate(180)
      {
         side_plate(0);
         side_plate(spsp);
         // side_plate(2*spsp);
      }
   }
}

module end_plate()
{
   translate([ll/2-ms , -epl/4,0])
   {
      cube([w, epl/2, he]);
   }
}

module side_plate(xo)
{
   translate([spo2-xo, wst/2-ms,0])
   {
      cube([spl, w, he]);
   }
}
