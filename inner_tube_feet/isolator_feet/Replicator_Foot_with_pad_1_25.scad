//  Replicator foot for gripper pad
//  The pad used is a one inch diameter, brand name 'SoftTouch by Waxman  #7385'
//  They come 16 to a package and I think I either got these at Walmart or Lowe's Hardware.

//  1/13/13 - GAC:  enlarged foot area slightly to take 1.25" dia Sorbothane isolators -
//  http://www.amazon.com/gp/product/B003IMJ3S2/ref=oh_details_o02_s02_i00



difference () {
	union(){
		translate ([ 15, 15, -8]) cylinder (h=20, r=15.5, $fn=100);
		translate ([ 15, 15, -8]) cylinder (h=5, r=20, $fn=100);
		translate ([ 15, 15, -6]) cylinder (h=5, r=18, $fn=100);
		translate ([ 5, 16, -8]) cylinder (h=20, r=8, $fn=100);
		translate ([ 5, 14.75, -8]) cylinder (h=20, r=8, $fn=100);
		translate ([ 16,5, -8]) cylinder (h=20, r=8, $fn=100);
		translate ([14.75,5, -8]) cylinder (h=20, r=8, $fn=100);
	} // union

	translate ([ 15, 15, -16]) cylinder (h=10, r=17);
	translate ([-10,2,1]) cube (size = [60,5.65,15], center = false);
	rotate ([0,0,270]) translate ([-50,2,1]) cube (size = [60,5.65,15], center = false);
	rotate ([0,0,270]) translate ([-65,15,-1]) cube (size = [50,50,16], center = false);
	
	// added a couple of holes for a 3mm setscrew if needed to hold foot in place
	translate ([22, 16, 6]) rotate (a = [90, 0, 0]) cylinder (h = 10, r = 1.5, $fn = 30);
	translate ([6, 22, 6]) rotate (a = [0, 90, 0]) cylinder (h = 10, r = 1.5, $fn = 30);

} // difference


translate ([10,7.9,0])
rotate ([-4,0,0])
cylinder (h=8, r=.8, $fn=20);

translate ([20,7.9,0])
rotate ([-4,0,0])
cylinder (h=8, r=.8, $fn=20);

translate ([7.9,10,0])
rotate ([0,4,0])
cylinder (h=8, r=.8, $fn=20);

translate ([7.9,20,0])
rotate ([0,4,0])
cylinder (h=8, r=.8, $fn=20);