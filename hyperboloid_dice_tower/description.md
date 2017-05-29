A [hyperboloid](https://en.wikipedia.org/wiki/Hyperboloid_structure) [diagrid](https://en.wikipedia.org/wiki/Diagrid)  lattice dice tower, looking like a mix of one of [Vladimir Shukhov](https://en.wikipedia.org/wiki/Vladimir_Shukhov)’s towers and a power plant’s cooling tower.

I did print David South’s “bone” dice tower (thing 621548). It works and looks fine, but i was a bit disappointed when i realized that the columns were curved and not straight lines.

So, here are lots of straight beams or wires (even the rings are really polygons) that form a dice tower.

There is also just the “cooling tower” shell. That is just a sculpture without much practical use.

## Printing

The thing prints out surprisingly easily, and is stable enough for its job. It is probably one of the lightest full size dice towers out there. (If somebody build one out of an [aerogel](https://en.wikipedia.org/wiki/Aerogel), i want to see it!) Mine weighs 15 g, the bone dice tower 66 g, and th “angular dice tower” (thing 617991) 106 g without trays.

Use standard settings. I used PLA, 200 µm layers and normal speeds. Print it the way it’s oriented, with the feet up in the air. The one from the images were done in PETG, which works fine as well.

You need reasonably good bed adhesion, as the contact area isn’t all that big. For the flimsy version, you may want to use blue tape, remove tower and tape together and then peel of the tape from the tower.

Don’t use a raft. Trying to get it off will most likely break the tower instead. A brim might work, though. Falsework (supports) would be just a waste of material.


## Post printing

Depending on your slicer and how well retraction works, you may end up with a lot of “hairs” connecting the wires. While You can experiment with the retract settings and flow rate to get rid of them, i just accept them. For me they are part of the finished structure, and so i did no clean up on mine. They probably add a bit of strength, too.


## How i designed this

Creating a hyperbolic lattice shell could hardly be easier in OpenSCAD. You make a thin cuboid, move it away from the centre, tilt it, rotate it, and make some copies of it:
```openscad
for (o = [0:s:360-s])
   rotate(o)
      translate([r_t, 0, 0])
         rotate([a_1, 0, -a_2])
            translate([0,0, l/2])
               cube([w, w, l], center=true);
```

Do it with the angles in the other direction, and your shell is done.

I didn’t calculate the ring radiuses, but tweaked them by hand. The same for the height of the shell. I just picked the length of one wire and put the last ring at the height it came out.

Design files and history can be found at github, in [a directory](https://github.com/ospalh/3d-printing/tree/develop/hyperboloid_dice_tower) of my 3d printing repo there.
