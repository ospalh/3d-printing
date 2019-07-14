A parametric ball bearing finger cap. This is based on [bda](https://www.thingiverse.com/bda/about)’s “[Customizable comfy spinner caps. Cap for any bearing.](https://www.thingiverse.com/thing:2319653)”, but you have to put in some measures as length (in millimetre). The important ones:

* Shaft diameter: size of the inner hole of the bearing
* Bearing hight: distance between the two flat surfaces of the bearing. The shaft of the cap will be 45 % of this and two caps will fit into the bearing.
* Cap diameter: the diameter of the cap. This can be smaller or larger than the outer diameter of the bearing. Pick this to taste. I use 1 mm less than the bearing size. 21 mm for the 22 mm ⌀ 608 bearing.

Some more things can be set up in the customizer, and even more things in the `scad` file.

The caps in the images of most of my “[yacs](https://www.thingiverse.com/tag:yacs)” fidget toys are this one.

## how print

The reason i like this is that this design brings along its own falsework and brim. I had a real problem getting off the slic3r-generated falsework from the “[Super Bearing Cap - 21 mm](https://www.thingiverse.com/thing:2306009)”s and ended up printing them stem up.

So, select “Falsework and brim” in the customizer and *no* “supports” in the slicer.


## post printing

Remove the falsework with a wood carving knife or similar. Trim parts of the underside hanging below the rim. Clip into your bearing. Use a file, or the customizer, OpenSCAD or your slicer to change the scale when it doesn’t fit at first because of printer tolerances.


## how designed:

Q: What does an engineer do when you hand em a red rubber ball and ask for its volume?
A: Look at it, and when ey’s found the model number look up the volume in eir red-rubber-ball reference table.

I liked some aspects of bda’s comfy bearing cap so much that i took it as the base for this. What i didn’t like was that you had to put in the model number of your bearing, and it worked only for an – admittedly – long list of bearings. The one i wanted wasn’t among them. So i changed this and you have to put in some length now. I also changed the way the main shape of the pin and cap is defined, check out the `scad` file for details.

More visible: i replaced the chamfer on the *bottom* and top of the cap part with a rounding (or fillet) on top. Prints much better now, at least for me.

As always, (my part of the) design history at [github](https://github.com/ospalh/3d-printing/tree/develop/bdas_bearing_caps).

## Vocabulary rant

***[falsework](https://en.wiktionary.org/wiki/falsework)***: a temporary frame serving to support and brace a building under construction until it can stand alone.

In other word, those structures that you sometimes need when printing overhangs.My guess is that the first people that wrote a slicer just didn’t know that word, maybe even the large scale construction *concept*, and reinvented the wheel and named it the “circular transportation facilitation device”. Or “supports”. I try my best to use the correct word, falsework, when possible.
