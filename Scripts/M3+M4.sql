/*********************************************************************************************************************************/
/************************************************************* MODUL 3 ***********************************************************/
/*********************************************************************************************************************************/

--Modu³ 3 - Zadanie 1
--Stwórz nowy schemat o nazwie expense_tracker

--DROP SCHEMA IF EXISTS expense_tracker;

--CREATE SCHEMA expense_tracker;


--Modu³ 3 - Zadanie 2
--W schemacie expense_tracker na podstawie do³¹czonego diagramu ERD stwórz wszystkie tabele projektowe, wed³ug do³¹czonego opisu. 

--tabela bank_account_owner

DROP TABLE IF EXISTS expense_tracker.bank_account_owner;

CREATE TABLE IF NOT EXISTS expense_tracker.bank_account_owner (
	id_ba_own SERIAL,
	owner_name VARCHAR(50) NOT NULL,
	owner_desc VARCHAR(250),
	user_login VARCHAR(50) NOT NULL,
	active BOOLEAN DEFAULT TRUE NOT NULL,
	insert_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	update_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
	CONSTRAINT pk_bank_account_owner PRIMARY KEY (id_ba_own)
);


--tabela bank_account_types

DROP TABLE IF EXISTS expense_tracker.bank_account_types;

CREATE TABLE IF NOT EXISTS expense_tracker.bank_account_types ( 
	id_ba_type SERIAL, 
	ba_type VARCHAR(50) NOT NULL, 
	ba_desc VARCHAR(250), 
	active BOOLEAN DEFAULT TRUE NOT NULL,
	is_common_account BOOLEAN DEFAULT FALSE NOT NULL, 
	id_ba_own INT,
	insert_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	update_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT pk_bank_account_types PRIMARY KEY (id_ba_type),
	CONSTRAINT bank_account_types_fk FOREIGN KEY (id_ba_own) REFERENCES bank_account_owner(id_ba_own)
);

--ALTER TABLE expense_tracker.transactions ADD CONSTRAINT transactions_users_fk FOREIGN KEY (id_user) REFERENCES users(id_user);


--tabela transaction_bank_accounts

DROP TABLE IF EXISTS expense_tracker.transaction_bank_accounts;

CREATE TABLE IF NOT EXISTS expense_tracker.transaction_bank_accounts (
	id_trans_ba SERIAL,
	id_ba_own INT,
	id_ba_type INT,
	bank_account_name VARCHAR(50) NOT NULL,
	bank_account_desc VARCHAR(250),
	active BOOLEAN DEFAULT TRUE NOT NULL, 
	insert_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	update_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT pk_transaction_bank_accounts PRIMARY KEY (id_trans_ba),
	CONSTRAINT transaction_bank_accounts_owner_fk FOREIGN KEY (id_ba_own) REFERENCES bank_account_owner(id_ba_own),
	CONSTRAINT transaction_bank_accounts_types_fk FOREIGN KEY (id_ba_type) REFERENCES bank_account_types(id_ba_type)
);


--tabela transaction_category

DROP TABLE IF EXISTS expense_tracker.transaction_category;

CREATE TABLE IF NOT EXISTS expense_tracker.transaction_category (
	id_trans_cat SERIAL,
	category_name VARCHAR(50) NOT NULL,
	category_description VARCHAR(250),
	active BOOLEAN DEFAULT TRUE NOT NULL, 
	insert_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	update_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT pk_transaction_category PRIMARY KEY (id_trans_cat)
);


--tabela transaction_subcategory

DROP TABLE IF EXISTS expense_tracker.transaction_subcategory;

CREATE TABLE IF NOT EXISTS expense_tracker.transaction_subcategory (
	id_trans_subcat SERIAL,
	id_trans_cat INT,
	subcategory_name VARCHAR(50) NOT NULL,
	subcategory_description VARCHAR(250),
	active BOOLEAN DEFAULT TRUE NOT NULL, 
	insert_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	update_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT pk_transaction_subcategory PRIMARY KEY (id_trans_subcat),
	CONSTRAINT transaction_subcategory_category_fk FOREIGN KEY (id_trans_cat) REFERENCES transaction_category(id_trans_cat)
);


--tabela transaction_type

DROP TABLE IF EXISTS expense_tracker.transaction_type;

