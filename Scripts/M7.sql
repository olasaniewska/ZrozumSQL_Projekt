/*********************************************************************************************************************************/
/************************************************************* MODUL 7 ***********************************************************/
/*********************************************************************************************************************************/

--Modu� 7 - Zadanie 1
--Wy�wietl wszystkie informacje o koncie:
	--nazwa w�a�cieciela (owner_name)
	--opis w�a�ciciela (owner_desc)
	--typ konta (ba_type)
	--opis konta (ba_desc)
	--flaga czy jest aktywne (active)
	--nazwa konta bankowego (bank_account_name)
	--razem z u�ytkownikiem (user_login), kt�ry jest do niego przypisany. Dla w�a�ciciela, jakim jest Janusz Kowalski.

SELECT
	bao.owner_name,
	bao.owner_desc,
	bat.ba_type,
	bat.ba_desc,
	tba.active,
	tba.bank_account_name,
	u.user_login
FROM
	(expense_tracker.bank_account_owner bao
LEFT JOIN expense_tracker.bank_account_types bat ON
	bao.id_ba_own = bat.id_ba_own
LEFT JOIN expense_tracker.transaction_bank_accounts tba ON
	bat.id_ba_type = tba.id_ba_typ)
LEFT JOIN expense_tracker.users u ON
	bao.user_login = u.id_user
WHERE
	bao.owner_name = 'Janusz Kowalski';


--Modu� 7 - Zadanie 2
--Wy�wietl wszystkie informacje o dost�pnych kategoriach transakcji i ich mo�liwych podkategoriach.
--W obu przypadkach powinny to by� tylko "aktywne" elementy (active TRUE / 1 / Y / y :)).
--W wyniku wy�wietl 2 atrybuty, nazwa kategorii i nazwa podkategorii, dane posortuj po
--identyfikatorze kategorii rosn�co.

SELECT
	tc.category_name,
	ts.subcategory_name
FROM
	expense_tracker.transaction_category tc
LEFT JOIN expense_tracker.transaction_subcategory ts ON
	tc.id_trans_cat = ts.id_trans_cat
WHERE
	(tc.active = '1'
	OR tc.active = 'TRUE'
	OR tc.active = 'Y'
	OR tc.active = 'y')
	AND (ts.active = '1'
	OR ts.active = 'TRUE'
	OR ts.active = 'Y'
	OR ts.active = 'y')
ORDER BY
	tc.id_trans_cat ASC;


--Modu� 7 - Zadanie 3
--Wy�wietl wszystkie transakcje (TRANSACTIONS), kt�re mia�y miejsce w 2016 roku
--zwi�zane z kategori� JEDZENIE.

SELECT
	t.*,
	tc.category_name
FROM
	expense_tracker.transactions t
LEFT JOIN expense_tracker.transaction_category tc ON
	t.id_trans_cat = tc.id_trans_cat
WHERE
	EXTRACT( YEAR
FROM
	t.transaction_date ) = '2016'
	AND tc.category_name LIKE 'JEDZENIE';


--Modu� 7 - Zadanie 4
--Dodaj now� podkategori� do tabeli TRANSACTION_SUBCATEGORY, kt�ra b�dzie w relacji z kategori� (TRANSACTION_CATEGORY) JEDZENIE.
--Na podstawie wynik�w z zadania 3, dla wszystkich wierszy z kategorii jedzenie, kt�re nie
--maj� przypisanej podkategorii (-1) zaktualizuj warto�� podkategorii na now� dodan�.
--Mo�esz wykorzysta� dowoln� znan� Ci konstrukcj� (UPDATE / UPDATE + WITH / UPDATE + FROM / UPDATE + EXISTS).

INSERT INTO expense_tracker.transaction_subcategory (id_trans_cat, subcategory_name, subcategory_description) VALUES (1, 'Nowa podkategoria', 'Nowa podkategoria');
	   
WITH no_subcategories AS (
SELECT
	t.id_transaction,
	t.id_trans_subcat
FROM
	expense_tracker.transactions AS t
LEFT JOIN expense_tracker.transaction_category AS tc ON
	t.id_trans_cat = tc.id_trans_cat
LEFT JOIN expense_tracker.transaction_subcategory AS ts ON
	t.id_trans_subcat = ts.id_trans_subcat
	AND tc.id_trans_cat = ts.id_trans_cat
WHERE
	EXTRACT( YEAR
FROM
	t.transaction_date ) = '2016'
	AND tc.category_name LIKE 'JEDZENIE'
	AND t.id_trans_subcat = -1 )

	
UPDATE
	expense_tracker.transactions AS t SET
	id_trans_subcat = (
	SELECT
		ts.id_trans_subcat
	FROM
		expense_tracker.transaction_subcategory AS ts
	WHERE
		ts.subcategory_name = 'Nowa podkategoria' )
WHERE
	EXISTS (
	SELECT
		*
	FROM
		no_subcategories AS ns
	WHERE
		t.id_transaction = ns.id_transaction) RETURNING *;


--Modu� 7 - Zadanie 5
--Wy�wietl wszystkie transakcje w roku 2020 dla konta oszcz�dno�ciowego Janusz i Gra�ynka.
--W wynikach wy�wietl informacje o:
	--nazwie kategorii,
	--nazwie podkategorii,
	--typie transakcji,
	--dacie transakcji
	--warto�ci transakcji.

SELECT
	tc.category_name,
	ts.subcategory_name,
	tt.transaction_type_name,
	t.transaction_date,
	t.transaction_value
FROM
	(expense_tracker.bank_account_owner bao
LEFT JOIN expense_tracker.transaction_bank_accounts tba ON
	bao.id_ba_own = tba.id_ba_own
LEFT JOIN expense_tracker.bank_account_types bat ON
	tba.id_ba_typ = bat.id_ba_type
LEFT JOIN expense_tracker.transactions t ON
	tba.id_trans_ba = t.id_trans_ba)
LEFT JOIN expense_tracker.transaction_category tc ON
	t.id_trans_cat = tc.id_trans_cat
LEFT JOIN expense_tracker.transaction_subcategory ts ON
	t.id_trans_subcat = ts.id_trans_subcat AND tc.id_trans_cat = ts.id_trans_cat 
LEFT JOIN expense_tracker.transaction_type tt ON
	t.id_trans_type = tt.id_trans_type
WHERE
	bao.owner_name = 'Janusz i Gra�ynka'
	AND bat.ba_type LIKE '%OSZCZ%'
	AND EXTRACT (YEAR
FROM
	t.transaction_date) = '2020';

	