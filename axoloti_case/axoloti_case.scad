// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// Axoloti case.
//
// © 2017 Roland Sieker <ospalh@gmail.com>
// © 2013 M_G
// Licence: CC-BY-SA 4.0

// Based on M_G’s OpenSCAD Parametric Packaging Script v2, version
// 2.6c. Thingiveres thing https://www.thingiverse.com/thing:66030
// See the source file there for usage notes.

// The layout of the parts. Change this to top, render, export, then
// bottom, reder, export.
// layout="beside";  // [beside, stacked, top, bottom]
layout="bottom";  // [beside, stacked, top, bottom]


screw_hole_distance = 2;
screw_hole_radius = 1.6;

// Dimensions of the axoloti core.
// Todo: get the real height:
device_xyz = [160, 50, 23];
// The gap between the axoloti and the case:
clearance_xyz = [1, 1, 2];
// Theckness of the case walls:
// wall_t = 3;  // originall thickness
wall_t = 3; // 2 mm should be plenty.

// The external radius of the rounded corners of the packaging
corner_radius = 3;
// How many sides do these rounded corners have?
corner_sides = 5;
// How high is the lip that connects the 2 halves?
lip_h = 5;
// How tall is the top relative to the bottom
top_bottom_ratio=0.2;  // Originally 0.5.
// We want the gap to coincide with the USB connectors, which are quite
// low. Needs tweaking because of some posts.

// Does the part have (anti-warping) mouse ears?
has_mouseears = false;
mouse_ear_thickness=0.2*2;  // Twice print layer thickness is a good idea
mouse_ear_radius = 10;  // 5–15  (mm) generally work well


// How far apart the 2 halves are in the "beside" layout
separation = 15;
// How much of an overlap (-ve) or gap (+ve) is there between the inner
// and outer lip surfaces, a value of 0 implies they meet perfectly in
// the middle
// lip_fit=0.2;
lip_fit = 0.2;

// Does it have an imported representaion of the actual device to be packaged?
has_device=false;

// Edge style, possible values:
// "cuboid", "rounded4sides", "rounded6sides", "chamfered6sides"
box_type = "rounded6sides";

// Data structure defining all the cutouts and depressions used on the packaging
holes = [
   // Three examples
   ["N", "Rectangle", [-7, 0.5,0,-device_xyz[2]/2,0,"inside"],
    [wall_t, 14, 2] ], // Cutout for µSD card (Reuse this?)

//   ["E", "Rectangle", [0.5, +0.75,0,0,0,"inside"], [wall_t, 9, 5]],
   // cutout for switch

   // The SD card
  // ["N", "Rectangle", [15, +1,0,0,0,"inside"], [wall_t, 10, 6]],
   //cutout for uUSB port

   // Screw holes
   ["B", "Cylinder",
    [screw_hole_distance, screw_hole_distance,
     -device_xyz[0]/2, -device_xyz[1]/2, 0, "outside"],
    [clearance_xyz[2]+wall_t, screw_hole_radius, 10]],
   ["B", "Cylinder",
    [-screw_hole_distance, screw_hole_distance,
     device_xyz[0]/2, -device_xyz[1]/2, 0, "outside"],
    [clearance_xyz[2]+wall_t, screw_hole_radius, 10]],
   ["B", "Cylinder",
    [-screw_hole_distance, -screw_hole_distance,
     device_xyz[0]/2, device_xyz[1]/2, 0, "outside"],
    [clearance_xyz[2]+wall_t, screw_hole_radius, 10]],
   ["B", "Cylinder",
    [screw_hole_distance, -screw_hole_distance,
     -device_xyz[0]/2, device_xyz[1]/2, 0, "outside"],
    [clearance_xyz[2]+wall_t, screw_hole_radius, 10]],
   ];

post_tolerance=0.1;

// Data structure defining all the internal supporting structures used
// on the packaging

posts = [
   // Format:
   // [face_name, shape_name shape_position[x_pos,y_pos,x_offs,y_offs,rotate,align],
   //  shape_size[depth,,,]]
   ["B", "Cylinder",
    [screw_hole_distance, screw_hole_distance,
     -device_xyz[0]/2, -device_xyz[1]/2, 0, "inside"],
    [clearance_xyz[2], 2*screw_hole_radius, 10]],
   ["B", "Cylinder",
    [-screw_hole_distance, screw_hole_distance,
     device_xyz[0]/2, -device_xyz[1]/2, 0, "inside"],
    [clearance_xyz[2], 2*screw_hole_radius, 10]],
   ["B", "Cylinder",
    [screw_hole_distance, -screw_hole_distance,
     -device_xyz[0]/2, device_xyz[1]/2, 0, "inside"],
    [clearance_xyz[2], 2*screw_hole_radius, 10]],
   ["B", "Cylinder",
    [-screw_hole_distance, -screw_hole_distance,
     device_xyz[0]/2, device_xyz[1]/2, 0, "inside"],
    [clearance_xyz[2], 2*screw_hole_radius, 10]],


   ];

// Data structure defining all the engraved text used on the packaging
texts = [
   // Recessed text on faces

   // This version uses the native, relatively new, OpenSCAD text() function.

   // [
   // face_name, text_to_write,
   // shape_position[x_pos,y_pos,x_offs,y_offs,rotate,align],
   // shape_size[depth, font_height, mirror, font_name]
   // ]
   // Notes:
   // Mirror must be 0 or 1 corresponding to false and true in this
   // version
   // Use a font you a) have, b) like, and c) that contains the glyphs
   // you want.

   // ["T", "31", [0,12,0,0,0,"outside"], [1,4,1,0]],//device ID
   // ["T", "2013-3-25", [0,0,0,0,90,"inside"], [0.5,4,1,1]],//date
   // ["N", "X-", [0,10,0,0,0,"outside"], [1,10,1,0]],
   // ["S", "X+", [0,-6,0,0,0,"outside"], [1,10,1,0]],
   // ["E", "Y+", [10,-6,0,0,0,"outside"], [1,10,1,0]],



   ["T", "XQg", [0,0,0,0,90,"inside"], [11,5, 0, "Praxis LT"]],
   ["E", "Off On", [0,-5,0,0,0,"outside"], [1,3, 0, "Praxis LT"]],
   ["E", "uUSB", [15,-5,0,0,0,"outside"], [1,3, 0, "Praxis LT"]],
   ["W", "µSD", [14,4,0,0,0,"outside"], [1,3, 0, "Praxis LT"]],
   ];


