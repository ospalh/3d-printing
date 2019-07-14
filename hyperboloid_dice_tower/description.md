A [hyperboloid](https://en.wikipedia.org/wiki/Hyperboloid_structure) [diagrid](https://en.wikipedia.org/wiki/Diagrid)  lattice dice tower, looking like a mix of one of [Vladimir Shukhov](https://en.wikipedia.org/wiki/Vladimir_Shukhov)’s towers and a power plant’s cooling tower.


### Diceware and KeePassXC

Apart from reducing cheating at dice games, dice towers are a great way to generate passwords that are easy to remember and strong. Look up the principles at [diceware](http://world.std.com/~reinhold/diceware.html) and get nicely formatted English or German lists from my github [LaTeX diceware](https://github.com/ospalh/latex-diceware/) repo, for the standard 5 x 6-sided dice or 3 × 20-sided dice.
On the other hand [KeePassXC](https://keepassxc.org/) and presumably other password managers can use wordlists and generate diceware-like passwords for you.



## Printing

The thing prints out surprisingly easily, and is stable enough for its job.

Use standard settings. I used PLA, 200 µm layers and normal speeds. Print it the way it’s oriented, with the feet up in the air.

Don’t use a raft. Trying to get it off will most likely break the tower instead. A brim might work, though. No falsework (supports).


## Post printing

Depending on your slicer and how well retraction works, you may end up with a lot of “hairs” connecting the wires. While You can experiment with the retract settings and flow rate to get rid of them, i just accept them. For me they are part of the finished structure, and so i did no clean up on mine. They probably add a bit of strength, too.


## How i designed this

I did print David South’s [bone dice tower](https://www.thingiverse.com/thing:621548). It works and looks fine, but i was a bit disappointed when i realized that the columns were curvd and not straight lines.


So i made a dice tower out of straight beams or wires (even the rings are really polygons).
It is probably one of the lightest full size dice towers out there. (If somebody build one out of an [aerogel](https://en.wikipedia.org/wiki/Aerogel), i want to see it!) Mine weighs 15 g, the bone dice tower 66 g, and the “[angular dice tower](https://www.thingiverse.com/thing:617991)” 106 g without trays.

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

I didn’t calculate the ring radiuses, but tweaked them by hand. The same for the hight of the shell. I just picked the length of one wire and put the last ring at the hight it came out.

Design files and history can be found at github, in [a directory](https://github.com/ospalh/3d-printing/tree/develop/hyperboloid_dice_tower) of my 3d printing repo there.

This is a rework of a version i publisht at [YouMagine](https://www.youmagine.com/designs/hyperboloid-dice-tower). I changd it from four to three ramps, aded a “lid” so you hav to throw the dice onto the first ramp, and removd the circular hole you could throw small dice straight thru.
