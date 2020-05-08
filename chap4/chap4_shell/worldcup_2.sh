#!/usr/bin/env bash


#read -r line < worldcupplayerinfo.tsv


total=0
age20=0
age20_30=0
age30=0

max_age=0
min_age=100

max_namelen=0
min_namelen=100

#分解信息
ages=$(awk -F '\t' '{print $6}' worldcupplayerinfo.tsv)

#names=$(awk -F '\t' '{print $9}' worldcupplayerinfo.tsv)

positions=$(awk -F '\t' '{print $5}' worldcupplayerinfo.tsv)


for age in ${ages};do
	if [[ $age != "Age" ]]; then
		total=$((total+1))
	       	name=$(awk -F '\t' 'NR=='$((total+1))' {print $9}' worldcupplayerinfo.tsv)
		name1=${name//[[:space:]]/}
		#echo "$name1"
		name_len=${#name1}

		if [[ $age -lt 20 ]]; then
			age20=$((age20+1))
		fi


		if [[ $age -ge 20 && $age -le 30 ]]; then
			age20_30=$((age20_30+1))
		fi


		if [[ $age -gt 30 ]]; then
			age30=$((age30+1))
		fi


		if [[ $age -gt $max_age ]]; then
			max_age=$age
			
		fi


		if [[ $age -lt $min_age ]]; then
			min_age=$age
		fi


		if [[ $name_len -gt $max_namelen ]];then
			max_namelen=$name_len
		fi


		if [[ $name_len -lt $min_namelen ]];then
			min_namelen=$name_len
		fi
	fi
done

echo "年龄在20岁以下的数量和百分比：$age20,$(echo "scale=2; $age20*100/$total" | bc)%"

echo "年龄在20岁到30岁之间的数量和百分比：$age20_30,$(echo "scale=2; $age20_30*100/$total" | bc)%"

echo "年龄在30岁以上的数量和百分比：$age30,$(echo "scale=2; $age30*100/$total" | bc)%"

echo "================================================"
echo "最大的年龄：$max_age"
echo "最小的年龄：$min_age"
echo "最长的名字长度：$max_namelen"
echo "最短的名字长度：$min_namelen"

#找出年龄最大最小的人的名字
#找出最长最短的名字
row=1
declare -a oldest_names
declare -a youngest_names

declare -a longest_names
declare -a shortest_names

i=0
j=0
u=0
v=0
for age in ${ages};do
	if [[ $age != "Age" ]];then
		name=$(awk -F '\t' 'NR=='$((row+1))' {print $9}' worldcupplayerinfo.tsv)
		name1=${name//[[:space:]]/}
		name_len=${#name1}

		if [[ $age == $max_age ]];then
			oldest_names[$i]="$name"
			i=$((i+1))
		fi


		if [[ $age == $min_age ]];then
			youngest_names[$j]="$name"
			j=$((j+1))
		fi


		if [[ $name_len == $max_namelen ]];then
			longest_names[$u]="$name"
			u=$((u+1))
		fi


		if [[ $name_len == $min_namelen ]];then
			shortest_names[$v]="$name"
			v=$((v+1))
		fi

		row=$((row+1))
	fi
done

echo "Oldest player:"
index=0
while [ $index -lt "$i" ];do
	echo "${oldest_names[${index}]}"
	index=$((index+1))
done
echo "----------------------------------------------"
echo "Youngest player:"
index=0
while [ $index -lt "$j" ];do
	echo "${youngest_names[${index}]}"
	index=$((index+1))
done

echo "============================================="

echo "longest name:"
index=0
while [ $index -lt "$u" ];do
	echo "${longest_names[${index}]}"
	index=$((index+1))
done
echo "----------------------------------------------"
echo "shortest name:"
index=0
while [ $index -lt "$v" ];do
	echo "${shortest_names[${index}]}"
	index=$((index+1))
done


#统计球员位置信息
#转换成关联数组
declare -A positions_array
for position in ${positions};do
	if [[ "$position" != "Position" ]];then
	
		if [[ "$position" != "" ]];then
			positions_array["$position"]=$((positions_array["$position"]+1))
		fi

	fi
done

#echo "$total"

for key in "${!positions_array[@]}";do
	echo "$key:${positions_array[$key]}	 $(echo "scale=2; ${positions_array[$key]}*100/$total" | bc)%"
done












