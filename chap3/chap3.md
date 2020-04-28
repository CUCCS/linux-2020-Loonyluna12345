## 实验要求

- 根据[命令篇by阮一峰的网络日志](www.ruanyifeng.com/blog/2016/03/systemd-tutorial-commands.html
)和[实战篇by阮一峰的网络日志](http://www.ruanyifeng.com/blog/2016/03/systemd-tutorial-part-two.html)
完成systemd操作，并用asciinema全程录像并上传。

- 完成第三章自查清单。


## 实验环境
- Windows 10
- VirtualBox 6.1
- Ubuntu 18.04.4
- asciinema
- systemd 237


## 参考资料
- [黄老师课件](https://c4pr1c3.github.io/LinuxSysAdmin/)
- [命令篇by阮一峰的网络日志](www.ruanyifeng.com/blog/2016/03/systemd-tutorial-commands.html)
- [实战篇by阮一峰的网络日志](http://www.ruanyifeng.com/blog/2016/03/systemd-tutorial-part-two.html)



## 实验过程

#### win10上的PuTTY连接到虚拟机上的Ubuntu；

#### 升级systemd
```sudo apt install systemd```

#### 开始录像；
```asciinema rec```

#### 开始根据材料学习
录像：
- [命令篇第一部分](https://asciinema.org/a/rtMpun08ZjlMesEOGgXLkZtVm)
- [命令篇第二部分](https://asciinema.org/a/HrLKskRRLUpfMfFGI7eSniLIe)
- [实战篇第一部分](https://asciinema.org/a/8JVLVTDUIbZP0RdDkIC9MbjoI)
- [实战篇第二部分](https://asciinema.org/a/H3MxijQsMNHDPM6njolszNqHZ)



## 自查清单

- 如何添加一个用户并使其具备sudo执行程序的权限?  
```adduser janie```  
```passwd janie```     
```sudo su```  
```chown root:root /usr/bin/sudo```  
```chmod u+w /etc/sudoers```  
``` vim /etc/sudoers```  
```找到"root ALL=(ALL) ALL"这行```  
```在下面添加：janie ALL=(ALL) ALL```  


- 如何将一个用户添加到一个用户组？  
``` usermod -a -G somegroup someuser```

- 如何查看当前系统的分区表和文件系统详细信息？
```
fdisk -l
df -h
```

- 如何实现开机自动挂载Virtualbox的共享目录分区？
```
sudo su
找到文件/etc/fstab
追加sharing /mnt/share vboxsf defaults 0 0
重启
```

- 基于LVM（逻辑分卷管理）的分区如何实现动态扩容和缩减容量？
```
fdis -1
pvcreate /dev/sdb1 
pvcreate /dev/sdc1 
vgcreate somename1 /dev/sdb1
vgdisplay
lvcreate -l 2000 -n somename2 somename1
mkfs -t ext3 /dev/somename2 /somename1
mount /dev/vg_test/lv_test /opt/oracle/
df -h
lvextend -l +2558 /dev/somename1/somename2

vgextend somename1/dev/sdc1  
```
```
lvs
resize2fs /dev/vgqjc/lvqjc 5G
lvreduce -L 5G /dev/vgqjc/lvqjc 
```

- 如何通过systemd设置实现在网络连通时运行一个指定脚本，在网络断开时运行另一个脚本？
```
增加ExecStop字段：停止网络服务时执行的命令
e.g. ExecStop=/usr/sbin/xxx
增加ExecStartPost字段（启动网络服务之后执行的命令）
e.g.ExecStartPost=/usr/bin/xxxx
```
- 如何通过systemd设置实现一个脚本在任何情况下被杀死之后会立即重新启动？实现杀不死？  
增加停止服务之后执行原来的服务的命令 
```
增加停止服务之后执行原来的服务的命令 
e.g. ExecStopPost=/usr/bin/xxx
```






