#!/bin/sh

# Update base system
dnf update -y

# Add the Tailscale repository and install Tailscale:
dnf config-manager --add-repo https://pkgs.tailscale.com/stable/oracle/8/tailscale.repo
dnf install tailscale

# Install Caddy Web Server 
dnf install 'dnf-command(copr)'
dnf copr enable @caddy/caddy
dnf install caddy -y

# Use systemctl to enable and start the service:
systemctl enable --now tailscaled

# Connect your machine to your Tailscale network and authenticate in your browser:
tailscale up

# Allow masquerading in firewalld
firewall-cmd --permanent --add-masquerade

# Start the Caddy service and enable it to start at system reboot:
systemctl start caddy
systemctl enable caddy

# Check the status of the Caddy service 
systemctl status caddy
