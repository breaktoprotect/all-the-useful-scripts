# Useful Docker Compose Aliases

Check that the following is already in `~/.bashrc`:
```bash
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
```

Create a `~/.bash_aliases` in `~/`:
```bash
alias dcup='docker-compose up -d'
alias dcupb='docker-compose up -d --build'
alias dcdown='docker-compose down'
alias dcdownv='docker-compose down -v'
alias dcbuild='docker-compose build'
alias dcreset='dcdownv && dcupb'
alias k='kubectl'
```