// Data structure defining external items such as .stl files to import

items = [
   // External items on faces:
   // [face_name, external_file,
   //  shape_position[x_pos,y_pos,x_offs,y_offs,rotate,align],
   //  shape_size[depth, scale_x,scale_y, scale_z, mirror]]

   // Note: for silly reasons mirror must be 0 or 1 corresponding to
   // false and true in this version


//    ["T", "axoloti_logo.stl",            [0,0,0,0,90,"outside"],                     [0.5,10/21.9,10/21.9,1.1/1.62,0]]
   ];

// A small number used for manifoldness
a_bit = 0.01;

// X dimension of packaging
box_l = device_xyz[0]+2*(clearance_xyz[0]+wall_t);
// y dimension of packaging
box_b = device_xyz[1]+2*(clearance_xyz[1]+wall_t);
// z dimension of packaging
box_h = device_xyz[2]+2*(clearance_xyz[2]+wall_t);

// Now create things:

mouse_ears=[has_mouseears, mouse_ear_thickness, mouse_ear_radius];

box=[box_l,box_b,box_h,corner_radius,corner_sides,wall_t];//

make_box(box, corner_radius, corner_sides, lip_h, lip_fit, top_bottom_ratio, mouse_ears, layout, separation, holes, posts, texts, items, has_device, box_type);




module make_box(box, corner_radius=3, corner_sides=5, lip_h=2, lip_fit=0, top_bottom_ratio=0.5, mouse_ears=[false], layout="beside", separation=2, holes=[], posts=[], texts=[], items=[], has_device=false, box_type="rounded4sides"){
   echo("layout", layout);

   //echo("holes", holes);
   //echo ("variables", corner_radius, corner_sides, lip_h, top_bottom_ratio, has_mouseears, layout, separation);
   translate(v=[0, 0, box[2]/2]){
      if (layout=="beside"){
         echo("beside");
         union(){
            translate(v=[(separation+box[0])/2, 0, 0]){
               half_box(box, corner_radius, corner_sides, lip_h, lip_fit, top_bottom_ratio, which_half="bottom", holes=holes, posts=posts, mouse_ears=mouse_ears, texts=texts, items=items, box_type=box_type);
               //cube(size=[25.5, 31.5, 23.5], center=true);
               //rotate(a=[0, 0, 90])translate(v=[-30/2, -15/2, 0])import("wimuv3_stack_v0.1.stl");
//                  rotate(a=[0, 0, -90])translate(v=[-27/2, -40/2, 1.88])import("2013_04_04-WIMUv3a_PCB-V0-2_logo.stl");
            }translate(v=[-(separation+box[0])/2, 0, 0]) rotate(a=[0, 180, 0]){
               half_box(box, corner_radius, corner_sides, lip_h, lip_fit, top_bottom_ratio, which_half="top", holes=holes, posts=posts, mouse_ears=mouse_ears, texts=texts, items=items, box_type=box_type);//cube(size=[box[0], box[1], box[2]], center=true);
               //cube(size=[25.5, 31.5, 23.5], center=true);
            }
         }
      }else if (layout=="stacked"){
         echo("stacked");
         half_box(box, corner_radius, corner_sides, lip_h, lip_fit, top_bottom_ratio, which_half="bottom", holes=holes, posts=posts, mouse_ears=mouse_ears, texts=texts, items=items, has_device=has_device, box_type=box_type);
         translate(v=[0, 0, 0])half_box(box, corner_radius, corner_sides, lip_h, lip_fit, top_bottom_ratio, which_half="top", holes=holes, posts=posts, mouse_ears=[false], texts=texts, items=items, box_type=box_type);
         //rotate(a=[0, 0, 90])translate(v=[-30/2, -15/2, 0])import("wimuv3_stack_v0.1.stl");
      }else if (layout=="top"){
         echo("top");
         rotate(a=[180, 0, 0]) half_box(box, corner_radius, corner_sides, lip_h, lip_fit, top_bottom_ratio, which_half="top", holes=holes, posts=posts, mouse_ears=mouse_ears, texts=texts, items=items, box_type=box_type);
      }else if (layout=="bottom"){
         echo("bottom");
         half_box(box, corner_radius, corner_sides, lip_h, lip_fit, top_bottom_ratio, which_half="bottom", holes=holes, posts=posts, mouse_ears=mouse_ears, texts=texts, items=items, has_device=has_device, box_type=box_type);
      }else{
         echo("unknown layout requested", layout);
      }
   }
}

module half_box(box, corner_radius=3, corner_sides=5, lip_h=2, lip_fit=0, top_bottom_ratio=0.5, which_half="bottom", holes=[], posts=[], mouse_ears=[false], texts=[], , items=[], has_device=false, box_type="rounded4sides"){
   a_bit=0.01;
   echo("holes", holes);
   has_mouse_ears=mouse_ears[0];
   mouse_ear_thickness=mouse_ears[1];
   mouse_ear_radius=mouse_ears[2];

