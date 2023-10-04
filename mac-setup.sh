# This is a mac setup bash file for installing all the necessary tools for a new mac

https://github.com/danielfoehrKn/kubeswitch
brew install danielfoehrkn/switch/switch
# INSTALLATION_PATH=$(brew --prefix switch) && source $INSTALLATION_PATH/switch.sh
# to your .bashrc or .zshrc file.
echo 'INSTALLATION_PATH=$(brew --prefix switch) && source $INSTALLATION_PATH/switch.sh' >> ~/.zshrc

# Install iTerm2
brew install --cask iterm2

# Install VSCode
brew install --cask visual-studio-code

# Install Chrome
brew install --cask google-chrome

# Install Firefox
brew install --cask firefox

# install mattermost
brew install --cask mattermost

# Install telegram

# spotify
# insomnia 
brew install --cask insomnia


brew install dua-cli



# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install Powerlevel10k



## Install NVM
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash


## install node lts
nvm install --lts

## Install Node
nvm install node



