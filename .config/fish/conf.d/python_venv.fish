set -g _python_venv_dir ""
function _python_venv_active
    if not string match "$_python_venv_dir*" $PWD >/dev/null
        deactivate
        set _python_venv_dir ""
    end
end

function _python_venv_not_active
    set -f path $PWD
    while test "$path" != "/"
        if test -d "$path/.python"
            set _python_venv_dir $path
            source "$_python_venv_dir/.python/bin/activate.fish"
            return
        end
        set path (path dirname $path)
    end
end

function _python_venv_main -v PWD
    if test -n $_python_venv_dir
        _python_venv_active
    else
        _python_venv_not_active
    end
end

_python_venv_main