   wall_t=box[5];
   cutaway_extra=0.01;
   if (which_half=="bottom") color("springgreen") {
         echo("bottom half");
         union(){//combine hollow cutout box with posts
            difference(){
               union(){
                  difference(){
                     // Make the hollow box
                     box_type(box, box_type);
                     box_type(
                        [box[0]-2*box[5], box[1]-2*box[5], box[2]-2*box[5],
                         corner_radius-box[5], corner_sides], box_type);
                  }
                  make_posts(box, posts);
               }
               translate(v=[0, 0, box[2]*(1-top_bottom_ratio)-lip_h/2])
               {
                  // Cutting away other half and lip cutout
                  translate(v=[0, 0, lip_h/2 - box[2]/2 ])
                     rounded_rectangle_cylinder_hull(
                        box[0]-(box[5]-lip_fit), box[1]-(box[5]-lip_fit),
                        lip_h+0.01, corner_radius-(box[5]-lip_fit)/2,
                        corner_sides);
                  // Cutout for lips
                  translate(v=[0,0,lip_h+cutaway_extra/2])
                     cube(
                        size=[
                           box[0]+2*cutaway_extra, box[1]+2*cutaway_extra,
                           box[2]+cutaway_extra],
                        center=true);
                  // Need to oversize this using cutaway_extra so it
                  // gets any extra material on the side the be removed
                  // on the outside (from posts)
               }
               #make_cutouts(box, holes);
               // Remove the material for the cutouts because this
               // happens at the end you can make a hole in the centre
               // of a post! perhaps a cone for a countersink screw
               // through hole
               make_texts(box, texts);
               make_items(box, items);
            }
            //make_posts(box, posts);
            mouse_ears(box,mouse_ear_thickness,mouse_ear_radius, has_mouse_ears);
            if(has_device==true){
               echo("has device");
               //rotate(a=[0,0,90])translate(v=[-31/2,-25/2,-box[2]/2+3.5])import("wimuv3_stack_v0.1.stl");
               rotate(a=[0,0,90])translate(v=[-40/2,-27/2,1.88-9.23/2])import("2013_04_04-WIMUv3a_PCB-V0-2_logo.stl");
            }
         }

      }else if (which_half=="top") color("crimson") {
         echo("top half");
         union(){
            intersection(){
               difference(){
                  //echo("box",box);
                  union(){
                     difference(){//make hollow box
                        box_type(box, box_type); //rounded_rectangle_cylinder_hull(box[0],box[1],box[2],corner_radius,corner_sides);
                        //box_type([box[0]-2*box[5][0],box[1]-2*box[5][1],box[2]-2*box[5][2],corner_radius-0.5*(box[5][0]+box[5][1]),corner_sides], box_type="rounded4sides");//rounded_rectangle_cylinder_hull(box[0]-2*box[5],box[1]-2*box[5],box[2]-2*box[5],corner_radius-box[5],corner_sides);
                        box_type([box[0]-2*box[5],box[1]-2*box[5],box[2]-2*box[5],corner_radius-box[5],corner_sides], box_type);//rounded_rectangle_cylinder_hull(box[0]-2*box[5],box[1]-2*box[5],box[2]-2*box[5],corner_radius-box[5],corner_sides);
                     }
                     make_posts(box,posts);
                  }
                  #make_cutouts(box, holes);
                  make_texts(box, texts);
                  make_items(box, items);
               }
               translate(v=[0,0,(box[2]*(1-top_bottom_ratio))-lip_h/2]){//removed -lip_h/2 from z translate/re-added
                  //translate(v=[0,0,lip_h/2 - box[2]/2]) rounded_rectangle_cylinder_hull(box[0]-box[5],box[1]-box[5],lip_h+0.01,corner_radius-box[5]/2,corner_sides);//lips
                  translate(v=[0,0,lip_h/2 - box[2]/2]) rounded_rectangle_cylinder_hull(box[0]-(box[5]+lip_fit),box[1]-(box[5]+lip_fit),lip_h+0.01,corner_radius-(box[5]+lip_fit)/2,corner_sides);//lips
                  // translate(v=[0,0,lip_h/2 - box[2]/2]) rounded_rectangle_cylinder_hull(box[0]-box[5][0],box[1]-box[5][1],lip_h+0.01,corner_radius-(box[5][0]+box[5][1])/4,corner_sides);
                  translate(v=[0,0,lip_h-a_bit]) cube(size=[box[0]+2*cutaway_extra,box[1]+2*cutaway_extra,box[2]], center=true);
               }
            }
            //make_posts(box,posts);
            rotate(a=[180,0,0])mouse_ears(box,mouse_ear_thickness,mouse_ear_radius, has_mouse_ears);
         }

      }else{
      echo("invalid half requested",which_half);
   }
}

module rounded_rectangle_cylinder_hull(x,y,z,r,s)
{
   //cube(size=[x,y,z],center=true);
   //echo("number of sides",s);
   hull()
   {
      cross_box(x,y,z,r);
      // This is to ensure the overall dimensions stay true to those
      // requested even for low-poly cylinders

      translate(v=[   x/2 -r ,   y/2 -r , 0])
         cylinder(h=z, r=r, center=true, $fn=4*s);
      translate(v=[   x/2 -r , -(y/2 -r), 0])
         cylinder(h=z, r=r, center=true, $fn=4*s);
      translate(v=[ -(x/2 -r), -(y/2 -r), 0])
         cylinder(h=z, r=r, center=true, $fn=4*s);
      translate(v=[ -(x/2 -r),   y/2 -r , 0])
         cylinder(h=z, r=r, center=true, $fn=4*s);
   }
}

module cross_box(x,y,z,r)
{
   cube(size=[x-2*r,y-2*r,z],center=true);
   cube(size=[x-2*r,y,z-2*r],center=true);
   cube(size=[x,y-2*r,z-2*r],center=true);
}

module make_cutouts(box, holes)
{
   box_l=box[0];  // x
   box_b=box[1];  // y
   box_h=box[2];  // z
   box_t=[box[5],box[5],box[5]];//wall_t

   // %cube(size=[box_l,box_b,box_h],center=true);

   x_pos = 0;
   y_pos = 0;
   face = "X";

