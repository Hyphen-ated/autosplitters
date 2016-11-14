This is an isaac autosplitter for LiveSplit. It can be used to automatically
start your timer, reset it when you reset a run, and split, either when you enter
the chest, or when you enter a new floor (if you're doing single character runs).
Generally, the only thing you should have to do manually with your timer is hit
a reset hotkey, and you only have to do that after either finishing a run, or 
resetting a multi-character run when you've gone past the first character already.

To use it, right click Livesplit and go to "edit layout", then do:
Plus -> Control -> Scriptable Auto Splitter.

Then point it to isaac-afterbirth.asl and you're good to go.

You can also use this to display your current win streak inside LiveSplit,
which you may find convenient if you stream eden streaks or whatever.
To do that, get the ASL Var Viewer plugin from
https://github.com/hawkerm/LiveSplit.ASLVarViewer
and tell it to show the value of the "winstreak" variable.

Issues: 
* It splits at the end of the chest animation instead of the beginning. (pretty insignificant)
* If you're doing runs with the BLCK CNDL seed, and you want to split on floors, you need to
  check the box in the options to tell the timer about it, or else it will mishandle XL floors.

This is version 9 of the splitter, for afterbirth 1.06.0109