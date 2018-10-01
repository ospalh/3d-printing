Stacking and storage aid for coin collections.

This allows you to stack and store coins of different sizes. I use it to reduce the storage volue of a coin collection i inherited. I don’t want to sell it, but don’t want it to waste too much space in my cupboard, either.

You must use OpenSCAD to adopt this to the coins you want to store.
The thing to adapt is the `coin_sizes` vector at the beginnig. Put in a pair of values for each coin size you want to store, diameter and height of the coin stack. The example is for the numbers of French Francs i used this for. Follow the example, but use your coin sizes and numbers. You can use as few or as many value pairs as you need.


With the lid, you can put a bit Tesa or other stick tape around it without problem.

This uses a lot of clearance. You can reduce it in the OpenSCAD file, but i prefer the coins rattling a bit to spending too much time sanding and filing this into shape.

# print

easy

200µm

0 % (!)

# how

This is a generalization of my euro coin stacker. This file is actually a bit shorter, and uses recursive functions, where the euro file unrolles things.

This uses somewhat thin walls, because it is not intended to carry significant loads, just to keep the coins in place. It uses somewhat complicated calculations to get the outer slopes right.

There is some design history available at my [github repo](https://github.com/ospalh/3d-printing/tree/develop/eurostack).
