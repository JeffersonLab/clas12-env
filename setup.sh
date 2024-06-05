
# get the full path of the directory containing this file:
src=${BASH_ARGV[0]}
if [ "x$src" = "x" ]; then
    src=${(%):-%N} # for zsh
fi
if [ "x${src}" = "x" ]; then
    [ -f ./setup.sh ] && home="$PWD" || echo ERROR: could not determine installation path!
else
    x=$(dirname ${src}) && home=$(cd ${x} > /dev/null; pwd)
fi

if [ -z ${home+x} ] && [ -d $home/modulefiles ]; then
    echo 'ERROR:  could not find $CLAS12_HOME.'
else
    echo "WARNING:  This setup.csh script is deprecated and will be removed in the future:"
    echo "          $home/setup.sh"
    echo "WARNING:  This command is equivalent and should be used instead:"
    echo "          module use $home/modulefiles"
fi
