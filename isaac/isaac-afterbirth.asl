//isaac autosplits by Hyphen-ated
state("isaac-ng", "1.06.0109")
{
   int wins: 0x002EE09C, 0x64c;
   int checksum:  0x002EE09C, 0x6f0; 
   int character: 0x002EE09C, 0x7e78;
   int floor: 0x002EC554, 0x0;
}

update
{
    //print("wins: " + current.wins + ", checksum: " + current.checksum.ToString("X") + ", floor: " + current.floor + ", character: " + current.character); 
}

start
{
    return (current.checksum != old.checksum
         && current.floor != 0);
}

reset 
{
    return (current.checksum != old.checksum 
         && current.floor == 1
         && timer.CurrentSplitIndex == 0);
}

split
{
    return (current.wins == old.wins + 1);
}