// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// Grab toy
//
// (c) 2018 E. Coiras as CC-BY
// (c) 2018 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0


// ... to preview. You will get all parts when you click "Create Thing".
part = "short grabber"; // [short grabber, long grabber, hinge test]


// Spacing between parts Make this a small as possible but not smaller. Try the hinge test to get the value for you
slack = 0.5; // [0.15:0.01:0.7]




REINFORCE_CORE = true; //add extra material to hinge cores
REINFORCE_SHOULDER = false; //add extra material to shoulders

// Set this to "render" and click on "Create Thing" when done with the setup.
preview = true; // [false:render, true:preview]



/* [Hidden] */

// Done with the customizer

// *******************************************************
// Extra parameters. These can be changed reasonably safely.

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

iota = 0.01; //a small quantity
some_distance = 120;

//font = "Arial Narrow:style=Bold";
font = "Liberation Sans:style=Bold";
text_size = 4.5;
texthight = 1.0;

// *******************************************************
// End setup



// *******************************************************
// Generate the parts




// print_part();
preview_parts();
// stack_parts();



module print_part()
{
   if ("short grabber" == part)
   {
      GrabToyPlusPlus4hinges();
   }
   if ("long grabber" == part)
   {
      GrabToyPlusPlus10hinges();
   }
   if ("hinge test" == part)
   {
      HingeSlackTest();
   }
}

module preview_parts()
{
   GrabToyPlusPlus4hinges();
   translate([some_distance, 0, 0])
   {
      GrabToyPlusPlus10hinges();
   }
   translate([0, some_distance, 0])
   {
      HingeSlackTest();
   }
}

// *******************************************************
// Code for the parts themselves



// Original comment/explanation:
/*********************************************************************

Grab Toy ++

Introduction:
-------------
Had lots of problems printing the amazing Scissor Snake family
(https://www.thingiverse.com/thing:1902131) with hinges fusing
together and some parts snapping. So I tried to design a simpler
hinge that could also be printed in place using OpenSCAD, where
I could play with different spacings between the moving parts.
Then I did the code for the rest of the toy, learning OpenSCAD
along the way. Very cool software!

Tips:
-----
Instead of printing the biggest grabtoy here and be disappointed
it fused together, you can first check which spacing works better
for your printer settings by printing the HingeSlackTest() model.

The default slack of 0.5 is a good starting point. The lowest I
managed when printing PLA at 0.2mm resolution with my Anycubic
I3+ at normal (i.e. fast) speed was 0.35, but only at very low
temperatures (190º) which results in poorer surface finish.

I found that robustness of the toys varied a lot depending on
the slicing software, with some not putting extra material in
thin regions that are structurally important (mostly the cores
and shoulders of the hinges). Playing around I realized that
some carefully placed thin slits forced the slicers to create
extra walls, thus reinforcing some key areas. Enable or disable
them by setting REINFORCE_CORE and REINFORCE_SHOULDER to true
or false.


NOTES:
------
- 07/JAN/2018: First version. E. Coiras.

*********************************************************************/



//hinge core parameters
cr0 = 3; //inner radius
cr1 = 7; //outer radius
ch = 12; //hight

//arm parameters
totalArmLength = 10;
shoulderLength = 2.5;

//handle parameters
wRing = 4;
hRing = ch;
rRing = 14;
armlhandle = 12;
ringAspectRatio = 4/3;
ringTilt = 30; //degrees
baseWidth = 40; //degrees

//teeth parameters
rTooth0 = 0.2; //tip width
rTooth1 = 1; //base width
hTooth = 3; //hight
wTooth = ch; //depth
nTeethUp = 6; //number of teeth for the upper jaw
nTeethLow = 5; //number of teeth for the lower jaw

//handle modules
module fingerHole(wh, hh, rh, sc, ang)
{
   rotate([0,0,-ang])
   {
      scale([1,sc,1])
      {
         rotate_extrude(convexity = 10)
         {
            translate([rh,0,0])
            {
               resize([wh,hh,iota])
               {
                  circle();
               }
            }
         }
      }
   }
}

module handleBase(wh, hh, rh, sc, ang, baseang)
{
   rotate([0,0,-ang])
      scale([1,sc,1])
      rotate([0,0,-baseang/2-90])
      rotate_extrude(angle = baseang, convexity = 10)
      translate([rh,0,0])
      resize([wh,hh,iota])
      circle();
}

