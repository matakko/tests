## What is DCNet?
DCNet is a cloud service dedicated to support select Dreamcast games with online features to be able to play them through Flycast seamlessly without the need of port-forwarding/UPNP configuration.

While connecting to Dreamcast Live servers through Flycast requires game-specific port-forward configurations in routers to be able to succesfully play in most if not all games, DCNet lets you play in any of the supported games from any functional internet connection without previous setup as it uses its own servers.

To use this feature, you just need to head to the Network tab, enable DCNet, and access the game's online mode as you normally would.

**This feature is currently only available in the latest Flycast builds**, so you need to download that from the [Flycast builds website](https://flyinghead.github.io/flycast-builds/).

Note that for it to work, the ISP info stored in the emulated Dreamcast flash should be user "flycast1" or "flycast2" with password "password" (these are set by default by Flycast) - if you change these through a web browser, it won't work.

## Currently supported games:

Note that any games marked as [Alpha] or [Beta] are supported and playable but with early code - so expect the possibility of bugs/crashes happening with them.

* 4x4 Evolution
* ChuChu Rocket
* Dee Dee Planet
* Internet Game Pack
* Monaco Racing Simulation 2
* NBA 2K1
* NBA 2K2
* NCAA 2K2
* NFL 2K1
* NFL 2K2
* Ooga Booga
* PBA Bowling 2001
* Planet Ring
* POD: Speedzone
* StarLancer
* Toy Racer
* World Series Baseball 2K2
* Worms World Party

Beta:
* Daytona USA
* Sega Tetris
* Golf Shiyou Yo 2
* Aero Dancing i
* Aero Dancing i Jikai Saku Made Matemasen
* Hundred Swords

Alpha:
* Speed Devils Online

Additionally, the following games, while not using DCNet game servers, are also fully compatible with DCNet:
* F355 Challenge
* Phantasy Star Online v1 and v2
* Quake III
* Mobile Suit Gundam: Federation vs. Zeon [to be fully confirmed]

## Guide to get started with DCnet. (W.I.P)

* Go to the **Settings** page on **Flycast** , and to the **Network** tab, and Check the box **DCnet**. 

* * With **DCnet,** you can now connect via Cell Network or open **Wi-fi**.

* * Online play on Dreamcast at **33.6k** modem speeds mean that you use next to **no** data. With a little math we can take the data rate, **33.6 kbps**, make it easier to work with and we get **4.2 KB/s,** which over a time of **1,073,741,824 seconds** or **69.4 hours** will consume **1 GB** of data. 

*The actual time will most likely will be much longer due to protocol overhead, how the game works, connection instability typical of dial-up modems, and also the fact that most games are not sending data continually at the max speeds. Even at these speeds, it is pretty amazing how the gameplay is so smooth.*

## Guides for individual games to get going. (W.I.P)


* **Daytona USA -** You must first enter **HOMEPAGE** in the Main Menu to create a Key file, complete with the username/password you want it to be registered with, then save it to the VMU. Once you have that file saved, enter **NET BATTLE**, select the VMU where you have the Key File saved, select the VMU with your game save, select Yes to the two disclaimers afterwards, select flycast1 in the Select Provider screen and wait until it says you're connected.

* Then, you create a handle [or select it if you already have one], select the DCNet_Daytona server, select your lobby of preference and then create/join a team to play at.

* **Pod Racer -** When you hit **"Network"** scroll 2 times to the left until you are on **"ACCOUNT 1"** then once you dial in you MUST MAKE A NEW NAME, and then once that is done, you are able to use that name/pass combo to just login each time after, but this game you actually have to register the name you select, again, 6 digit name and pass please.

* **Quake III -** Go to **OPTIONS** from the **Main Menu > Player** and set your name and player here, this is how you will be seen online. make sure you save and load this profile when you boot back in to the game to carry your data with you.

* **Toy Racer -** Will ask you for a Nickname to show you in games, and also asks for a password, for this game ANY password works. Type anything, even  a single letter, will breeze you thru.

* **Monaco Grand Prix -** Online requires you to hit **"NEW USER"** and register your nick and pass, use 6 chars minimum, then you can use this name after the initial creation to just "Connect" with every time after.

* **F355 Challenge -** Does not require login info to enter **NETWORK PLAY**, but you should first go to **SETTINGS>GAME OPTIONS** and set your name and country here [the countries available depend of the game region]. Then **SAVE** on the main menu to save this name profile. 

* You can also go to **CAR PROFILE** to set any settings for the car, color, and number here (the name shown here is for the car data, not your online name), but don't forget to SAVE on this screen.

* Normally, you will have to LOAD from the main menu and then from the **CAR PROFILE** screen to have your network play name and car, as the game doesn't auto-save or auto-load. You can also create a savestate after having these set-up and then load it anytime you want to head over online.

* **NBA 2K1, NBA 2k2, NFL 2K1, NFL 2k2, NCAA 2K2,  World Series Baseball 2K2, and Ooga Booga -** The following games require you to "login" with a username and password combo, make sure each one is 6 characters long, and using the same name and pass combo is recommended to track your scoring. ***NOTE.** YOUR USERNAME AND PASSWORD MUST BE 6 CHARACTERS. ANY LESS WILL NOT BE ACCEPTED.*
1  *Now in the 2k Games, as long as you use the same username login, it will start to track your scores!* 

* **ChuChu Rocket -** When entering Network for the first time, it will ask you for an username and password. You can set it to whatever, and it will autosave to the VMU. Verified as small as 3 characters for both, you should use the same username/pass combo to keep score tracking.

* **Dee Dee Planet -** The game servers are set to not check passwords, so registration is not necessary and any user name/password is accepted.

* **Planet Ring -** This game requires a registration, but the unique part here (Verified with a 6 char password) is you need a **PRIVACY CODE.** I have verified it works by entering 10 letters in to the spot and continuing. I have NOT yet verified if 2 people can use the same random 10 digit code and be logged in at the same time.
