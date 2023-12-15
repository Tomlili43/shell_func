# tutorial https://cloud.tencent.com/developer/article/2171401
# key point  docker newwork 1.master host mode 2. slave use bridge mode
# master and slave all use bridge mode then master and slave can not connect each other mysql

# create folder for mysql
mkdir -p /home/TomDu/mydata/mysql-master/conf
mkdir -p /home/TomDu/mydata/mysql-master/data
mkdir -p /home/TomDu/mydata/mysql-master/log
mkdir -p /home/TomDu/mydata/mysql-master/mysql-files

mkdir -p /home/TomDu/mydata/mysql-slave/conf
mkdir -p /home/TomDu/mydata/mysql-slave/data
mkdir -p /home/TomDu/mydata/mysql-slave/log
mkdir -p /home/TomDu/mydata/mysql-slave/mysql-files

# master config
# -----------------------------------------------------------
[mysqld]

## 设置server_id，同一局域网中需要唯一

server_id=101 

## 指定不需要同步的数据库名称

binlog-ignore-db=mysql  

## 开启二进制日志功能

log-bin=mall-mysql-bin  

## 设置二进制日志使用内存大小（事务）

binlog_cache_size=1M  

## 设置使用的二进制日志格式（mixed,statement,row）

binlog_format=mixed  

## 二进制日志过期清理时间。默认值为0，表示不自动清理。

expire_logs_days=7  

## 跳过主从复制中遇到的所有错误或指定类型的错误，避免slave端复制中断。

## 如：1062错误是指一些主键重复，1032错误是因为主从数据库数据不一致

slave_skip_errors=1062

# -----------------------------------------------------------
# slave config
# -----------------------------------------------------------
[mysqld]

## 设置server_id，同一局域网中需要唯一

server_id=102

## 指定不需要同步的数据库名称

binlog-ignore-db=mysql  

## 开启二进制日志功能，以备Slave作为其它数据库实例的Master时使用

log-bin=mall-mysql-slave1-bin  

## 设置二进制日志使用内存大小（事务）

binlog_cache_size=1M  

## 设置使用的二进制日志格式（mixed,statement,row）

binlog_format=mixed  

## 二进制日志过期清理时间。默认值为0，表示不自动清理。

expire_logs_days=7  

## 跳过主从复制中遇到的所有错误或指定类型的错误，避免slave端复制中断。

## 如：1062错误是指一些主键重复，1032错误是因为主从数据库数据不一致

slave_skip_errors=1062  

## relay_log配置中继日志

relay_log=mall-mysql-relay-bin  

## log_slave_updates表示slave将复制事件写进自己的二进制日志

log_slave_updates=1  

## slave设置为只读（具有super权限的用户除外）

read_only=1

# -----------------------------------------------------------

docker run -p 3307:3306 --name mysql-master \
-v /home/TomDu/mydata/mysql-master/log:/var/log/mysql \
-v /home/TomDu/mydata/mysql-master/data:/var/lib/mysql \
-v /home/TomDu/mydata/mysql-master/conf:/etc/mysql \
-v /home/TomDu/mydata/mysql-master/mysql-files:/var/lib/mysql-files \
-e MYSQL_ROOT_PASSWORD=123456 \
--network host \
-d mysql:8.0.25 


docker run -p 3308:3306 --name mysql-slave \
-v /mydata/mysql-slave/log:/var/log/mysql \
-v /mydata/mysql-slave/data:/var/lib/mysql \
-v /mydata/mysql-slave/conf:/etc/mysql \
-v /mydata/mysql-slave/mysql-files:/var/lib/mysql-files \
-e MYSQL_ROOT_PASSWORD=123456 \
-d mysql:8.0.25


#  create user in master instance
CREATE USER 'slave'@'%' IDENTIFIED BY '123456';
GRANT REPLICATION SLAVE,REPLICATION CLIENT ON *.* TO 'slave'@'%';
ALTER USER 'slave'@'%' IDENTIFIED WITH mysql_native_password BY '123456';


# show master status
show master status;



# slave config
change master to master_host='192.168.2.110', master_user='slave', master_password='123456', master_port=3306, master_log_file='mall-mysql-bin.000005', master_log_pos=156, master_connect_retry=30;

# show slave status
start slave;
show slave status \G

# read error log 
# Slave_IO_Running: Yes, Slave_SQL_Running: Yes
# docker command 
# CentOS which package contains ping
 yum provides "*/ping" 

# check network of container
 docker inspect --format='{{.NetworkSettings.IPAddress}}' mysql-master
 docker inspect --format='{{.NetworkSettings.IPAddress}}' mysql-slave