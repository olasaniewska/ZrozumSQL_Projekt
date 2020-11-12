/*********************************************************************************************************************************/
/************************************************************* MODUL 5 ***********************************************************/
/*********************************************************************************************************************************/

--Modu� 5 - Zadanie 1 
/* Dla tabel posi�daj�cych klucz g��wny (PRIMARY KEY) zmie� typ danych dla identyfikator�w
(PRIMARY KEY) na typ SERIAL. Zmieniaj�c definicj� struktury i zapytania CREATE TABLE.
Klucze obce w tabelach (z ograniczeniem REFERENCES) powinny zosta�, jako typ ca�kowity. */

--Ten punkt mia�am zrobiony wcze�niej 


--Modu� 5 - Zadanie 2
/* Dla ka�dej z tabel projektowych wstaw przynajmniej 1 rzeczywisty rekord spe�niaj�cy
kryteria tabeli i kluczy obcych. */

--tabela bank_account_owner

INSERT
	INTO
	expense_tracker.bank_account_owner (owner_name, owner_desc, user_login, active, insert_date, update_date )
VALUES('Aleksandra Saniewska', 'Opis', 'olasaniewska', TRUE, '2020-10-28', '2020-10-28');

INSERT
	INTO
	expense_tracker.bank_account_owner (owner_name, owner_desc, user_login)
VALUES('Adam Nowak', 'Opis', 'adam_nowak');

--TRUNCATE TABLE expense_tracker.bank_account_owner RESTART IDENTITY CASCADE;


--tabela bank_account_types
--schemat tabelki bank_account_types wydaje si� by� nieprawid�owy
--moim zdaniem w tej tabeli nie powinno znajdowa� si� id_ba_own, poniewa� wielu w�a�cicieli mo�e posiada� konto jakiego� konkretnego typu, lepiej by�oby ju� przypisywa� do w�a�ciciela typ konta jakie posiada
--wydaje mi si� jednak, �e w schemacie u�yte jest jeszcze lepsze rozwi�zanie - w tabeli transaction_bank_accounts znajduje si� zar�wno informacja o w�a�cicielu konta jak i typie konta jakie posiada i to jest wystarczaj�ce

INSERT
	INTO
	expense_tracker.bank_account_types ( ba_type, ba_desc, id_ba_own )
VALUES('Konto osobiste', 'Opis', 1);


INSERT
	INTO
	expense_tracker.bank_account_types ( ba_type, ba_desc, id_ba_own, active, is_common_account )
VALUES('Konto firmowe', 'Opis', 2 , FALSE, TRUE);

--TRUNCATE TABLE expense_tracker.bank_account_types RESTART IDENTITY CASCADE;


--tabela transaction_bank_accounts

INSERT
	INTO
	expense_tracker.transaction_bank_accounts (id_ba_own, id_ba_type, bank_account_name, bank_account_desc )
VALUES(1, 1, 'Nazwa', 'Opis');

--TRUNCATE TABLE expense_tracker.transaction_bank_accounts RESTART IDENTITY CASCADE;


--tabela transaction_category

INSERT
	INTO
	expense_tracker.transaction_category ( category_name, category_description )
VALUES('Zakupy', 'Opis');

--TRUNCATE TABLE expense_tracker.transaction_category RESTART IDENTITY CASCADE;


--tabela transaction_subcategory

INSERT
	INTO
	expense_tracker.transaction_subcategory ( id_trans_cat, subcategory_name, subcategory_description )
VALUES(1, 'Zakupy spo�ywcze', 'Opis');

--TRUNCATE TABLE expense_tracker.transaction_subcategory RESTART IDENTITY CASCADE;


--tabela transaction_type

INSERT
	INTO
	expense_tracker.transaction_type ( transaction_type_name, transaction_type_desc )
VALUES('Nazwa transakcji', 'Opis');

--TRUNCATE TABLE expense_tracker.transaction_type RESTART IDENTITY CASCADE;


--tabela users

INSERT
	INTO
	expense_tracker.users (user_login, user_name, user_password, password_salt)
VALUES ('olasan', 'olasan', 'ola123456', 'B87RS') ;

--TRUNCATE TABLE expense_tracker.users RESTART IDENTITY CASCADE;


--tabela transactions

INSERT
	INTO
	expense_tracker.transactions ( id_trans_ba, id_trans_cat, id_trans_subcat, id_trans_type, id_user, transaction_value, transaction_description)
VALUES (1, 1, 1, 1, 1, 9.99, 'Transakcja nr. 1' );


INSERT
	INTO
	expense_tracker.transactions ( id_trans_ba, id_trans_cat, id_trans_subcat, id_trans_type, id_user, transaction_value, transaction_description)
VALUES (1, 1, 1, 1, 1, 29.99, 'Transakcja nr. 2');

--TRUNCATE TABLE expense_tracker.transactions RESTART IDENTITY CASCADE;



--Modu� 5 - Zadanie 3
/* Wykonaj pe�n� kopi� zapasow� bazy danych z opcj� --clean (do formatu plain tak �eby
widzie�, co si� zrzuci�o) korzystaj�c z narz�dzia pg_dump. Nast�pnie odtw�rz kopi� z
zapisanego skryptu korzystaj�c z narzedzia DBeaver lub psql. */

/********************Polecenia z konsoli****************************/

--cd C:\Users\olasa\AppData\Roaming\DBeaverData\drivers\clients\postgresql\win\13>

/*
 
pg_dump --host localhost ^
        --port 5433 ^
        --username postgres ^
        --format d ^
        --file "C:\Users\olasa\AppData\Roaming\DBeaverData\workspace6\ZrozumSQL_Projekt\Projekt_OlaS\backup" ^
        --schema expense_tracker ^
        postgres

pg_dump --host localhost ^
        --port 5433 ^
        --username postgres ^
        --format plain ^
        --file "C:\Users\olasa\AppData\Roaming\DBeaverData\workspace6\ZrozumSQL_Projekt\Projekt_OlaS\backup\schema_expense_tracker_bp.sql" ^
        --schema expense_tracker ^
        postgres

pg_restore --host localhost ^
           --port 5433 ^
           --username postgres ^
           --dbname postgres ^
           --clean ^
           "C:\Users\olasa\AppData\Roaming\DBeaverData\workspace6\ZrozumSQL_Projekt\Projekt_OlaS\backup"  


psql -U postgres -p 5433 -h localhost -d postgres -f "C:\Users\olasa\AppData\Roaming\DBeaverData\workspace6\ZrozumSQL_Projekt\Projekt_OlaS\backup\schema_expense_tracker_bp.sql"

**/
