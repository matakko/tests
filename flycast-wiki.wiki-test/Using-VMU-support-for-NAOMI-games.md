Some few NAOMI games have an option to use an VMU, as originally there were cabinets that allowed you to plug your own VMU into the cabinet and use your own data from the console version of the game. Support for this feature is still in progress, and can be confirmed to work on some games, but still needs implementing on others.
* The first thing you would have to do, regardless of the game, is to enable the VMU usage through the Game Test Menu. The option name may depend of the game, but it always comes turned off by default.
* Most if not all games will disable or hide the VMU usage option if the Region is NOT set to Japan; so that means you have to use the Japan region in order to use it.
* All games read the VMU from the B1 slot (for Player 1; if the game supports an second VMU for Player 2, it will use the C1 slot). This means that the game files to be used need to be saved to B1 (or C1 for Player 2), and the corresponding controller and VMUs must be enabled.
* For each game guide on using their VMU features, make sure to check the linked pictures on each step, for context and knowing how things should look.

### Games known to have VMU support
* Cannon Spike/Gunspike (cspike)
* Capcom Vs. SNK Millenium Fight 2000 (capsnk)
* Capcom Vs. SNK Millenium Fight 2000 Pro (cvsgd)
* Capcom Vs. SNK 2 Mârk of the Millenium 2001 (cvs2)
* Cyber Troopers Virtual-On Oratorio Tangram M.S.B.S. 5.66 (vonot)
* Heavy Metal Geomatrix
* Marvel VS. Capcom 2 (mvsc2)
* Power Stone 2 (pstone2)
* Project Justice/Moero Justice Gakuen (pjustic)
* Street Fighter Zero 3 Upper (sfz3ugd)

### Games confirmed with emulated/working VMU support
* Capcom VS. SNK Millenium Fight 2000 (capsnk)
* Capcom VS. SNK Millenium Fight 2000 Pro (cvsgd)
* Cyber Troopers Virtual-On Oratorio Tangram M.S.B.S. 5.66 (vonot)
* Project Justice/Moero Justice Gakuen (pjustic)
* Street Fighter Zero 3 Upper (sfz3ugd)

### Games yet to be emulated/working with VMU support (currently they aren't recognized due to using an different hardware)
* Capcom Vs. SNK 2 Mârk of the Millenium 2001 (cvs2)
* Spawn


## Capcom VS. SNK Millenium Fight 2000 Pro (cvsgd)
* Compatible with: Capcom VS. SNK Pro for Dreamcast (which is Japan only)
* Features: Using your custom colors saved in the VMU with the Color Edit mode
* How to use:
  * Create an custom color with the [Color Edit mode](https://github.com/TheArcadeStriker/flycast-wiki/blob/master/screenshots/naomivmu/cvsgd-1.png) of the Dreamcast game. (for this example, we're making [Gouki](https://github.com/TheArcadeStriker/flycast-wiki/blob/master/screenshots/naomivmu/cvsgd-2.png) and [E. Ryu](https://github.com/TheArcadeStriker/flycast-wiki/blob/master/screenshots/naomivmu/cvsgd-3.png) custom colors)
  * Save it on the [VMU slot B1](https://github.com/TheArcadeStriker/flycast-wiki/blob/master/screenshots/naomivmu/cvsgd-4.png) (or save anywhere else and copy it later to B1); you have [two](https://github.com/TheArcadeStriker/flycast-wiki/blob/master/screenshots/naomivmu/cvsgd-5.png) Color slots avaliable per character, and colors can be saved to either or both at the same time.
  * Load Capcom VS. SNK Pro NAOMI and go to [Test Menu](https://github.com/TheArcadeStriker/flycast-wiki/blob/master/screenshots/naomivmu/cvsgd-6.png), then [Game Test Menu](https://github.com/TheArcadeStriker/flycast-wiki/blob/master/screenshots/naomivmu/cvsgd-7.png).
  * [Set the VM-Kit option to 'SEGA'.](https://github.com/TheArcadeStriker/flycast-wiki/blob/master/screenshots/naomivmu/cvsgd-8.png)
  * Exit both test menus and enter the game as normal; if the VMU is recognized, [it should briefly show an VMU image](https://github.com/TheArcadeStriker/flycast-wiki/blob/master/screenshots/naomivmu/cvsgd-9.png) (and say "ACCESS" on the B1 VMU screen if shown) before showing the character select screen.
  * Characters with avaliable custom colors will have [Color 1](https://github.com/TheArcadeStriker/flycast-wiki/blob/master/screenshots/naomivmu/cvsgd-10.png) and/or [Color 2](https://github.com/TheArcadeStriker/flycast-wiki/blob/master/screenshots/naomivmu/cvsgd-11.png) tags on them. You can select Color 1 by pressing LP+HK on the character, and Color 2 by pressing LK+HP.
  * [Note that you should be able to see the tag of your selected custom color appear floating away if you selected it.](https://github.com/TheArcadeStriker/flycast-wiki/blob/master/screenshots/naomivmu/cvsgd-12.png)
  * Enjoy your custom colors! Here's the end result, with [Gouki](https://github.com/TheArcadeStriker/flycast-wiki/blob/master/screenshots/naomivmu/cvsgd-13.png) and [E. Ryu](https://github.com/TheArcadeStriker/flycast-wiki/blob/master/screenshots/naomivmu/cvsgd-14.png) using their previously created custom colors.

## Project Justice/Moero Justice Gakuen (pjustic)
* Compatible with: Moero Justice Gakuen (Japanese versions of Project Justice only)
* Features: Allows you to use your EDIT characters made through the Nekketsu Nikki board game in the Dreamcast version, which is where you create the custom characters.
* How to use:
  * Play the Nekketsu Nikki mode of the Dreamcast version (should be the first option in the menu). Note that it has a lot of untranslated text, so you can either use an FAQ and just go through it as fast as you can. You NEED to finish the 40 turns the board game has and then wait for the CPU matches to end.
  * Once that is done, keep pressing A until it prompts you to save to an VMU. You can save it to VMU slot B1 (for Player 1) or VMU slot C1 (for Player 2); at this point you are finally saving the EDIT character data in a usable form.
  * Boot Moero Justice Gakuen NAOMI and go to Test Menu, then Game Test Menu.
  * Set the VM-Kit option to 'SEGA'
  * Exit both test menus and enter the game as normal. If the VMUs are recognized with valid files, then not only there should be an EDIT icon avaliable where an Random icon normally is, but it should also show that the VMU is valid, and then allow you to select your custom character.
  * Enjoy your custom character!

## Street Fighter Zero 3 Upper (sfz3ugd)
* Compatible with: Street Fighter Zero 3 Saikyo-ryu Dojo (Japanese version of SFA3 only). Matching Service version is also compatible.
* Features: Allows you to use the first 3 custom characters slots from set in Entry Mode on the Dreamcast; said custom characters are imported from World Tour mode.
* How to use:
  * Play the World Tour mode of the Dreamcast version, which can be progressed as much as you want with your selected character.
  * When you are done, save the World Tour data to any VMU.
  * Go to Entry mode and register your World Tour character, then save the game data into VMU slot B1 (for Player 1) or VMU slot C1 (for Player 2).
  * Boot Street Fighter Zero 3 Upper and go to Test Menu, then Game Test Menu.
  * Set the VM-Kit option to 'SEGA'
  * Exit both test menus and enter the game as normal. If the VMUs are recognized with valid files, it should show VMUs with an 'OK' on it, and then show the custom characters in the Entry slots.
  * Enjoy playing with your World Tour characters!