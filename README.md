# ocserv-compose
ocserv daloRADIUS freeradius  docker compose .anyconnect server  

## 介绍

AnyConnect VPN 服务端ocserv ,freeradius ,daloradius,mysql 的docker-compose 整合.
  
## Install
前提是已经安装[Docker](https://developer.aliyun.com/mirror/docker-ce) ,[Docker-compose](https://github.com/docker/compose).并启动好docker. 
* 将当前 repo 下载到本地.  
`cd ~;git clone https://github.com/youxixin888/ocserv-compose.git`  
* 按需要修改证书请求里边的服务器地址等信息(可选)  
`cd ~/ocserv-compose/certs/`
* 构建镜像  
 `cd ~/ocserv-compose;docker build -t ocserv .`
* 生成证书和key  
`docker run --rm -v ~/ocserv-compose/certs/:/opt/certs  ocserv sh /opt/certs/gen.sh` 
* 按需修改ocserv/ocserv.conf 这里可以配置地址,路由,dns等信息(可选)  
`cd ~/ocserv-compose/ocserv/;vi ocserv.conf`
* 启动服务器(最后加-d参数可以后台运行)  
`cd ~/ocserv-compose;docker-compose up`
  
## 使用
* 访问管理后台添加用户  
`http://yourserverip/daloradius`
默认密码radius  
  
* 客户端测试连接  
* 按需配置iptables使用nat或者
  
## 参考:
* [wppurking/ocserv-docker](https://github.com/wppurking/ocserv-docker)
* [frauhottelmann/daloradius-docker](https://github.com/frauhottelmann/daloradius-docker)