   echo("len(holes)",len(holes));
   for (j=[0:len(holes)-1])
   {
      x_pos = holes[j][2][0];
      y_pos = holes[j][2][1];
      x_offs= holes[j][2][2];
      y_offs= holes[j][2][3];
      face = holes[j][0];
      shape_type=holes[j][1];
      shape_data=holes[j][3];
      rotation=holes[j][2][4];
      align=holes[j][2][5];
      depth=holes[j][3][0];
      //echo("face",face);
      if (face=="N")
      {
         translate(v=[0,box_b/2,0])
            rotate(a=[-90,0,0])
            translate(v=[-(x_pos+x_offs),-(y_pos+y_offs),0])
         {
            //echo("alignment", align);
            if (align=="inside")
            {
               //echo("translate by",+depth/2-box_t);
               translate(v=[0,0,+depth/2-box_t[1]])
                  rotate(a=[0,0,-rotation])
                  make_shape(shape_type, shape_data);
            }
            else if (align=="outside")
            {
               //echo("translate by",-depth/2);
               translate(v=[0,0,-depth/2])
                  rotate(a=[0,0,-rotation])
                  make_shape(shape_type, shape_data);
            }
            else
            {
               echo("invalid alignment", align);
            }
         }
      }
      else if (face=="E")
      {
         translate(v=[box_l/2,0,0])
            rotate(a=[0,90,0])
            rotate(a=[0,0,-90])
            translate(v=[-(x_pos+x_offs),-(y_pos+y_offs),0])
         {
            //make_shape(shape_type, shape_data);
            if (align=="inside")
               translate(v=[0,0,+depth/2-box_t[0]])
                  rotate(a=[0,0,-rotation])
                  make_shape(shape_type, shape_data);
            else if (align=="outside")
               translate(v=[0,0,-depth/2])
                  rotate(a=[0,0,-rotation])
                  make_shape(shape_type, shape_data);
            else
               echo("invalid alignment", align);
         }
      }
      else if (face=="T")
      {
         translate(v=[0,0,box_h/2])
            rotate(a=[0,0,0])
            translate(v=[(x_pos+x_offs),(y_pos+y_offs),0])
         {
            if (align=="inside")
               translate(v=[0,0,+depth/2-box_t[2]])
                  rotate(a=[0,0,-rotation])
                  make_shape(shape_type, shape_data);
            else if (align=="outside")
               translate(v=[0,0,-depth/2])
                  rotate(a=[0,0,-rotation])
                  make_shape(shape_type, shape_data);
            else
               echo("invalid alignment", align);
         }
      }
      else if (face=="S")
      {
         translate(v=[0,-box_b/2,0])
            rotate(a=[+90,0,0])
            translate(v=[-(x_pos+x_offs),(y_pos+y_offs),0])
         {
            if (align=="inside")
               translate(v=[0,0,+depth/2-box_t[1]])
                  rotate(a=[0,0,rotation])
                  make_shape(shape_type, shape_data);
            else if (align=="outside")
               translate(v=[0,0,-depth/2])
                  rotate(a=[0,0,rotation])
                  make_shape(shape_type, shape_data);
            else
               echo("invalid alignment", align);
         }
      }
      else if (face=="W")
      {
         translate(v=[-box_l/2,0,0])
            rotate(a=[0,-90,0])
            rotate(a=[0,0,-90])
            translate(v=[-(x_pos+x_offs),(y_pos+y_offs),0])
         {
            if (align=="inside")
               translate(v=[0,0,+depth/2-box_t[0]])
                  rotate(a=[0,0,rotation])
                  make_shape(shape_type, shape_data);
            else if (align=="outside")
               translate(v=[0,0,-depth/2])
                  rotate(a=[0,0,rotation])
                  make_shape(shape_type, shape_data);
            else
               echo("invalid alignment", align);
         }
      }
      else if (face=="B")
      {
         //echo("bottom");
         translate(v=[0,0,-box_h/2])
            rotate(a=[0,180,0])
            translate(v=[-(x_pos+x_offs),(y_pos+y_offs),0])
         {
            if (align=="inside")
               translate(v=[0,0,+depth/2-box_t[2]])
                  rotate(a=[0,0,rotation])
                  make_shape(shape_type, shape_data);
            else if (align=="outside")
               translate(v=[0,0,-depth/2])
                  rotate(a=[0,0,rotation])
                  make_shape(shape_type, shape_data);
            else
               echo("invalid alignment", align);
         }
      }
      else
      {
         echo("Unknown Face",face);
      }
   }
}

module mouse_ears(box,thickness,radius, has_mouse_ears)
{
   if (has_mouse_ears)
      union()
      {
         translate(v=[box[0]/2,box[1]/2,-box[2]/2])
            cylinder(r=radius, center=false);
         translate(v=[box[0]/2,-box[1]/2,-box[2]/2])
            cylinder(r=radius, center=false);
         translate(v=[-box[0]/2,box[1]/2,-box[2]/2])
            cylinder(r=radius, center=false);
         translate(v=[-box[0]/2,-box[1]/2,-box[2]/2])
            cylinder(r=radius, center=false);
      }
}

module make_posts(box, posts)
{
   //This will be based on make_cutouts
   echo ("make_posts");
   a_bit=0.01;
   box_l=box[0];//x
   box_b=box[1];//y
   box_h=box[2];//z
   box_t=[box[5],box[5],box[5]];//wall_t [x,y,z]

//% cube(size=[box_l,box_b,box_h],center=true);

