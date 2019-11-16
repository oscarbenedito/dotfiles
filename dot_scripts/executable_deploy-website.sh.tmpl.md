# File `deploy-website.sh`
This file automatically deploys my website, given the appropriate configuration on the machine.

## File description
Shebang line and setting up the variables.
```bash file executable_deploy-website.sh.tmpl
#!/bin/bash
HUGO_PATH="{{ .chezmoi.homedir }}/Git/obenedito.org"
TEMP_DIR="{{ .chezmoi.homedir }}/.tmp-webdav"
MOUNT_PATH="/media/obenedito"
WEBDAV_FOLDER="html-obenedito.org"
```

We delete the previous build site on the folder (as far as I have noticed, Hugo doesn't delete the files by default, so deleted files would still be in the new build if this line wasn't here).
```bash file executable_deploy-website.sh.tmpl
rm -rf $HUGO_PATH/public
```

We build the website
```bash file executable_deploy-website.sh.tmpl
hugo -s $HUGO_PATH --minify
```

We mount the filesystem with WebDAV (considering it is well configured) and we create the temporary directory for the `rsync` call.
```bash file executable_deploy-website.sh.tmpl
mount $MOUNT_PATH
mkdir $TEMP_DIR
```

We synchronize the files with `rsync`.
```bash file executable_deploy-website.sh.tmpl
rsync -ruvc --progress --delete --temp-dir=$TEMP_DIR $HUGO_PATH/public/ $MOUNT_PATH/$WEBDAV_FOLDER
```

Finally, we remove the temporary directory and unmount the filesystem.
```bash file executable_deploy-website.sh.tmpl
rmdir $TEMP_DIR
umount $MOUNT_PATH
```
