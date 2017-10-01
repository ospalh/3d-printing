// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// Rudolf Koch’s reply to requests for free samples of his work, translated
// to English
//
// © 2017 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0


ms = 0.01;
// Muggeseggele (gnat’s bollocks, in Swabian about as harmless as the
// phrase shown)

schwabacher = "Alte Schwabacher:style=Regular";

//
breite = 54;
tiefe = 52.22;
xo = 0 + breite/2;
yo = -4.35 + tiefe/2;

rand = 5;
hw = 2;  // Halter weite
hh = 0.5;

// swabian_greatings(1); // unconnected
// positive_greating();
negative_greating();
//quick_greating();

module positive_greating()
{
   plate(1);
   translate([0,0,1])
   {
      swabian_greatings(1);
   }
}

module negative_greating()
{
   difference()
   {
      plate(2);
      translate([0,0,1])
      {
         swabian_greatings(1+ms);
      }
   }
}

module quick_greating()
{
   connectors();
   swabian_greatings(1+hh);
}



module swabian_greatings(h)
{
   linear_extrude(h)
   {
      translate([0, 16])
      {
         text("Up", font=schwabacher, size=32);
      }
      translate([0, 0])
      {
         text("yours!", font=schwabacher, size=16);
      }

   }
}


module plate(h)
{
   translate([xo,yo,h/2])
   {
      cube([breite+2*rand, tiefe+2*rand, h], center=true);
   }
}


module connectors()
{

   module wH(x, y, l)
   {
      // waagerechter Halter
      translate([x, y, hh/2])
      {
         cube([l, hw, hh], center=true);
      }
   }
   module sH(x, y, l)
   {
      // senkrechter Halter
      translate([x, y, hh/2])
      {
         cube([hw, l, hh], center=true);
      }
   }
   module dH(x, y, l)
   {
      // diagonaler Halter
      translate([x, y, hh/2])
      {
         rotate(-45)
         {
            cube([hw, l, hh], center=true);
         }
      }
   }
   module qH(x, y, l)
   {
      // diagonaler Halter (quer)
      translate([x, y, hh/2])
      {
         rotate(-45)
         {
            cube([l, hw, hh], center=true);
         }
      }
   }
   module xH(x, y, l, a)
   {
      // schräger Halter
      translate([x, y, hh/2])
      {
         rotate(a)
         {
            cube([l, hw, hh], center=true);
         }
      }
   }

}
