# Apply any modifications here.

# Enable kernel modules 

# iptables-recent (k8s)
sed -i 's/# CONFIG_NETFILTER_XT_MATCH_RECENT is not set/CONFIG_NETFILTER_XT_MATCH_RECENT=y/' Microsoft/config-wsl
# iscsi-tcp (longhorn)
sed -i 's/# CONFIG_ISCSI_TCP is not set/CONFIG_ISCSI_TCP=y/' Microsoft/config-wsl