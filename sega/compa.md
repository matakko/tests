# Naomi/Atomiswave QA

Last update: January 2022

- NAOMI2 aren't really tested at current point (they all hang waiting for the T&L chip)

## Full Compatibility Table

|romset|parent|supported|Testing notes|Emulation Notes|
|------|------|---|------------|----------------------|
|18wheelr|naomi|no||"MOTOR NETWORK ERR IN 01 OUT ff"|
|18wheelro|18wheelr|no|
|18wheelrt|18wheelr|no|
|18wheels|18wheelr|no|_Not extensively tested, just a brief playthrough_|Truck translucency/smoke/lights effects are off<br><br>No fog<br><br>Internal view is unusable, points to an odd angle|
|18wheelu|18wheelr|no|
|airlbios||no?||Throws "ERROR 03", correct?|
|alienfnt|naomi|no||No inputs hooked<br><br>Needs optical drive connection (master-slave), bypass with start button<br><br>Title screen has Z sort issues (flashes goes above backdrop)<br><br>Earth render looks ugly with no bilinear filtering in attract and when coined up<br><br>MAME process exited once with non-zero status code 3 (investigate)|
|alienfnta|alienfnt|no|
|alpilot|airlbios|no||Throws "Error 03" when booting|
|alpilotj|naomi|partial?||Punts with error 51 (system assignments: 1 player set)<br><br>Wants 31 kHz Mode|
|anmlbskt|awbios|yes?|_Can be run at 100% on high end hosts, made a bunch of .inp attempts_|Running memory test makes performance to dip (executing invalid code?)<br><br>Game select has BGM hiccups, eventually silent<br><br>Game start fanfare sounds with a bit of crackle at end.<br><br>~~Verify game graphics (priorities are dubious in some gameplay places)~~|
|anmlbskta|anmlbskt|yes?|
|anpanman2|naomi|no||Punts with error 51 (system assignments: 1 player set)<br><br>Wants 31 kHz Mode<br><br>Punts with "I/O BD CONNECTED TO NAOMI BD DOES NOT FULLFILL GAME SPECS."<br><br>Service mode is almost unusable, service button being always held (workaround: press TEST three items above the wanted one). Trouble Check returns error code = -17 / machine status = -1|
|asndynmt|naomi|no|_Untested after 1-2_|Attract mode shows title screen with big solid polygon covering background (not unlike HOTD2), next scene has perspective correction/Z fighting issues for some building polygons<br><br>Character select has clouds/mist not blending properly<br><br>PIP clipping issues for mission select<br><br>1-2 background has more Z fighting issues (missing fog even? Verify), scene after QTE has severe Z sort issues (pillars covering playfield)<br><br>Game Over smoke isn't transparent|
|asndynmto|asndynmt|no|
|ausfache|naomi|no|_Untested beyond brief practice mode_<br><br>"Who is Pic Corporation credited at boot?" -> [販売：ピーアイシー](http://kakuge.info/d/t/akatsuki_aa.htm) [(alt)](http://subtlestyle.net/akatsukiaa/)|~~Hangs on attract (ADX)~~<br><br>Title screen/How to Play sports wrong polygon vertices<br><br>Z sort issues below Practice Mode layer (character legs gets corrupted)<br><br>Hangs during how to play screen (drc?)|
|awbios|no|||Flips back between cross hatch / color test without user intervention (verify)|
|azumanga|naomigd|no|_Untested other than few levels_|Draws character select cursor without transparency<br><br>When performing a combo MC covers the playfield|
|basschal|awbios|no|
|basschalo|basschal|no|_Start can be used to skip attract elements_|Has "pulse X/Y" that needs to be hooked up, tournament settings in service mode uses it for operating in menu<br><br>Service mode is very unresponsive<br><br>Has printer settings in service mode<br><br>Service mode crashes when exited (by enabling tournament settings? Verify)<br><br>Water in gameplay has black gaps, and draws odd blended olive colored spots|
|bdrdown|naomigd|partial?|_Tested up to stage 3 boss_|Stage intro fade-ins shows pop-up objects<br><br>Boss timers alternatively shows current time and a zero value (verify)<br><br>1st boss explosion shows with square gaps<br><br>Status bar at bottom doesn't blend properly<br><br>Game over text animation doesn't reveal text properly (polygon vertices)<br><br>BGMs scratches too much|
|beachspi|naomi2|no||
|blokpong|awbios|no||No analog inputs (trackball?)<br><br>Solid shadow color on gameplay<br><br>Gets stuck in attract for some time with "Game Over / Insert Coin" blinking only after first goal occurs, eventually unfreezes and loops back attract sequence (verify)<br><br>Atomiswave logo jingle is offset wrt GFX (especially noticeable after one attract sequence)|
|capsnk|naomi|partial|_Played to completion_|~~Runs at half speed (hiccups)~~<br><br>Lightning effects has wrong Z sorts (cfr. hit confirms, Iori qcf+p Yamibarai, B+D charging in SNK mode, KO spinning text, misc)<br><br>Geese ending has squared explosions<br><br>Game Over GFXs don't blend properly|
|capsnka|capsnk|partial|
|capsnkb|capsnk|partial|
|cfield|naomigd|partial?|_Played a bit of stage 1_<br><br>_Left in attract for >30 minutes_<br><br>"Developed by Milestone Inc."|~~Hangs on attract (ADX)~~<br><br>Gameplay background looks quite messy (particularly buildings with cyan lights, verify)<br><br>Using button B sword has random transparency issues|
|chocomk|naomigd|no|_Played a couple stages_|Hardlocks on title screen (-drc?)<br><br>Z sort issues on title screen (main character goes submerged by grass)<br><br>Wrong polygon vertices masks on game select menus<br><br>On gameplay there are Z sort issues for cloud/vapors (noticeable if you move too)|
|claychal|awbios|no||Missing lightgun inputs<br><br>Sports polygon wrong vertices on small title screen elements|
|cleoftp|naomigd|partial|_Made a quick play_|Some priorities looks wrong (verify)|
|clubk2k3|naomi2|no||
|clubk2kp|clubk2k3|no||
|clubk2kpa|clubk2k3|no||
|clubkcyc|naomi2|no||
|clubkcyco|clubkcyc|no||
|clubkprz|naomi2|no||
|clubkpzb|naomi2|no||
|clubkrt|naomi2|no||
|clubkrta|clubkrt|no||
|clubkrtc|clubkrt|no||
|clubkrto|clubkrt|no||
|confmiss|naomigd|no|_Played up to stage 1_|Crashes often in service mode (inputs are unresponsive)<br><br>Reads RTC as 1885 in attract mode (btanb)<br><br>Stage 1 OP draws a solid polygon over scene when soldier gets knocked out<br><br>Draws solid black polygons for sunlight effect during stage 1<br><br>Hit confirms tends to have Z sort bugs<br><br>Doesn't show special weapons when displayed in box (more Z sort)|
|crackndj|naomi|no||Missing turntable input, fader min/max settings has way narrower defaults (107-159)<br><br>Punts with "ERROR I/O BD CONNECTED TO NAOMI BD DOES NOT FULFILL THE GAME SPECS", prints detected info on screen|
|crakndj2|naomi|no||Missing turntable input, fader min/max settings has way narrower defaults (107-159)<br><br>Punts with "ERROR I/O BD CONNECTED TO NAOMI BD DOES NOT FULFILL THE GAME SPECS", prints detected info on screen|
|crzytaxi|naomi|?||BGMs drops after a while of gameplay<br><br>Entering parking has tons of Z fighting<br><br>Getting near the Church makes sky to become black<br><br>Draws earned score with holes during gameplay|
|csmash|naomi|no|
|csmasho|csmash|no|_Known to use lots of blending effects, consider doing an attract side-by-side_|Unplayable in gameplay (layer covering everything else), attract mode often goes too far away with camera (focal distance)|
|cspike|naomi|partial|_played to loop 1 completion, loop 2 untested (shouldn't matter)_|Some transparency issues<br><br>has lightning/shadow issues on stage 3, 7, 9 bosses<br><br>has missing fog (stages 1, 6)<br><br>pings AICADSP 33fc + others on every gameplay transition (likely btanb)<br><br>title screen in attract is glitchy for a brief moment|
|cvs2|naomigd|partial|_Played a single match in 3 vs. 3 mode__<br><br>_Has [Passwords](https://gamefaqs.gamespot.com/arcade/562704-capcom-vs-snk-2/cheats) in service mode_|Black "Capcom vs. SNK" title screen logo, various elements in character select/gameplay<br><br>Several sparks have black pen instead of transparency during gameplay|
|cvs2mf|cvs2|no|_Played a single match in 3 vs. 3 mode_|Black "Capcom vs. SNK" title screen logo, various elements in character select/gameplay<br><br>~~Runs at half speed (hiccups)~~<br><br>Has "C-Panel" option in service mode (?)|
|cvsgd|naomigd|no||~~Runs at least half speed (Capcom logo), seems to have hiccups~~<br><br>wrong blending on intro<br><br>hangs at Capcom vs. SNK select (regression or drc?)<br><br>leaves ranking screen too soon<br><br>hardlocks MAME after leaving ranking screen (drc)|
|deathcox|naomi|partial?|
|deathcoxj|deathcox|partial?|_Played a bit of stage 1_|~~No lightgun inputs~~<br><br>~~Hangs after For Use in Japan (ADX)~~<br><br>3-2-1 countdown in gameplay looks bogus (verify)|
|deathcoxo|deathcox|partial?|
|demofist|awbios|no|_Untested_|Hardlocks MAME with drc, cfr. [MT#08088](https://mametesters.org/view.php?id=8088)|
|derbyo2k|naomi|no||Wants -bios 14 (USA) otherwise refuses to boot, but in-game text is in Japanese!?<br><br>Wants 31 kHz<br><br>Defaults to network mode slave (needs to be set to "Communication Mode" -> "no link" in service mode).<br><br>_No Link seems a debug mode even, pressing b4 on attract gives a reduced service set_. This Jp only service menu returns a red screen with "Card Test" failed printed after a while. This is also repeated after a while in attract.<br><br>Has card r/w test<br><br>Horses draws with big square shadows<br><br>Doesn't seem startable, most likely needs satellite connections|
|derbyoc|naomi|no|
|derbyoc2|naomi|no|
|derbyocw|naomi|no||Wants -bios 14 (USA) otherwise refuses to boot, it's an Export set tho?<br><br>Wants 31 kHz<br><br>"CARD READER-WRITER DOESN'T RESPONSE" when booted (uses Sanwa CRP-1231)|
|dirtypig|awbios|no|_Played up to completion (five matches)_<br><br>_Probably the least demanding game in the Naomi library (can get 90-100% safely with DRC)_|Has Z Sort issues, some of them hinders gameplay (score and playbook hidden)<br><br>Hardlocks MAME by entering service mode after some time? (reverify)|
|doa2|doa2m|partial|
|doa2a|doa2m|partial|
|doa2m|naomi|partial|_Played up to Ein completion in Story Mode_|"GET READY" / "REPLAY" / "KO" text in gameplay doesn't blend properly (draws transparent)<br><br>C2 Ein has Z fighting issues (more noticeable on chara select and when zoomed in)<br><br>C1 Kasumi has wrongly colored skirt tunic part<br><br>No fog for "elevator" stage (stage 3 Ein), and for Bankotsubo (final boss) stage<br><br>Ein winning pose loses hair when screen fades out<br><br>Stage 5 Ein (vs. Ayane) has black water droplets<br><br>Sometimes female chars throws very high pitched samples (Kasumi, Lei-Fang, is it reproducible in sound test?)|
|dolphin|awbios|partial?|_Played up to stage 2 boss_|Sea GFX is solid instead of transparent (cfr. stage 1 first attract demo)<br><br>Explosions shows as square shapes (i.e. Z sort)<br><br>Lens flare at the end of the tunnel in stage 1 has higher priority than player instead of blending<br><br>Some bullets/flame GFXs gets overwritten by player bullets|
|dragntr|naomigd|no||"Fatal error: GDROM: Could not find the file to decrypt."|
|dragntr2|naomigd|no||"Fatal error: GDROM: Could not find the file to decrypt."|
|dragntr3|naomigd|no||Hangs on "NOW LOADING" (PC=0xc0441b6 R0=$c01fc00)<br><br>Throws "G2 I/O TROUBLE" if debug skipped on boot<br><br>Hangs when entering service mode (PC=0x800000a2)|
|dragntra|dragntr|no||"Fatal error: GDROM: Could not find the file to decrypt."|
|drbyocwa|derbyocw|no|
|drbyocwb|derbyocw|no|
|drbyocwc|derbyocw|no|
|dybb99|naomi|no|_Untested_|Hangs in attract with "NOT CONNECT JAMMA BOARD"|
|dybbnao|naomi|partial|_Played 9 inning match to completion_|analog default inputs are way too sensitive (200)<br><br>Has Konami logo on Tokyo Dome (first stadium), just licensed Stadium stuff?<br><br>Dugout has Z sort issues (press start during gameplay)|
|dygolf|naomigd|no||Punts with "ERROR I/O BD CONNECTED TO NAOMI BD DOES NOT FULFILL THE GAME SPECS" (needs two nodes apparently)|
|f355|f355dlx|no||"Looking for master"<br><br>No inputs|
|f355bios||no||"Looking for master"<br><br>No inputs|
|f355dlx||no||"Looking for master"<br><br>No inputs|
|f355p|f355|no||"Looking for master"<br><br>No inputs|
|f355twin|f355bios|no||"Looking for master"<br><br>No inputs|
|f355twinp|f355twin|no||"Looking for master"<br><br>No inputs|
|f355twn2|f355bios|no||"Looking for master"<br><br>No inputs|
|fotns|awbios|no|_Played up to stage 2_|Randomly hangs during gameplay (-drc?)<br><br>Several GFX issues during intro<br><br>Gameplay sports incomplete GFXs on fade-ins/-outs<br><br>Exiting from service mode (while entering from For use in Japan) will cause RAM corruption (cfr. the corrupted For use in Japan second time around, repeated ADX sounds in OP etc.)|
|ftspeed|awbios|no||cannot calibrate inputs<br><br>camera looks too low in gameplay<br><br>punts with "Fatal error: SH4MMU: associative mode writes unsupported" when exiting from service mode|
|ggisuka|awbios|no|_untested other than brief round_|HP bars draws with wrong polygon vertices<br><br>Black screens when exited from service mode|
|ggram2|naomi|partial?|_Tested one match_|Hit confirms doesn't blend properly<br><br>Shadows doesn't draw behind text box in how to play screen in attract<br><br>Has frame skip issues, mostly noticeable during wrestler entrances|
|ggx|naomi|partial?|_Unsurprisingly similar to ggx15 later release_|Starts off with EEPROM issues (bypass with start button)<br><br>HP bars/Heaven or Hell/... draws with wrong polygon vertices|
|ggx15|awbios|partial?|_Played a few rounds_<br><br>_Left in attract for >30 minutes_|HP bars/Heaven or Hell/... draws with wrong polygon vertices<br><br>Potemkin pants draws with a bit of alpha transparency (verify)|
|ggxx|naomigd|partial?|_Played up to final stage_<br><br>_Default maps button differently than other NAOMI games, cfr. service mode_<br><br>_Has password set in service mode, what for?_|Starts off with EEPROM issues (bypass with start button)<br><br>Strips of garbage during intros, and on WIN/LOSE text after rounds on gameplay<br><br>Several stages have Z sort issues (cfr. Slayer stage, 9)<br><br>I-No stage doesn't have fog (last stage)|
|ggxxac|naomigd|partial?|_untested other than brief round_|Draws text with overline garbage<br><br>Intro has some lines of garbage scattered through|
|ggxxrl|naomigd|partial?|_untested other than brief round_<br><br>_Has password set in service mode, what for?_|Starts off with EEPROM issues (bypass with start button)<br><br>Strips of garbage during intros, and on WIN/LOSE text after rounds on gameplay|
|ggxxrlo|ggxxrl|partial?|
|ggxxsla|naomigd|partial?|_untested other than brief round_|Strips of garbage during intros, and on WIN/LOSE text after rounds on gameplay|
|gram2000|naomi|partial?|_Run some matches in Watch Mode_<br><br>_Left in attract for >30 minutes_|Fighter OPs have a solid white light hitting them<br><br>Gameplay shadows have severe Z fighting<br><br>HP bars have wrong polygon vertices<br><br>Hit confirms doesn't blend properly<br><br>Flame trigger close up looks quite ugly (verify)<br><br>Winner scene lights doesn't blend properly<br><br>During tag matches, camera may position in awkward/hilarious places (like inside a non-active fighter)|
|gundmct|naomi|no|_Untested after stage 5_<br><br>_looks to have common bug points with pstone, with significantly easier steps to reproduce_|"2001 02 08"<br><br>Punts with error 51 (system assignments: 1 player set)<br><br>Has Network Mode in service mode<br><br>Attract mode shows transparency issue with Gundam vapors<br><br>Entry screens sports several black pixels instead of being transparent (arrow for faction select, name entry cursor, Real Robot selection), and polygon wrong vertices on faction names. Both are also reflected in gameplay and debriefings.<br><br>Name entry cursor also covers initials instead of being semi-transparent (Z sort too?).<br><br>De-Briefing is again same deal (not showing the destruction below green monitor)<br><br>No fog in gameplay<br><br>Briefing map text (green) sports color offset<br><br>Slight shadow issue when player enters into gameplay area (shows a long one for a split second)<br><br>Looks to have speed hiccups (verify)|
|gundmgd|naomigd|no|
|gundmxgd|naomigd|no|
|gunsur2|naomi|no|
|gunsur2j|gunsur2|no||Entering in service mode punts to game booting<br><br>~~Hangs on attract (ADX)~~<br><br>No inputs hooked up (similar but not quite as hotd2)|
|gwing2|naomi|no|_Arguably "Capcom" and "Takumi" needs to be swapped in manufacturer priority_|No fog during gameplay<br><br>Reflect force covers the ship instead of blending<br><br>Hangs randomly (?)|
|hmgeo|naomi|no|_Played a single match_|Default with network slave (disable in service mode)<br><br>Has VM-KIT in service mode<br><br>Shadow/lightning/flame effects are off during gameplay (Z sort)<br><br>Verify camera/focal distance (i.e. when wall covers action instead of zoom-in)|
|hod2bios|no|||Jumps to lalaland as soon as it's started (is it runnable?)|
|hopper|naomi|no|Prints "I/O BOARD IS BAD" when booted<br><br>Crashes with invalid opcode accesses when entering service mode (both -drc and -nodrc, btanb?)|
|hotd2|hod2bios|no|
|hotd2e|hotd2|no|
|hotd2o|hotd2|no|_Played to completion_|Stage 1 gameplay rain is not transparent<br><br>Has severe geometry issues, particularly noticeable when camera point at sky<br><br>Title screen is ugly on coin in<br><br>No fog (halfway stage 3, dungeon)<br><br>Water effect is ugly (stage 3 boss)<br><br>Draw-ins in some doors (cfr. stage 3 boss half time, stage 4)<br><br>Goldman doesn't show up in stage 4 boss intro (pip with a screen, verify)<br><br>Transparent car windshield glass hides some elements during stage 5 boss rush (noticeable when entering tunnel after beating boss 2 again, subtle bug)<br><br>Pings AICADSP 33fc when Magician enters into scene during stage 5 boss intro<br><br>Ugly transparency effects midway during Magician fight (swarm charging attack), also cfr. Magician death<br><br>Name Entry screen doesn't show initials layer|
|hotd2p|hotd2|no|
|ikaruga|naomigd|no|_untested after stage 2_|~~runs at half speed~~<br><br>stage 2 has invisible bullets midway thru (known to be tricky to emulate Z triangle-level sorting)<br><br>Has wrong blending for Warning No Refuge screens (green instead of red with no saturation)<br><br>Wrong blending for Battle Reports<br><br>No fog (very noticeable on stage 2)|
|illvelo|naomi|no|_Tested halfway thru stage 1_|Punts with error 51 (needs 1 player set and vertical screen orientation)<br><br>Player level up wave effect covers everything in range for the time they are on (bullets/enemies etc., Z sort)|
|inidv3ca|inidv3cy|no||
|inidv3cy|naomi2|no||
|initd|naomi2|no||
|initdexp|naomi2|no||
|initdexpo|initdexp|no||
|initdo|initd|no||
|initdv2e|initdv2j|no||
|initdv2j|naomi2|no||
|initdv2ja|initdv2j|no||
|initdv2jo|initdv2j|no||
|initdv3e|naomi2|no||
|initdv3j|naomi2|no||
|initdv3jb|initdv3j|no||
|inunoos|naomi|no||No inputs hooked up<br><br>Wants 31 kHz<br><br>Punts with "ERROR I/O BD CONNECTED TO NAOMI BD DOES NOT FULFILL THE GAME SPECS"|
|jambo|naomi|no|_Played a bit in stage 1_|Hangs often in service mode (tested input test, game assignments)<br><br>Inputs are slightly incorrect (shift up is lasso, shift down is toggle gear instead)<br><br>Fade-ins/-outs draws black sky<br><br>Fences/trees on gameplay draws as corrupted textures<br><br>Continue screen (plus other misc tutorials) draws with shifted backgrounds<br><br>Second lasso is invisible due to Z sort (the zoomed in one)|
|jingystm|naomigd|no|_Played up to Xell (final boss)_|~~black screen on boot~~<br><br>~~can crash at character select (ADX?)~~<br><br>Black screens from either game or service mode, if you boot actual game code more than once (i.e. going into service mode then exiting and going game mode will black screen, same for game mode then calling service mode)<br><br>Is attract mode intro really not supposed to have any sound? (Demul does same, most likely btanb)<br><br>No shadows during gameplay<br><br>Hit confirms have wrong underlying Z sorts<br><br>Jiao stage (6) has lightning effects fully covering instead of be transparent (Z sort?)|
|karous|naomigd|no||~~Hangs in attract/gameplay (ADX)~~<br><br>Several bullets are invisible (cfr. stage 1 boss)|
|keyboard|naomigd|partial|_played up to completion_|main center gameplay area doesn't cut off at edges (clip rectangle issue)<br><br>~~was crashing after some time in attract~~ (cannot reproduce, left in attract for 1 hour, assume fixed)<br><br>Has no numpad (btanb, Sega Naomi keyboard doesn't have it)|
|kick4csh|naomi|no||Wants -bios 8 (Export) otherwise refuses to boot<br><br>Punts with error 51 (needs 1 player set)<br><br>Wants 31 kHz<br><br>"I/O BD IS NOT CONNECTED TO NAOMI BD"<br><br>"COM. TIME OUT" waiting for hopper response when entering game service mode|
|kingrt66|naomi2|no||
|kingrt66p|kingrt66|no||
|kofnw|awbios|partial?|
|kofnwj|kofnw|partial?|_Played a single match_|Test/Service buttons doesn't work in service mode (RTC increment works fine)|
|kofxi|awbios|no|_Made a bunch of brief plays_|Hangs when exiting service mode (verify)<br><br>~~Hangs during attract (ADX)~~<br><br>Beach stage has solid green lightning|
|kov7sprt|awbios|no|_Played for 30 minutes_<br><br>_Defaults to audio mode = "mono"_<br><br>_Looks not very demanding performance wise_|Needs title to be translated in Jp (Taiwan version too?)<br><br>Has very low pitched sound when gameplay starts (verify)<br><br>Several GFX effects hides underlying objects, hindering gameplay (Z sort?) (cfr. stage 1 flame effect, stage 2 left route sub-boss, plants poison in stage 3 left, etc.)<br><br>Sprite objects disappears when screen fades out on stage completion<br><br>Ranking screen 1st place portrait looks dithered (verify)|
|kurucham|naomigd|partial?|_Played single round_<br><br>"Developed by Starfish-SD" (also cfr. title screen)|~~Sports wrong pitch on Starfish logo (YUV?)~~<br><br>~~Hangs on title screen (ADX)~~<br><br>Selection panel doesn't blend properly|
|lupinsho|naomigd|no||"com. error occurred between Naomi BD and i/o BD" after some secs. of coining it up<br><br>Service mode GFXs are offset|
|lupinshoo|lupinsho|no|
|luptype|naomigd|no||"Co-developed by WOW Entertainment and 8ing"<br><br>~~Hangs when coined up (ADX)~~<br><br>Hardlocks MAME during attract or by entering stage 2 (drc)<br><br>Plays badly during attract (verify)|
|mamonoro|naomi|no|_untested after quick play_|Punts with error 51 (needs 1 player set)<br><br>Punts with error 54 (screen orientation vertical)<br><br>Crashes if booting game, entering service mode then exiting and viceversa<br><br>Explosion covers other objects, including bullets (Z Sort)|
|manicpnc|naomi|no||Error 02 when booted normally, wants an US or Export BIOS<br><br>Wants 31 kHz<br><br>"ERROR 106:SENSOR BOARD TIME OUT"|
|marstv|naomi|no|_Untested after brief single game_|Cuts off title screen/BGM too soon? (verify)<br><br>Intro/Game select hangs for a long time on line dispatches (eventually draws a bunch of white overline chars!?)|
|maxspeed|awbios|no||Inputs doesn't work<br><br>~~Draws title screen intro with wrong colors~~<br><br>Draws car in attract with bogus transparencies|
|mazan|naomi|no|
|mazanj|mazan|no|
|mazanu|mazan|no||Throws "I/O PCB ERROR" at boot|
|mbaa|naomi|partial?|_Played a couple matches_|~~Crashes on character select (ADX?)~~<br><br>Gameplay HP / guard meters draws with wrong polygon vertices<br><br>Z sort looks dubious on winning round (verify)|
|mbaao|mbaa|no|
|meltyb|naomigd|partial?|_Played a couple matches_|~~Crashes when credited (ADX?)~~<br><br>Gameplay HP / guard meters draws with wrong polygon vertices|
|meltybld|naomigd|partial?|
|meltyblo|meltybld|partial?|_Untested_|~~Crashes when credited (ADX?)~~|
|meltybo|meltyb|partial?|
|mj1|naomigd|no||Fatalerrors with "GDROM: Could not find the file to decrypt."|
|moeru|naomigd|no|_Tested up to 2nd casino_|"Press Start Button" GFX colors aren't quite right<br><br>Intro dialogue box doesn't show gal properly behind the transparency<br><br>Bad polygons vertices on "lights", at least Poker 2 screen and Black Jack playfield<br><br>Some cards in Poker 2 aren't shown (specific figures?)<br><br>Continue screen numbers are oddly transparent|
|mok|naomigd|no|_Played thru first stage_|Needs gun recalibration in service mode<br><br>Crashes with a "COMM. ERROR BETWEEN NAOMI AND I/O BD" during attract<br><br>SFXs can die during gameplay (spurious keyon?)<br><br>Missing fog on stage 2 when entering Sphinx|
|monkeyba|naomigd|no|_Played a bit of Easy course_|Doesn't show course select GFX (Z sort)<br><br>Doesn't show map GFXs (user clip + Z sort)<br><br>Clouds don't blend<br><br>Bonus stages shows lights and player ball with black pixels instead of transparency|
|mslug6|awbios|partial?|_Played a couple stages_||
|mushi2eo|mushik2e|no|
|mushi2k4|naomi|no|
|mushi2k5|naomi|no||"Card Jam" printed at boot<br><br>Has Barcode Reader and Card Dispenser tests on service mode|
|mushi2k61|naomi|no|
|mushi2k62|naomi|no|
|mushik2e|naomi|no|
|mushik2k|mushik2e|no|
|mushik4e|naomi|no|
|mushikc|mushike|no|
|mushike|naomi|no|
|mushikeo|mushike|no|
|mushikep|mushike|no|
|mushikk|mushike|no|
|mvsc2|naomi|no|
|mvsc2u|mvsc2|no|_Untested after a single round_|~~Runs at half speed (hiccups), attract mode sound completes way faster than GFXs~~ (verify)<br><br>Light effect submerges title screen, Z sort<br><br>Hit confirms have black pixels instead of transparency, ugly wave effect when a character is knocked down|
|naomi|no||"Error 01"|
|naomi2|no||"Error 01"|
|naomigd||no||"Error 01", according to [error codes](https://wiki.arcadeotaku.com/w/Sega_NAOMI_Error_Codes) should really return 24 instead.|
|ndcfboxa|naomigd|no||"NO DIMM BOARD"|
|ngbc|awbios|no?|
|ngbcj|ngbc|no?|_Untested other than brief round_|Draws intro/pre-match screens with several wrong polygon vertices<br><br>Service mode is unresponsive when booted (can be used after random time)|
|ngdup23a|naomigd|no||"NO DIMM BOARD"|
|ngdup23c|naomigd|no||"NO DIMM BOARD"|
|ngdup23e|naomigd|no||"NO DIMM BOARD"|
|ninjaslt|naomi|no|
|ninjaslta|ninjaslt|no|
|ninjasltj|ninjaslt|no||No inputs, punts to "I/O PCB ERROR" when booted|
|ninjasltu|ninjaslt|no|
|oinori|naomi|no||"VER 2003/08/26"<br><br>Wants 31 kHz<br><br>No inputs<br><br>No network connection, hangs on boot with "SATE." B.RAM error<br><br>Exiting from BACKUP DATA MENU in service mode shows a DEBUG SETTING submenu with interesting ones, but this menu cannot be exited anyway?|
|otrigger|naomi|no||Black screens from both service mode and game mode (maple device?)|
|pjustic|naomi|no|_untested in-game_|Ranking screen has weird geometry model issues for a split second<br><br>Hardlocks during attract on ranking screen (drc)|
|pokasuka|manicpnc|no||Wants 31 kHz Mode<br><br>No inputs hooked up<br><br>"Call attendant" when booted, "ERROR 106:SENSOR BOARD TIME OUT"|
|pstone|naomi|no|_played to completion_|"Jan 19 1999"<br><br>Terrible lightning/transparency effects, some of them hinders gameplay (chests, lettering in attract, Power Up state, Valgas Power Up cyan balls attack, misc)<br><br>Z sort issue for right character name in VS screen<br><br>Some elements have black opaque pixels instead of being transparent (Flamethrower flames, character 2 Power Stone state, Power Stones themselves, ending)<br><br>Focal distance looks wrong during Winning Pose (rationale: hold C, push down and release for terrain superimposing everything)<br><br>Missing fog for Kraken and Ryoma stage backgrounds<br><br>Transformation BGM sometimes have hiccups (stops playing for few secs)<br><br>Ending text layer is slightly color offsetted (should be brighter, Z sort?)|
|pstone2|naomi|no|_Sports similar issues as pstone, untested beyond one stage play_|Has optional VM-Kit in service mode (disabled on default)<br><br>Kick input acts as grab in this? (verify, should be same as pstone where grabs are punch+kick instead)|
|pstone2b|pstone2|no|
|psyvar2|naomigd|partial?||"1.002 2003/10/10"<br><br>~~Hangs in attract and gameplay (ADX)~~|
|puyoda|naomi|partial?|_Reached stage 3 in easy mode_|~~Uses ADX but doesn't hang apparently? Score result, continue sample and **all** service mode sound test items repeats regardless~~<br><br>Gameplay moves layer doesn't cliprect properly in the designated area<br><br>Puyo gauges on top of gameplay area gets covered by sparks at the end of a sequence|
|puyofev|naomigd|no|
|puyofevj|puyofev|no||~~Hangs in attract/after pressing start (ADX)~~<br><br>Rotates joystick inputs i.e. up goes left, right goes up, down goes right, left goes up (Maple or CPU bug?)|
|puyofevp|puyofev|no|
|qmegamis|naomi|?|_untested after quick play (language barrier)_<br><br>_Title should be translated properly (it's either "Quiz Aa! Megamisama" or "Quiz Ah! My Goddess", with a subtitle "Stay With Fighting Wings" retranslated to Jp)_|Attract mode doesn't show full building structs (Z sort issue with shadows)<br><br>Tree shadows draws solid after first quiz|
|quizqgd|naomigd|?|_untested after quick play (language barrier)_<br><br>_Left in attract for >30 minutes_|Draws title screen behind gals legs<br><br>To enter input test in service mode it requires a very light test button press (i.e. exits very soon if pressed for a bit too long, verify)|
|radirgy|naomigd|partial?|_Played up to stage 2_|~~Runs too slow~~<br><br>~~Randomly crashes on attract/gameplay (ADX)~~<br><br>Draws text during attract with black boxes (verify)<br><br>Incorrect Z sort during gameplay for blended boxes (i.e. dialogue text, score display)|
|radirgyn|naomi|partial?|_Played first two stages_|~~Hangs during attract (ADX)~~<br><br>First gameplay text box draws with weird corrupted colors (btanb)|
|radirgyo|radirgy|no|
|rangrmsn|awbios|no|_Left in attract for >10 minutes_|Hooks up driving controls instead of lightgun (no inputs basically)|
|rhytngk|naomi|no|_Untested after brief -debug -nodrc check_|Wants 31 kHz Mode<br><br>Black screen on boot (nodrc/drc), for -nodrc it wants flag set from gdlen|
|ringout|naomi|no||"ERROR !! TWO JAMMA I/O BOARDS ARE REQUIRED"<br><br>No analog inputs hooked up|
|ringouto|ringout|no|
|rumblef|awbios|no|_Played a single match_<br><br>_Same as rumblefp wrt entering then exiting service mode (random type of crashes)_|
|rumblef2|awbios|no|_Played a single match_<br><br>_Same as rumblefp wrt entering then exiting service mode (random type of crashes)_|
|rumblefp|rumblef|no|_Made a quick play up to round 4_<br><br>_NB: stage names needs to be captured in "map" screen_|Has polygon wrong vertices in "how to play" / "map" / "next challenger" screens<br><br>Cuts off map wireframes on "map" screens<br><br>"Fight" text is partially hidden in ? stage (lens flare covering even?)<br><br>Some pre-fight animations looks weird (jumps off frames? Verify)<br><br>? stage has garbage on background (mip-mapping? Other?)<br><br>Entering then exiting service mode causes a crash and NVRAM corruption when entering gameplay|
|rumblf2p|rumblef2|no|_Played a single match_<br><br>_Same as rumblefp wrt entering then exiting service mode (random type of crashes)_|
|salmankt|awbios|no|"Jun 14 2004" in service mode<br><br>Error 01 at boot, "Network cartridge unconnected"<br><br>Needs touch screen inputs<br><br>Uses AW Card (cfr. attract)<br><br>3p Mahjong attract is questionable on discards (demo visioned sports a weird Kokushi Musou attempt punted at the very beginning, verify)|
|samba|naomi|no||No inputs hooked up<br><br>~~Hangs on produced by Sega (ADX)~~|
|samba2k|naomi|no||No inputs hooked up<br><br>~~Hangs on produced by Sega (ADX)~~|
|sambaa|samba|no|No inputs hooked up<br><br>~~Hangs on produced by Sega (ADX)~~|
|sambap|samba|no|No inputs hooked up<br><br>~~Hangs on produced by Sega (ADX)~~|
|samsptk|awbios|no|_Played a couple matches<br><br>_Looks a bit too demanding performance wise for being a 2d game ..._|Entering service mode is unresponsive, hangs when exiting|
|senko|naomigd|no|
|senkoo|senko|no|_Untested after a brief round_|~~Hangs when coined up (ADX)~~<br><br>Draws wrong polygon vertices<br><br>No fog in gameplay|
|senkosp|naomigd|no|
|sfz3ugd|naomigd|partial?|_Played a couple matches_|~~Hangs in attract/gameplay (ADX)~~<br><br>~~No BGMs (GD-Rom?)~~<br><br>HP bars have polygon slashes|
|sgdrvsim|naomi2|no||
|sgtetris|naomi|partial|_Played a single game, run in attract for 40 minutes_|Draws a _vertical flipped X3_ text above slot GFX (verify, should be a Z sort bug)<br><br>Has network mode in service mode<br><br>Draws no playfield background for 2p side when it's below the tutorial layer in attract mode|
|shaktam|naomigd|?|
|shaktamb|naomigd|?|_No idea about how to play this, assuming it's even doable with current input layout_|Has perspective correction issues on background during gameplay|
|shaktmsp|naomigd|?|
|shangril|naomi|partial|_Tested up to gal 2 (game is very cheaty)_|Cuts off "cyber angel mahjong battle" on title screen<br><br>Has a bit of Z fighting when mahjong table generates<br><br>Has optional network mode|
|shikgam2|naomigd|no|_Tested up to 2-1_<br><br>_Published by Taito_<br><br>_"SHIKIGAMI NO SHIRO 2 Version 1.000 2003/03/07 14:17" in service mode_|Black screens from either game or service mode, if you boot actual game code more than once (i.e. going into service mode then exiting and going game mode will black screen, same for game mode then calling service mode)<br><br>Top of screen repeats what's on bottom<br><br>"For use in Japan" has polygon vertices issue<br><br>Player sprite aura covers own bullets<br><br>Boss explosions are pretty ugly to look at<br><br>Stage clear score recap has background polygon that doesn't blend properly|
|shootopl|naomi|no||Punts with "ERROR I/O BD CONNECTED TO NAOMI BD DOES NOT FULFILL THE GAME SPECS", no inputs are accepted in service mode|
|shootpl|naomi|no||Wants 31kHz Mode<br><br>Punts with "ERROR I/O BD CONNECTED TO NAOMI BD DOES NOT FULFILL THE GAME SPECS"<br><br>Service mode punts with "COM. TIME OUT(HOPPER)" error|
|shootplm|naomi|no||Punts with error 51 (needs 1 player set)<br><br>Wants 31kHz Mode<br><br>Punts with "ERROR I/O BD CONNECTED TO NAOMI BD DOES NOT FULFILL THE GAME SPECS"|
|shootplmp|shootplm|no|
|shors2k1|naomi|no|
|shors2k2|naomi|no|
|shors2k2l|naomi|no|
|shors2k2m|naomi|no|
|shors2k2s|naomi|no|
|shorse|naomi|no|
|shorsel|shorse|no|
|shorsem|shorse|no|
|shorsep|naomi|no|
|shorsepb|shorsep|no|
|shorsepl|shorsep|no|
|shorsepm|shorsep|no|
|shorsepr|naomi|no|
|shorseprl|shorsepr|no|
|shorseprs|shorsepr|no|
|shorseprvl|shorsepr|no|
|shorseprvr|shorsepr|no||Black screen on service mode<br><br>"Communication error" printed when booted, hangs|
|shorseps|shorsep|no||"2003/12/02"<br><br>Wants 31 kHz mode<br><br>Errors with "Device Not Ready" -> ERR_ARCNET_PTV / Sound Driver Init Error|
|sl2007|naomi|no|_made a single sl2007 play, sl2007 is a good benchmark having selectable screens (option 2)_|~~Hangs in attract/gameplay (ADX)~~<br><br>ExZeal don't mask area at top<br><br>ExZeal don't draw any background in gameplay<br><br>Ditto for Shooting Love 2007: Recycle stage has no space background, it also don't draw text/bullets<br><br>Shooting Love 2007: rensha tank stages draws incorrect explosions and tank spawns effects<br><br>Shooting Love 2007: doesn't draw bomb icon (Z sort?)<br><br>Shooting Love 2007: bee dodge stage has no fog<br><br>Can potentially hardlock MAME (pinpoint which stages, -drc?)|
|slasho|naomi|partial?|
|slashout|naomigd|partial?|_Untested after brief stage 2 venture, game's extremely hard and long ..._|Gameplay PIP map doesn't cliprect properly (NB: start button swaps size for it, user tile clips)<br><br>Magic Charges (hold B button in-game) shows misaligned GFXs on HUD<br><br>iframes/Magic Charges sports translucency issue on chars (player and enemies)<br><br>In-game Question Mark drop looks oddly colored (verify)<br><br>Sports communication mode just like Spike-Out<br><br>(trivial) Inputs diverges with default mapping, maps as b2/b3/b4/b1 in service mode (A-B-C with D on bottom row, New NG mapping/Spike-Out)|
|smarinef|naomi|no||Crashes during loading on -drc<br><br>On -nodrc "ERROR I/O BD CONNECTED TO NAOMI BD DOES NOT FULFILL GAME SPECS|
|smlg99|naomi|no|_untested_|Crashes MAME with no stack trace during intro (drc)|
|soulsurf|naomi2|no||
|spawn|naomi|no|_not extensively tested beyond stage 1_|Defaults to Network slave (change in service mode)<br><br>Skips "for use in Japan" too fast<br><br>Hangs during attract (drc)<br><br>Focal camera looks too far in gameplay (verify)|
|spkrbtl|naomigd|no|_Not extensively tested, reached stage 3 once_<br><br>Throws random "ERROR!! COM. ERROR OCCURED BETWEEN NAOMI BD AND I/O BD"<br><br>Writes to $00000000-8 during gameplay (most likely btanb), reads to sound space $810004 (?)<br><br>Has no shadows during gameplay|
|sprtjam|naomigd|partial?|_Played to a single completion round, i.e. listed sub-games_|Sega/WOW logos submerged by the black tree shadow instead of blending<br><br>Attract "Welcome to Sports Jam" shows black texture instead of title logo<br><br>Intro gameplay has white layer covering center presentator mini-screen on zoom-in<br><br>Has black line on top of Sports Jam logo for intermission before/after score result<br><br>"Computer Receive" / "The Great Slugger" / "Final game presentation" has square shadows<br><br>"3 Points Shootout" shows lightning overlaps instead of blending on pre-screens<br><br>"The Great Slugger" has mip-mapping issues for the score panels on stands, black traces for hit balls and bat<br><br>Ugly lightning for ending screen (covering the cup with black)|
|sprtshot|awbios|no|_untested_|Needs lightgun inputs<br><br>Has extra scope (just a physical magnifying glass?)|
|ss2005|naomigd|partial?|_Played a couple rounds_|~~Hangs on Starfish-SD YUV logo (ADX?)~~<br><br>Tile visibility is sorta off|
|ss2005o|ss2005|partial?|
|sstrkfgt|naomi|no||Punts with error 51 (needs 1 player set)<br><br>Joystick in how to play has wrong polygon vertices<br><br>No background for training mode briefings (it's also particularly slow performance wise)<br><br>Full internal camera draws black pixels on HUD<br><br>Planes have some wrong colors on them<br><br>Score debriefing draws instructor with half shadowed face<br><br>Medium/Hard briefings sports girl without half 3d model<br><br>Draws sky with Z fighting on medium course stage 1 (noticeable when tilting plane)|
|sstrkfgta|sstrkfgt|no|
|starseek|naomigd|partial|_Single credit playthrough_|Crashes while accessing service mode (drc)|
|suchie3|naomi|partial|_played a few rounds_|Has black dots on intro movie<br><br>Tiles have polygon vertices bug<br><br>Has wrong colors when entering/exiting panel bonus game<br><br>MC have a line strip when winning/losing (cfr. ggxx*)|
|sushibar|awbios|yes?|_Played one challenge mode_|_No issues?_|
|takoron|naomigd|partial|_Played up to easy mode completion_|"Developed by Compile Heart, distributed by AMI"|
|tduno|naomi|no||Punts with woman crying and "Printer error" screen (disable in service mode)<br><br>Needs Touch Panel inputs<br><br>Clip rectangle bug with attract mode "how to play" screens (cuts off left portion)<br><br>Ugly eyeliner for girl faces|
|tduno2|naomi|no||Wants 31 kHz Mode<br><br>Punts with woman crying and "Printer error" screen (disable in service mode)<br><br>Needs Touch Panel inputs<br><br>Title screen sports sub-title not hooked up<br><br>Attract mode TV drawing cuts off left edge|
|tetkiwam|naomigd|no|_Made a bunch of plays on a few modes_|Backgrounds are trapezoid instead of square on game select (overlay polygons going the wrong directions)<br><br>~~Hangs during attract (ADX)~~<br><br>Some transparencies are bad during gameplay<br><br>Gameplay area shows as pure black instead of being alpha blended separated in square shapes|
|tokyobus|naomi|no||Prints "MOTOR ERROR IN:f0 OUT:ff" when booted (disable it in service with "game assignments" -> "motor power" -> "no power")<br><br>Has no inputs hooked up<br><br>~~Hangs on title screen (ADX)~~|
|totd|naomi|no|
|totdo|totd|no|_Unsurprisingly similar to hotd2 in issues with sorta minor extent_<br><br>_Has stage select (right option)_<br><br>_Untested after stage 1 playthrough_<br><br>_NAOMI keyboard at the end of stage 1 is definitely without numpad_||
|toukon4|naomi|no|_Untested_|Has severe geometry issues during gameplay (arms go haywire, according to MetalliC: "[...] sort of UB, I recall this game does a lot of weird r/w due to bugs or wrong pointer math, and might expect to get some magic values"|
|toyfight|naomi|partial|_Left in attract for >30 minutes_<br><br>_Played to completion_<br><br>"Co-developed with [Anchor Inc.](http://www.anchorinc.co.jp/)" [Wiki](https://en.wikipedia.org/wiki/Anchor_Inc.) [MobyGames](https://www.mobygames.com/company/anchor-inc)|Throws an "AICA read undocumented reg 2500" during boot-up sequence, "read 2300" when entering service mode<br><br>Sega logo has minor polygon issues<br><br>No fog in gameplay/attract<br><br>Has Z fighting on pre-fight scenes<br><br>Cymbals' cymbals (no pun) and Toy King Deluxe (stage 7 boss) has buggy translucency (verify)|
|trgheart|naomigd|no|_untested_|~~Hangs on character select (ADX)~~|
|trghearto|trgheart|no|
|trizeal|naomigd|no|_untested_|~~Hangs on attract/after pressing start (ADX, regression?)~~|
|undefeat|naomigd|partial?|_Tested up to stage 2 boss_|Explosions have Z sort issues (noticeable on bosses)|
|usagiym|naomigd|no|_Played up to 2nd round, until the hang_|Screen is not masked for the right edge (repeats the left column)<br><br>Chapman hints are submerged (horse and face covering tiles)<br><br>Doesn't show ryuukyoku/exhaustive draw hands<br><br>Underlying faces are squared cut off when winning hand<br><br>Seems to hang on Chombo situations, cfr. [MT#8152](https://mametesters.org/view.php?id=8152)<br><br>Has comms mode in service mode (3rd option -> 1st)|
|vathlete|naomigd|no|_Untested on gameplay_|~~Hangs during attract/gameplay (ADX)~~<br><br>Has several bare polygons that hides underlying explainations on how to play|
|vathletep|vathlete|no|
|vf4|naomi2|no||
|vf4b|vf4|no||
|vf4cart|naomi2|no||
|vf4evo|naomi2|no||
|vf4evoa|vf4evo|no||
|vf4evob|vf4evo|no||
|vf4evoct|naomi2|no||
|vf4o|vf4|no||
|vf4tuned|naomi2|no||
|vf4tuneda|vf4tuned|no||
|vf4tunedd|vf4tuned|no||
|vfurlong|awbios|no||"ERROR1: communication cartridge not connected" and "OFFLINE" printed at boot (bypassed by game itself), has background polygon with wrong vertices.<br><br>Performance drops significantly on title screen blend effect (80% -> 19%)<br><br>Hangs when trying to enter service mode, "unknown flash mode byte 0" printed in error.log|
|virnba|naomi|partial?|_Untested after a single match_<br><br>_Marked as USA version but can be booted as Japan too?_|Ball doesn't draw properly<br><br>Gameplay backboards are opaque instead of transparent<br><br>Team select doesn't show the unselected teams (Z sort?)<br><br>Glitchy cursors on gameplay|
|virnbao|virnba|partial?|
|virnbap|virnba|partial?|
|virnbapa|virnba|partial?|
|vonot|naomi|no|_untested after checking it coins it up and enters gameplay in -nodrc_|Needs input re-labels, also what's "QM" even for? (p1 b3)<br><br>Doesn't show game difficulty gauge in service mode. Doesn't show cross hatch in monitor test.<br><br>Has optional Comms link and VMU options in service mode<br><br>Crashes after Presented by Sega with meaningless stack trace (drc)|
|vs2_2k|naomi|partial?|
|vs2_2ko|vs2_2k|partial?|_Played a couple matches_<br><br>_Omake: on team select press start **once** on Yugoslavia, USA, Korea, Italy to unlock YukiChan team on top of Japan_|Black instead of sky in attract, no lights, no shadows<br><br>Input layout should be worked on, Virtua Striker maps b2/b3/b1|
|vstrik3|naomi2|no||
|vstrik3c|naomi2|no||
|vstrik3co|vstrik3c|no||
|vtenis2c|naomi|partial||_same as vtennis2_|
|vtennis|naomi|no||Crashes after Sega logo in attract<br><br>Crashes before gameplay|
|vtennis2|naomigd|partial|_Single game up to Quarter Finals (Wimbledon)_|Black text for players in attract mode (should be white), black stick/buttons in how to play (green) and net is basically opaque (in gameplay too, MetalliC: "mip-map level adjustment ("D-adjust" value)"), black cursor for player select<br><br>Drops corrupted sounds when winning a match (?)<br><br>Gameplay polygons all have wrong vertices<br><br>Clipping issues (objects in the wrong place) when vertical split screen after point scene displays|
|vtennisg|naomigd|no||Crashes after Sega logo in attract<br><br>Crashes before gameplay|
|waidrive|awbios|no||Needs trackball inputs|
|wccf116|naomigd|no||Punts with error 51 (needs 1 player set)<br><br>Wants 31 kHz mode<br><br>Throws "NOT EXIST DIMM BOARD", also soft reset throws error 22 (still wants DIMM board)<br><br>fails satellite comms check<br><br>in service mode it can sometimes set an incorrect video mode (640x288? Pinpoint culprit)<br><br>has camera/card/ic card tests|
|wccf1dup|naomigd|no||Fatalerrors with "GDROM: Could not find the file to decrypt."|
|wccf212e|naomigd|no|
|wccf234j|naomigd|no|
|wccf2chk|naomigd|no|
|wccf310j|naomigd|no|
|wccf322e|naomigd|no|
|wccf331e|wccf322e|no|
|wccf420e|naomigd|no||Punts with error 02 (wants an Export default BIOS)<br><br>Punts with error 51 (needs 1 player set)<br><br>Wants 31 kHz mode<br><br>Draws an "N" in service mode<br><br>black screen when booted|
|wldkicks|naomi|no|
|wldkicksj|wldkicks|no|
|wldkickspj|wldkicks|no||Severe geometry issues on gameplay (all structs points to upper left)<br><br>Entering into Service Mode punts in game anyway<br><br>Title screen is sometimes glitchy (let it run in attract)<br><br>Raw polygons draws incorrect diagonal lines (cfr. championship table)<br><br>missing inputs|
|wldkickspw|wldkicks|no|
|wldkicksu|wldkicks|no|
|wldrider|naomi2|no||
|wrungp|naomi|no|_Untested_|Has no inputs hooked up<br><br>Sports communication link in service mode<br><br>Has wiring test, that requires specific I/O board. Prints "NO MAIN BD ID" / "NO ROM BD ID" / "NO DRIVE BOARD" if booted up (with black instead of transparent pixels)<br><br>Title screen jetski shows full black<br><br>~~Hangs on title screen (ADX)~~|
|wrungpo|wrungp|no|
|wsbbgd|naomigd|partial?|_Played up to a 4th inning game_|Attract mode OP shows portions of field<br><br>Match intro in gameplay has Z fighting on land field<br><br>Base loads has incorrect user tile clips, and sometimes its GFXs shows on main screen<br><br>No player shadows? (verify)|
|wwfroyal|naomi|no||"Co-Developed with THQ, JAKKS, Yuke's"<br><br>Sometimes sound outputs garbage during gameplay<br><br>Crashes MAME when entering service mode with invalid stack trace (buffer overflow?) cfr. [MT#8177](https://mametesters.org/view.php?id=8177) <br><br>Needs 4 player inputs|
|xtrmhnt2|awbios|no||Uses ALL.Net device<br><br>Cannot be started or put into service mode (missing lightgun or network too?)<br><br>Has wrong alpha effect on background of ranking screen|
|xtrmhunt|awbios|no||Missing lightgun inputs|
|zerogu2|naomi|partial|_Played up to loop 1 completion (7 stages)_<br><br>_Has two buttons listed in service mode_<br><br>_Has Maintenance Mode in typical Psikyo fashion in service mode (unknown codes)_|No fog during attract/gameplay<br><br>Powerup gems don't blend<br><br>Cuts off bullets on status bar instead of blending during gameplay. Bullets coming from player heli are covered by rotor blades<br><br>Has serious camera positioning issues on skippable cutscenes<br><br>Clouds don't blend in sky stage (1-3?)<br><br>Final stage lasers overlap without transparency<br><br>Ending text shows stats values during fade-in/-out (i.e. stage 1 time/shot down/score without legenda attached). Fixes once transition fully completes|
|zombrvn|naomi|no|
|zombrvne|zombrvn|no|
|zombrvno|zombrvn|no|_Played up to stage 1 boss_<br><br>_Needs optional digital control method_|Player HP bar doesn't show poison and life loss at all<br><br>Character select screen initially submerges top of screen with a black strip (fixes by moving cursor)<br><br>"Are we still following this guy" scene has terrible shadowing<br><br>Area 1 boss lacks fog<br><br>Sometimes black screens on entering game service mode|
|zunou|naomi|no||Wants 31 kHz<br><br>Hangs when booting either game or Service Mode (bp c0d1c9e)<br><br>Extreme cut off of overall screen if booted<br><br>Eventually crashes with wild error.log accesses<br><br>Should **at very least** need touch screen inputs|
