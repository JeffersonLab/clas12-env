
# get an environment variable, with a default if it doesn't exist:
proc getenv {name default} {
    if { [ info exists ::env($name) ] } {
        return $::env($name)
    }
    return $default
}

# get the basename of the value of a path-like environment variable, which
# will commonly be a version number, with a default of "$name":
proc getvenv {name} {
    return [ file tail [getenv $name \$$name] ] 
}

# get the full, normlized path to the directory containing this tcl script:
proc home {} {
    set x [ dict get [info frame 0] file ]
    return [ file normalize [exec dirname $x]/../.. ]
}

# get the $OSRELEASE environment variable if it exists, else
# run our script to get what it will become upon loading modules:
# (Note, we don't use our getenv here for performance reasons.)
proc osrelease {} {
    if { [ info exists ::env(OSRELEASE) ] } {
        return $::env(OSRELEASE)
    }
    return [ exec [home]/modulefiles/util/osrelease.py ]
}

# print a colored error message:
proc err {msg} {
    puts stderr "\033\[1;31mERROR:\033\[0m $msg"
}

# print a colored warning message:
proc warn {msg} {
    puts stderr "\033\[1;33mWARNING:\033\[0m $msg"
}

# print a warning message if a path doesn't exist:
proc warndir {path msg} {
    if [file isdirectory $path] {
        return 1
    } elseif [module-info mode load] {
        warn $msg
    }
    return 0
}

# sort of a "prereq --optional" prior to version 5.2:
proc prereq_optional {name} {
    if [is-avail $name] {
        if [expr {[versioncmp $::ModuleToolVersion 5.2] < 0}] {
            prereq $name
        } else {
            prereq --optional $name
        }
    }
}

