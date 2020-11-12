/*********************************************************************************************************************************/
/************************************************************* MODUL 6 ***********************************************************/
/*********************************************************************************************************************************/

--Modu³ 6 - Zadanie 1
/* Na podstawie skryptu powy¿ej:
	a. OPCJA1: Odtwórz schemat z danymi na podstawie skryptu
	b. OPCJA2: Dopasuj skrypt pod swój przygotowany schemat z poprzednich modu³ów. */

/********************Polecenia z konsoli****************************/
--psql -U postgres -p 5433 -h localhost -d postgres -f "C:\Users\olasa\AppData\Roaming\DBeaverData\workspace6\ZrozumSQL_Projekt\Projekt_OlaS\backup\m6_expense_tracker_dump.sql"


--Modu³ 6 - Zadanie 2
/* Zapoznaj siê z danymi zawartymi w tabelach.
	a. SprawdŸ kategorie, podkategorie.
	b. SprawdŸ relacje pomiêdzy tabelami: BANK_ACCOUNT_TYPES, BANK_ACCOUNT_OWNER, TRANSACTION_BANK_ACCOUNTS, USERS
	c. SprawdŸ w ilu danych brakuje po³¹czenia z tabelami powi¹zanymi (u¿ycie kluczy -1) */



--Modu³ 6 - Zadanie 3
/* Poœwiêæ trochê czasu na przemyœlenie, jakie b³êdy logiczne / strukturalne widzisz w tym schemacie.
Uwzglêdnij æwiczenia z Modu³u 5 (dodawanie wierszy do tabel projektu) i dane rzeczywiste z tego modu³u.
Zaproponuj ewentualne zmiany:
	o Mog¹ to byæ zmiany w tabelach (usuniêcie tabel / rozbicie / normalizacja)
	o Mog¹ to byæ zmiany w atrybutach (dodanie atrybutów / zamiana niektórych tabel na atrybuty / usuniêcie kolumn)
	o Zmiana relacji FOREIGN KEY (czy wszystko jest potrzebne? Czy czegoœ brakuje?) */


--Tabela bank_account_owner
--typ kolumny user_login zmieni³abym na varchar teraz jest int.
--albo usunê³abym tê kolumnê, poniewa¿ jest ona w tabeli users
--lepiej odpowiednio po³¹czyæ te tabele ze sob¹ relacj¹
--poza tym tabela bank_account_owner powinna byæ raczej w jakiœ sposób spójna z tabel¹ users,
--mo¿e pomiêdzy tabel¹ users, a bank_account_owner powinna byæ jeszcze jedna tabela przechowuj¹ca klucze g³ówne obu 
--tych tabel w taki sposób, aby wielu u¿ytkowników mog³o byæ przypisanych do wielu kont.


--Tabela bank_account_types
--nie powinien tu byæ przypisany w³aœciciel konta, mo¿e byæ wiele kont danego typu a tym samym wielu w³aœcicieli
--w³aœciciele powinni byæ wskazani dla konkretnego konta lub kont, a nie dla typu kont
--przez przypisanie w³aœciciela tabelka siê psu³a, bo nazwy typów kont siê powtarza³y, przez to ¿e toretycznie rekordy siê ró¿ni³y, ale tylko w³aœcicielem
--w zwi¹zku z tym tabelê bank_account_types pozostawi³abym jedynie w relacji z tabel¹ transaction_bank_account


--Tabela transaction_bank_accounts
--tabelê transaction_bank_accounts pozostawi³abym raczej z relacjami z tabelami: transactions, bank_account_owner oraz bank_account_types
--tak naprawdê nazwa i opis tycz¹ siê tego co znajduje siê w tabeli bank_account_types


--Tabela transaction_category
--chyba stworzy³abym now¹ tabelê ³¹cz¹c¹ tabele transaction_category i transaction_subcategory, w taki sposób, aby kategoria mog³a mieæ wiele podkategorii, a ka¿da podkategoria wiele kategorii. (wtedy klucz g³ówny z³o¿ony w nowej tabeli)


--Tabela transaction_subcategory
--nazwa podkategorii jest wszêdzie taka sama jak opis podkategorii, wiêc nie jestem pewna czy potrzebna jest kolumna do opisu kategorii


--Tabela transaction_type
--raczej bez zmian


--Tabela transactions
--wydaje mi siê, ¿e z tabeli transaction mo¿na by by³o usun¹æ kolumnê id_trans_cat, a tym samym klucz obcy i zostawiæ tylko odwo³anie do podkategorii,
--a od podkategorii spokojnie bêdzie mo¿na dostaæ siê do kategorii
--chyba usunê³abym te¿ po³¹czenie z tabel¹ users


--Tabela users
--po³¹czona by³aby now¹, dodatkow¹ tabel¹ z tabel¹ bank_account_owner. W taki sposób, ¿eby u¿ytkownik móg³ byæ w³aœcicielem wielu kont oraz ¿eby konta mog³y mieæ przypisanych wielu w³aœcicieli. (wtedy klucz g³ówny z³o¿ony w nowej tabeli)
--mog³oby byæ te¿ tak, zeby zamiast id_user wartoœci¹ unikaln¹ by³o user_login i wtedy tabelê users po³¹czyæ z tabel¹ bank_account_owner takim kluczem


--Ogólnie kolumnê active da³abym tylko do tabeli transaction_bank_accounts, ewentualnie jeszcze do tabeli users
--oraz zmienila typ tej kolumny na boolean
--poza tym wartoœci w kolumnie active s¹ wszêdzie sta³e i wynosz¹ '1', wiêc aktualnie wydaje siê byæ bezu¿yteczna



