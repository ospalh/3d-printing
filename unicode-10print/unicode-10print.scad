// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// 10PRINT for OpenScad (for customizer, no title option)
//
// © 2016 Fernando Jerez
// © 2017 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA-NC 4.0


// preview[view:south, tilt:top]

// Number of horizontal cells
gridx = 36;  // [2,100]
// Number of vertical cells
gridy = 20; // [2,100]

/* [Hidden] */
random = rands(9585, 9586, 10000);
h = 5; // hight of 'stick'

font = "DejaVu Sans Mono:style=Book";
gridsize = h/sqrt(2);
tweak_x = 1.18;
tweak_y = 0.615;

color("Blue")
{
   translate([-0.5*gridsize,-0.5*gridsize,0.5])
   {
      cube([(2+gridx)*gridsize,(2+gridy)*gridsize,1],center=true);
   }
}

color("White")
{
   translate([-gridsize*gridx/2,-gridsize*gridy/2,1])
   {
      linear_extrude(1)
      {
         for(x = [0:gridx-1])
         {
            for(y = [0:gridy-1])
            {
               translate([x*gridsize,y*gridsize,0])
               {
                  scale([tweak_x, tweak_y])
                  {
                     text(
                        text=chr(round(random[x*(gridy-1)+y])), size=gridsize,
                        font=font, halign="center", valign="center");
                  }
               }
            }
         }
      }
   }
}
