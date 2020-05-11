#!/usr/bin/env bash
#!/bin/bash

function usage

{

    cat<<OUTPUT

    usage $0: WebProcessing.sh [-h][-ip][-r][-url][-uh][-help]

    optional arguments:

    -h             统计访问来源主机TOP 100和分别对应出现的总次数

    -ip             统计访问来源主机TOP 100 IP和分别对应出现的总次数

    -r             统计不同响应状态码的出现次数和对应百分比

    -url              统计最频繁被访问的URL TOP 100

    -uh <url>       给定URL输出TOP 100访问来源主机

    -ru             分别统计不同4XX状态码对应的TOP 10 URL和对应出现的总次数

    -help,  --help"

OUTPUT
}

function host_top_100()
{
	#删第一行
	#分割，按行处理
	#结尾代码块
	(sed -e '1d' web_log.tsv|awk -F '\t' '{a[$1]++} END {for(i in a) {print i,a[i]}}'|sort -nr -k2|head -n 100)

}

function ip_top_100()
{
	(sed -e '1d' web_log.tsv|awk -F '\t' '{if($1~/^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$/) print $1}'|awk '{a[$1]++} END {for(i in a){print i,a[i]}}'|sort -nr -k2|head -n 100)
}

function url_top_100()
{
	(sed -e '1d' web_log.tsv|awk -F '\t' '{a[$6]++} END {for(i in a) {printf("%d 数量为：%d\n",i,a[i])}}' |sort -nr -k2|head -n 100)

}

function response()
{
	(sed -e '1d' web_log.tsv|awk -F '\t' '{a[$6]++;total++} END {for(i in a){printf("%d: %-10d percentage: %.5f%\n",i,a[i],a[i]*100/total)}}')
}

function url_host()
{
	 (sed -e '1d' web_log.tsv|awk -F '\t' '{if($5=="'$1'") a[$1]++} END {for(i in a){print i,a[i]}}'|sort -nr -k2|head -n 100)

}
function 4xxurl
{

    a=$(sed -e '1d' 'web_log.tsv'|awk -F '\t' '{if($6~/^4+/) a[$6]++} END {for(i in a) print i}')

    for i in $a;do
        (sed -e '1d' web_log.tsv|awk -F '\t' '{if($6~/^'$i'/) a[$6][$5]++} END {for(i in a){for(j in a[i]){print i,j,a[i][j]}}}'|sort -nr -k3|head -n 10)

    done

}
if [[ "$0" && "$1" == "" ]];then

	usage
	
fi

if [[ "$1" != "" ]];then

    case "$1" in

    -h )

        host_top_100

        ;;
    -ip )
	ip_top_100

	;;
    -url )
        url_top_100
	
	;;
    -r )
	response

	;;
    -uh )
	url_host

	;;
    -ru )
	4xxurl

	;;

    esac
	
fi
