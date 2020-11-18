/*********************************************************************************************************************************/
/************************************************************* MODUL 7 ***********************************************************/
/*********************************************************************************************************************************/

--Modu³ 7 - Zadanie 1
--Wyœwietl wszystkie informacje o koncie:
	--nazwa w³aœcieciela (owner_name)
	--opis w³aœciciela (owner_desc)
	--typ konta (ba_type)
	--opis konta (ba_desc)
	--flaga czy jest aktywne (active)
	--nazwa konta bankowego (bank_account_name)
	--razem z u¿ytkownikiem (user_login), który jest do niego przypisany. Dla w³aœciciela, jakim jest Janusz Kowalski.

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


--Modu³ 7 - Zadanie 2
--Wyœwietl wszystkie informacje o dostêpnych kategoriach transakcji i ich mo¿liwych podkategoriach.
--W obu przypadkach powinny to byæ tylko "aktywne" elementy (active TRUE / 1 / Y / y :)).
--W wyniku wyœwietl 2 atrybuty, nazwa kategorii i nazwa podkategorii, dane posortuj po
--identyfikatorze kategorii rosn¹co.

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


--Modu³ 7 - Zadanie 3
--Wyœwietl wszystkie transakcje (TRANSACTIONS), które mia³y miejsce w 2016 roku
--zwi¹zane z kategori¹ JEDZENIE.

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


--Modu³ 7 - Zadanie 4
--Dodaj now¹ podkategoriê do tabeli TRANSACTION_SUBCATEGORY, która bêdzie w relacji z kategori¹ (TRANSACTION_CATEGORY) JEDZENIE.
--Na podstawie wyników z zadania 3, dla wszystkich wierszy z kategorii jedzenie, które nie
--maj¹ przypisanej podkategorii (-1) zaktualizuj wartoœæ podkategorii na now¹ dodan¹.
--Mo¿esz wykorzystaæ dowoln¹ znan¹ Ci konstrukcjê (UPDATE / UPDATE + WITH / UPDATE + FROM / UPDATE + EXISTS).

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


--Modu³ 7 - Zadanie 5
--Wyœwietl wszystkie transakcje w roku 2020 dla konta oszczêdnoœciowego Janusz i Gra¿ynka.
--W wynikach wyœwietl informacje o:
	--nazwie kategorii,
	--nazwie podkategorii,
	--typie transakcji,
	--dacie transakcji
	--wartoœci transakcji.

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
	bao.owner_name = 'Janusz i Gra¿ynka'
	AND bat.ba_type LIKE '%OSZCZ%'
	AND EXTRACT (YEAR
FROM
	t.transaction_date) = '2020';

	