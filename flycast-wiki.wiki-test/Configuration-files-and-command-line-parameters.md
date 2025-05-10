## Main configuration file (emu.cfg)
The main file where most if not all of flycast's settings is called emu.cfg, located in the root of flycast's folder.

### Audio section [audio]
The only options here are backend (audio backend used) and disabling audio or not. Note that in the backend option, the backends avaliable may vary from the OS being used, but generally it is fine to use auto.
| Option      | Values      | 
| ----------- |:-------------:|
| backend    | auto, null, depends of OS   |
| disable    | 0, 1   |

### Main config section [config]
| Option      | Values      | Description      | 
| ----------- |:-------------:|:-------------:|
| Debug.SerialConsoleEnabled   | no/yes   | Serial cable related. Not exposed in settings menu. For debug purposes. |
| Debug.SerialPTY    | no/yes   | Not exposed in settings menu. For debug purposes. Linux/Unix only. |
| Dreamcast.Broadcast   | 0-4   | Broadcast setting. 0=NTSC, 1=PAL, 2=PAL/M, 3=PAL/N, 4=Default |
| Dreamcast.Cable   | 1-3   | Cable setting. 1=VGA, 2=RGB Component, 3=TV Composite |
| Dreamcast.ContentPath   | path; | Content Paths to load games from. Additional file paths separated with ";" |
| Dreamcast.ForceWindowsCE   | no/yes   | Force full MMU emulation and other Windows CE features. |
| Dreamcast.HideLegacyNaomiRoms   | no/yes  | Hide Legacy NAOMI roms (.bin, .dat and .lst) from game list |
| Dreamcast.Language   | 0-6   | 0=Japanese, 1=English, 2=German, 3=French, 4=Spanish, 5=Italian, 6=Default. |
| Dreamcast.Region   | 0-3   | Region setting. 0=Japan, 1=USA, 2=Europe, 3=Default |

### Window/screen section [window]
The options avaliable here are useful to change the window size (width and height), as well as selecting if Flycast is maximized or fullscreen.
| Option      | Values      | 
| ----------- |:-------------:|
| fullscreen    | no/yes  |
| height    | number   |
| maximized    | no/yes  |
| width    | number  |


## Command-line parameters
### Launching game from command-line/batch
Flycast supports loading games through drag-and-dropping over the .exe file, using an batch file or through the command-line. For example, if you have an Marvel VS. Capcom 2 ROM at the root Flycast folder and you have an flycast.exe file, if you type `flycast.exe mvsc2.zip` on the command-line, flycast should open with Marvel VS Capcom 2 booting; as long as you have the NAOMI BIOS installed. Essentially, by putting the flycast's executable filename alongside the name of the ROM file, relative path OR the full path, flycast should load it. Note that if the filename or file path has spaces, you should enclose it in quotes. Here's some examples:
* `flycast mvsc2.zip` (flycast.exe + filename; on Windows you can just use the exe filename and will still run)
* `flycast.exe "games/dreamcast/Daytona USA (USA).chd"` (flycast.exe + path to game inside root folder; note that game path is enclosed in quotes)
* `flycast.exe "C:\Emulators\flycast\games\dreamcast\Dennou Senki - Virtual-On - Oratorio Tangram (Japan)\Dennou Senki - Virtual-On - Oratorio Tangram (Japan).gdi"` (flycast.exe + FULL path to game; absurdly long in this case but it also works; note that game path is enclosed in quotes)
* `"C:\Emulators\flycast\flycast.exe" "C:\mvsc2.zip"`(FULL path for flycast.exe + path to game, which in this example is in C:\ root; note that game path is enclosed in quotes)
* `C:\Emulators\flycast\flycast.exe C:\mvsc2.zip`(FULL path for flycast.exe + path to game, which in this example is in C:\ root; note that game path ISN'T enclosed in quotes because there are no spaces in either path, but it is valid to enclose in quotes as shown in the previous example)

In any case, you should enclose the paths in quotes (if you need to, either relative or path) if the path contains any folder or the filename of the game has spaces on it; and if you are trying to load something through command-line but doesn't work, enclose the paths anyways even if it doesn't seem to have spaces.

### Using settings through command-line parameters
You can pass settings to flycast through parameters, in order to make the emulator use them when loading through command-line or batch; these are temporal and are not saved when the emulator is closed (with some very few exceptions; and modifying settings through the emu after using these will still save changes).
The parameters used are actually taken from the emu.cfg possible settings themselves, with the template being `-config  section:key=value`; section being the section where the setting/key is located (in the lists above, the section name for each one is enclosed in brackets), the key is the setting/option to be changed, and the value is the value you would use for said setting.

For example, using `flycast.exe -config config:rend.Rotate90=yes` will make flycast open with the screen rotated 90º; the section here would be `config`, the key/option would be `rend.Rotate90` which is under the aforementioned `config` section, and the value, which can be yes or no, is set here to `yes`. These can be used as well when loading an game through command line (the parameters must be specified before the game filename/filepath), and more than 1 can be used at a time, which can be done by placing another `-config`with the wanted parameters in front of the first one, and so on.

Another example could be, if we wanted to load Capcom VS SNK Pro NAOMI from an folder, in fullscreen and with Widescreen hack enabled enabled, we would use `flycast.exe -config config:rend.WideScreen=yes -config window:fullscreen=yes "C:\Emulators\flycast\games\arcade\cvsgd.7z"`, and the structure is like the following:
* `flycast.exe`
* `-config config:rend.WideScreen=yes`, which is used to set WideScreen hack enabled
* `-config window:fullscreen=yes `, which is used to open the emulator in fullscreen regardless of if that option was set previously or not
* `"C:\Emulators\flycast\games\arcade\cvsgd.7z"`, which is an full path to the ROM for Capcom VS SNK Pro (in this case, it could also be passed WITHOUT quotes since there's no spaces anywhere in the path)