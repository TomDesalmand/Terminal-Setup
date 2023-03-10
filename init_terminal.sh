#!/bin/bash

#Check if user launched script as sudo
if [ "$(id -u)" != "0" ]; then
  echo -e "\033[1;30;41mPlease run this script as root.\033[0m"
  exit 1
fi

#Update packages
echo -e "\033[1;30;43mUpdating...\033[0m"
if [ -x /usr/bin/apt ]; then
  apt-get update -y
  apt-get upgrade -y
elif [ -x /usr/bin/dnf ]; then
  dnf update -y
  dnf upgrade -y
fi

#Install build-essential packages
echo -e "\033[1;30;43mInstalling build-essential...\033[0m"
if [ -x /usr/bin/apt ]; then
  apt-get install -y build-essential
elif [ -x /usr/bin/dnf ]; then
  dnf install -y make automake gcc gcc-c++ kernel-devel
fi
echo -e "\033[1;30;42mBuild-essential has been successfully installed.\033[0m"

#Install curl packages
echo -e "\033[1;30;43mInstalling curl...\033[0m"
if [ -x /usr/bin/apt ]; then
  apt-get install -y curl
elif [ -x /usr/bin/dnf ]; then
  dnf install -y curl
fi
echo -e "\033[1;30;42mCurl has been successfully installed.\033[0m"

echo -e "\n"
echo "Do you want to install Oh My ZSH or Koala ZSH shell?"
echo "Enter '1' for Oh My ZSH"
echo "Enter '2' for Koala ZSH shell"
read -p "-> " choice
echo -e "\n"

if [ $choice -eq 1 ]; then
  curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh | bash
  chsh -s $(which zsh)
elif [ $choice -eq 2 ]; then
  #Install ZSH packages
  echo -e "\033[1;30;43mInstalling ZSH...\033[0m"
  if [ -x /usr/bin/apt ]; then
    apt install -y git zsh zsh-autosuggestions
  elif [ -x /usr/bin/dnf ]; then
    dnf install -y git zsh zsh-autosuggestions
  fi
  echo -e "\033[1;30;42mZSH has been successfully installed.\033[0m"

  #Set ZSH as default shell
  chsh -s $(which zsh)
  rm ~/.zshrc
  mv ~/.zshrc ~/

  #Install starship packages
  echo -e "\033[1;30;43mInstalling starship...\033[0m"
  curl -fsSL https://starship.rs/install.sh | bash
  echo -e "\033[1;30;42mStarship has been successfully installed.\033[0m"
else
  echo "Invalid choice. Please enter '1' or '2'."
  exit 1
fi
