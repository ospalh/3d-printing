A trick for people without a filament fan.

Put this on the build plate along with your object to print, and your part will have a bit of time to cool down whil this is printed.

Set the heights to the bottom and top heights where you have problems with your part.

I think printing this in y rather than x direction reduces the chance of it tipping over on Průša-style printers. (Here the wind, along with the accelaration, might play a role.)

Print settings

This needs some advanced setup. I know slic3r, and this is how to do it there:
* You need both `STL`s, the wall and the modifier
* Load the wall as a normal part. Place it on the build plate. Away from the real parts, if possible.
* Open the wall’s settings.
* Click on “Load modifier...” and load the modifier `STL`.
* Select the modifier in the tree view
* Click the green “+” and pick “Speed > Perimeters”
* Set this to a low value. The lower, the longer the print head loiters on the wall.
* The wall is 100 mm long. A perimeter speed of, for example, 10 mm/s gives you ten seconds cooling time for your part.

Post printing:

Throw this part away. Scrap parts of it that ended up on the the part you wated off it with a knife.