CREATE TABLE IF NOT EXISTS expense_tracker.transaction_type (
	id_trans_type SERIAL,
	transaction_type_name VARCHAR(50) NOT NULL,
	transaction_type_desc VARCHAR(250),
	active BOOLEAN DEFAULT TRUE NOT NULL, 
	insert_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	update_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT pk_transaction_type PRIMARY KEY (id_trans_type)
);


--tabela users

DROP TABLE IF EXISTS expense_tracker.users;

CREATE TABLE IF NOT EXISTS expense_tracker.users (
	id_user SERIAL,
	user_login VARCHAR(25) NOT NULL,
	user_name VARCHAR(50) NOT NULL,
	user_password VARCHAR(100) NOT NULL,
	password_salt VARCHAR(100) NOT NULL,
	active BOOLEAN DEFAULT TRUE NOT NULL, 
	insert_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	update_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT pk_users PRIMARY KEY (id_user)
);


-- tabela transactions

DROP TABLE IF EXISTS expense_tracker.transactions;

CREATE TABLE IF NOT EXISTS expense_tracker.transactions (
	id_transaction SERIAL,
	id_trans_ba INT,
	id_trans_cat INT,
	id_trans_subcat INT,
	id_trans_type INT,
	id_user INT,
	transaction_date DATE DEFAULT CURRENT_DATE,
	transaction_value NUMERIC(9,2),
	transaction_description TEXT,
	insert_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	update_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT pk_transactions PRIMARY KEY (id_transaction),
	CONSTRAINT transactions_bank_accounts_fk FOREIGN KEY (id_trans_ba) REFERENCES transaction_bank_accounts(id_trans_ba),
	CONSTRAINT transactions_category_fk FOREIGN KEY (id_trans_cat) REFERENCES transaction_category(id_trans_cat),
	CONSTRAINT transactions_subcategory_fk FOREIGN KEY (id_trans_subcat) REFERENCES transaction_subcategory(id_trans_subcat),
	CONSTRAINT transactions_type_fk FOREIGN KEY (id_trans_type) REFERENCES transaction_type(id_trans_type),
	CONSTRAINT transactions_users_fk FOREIGN KEY (id_user) REFERENCES users(id_user)
);


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

/*********************************************************************************************************************************/
/************************************************************* MODUL 4 ***********************************************************/
/*********************************************************************************************************************************/

--Modu³ 4 - Zadanie 1
--Korzystaj¹c ze sk³adni CREATE ROLE, stwórz nowego u¿ytkownika o nazwie
--expense_tracker_user z mo¿liwoœci¹ zalogowania siê do bazy danych i has³em silnym

CREATE ROLE expense_tracker_user WITH LOGIN PASSWORD 'TrudneHasloProjekt111@';


--Modu³ 4 - Zadanie 2
-- Korzystaj¹c ze sk³adni REVOKE, odbierz uprawnienia tworzenia obiektów w schemacie public roli PUBLIC

REVOKE CREATE ON SCHEMA public FROM PUBLIC;


--Modu³ 4 - Zadanie 3
--Je¿eli w Twoim œrodowisku istnieje ju¿ schemat expense_tracker (z obiektami tabel) usuñ go korzystaj¹c z polecenie DROP CASCADE.

DROP SCHEMA expense_tracker CASCADE;


--Modu³ 4 - Zadanie 4
--Utwórz now¹ rolê expense_tracker_group

CREATE ROLE expense_tracker_group WITH LOGIN PASSWORD 'ExpenseTrackerGroup111@';


--Modu³ 4 - Zadanie 5
--Utwórz schemat expense_tracker, korzystaj¹c z atrybutu AUTHORIZATION, ustalaj¹c w³asnoœæ na rolê expense_tracker_group.

CREATE SCHEMA expense_tracker AUTHORIZATION expense_tracker_group;


--Modu³ 4 - Zadanie 6
--Dla roli expense_tracker_group, dodaj nastêpuj¹ce przywileje:
	--Dodaj przywilej ³¹czenia do bazy danych postgres (lub innej, je¿eli korzystasz z innej nazwy)
	--Dodaj wszystkie przywileje do schematu expense_tracker

GRANT CONNECT ON DATABASE postgres TO expense_tracker_group;

GRANT ALL PRIVILEGES ON SCHEMA expense_tracker TO expense_tracker_group;


--Modu³ 4 - Zadanie 7
--Dodaj rolê expense_tracker_group u¿ytkownikowi expense_tracker_user.

GRANT expense_tracker_group TO expense_tracker_user;

