_NOTE: The current page is still in construction; the information here so far was provided through Shiburizu's own guide for Flycast-GGPO._

***

Flycast's GGPO networking integration allows for zero-delay online play. It is currently in an "alpha" quality so bear in mind there are bugs, missing features and many updates. Still if you'd like to play here's a guide on how to do so.

If you find this kind of work valuable consider tipping Flyinghead for his work on the Flycast project. Please try to troubleshoot as much as you can and hit up the Flycast Discord if you are still having trouble.

## The basic process
This is the basic process of using Flycast's GGPO networking, bearing in mind there are many optimizations which will be described below.

1. [Download the latest version of Flycast-Dojo GGPO test release.](https://github.com/blueminder/flycast-dojo/releases)
2. Place Flycast in its own folder and run. This will create initial configs and let you bind buttons. Be sure to specify your content location to get your ROMs & BIOS choices picked up.
3. Bind your controller. Make sure your controller choice is set to Port A.
4. If your game does not have a save state, create or load one. Flycast-dojo may have a default for you already, check the list.
5. In the Dojo settings tab, set Netplay Method to "GGPO (experimental)". Also make sure "Internet Matchmaking" is enabled.
      1. If you are "hosting", select the "HOST" in the drop down on the main menu and pick your game. This will generate a Match Code to send to your opponent.
      2. If you are "joining", select the "JOIN" in the drop down on the main menu and pick your game. You will be asked to enter a Match Code provided to you by the host and click "Start Session".
6. Both players will be asked to optionally set a fixed input delay to keep gameplay consistent over distant connections (>100ms). You may set from 1 to 20 frames with the Delay slider and both players must have the same delay value. You may use "Suggest delay" to see the detected ping and receive a suggested delay value.
7. Click "Start Session" once again to connect to your opponent and begin gameplay.

If you wish to connect to your opponent with a public IPv4 address or through a virtual LAN such as Radmin-VPN or Zerotier you can disable "Internet Matchmaking" in the Dojo tab and it will ask for an IP Address for both players to connect to each other instead.

## Save states

First you should check if Dojo has a save state for you to use first. If not, create your own.

### Save states included in Dojo
Games with downloadable pre-configured save states will be highlighted in yellow on the ROM selection screen when hosting or joining. Right click on the game in the list and click "Download Savestate". Both players should do this otherwise your game will never be in sync.

You can browse the list of states [here](https://github.com/blueminder/flycast-netplay-savestates).

### Creating a save state for netplay
This is critical to avoid crashes and desyncs. Do it for every game you play.

1. Start a game offline. Get the game into a state you'd like to begin playing online with (i.e. Character Select). Open the Menu (TAB on Keyboard by default) and click Save State.
1. This will create a .state file for the ROM you are playing in the "data" folder of the emulator.
1. To set this newly-created save state as your netplay default add `.net` to the end of the file name i.e. `ausfache.state.net`
1. Send it to your opponent to place in their data folder. If both players are using flycast-dojo it will load the state automatically in GGPO netplay.

## Joysticks over GGPO
Some games such as racing or platformer games require use of the Dreamcast's joysticks. At the time of writing Flycast allows you to optionally enable left joystick inputs over GGPO. Note that due to the nature of analog inputs you may encounter more desyncs or more demanding performance than usual so only use it if it is an absolute requirement to play.

To enable it find the "Left Thumbstick" option in the Dojo settings tab and enable "Horizontal" if you only need left/right (Racing games) or Full if you need all directions of input.



## Common issues
Issues listed here will be specific to GGPO Networking setups. For general controller support, ROM set questions or emulation tweaks you should read the relevant pages on this wiki and [Flycast Dojo's FAQ](http://flycast.dojo.ooo/faq.html).

* GGPO Assertion Failed: First make sure you are using a save state to play. After, swap the P1 and P2 player. This may be an issue with the "host" player network.
* Game opens a service/test/debug menu: Go to your controller mappings, select Arcade Controls in the drop-down. Find Service, Test, Menu, etc. and click Unmap. Do this for pretty much anything you're not using to avoid problems.
* Unhandled SH4 Exception: Make sure both players have their Mouse port set to None in the Controls tab.
* Wrong controller bindings during gameplay: Flycast stores your Dreamcast and Arcade control schemes independently but some games may default to the wrong setting. Make sure that when you set Dreamcast and Arcade controls in the dropdown that the bindings are identical.

### Dreamcast devices
A compatibility tweak for Dreamcast games or games that supported VMU loading. Helps if you get crashes during loading screens.

* Go to the Controls settings tab.
* Set Device A and B to "Sega Controller" and set C and D to None, with both peripheral options next to the controller choice in ports A and B set to None as well.
* Use save states when netplaying.