module halfHandle(arml,ch,cr0,cr1,slack,wh, hh, rh, sc, ang, baseang)
{
   dx = cr1;
   union() {
      hull()
      {
         translate([rh+dx-wh/2,1.75*rh*sc + arml,0])
         {
            handleBase(wh,hh,rh,sc,ang,baseang);
         }
         translate([cr1/2+slack/2,cr1+arml,0])
            cube([cr1-slack,iota,ch], center = true);
      }
      translate([rh+dx-wh/2,1.75*rh*sc + arml,0])
      {
         fingerHole(wh,hh,rh,sc,ang);
      }
   }
}

//jaw modules
module tooth(r0,r1,h,w)
{
   hull()
   {
      translate([h/2,0,0]) cube([iota,2*r0,w], center = true);
      translate([-h/2,0,0]) cube([iota,2*r1,w], center = true);
   }
}

module teeth(r0,r1,h,w,n) {
   dy = 2*(r1 + r0);
   translate([0,-dy*(n-1)/2,0])
      for(k = [0:n-1])
      {
         translate([0,k*dy,0])
            tooth(r0,r1,h,w);
      }
}

module jaw(jl,r0,r1,h,w,n, cr1,ch,al,slack)
{
   union()
   {
      rotate([0,0,-45])
         translate([0,jl,0])
         teeth(r0,r1,h,w,n);
      hull()
      {
         rotate([0,0,-22.5])
            translate([-h/2,jl-n*(r0+r1)-(jl-al)/4,0])
            cube([iota,n*2*(r0+r1)/2,w],center = true);
         translate([cr1/2-slack,cr1+al,0]) cube([3*cr1/4,iota,ch], center = true);
      }
      hull()
      {
         rotate([0,0,-45])
            translate([-h/2,jl,0])
            cube([iota,n*2*(r0+r1),w],center = true);
         rotate([0,0,-22.5])
            translate([-h/2,jl-n*(r0+r1)-(jl-al)/4,0])
            cube([iota,n*2*(r0+r1)/2,w],center = true);
      }
   }
}

module jaws(jl,r0,r1,h,w,nupper,nlower, cr1,ch,al,slack)
{
   //rotate([0,0,-44.5]) //uncomment to check closed position
   jaw(jl,r0,r1,h,w,nupper, cr1,ch,al,slack);
   //rotate([0,0,44.5]) //uncomment to check closed position
   scale([1,-1,1])
      jaw(jl,r0,r1,h,w,nlower, cr1,ch,al,slack);
}

//hinge modules
module bottomShoulder(al,ch,cr0,cr1,slack)
{
   module bS()
   {
      union()
      {
         hull()
         {
            translate([cr1/2-slack/2,0,ch/4])
            {
               cylinder(ch/2,iota,cr1/2, center = true);
            }
            translate([cr1/2,2*cr1/3,0])
               translate([-(cr1-slack)/2,0,0])
               rotate([0,0,22.5])
               translate([cr1/2,0,0.2*ch])
               cube([cr1,iota,0.6*ch], center = true);
         }
         hull()
         {
            translate([cr1/2,cr1+al,0])
               cube([cr1-slack,iota,ch], center = true);
            translate([cr1/2,2*cr1/3,0])
               translate([-(cr1-slack)/2,0,0])
               rotate([0,0,22.5])
               translate([cr1/2,0,0.2*ch])
               cube([cr1,iota,0.6*ch], center = true);
         }
      }
   }

   if (REINFORCE_SHOULDER)
   {
      difference()
      {
         bS();
         translate([cr1/2-slack/2,(al+cr1)/2,ch/4])
            cube([slack/4,al+cr1+slack,2*ch],center=true);
      }
   }
   else
   {
      bS();
   }
}

