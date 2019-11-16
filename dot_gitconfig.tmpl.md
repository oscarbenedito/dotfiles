# File `.gitconfig`

Adding git user account.
```toml file dot_gitconfig.tmpl
[user]
  email = oscar@obenedito.org
  name = oscarbenedito
  [[ include pgpsigningkey]]
```
## PGP key
If specified in the `chezmoi` data, configure the signing key. Note that the following code is the block included with `pgpsigningkey`.
```toml block pgpsigningkey
{{- if .pgpkey }}
signingkey = 827E5A8E3AE8A499
{{- end }}
```

If a PGP is used, we'll add the following line to sign commits by default.
```toml file dot_gitconfig.tmpl
{{- if .pgpkey }}
[commit]
  gpgsign = true
{{- end }}
```

## License
This file is licensed under the CC0 1.0 Universal license and therefore is part of the public domain. To the extent possible under law, Oscar Benedito, who associated CC0 with this work, has waived all copyright and related or neighboring rights to this work. You can find a copy of the CC0 license [here](https://gitlab.com/oscarbenedito/dotfiles/blob/master/CC0-1.0).
