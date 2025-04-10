inputSysNames=$1
envName=$2
orig=$3
dest=$4

# Split the sys names into array and process for each
IFS=',' read -r -a sysArray <<< $inputSysNames
for sys in "${sysArray[@]}"
do

searchString="bamboo_vpay_(${sys})_${envName}_"
# echo '----------------------------------------------------------------'
# echo $searchString
# echo '----------------------------------------------------------------'
VARS=($(compgen -v | grep -P "${searchString}"))
# echo '----------------------------------------------------------------'
# cat $orig
# echo '----------------------------------------------------------------'
for i in "${VARS[@]}"
do
    #Remove $environ from variable name
    var=`echo $i |  sed "s/bamboo_vpay_${sys}_${envName}_/${sys}/"`
    #Replace variables in files
	if [ `grep -c $var $orig` -gt 0 ]
	then
		echo "Replacing '$var' with '${!i}' in file '$file'"
		sed -i "s|{{$var}}|${!i}|" $orig
	fi 
done
done
mv $orig $dest

Argument: "FaxMan,DocSys" ${bamboo.vpay.DeployEnv} "./appsettings.template-secure.json" "./appsettings.secure.json"


give me equivalent bash script to run them in github action workflow.
