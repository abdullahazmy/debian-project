#!/bin/bash

sudo apt install snapd
sudo snap install core

browserInstallation()
{
    echo "Please select the web browser you want to install (or 'None' to skip): "

browser_option=("None" "Chrome" "Brave" "Floorp" "Thorium")

select web in "${browser_option[@]}"; do
  case $web in
    "Chrome")
      web_install="chrome"
      break
      ;;
    "Brave")
      web_install="brave"
      break
      ;;
    "Floorp")
      web_install="floorp"
      # Install Floorp-browser
      nala install apt-transport-https curl -y
      curl -fsSL https://ppa.ablaze.one/KEY.gpg | gpg --dearmor -o /usr/share/keyrings/Floorp.gpg
      curl -sS --compressed -o /etc/apt/sources.list.d/Floorp.list 'https://ppa.ablaze.one/Floorp.list'
      nala update
      nala install floorp -y
      break
      ;;
    "Thorium")
      web_install="thorium"
      # Install Thorium-browser
      builddir="/tmp/thorium_build"  # Change this if you prefer a different temporary directory
      mkdir -p "$builddir"  # Create the temporary directory if it doesn't exist
      cd "$builddir"
      nala install apt-transport-https curl -y
      wget -O ./deb-packages/thorium-browser.deb "$(curl -s https://api.github.com/repos/Alex313031/Thorium/releases/latest | grep browser_download_url | grep amd64.deb | cut -d '"' -f 4)"
      nala install ./deb-packages/thorium-browser.deb -y
      cd -  # Exit the temporary directory
      rm -rf "$builddir"  # Optionally remove the temporary directory after installation (comment out if you want to keep it)
      break
      ;;
    "None")
      echo "Skipping web browser installation."
      exit 0
      ;;
    *)
      echo "Invalid selection."
      ;;
  esac
done

# Now you have $web_install set to the chosen browser (or empty if "None")

# Placeholder comments for Chrome and Brave installation (replace with actual commands)
if [ "$web_install" = "chrome" ]; then
  echo "** Installing Google Chrome...**"
  sudo apt install wget -y
  wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
  sudo apt install ./google-chrome-stable_current_amd64.deb -y
  rm google-chrome-stable_current_amd64.deb
elif [ "$web_install" = "brave" ]; then
    echo "** Installing Brave... **"
    sudo snap install brave
    echo "Brave browser installed successfully."
fi
}

