
/*********************************************************************************************************************************/
/************************************************************* MODUL 4 ***********************************************************/
/*********************************************************************************************************************************/

--Modu� 4 - Zadanie 1
--Korzystaj�c ze sk�adni CREATE ROLE, stw�rz nowego u�ytkownika o nazwie
--expense_tracker_user z mo�liwo�ci� zalogowania si� do bazy danych i has�em silnym

--DROP ROLE IF EXISTS expense_tracker_user;

CREATE ROLE expense_tracker_user WITH LOGIN PASSWORD 'TrudneHasloProjekt111@';


--Modu� 4 - Zadanie 2
-- Korzystaj�c ze sk�adni REVOKE, odbierz uprawnienia tworzenia obiekt�w w schemacie public roli PUBLIC

REVOKE CREATE ON SCHEMA public FROM PUBLIC;


--Modu� 4 - Zadanie 3
--Je�eli w Twoim �rodowisku istnieje ju� schemat expense_tracker (z obiektami tabel) usu� go korzystaj�c z polecenie DROP CASCADE.

DROP SCHEMA IF EXISTS expense_tracker CASCADE;


--Modu� 4 - Zadanie 4
--Utw�rz now� rol� expense_tracker_group

CREATE ROLE expense_tracker_group;


--Modu� 4 - Zadanie 5
--Utw�rz schemat expense_tracker, korzystaj�c z atrybutu AUTHORIZATION, ustalaj�c w�asno�� na rol� expense_tracker_group.

CREATE SCHEMA expense_tracker AUTHORIZATION expense_tracker_group;

--Modu� 4 - Zadanie 6
--Dla roli expense_tracker_group, dodaj nast�puj�ce przywileje:
	--Dodaj przywilej ��czenia do bazy danych postgres (lub innej, je�eli korzystasz z innej nazwy)
	--Dodaj wszystkie przywileje do schematu expense_tracker

GRANT CONNECT ON DATABASE postgres TO expense_tracker_group;

GRANT ALL PRIVILEGES ON SCHEMA expense_tracker TO expense_tracker_group;


--REASSIGN OWNED BY expense_tracker_group TO postgres; -- jak chcia�abym usun�� rol� expense_tracker_group to najpierw trzeba by�oby odebra� w�asno�� nad schematem
--DROP OWNED BY expense_tracker_group;
--DROP ROLE IF EXISTS expense_tracker_group; - i usun��

--Modu� 4 - Zadanie 7
--Dodaj rol� expense_tracker_group u�ytkownikowi expense_tracker_user.

GRANT expense_tracker_group TO expense_tracker_user;