   x_pos = 0;
   y_pos = 0;
   face = "X";
   echo("len(posts)",len(posts));
   for (j=[0:len(posts)-1])
   {
      x_pos = posts[j][2][0];
      y_pos = posts[j][2][1];
      x_offs= posts[j][2][2];
      y_offs= posts[j][2][3];
      face = posts[j][0];
      shape_type=posts[j][1];
      shape_data=posts[j][3];
      rotation=posts[j][2][4];
      align=posts[j][2][5];
      depth=posts[j][3][0]-a_bit;
      //echo("face",face);
      if (face=="N")
      {
         translate(v=[0,box_b/2,0])
            rotate(a=[-90,0,0])
            translate(v=[-(x_pos+x_offs),-(y_pos+y_offs),0])
         {
            //echo("alignment", align);
            if (align=="inside")
            {
               // echo("translate by",+depth/2-box_t);
               translate(v=[0,0,-depth/2-box_t[1]])
                  rotate(a=[0,0,-rotation])
                  make_shape(shape_type, shape_data);
            }
            else if (align=="outside")
            {
               //  echo("translate by",-depth/2);
               translate(v=[0,0,-depth/2-a_bit])
                  rotate(a=[0,0,-rotation])
                  make_shape(shape_type, shape_data);
            }
            else
            {
               echo("invalid alignment", align);
            }
         }
      }
      else if (face=="E")
      {
         translate(v=[box_l/2,0,0])
            rotate(a=[0,90,0])
            rotate(a=[0,0,-90])
            translate(v=[-(x_pos+x_offs),-(y_pos+y_offs),0])
         {
            // make_shape(shape_type, shape_data);
            if (align=="inside")
               translate(v=[0,0,-depth/2-box_t[0]])
                  rotate(a=[0,0,-rotation])
                  make_shape(shape_type, shape_data);
            else if (align=="outside")
               translate(v=[0,0,-depth/2-a_bit])
                  rotate(a=[0,0,-rotation])
                  make_shape(shape_type, shape_data);
            else
               echo("invalid alignment", align);
         }
      }
      else if (face=="T")
      {
         echo(face,align);
         translate(v=[0,0,box_h/2])
            rotate(a=[0,0,0])
            translate(v=[(x_pos+x_offs),(y_pos+y_offs),0])
         {
            if (align=="inside")
               translate(v=[0,0,-depth/2-box_t[2]])
                  rotate(a=[0,0,-rotation])
                  make_shape(shape_type, shape_data);
            else if (align=="outside")
               translate(v=[0,0,-depth/2-a_bit])
                  rotate(a=[0,0,-rotation])
                  make_shape(shape_type, shape_data);
            else
               echo("invalid alignment", align);
         }
      }
      else if (face=="S")
      {
         translate(v=[0,-box_b/2,0])
            rotate(a=[+90,0,0])
            translate(v=[-(x_pos+x_offs),(y_pos+y_offs),0])
         {
            if (align=="inside")
               translate(v=[0,0,-depth/2-box_t[1]])
                  rotate(a=[0,0,rotation])
                  make_shape(shape_type, shape_data);
            else if (align=="outside")
               translate(v=[0,0,-depth/2-a_bit])
                  rotate(a=[0,0,rotation])
                  make_shape(shape_type, shape_data);
            else
               echo("invalid alignment", align);
         }
      }
      else if (face=="W")
      {
         translate(v=[-box_l/2,0,0])
            rotate(a=[0,-90,0])
            rotate(a=[0,0,-90])
            translate(v=[-(x_pos+x_offs),(y_pos+y_offs),0])
         {
            if (align=="inside")
               translate(v=[0,0,-depth/2-box_t[0]])
                  rotate(a=[0,0,rotation])
                  make_shape(shape_type, shape_data);
            else if (align=="outside")
               translate(v=[0,0,-depth/2-a_bit])
                  rotate(a=[0,0,rotation])
                  make_shape(shape_type, shape_data);
            else
               echo("invalid alignment", align);
         }
      }
      else if (face=="B")
      {
         // echo("bottom");
         translate(v=[0,0,-box_h/2])
            rotate(a=[0,180,0])
            translate(v=[-(x_pos+x_offs),(y_pos+y_offs),0])
         {
            if (align=="inside")
               translate(v=[0,0,-depth/2-box_t[2]])
                  rotate(a=[0,0,rotation])
                  make_shape(shape_type, shape_data);
            else if (align=="outside")
               translate(v=[0,0,-depth/2-a_bit])
                  rotate(a=[0,0,rotation])
                  make_shape(shape_type, shape_data);
            else
               echo("invalid alignment", align);
         }
      }
      else
      {
         echo("Unknown Face",face);
      }
   }
}

