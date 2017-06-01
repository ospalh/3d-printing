Yet another coin fidget spinner. This one is tiny three arm version. it uses stacks of four 1 eurocent coins per arm and a 5 mm × 11 mm × 5 mm bearing, called “685”, in the centre.


# How designed

This is slightly parametric. Whit a bit of work you can use your favourite coins, either local currencies, or parts of that little pile of foreign currency that travellers tend to collect. For that i have included the FreeCAD files. They include a spreadsheet called “sizes”. To get a new spinner, do this:

* Download [FreeCAD](https://www.freecadweb.org/wiki/Download) and get it running
* Load the `685_coin_spinner_3_arm.fcstd` FreeCAD file
* In the tree view, double click on “Sizes”. You should see the spreadsheet
* Measure your coin or look up its size (Wikipedia, search engine, &c.)
* Put in the diameter and thickness in `B6` and `B7`. Make sure to keep the `=` and `mm`.
* Check that you have enough coins. The spreadsheet shows the number needed. Typically 12.
* Change other values in the “B” column, like the whole spinner’s size, to taste.
* Go back to the `685_coin_spinner_3_arm` view
* Check that the shown shape looks OK. There are view controls at the top
* Check that in the tree view there are no exclamation marks as warnings
* If the spinner looks good, select the last item, “spinner”. It should turn green in the main view.
* If not, it’s easiest to close *without* saving and to try again. Change fewer values, and only by small amounts, but the small size of the central bearings means you can’t really use coins much larger than the 1 eurocent.
* Look for the dropdown in the tool bar and select “Mesh Design”
* You should now have a “Meshes” menu. Select “Create mesh from shape …”
* I have to select the “Standard” radio button. “Mefisto” produces empty meshes.
* Click OK
* There should be a “spinner (Meshed)” item in the tree view. Select it.
* Click on the “Export a mesh to file” icon, enter a file name, select file type (STL or OBJ) and name and click “OK”,
* Et voilà, you’re done. You have finished your first FreeCAD lesson and can now go ahead and slice and print your customized spinner.

The FreeCAD version is for the more compact (thin walled) version.

There is also some design history available at my [github repo](https://github.com/ospalh/3d-printing/tree/develop/yacs).
