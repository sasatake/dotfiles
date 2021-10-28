zfiles=(
    ".zbase"
    ".zplug"
    ".zenv"
    ".zcomp"
    ".zhistory"
    ".zfunctions"
    ".zalias"
    ".zhook"
)

for zfile in $zfiles
do
    [ -f $ZDOTDIR/$zfile ] && source $ZDOTDIR/$zfile
done