#!/bin/sh

HUGO_PATH="$HOME/Git/obenedito.org"
TEMP_DIR="$HOME/.tmp-webdav"
MOUNT_PATH="/media/obenedito"
WEBDAV_FOLDER="html-obenedito.org"

rm -rf "$HUGO_PATH/public"
hugo -s "$HUGO_PATH" --minify
mount "$MOUNT_PATH"
mkdir "$TEMP_DIR"
rsync -ruvc --progress --delete --temp-dir="$TEMP_DIR $HUGO_PATH/public/" \
  "$MOUNT_PATH/$WEBDAV_FOLDER"
rmdir "$TEMP_DIR"
umount "$MOUNT_PATH"
