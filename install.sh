echo "Installing dependencies..."
sudo apt update
sudo apt install -y msr-tools cpufrequtils

echo "Copying script to /usr/local/bin..."
sudo cp bdprochot.sh /usr/local/bin/bdprochot.sh
sudo chmod +x /usr/local/bin/bdprochot.sh

echo "Configuring the systemd service..."

cat <<EOF | sudo tee /etc/systemd/system/bdprochot.service > /dev/null
[Unit]
Description=Disable BD-PROCHOT on Intel CPU
After=network.target

[Service]
ExecStart=/usr/local/bin/bdprochot.sh
Type=oneshot
User=root
Group=root
Restart=no
StandardOutput=journal
StandardError=journal
SyslogIdentifier=bdprochot

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable bdprochot.service
sudo systemctl start bdprochot.service

echo "Installation completed successfully!"