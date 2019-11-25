# File `.bash_aliases`
Alias to run Markion everytime we use chezmoi, before actually running chezmoi.
``` file dot_bash_aliases.tmpl
chezmoi() {
  sh $HOME/.local/share/chezmoi/markion.sh
  {{ .chezmoi_location }} $*
}
```

Changing the `clear` command.
``` file dot_bash_aliases.tmpl
alias clear="printf '\033c'"
```

Alias to update the system, diferent for Debian or Arch.
``` file dot_bash_aliases.tmpl
alias upgrade="
{{- if eq .chezmoi.osRelease.id "debian" -}}
  sudo apt-get update && sudo apt-get upgrade
{{- else -}}
  sudo pacman -Syyu
{{- end }}"
```

## Backups
If backup is enabled in the `chezmoi` data, create backup alias, excluding the files specified in the `chezmoi` data. First is the complete backup alias:
``` block backup_all
alias backup_all="rsync -gloptruzvP --delete --no-group --exclude={
  {{- range $i, $dir := .backup.backup_exclude }}
    {{- if $i -}}
      ,
    {{- end -}}
    "{{ $dir }}"
  {{- end -}}
} {{ .chezmoi.homedir }}/ /media/$USER/OSCAR/.{{ .backup.backup_dir }}/"
```

And secondly the smaller backup, with extra excluded directories. I back it up on a USB drive so I encrypted with VeraCrypt (as I carry my USB around, I wouldn't want my personal data to be in plain text in case I lost it). It will back it up to two VeraCrypt volumes (as the backup takes up more than 4GiB and the USB where I do it is formated with a FAT filesystem). First of all, we mount the VeraCrypt volumes:
``` block mount-backup-vc
veracrypt --mount /media/$USER/Oscar/Varis/copia-gris.hc --slot="10"
veracrypt --mount /media/$USER/Oscar/Varis/copia-gris-git.hc --slot="11"
```
Then we back up all the data:
``` block rsync-small-backup
rsync -gloptruzvP --delete --exclude={"/Git",
{{- range $i, $dir := .backup.backup_exclude }}
  {{- if $i -}}
    ,
  {{- end -}}
  "{{ $dir }}"
{{- end -}}
{{ range $dir := .backup.small_backup_exclude -}}
  ,"{{ $dir }}"
{{- end -}}
} {{ .chezmoi.homedir }}/ /media/veracrypt10/{{ .backup.backup_dir }}/
rsync -gloptruzvP --delete {{ .chezmoi.homedir }}/Git/ /media/veracrypt11/{{ .backup.backup_dir }}/
```

And finally we unmount the volumes.
``` block unmount-backup-vc
veracrypt --dismount /media/$USER/Oscar/Varis/copia-gris.hc
veracrypt --dismount /media/$USER/Oscar/Varis/copia-gris-git.hc
```

So the alias will be:
``` block backup_vc_10_11
backup_vc_10_11() {
  [[ include mount-backup-vc ]]
  [[ include rsync-small-backup ]]
  [[ include unmount-backup-vc ]]
}
```

### USB Backups
The following alias is used when backing up my USB drive.
``` block backup_usb
alias backup_usb="rsync -gloptruzvP --delete --exclude={"/Varis/copia-gris.hc","/Varis/copia-gris-git.hc"} /media/$USER/Oscar/ {{ .chezmoi.homedir }}/USB/"
```

### Writing the backups
Finally, we include the aliases to the file.
``` file dot_bash_aliases.tmpl
{{- if .backup }}
[[ include backup_all ]]
[[ include backup_vc_10_11 ]]
[[ include backup_usb ]]
{{- end }}
```

## Website
If website is enabled in the `chezmoi` configuration, we create aliases to the scripts to open the website working environment the to deploy the website.
``` file dot_bash_aliases.tmpl
{{- if .website }}
alias website="~/.scripts/tmux-website.sh"
alias deploy_website="~/.scripts/deploy-website.sh"
{{- end }}
```

## License
This file is licensed under the CC0 1.0 Universal license and therefore is part of the public domain. To the extent possible under law, Oscar Benedito, who associated CC0 with this work, has waived all copyright and related or neighboring rights to this work. You can find a copy of the CC0 license [here](https://gitlab.com/oscarbenedito/dotfiles/blob/master/CC0-1.0).
