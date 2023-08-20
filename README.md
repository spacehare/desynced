# desynced

for my Desynced mods and tools

## using [mod.py](mod.py)

1. install [python](https://www.python.org/downloads/)
1. install [PyYAML](https://pypi.org/project/PyYAML/)
1. edit [mods.yaml](mods.yaml) with your file paths
1. use `py mod.py -h` for command help

### what it does:
1. take user arguments (like what mod the user wants to upload)
1. take information from the [mods.yaml](mods.yaml) file (like the mod `id` and `path` if they exist)
    - if the mod `id` or the mod itself does not exist, ask the user if they want to upload a new one
1. zip the folder, if the mod isn't already zipped
1. uploads or updates with `DesyncedModUploader.exe`

example: `py mod.py RabbitsFirstMod`

it can also create symlinks. you can choose one or it will default to Desynced's `mods` folder (`content_mods`)

example: `py mod.py RabbitsFirstMod --sym`


### example `mods.yaml`:
```yaml
uploader: R:\Rabbit - Game Dev\DesyncedModUploader-1.0\DesyncedModUploader.exe
content_mods: N:\SteamLibrary\steamapps\common\Desynced\Desynced\Content\mods
workshop: N:\SteamLibrary\steamapps\workshop\content\1450900

# path should be relative to this file (mods.yaml)
RabbitsFirstMod:
  id: 3021710010
  path: RabbitsFirstMod\RabbitsFirstMod
```

