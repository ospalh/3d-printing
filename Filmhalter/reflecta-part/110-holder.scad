// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// Film holder to scan 110 (pocket) film in a Reflecta ProScan 10T 35 mm
// film scanner
//
// © 2018 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-NC-SA 4.0
// Based on …
/*
 * Film Holder for Plustek OpticFilm scanners and 110 films.
 *
 * (C) 2016 Richard "Shred" Körber
 *
 * Project page on Thingiverse:
 *   https://www.thingiverse.com/thing:1328672
 *
 * Licensed under Creative Commons BY-NC-SA:
 *   https://creativecommons.org/licenses/by-nc-sa/3.0/
 */

// … to preview. You will get all parts when you click “Create Thing”.
part = "cover"; // [holder: film strip holder, cover: film strip cover]


// Also depends on your printer size!
numberOfWindows = 6;    // [1:20]

// Use struts to save some material?
saveMaterial = "false"; // [false:No, true:Yes]


// trick the customizer into ignoring the following variables...
module endOfParameters() {}



height = 5.75;  // Total height (Z)
innerHeight = 3;  // Height of inner frame (Z)
minkRadius = 2;  // Minkowski radius for outer frame

totalWidth = 62;  // Total width (Y)
filmWidth = 16;  // Film width (Y)
filmThickness = 0.75;  // Film thickness (Z)

windowLength = 20;  // Length of a single window (X)
windowOffset = 5;  // Offset of first window to right frame edge (X)
windowDistance = 25.4;  // Distance between windows (X)
windowGap = 0.4;  // Gap size on each side (Y)

notchSize = 5;  // Length (X) of transport notches (depth is half of it)
notchHeight = height;  // Height (Z) of notches

coverFrameSizeX = 15;  // Distance outer edge to cover edge (X)
coverFrameSizeY = 7;  // Distance outer edge to cover edge (Y)
coverGap = 0.3;  // Gap between outer and inner edges

strutsThickness = 4;  // Thickness of the save material struts

cutHeight = height + 2;
windowCount = numberOfWindows;
windowWidth = filmWidth - 2 * windowGap;
filmLength = windowCount * windowDistance - (windowDistance - windowLength) +
   2 * windowOffset;
totalLength = filmLength + 2 * coverFrameSizeX;
coverHeight = height - innerHeight;

// Set this to “render” and click on “Create Thing” when done with the setup.
preview = 1; // [0:render, 1:preview]

tau = 2 * PI;  // π is still wrong. τ = ⌀ ÷ r
angle=60;
xy_factor = 1/tan(angle);
// To get from a height to a horizontal width inclined correctly
z_factor = tan(angle);  // The other way around


some_distance = 10;
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

// print_part();
preview_parts();
// stack_parts();



module print_part()
{
   if ("holder" == part)
   {
      completeHolder();
   }
   if ("cover" == part)
   {
      completeCover();
   }
}

module preview_parts()
{

   completeHolder();
   translate([0, -some_distance, 0])
   {
      completeCover();
   }
}

module stack_parts()
{
   // intersection()
   {
      color("yellow")
      {
         completeHolder();
      }
      color("red")
      {
         translate([0, 0, innerHeight+ms])
         {
            rotate([180, 0, 0])
            {
               // Derotated
               completeCover();
            }
         }
      }
   }
}

// *******************************************************
// Code for the parts themselves




// uncomment to find out if the top cover fits into the holder
//






// Holder Base
module holder()
{
   translate([minkRadius, minkRadius, 0])
   {
      minkowski()
      {
         cube(
            [totalLength - minkRadius * 2, totalWidth- minkRadius * 2,
             height - 1]);
         cylinder(r=minkRadius, h=1);
      }
   }
}

// Cover Cutout
module coverCutout()
{
   translate([0, coverFrameSizeY, innerHeight])
   {
      cube([filmLength, totalWidth - coverFrameSizeY * 2, cutHeight]);
   }
}

// Triangles (for the struts)
module triangle(dim)
{
   polyhedron(
      points = [
         [0, 0, 0],
         [dim[0], 0, 0],
         [dim[0], dim[1], 0],
         [0, 0, dim[2]],
         [dim[0], 0, dim[2]],
         [dim[0], dim[1], dim[2]]
         ],
      faces = [
         [0, 1, 2], [3, 5, 4],
         [0, 3, 4, 1], [1, 4, 5, 2], [0, 2, 5, 3]

         ]
      );
}

// Circlular segment
module circlePart(dim)
{
   r = (4 * pow(dim[0], 2) + pow(dim[1], 2)) / (8 * dim[0]);
   translate([r - dim[0], dim[1] / 2, dim[2] / 2])
   {
      difference()
      {
         cylinder(h=dim[2], r=r, center=true);
         translate([dim[0], 0, -0.2])
         {
            cube([r*2, r*2, dim[2] + 0.5], center=true);
         }
      }
   }
}

