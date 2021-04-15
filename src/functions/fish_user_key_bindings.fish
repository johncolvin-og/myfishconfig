function fish_user_key_bindings
    # ctrl+key
    bind -M insert \cn down-or-search
    bind -M insert \cp up-or-search
    bind -M insert \cj down-or-search
    bind -M insert \ck up-or-search
    bind -M insert \ch backward-char
    bind -M insert \cl forward-char
    # ctrl+alt h
    bind -M insert \e\b backward-word
    # ctrl+alt l
    bind -M insert \e\f forward-word
end

# builtin bindings: left
# bind --preset -M insert \e\[C backward-char
# bind --preset \e\[C backward-char
# bind --preset -M visual \e\[C backward-char

# builtin bindings: ctrl+left
# bind --preset -M insert \e\e\[C prevd-or-backward-word
# bind --preset \e\e\[C prevd-or-backward-word
# bind --preset -M visual \e\e\[C prevd-or-forward-word

# builtin bindings: right
# bind --preset -M insert \e\[C forward-char
# bind --preset \e\[C forward-char
# bind --preset -M visual \e\[C forward-char

# builtin bindings: ctrl+right
# bind --preset -M insert \e\e\[C nextd-or-forward-word
# bind --preset \e\e\[C nextd-or-forward-word
# bind --preset -M visual \e\e\[C nextd-or-forward-word

