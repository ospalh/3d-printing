Reflecta Scan 7 scann accelerater

This is a replacement for the Reflecta Scan7 135 film holder that allows you to quickly push the strips through the digitizer.

The point of the cheap camera based film digitizers is, apart from the price, the speed. (Resolution and scratch removal are sacrificed for this.) But the standard Reflecta film holder requires a number of steps:

* Pull holder out of digitizer
* Open holder
* Clean the film
* Carefully position film
* Close holder
* Insert holder into digitizer
* Then you have to take the four pictures, one by one

That takes too long! I want to digitize literally hundreds of old films.

So, with this you grab a strip, clean it, push it into the digitizer a bit, take a picture, shove it in a bit more, picture, shove, picture, shove, picture, yank out strip. Done. Next.

N.B.: The advantage of the open and close holder is that it is nicer to your film strips. Don’t use this things with precious negatives. Only some old ones that take up too much space. I cant guarantee that you won’t scratch up some of them.

This uses eight tiny 1 mm high × 2.4 mm ⌀ neodymium magnets to hold shut. If you have other sizes lying around you can modify the file in OpenSCAD.


##How to print

Use fine resolution (100 µm) to get the steps of the wedge as smooth as possible off the print bed.
Use black to reduce stray light. PLA is fine, but aceton smoothing of ABS might be a good idea. Other print parameters aren’t important. No falsework required. Warping might be a problem, so use a brim or raft if you have to.


## Post-printing

This needs a bit of deburring and a lot of sanding. The wedge should be a smooth inclined plane. The film comes into contact with large areas of this and the bottom part should be as smooth as possible, too.



### Glueing in the magnets

Glueing in the magnets was surprisingly tricky. They tend to fly through the air towards any piece of iron and to flip over all the time. I came up with this procedure.

#### Tools

* The eight magnets
* The holder and clamp
* Magnetic surface to store stacks of magnets. A “copper” (iron) coin like 1, 2, 5 eurocent works fine
* Eight M3 or smaller bolts or similar iron rods
* Eight small (c. 1 cm × 5 cm) pieces of paper
* Pens, to mark metal surfaces and paper
* Super glue
* Latex or similar gloves
* Other protective materials. Newspaper for the table, face shield &c.

#### Procedure

* Make a stack out of the magnets on the coin
* Mark the top side of each magnet with a pen and form a second stack of marked magnets. This is to mark the same pole on all the magnets.
* Mark one side of all the pieces of paper
* Take one magnet and place it on the table alone
* Take a piece of paper and place it on top of the magnet, with the marked side up or down to match the magnet
* Take a bolt and put it on the magnet, clamping the paper
* Do this for the other seven magnets, too.
* Make sure the bolt-magnets don’t get too close to each other
* Make sure four have the mark up and four the mark down, both on the magnet and on the paper
* Don the gloves, open a window
* Take the holder and the four magnets with the mark up
* Festina lente
* For each, put a bit of glue into the magnet depression
* Re-seal the glue container
* Take the bolt with the magnet and put the magnet into the hole
* Hold down the paper and remove the bolt
* Remove the paper
* Repeat for the clamp and the magnets facing the other way


Used a pen to mark the same pole on all of the magnets, the top side when they formed a stack, and then put them in with the mark up for the holder proper and down for the clamp.


## How designed

First i looked at shred’s [110 film holder](https://www.thingiverse.com/thing:1328672) for plustek scanners. Firt change the outer size to “Reflecta”, scan my stack of 110 films, than change the film size and scan the Minox. Turns out i only had one 110 film, which i scanned on my flatbed scanner. So i started over from scratch.

I briefly experimented with a hinge (based on rohinosling’s  [parametric hinge](https://www.thingiverse.com/thing:2187167)) but i had too much problems breaking them free. The original Reflecta film holders have a hinge.

For a while i had planned to bury the magnets. Pause the print, put them in, let them be covered by PLA. The putting in worked OK, only when i wanted to check that they were still in place a while after the pause i found them on the steel extruder carrier. They had leaped up when a big iron mass passed by, foiling this plan.

There is some design history available at my [github repo](https://github.com/ospalh/3d-printing/tree/develop/Reflecta-Minoxhalter).
