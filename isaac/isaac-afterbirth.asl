//isaac autosplits by Hyphen-ated
state("isaac-ng", "1.06.0109")
{
   int wins: 0x002EE09C, 0x64c;
   int checksum:  0x002EE09C, 0x6f0; 
   int character: 0x002EE09C, 0x7e78;
   int floor: 0x002EC554, 0x0;
   int timer: 0x002EC554, 0x174d4c;
}

startup
{
    settings.Add("character_run", true, "Multi-character run");
    settings.SetToolTip("character_run", "Disables auto-resetting when you're past the first split.");
    settings.Add("floor_splits", false, "Split on every floor");
}

update
{
    //print("wins: " + current.wins + ", checksum: " + current.checksum.ToString("X") + ", floor: " + current.floor + ", character: " + current.character + ", timer: " + current.timer); 
}

start
{
    return (old.timer == 0 && current.timer != 0);
}

reset 
{
    return (old.timer == 0 && current.timer != 0 
         && (!settings["character_run"] || timer.CurrentSplitIndex == 0));
}

split
{
    return (current.wins == old.wins + 1 
         || (settings["floor_splits"] && current.floor > old.floor && current.floor > 1));
}