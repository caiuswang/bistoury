insert into bistoury_user (user_code, password) values ('admin','q1mHvT20zskSnIHSF27d/A==');
INSERT INTO bistoury_gitlab_token(user_code, private_token) VALUES ('admin', 'ow4yy4OULCXTKEPd/vlmLWmVK8qFD1FI5DnshVhSjco=');

insert into bistoury_app(code, git_id, name, group_code, status, creator) values ('bistoury_demo_app', 1, '测试应用','tcdev',1,'admin');
insert into bistoury_user_app (app_code, user_code) values ('bistoury_demo_app','admin');
insert into bistoury_server (server_id, ip, port, host, log_dir, room, app_code, auto_jstack_enable, auto_jmap_histo_enable) values ('bade8ba7d59b4ca0b91a044739a670aa','127.0.0.1',8080,'${agent_hostname}','${log_dir}','al','bistoury_demo_app',1,0);

insert into bistoury_app(code, git_id, name, group_code, status, creator) values ('tkl-h5-api',168, 'tkl-h5-api','tcdev',1,'admin');
insert into bistoury_server (server_id, ip, port, host, log_dir, room, app_code, auto_jstack_enable, auto_jmap_histo_enable) values ('b7ab631d8f30415d99ef6c2b922abd19','${agent_hostip}',8060,'${agent_hostname}','/data/logs/tkl-h5-api','al','tkl-h5-api',1,0);
insert into bistoury_user_app (app_code, user_code) values ('tkl-h5-api','admin');

insert into bistoury_app(code, git_id, name, group_code, status, creator) values ('tkl-order-api/order-daemon',166,'order-daemon', 'tcdev',1,'admin');
insert into bistoury_server (server_id, ip, port, host, log_dir, room, app_code, auto_jstack_enable, auto_jmap_histo_enable) values ('b7ab631d8f30415d99ef6c2b922abd18','${agent_hostip}',23370,'${agent_hostname}','/data/logs/order-daemon','al','tkl-order-api/order-daemon',1,0);
insert into bistoury_user_app (app_code, user_code) values ('tkl-order-api/order-daemon','admin');


insert into bistoury_app(code, git_id, name, group_code, status, creator) values ('tkl-order-api/order-service',166,'order-service', 'tcdev',1,'admin');
insert into bistoury_server (server_id, ip, port, host, log_dir, room, app_code, auto_jstack_enable, auto_jmap_histo_enable) values ('b7ab631d8f30415d99ef6c2b922abd16','${agent_hostip}',23310,'${agent_hostname}','/data/logs/order-daemon','al','tkl-order-api/order-service',1,0);
insert into bistoury_user_app (app_code, user_code) values ('tkl-order-api/order-service','admin');

insert into bistoury_app(code, git_id, name, group_code, status, creator) values ('tkl-lotto-manager',524, 'tkl-lotto-manager','tcdev',1,'admin');
insert into bistoury_server (server_id, ip, port, host, log_dir, room, app_code, auto_jstack_enable, auto_jmap_histo_enable) values ('b7ab631d8f30415d99ef6c2b922abd17','${agent_hostip}',8886,'${agent_hostname}','/data/logs/tkl-lotto-manager','al','tkl-lotto-manager',1,0);
insert into bistoury_user_app (app_code, user_code) values ('tkl-lotto-manager','admin');


insert into bistoury_app(code, git_id, name, group_code, status, creator) values ('tkl-lotto/lotto-daemon',523, 'lotto-daemon','tcdev',1,'admin');
insert into bistoury_server (server_id, ip, port, host, log_dir, room, app_code, auto_jstack_enable, auto_jmap_histo_enable) values ('b7ab631d8f30415d99ef6c2b922abd15','${agent_hostip}',34200,'${agent_hostname}','/data/logs/lotto-daemon','al','tkl-lotto/lotto-daemon',1,0);
insert into bistoury_user_app (app_code, user_code) values ('tkl-lotto/lotto-daemon','admin');

insert into bistoury_app(code, git_id, name, group_code, status, creator) values ('tkl-sale-api',208, 'tkl-sale-api','tcdev',1,'admin');
insert into bistoury_server (server_id, ip, port, host, log_dir, room, app_code, auto_jstack_enable, auto_jmap_histo_enable) values ('b7ab631d8f30415d99ef6c2b922abd14','${agent_hostip}',34600,'${agent_hostname}','/data/logs/tkl-sale-api','al','tkl-sale-api',1,0);
insert into bistoury_user_app (app_code, user_code) values ('tkl-sale-api','admin');
