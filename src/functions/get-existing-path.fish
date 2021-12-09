function get-existing-path -d "Echos a path if it exists, otherwise returns 1"
    argparse f/file d/directory s/symbolic-link -- $argv
    if test (count $argv) -eq 0
        echo 'ERROR (get_existing_file): No file specified' 1>&2
        return 1
    end

    set test_path_args -e
    if set -q _flag_file; and test $status -eq 0
        set test_path_args -f
    else if set -q _flag_directory; and test $status -eq 0
        set test_path_args -d
    else if set -q _flag_symbolic_link; and test $status -eq 0
        set test_path_args -L
    end

    if test $test_path_args $argv[1]
        echo $argv[1]
    else
        return 1
    end
end
