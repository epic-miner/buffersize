#!/bin/bash

# Set the desired buffer sizes
RMEM_MAX=8388608
RMEM_DEFAULT=8388608

# Backup the current sysctl.conf file
cp /etc/sysctl.conf /etc/sysctl.conf.bak

# Add or update the buffer size settings in sysctl.conf
grep -q "net.core.rmem_max" /etc/sysctl.conf && \
    sed -i "s/^net.core.rmem_max.*/net.core.rmem_max = $RMEM_MAX/" /etc/sysctl.conf || \
    echo "net.core.rmem_max = $RMEM_MAX" >> /etc/sysctl.conf

grep -q "net.core.rmem_default" /etc/sysctl.conf && \
    sed -i "s/^net.core.rmem_default.*/net.core.rmem_default = $RMEM_DEFAULT/" /etc/sysctl.conf || \
    echo "net.core.rmem_default = $RMEM_DEFAULT" >> /etc/sysctl.conf

# Apply the changes
sysctl -p

# Verify the changes
echo "Current receive buffer sizes:"
sysctl net.core.rmem_max
sysctl net.core.rmem_default
