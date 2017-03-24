This is an isaac autosplitter for LiveSplit. Here's what it can do:
 * automatically start your timer
 * reset your timer when you reset a run
 * automatically split, either when you finish a character, or when you enter a new floor (configurable)

Generally, the only thing you should have to do manually with your timer is hit
a reset hotkey, and you only have to do that after either finishing a run, or 
resetting a multi-character run when you've gone past your first split already.

To use it, right click Livesplit and go to "edit layout", then do:
Plus -> Control -> Scriptable Auto Splitter.

Then point it to isaac-afterbirth.asl and you're good to go.

If you're using per-floor splits and you're running a category with BLCK CNDL, you need to click a checkbox
in the options to tell the autosplitter about it, or else it will handle XL floors wrong.

You can also use this to display your current win streak inside LiveSplit,
which you may find convenient if you stream eden streaks or whatever.
To do that, get the ASL Var Viewer plugin from
https://github.com/hawkerm/LiveSplit.ASLVarViewer
and tell it to show the value of the "winstreak" variable.

Issues: 
* It splits at the end of the chest animation instead of the beginning. (pretty insignificant)