// Draws a single scan window
module window(wHeight)
{
   chh = wHeight / 2;
   ihh = wHeight + 0.2;
   polyhedron(
      points = [
         [-chh, -chh, 0],
         [windowLength + chh, -chh, 0],
         [windowLength + chh, windowWidth + chh, 0],
         [-chh, windowWidth + chh, 0],
         [0, 0, ihh],
         [windowLength, 0, ihh],
         [windowLength, windowWidth, ihh],
         [0, windowWidth, ihh]
         ],
      faces = [
         [0, 4, 5, 1], [1, 5, 6, 2], [2, 6, 7, 3],
         [3, 7, 4, 0], [0, 1, 2, 3], [4, 7, 6, 5]
         ]
      );
}

// Draws all the windows
module windows(wHeight)
{
   for (i = [filmLength - windowLength - windowOffset : -windowDistance : 0])
   {
      translate([i, 0, -0.1])
      {
         window(wHeight);
      }
   }
}

// Draws a single notch
module notch()
{
   rotate([0, 0, 45]) translate([0, 0, (notchHeight / 2) - 0.1])
   {
      cube([notchSize, notchSize, notchHeight + 0.3], center=true);
   }
}

// Draws all the notches
module notches()
{
   for (i = [filmLength - windowLength - windowOffset : -windowDistance : 0])
   {
      translate([i + (windowWidth + windowOffset) / 2, 0, 0]) notch();
      translate([i + (windowWidth + windowOffset) / 2, totalWidth, 0]) notch();
   }
}

// Draws a cutout pattern to save material
module cutoutPattern(dim)
{
   tw = dim[0] / 4;
   to = strutsThickness / 2;
   for (j = [0 : tw : dim[0] - 1])
   {
      translate([j + to, 0, 0])
      {
         triangle([tw - to * 1.5, dim[1] - to, dim[2]]);
      }
      translate([j + tw - to, dim[1], 0])
      {
         rotate([0, 0, 180])
         {
            triangle([tw - to * 1.5, dim[1] - to, dim[2]]);
         }
      }
   }
}

// If saving material, draws a cutout pattern above and below the windows
module saveMaterialCutout(length, border=0)
{
   if (saveMaterial == "true")
   {
      smHeight = (totalWidth - coverFrameSizeY * 2 - filmWidth) / 2 -
         strutsThickness;

      translate([0, totalWidth - coverFrameSizeY - smHeight, -0.1])
      {
         cutoutPattern([length, smHeight - border, cutHeight]);
      }
      translate([0, coverFrameSizeY + border, -0.1])
      {
         cutoutPattern([length, smHeight - border, cutHeight]);
      }
   }
}

// Draws the cover plate (without cutouts)
module coverPlate()
{
   union()
   {
      translate([(totalLength - filmLength) / 2 + coverGap, 0, 0])
      {
         cube(
            [filmLength - coverGap * 2,
             totalWidth - coverFrameSizeY * 2 - coverGap * 2,
             coverHeight]);
      }

      translate(
         [0, (totalWidth - filmWidth - coverFrameSizeY * 2) / 2, 0])
      {
         cube(
            [coverFrameSizeX + coverGap * 4, filmWidth - coverGap * 2,
             coverHeight]);
         circlePart([5, filmWidth - coverGap * 2, coverHeight]);
      }
   }

}

// Draws the entire holder bottom
module completeHolder()
{
   difference()
   {
      holder();
      translate(
         [-0.1, (totalWidth - filmWidth) / 2, innerHeight - filmThickness])
      {
         cube([filmLength + coverFrameSizeX + 0.1, filmWidth, height]);
      }

      translate(
         [(totalLength - filmLength) / 2,
          (totalWidth - filmWidth) / 2 + windowGap, -filmThickness])
      {
         windows(innerHeight);
      }

      translate([(totalLength - filmLength) / 2, 0, 0])
      {
         coverCutout();
         notches();
         saveMaterialCutout(filmLength);
      }
   }
}

// Draws the entire holder top cover
module completeCover()
{
   rotate([180,0,0])
   {
      difference()
      {
         translate([0, coverFrameSizeY + coverGap, 0])
         {
            coverPlate();
         }

         translate(
            [(totalLength - filmLength) / 2,
             (totalWidth - filmWidth) / 2 + windowGap, 0])
         {
            windows(coverHeight);
         }

         translate([(totalLength - filmLength) / 2 + strutsThickness, 0, 0])
         {
            saveMaterialCutout(filmLength - strutsThickness * 2, strutsThickness);
         }
      }
   }
}
