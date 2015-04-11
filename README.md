# adopt-a-wifi
WIFI领养计划

你可以认领一个 WIFI，如果:
* 开放一个公共的，可访问 \*\*beep\*\* 的WIFI，或者；
* 让一个公共 WIFI 拥有可访问 \*\*beep\*\* 的超能力


如何提供一个可以访问 \*\*beep\*\* 的WIFI
* 购买一个自带该功能的路由器(以下不是广告)
  * [OAIR H600](http://www.oair.com/index.php/index/web2_pro_c_h600.html)
* 给已有路由器更新固件(待完善)
* 软件方案(待完善)

## TODO:
* ~~一个静态页面，显示一个广州区域的百度地图~~
* ~~数据库，储存已标记区域的信息(可能是领养者名字，wifi名字，wifi密码，备注?)~~
* ~~地图根据数据库信息显示小红旗~~
* 用户可在静态页面提交认领某WIFI的申请
* Github page 指向/serve 该静态页面

## Install:
* 需要安装`mysql`
    * mac 用户可使用`homebrew`进行安装，`brew install mysql`
* 安装依赖包`npm install`

## Usage:
* 开启mysql服务, `mysql.server start`
* 进入`mysql`,`mysql -u root`
* 在`mysql`中,`source /path/to/adopt-a-wifi/app/seed.sql`
    * 在数据库插入
        * `use wifimap`
        * `insert into wifis (name, owner, latitude, longitude) values ("xxx", "xxx", xxx.xxxxxxx, xxx.xxxxxxx)`, 广州市经纬度为113.264435, 23.129163,
* 使用gulp进行开发管理`gulp`
* 开启node服务器,`node app.js`或者 `nodemon app.js`



