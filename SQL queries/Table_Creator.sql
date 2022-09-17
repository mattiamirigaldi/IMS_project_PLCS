create table admins (

	id bigint,
	firstname varchar(50),
	lastname  varchar(50),
	username  varchar(50),
	mail	  varchar(50),
	pwd      varchar(50),
	rfid bigint,
);

create table operators(
	admin_id bigint,
	id bigint,
	firstname varchar(50),
	lastname  varchar(50),
	username  varchar(50),
	mail	  varchar(50),
	pwd      varchar(50),
	rfid bigint,
	branch varchar(255),
);


create table customers(
	admin_id bigint,
	opr_id bigint,
	id bigint,
	firstname varchar(50),
	lastname  varchar(50),
	username  varchar(50),
	mail	  varchar(50),
	pwd      varchar(50),
	rfid bigint,
	branch varchar(255),
);


create table totems(

	admin_id bigint,
	opr_id	 bigint,
	totem_id	 bigint, 
	macAddress	 varchar(255),
);


create table items(

	admin_id bigint,
	opr_id	 bigint,
	cus_id	 bigint, 
	id		 bigint,
	name	 varchar(255),
	category varchar(50),
	branch varchar(255),
	rfid	bigint
);



create table books(

	item_id bigint, 
	id		 bigint,
	title	 varchar(255),
	author varchar(50),
	genre varchar(255),
	publisher varchar(50),
	date  varchar(50),
	rfid	bigint,
	loc		varchar(255),
	description varchar(255),
);
