A multi-lingual two tone flip calendar based on [O.T. Vinta](https://www.thingiverse.com/otvinta3d/about)’s [flip calendar](https://www.thingiverse.com/thing:1785261).

That thing is a great idea, but i had some problems with it.
* The fulcrums are desigend with not enough clearance for my taste
* I can’t stand the ALL CAPS shouty month names.
* Also, there was no German version ready
* I like more contrast for the text
* And the “TURN SLOWLY” and “CHANGE MONTH” will be annoying after a month or two.

So, the changes:

* I added extra clearance to the fulcrums
* The month text has been separated into a set of cards to be put into a month card carrier. There are several versions ready
  * English
  * German
  * Euro-Arabic numbers
  * Roman numbers
  * You can add other languages by changing the text in `Monatskarten.scad` in OpenSCAD and rendering it. Make sure you use a font you have.
* The English and German texts use lower case latters.
* The day and month cards are for two (or three) tone printing.
* While there are »Monat drehen« and »langsam drehen« cards, i also added some random emoji to fill the backs of the extra day cards. You can change these, too, to taste. Use `Tagestafel.scad` and OpenSCAD. I found the “Symbola” font useful for this.


# Print settings


Print the day cards a few at a time with two or three tone printing, the month cards with two tone printing.

* Print the first 400 µm (two layers) with one colour
* pause, switch filament to another colour
* print until 400 µm before the top
* switch back to the first color, or a third one.
* I usend orange and black for most cards, and orange, black, red for the cards with non-day backs.
* For the month cards, do only one filament change, start with the background color.

I printed the card carrier box without supports.


## Post-printing

It card carrier needed quite a bit of filing of the gap, but worked fine in the end.

Check out the assembly instructions at the original.

The day cards needed a lot of sanding.

The month cards have to be put into the month card carrier carousell, obviously.


## How desigend

As said above and at the left, this is derived from [O.T. Vinta](https://www.thingiverse.com/otvinta3d/about)’s [flip calendar](https://www.thingiverse.com/thing:1785261).
Some of the parts, the card carrier, two part base, knob and washer, are unchanged from the original.
The arms are slightly modified, with thinner fulcrums, the month card carrier is modified a bit more.
Finally, for the day cards i started from scratch.

There is some design history available at my [github repo](https://github.com/ospalh/3d-printing/tree/develop/Drehkalender). Don’t look at the version that i used to produce the “Jnya-aa” card on a Mac. I’m serious.
