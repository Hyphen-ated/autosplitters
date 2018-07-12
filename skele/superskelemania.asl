//by Hyphen-ated

state("SuperSkelemania")
{
    double frames  : "SuperSkelemania.exe", 0x00117EAC, 0xc, 0x10, 0x70, 0x0;
    double seconds : "SuperSkelemania.exe", 0x00117EAC, 0xc, 0x10, 0x7c, 0x0;
    double minutes : "SuperSkelemania.exe", 0x00117EAC, 0xc, 0x10, 0x88, 0x0;
    double hours   : "SuperSkelemania.exe", 0x00117EAC, 0xc, 0x10, 0x94, 0x0;
    
    double dive : "SuperSkelemania.exe", 0x00117EAC, 0xc, 0x10, 0xac, 0x0;
    double flip : "SuperSkelemania.exe", 0x00117EAC, 0xc, 0x10, 0xb8, 0x0;
    double dash : "SuperSkelemania.exe", 0x00117EAC, 0xc, 0x10, 0xc4, 0x0;
    double bowl : "SuperSkelemania.exe", 0x00117EAC, 0xc, 0x10, 0xd0, 0x0;
    double pound: "SuperSkelemania.exe", 0x00117EAC, 0xc, 0x10, 0xdc, 0x0;
    double blast: "SuperSkelemania.exe", 0x00117EAC, 0xc, 0x10, 0xe8, 0x0;
}

update
{
    //IGT is stored as these four values. let's calculate it out as seconds here so it's easier to work with.
    current.gameTime = current.hours * 3600 + current.minutes * 60 + current.seconds + current.frames / 60.0;
}

start
{
	return (current.gameTime > 0.05);
}

reset
{
    //if all these values are 1, that means the game is ending and we want to split rather than reset.
    //any other time, it's a reset because they went back to the main menu.
	return !(old.dive == 1 && old.flip == 1 && old.dash == 1 && old.bowl == 1 && old.pound == 1 && old.blast == 1)
           && current.gameTime < 0.05; 
}

split
{
    //check for any of the powerups
    if (current.dive == 1 && old.dive == 0) return true;
    if (current.flip == 1 && old.flip == 0) return true;
    if (current.dash == 1 && old.dash == 0) return true;
    if (current.bowl == 1 && old.bowl == 0) return true;
    if (current.pound == 1 && old.pound == 0) return true;
    if (current.blast == 1 && old.blast == 0) return true;
    
    //check for the end of the game
    if ((old.dive == 1 && old.flip == 1 && old.dash == 1 && old.bowl == 1 && old.pound == 1 && old.blast == 1)
        && current.gameTime < 0.05) {
        return true;
        }
}

isLoading
{
    //always true to force livesplit to constantly sync to IGT
	return true;
}

gameTime
{
    //use old instead of current because otherwise it will be 0 after the final split happens
	return TimeSpan.FromSeconds(old.gameTime);
}