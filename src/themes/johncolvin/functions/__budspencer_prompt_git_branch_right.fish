################
# => Git segment
################
function __budspencer_prompt_git_branch_right -d 'Return the current branch name'
    set -l branch (command git symbolic-ref HEAD 2> /dev/null | sed -e 's|^refs/heads/||')
    if not test $branch >/dev/null
        set -l position (command git describe --contains --all HEAD 2> /dev/null)
        if not test $position >/dev/null
            set -l commit (command git rev-parse HEAD 2> /dev/null | sed 's|\(^.......\).*|\1|')
            if test $commit
                set_color -b $budspencer_colors[11]
                switch $pwd_style
                    case short long git
                        echo -n ''
                        echo -n ''(set_color $budspencer_colors[1])' ➦ '$commit' '(set_color $budspencer_colors[11])
                    case none
                        echo -n ''
                end
                set_color normal
                set_color $budspencer_colors[11]
            end
        else
            set_color -b $budspencer_colors[9]
            switch $pwd_style
                case short long git
                    echo -n ''(set_color $budspencer_colors[1])'  '$position' '(set_color $budspencer_colors[9])
                case none
                    echo -n ''
            end
            set_color normal
            set_color $budspencer_colors[9]
        end
    else
        set_color -b $budspencer_colors[3]
        switch $pwd_style
            case short long git
                echo -n ''(set_color $budspencer_colors[1])'  '$branch' '(set_color $budspencer_colors[3])
            case none
                echo -n ''
        end
        set_color normal
        set_color $budspencer_colors[3]
    end
end
