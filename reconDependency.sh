#!/bin/bash

# Ensure Go is installed
if ! command -v go &> /dev/null; then
    echo "Go is not installed. Please install Go to proceed."
    exit 1
fi

# Ensure unzip and 7z are installed
if ! command -v unzip &> /dev/null; then
    echo "Unzip is not installed. Installing it now..."
    sudo apt update && sudo apt install -y unzip
fi

if ! command -v 7z &> /dev/null; then
    echo "7z is not installed. Installing it now..."
    sudo apt update && sudo apt install -y p7zip-full
fi

# Install Go tools
go install github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
go install github.com/tomnomnom/anew@latest
go install github.com/tomnomnom/hacks/unisub@latest
go install github.com/projectdiscovery/httpx/cmd/httpx@latest
go install github.com/projectdiscovery/dnsx/cmd/dnsx@latest
go install github.com/projectdiscovery/chaos-client/cmd/chaos@latest
go install github.com/projectdiscovery/shuffledns/cmd/shuffledns@latest
go install github.com/tomnomnom/waybackurls@latest
go install github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest
go install github.com/OJ/gobuster/v3@latest
go install github.com/ffuf/ffuf/v2@latest

# Ensure Go binaries are in PATH
export PATH=$PATH:$(go env GOPATH)/bin

# Manual installation for other tools
mkdir -p ~/tools && cd ~/tools

# Install findomain
wget https://github.com/findomain/findomain/releases/latest/download/findomain-linux.zip -O findomain-linux.zip
unzip findomain-linux.zip
chmod +x findomain
sudo mv findomain /usr/local/bin/
rm findomain-linux.zip

# Install amass
wget https://github.com/OWASP/Amass/releases/latest/download/amass_linux_amd64.zip -O amass_linux_amd64.zip
unzip amass_linux_amd64.zip
chmod +x amass_linux_amd64/amass
sudo mv amass_linux_amd64/amass /usr/local/bin/
rm -r amass_linux_amd64 amass_linux_amd64.zip

# Install massdns
git clone https://github.com/blechschmidt/massdns.git
cd massdns
make
sudo cp bin/massdns /usr/local/bin/
cd ..
rm -rf massdns

# Install dirsearch (Python-based)
git clone https://github.com/maurosoria/dirsearch.git
sudo ln -s $(pwd)/dirsearch/dirsearch.py /usr/local/bin/dirsearch

# Cleanup
cd ~
rm -rf ~/tools

echo "All tools installed successfully!"

