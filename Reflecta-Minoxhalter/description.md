A film strip holder to scan Minox “spy camera” film with a [Reflecta ProScan 10T](https://reflecta.de/en/products/detail/~id.734~nm.69/reflecta-ProScan-10T.html) cheap-compared-to-drum-scanners film scanner i own. I think the predecessor, the ProScan 7200 uses the same holders.

This uses eight tiny 1 mm high × 2 mm ⌀ neodynium magnets to hold shut. If you have other sizen lying around you can modify the file in OpenSCAD.

There is also a bit of preparation to adapt this to 110 film. Use OpenSCAD, again.

##How to print

Print settings aren’t too important. No falsework required. Warping might be a problem, so use a brim or raft if you have to. It is designed with a 0.4 mm nozzle and 200 µm layers in mind.

You do need to pause the print to put in the magnets 0.4 mm before the main parts are finished.

N.B.: Make sure you put them in in the right direction. I used a pen to mark the same pole on all of them, the top side when they formed a stack, and then put them in with the mark up for the holder proper and down for the clamp.


## Post-printing

This needs a bit of deburring. I also sanded mine all over to give it a matte finish.

## How designed

First i looked at shred’s [110 film holder](https://www.thingiverse.com/thing:1328672) for plustek scanners. Firt change the outer size to “Reflecta”, scan my stack of 110 films, than change the film size and scan the Minox. Turns out i only had one 110 film, which i scanned on my flatbed scanner. So i started over from scratch.

I briefly experimented with a hinge (based on rohinosling’s  [parametric hinge](https://www.thingiverse.com/thing:2187167)) but i had too much problems breaking them free. The original Reflecta film holders have a hinge.

There is some design history available at my [github repo](https://github.com/ospalh/3d-printing/tree/develop/Reflecta-Minoxhalter).
