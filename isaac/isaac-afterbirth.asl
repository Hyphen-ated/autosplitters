//isaac autosplits by Hyphen-ated
state("isaac-ng", "1.06.0109")
{
   int wins: 0x002EE09C, 0x64c;
   int checksum:  0x002EE09C, 0x6f0;   
   int character: 0x002EE09C, 0x7e78;
   int winstreak: 0x002EE09C, 0x1b8;
   int floor: 0x002EC554, 0x0;
   int timer: 0x002EC554, 0x174d4c;
   int curse: 0x002EC554, 0xC;
}

startup
{
    settings.Add("character_run", true, "Multi-character run");
    settings.SetToolTip("character_run", "Disables auto-resetting when you're past the first split.");
    settings.Add("floor_splits", false, "Split on every floor");
    settings.Add("blck_cndl", false, "You're using blck_cndl mode (only relevant if splitting on floors)");
}

init
{
    vars.timer_during_floor_change = 0;
}

update
{
    //print("wins: " + current.wins + ", floor: " + current.floor + ", character: " + current.character + ", timer: " + current.timer + ", curse: " + current.curse); 
}

start
{
    if(old.timer == 0 && current.timer != 0)
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
    if(old.timer == 0 && current.timer != 0 && current.timer < 10
         && (!settings["character_run"] || timer.CurrentSplitIndex == 0))
    {
        vars.timer_during_floor_change = 0;
        return true;
    }
}

split
{
    if(current.wins == old.wins + 1) 
        return true;
                
    if (settings["floor_splits"]) 
    {
        if (current.floor > old.floor && current.floor > 1) {
            //when using floor splits, if they just got into an xl floor, we are going to doublesplit
            vars.timer_during_floor_change = current.timer;       
            return true;
        }
        
        if(vars.timer_during_floor_change != -1 
        && current.timer > vars.timer_during_floor_change)
        {
            vars.timer_during_floor_change = -1;
            //if they're in blck_cndl mode, there is no xl even if the xl curse looks like it's on
            if(current.curse == 2 && !settings["blck_cndl"]) {
                var model = new TimerModel { CurrentState = timer };
                model.SkipSplit();
            }            
        }
    }
    
    
}