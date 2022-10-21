function apt-upgrade-interactive
    sudo apt update && apt list --upgradable && prompt_confirm "Upgrade the above packages?" && sudo apt upgrade
end

