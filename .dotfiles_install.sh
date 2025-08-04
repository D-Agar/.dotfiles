DOTFILES_REPO="https://github.com/D-Agar/.dotfiles.git"
DOTFILES_DIR="$HOME/.dotfiles"
BACKUP_DIR="$DOTFILES_DIR-backup"

git clone --bare "$DOTFILES_REPO" "$DOTFILES_DIR"
function dotfiles {
   /usr/bin/git --git-dir="$DOTFILES_DIR" --work-tree="$HOME" "$@"
}
mkdir -p "$HOME/.dotfiles-backup"
dotfiles checkout
if [ $? = 0 ]; then
  echo "Checked out dotfiles.";
else
    echo "Backing up pre-existing dot files.";
    dotfiles checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | while read -r file; do
        mkdir -p "$BACKUP_DIR$(dirname "$file")"
        mv "$HOME/$file" "$BACKUP_DIR$file"
    done
fi
dotfiles checkout
dotfiles config status.showUntrackedFiles no
