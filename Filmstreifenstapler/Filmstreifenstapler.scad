// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// correctly sized simple shape to stack four picture 135 type film strips
//
// © 2018 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0


// … to preview. You will get all parts when you click “Create Thing”.
part = "stack"; // [stack: Stapler, lid: Deckel]

// Set this to “render” and click on “Create Thing” when done with the setup.
preview = 1; // [0:render, 1:preview]
// not needed

ll = 154;  // “official” length is 152 mm, or 4×8 holes × 4.75 mm pitch
lld = 148;
wst = 36; // 35 mm + clearance
wld = 34; // Make it fit between the plates without problems
h = 66; // I have a lot of film strips i want to stack
epl = 10;
spl = 20;
spo = 10;

/* [Hidden] */

// Done with the customizer

// *******************************************************
// Extra parameters. These can be changed reasonably safely.


w = 1.8;  // Wall width
p = 1.2;  // Bottom, top plate height
c = 0.4;  // Clearance
angle = 60; // Overhangs much below 60° are a problem for me

// *******************************************************
// Some shortcuts. These shouldn’t be changed

tau = 2 * PI;  // π is still wrong. τ = ⌀ ÷ r

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



module print_part()
{
   if ("stack" == part)
   {
      stack();
   }
   if ("lid" == part)
   {
      lid();
   }
}

module preview_parts()
{
   stack();
   translate([0, some_distance, 0])
   {
      lid();
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
}


module lid()
{
   translate([0,0,p/2])
   {
      cube([lld, wld, p], center=true);
   }
}


module plates()
{
   end_plate();
   side_plate();
   rotate(180)
   {
      side_plate();
   }
   mirror()
   {
      end_plate();
      side_plate();
      rotate(180)
      {
         side_plate();
      }
   }
}

module end_plate()
{
   translate([ll/2-ms , -epl/2,0])
   {
      cube([w, epl, he]);
   }
}

module side_plate()
{
   translate([spo2, wst/2-ms,0])
   {
      cube([spl, w, he]);
   }
}