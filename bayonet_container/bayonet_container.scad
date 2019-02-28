// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// Roehren mit Bajonettverschluss, um DM-Muenzen zu lagern.
//
// (c) 2018 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0
// Original:
// https://www.thingiverse.com/thing:56910
// (c) Walter Hsiao
// Licence: CC-BY-SA


// ... to preview. You will get all three when done. Print just one of the
part = "container"; // [container,lid]

// Set this to "render" and click on "Create Thing" when done with the setup.
preview = 1; // [0:render, 1:preview]

// Style of the container bottom, plain or with bayonette to stack them
stackable = 0;  // [0: no, 1: yes]

// minimum interior diameter of container
_insideDiameter = 17;  // [5:0.1:35]

// height of the container's interior space
_interiorHeight = 110;  // [5:0.1:200]

// the thinnest walls of the container will use this value
_minimumWallThickness = 1.2;

// horizontal thickness used for the top of the lid or bottom of the container
_topBottomThickness = 1.2;

// height of the lip between lid and container
_lipHeight = 3.0;

// how much the locking bayonets protrude (larger values may be needed for larger diameters)
_bayonetDepth = 0.6;

// gap to place between moving parts to adjust how tightly the pieces fit together
_partGap = 0.2;


/* [Hidden] */

// Done with the customizer

// *******************************************************
// Extra parameters. These can be changed reasonably safely.


_numberOfSides = 6;  // [3:1:12]

w = 1.8;  // Wall width
p = 1.2;  // Bottom, top plate height
c = 0.4;  // Clearance
angle = 60; // Overhangs much below 60 degrees are a problem for me


// the thinnest walls of the container will use this value
_minimumWallThickness = 1.2;

// horizontal thickness used for the top of the lid or bottom of the container
_topBottomThickness = 1.2;

// *******************************************************
// Some shortcuts. These shouldn't be changed

tau = 2 * PI;  // pi is still wrong. tau = circumference / r

xy_factor = 1/tan(angle);
// To get from a height to a horizontal width inclined correctly
z_factor = tan(angle);  // The other way around

// Override these to specify exterior dimensions instead of interior
// dimensions
outsideDiameter = _insideDiameter +
   2 * (_minimumWallThickness*2 + _partGap + _bayonetDepth);
baseHeight = _interiorHeight + _topBottomThickness - _lipHeight;
stackable_containerHeight = _interiorHeight + _topBottomThickness;
lidHeight = _topBottomThickness + _lipHeight + 2; // 2 mm extra for the bayonet
// No storage space in the lid. That's what "lid" means.
twistAngle = 60; // amount of twist to close the lid
bayonetAngle = 30; // angular size of the bayonets


some_distance = 2 * _insideDiameter;
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
   if (part == "container")
   {
      if (stackable)
      {
         short_stackable_container();
      }
      else
      {
         short_container();
      }
   }
   else if (part == "stackable container")
   {

   }
   else if (part == "lid")
   {
      short_lid();
   }
}


module preview_parts()
{
   short_container();
   translate([some_distance, 0, 0])
   {
      short_stackable_container();
   }
   translate([0, some_distance, 0])
   {
      short_lid();
   }
}

module stack_parts()
{
   // intersection() // N.B.: Use only two at a time
   {
      // Pick one
      // short_stackable_container();
      short_container();

      // Dto.
      // translate([0,0,stackable_containerHeight + _lipHeight+ 2*_bayonetDepth+ ms])
      translate([0,0,baseHeight + _lipHeight+ 2*_bayonetDepth+ ms])
      {
         rotate([0,180,0])
         {
            short_lid();
         }
      }
   }
}

// *******************************************************
// I'm being lazy and won't replace the signatures, but jus add these shortcuts.

module short_container()
{
   container(
      _style, outsideDiameter, baseHeight, _minimumWallThickness,
      _topBottomThickness, _lipHeight, _bayonetDepth, bayonetAngle, _partGap,
      _numberOfSides);
}


module short_stackable_container()
{
   stackable_container(
      _style, outsideDiameter, stackable_containerHeight, _minimumWallThickness,
      _topBottomThickness, _lipHeight, _bayonetDepth, bayonetAngle, _partGap,
      _numberOfSides, twistAngle);
}
module short_lid()
{
   lid(
      _style, outsideDiameter, lidHeight, _minimumWallThickness,
      _topBottomThickness, _lipHeight, _bayonetDepth, bayonetAngle,
      _numberOfSides, twistAngle);

}


// *******************************************************
// Code for the parts themselves


module makeStylizedCylinder(type, diameter, height, rounding, polygonSides)
{
   radius = diameter/2;
   if (type == "crown")
   {
      crownCylinder(polygonSides, radius, height, rounding);
   }
   else if (type == "flipped crown")
   {
      translate([0,0,height])
      {
         mirror([0,0,1])
         {
            crownCylinder(polygonSides, radius, height, rounding);
         }
      }
   }
   else if (type == "polygon")
   {
      polyCylinder(polygonSides, radius, height, rounding);
   }
   else
   {
      roundCylinder(radius, height, rounding);
   }
}