module topShoulder(al,ch,cr0,cr1,slack)
{
   module tS()
   {
      union()
      {
         hull()
         {
            union()
            {
               translate([cr1/2-slack/2,0,ch/2])
                  cylinder(h = ch/4,iota,cr1/2, center = true);
               difference()
               {
                  translate([cr1/2-slack/2,0,ch/2])
                     sphere(cr1/2);
                  translate([cr1/2-slack/2,0,ch/4])
                     cube([cr1,cr1,cr1], center = true);
               }
            }
            translate([cr1/2,2*cr1/3,ch/8])
               translate([-(cr1-slack)/2,0,0])
               rotate([0,0,22.5])
               translate([cr1/2,0,ch/4+slack/4])
               cube([cr1,iota,0.6*ch], center = true);
         }
         hull()
         {
            translate([cr1/2,cr1+al,0])
               cube([cr1-slack,iota,ch], center = true);
            translate([cr1/2,2*cr1/3,ch/8])
               translate([-(cr1-slack)/2,0,0])
               rotate([0,0,22.5])
               translate([cr1/2,0,ch/4+slack/4])
               cube([cr1,iota,0.6*ch], center = true);
         }
      }
   }

   if (REINFORCE_SHOULDER)
   {
      difference()
      {
         tS();
         translate([cr1/2-slack/2,(al+cr1)/2,ch/4])
            cube([slack/4,al+cr1+slack,2*ch],center=true);
      }
   }
   else
   {
      tS();
   }
}

module endHingeBottom(al,ch,cr0,cr1,slack)
{
   difference()
   {
      union()
      {
         union()
         {
            translate([slack/2,0,0])
               scale([1,-1,-1])
               bottomShoulder(al,ch,cr0,cr1,slack);
         }
         cylinder(ch, cr1, cr0, center = true);
      }
      union()
      {
         translate([0,0,ch/6])
            cylinder(2*ch/3+iota, cr0+slack, cr1+slack, center = true);
         translate([0,0,-ch/3])
            cylinder(ch/3+iota, (cr0+cr1)/2+slack, cr0+slack, center = true);
      }
   }
}

module endHingeTop(al,ch,cr0,cr1,slack)
{
   union()
   {
      if (REINFORCE_CORE)
      {
         difference()
         {
            union()
            {
               translate([0,0,ch/6])
                  cylinder(2*ch/3, cr0, cr1, center = true);
               translate([0,0,-ch/3])
                  cylinder(ch/3, (cr0+cr1)/2, cr0, center = true);
            }
            //to make waist thicker on print
            translate([0,0,-slack])
            {
               union()
               {
                  cube([cr0,slack/4,ch], center = true);
                  cube([slack/4,cr0,ch], center = true);
               }
            }
         }
      }
      else
      {
         union()
         {
            translate([0,0,ch/6])
               cylinder(2*ch/3, cr0, cr1, center = true);
            translate([0,0,-ch/3])
               cylinder(ch/3, (cr0+cr1)/2, cr0, center = true);
         }
      }
      translate([-slack/2,0,0])
      {
         scale([-1,-1,1])
         {
            topShoulder(al,ch,cr0,cr1,slack);
         }
      }
   }
}

module endHinge(arml,shoulderl,ch,cr0,cr1,slack,openangle)
{
   union()
   {
      endHingeBottom(shoulderl,ch,cr0,cr1,slack);
      translate([(cr1+slack)/2,-cr1-(arml-shoulderl)/2-shoulderl,0])
         cube([cr1-slack,arml-shoulderl,ch], center = true);
   }
   rotate([0,0,-openangle])
   {
      union()
      {
         endHingeTop(shoulderl,ch,cr0,cr1,slack);
         translate([-(cr1+slack)/2,-cr1-(arml-shoulderl)/2-shoulderl,0])
            cube([cr1-slack,arml-shoulderl,ch], center = true);
      }
   }
}

module hingeBottom(al,ch,cr0,cr1,slack)
{
   difference()
   {
      union()
      {
         union()
         {
            translate([slack/2,0,0])
               scale([1,-1,-1]) bottomShoulder(al,ch,cr0,cr1,slack);
            translate([-slack/2,0,0])
               scale([-1,1,-1]) bottomShoulder(al,ch,cr0,cr1,slack);
         }
         cylinder(ch, cr1, cr0, center = true);
      }
      union()
      {
         translate([0,0,ch/6])
            cylinder(2*ch/3+iota, cr0+slack, cr1+slack, center = true);
         translate([0,0,-ch/3])
            cylinder(ch/3+iota, (cr0+cr1)/2+slack, cr0+slack, center = true);
      }
   }
}

