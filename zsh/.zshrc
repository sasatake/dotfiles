zfiles=(
    ".zbase"
    ".zproxy"
    ".zplug"
    ".zenv"
    ".zcomp"
    ".zhistory"
    ".zfunctions"
    ".zalias"
)

for zfile in $zfiles
do
    [ -f $ZDOTDIR$zfile ] && source $ZDOTDIR$zfile
done