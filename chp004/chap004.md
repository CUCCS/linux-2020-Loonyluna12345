## 实验环境
- Windows 10
- VirtualBox 6.1
- Ubuntu 18.04.4
- bash 4.4.20


## 实验任务一：用bash编写一个图片批处理脚本，实现以下功能： 
#### 1.支持命令行参数方式使用不同功能√
#### 2.支持对指定目录下所有支持格式的图片文件进行批处理√
#### 3.支持以下常见图片批处理功能的单独使用或组合使用  
√支持对jpeg格式图片进行图片质量压缩  
√支持对jpeg/png/svg格式图片在保持原始宽高比的前提下压缩分辨率  
√支持对图片批量添加自定义文本水印  
√支持批量重命名（统一添加文件名前缀或后缀，不影响原始文件扩展名）  
√支持将png/svg图片统一转换为jpg格式图片  


## 实验任务二：用bash编写一个文本批处理脚本，对以下附件分别进行批量处理完成相应的数据统计任务： 
#### 2014世界杯运动员数据 
√ 统计不同年龄区间范围（20岁以下、[20-30]、30岁以上）的球员数量、百分比  
√ 统计不同场上位置的球员数量、百分比  
√ 名字最长的球员是谁？名字最短的球员是谁？  
√ 年龄最大的球员是谁？年龄最小的球员是谁？  

##### 任务二思路：
1.先将worldcupplayerinfo.tsv用psftp.exe从Windows10复制到Ubuntu：
```
put worldcupplayerinfo.tsv
```
2.将每条信息按tab键分解，得到年龄和位置的列表  
3.循环遍历年龄列表，同时获取每条信息的名字；得到年龄区间统计信息、最大最小年龄、最长最短名字长度  
4.找到最大最小年龄和最长最短名字长度对应的名字  
5.将位置列表转换为位置关联数组，统计每个key(位置)对应多少人，计算百分比  
附：代码见worldcup_2.sh




## 实验任务三：用bash编写一个文本批处理脚本，对以下附件分别进行批量处理完成相应的数据统计任务： 
#### Web服务器访问日志 
√ 统计访问来源主机TOP 100和分别对应出现的总次数  
√ 统计访问来源主机TOP 100 IP和分别对应出现的总次数  
√ 统计最频繁被访问的URL TOP 100  
√ 统计不同响应状态码的出现次数和对应百分比  
√ 分别统计不同4XX状态码对应的TOP 10 URL和对应出现的总次数  
√ 给定URL输出TOP 100访问来源主机  
##### 任务三思路：
1.先将web_log.tsv用psftp.exe从Windows10复制到Ubuntu：
```
put web_log.tsv
```
2.每个子任务对应一个函数，通过条件判断调用不同的函数  
3.学习awk命令的使用  
附：代码见log_3.sh  



## 参考资料
[linux awk命令详解](https://www.cnblogs.com/xudong-bupt/p/3721210.html
)  
[shell数组操作](https://www.cnblogs.com/sco1234/p/8906527.html)  
[shell编程 帮助功能的实现](https://blog.csdn.net/hejinjing_tom_com/article/details/79946427)  
[shell脚本从文件中按行读取数据，并且赋值到数组中的几种方法](https://blog.csdn.net/zhengcaihua0/article/details/80740867?utm_medium=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-2&depth_1-utm_source=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-2)  
[作业17级](https://github.com/CUCCS/)   
[imagemagick官方文档](https://www.imagemagick.org/Usage/)   
[老师课件](https://c4pr1c3.github.io/LinuxSysAdmin/)  
[使用imagemagick批量加水印缩小图像的脚本](https://www.cnblogs.com/mfryf/p/3368951.html)  
[Linux Shell 批量重命名的方法总览](https://blog.csdn.net/kwame211/article/details/76019823)  

