// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// correctly sized simple shape to stack four picture 135 type film strips
//
// © 2018 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0


// … to preview. You will get all parts when you click “Create Thing”.
part = "lid"; // [stack: Stapler, lid: Deckel]

// Set this to “render” and click on “Create Thing” when done with the setup.
preview = 1; // [0:render, 1:preview]
// not needed

ll = 11*13+3;  //
lld = ll-3;
wst = 10; // 9.2 mm + clearance
wld = 9; // Make it fit between the plates without problems
h = 66; // I have a lot of film strips i want to stack

w = 1.8;  // Wall width

epl = wld + 2*w;
spl = 10;
spo = -w;
spsp = ll/4;


/* [Hidden] */

// Done with the customizer

// *******************************************************
// Extra parameters. These can be changed reasonably safely.



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
   side_plate(0);
   side_plate(spsp);
   side_plate(2*spsp);
   rotate(180)
   {
      side_plate(0);
      side_plate(spsp);
      side_plate(2*spsp);
   }
   mirror()
   {
      end_plate();
      side_plate(0);
      side_plate(spsp);
      side_plate(2*spsp);
      rotate(180)
      {
         side_plate(0);
         side_plate(spsp);
         side_plate(2*spsp);
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

module side_plate(xo)
{
   translate([spo2-xo, wst/2-ms,0])
   {
      cube([spl, w, he]);
   }
}