module make_shape(shape, shape_data)
{
   a_bit=0.01;  // for ensuring manifoldness
   // shape =
   //  "Cone", "Ellipse", "Cylinder", "Round_Rect", "Square", "Rectangle",
   //  Nub_Post, Dip_Post, Hollow_Cylinder
   //shape_data=[4,5,4,8];//[4,8,12,20];//[4,2,10];//[4,10,8,2,4];//[5,10];//[2,4,15];
   if(shape=="Square"){//[depth, length_breadth]
      cube(size=[shape_data[1],shape_data[1],shape_data[0]+a_bit],center=true);//do thing for square

   }else if(shape=="Rectangle"){//[depth, length, breadth]
      cube(size=[shape_data[1],shape_data[2],shape_data[0]+a_bit],center=true);//do thing for rectangle

   }else if(shape=="Round_Rect"){//[depth, length, breadth, corner_radius, corner_sides]
      rounded_rectangle_cylinder_hull(shape_data[1],shape_data[2],shape_data[0]+a_bit, shape_data[3], shape_data[4]);
      /*hull(){
        translate(v=[   shape_data[1]/2 -shape_data[3] ,   shape_data[2]/2 -shape_data[3] , 0])cylinder(h=shape_data[0]+a_bit, r=shape_data[3], center=true, $fn=4*shape_data[4]);
        translate(v=[   shape_data[1]/2 -shape_data[3] , -(shape_data[2]/2 -shape_data[3]), 0])cylinder(h=shape_data[0]+a_bit, r=shape_data[3], center=true, $fn=4*shape_data[4]);
        translate(v=[ -(shape_data[1]/2 -shape_data[3]), -(shape_data[2]/2 -shape_data[3]), 0])cylinder(h=shape_data[0]+a_bit, r=shape_data[3], center=true, $fn=4*shape_data[4]);
        translate(v=[ -(shape_data[1]/2 -shape_data[3]),   shape_data[2]/2 -shape_data[3] , 0])cylinder(h=shape_data[0]+a_bit, r=shape_data[3], center=true, $fn=4*shape_data[4]);
        }*/
   }else if(shape=="Cylinder"){ //(depth, radius ,sides)
      cylinder(r=shape_data[1],h=shape_data[0]+a_bit,center=true, $fn=shape_data[2]);//do thing for cylinder

   }else if(shape=="Ellipse"){ //(depth, radius_length, radius_breadth, sides)
      scale (v=[shape_data[1],shape_data[2],1])cylinder(r=1,h=shape_data[0]+a_bit,center=true, $fn=shape_data[3]);//do thing for ellipse

   }else if(shape=="Cone"){ //(depth, radius_bottom, radius_top ,sides)
      cylinder(r1=shape_data[1],r2=shape_data[2],h=shape_data[0]+a_bit,center=true, $fn=shape_data[3]);//do thing for cone

   }else if(shape=="Nub_Post"){ //(depth, radius_bottom, radius_top , depth_nub, sides)
      union(){
         echo ("make nub",shape_data);
         cylinder(r=shape_data[1], h=shape_data[0]+a_bit,center=true, $fn=shape_data[4]);//do thing for cylinder outside
         //cylinder(r=max(shape_data[2],shape_data[1]), h=shape_data[0]+a_bit,center=true, $fn=shape_data[3]);//do thing for cylinder outside
         //translate(v=[0,0,(shape_data[0]-shape_data[3])/2]) cylinder(r=min(shape_data[2],shape_data[1]), h=shape_data[0]+a_bit,center=true, $fn=shape_data[3]);//do thing for cylinder inside
         translate(v=[0,0,(-shape_data[0]+shape_data[3])/2]) cylinder(r=shape_data[2], h=shape_data[0]+a_bit,center=true, $fn=shape_data[4]);//do thing for cylinder inside
      }

   }else if(shape=="Dip_Post"){ //(depth, radius_bottom, radius_top ,depth_dip, sides)
      difference(){
         echo("dip_post",shape_data);
         cylinder(r=shape_data[1],h=shape_data[0]+a_bit, center=true,$fn=shape_data[4]);//do thing for cylinder outside
         //cylinder(r=max(shape_data[2],shape_data[1]), h=shape_data[0]+a_bit,center=true, $fn=shape_data[3]);//do thing for cylinder outside
         //translate(v=[0,0,(shape_data[0]+shape_data[3])/2]) cylinder(r=min(shape_data[2],shape_data[1]), h=shape_data[0]+2*a_bit,center=true, $fn=shape_data[3]);//do thing for cylinder inside
         translate(v=[0,0,(-shape_data[0]+shape_data[3])/2]) cylinder(r=shape_data[2], h=shape_data[3]+2*a_bit,center=true, $fn=shape_data[4]);//do thing for cylinder inside
      }
   }else if(shape=="Hollow_Cylinder"){ //(depth, radius_outside, radius_inside ,sides)
      difference(){
         cylinder(r=max(shape_data[2],shape_data[1]), h=shape_data[0]+a_bit,center=true, $fn=shape_data[3]);//do thing for cylinder outside
         cylinder(r=min(shape_data[2],shape_data[1]), h=shape_data[0]+2*a_bit,center=true, $fn=shape_data[3]);//do thing for cylinder inside
      }
   }else{
      echo("Unsupported Shape",shape);
   }
}

module box_type(box, box_type="rounded4sides"){
//basic initial if clause checker will identify if r or s are <=0 or 1 are reverts to a different shape otherwise (simple cuboid)
//this will aid in situations such as r<=wall_t so calculated internal r is now 0 or negative which could cause unexpected geometry or crashes
   if(box_type=="cuboid" || (box[3]<=0 || box[4]<=0)){//|| box[3]<=0 || box[4]=0
      cube(size=[box[0],box[1],box[2]],center=true);
   }else if(box_type=="rounded4sides"){
      rounded_rectangle_cylinder_hull(box[0],box[1],box[2],box[3],box[4]);
   }else if(box_type=="rounded6sides"){
      rounded_rectangle_sphere_hull(box[0],box[1],box[2],box[3],box[4]);
   }else if(box_type=="chamfered6sides"){
      chamfered_rectangle_hull(box[0],box[1],box[2],box[3]);
   }else{
      echo ("unknown box type requested",box_type);
   }
}

module chamfered_rectangle_hull(x,y,z,r){
   hull()
   {
      cross_box(x,y,z,r);
      // This is to ensure the overall dimensions stay true to those
      // requested even for low-poly cylinders
   }
}

module rounded_rectangle_sphere_hull(x,y,z,r,s){
   hull()
   {
      cross_box(x,y,z,r);
      // This is to ensure the overall dimensions stay true to those
      // requested even for low-poly cylinders
      translate(v=[   x/2 -r ,   y/2 -r ,   z/2 -r ])
         sphere(r=r, $fn=4*s);
      translate(v=[   x/2 -r , -(y/2 -r),   z/2 -r ])
         sphere(r=r,$fn=4*s);
      translate(v=[ -(x/2 -r), -(y/2 -r),   z/2 -r ])
         sphere(r=r,$fn=4*s);
      translate(v=[ -(x/2 -r),   y/2 -r ,   z/2 -r ])
         sphere(r=r,$fn=4*s);
      translate(v=[   x/2 -r ,   y/2 -r , -(z/2 -r)])
         sphere(r=r, $fn=4*s);
      translate(v=[   x/2 -r , -(y/2 -r), -(z/2 -r)])
         sphere(r=r, $fn=4*s);
      translate(v=[ -(x/2 -r), -(y/2 -r), -(z/2 -r)])
         sphere(r=r, $fn=4*s);
      translate(v=[ -(x/2 -r),   y/2 -r , -(z/2 -r)])
         sphere(r=r, $fn=4*s);
   }
}


module make_items(box, items)
{
   // This will be based on make_cutouts

   // External items on faces: [
   //    face_name, external_file,
   //    shape_position[
   //       x_pos,y_pos,x_offs,y_offs,rotate,align],
   //    shape_size[
   //      scale_z,scale_x,scale_y,mirror]]

