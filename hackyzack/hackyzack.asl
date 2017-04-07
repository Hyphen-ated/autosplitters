//HackyZack autosplits by Hyphen-ated

state("HackyZackGame")
{
   int level_complete_menu : 0x3c9668 , 0x8, 0x20c, 0xb4;
}

startup
{
    settings.Add("split_each_level", false, "Split after every single level, not just worlds");
}

init
{
    current.level = 1;
    vars.world_final_levels = new List<int>(){10, 20, 30, 40, 50, 55};    
}

update
{
    if (old.level_complete_menu == 0 && current.level_complete_menu == 1) {
        current.level = old.level + 1;
    } else {
        current.level = old.level;
    }
}

split
{
    if (current.level == old.level)
        return false;
        
    return settings["split_each_level"] ||
           vars.world_final_levels.IndexOf(old.level) != -1;

}