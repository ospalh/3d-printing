// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// A customizable GEB-style logo cube
//
// © 2018 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0


// Three letters
letters = "WWW"; //

// Pick one of the Google fonts.
font = "Praxis LT";


/* [Hidden] */

// Done with the customizer

size = 40;


// *******************************************************
// End setup



// *******************************************************
// Generate the parts

tricube();


// *******************************************************
// Code for the parts themselves

module tricube()
{
   // intersection()
   {
      letter(letters[0]);
      translate([0,size/2,size/2])
      {
         rotate([90,0,0])
         {
            letter(letters[1]);
         }
      }
      translate([-size/2,0,size/2])
      {
         rotate([0,90,0])
         {
            letter(letters[2]);
         }
      }

   }
}




module letter(c)
{
   linear_extrude(size)
   {
      text(c, font=font, size=size, halign="center", valign="center");
   }
}
