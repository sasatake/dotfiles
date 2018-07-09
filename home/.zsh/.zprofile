for localsetting in `ls -A ${ZDOTDIR}/local/ | grep -v "sample$"`
do
    source ${ZDOTDIR}/local/${localsetting}
done