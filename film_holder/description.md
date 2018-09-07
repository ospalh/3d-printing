Reflecta Minox film holder

A film strip holder to scan Minox “spy camera” film with a [Reflecta ProScan 10T](https://reflecta.de/en/products/detail/~id.734~nm.69/reflecta-ProScan-10T.html) cheap-compared-to-drum-scanners film scanner i own. I think the predecessor, the ProScan 7200 uses the same holders.

This uses eight tiny 1 mm high × 2.4 mm ⌀ neodymium magnets to hold shut. If you have other sizes lying around you can modify the file in OpenSCAD.

There is also a bit of preparation to adapt this to 110 film. Use OpenSCAD, again.

##How to print

Use black to reduce stray light. PLA is fine, print settings aren’t too important. No falsework required. Warping might be a problem, so use a brim or raft if you have to.


## Post-printing

This needs a bit of deburring. I also sanded mine all over to give it a matte finish.


### Glueing in the magnets

Glueing in the magnets was surprisingly tricky. They tend to fly through the air towards any piece of iron and to flip over all the time. I came up with this procedure.

#### Tools

* The eight magnets
* The holder and clamp
* Magnetic surface to store stacks of magnets. A “copper” (iron) coin like 1, 2 or 5 eurocent works fine
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


## How designed

First i looked at shred’s [110 film holder](https://www.thingiverse.com/thing:1328672) for plustek scanners. Firt change the outer size to “Reflecta”, scan my stack of 110 films, than change the film size and scan the Minox. Turns out i only had one 110 film, which i scanned on my flatbed scanner. So i started over from scratch.

I briefly experimented with a hinge (based on rohinosling’s  [parametric hinge](https://www.thingiverse.com/thing:2187167)) but i had too much problems breaking them free. The original Reflecta film holders have a hinge.

For a while i had planned to bury the magnets. Pause the print, put them in, let them be covered by PLA. The putting in worked OK, but i later found them on the steel extruder carrier. They had leaped up when a big iron mass passed by, foiling this plan.

There was also a version with thin bars to separate the images, but as the spacing of them on the Minox films i have is so irregualr i dropped that.

There is some design history available at my [github repo](https://github.com/ospalh/3d-printing/tree/develop/Reflecta-Minoxhalter).
