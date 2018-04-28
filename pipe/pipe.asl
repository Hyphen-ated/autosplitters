//Pipe autosplits by Hyphen-ated

state("ANOMONA", "1.1")
{
   int key   : 0x39B1E8, 0x04, 0x246;
   int heart : 0x39B1E8, 0x04, 0x254;
   int clock : 0x39B1E8, 0x04, 0x264;
   int screen1 : 0x39B1E8, 0x04, 0x106;
   int screen2 : 0x39B1E8, 0x04, 0x116;
   int flag  : 0x3859A0;
}

init
{
    vars.currentRoomIdx = 0;
    vars.screen1Vals = new List<int>();
    vars.screen1Vals.Add(475136);
    vars.screen1Vals.Add(475144);
    vars.screen1Vals.Add(475152);
    vars.screen1Vals.Add(475156);
    vars.screen1Vals.Add(475136);
    vars.screen1Vals.Add(475120);
    vars.screen1Vals.Add(475136);
    vars.screen1Vals.Add(475120);
    vars.screen1Vals.Add(458752);
    vars.screen1Vals.Add(458752);
    vars.screen1Vals.Add(0);
    
    vars.screen2Vals = new List<int>();
    
    vars.screen2Vals.Add(475170);
    vars.screen2Vals.Add(475168);
    vars.screen2Vals.Add(475168);
    vars.screen2Vals.Add(475164);
    vars.screen2Vals.Add(475164);
    vars.screen2Vals.Add(475164);
    vars.screen2Vals.Add(475168);
    vars.screen2Vals.Add(475164);
    vars.screen2Vals.Add(475168);
    vars.screen2Vals.Add(458752);
    vars.screen2Vals.Add(0);
    
}

startup
{
    settings.Add("split_pickups", true, "Split on the key and on hearts");
    settings.Add("split_screens", false, "Split on the screen transitions in the any% route");
}

update
{
    //print("key: " + current.key + ", heart: " + current.heart + ", clock: " + current.clock + ", flag: " + current.flag); 
}

start
{
    if (old.clock == 0 && current.clock != 0) {
        vars.currentRoomIdx = 0;
        return true;
    }
}

reset 
{
    if (old.clock != 0 && current.clock == 0) {
        vars.currentRoomIdx = 0;
        return true;
    }
}

split
{
    if(settings["split_screens"]
       && current.screen1 == vars.screen1Vals[vars.currentRoomIdx + 1]
       && current.screen2 == vars.screen2Vals[vars.currentRoomIdx + 1]) {
       
       ++vars.currentRoomIdx;
       return true;
       }

    if(settings["split_pickups"] &&
         (old.key != current.key 
         || old.heart != current.heart)) {
         return true;
    }
    
    return (old.flag != current.flag);
}