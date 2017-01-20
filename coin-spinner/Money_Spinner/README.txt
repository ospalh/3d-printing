                   .:                     :,                                          
,:::::::: ::`      :::                   :::                                          
,:::::::: ::`      :::                   :::                                          
.,,:::,,, ::`.:,   ... .. .:,     .:. ..`... ..`   ..   .:,    .. ::  .::,     .:,`   
   ,::    :::::::  ::, :::::::  `:::::::.,:: :::  ::: .::::::  ::::: ::::::  .::::::  
   ,::    :::::::: ::, :::::::: ::::::::.,:: :::  ::: :::,:::, ::::: ::::::, :::::::: 
   ,::    :::  ::: ::, :::  :::`::.  :::.,::  ::,`::`:::   ::: :::  `::,`   :::   ::: 
   ,::    ::.  ::: ::, ::`  :::.::    ::.,::  :::::: ::::::::: ::`   :::::: ::::::::: 
   ,::    ::.  ::: ::, ::`  :::.::    ::.,::  .::::: ::::::::: ::`    ::::::::::::::: 
   ,::    ::.  ::: ::, ::`  ::: ::: `:::.,::   ::::  :::`  ,,, ::`  .::  :::.::.  ,,, 
   ,::    ::.  ::: ::, ::`  ::: ::::::::.,::   ::::   :::::::` ::`   ::::::: :::::::. 
   ,::    ::.  ::: ::, ::`  :::  :::::::`,::    ::.    :::::`  ::`   ::::::   :::::.  
                                ::,  ,::                               ``             
                                ::::::::                                              
                                 ::::::                                               
                                  `,,`


http://www.thingiverse.com/thing:1937473
MoneySpinner by GeoffB is licensed under the Creative Commons - Attribution license.
http://creativecommons.org/licenses/by/3.0/

# Summary

I liked CarryTheWhat's spinner toy that they have published here:
http://www.thingiverse.com/thing:1871997

But given that roller bearings can be a little scarce, I wanted to use some mass that was more readily available. I also wanted some more practice developing 'if...else' loops in OpenSCAD.

So I present MoneySpinner, a collection of spinner toys that use appropriately sized and globally available coins as the spinning mass. 

Depending on your country, you can download an STL to print that uses readily available coins that (hopefully) press fit into the holders. The STLs have the coin type followed by the number of spokes in their filenames.

The OpenSCAD file caters for between two and seven spokes and the following coins:
-   Australian $2
-   Australian 5c
-   US 10c (dime)
-   UK £1
-   UK 5p
-   EU €1
-   Qatari 50 dirham, and
-   US 5c (nickel).

I have now uploaded the scad file into the Customizer. Please tell me how it works out for you. Additionally, I have uploaded a selection of STLs to cater for most people's desires. 

Most options accommodate two coins in each 'stack'. When using AU 5c, US 10c and UK 5p, three coins per stack can be fitted. I have sourced the dimensions (diameter and thickness) from reliable sources on the web but if you print one of these and have major problems fitting the coins, please provide me with feedback.

I have also used the excellent knurling function provided by aubenc's library here:
http://www.thingiverse.com/thing:32122 

Update 1: I have printed a number of these now.Tolerances are fairly tight, an Australian $2 fits well but the 5 cent coin has a tendency to break through one or more ring as the 3 coins are pressed in. My solution has been to scale the STL up by 100.5% in Simplify 3D when I make my gcode. 101% made the bearing a bit loose. Your mileage may vary.

Update 2: I deleted the CR2032 option in case someone sets fire to themselves. Instead, as requested there is now a US 5c (Nickel) option. It assumes stacks of 4 (as requested). Tell me if this doesn't work. It seems like you will need long fingers!

Update 3: Now includes a smooth edge option for those with soft fingers! Look for the 3 spoke US 5c STL and the Smooth option in the Customizer.

# Print Settings

Printer Brand: Printrbot
Printer: Simple Black
Rafts: Doesn't Matter
Supports: No
Resolution: 0.2mm
Infill: 20%

Notes: 
I use a raft to ensure adhesion without a heated bed. As these are only several millimetres thick, it is important to ensure they remain attached throughout the print.

# How I Designed This

I designed this using OpenSCAD. The current code incorporates switches that select the number of spokes (between 2 and 7) and the coin type by name. The dimensions of individual coin types are hard coded and selected automatically through an *if...else* sequence.

A 'spoke' is built using a knurled disk of appropriate dimensions with a void and attached to an 'arm' which is proportional to the coin diameter.

The length of the spoke is dependent on the dimensions of the coin and must be able to be spun between a thumb and finger without hitting the web in between. I think a €1 coin, which has a diameter of 23.3mm is the limit and may be too big for many people.

The spoke is then rotated by the appropriate angle using a *for()* loop and attached to a hub that is appropriate for a standard 22mm rollerskate bearing.