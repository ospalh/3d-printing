A collection of all purpose wedges. These aren’t done with OpenSCAD but with FreeCAD, but are rounded (filleted).
There are four versions of FreeCAD files
* A wedge with a sharp edge, to be printed lying flat
* A blunt wedge, to be printed lying flat
* A wedge with a sharp edge, to be printed upright
* A blunt wedge, to be printed upright

There are a few ready made STL files:
* One to prop open a window (`Fensterkeil.stl`)
* Two versions to prop open a patio door (that has quite a bit of ground clearance)
* Two without a specific purpose in mind

The idea is that you take the FreeCAD files and change the size to what you need. It’s a bit harder than with my [dial-a-wedge](https://www.thingiverse.com/thing:2323604), sorry. Do it like this:

* Download [FreeCAD](https://www.freecadweb.org/wiki/Download) and get it running
* Load one of the `fcstd`  FreeCAD files.
* In the tree view, double click on “Sizes”. You should see the spreadsheet
* Change the values to what you want. Make sure to keep the `=` and `mm`.
* Go back to, wlog, the `upright_wedge`  view. Tab at the bottom.
* Check that the shown shape looks OK. There are view controls at the top
* Check that in the tree view there are no exclamation marks as warnings
* If there *are* problems, it’s easiest to close *without* saving and to try again. Change fewer values, and only by small amounts.
* If the wedge looks good, select the last item in the tree view. The wedge should turn green in the main view.
* Look for the dropdown in the tool bar and select “Mesh Design”
* You should now have a “Meshes” menu. Select “Create mesh from shape …”
* I have to select the “Standard” radio button. “Mefisto” produces empty meshes.
* Click OK
* There should be a “fillet (Meshed)” or similar item in the tree view. Select it.
* Click on the “Export a mesh to file” icon, enter a file name, select the file type (STL or OBJ) and click “OK”,
* Et voilà, you’re done. You have finished your first FreeCAD lesson and can now go ahead and slice and print your customized spinner.


There is some design history at
[github](https://github.com/ospalh/3d-printing/tree/develop/free_wedge). When
the version here is ever updated, look at the repo there for older
versions.
