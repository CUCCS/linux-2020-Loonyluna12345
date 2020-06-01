#!/usr/bin/env bash



function usage()
{
	cat << OUTPUT

    
	Notice：before using this tool, please install ImageMagick first.

	usage:$0 [-f directory][-j][-jp percent][-c percent][-pre pre_rename][-pro pro_rename][-w text][-h]

	optional arguments:


   -f <directory>     The filename or directory

   -jp <percent>                支持对jpeg格式图片进行图片质量压缩

   -cr <percent>                支持对jpeg/png/svg格式图片在保持原始宽高比的前提下压缩分辨率

   -j                          支持将png/svg图片统一转换为jpg格式图片

   -w <text>                   支持对图片批量添加自定义文本水印
    
   -pre <pre_rename>             支持批量重命名（统一添加文件名前缀)

   -pro <pro_rename>             支持批量重命名（统一添加文件名后缀）

   -h,--help                            
OUTPUT
}

function pre_rename
{
    for file in `ls $1`;do
            name=${file%.*}
            mv ${1}${file} ${1}${2}${name}.${file##*.}
    done
    echo "Pre Name changed!"
}

function pro_rename
{
    for var in `ls $1`;do
	   # mv "$var" "${var%.jpg}_efg.jpg"
            name=${file%.*}
            mv ${1}${file} ${1}${name}${2}.${file##*.}
    done  
    echo "Pro Name changed!"
}

function change_into_jpeg
{
    filelist=`ls $1`
	for fileName in $filelist;do
    case $(file $1/$fileName) in
        *svg*)
		FILE=$fileName
                $(convert $1/$fileName $1/change_into_jpg${FILE##*/}.jpg)
                ;;
		*png*)
		FILE=$fileName
                $(convert $1/$fileName $1/change_into_jpg${FILE##*/}.jpg)

                ;;				
	esac
	done

	echo "Done!"
}

function change_resolution
{
	filelist=`ls $2`
	for fileName in $filelist;do
    case $(file $2/$fileName) in
        *jpeg*)
                $(convert $2/$fileName -resize $1%x$1% "$2/change_resolution"$fileName)
                ;;
        *svg*)
                $(convert $2/$fileName -resize $1%x$1% "$2/change_resolution"$fileName)
                ;;
	*png*)
                $(convert $2/$fileName -resize $1%x$1% "$2/change_resolution"$fileName)
                ;;				
	esac
	done

	echo "Done!"
}

function add_watermark
{ 
	filelist=`ls $2`

	for fileName in $filelist

	do 

    case $(file $2/$fileName) in

        *jpg*)
                $(convert -size 140x80 xc:none -fill grey \
			-gravity NorthWest -draw "text 10,10 $1" \
			-gravity SouthEast -draw "text 5,15 $1" \
			miff:- |\
			composite -tile - $2/$fileName  $2/watermark_$fileName)
                ;;

        *svg*)
                $(convert -size 140x80 xc:none -fill grey \
			-gravity NorthWest -draw "text 10,10 $1" \

			-gravity SouthEast -draw "text 5,15 $1" \
			miff:- |\
			composite -tile - $2/$fileName  $2/watermark_$fileName)
                ;;

		*png*)
                $(convert -size 140x80 xc:none -fill grey \
			-gravity NorthWest -draw "text 10,10 $1" \
			-gravity SouthEast -draw "text 5,15 $1" \
			miff:- |\
			composite -tile - $2/$fileName  $2/watermark_$fileName)

                ;;	
		*bmp*)
                $(convert -size 140x80 xc:none -fill grey \
			-gravity NorthWest -draw "text 10,10 $1" \
			-gravity SouthEast -draw "text 5,15 $1" \
			miff:- |\
			composite -tile - $2/$fileName  $2/watermark_$fileName)

                ;;	

	esac
	done

	echo "Done!"
}
function compress_quality
{
	filelist=`ls $2`

	for fileName in $filelist;do
    case $(file $2/$fileName) in
        *jpg*)
                $(convert $2/$fileName -quality $1 "$2/compress_quality_"$fileName)

                ;;

        *JPG*)
                $(convert $2/$fileName -quality $1 "$2/compress_quality_"$fileName)

                ;;
	esac
	done
    echo "Done!"
}

if [[ "$0" && "$1" == "" ]];then
	usage
fi


while getopts 'f:j:jp:c:pre:pro:w' OPT; do
	case $OPT in
		h)
			usage;;
		f)
			filepath="$OPTARG";;
		pro)
			ifpro_rename=1
			newName=$OPTARG;;
		pre)
			ifpre_rename=1
			newName=$OPTARG;;
		j)
			ifchange_into_jpeg=1;;
		w)
			ifadd_watermark=1
			watermark=$OPTARG;;
		jp)
			ifcompression=1
			quality=$OPTARG;;
		cr)
			ifchange_resolution=1
			compressRatio=$OPTARG;;
	esac
done





if [[ $ifcompression && $quality && $filepath ]];then
	compress_quality $quality $filepath
fi


if [[ $ifchange_resolution &&  $compressRatio && $filepath ]];then
	change_resolution $compressRatio $filepath
fi


if [[ $ifadd_watermark && $filepath && $watermark ]];then
	add_watermark $watermark $filepath 
fi


if [[ $ifpre_rename && $filepath && $newName ]];then
	pre_rename $filepath $newName
fi

	
if [[ $ifpro_rename && $filepath && $newName ]];then
	pro_rename $filepath $newName
fi


if [[ $ifchange_into_jpeg && $filepath ]];then
	change_into_jpeg $filepath
fi
