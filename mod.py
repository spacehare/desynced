import subprocess
import argparse
import yaml
import zipfile
from pathlib import Path

TEMP: Path = Path('.temp')
MODS_FILENAME: Path = Path('mods.yaml')

mods: dict = yaml.load(MODS_FILENAME.read_text(), Loader=yaml.Loader)
# with open(MODS_FILENAME, encoding='utf-8') as f:
#     mods = yaml.load(f, Loader=yaml.Loader)
target_zip: Path
DesyncModUploader_args = [mods['uploader']]
ap = argparse.ArgumentParser()

ap.add_argument('source',
                help='The mod you want to upload. ZIP or folder')
args = ap.parse_args()

new_source_path: Path

if args.source in mods:
    print(f'found {args.source} in {MODS_FILENAME}')
    new_source_path = Path(mods[args.source]['path'])
    DesyncModUploader_args.append(f"-u {mods[args.source]['id']}")
else:
    mistake = input(
        f'This mod does not exist in {MODS_FILENAME}, do you want to upload a new mod?')
    if mistake == 'no' or mistake == 'n':
        exit()
    new_source_path = Path(args.source)


if new_source_path.is_dir():
    target_zip = Path(TEMP, new_source_path.stem).with_suffix('.zip')
    with zipfile.ZipFile(target_zip, 'w', zipfile.ZIP_DEFLATED) as zf:
        for item in new_source_path.rglob('*'):
            new_name = Path(*item.parts[len(new_source_path.parts):])
            zf.write(item, arcname=new_name)
elif new_source_path.is_file() and new_source_path.suffix == '.zip':
    target_zip = new_source_path
else:
    print('folder or .zip only')
    exit()

DesyncModUploader_args.append(str(target_zip))

print(DesyncModUploader_args)

# result = subprocess.run([mods['uploader']],
#                         capture_output=True,
#                         text=True)
# print(result)


target_zip.unlink()
