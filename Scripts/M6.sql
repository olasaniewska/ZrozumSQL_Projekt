/*********************************************************************************************************************************/
/************************************************************* MODUL 6 ***********************************************************/
/*********************************************************************************************************************************/

--Modu� 6 - Zadanie 1
/* Na podstawie skryptu powy�ej:
	a. OPCJA1: Odtw�rz schemat z danymi na podstawie skryptu
	b. OPCJA2: Dopasuj skrypt pod sw�j przygotowany schemat z poprzednich modu��w. */

/********************Polecenia z konsoli****************************/
--psql -U postgres -p 5433 -h localhost -d postgres -f "C:\Users\olasa\AppData\Roaming\DBeaverData\workspace6\ZrozumSQL_Projekt\Projekt_OlaS\backup\m6_expense_tracker_dump.sql"


--Modu� 6 - Zadanie 2
/* Zapoznaj si� z danymi zawartymi w tabelach.
	a. Sprawd� kategorie, podkategorie.
	b. Sprawd� relacje pomi�dzy tabelami: BANK_ACCOUNT_TYPES, BANK_ACCOUNT_OWNER, TRANSACTION_BANK_ACCOUNTS, USERS
	c. Sprawd� w ilu danych brakuje po��czenia z tabelami powi�zanymi (u�ycie kluczy -1) */



--Modu� 6 - Zadanie 3
/* Po�wi�� troch� czasu na przemy�lenie, jakie b��dy logiczne / strukturalne widzisz w tym schemacie.
Uwzgl�dnij �wiczenia z Modu�u 5 (dodawanie wierszy do tabel projektu) i dane rzeczywiste z tego modu�u.
Zaproponuj ewentualne zmiany:
	o Mog� to by� zmiany w tabelach (usuni�cie tabel / rozbicie / normalizacja)
	o Mog� to by� zmiany w atrybutach (dodanie atrybut�w / zamiana niekt�rych tabel na atrybuty / usuni�cie kolumn)
	o Zmiana relacji FOREIGN KEY (czy wszystko jest potrzebne? Czy czego� brakuje?) */


--Tabela bank_account_owner
--typ kolumny user_login zmieni�abym na varchar teraz jest int.
--albo usun�abym t� kolumn�, poniewa� jest ona w tabeli users
--lepiej odpowiednio po��czy� te tabele ze sob� relacj�
--poza tym tabela bank_account_owner powinna by� raczej w jaki� spos�b sp�jna z tabel� users,
--mo�e pomi�dzy tabel� users, a bank_account_owner powinna by� jeszcze jedna tabela przechowuj�ca klucze g��wne obu 
--tych tabel w taki spos�b, aby wielu u�ytkownik�w mog�o by� przypisanych do wielu kont.


--Tabela bank_account_types
--nie powinien tu by� przypisany w�a�ciciel konta, mo�e by� wiele kont danego typu a tym samym wielu w�a�cicieli
--w�a�ciciele powinni by� wskazani dla konkretnego konta lub kont, a nie dla typu kont
--przez przypisanie w�a�ciciela tabelka si� psu�a, bo nazwy typ�w kont si� powtarza�y, przez to �e toretycznie rekordy si� r�ni�y, ale tylko w�a�cicielem
--w zwi�zku z tym tabel� bank_account_types pozostawi�abym jedynie w relacji z tabel� transaction_bank_account


--Tabela transaction_bank_accounts
--tabel� transaction_bank_accounts pozostawi�abym raczej z relacjami z tabelami: transactions, bank_account_owner oraz bank_account_types
--tak naprawd� nazwa i opis tycz� si� tego co znajduje si� w tabeli bank_account_types


--Tabela transaction_category
--chyba stworzy�abym now� tabel� ��cz�c� tabele transaction_category i transaction_subcategory, w taki spos�b, aby kategoria mog�a mie� wiele podkategorii, a ka�da podkategoria wiele kategorii. (wtedy klucz g��wny z�o�ony w nowej tabeli)


--Tabela transaction_subcategory
--nazwa podkategorii jest wsz�dzie taka sama jak opis podkategorii, wi�c nie jestem pewna czy potrzebna jest kolumna do opisu kategorii


--Tabela transaction_type
--raczej bez zmian


--Tabela transactions
--wydaje mi si�, �e z tabeli transaction mo�na by by�o usun�� kolumn� id_trans_cat, a tym samym klucz obcy i zostawi� tylko odwo�anie do podkategorii,
--a od podkategorii spokojnie b�dzie mo�na dosta� si� do kategorii
--chyba usun�abym te� po��czenie z tabel� users


--Tabela users
--po��czona by�aby now�, dodatkow� tabel� z tabel� bank_account_owner. W taki spos�b, �eby u�ytkownik m�g� by� w�a�cicielem wielu kont oraz �eby konta mog�y mie� przypisanych wielu w�a�cicieli. (wtedy klucz g��wny z�o�ony w nowej tabeli)
--mog�oby by� te� tak, zeby zamiast id_user warto�ci� unikaln� by�o user_login i wtedy tabel� users po��czy� z tabel� bank_account_owner takim kluczem


--Og�lnie kolumn� active da�abym tylko do tabeli transaction_bank_accounts, ewentualnie jeszcze do tabeli users
--oraz zmienila typ tej kolumny na boolean
--poza tym warto�ci w kolumnie active s� wsz�dzie sta�e i wynosz� '1', wi�c aktualnie wydaje si� by� bezu�yteczna