   // Note: for silly reasons mirror must be 0 or 1 corresponding to
   // false and true in this version
   // Example: ["N", "tyndall_logo_v0_2.stl", [0,0,0,0,0,"outside"],
   // [1,1,1,0]]
   echo ("make_items");
   a_bit=0.01;
   box_l=box[0];//x
   box_b=box[1];//y
   box_h=box[2];//z
   box_t=[box[5],box[5],box[5]];  // wall_t [x,y,z]

   // %cube(size=[box_l,box_b,box_h],center=true);

   x_pos = 0;
   y_pos = 0;
   face = "X";
   echo("len(items)",len(items));
   for (j=[0:len(items)-1])
   {
      face = items[j][0];
      items_to_use=items[j][1];
      x_pos = items[j][2][0];
      y_pos = items[j][2][1];
      x_offs= items[j][2][2];
      y_offs= items[j][2][3];
      rotation=items[j][2][4];
      align=items[j][2][5];
      scale_z=items[j][3][3];
      scale_x=items[j][3][1];
      scale_y=items[j][3][2];
      items_mirror=items[j][3][4];
      depth=items[j][3][0];
      //echo("items face",face);
      if (face=="N")
         mirror(v=[items_mirror,0,0])
         {
            translate(v=[0,box_b/2,0])
               rotate(a=[-90,0,0])
               translate(v=[-(x_pos+x_offs),-(y_pos+y_offs),0])
            {
               if (align=="inside")
                  translate(v=[0,0,-box_t[1]])
                     rotate(a=[0,0,-rotation])
                     scale(v=[scale_x,scale_y,scale_z])
                     import(items_to_use);
               else if (align=="outside")
                  translate(v=[0,0,-depth])
                     rotate(a=[0,0,-rotation])
                     scale(v=[scale_x,scale_y,scale_z])
                     import(items_to_use);
               else
                  echo("invalid alignment", align);
            }
         }
      else if (face=="E")
         mirror(v=[0,items_mirror,0])
         {
            translate(v=[box_l/2,0,0])
               rotate(a=[0,90,0])
               rotate(a=[0,0,-90])
               translate(v=[-(x_pos+x_offs),-(y_pos+y_offs),0])
            {
               if (align=="inside")
                  translate(v=[0,0,-box_t[0]])
                     rotate(a=[0,0,-rotation])
                     scale(v=[scale_x,scale_y,scale_z])
                     import(items_to_use);
               else if (align=="outside")
                  translate(v=[0,0,-depth])
                     rotate(a=[0,0,-rotation])
                     scale(v=[scale_x,scale_y,scale_z])
                     import(items_to_use);
               else
                  echo("invalid alignment", align);
            }
         }
      else if (face=="T")
         mirror(v=[items_mirror,0,0])
         {
            translate(v=[0,0,box_h/2])
               rotate(a=[0,0,0])
               translate(v=[(x_pos+x_offs),(y_pos+y_offs),0])
            {
               if (align=="inside")
                  translate(v=[0,0,-box_t[2]])
                     rotate(a=[0,0,-rotation])
                     scale(v=[scale_x,scale_y,scale_z])
                     import(items_to_use);
               else if (align=="outside")
                  translate(v=[0,0,-depth])
                     rotate(a=[0,0,-rotation])
                     scale(v=[scale_x,scale_y,scale_z])
                     import(items_to_use);
               else
                  echo("invalid alignment", align);
            }
         }
      else if (face=="S")
         mirror(v=[items_mirror,0,0])
         {
            translate(v=[0,-box_b/2,0])
               rotate(a=[+90,0,0])
               translate(v=[-(x_pos+x_offs),(y_pos+y_offs),0])
            {
               if (align=="inside")
                  translate(v=[0,0,-box_t[1]])
                     rotate(a=[0,0,-rotation])
                     scale(v=[scale_x,scale_y,scale_z])
                     import(items_to_use);
               else if (align=="outside")
                  translate(v=[0,0,-depth])
                     rotate(a=[0,0,-rotation])
                     scale(v=[scale_x,scale_y,scale_z])
                     import(items_to_use);
               else
                  echo("invalid alignment", align);
            }
         }
      else if (face=="W")
         mirror(v=[0,items_mirror,0])
         {
            translate(v=[-box_l/2,0,0])
               rotate(a=[0,-90,0])
               rotate(a=[0,0,-90])
               translate(v=[-(x_pos+x_offs),(y_pos+y_offs),0])
            {
               if (align=="inside")
                  translate(v=[0,0,-box_t[0]])
                     rotate(a=[0,0,-rotation])
                     scale(v=[scale_x,scale_y,scale_z])
                     import(items_to_use);
               else if (align=="outside")
                  translate(v=[0,0,-depth])
                     rotate(a=[0,0,-rotation])
                     scale(v=[scale_x,scale_y,scale_z])
                     import(items_to_use);
               else
                  echo("invalid alignment", align);
            }
         }
      else if (face=="B")
         mirror(v=[items_mirror,0,0])
         {
            translate(v=[0,0,-box_h/2])
               rotate(a=[0,180,0])
               translate(v=[-(x_pos+x_offs),(y_pos+y_offs),0])
            {
               if (align=="inside")
                  translate(v=[0,0,-box_t[2]])
                     rotate(a=[0,0,-rotation])
                     scale(v=[scale_x,scale_y,scale_z])
                     import(items_to_use);
               else if (align=="outside")
                  translate(v=[0,0,-depth])
                     rotate(a=[0,0,-rotation])
                     scale(v=[scale_x,scale_y,scale_z])
                     import(items_to_use);
               else
                  echo("invalid alignment", align);
            }
         }
      else
      {
         echo("Unknown Face",face);
      }
   }
}

module make_texts(box, items)
{

   // External items on faces: [
   //    face_name, string,
   //    shape_position[
   //       x_pos,y_pos,x_offs,y_offs,rotate,align],
   //    shape_size[
   //      scale_z,scale_x,scale_y,mirror]]
   //    shape_position[
   //       x_pos,y_pos,x_offs,y_offs,rotate,align],
   //    shape_size[depth,font_height,font_spacing,mirror]

