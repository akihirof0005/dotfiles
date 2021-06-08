
HASKELL_FLAG=$(cat ~/dotfiles/config.json | jq -r .languages.haskell.enable)
if [ HASKELL_FLAG ]; then
  stack upgrade
fi

