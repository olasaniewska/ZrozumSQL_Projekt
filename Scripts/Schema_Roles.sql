
/*********************************************************************************************************************************/
/************************************************************* MODUL 4 ***********************************************************/
/*********************************************************************************************************************************/

--Modu³ 4 - Zadanie 1
--Korzystaj¹c ze sk³adni CREATE ROLE, stwórz nowego u¿ytkownika o nazwie
--expense_tracker_user z mo¿liwoœci¹ zalogowania siê do bazy danych i has³em silnym

--DROP ROLE IF EXISTS expense_tracker_user;

CREATE ROLE expense_tracker_user WITH LOGIN PASSWORD 'TrudneHasloProjekt111@';


--Modu³ 4 - Zadanie 2
-- Korzystaj¹c ze sk³adni REVOKE, odbierz uprawnienia tworzenia obiektów w schemacie public roli PUBLIC

REVOKE CREATE ON SCHEMA public FROM PUBLIC;


--Modu³ 4 - Zadanie 3
--Je¿eli w Twoim œrodowisku istnieje ju¿ schemat expense_tracker (z obiektami tabel) usuñ go korzystaj¹c z polecenie DROP CASCADE.

DROP SCHEMA IF EXISTS expense_tracker CASCADE;


--Modu³ 4 - Zadanie 4
--Utwórz now¹ rolê expense_tracker_group

CREATE ROLE expense_tracker_group;


--Modu³ 4 - Zadanie 5
--Utwórz schemat expense_tracker, korzystaj¹c z atrybutu AUTHORIZATION, ustalaj¹c w³asnoœæ na rolê expense_tracker_group.

CREATE SCHEMA expense_tracker AUTHORIZATION expense_tracker_group;

--Modu³ 4 - Zadanie 6
--Dla roli expense_tracker_group, dodaj nastêpuj¹ce przywileje:
	--Dodaj przywilej ³¹czenia do bazy danych postgres (lub innej, je¿eli korzystasz z innej nazwy)
	--Dodaj wszystkie przywileje do schematu expense_tracker

GRANT CONNECT ON DATABASE postgres TO expense_tracker_group;

GRANT ALL PRIVILEGES ON SCHEMA expense_tracker TO expense_tracker_group;


--REASSIGN OWNED BY expense_tracker_group TO postgres; -- jak chcia³abym usun¹æ rolê expense_tracker_group to najpierw trzeba by³oby odebraæ w³asnoœæ nad schematem
--DROP OWNED BY expense_tracker_group;
--DROP ROLE IF EXISTS expense_tracker_group; - i usun¹æ

--Modu³ 4 - Zadanie 7
--Dodaj rolê expense_tracker_group u¿ytkownikowi expense_tracker_user.

GRANT expense_tracker_group TO expense_tracker_user;

