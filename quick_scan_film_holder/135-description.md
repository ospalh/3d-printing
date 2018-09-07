Reflecta x7-Scan  scan accelerater

This is a replacement for the Reflecta x7-Scan 135 film holder that allows you to quickly push the strips through the digitizer.

The point of the small camera based film digitizers is, apart from the price, the speed. (Resolution¹ and scratch removal are sacrificed for this.) But the standard Reflecta film holders requires a number of steps:

* Pull holder out of digitizer
* Open holder
* Clean the film
* Carefully position film
* Close holder
* Insert holder into digitizer
* Then you have to take the four pictures, one by one

That takes too long! I want to digitize literally hundreds of old films.

So, with this you grab a strip, clean it, push it into the digitizer a bit, take a picture, shove it in a bit more, picture, shove, picture, shove, picture, yank out the strip. Done. Next.

N.B.: The advantage of the open and close holder is that it is nicer to your film strips. Don’t use this things with precious negatives. Only some old ones that take up too much space. I cant guarantee that you won’t scratch up some of them.

This uses eight tiny 1 mm high × 2.4 mm ⌀ neodymium magnets to hold shut. If you have other sizes lying around you can modify the file in OpenSCAD.


This should be somewhat easy to modify for other image sizes (126/instamatic), film strips (16 mm films like 110) and film digitizers. Get OpenSCAD and modify the header section of the design file for this, too.

##How to print

Use fine resolution (100 µm) to get the steps of the wedge as smooth as possible off the print bed. When you know how to do it you can use 100 µm only for the wedge part and higher values for parts below or above it.
Print with black filament to reduce stray light. PLA is fine, but aceton smoothing of ABS might be a good idea. Other print parameters aren’t important. No falsework required. Warping might be a problem, so use a brim or raft if you have to.


## Post-printing

This needs a bit of deburring and a lot of sanding. The wedge should be a smooth inclined plane. The film comes into contact with large areas of this and the bottom part should be as smooth as possible, too.



### Glueing in the magnets

Glueing in the magnets was surprisingly tricky. They tend to fly through the air towards any piece of iron and to flip over all the time. See the procedure for my [Reflecta Minox film strep holder](thingX) for details.

## How designed

This is based off my [Reflecta Minox film strip holder](thing X). See notes there.

There is some more design history available at my [github repo](https://github.com/ospalh/3d-printing/tree/develop/Reflectabeschleuninger).



¹In the sense of “seeing details” or “separating lines”, instead of  “pixel count”.