   // Note: for silly reasons mirror must be 0 or 1 corresponding to
   // false and true in this version
   // Example: ["N", "tyndall_logo_v0_2.stl", [0,0,0,0,0,"outside"],
   // [1,1,1,0]]
   echo ("make_items");
   a_bit=0.01;
   box_l=box[0];//x
   box_b=box[1];//y
   box_h=box[2];//z
   box_t=[box[5],box[5],box[5]];  // wall_t [x,y,z]

   // %cube(size=[box_l,box_b,box_h],center=true);

   x_pos = 0;
   y_pos = 0;
   face = "X";
   echo("len(items)",len(items));
   for (j=[0:len(items)-1])
   {
      face = items[j][0];
      text_to_type=items[j][1];
      x_pos = items[j][2][0];
      y_pos = items[j][2][1];
      x_offs= items[j][2][2];
      y_offs= items[j][2][3];
      rotation=items[j][2][4];
      align=items[j][2][5];
      depth=texts[j][3][0];
      text_height=texts[j][3][1];
      text_mirror=texts[j][3][2];
      //echo("items face",face);
      if (face=="N")
         mirror(v=[text_mirror,0,0])
         {
            translate(v=[0,box_b/2,0])
               rotate(a=[-90,0,0])
               translate(v=[-(x_pos+x_offs),-(y_pos+y_offs),0])
            {
               if (align=="inside")
                  translate(v=[0,0,-box_t[1]-a_bit])
                     rotate(a=[0,0,-rotation])
                     extrude_text(
                        text_to_type, text_height, depth+a_bit, font_name);
               else if (align=="outside")
                  translate(v=[0,0,-depth])
                     rotate(a=[0,0,-rotation])
                     extrude_text(
                        text_to_type, text_height, depth+a_bit, font_name);
               else
                  echo("invalid alignment", align);
            }
         }
      else if (face=="E")
         mirror(v=[0,text_mirror,0])
         {
            translate(v=[box_l/2,0,0])
               rotate(a=[0,90,0])
               rotate(a=[0,0,-90])
               translate(v=[-(x_pos+x_offs),-(y_pos+y_offs),0])
            {
               if (align=="inside")
                  translate(v=[0,0,-box_t[0]-a_bit])
                     rotate(a=[0,0,-rotation])
                     extrude_text(
                        text_to_type, text_height, depth+a_bit, font_name);
               else if (align=="outside")
                  translate(v=[0,0,-depth])
                     rotate(a=[0,0,-rotation])
                     extrude_text(
                        text_to_type, text_height, depth+a_bit, font_name);
               else
                  echo("invalid alignment", align);
            }
         }
      else if (face=="T")
         mirror(v=[text_mirror,0,0])
         {
            translate(v=[0,0,box_h/2])
               rotate(a=[0,0,0])
               translate(v=[(x_pos+x_offs),(y_pos+y_offs),0])
            {
               if (align=="inside")
                  translate(v=[0,0,-box_t[2]-a_bit])
                     rotate(a=[0,0,-rotation])
                     extrude_text(
                        text_to_type, text_height, depth+a_bit, font_name);
               else if (align=="outside")
                  translate(v=[0,0,-depth])
                     rotate(a=[0,0,-rotation])
                     extrude_text(
                        text_to_type, text_height, depth+a_bit, font_name);
               else
                  echo("invalid alignment", align);
            }
         }
      else if (face=="S")
         mirror(v=[text_mirror,0,0])
         {
            translate(v=[0,-box_b/2,0])
               rotate(a=[+90,0,0])
               translate(v=[-(x_pos+x_offs),(y_pos+y_offs),0])
            {
               if (align=="inside")
                  translate(v=[0,0,-box_t[1]-a_bit])
                     rotate(a=[0,0,-rotation])
                     extrude_text(
                        text_to_type, text_height, depth+a_bit, font_name);
               else if (align=="outside")
                  translate(v=[0,0,-depth])
                     rotate(a=[0,0,-rotation])
                     extrude_text(
                        text_to_type, text_height, depth+a_bit, font_name);
               else
                  echo("invalid alignment", align);
            }
         }
      else if (face=="W")
         mirror(v=[0,text_mirror,0])
         {
            translate(v=[-box_l/2,0,0])
               rotate(a=[0,-90,0])
               rotate(a=[0,0,-90])
               translate(v=[-(x_pos+x_offs),(y_pos+y_offs),0])
            {
               if (align=="inside")
                  translate(v=[0,0,-box_t[0]-a_bit])
                     rotate(a=[0,0,-rotation])
                     extrude_text(
                        text_to_type, text_height, depth+a_bit, font_name);
               else if (align=="outside")
                  translate(v=[0,0,-depth])
                     rotate(a=[0,0,-rotation])
                     extrude_text(
                        text_to_type, text_height, depth+a_bit, font_name);
               else
                  echo("invalid alignment", align);
            }
         }
      else if (face=="B")
         mirror(v=[text_mirror,0,0])
         {
            translate(v=[0,0,-box_h/2])
               rotate(a=[0,180,0])
               translate(v=[-(x_pos+x_offs),(y_pos+y_offs),0])
            {
               if (align=="inside")
                  translate(v=[0,0,-box_t[2]-a_bit])
                     rotate(a=[0,0,-rotation])
                     extrude_text(
                        text_to_type, text_height, depth+a_bit, font_name);
               else if (align=="outside")
                  translate(v=[0,0,-depth])
                     rotate(a=[0,0,-rotation])
                     extrude_text(
                        text_to_type, text_height, depth+a_bit, font_name);
               else
                  echo("invalid alignment", align);
            }
         }
      else
      {
         echo("Unknown Face",face);
      }
   }
}

module extrude_text(string, height, depth, font_name)
{
   linear_extrude(depth)
   {
      text(text=string, size=height, font=font_name);
   }
}
