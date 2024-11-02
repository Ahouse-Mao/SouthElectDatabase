--初始化postgres管理员用户
sudo su postgres --切换默认的管理员用户（可以越过登录）
psql --超级管理员免密登录
\l --查看目前的数据库
\password --修改管理员用户密码

--创建角色&修改权限
CREATE ROLE 角色名 WITH 权限名;
--WITH LOGIN：允许角色登录到数据库。
--WITH CREATEDB：允许角色创建数据库。
--WITH CREATEROLE：允许角色创建其他角色。
--NOSUPERUSER：防止角色成为超级用户。
--INHERIT：允许角色继承父角色的权限。
--NOINHERIT：不允许角色继承父角色的权限。
ALTER ROLE 角色名 WITH 权限名;