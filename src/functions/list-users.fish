function list-users
    cat /etc/passwd | cut -d : -f 1 | sort
end
