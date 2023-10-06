
DOTFILES_REPO=git@github.com:haak/dotfiles.git


# initial setup
# make dotfiles repo on github
chezmoi init
chezmoi add ~/.bashrc
chezmoi edit ~/.bashrc
chezmoi diff
chezmoi -v apply
chezmoi cd
git add .
git commit -m "Initial commit"

git remote add origin $DOTFILES_REPO
git branch -M main
git push -u origin main




# add new machine
# ensure you have ssh keys installed
chezmoi init $DOTFILES_REPO

chezmoi diff
chezmoi apply -v


# pull latest changes
chezmoi update -v