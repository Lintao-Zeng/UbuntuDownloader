运行commands工作流时可以使用ssh -D 0.0.0.0:1080 runner@8.tcp.us-cal-1.ngrok.io -p 19539命令创建临时的Socks5隧道，由于使用了ngrok网速不是很快，只能浏览网页。

要想网速快下载文件的话可以使用命令安装Tailscale，再使用ssh命令通过Tailscale的ip创建Socks5隧道
