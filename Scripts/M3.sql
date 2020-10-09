--Zadanie 1
--CREATE SCHEMA expense_tracker;

--Zadanie 2
--tabela bank_account_owner

DROP TABLE IF EXISTS expense_tracker.bank_account_owner;

CREATE TABLE IF NOT EXISTS expense_tracker.bank_account_owner (
	id_ba_own serial,
	owner_name VARCHAR(50) NOT NULL,
	owner_desc VARCHAR(250),
	user_login VARCHAR(50) NOT NULL,
	active boolean DEFAULT TRUE NOT NULL,
	insert_date timestamp DEFAULT current_timestamp,
	update_date timestamp DEFAULT current_timestamp
);

ALTER TABLE expense_tracker.bank_account_owner ADD CONSTRAINT pk_bank_account_owner PRIMARY KEY (id_ba_own);

--tabela bank_account_types

DROP TABLE IF EXISTS expense_tracker.bank_account_types;

CREATE TABLE IF NOT EXISTS expense_tracker.bank_account_types ( 
	id_ba_type serial, 
	ba_type varchar(50) NOT NULL, 
	ba_desc varchar(250), 
	active boolean DEFAULT TRUE NOT NULL,
	is_common_account boolean DEFAULT FALSE NOT NULL, 
	id_ba_own int,
	insert_date timestamp DEFAULT current_timestamp,
	update_date timestamp DEFAULT current_timestamp 
);

ALTER TABLE expense_tracker.bank_account_types ADD CONSTRAINT pk_bank_account_types PRIMARY KEY (id_ba_type);

-- tabela transactions
DROP TABLE IF EXISTS expense_tracker.transactions;

CREATE TABLE IF NOT EXISTS expense_tracker.transactions (
	id_transaction serial,
	id_trans_ba int,
	id_trans_cat int,
	id_trans_subcat int,
	id_trans_type int,
	id_user int,
	transaction_date date DEFAULT current_date,
	transaction_value numeric(9,2),
	transaction_description text,
	insert_date timestamp DEFAULT current_timestamp,
	update_date timestamp DEFAULT current_timestamp
);

ALTER TABLE expense_tracker.transactions ADD CONSTRAINT pk_transactions PRIMARY KEY (id_transaction);
--ALTER TABLE expense_tracker.transactions ADD CONSTRAINT transactions_users_fk FOREIGN KEY (id_user) REFERENCES users(id_user);

--tabela transaction_bank_accounts

DROP TABLE IF EXISTS expense_tracker.transaction_bank_accounts;

CREATE TABLE IF NOT EXISTS expense_tracker.transaction_bank_accounts (
	id_trans_ba serial,
	id_ba_own int,
	id_ba_typ int,
	bank_account_name varchar(50) NOT NULL,
	bank_account_desc varchar(250),
	active boolean DEFAULT TRUE NOT NULL, 
	insert_date timestamp DEFAULT current_timestamp,
	update_date timestamp DEFAULT current_timestamp
);

ALTER TABLE expense_tracker.transaction_bank_accounts ADD CONSTRAINT pk_transaction_bank_accounts PRIMARY KEY (id_trans_ba);

--tabela transaction_category

DROP TABLE IF EXISTS expense_tracker.transaction_category;

CREATE TABLE IF NOT EXISTS expense_tracker.transaction_category (
	id_trans_cat serial,
	category_name varchar(50) NOT NULL,
	category_description varchar(250),
	active boolean DEFAULT TRUE NOT NULL, 
	insert_date timestamp DEFAULT current_timestamp,
	update_date timestamp DEFAULT current_timestamp
);

ALTER table expense_tracker.transaction_category ADD CONSTRAINT pk_transaction_category PRIMARY KEY (id_trans_cat);

--tabela transaction_subcategory

DROP TABLE IF EXISTS expense_tracker.transaction_subcategory;

CREATE TABLE IF NOT EXISTS expense_tracker.transaction_subcategory (
	id_trans_subcat serial,
	id_trans_cat int,
	subcategory_name varchar(50) NOT NULL,
	subcategory_description varchar(250),
	active boolean DEFAULT TRUE NOT NULL, 
	insert_date timestamp DEFAULT current_timestamp,
	update_date timestamp DEFAULT current_timestamp
);

ALTER TABLE expense_tracker.transaction_subcategory ADD CONSTRAINT pk_transaction_subcategory PRIMARY KEY (id_trans_subcat);

--tabela transaction_type

DROP TABLE IF EXISTS expense_tracker.transaction_type;

CREATE TABLE IF NOT EXISTS expense_tracker.transaction_type (
	id_trans_type serial,
	transaction_type_name varchar(50) NOT NULL,
	transaction_type_desc varchar(250),
	active boolean DEFAULT TRUE NOT NULL, 
	insert_date timestamp DEFAULT current_timestamp,
	update_date timestamp DEFAULT current_timestamp
);

ALTER TABLE expense_tracker.transaction_type ADD CONSTRAINT pk_transaction_type PRIMARY KEY (id_trans_type);

--tabela users

DROP TABLE IF EXISTS expense_tracker.users;

CREATE TABLE IF NOT EXISTS expense_tracker.users (
	id_user serial,
	user_login varchar(25) NOT NULL,
	user_name varchar(50) NOT NULL,
	user_password varchar(100) NOT NULL,
	password_salt varchar(100) NOT NULL,
	active boolean DEFAULT TRUE NOT NULL, 
	insert_date timestamp DEFAULT current_timestamp,
	update_date timestamp DEFAULT current_timestamp
);

ALTER TABLE expense_tracker.users ADD CONSTRAINT pk_users PRIMARY KEY (id_user);
/*
--testowanie dzia³ania, jeœli id_user w tabeli users jest typu serial, a w tabeli transactions id_user jest typu int (sprawdzenie czy nie wyrzuca b³êdu)
INSERT INTO expense_tracker.users (
	id_user,
	user_login,
	user_name,
	user_password, 
	password_salt)
VALUES (1, 'olasan', 'olasan', 'ola123456', 'B87RS') ;

INSERT INTO expense_tracker.transactions (
	id_transaction,
	id_trans_ba,
	id_trans_cat,
	id_trans_subcat,
	id_trans_type,
	id_user,
	transaction_value,
	transaction_description)
VALUES ( 1, 1, 1, 1, 1, 1, 9.99, 'test' );

INSERT INTO expense_tracker.transactions (
	id_transaction,
	id_trans_ba,
	id_trans_cat,
	id_trans_subcat,
	id_trans_type,
	id_user,
	transaction_value,
	transaction_description)
VALUES (2,1,1,1,1,12,9.99,'test');

DELETE FROM users;
DELETE FROM transactions;
*/
