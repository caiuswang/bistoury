insert into bistoury_user (user_code, password) values ('admin','q1mHvT20zskSnIHSF27d/A==');
insert into bistoury_app(code, name, group_code, status, creator) values ('bistoury_demo_app','测试应用','tcdev',1,'admin');
insert into bistoury_user_app (app_code, user_code) values ('bistoury_demo_app','admin');
insert into bistoury_server (server_id, ip, port, host, log_dir, room, app_code, auto_jstack_enable, auto_jmap_histo_enable) values ('bade8ba7d59b4ca0b91a044739a670aa','127.0.0.1',8080,'${local_host}','${log_dir}','al','bistoury_demo_app',1,0);
insert into bistoury_app(code, name, group_code, status, creator) values ('168','tkl-h5-api','tcdev',1,'admin');
insert into bistoury_server (server_id, ip, port, host, log_dir, room, app_code, auto_jstack_enable, auto_jmap_histo_enable) values ('b7ab631d8f30415d99ef6c2b922abd19','${local_ip}',8060,'${local_host}','${log_dir}','al','tkl-h5-api',1,0);
insert into bistoury_user_app (app_code, user_code) values ('tkl-h5-api','admin');
INSERT INTO bistoury_gitlab_token(user_code, private_token) VALUES ('admin', 'ow4yy4OULCXTKEPd/vlmLWmVK8qFD1FI5DnshVhSjco=');