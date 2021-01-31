@echo off
set /p folder=请设置文件所在的文件夹路径，如：D:\mp4：
echo %folder%
md "%folder%\ts"
md "%folder%\success"
md "D:\output"
echo 3s后将进入下一步加图片水印
@ping -n 3 127.1 >nul 2>nul
::注意logo的路径
for %%a in ("%folder%\*.mp4") do ffmpeg -i "%%a" -vf "drawbox=x=0:y=1030:w=in_w:h=50:color=black@0.7:t=fill[box];movie=logo.png[wm];[box][wm]overlay=W-w:10[out]" D:\output\%%~na.mp4
echo 加图片水印执行成功，5s后将进入下一步滚动字幕
@ping -n 5 127.1 >nul 2>nul
for %%a in ("D:\output\*.mp4") do ffmpeg -i "%%a" -vf "drawtext=text='爆笑虫子搞笑集合第一期 BGM：滚动字幕测试':expansion=normal:fontfile=OPPOSans-M.ttf: y=h-line_h-10:x=W-(mod(5*n\,w+tw)): fontcolor=white: fontsize=40: shadowx=2: shadowy=2" "%folder%\success\%%~na.mp4"
echo 滚动字幕执行成功，5s后将进入下一步合成片尾
@ping -n 5 127.1 >nul 2>nul
for %%a in ("%folder%\success\*.mp4") do ffmpeg -i %%a -vcodec copy -acodec copy -vbsf h264_mp4toannexb %folder%\ts\%%~na.ts
del /f /q %%a in "D:\output\*.mp4"
for %%a in ("%folder%\ts\*.ts") do ffmpeg -i "concat:%%a|C:\Users\Meng\Desktop\pv\新建文件夹\end.ts" -acodec copy -vcodec copy -absf aac_adtstoasc D:\output\%%~na.mp4
echo 等待合成结束 5s后将删除换成缓存文件
del /f /q %%a in "%folder%\success\*.mp4"
del /f /q %%a in "%folder%\*.mp4"
del /f /q %%a in "%folder%\ts\*.ts"
del /f /q %%a in "%folder%\success\*.txt"
rd /s /q %folder%\ts
rd /s /q %folder%\success
echo 全部执行完毕 
pause