// AutoSplitter for The Binding of Isaac: Afterbirth+
// Code by Hyphen-ated
// Checkpoint code & pointer annotations by blcd/Zamiel

state("isaac-ng", "1.06.J85")
{
    // 0x004f3020 - GamePtr (which is the same thing as the Lua "game" pointer)
    int wins:      0x004f3020, 0x75c;
    int character: 0x004f3020, 0x7a34;
    int winstreak: 0x004f3020, 0x1f0;

    // 0x004f3010 - GlobalsPtr
    int timer:   0x004f3010, 0x00213b0c;
    int floor:   0x004f3010, 0x0;
    int curse:   0x004f3010, 0xC;
    
    // Checkpoint is a custom item planted at the end of a run in the Racing+ mod
    int cpCount: 0x004f3010, 0x9b64, 0x0, 0x2764, 0x864; // "Checkpoint" (ID 537) count
    
    // Off Limits is a custom item used by the Racing+ mod to signal the AutoSplitter that the mod is sending the player back to the first character        
    int olCount: 0x004f3010, 0x9b64, 0x0, 0x2764, 0x85C; // "Off Limits" (ID 535) count
    
    // 0x9b64 - PlayerVectorPtr
    // 0x0    - Player1
    // 0x2764 - Player1 CollectibleNum Vector Ptr
    // 0x864  - Item 537 count
    // 0x85C  - Item 535 count
}

startup
{
    settings.Add("character_run", true, "Multi-character run");
    settings.SetToolTip("character_run", "Disables auto-resetting when you're past the first split.");
    settings.Add("racing_plus_custom_challenge", false, "You're using the Racing+ custom challenge for multi-character runs", "character_run");
    settings.Add("floor_splits", false, "Split on floors");
    settings.Add("grouped_floors", false, "Combine basement, caves, depths, and womb into one split each", "floor_splits");
    settings.Add("blck_cndl", false, "You're using blck_cndl mode", "floor_splits");

}

init
{
    vars.timer_during_floor_change = 0;
}

update
{
    //print("wins: " + current.wins + ", floor: " + current.floor + ", character: " + current.character + ", timer: " + current.timer + ", curse: " + current.curse);
    //print("checkpointCount: " + current.checkpointCount);
}

start
{
    if (old.timer == 0 && current.timer != 0)
    {
        vars.timer_during_floor_change = 0;
        return true;
    }
}

reset
{
    //old.timer is 0 immediately during a reset, and also when you're on the main menu
    //this "current.timer < 10" is to stop a reset from happening when you s+q.
    // (unless you s+q during the first 1/3 second of the run, but why would you)
    if (old.timer == 0 && current.timer != 0 && current.timer < 10
        && (!settings["character_run"] || timer.CurrentSplitIndex == 0))
    {
        vars.timer_during_floor_change = 0;
        return true;
    }

    if (settings["racing_plus_custom_challenge"] && current.olCount == 1 && old.olCount != 1)
    {
        return true;
    }
}

split
{
    if (current.wins == old.wins + 1)
        return true;

    if (settings["racing_plus_custom_challenge"] && current.cpCount == 1 && old.cpCount != 1)
        return true;

    if (settings["floor_splits"])
    {
        if (current.floor > old.floor && current.floor > 1 && old.floor > 0
        && (!settings["grouped_floors"] || (current.floor != 2 && current.floor != 4 && current.floor != 6 && current.floor != 8))) {
            //when using floor splits, if they just got into an xl floor, we are going to doublesplit
            vars.timer_during_floor_change = current.timer;
            return true;
        }

        if (vars.timer_during_floor_change != -1
        && current.timer > vars.timer_during_floor_change)
        {
            vars.timer_during_floor_change = -1;
            //if they're in blck_cndl mode, there is no xl even if the xl curse looks like it's on
            //similarly, with grouped floors, there's no split to skip
            if(current.curse == 2 && !settings["blck_cndl"] && !settings["grouped_floors"]) {
                var model = new TimerModel { CurrentState = timer };
                model.SkipSplit();
            }
        }
    }
}