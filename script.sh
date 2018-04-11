exec > data.json
echo "var oData = ["
var=0
for f in *; do
    if [ -d ${f} ]; then
	echo "{ \"value\" : \""$f"\","
		cd  "$f"
		echo "\"develop\" : \""
		git rev-list --left-right --count origin/master...origin/develop;
		echo "\", \"release\" : \""
		git rev-list --left-right --count origin/master...origin/release;
		echo "\", \"master\" : \""
		git rev-list --left-right --count origin/master...origin/master;
		echo "\"}"
    cd .. 
    fi
done
echo "]"
sed -i $'s/\t/ /g' data.json
perl -p -i -e 's/\R//g;' data.json
sed -i -e 's/\}{/ },{ /g;' data.json
start output.html