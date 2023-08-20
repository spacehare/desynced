import subprocess
import argparse
import yaml
import zipfile
import os
from pathlib import Path


def mistake(text):
    response = input(text + '\n').casefold()
    if response in ['n', 'no'] or response not in ['yes', 'y', 'ok']:
        exit()


HERE: Path = Path(__file__).resolve().parent
TEMP: Path = Path(HERE, '.temp')
MODS_FILE: Path = Path(HERE, 'mods.yaml')
new_source_path: Path
target_zip: Path

mods: dict = yaml.load(MODS_FILE.read_text(), Loader=yaml.Loader)
DesyncModUploader_args: list[str] = [mods['uploader']]
ap = argparse.ArgumentParser()

ap.add_argument('source',
                help=f'The mod you want to upload. ZIP, folder, or name (key) of the mod in {MODS_FILE.name}')
ap.add_argument('--no-del', action='store_true',
                help="Don't delete ZIP in temp folder after finishing")
ap.add_argument('--no-upload', action='store_true',
                help="Don't upload the ZIP to the Steam workshop")
ap.add_argument('--sym-dir', '--sym', nargs='?', type=Path, const=mods['content_mods'],
                help=f"Requires admin privileges. Instead of zipping or uploading, create a symlink with this folder as the <link> or <src> and the \"source\" argument as the <target> or <dst>. If no folder is provided, it will use the value of content_mods in {MODS_FILE.name} instead")
ap.add_argument('--image', type=Path,
                help="An image file. Required for uploading new mods!")

args = ap.parse_args()
upload: bool = args.sym_dir is None and not args.no_upload

if args.source in mods:
    print(f'found {args.source} in {MODS_FILE.name}')
    new_source_path = Path(HERE, mods[args.source]['path'])
    if 'id' in mods[args.source] and mods[args.source]['id'] is int:
        DesyncModUploader_args += ['-u', f"{mods[args.source]['id']}"]
    elif upload:
        mistake(
            f'The mod id is missing from {MODS_FILE.name}, do you want to upload a new mod?')
else:
    if upload:
        mistake(
            f'This mod does not exist in {MODS_FILE.name}, do you want to upload a new mod?')
    new_source_path = Path(args.source)

if args.sym_dir:
    if new_source_path.is_dir():
        os.symlink(new_source_path,
                   args.sym_dir / new_source_path.stem,
                   target_is_directory=True)
    else:
        print('symlink must be folder')
    exit()

if new_source_path.is_dir():
    target_zip = Path(TEMP, new_source_path.stem).with_suffix('.zip')
    with zipfile.ZipFile(target_zip, 'w', zipfile.ZIP_DEFLATED) as zf:
        for item in new_source_path.rglob('*'):
            new_name = Path(*item.parts[len(new_source_path.parts):])
            zf.write(item, arcname=new_name)
elif new_source_path.is_file() and new_source_path.suffix == '.zip':
    target_zip = new_source_path
else:
    print('upload source must be folder or .zip')
    exit()

DesyncModUploader_args.append(str(target_zip))
if args.image:
    DesyncModUploader_args.append(str(args.image))

print(*DesyncModUploader_args)

if not args.no_upload:
    result = subprocess.run(DesyncModUploader_args,
                            capture_output=True,
                            text=True)
    print(result)

if not args.no_del:
    target_zip.unlink()
