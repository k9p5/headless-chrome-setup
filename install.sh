# Update, install correct drivers, and remove the old ones.
apt-get update
apt-get install -y vulkan-tools libnvidia-gl-550

# Verify NVIDIA drivers can see the T4 GPU and that vulkan is working correctly.
nvidia-smi
vulkaninfo

# Now install latest version of Node.js
npm install -g n
n lts
node --version
npm --version

# Next install Chrome stable
curl -fsSL https://dl.google.com/linux/linux_signing_key.pub | sudo gpg --dearmor -o /usr/share/keyrings/googlechrom-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/googlechrom-keyring.gpg] http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list
sudo apt update
sudo apt upgrade
sudo apt install -y google-chrome-stable

# Start dbus to avoid warnings by Chrome later.
export DBUS_SESSION_BUS_ADDRESS="unix:path=/var/run/dbus/system_bus_socket"
/etc/init.d/dbus start

# Enable RAM disk for efficient large file obj writes
sudo mkdir /mnt/ramdisk 
mount -o size=512M -t tmpfs none /mnt/ramdisk

npm install

node check_gpu.js