module thread(r1, r2, angle, height, yoffset, rotation, chamfer=0, r3=0, r4=0)
{
   for(a=[0,120,240])
   {
      rotate([0,0,a + rotation])
      {
         translate([0,0,yoffset])
         {
            hull()
            {
               smallArc(r1, r2, angle, height);
               if (chamfer != 0)
               {
                  translate([0,0,chamfer])
                  {
                     smallArc(r3, r4, angle, height);
                  }
               }
            }
         }
      }
   }
}

module container(
   style, diameter, height, wall, base, lipHeight, bayonetDepth, bayonetAngle, partGap, sides)
{
   height = max(height, base+lipHeight);
   radius = diameter/2;
   innerRadius = radius - wall*2 - bayonetDepth - partGap;
   fullHeight = height + lipHeight;
   rounding = 1.0;
   chamfer = bayonetDepth;
   bayonetHeight = (lipHeight-chamfer)/2;
   eps = 0.1;

   difference()
   {
      union()
      {
         // body
         if (style == "tapered")
         {
            taperedCylinder(radius, innerRadius+wall, height, rounding);
         }
         else
         {
            makeStylizedCylinder(style, diameter, height, rounding, sides);
         }

         // lip
         translate([0,0,rounding+eps])
         {
            cylinder(r=innerRadius+wall, h=fullHeight-rounding-eps);
         }

         // bayonet
         thread(
            innerRadius+wall-eps, innerRadius+wall+bayonetDepth, bayonetAngle,
            bayonetHeight, fullHeight - bayonetHeight/2, 0, -chamfer,
            innerRadius, innerRadius+wall);
      }

      // inner cutout
      translate([0,0,base])
      {
         cylinder(r=innerRadius, h=fullHeight);
         if (style == "round thin")
         {
            hull()
            {
               cylinder(r=radius-wall, h=height-base*2 - (radius-innerRadius));
               cylinder(r=innerRadius, h=height-base*2);
            }
         }
      }
   }
}



module lid(
   style, diameter, height, wall, base, lipHeight, bayonetDepth, bayonetAngle,
   sides, twistAngle)
{
   height = max(height, base+lipHeight);
   bayonetAngle = bayonetAngle+2;
   radius = diameter/2;
   innerRadius = radius - wall - bayonetDepth;
   rounding = 1.0;
   chamfer = bayonetDepth;
   bayonetHeight = (lipHeight-chamfer)/2;
   eps = 0.1;

   difference()
   {
      // body (round, hex, knurled)
      if (style == "tapered" || style == "thin")
      {
         taperedCylinder(radius, innerRadius+wall, height, rounding);
      }
      else
      {
         makeStylizedCylinder(style, diameter, height, rounding, sides);
      }

      // inner cutout
      translate([0,0,base])
      {
         cylinder(r=innerRadius, h=height+eps);
         if (style == "round thin")
         {
            hull()
            {
               cylinder(
                  r=radius-wall, h=height-lipHeight-base*2 - (radius-innerRadius));
               cylinder(r=innerRadius, h=height-lipHeight-base*2);
            }
         }
      }
      // bayonet
      thread(
         innerRadius-eps, innerRadius+bayonetDepth, bayonetAngle,
         lipHeight + eps, height - lipHeight/2 + eps/2,
         twistAngle + bayonetAngle);

      // bayonet
      thread(
         innerRadius-eps, innerRadius+bayonetDepth, bayonetAngle+twistAngle,
         bayonetHeight + eps, height - (lipHeight - bayonetHeight/2) + eps/2,
         twistAngle + bayonetAngle, chamfer, innerRadius-eps, innerRadius);
   }
}