module hingeTop(al,ch,cr0,cr1,slack)
{
   union()
   {
      if (REINFORCE_CORE)
      {
         difference()
         { //to make waist thicker on print
            union()
            {
               translate([0,0,ch/6])
                  cylinder(2*ch/3, cr0, cr1, center = true);
               translate([0,0,-ch/3])
                  cylinder(ch/3, (cr0+cr1)/2, cr0, center = true);
            }
            //to make waist thicker on print
            translate([0,0,-slack]) union()
            {
               cube([cr0,slack/4,ch], center = true);
               cube([slack/4,cr0,ch], center = true);
            }
         }
      }
      else
      {
         union()
         {
            translate([0,0,ch/6])
               cylinder(2*ch/3, cr0, cr1, center = true);
            translate([0,0,-ch/3])
               cylinder(ch/3, (cr0+cr1)/2, cr0, center = true);
         }
      }
      translate([-slack/2,0,0])
      {
         scale([-1,-1,1])
         {
            topShoulder(al,ch,cr0,cr1,slack);
         }
      }
      translate([slack/2,0,0])
      {
         topShoulder(al,ch,cr0,cr1,slack);
      }
   }
}

module hinge(arml,shoulderl,ch,cr0,cr1,slack,openangle)
{
   union()
   {
      hingeBottom(shoulderl,ch,cr0,cr1,slack);
      translate([-(cr1+slack)/2,cr1+(arml-shoulderl)/2+shoulderl,0])
         cube([cr1-slack,arml-shoulderl,ch], center = true);
      translate([(cr1+slack)/2,-cr1-(arml-shoulderl)/2-shoulderl,0])
         cube([cr1-slack,arml-shoulderl,ch], center = true);
   }
   rotate([0,0,-openangle])
   {
      union()
      {
         hingeTop(shoulderl,ch,cr0,cr1,slack);
         translate([-(cr1+slack)/2,-cr1-(arml-shoulderl)/2-shoulderl,0])
            cube([cr1-slack,arml-shoulderl,ch], center = true);
         translate([(cr1+slack)/2,cr1+(arml-shoulderl)/2+shoulderl,0])
            cube([cr1-slack,arml-shoulderl,ch], center = true);
      }
   }
}

module ext_text(tx)
{
   linear_extrude(hight = texthight)
   {
      text(text=tx, font=font, size=text_size, halign="center", valign="center");
   }
}

//hinge slack test model
module HingeSlackTest()
{
   dy = totalArmLength+cr1;
   dx = cr1 + slack;
   union()
   {
      //slack = 0.6
      translate([-dx,-dy,0])
         scale([1,-1,1])
         endHinge(totalArmLength+iota,shoulderLength+iota, ch, cr0, cr1, 0.6, 0);
      translate([-dx/2,-dy,ch/2-iota])
         rotate([0,0,90])
         ext_text("0.6");

      //slack = 0.5
      translate([0,dy,0])
         scale([-1,1,1])
         endHinge(totalArmLength+iota,shoulderLength+iota, ch, cr0, cr1, 0.5, 0);
      translate([-dx/2,dy,ch/2-iota])
         rotate([0,0,90])
         ext_text("0.5");

      //slack = 0.4
      translate([dx,-dy,0])
         scale([1,-1,1])
         endHinge(totalArmLength+iota,shoulderLength+iota, ch, cr0, cr1, 0.4, 0);
      translate([3*dx/2,-dy,ch/2-iota])
         rotate([0,0,90])
         ext_text("0.4");
      //slack = 0.3
      translate([2*dx,dy,0])
         scale([-1,1,1])
         endHinge(totalArmLength+iota,shoulderLength+iota, ch, cr0, cr1, 0.3, 0);
      translate([3*dx/2,dy,ch/2-iota])
         rotate([0,0,90])
         ext_text("0.3");


   }
}

