A trick for people without a filament fan.

Put this on the build plate along with your object to print, and your part will have a bit of time to cool down whil this is printed.



Print settings

There are two ways to use this: with OpenSCAD or with your slicer.

For both ways you first have to check the critical height of your real part. That is, the top and bottom height of those small bits where you need (passive) cooling.

* Set the top and bottom height in the `scad` file or, when it’s working, the customizer.
* Use either the solid or half wall `STL` and use your slicer to cut it to the right height.
* Use your slicer to print the wall slowly while keeping the normal speed for the real part.

I use slic3r, and this is how to do the speed setting there:
* Select the wall
* Click on “Settings”
* Add (+) “Speed (perimeters)”
* Put in a low value like 10 mm/s.

Post printing:

Throw this part away. Scrap parts of it that ended up on the the part you wated off it with a knife.
