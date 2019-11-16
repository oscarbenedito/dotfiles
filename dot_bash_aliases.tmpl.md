# File `.bash_aliases`

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
``` file dot_bash_aliases.tmpl
{{- if .backup }}
alias backup="rsync -gloptruzvP --delete --exclude={
  {{- range $i, $dir := .backup.backup_exclude }}
    {{- if $i -}}
      ,
    {{- end -}}
    "{{ $dir }}"
  {{- end -}}
} {{ .chezmoi.homedir }}/ /media/oscar/OSCAR/.{{ .backup.backup_dir }}/"
```

And secondly the smaller backup, with extra excluded directories. I back it up on a USB drive so I encrypted with VeraCrypt (as I carry my USB around, I wouldn't want my personal data to be in plain text in case I lost it). This alias assumes that you have mounted the VeraCrypt device on the 10th slot.
``` file dot_bash_aliases.tmpl
alias backup_vc_10="rsync -gloptruzvP --delete --exclude={
  {{- range $i, $dir := .backup.backup_exclude }}
    {{- if $i -}}
      ,
    {{- end -}}
    "{{ $dir }}"
  {{- end -}}
  {{ range $dir := .backup.small_backup_exclude -}}
    ,"{{ $dir }}"
  {{- end -}}
} {{ .chezmoi.homedir }}/ /media/veracrypt10/{{ .backup.backup_dir }}/"
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