//short grab toy
module GrabToyPlusPlus4hinges() {
   dy = totalArmLength+cr1;
   dx = cr1 + slack;
   union() {
      translate([0,2*dy,0]) scale([-1,1,1]) endHinge(totalArmLength+iota,shoulderLength+iota, ch, cr0, cr1, slack, 0);
      translate([dx,0,0]) {
         hinge(totalArmLength,shoulderLength, ch, cr0, cr1, slack, 0);
         //rotate([0,0,-45]) //uncomment to check closed position
         halfHandle(totalArmLength,ch,cr0,cr1,slack,wRing, hRing, rRing, ringAspectRatio, ringTilt, baseWidth);
         rotate([180,0,0])
            difference() {
            halfHandle(totalArmLength,ch,cr0,cr1,slack,wRing, hRing, rRing, ringAspectRatio, ringTilt, baseWidth);
            union() {
               translate([0,0,ch/6]) cylinder(2*ch/3+iota, cr0+slack, cr1+slack, center = true);
               translate([0,0,-ch/3]) cylinder(ch/3+iota, (cr0+cr1)/2+slack, cr0+slack, center = true);
            }
         }
      }
      translate([-dx,0,0]) hinge(totalArmLength,shoulderLength, ch, cr0, cr1, slack, 0);
      translate([0,-2*dy,0]) scale([1,-1,1]) endHinge(totalArmLength+iota,shoulderLength+iota, ch, cr0, cr1, slack, 0);
      translate([-dx,0,0]) scale([-1,1,1]) jaws(3*totalArmLength,rTooth0,rTooth1,hTooth,wTooth,nTeethUp,nTeethLow, cr1,ch,totalArmLength,slack);

      translate([dx/2,-dy,ch/2-iota])
         rotate([0,0,90])
         color("red")
         ext_text("GT");

      translate([dx/2,dy,ch/2-iota])
         rotate([0,0,90])
         color("red")
         ext_text("4");
   }
}

//long grab toy
module GrabToyPlusPlus10hinges() {
   dy = totalArmLength+cr1;
   dx = cr1 + slack;
   union() {
      translate([dx,0,0]) {
         hinge(totalArmLength,shoulderLength, ch, cr0, cr1, slack, 0);
         //rotate([0,0,-45]) //uncomment to check closed position
         halfHandle(totalArmLength,ch,cr0,cr1,slack,wRing, hRing, rRing, ringAspectRatio, ringTilt, baseWidth);
         rotate([180,0,0])
            difference() {
            halfHandle(totalArmLength,ch,cr0,cr1,slack,wRing, hRing, rRing, ringAspectRatio, ringTilt, baseWidth);
            union() {
               translate([0,0,ch/6]) cylinder(2*ch/3+iota, cr0+slack, cr1+slack, center = true);
               translate([0,0,-ch/3]) cylinder(ch/3+iota, (cr0+cr1)/2+slack, cr0+slack, center = true);
            }
         }
      }

      translate([0,2*dy,0]) scale([-1,1,1]) endHinge(totalArmLength+iota,shoulderLength+iota, ch, cr0, cr1, slack, 0);
      translate([-2*dx,2*dy,0]) scale([-1,1,1]) endHinge(totalArmLength+iota,shoulderLength+iota, ch, cr0, cr1, slack, 0);
      translate([-4*dx,2*dy,0]) scale([-1,1,1]) endHinge(totalArmLength+iota,shoulderLength+iota, ch, cr0, cr1, slack, 0);

      translate([-dx,0,0]) hinge(totalArmLength,shoulderLength, ch, cr0, cr1, slack, 0);
      translate([-3*dx,0,0]) hinge(totalArmLength,shoulderLength, ch, cr0, cr1, slack, 0);
      translate([-5*dx,0,0]) hinge(totalArmLength,shoulderLength, ch, cr0, cr1, slack, 0);

      translate([0,-2*dy,0]) scale([1,-1,1]) endHinge(totalArmLength+iota,shoulderLength+iota, ch, cr0, cr1, slack, 0);
      translate([-2*dx,-2*dy,0]) scale([1,-1,1]) endHinge(totalArmLength+iota,shoulderLength+iota, ch, cr0, cr1, slack, 0);
      translate([-4*dx,-2*dy,0]) scale([1,-1,1]) endHinge(totalArmLength+iota,shoulderLength+iota, ch, cr0, cr1, slack, 0);

      translate([-5*dx,0,0]) scale([-1,1,1]) jaws(3*totalArmLength,rTooth0,rTooth1,hTooth,wTooth,nTeethUp,nTeethLow, cr1,ch,totalArmLength,slack);

      //GT
      translate([dx/2,-dy,ch/2-iota])
         rotate([0,0,90])
         color("red")
         ext_text("GT");
      //++
      translate([dx/2,dy,ch/2-iota])
         rotate([0,0,90])
         color("red")
         ext_text("10");
   }
}
