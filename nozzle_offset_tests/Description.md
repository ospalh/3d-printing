Yet another dual extruder test.

This one is actually two tests, one coarse and one fine.



## Printing instruction

Use whatever setting you want to use for your dual extrusion print later.

## Usage

### Coarse test

The coarse test can be done in two ways, with
[ditto printing](http://jettyfirmware.yolasite.com/features.php) or
traditionally. Use the one or two rough calibration stl files for
this.

When you use ditto printing you *must* set the nozzle offset in the scad file as well as you know it. It’s set to the standard value of 36 mm x offset and 0 y offset. Those are used for the stl file.

When you’ve finished printing the cubes, take a photo of the print bed to check the orientation of the error later.

To measure the results, measure the hight of the whole three cube block
and subtract the hight of one of the end cubes. That is, zero your
caliper when measuring the hight of an end cube and then measure the
heigt of the three cube. Those are the absolute values of the offset. Think about whetehr you have to subtract or add them in your slicer, and print again with the correction.


### Fine test

The fine test patterns are too big for ditto printing. Use standard dual extrusion.

Here you should set the nozzle diameter when it’s not 0.4 mm. Different nozzle diameters for first and second extruder are not supported.

When the print is done you should take a high resolution photo of the patterns on the print bed. Removing them may shift the patterns and making them useless.

The comb structures are verniers. Use the center lines to determine the direction of the offset, and count which line on the bottom lines up exactly with a line at the top. That, multiplied by 0.05 mm, is your remaining offset.
