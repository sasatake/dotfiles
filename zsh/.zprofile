for secretFile in `ls ${ZDOTDIR}secret/.z*`
do
    source ${ZDOTDIR}secret/${secretFile}
done