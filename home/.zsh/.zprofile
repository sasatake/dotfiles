for localsetting in `ls ${ZDOTDIR}/local/ | grep -v "sample$"`
do
    source ${ZDOTDIR}/local/${localsetting}
done