@echo off
set /p folder=�������ļ����ڵ��ļ���·�����磺D:\mp4��
echo %folder%
md "%folder%\ts"
md "%folder%\success"
md "D:\output"
echo 3s�󽫽�����һ����ͼƬˮӡ
@ping -n 3 127.1 >nul 2>nul
::ע��logo��·��
for %%a in ("%folder%\*.mp4") do ffmpeg -i "%%a" -vf "drawbox=x=0:y=1030:w=in_w:h=50:color=black@0.7:t=fill[box];movie=logo.png[wm];[box][wm]overlay=W-w:10[out]" D:\output\%%~na.mp4
echo ��ͼƬˮӡִ�гɹ���5s�󽫽�����һ��������Ļ
@ping -n 5 127.1 >nul 2>nul
for %%a in ("D:\output\*.mp4") do ffmpeg -i "%%a" -vf "drawtext=text='��Ц���Ӹ�Ц���ϵ�һ�� BGM��������Ļ����':expansion=normal:fontfile=OPPOSans-M.ttf: y=h-line_h-10:x=W-(mod(5*n\,w+tw)): fontcolor=white: fontsize=40: shadowx=2: shadowy=2" "%folder%\success\%%~na.mp4"
echo ������Ļִ�гɹ���5s�󽫽�����һ���ϳ�Ƭβ
@ping -n 5 127.1 >nul 2>nul
for %%a in ("%folder%\success\*.mp4") do ffmpeg -i %%a -vcodec copy -acodec copy -vbsf h264_mp4toannexb %folder%\ts\%%~na.ts
del /f /q %%a in "D:\output\*.mp4"
for %%a in ("%folder%\ts\*.ts") do ffmpeg -i "concat:%%a|C:\Users\Meng\Desktop\pv\�½��ļ���\end.ts" -acodec copy -vcodec copy -absf aac_adtstoasc D:\output\%%~na.mp4
echo �ȴ��ϳɽ��� 5s��ɾ�����ɻ����ļ�
del /f /q %%a in "%folder%\success\*.mp4"
del /f /q %%a in "%folder%\*.mp4"
del /f /q %%a in "%folder%\ts\*.ts"
del /f /q %%a in "%folder%\success\*.txt"
rd /s /q %folder%\ts
rd /s /q %folder%\success
echo ȫ��ִ����� 
pause