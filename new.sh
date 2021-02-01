#!/bin/bash
#C:/Users/Meng/Desktop/pv
#C:/Users/Meng/Desktop/pv/新建文件夹
read -p "请设置文件所在的文件夹路径，如：D:\mp4：" input
echo "你输入了 $input"
#mkdir "$input/ts"
#mkdir "$input/success"
#mkdir "$input/output"
echo "echo 3s后将进入下一步加图片水印"
sleep 3
echo "ok"
# 注意logo的路径
for a in "$input/"*.mp4
do
ffmpeg -i "$a" -vf "drawbox=x=0:y=1030:w=in_w:h=50:color=black@0.7:t=fill[box];movie=logo.png[wm];[box][wm]overlay=W-w:10[out]" "$input/output/$(basename $a)"
done
echo "加图片水印执行成功，5s后将进入下一步滚动字幕"
sleep 5
## 添加滚动字幕
#for b in "$input/output/"*.mp4
#do
#ffmpeg -i "$b" -vf "drawtext=text='爆笑虫子搞笑集合第一期 BGM：滚动字幕测试':expansion=normal:fontfile=OPPOSans-M.ttf: y=h-line_h-10:x=W-(mod(5*n\,w+tw)): fontcolor=white: fontsize=40: shadowx=2: shadowy=2" "$input/success/$(basename $b)"
#done
#echo "滚动字幕执行成功，5s后将进入下一步合成片尾"
#sleep 5
# 转为拼接格式
for c in "$input/output/"*.mp4
do
ffmpeg -i "$c" -vcodec copy -acodec copy -vbsf h264_mp4toannexb "$input/ts/"$(basename $c .mp4).ts
done
# 删除中间文件
for d in "$input/output/"*.mp4
do
rm -f "$d"
done
# 添加片尾
for f in "$input/ts/"*.ts
do
ffmpeg -i "concat:""$f""|C:/Users/Meng/Desktop/pv/新建文件夹/end.ts" -acodec copy -vcodec copy -absf aac_adtstoasc "$input/output/"$(basename $f .ts).mp4
done
