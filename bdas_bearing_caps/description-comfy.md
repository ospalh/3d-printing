A parametric ball bearing finger cap. This is based on [](), but you have to put in some measures as length (in millimetre). The important once:

* Shaft diameter: size of the inner hole of the bearing
* Bearing height: distance between the two flat surfaces of the bearing. The shaft of the bearing will be 45 % of this, and two caps will fit into the bearing.
* Cap diameter: the diameter of the cap. This can be smaller or larger than the outer diameter of the bearing. Pick this to taste. I use 1 mm less than the bearing size. 21 mm for the 22 mm ⌀ 608 bearing.

Some more things can be set up in the customizer, and even more things in the `scad` file.

## how print

The reason i like this is that this design brings along its own falsework and brim. I had a real problem getting off the slic3r-generated falsework from [21 mm] caps.

So, select “Falsework and brim” in the customizer and *no* falsework (called “supports” in the software¹)


¹
## how designed:

Q: What does an engineer do when you hand em a small red rubber ball and ask for its volume?
A: Look at it, and when ey’s found the model number look up the volume in eir small-red-rubber-ball reference table.

I liked some aspects of [bdas]()’s comfy bearing cap so much that i took it as the base for this. What i didn’t like was that you had to put in the model number of your bearing, and it worked only for a longish list of bearings. The one i wanted wasn’t among them. So i changed this and you have to put in some length now. I also changed the way the main shape of the pin and cap is defined, check out the `scad` file for details.

More visible: i replaced the chamfer on the *bottom* and top of the cap part with a fillet on top. Prints much better now, at least for me.

As always, design history at [github]().
