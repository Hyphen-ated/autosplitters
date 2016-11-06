//Pipe autosplits by Hyphen-ated

state("ANOMONA", "1.1")
{
   int key   : 0x39B1E8, 0x04, 0x246;
   int heart : 0x39B1E8, 0x04, 0x254;
   int clock : 0x39B1E8, 0x04, 0x264;
   int flag  : 0x3859A0;
}

update
{
    //print("key: " + current.key + ", heart: " + current.heart + ", clock: " + current.clock + ", flag: " + current.flag); 
}

start
{
    return (old.clock == 0 && current.clock != 0);
}

reset 
{
    return (old.clock != 0 && current.clock == 0);
}

split
{
    return (old.key != current.key || old.heart != current.heart || old.flag != current.flag);
    //if you don't want splits, just one segment for the whole game, then use this:
    //return (old.flag != current.flag);
}