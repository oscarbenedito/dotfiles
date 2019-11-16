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
