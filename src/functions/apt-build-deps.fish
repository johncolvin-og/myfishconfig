function apt-build-deps -d "Show uninstalled build dependencies for a package"
    apt-get -s build-dep $argv[1] | awk '{ if ($1 == "Inst") print $2; }'
end