module stackable_container(
   style, diameter, height, wall, base, lipHeight, bayonetDepth, bayonetAngle,
   partGap, sides, twistAngle)
{
   height = max(height, base+lipHeight);
   radius = diameter/2;
   innerRadius = radius - wall*2 - bayonetDepth - partGap;
   middleRadius = radius - wall - bayonetDepth;
   wallThickness = radius - innerRadius;
   fullHeight = height + lipHeight;
   rounding = 0;
   topBayonetAngle = bayonetAngle+2;
   chamfer = bayonetDepth;
   bayonetHeight = (lipHeight-chamfer)/2;
   eps = 0.1;

   difference()
   {
      union()
      {
         // lip
         cylinder(r=innerRadius+wall, h=fullHeight);

         // body
         translate([0,0,lipHeight])
         {
            makeStylizedCylinder(style, diameter, height, rounding, sides);
         }
         // bayonet
         thread(
            innerRadius+wall-eps, innerRadius+wall+bayonetDepth, bayonetAngle,
            bayonetHeight, bayonetHeight/2, 0, chamfer, innerRadius,
            innerRadius+wall);
      }

      // inner cutout
      translate([0,0,base])
      {
         cylinder(r=innerRadius, h=fullHeight);
      }
      translate([0,0,lipHeight+max(wall,base)])
      {
         cylinder(r=middleRadius, h=fullHeight);
      }
      if (style == "round thin")
      {
         // assign(cutHeight = height-lipHeight-base*2 - wallThickness*2) {
         cutHeight = height-lipHeight-base*2 - wallThickness*2;
         {
            if (cutHeight > 0)
            {
               translate([0,0,lipHeight+base])
               {
                  hull()
                  {
                     translate([0,0,wallThickness])
                     {
                        cylinder(r=radius-wall, h=cutHeight);
                     }
                  cylinder(r=innerRadius, h=cutHeight + wallThickness*2);
                  }
               }
            }
         }
      }

      // thread cutout
      translate([0,0,fullHeight-lipHeight-partGap])
      {
         cylinder(r=middleRadius, h=lipHeight+partGap+eps);
      }

      // top thread
      thread(
         middleRadius-eps, middleRadius+bayonetDepth, topBayonetAngle,
         lipHeight+eps, fullHeight - lipHeight/2 + eps/2,
         twistAngle + topBayonetAngle);


      // top thread
      thread(
         middleRadius-eps, middleRadius+bayonetDepth,
         topBayonetAngle+twistAngle, bayonetHeight + eps,
         fullHeight - lipHeight + bayonetHeight/2 + eps/2,
         twistAngle + topBayonetAngle, chamfer, middleRadius-eps, middleRadius);
   }
}

////////////// Utility Functions ///////////////////

// only works from [0 to 180] degrees, runs clockwise from 12 o'clock
module smallArc(radius0, radius1, angle, depth)
{
   thickness = radius1 - radius0;
   eps = 0.01;

   union()
   {
      difference()
      {
         // full arc
         cylinder(r=radius1, h=depth, center=true);
         cylinder(r=radius0, h=depth+2*eps, center=true);

         for(z=[0, 180 - angle])
         {
            rotate([0,0,z])
            {
               translate([-radius1,0,0])
               {
                  cube(size = [radius1*2, radius1*2, depth+eps], center=true);
               }
            }
         }
      }
   }
}

module torus(r1, r2)
{
   rotate_extrude(convexity=4)
   {
      translate([r1, 0, 0])
      {
         circle(r = r2);
      }
   }
}

module roundCylinder(radius, height, rounding)
{
   if (rounding == 0)
   {
      cylinder(r=radius, h=height);
   }
   else
   {
      hull()
      {
         translate([0,0,height-rounding])
         {
            cylinder(r=radius, h=rounding);
         }
         translate([0,0,rounding])
         {
            torus(radius-rounding, rounding);
         }
      }
   }
}

module taperedCylinder(radius1, radius2, height, rounding)
{
   eps = 0.1;
   hull()
   {
      translate([0,0,height-eps])
      {
         cylinder(r=radius1, h=eps);
      }

      if (rounding == 0)
      {
         cylinder(r=radius2, h=eps);
      }
      else
      {
         translate([0,0,rounding])
         {
            torus(radius2-rounding, rounding);
         }
      }
   }
}

module crownCylinder(sides, radius, height, rounding)
{
   eps = 0.1;
   angle = 360/sides;
   hull()
   {
      translate([0,0,height-eps])
      {
         cylinder(r=radius, h=eps);
      }
      translate([0,0,rounding])
      {
         hull()
         {
            for (a=[0:angle:360])
            {
               rotate([0,0,a])
               {
                  translate([0,(radius-rounding) / cos(angle/2),0])
                  {
                     if (rounding == 0)
                     {
                        cylinder(r=1, h=eps);
                     }
                     else
                     {
                        sphere(r=rounding, $fn=30);
                     }
                  }
               }
            }
         }
      }
   }
}

module polyCylinder(sides, radius, height, rounding)
{
   angle = 360/sides;
   if (rounding == 0)
   {
      hull()
      {
         for (a=[0:angle:360])
         {
            rotate([0,0,a])
            {
               translate([0,(radius - rounding)/cos(angle/2),0])
               {
                  cylinder(r=1, h=height, $fn=30);
               }
            }
         }
      }
   }
   else
   {
      hull()
      {
         translate([0,0,height-rounding])
         {
            hull()
            {
               for (a=[0:angle:360])
               {
                  rotate([0,0,a])
                  {
                     translate([0,(radius - rounding)/cos(angle/2),0])
                     {
                        cylinder(r=rounding, h=rounding, $fn=30);
                     }
                  }
               }
            }
         }
         translate([0,0,rounding])
         {
            hull()
            {
               for (a=[0:angle:360])
               {
                  rotate([0,0,a])
                  {
                     translate([0,(radius - rounding) / cos(angle/2),0])
                     {
                        sphere(r=rounding, $fn=30);
                     }
                  }
               }
            }
         }
      }
   }
}
