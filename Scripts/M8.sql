/*********************************************************************************************************************************/
/************************************************************* MODUL 8 ***********************************************************/
/*********************************************************************************************************************************/

--Modu³ 8 - Zadanie 1    
--Oblicz sumê transakcji w podziale na kategorie transakcji. W wyniku wyœwietl nazwê kategorii i ca³kowit¹ sumê.

SELECT
	tc.category_name,
	sum(t.transaction_value) AS sum_per_category,
	(
	SELECT
		sum(t1.transaction_value)
	FROM
		expense_tracker.transactions t1) AS total_sum
FROM
	expense_tracker.transactions t
LEFT JOIN expense_tracker.transaction_category tc ON
	t.id_trans_cat = tc.id_trans_cat
GROUP BY
	tc.category_name
ORDER BY
	tc.category_name ASC;


--Modu³ 8 - Zadanie 2
--Oblicz sumê wydatków na U¿ywki dokonana przez Janusza (Janusz Kowalski) z jego 
--konta prywatnego (ROR - Janusz) w obecnym roku 2020.

SELECT
	tc.category_name,
	sum(t.transaction_value) AS sum_per_category
FROM
	expense_tracker.transactions t
INNER JOIN expense_tracker.transaction_category tc ON
	t.id_trans_cat = tc.id_trans_cat
INNER JOIN expense_tracker.transaction_bank_accounts tba ON
	t.id_trans_ba = tba.id_trans_ba
INNER JOIN expense_tracker.bank_account_owner bao ON
	tba.id_ba_own = bao.id_ba_own
WHERE
	tc.category_name = 'U¯YWKI'
	AND tba.bank_account_name = 'ROR - Janusz'
	AND bao.owner_name = 'Janusz Kowalski'
	AND (EXTRACT (YEAR
FROM
	t.transaction_date)) = (EXTRACT(YEAR
FROM
	current_date))
GROUP BY
	tc.category_name
ORDER BY
	tc.category_name ASC;

--czy lepsz¹ praktyk¹ jest u¿ywanie ograniczeñ w ON ni¿ w WHERE?

SELECT
	tc.category_name,
	sum(t.transaction_value) AS sum_per_category
FROM
	expense_tracker.transactions t
INNER JOIN expense_tracker.transaction_category tc ON
	t.id_trans_cat = tc.id_trans_cat
	AND tc.category_name = 'U¯YWKI'
	AND (EXTRACT (YEAR
FROM
	t.transaction_date)) = (EXTRACT(YEAR
FROM
	current_date))
INNER JOIN expense_tracker.transaction_bank_accounts tba ON
	t.id_trans_ba = tba.id_trans_ba
	AND tba.bank_account_name = 'ROR - Janusz'
INNER JOIN expense_tracker.bank_account_owner bao ON
	tba.id_ba_own = bao.id_ba_own
	AND bao.owner_name = 'Janusz Kowalski'
GROUP BY
	tc.category_name
ORDER BY
	tc.category_name ASC;


--Modu³ 8 - Zadanie 3
--Stwórz zapytanie, które bêdzie podsumowywaæ wydatki (typ transakcji: Obci¹¿enie) na
--wspólnym koncie RoR - Janusza i Gra¿ynki w taki sposób, aby widoczny by³ podzia³
--sumy wydatków, ze wzglêdu na rok, rok i kwarta³ (format: 2019_1), rok i miesi¹c (format:2019_12) w roku 2019. 
--Skorzystaj z funkcji ROLLUP.

SELECT
	EXTRACT (YEAR
FROM
	t.transaction_date) AS transaction_year,
	(EXTRACT (YEAR
FROM
	t.transaction_date) || '_' ||(EXTRACT (QUARTER
FROM
	t.transaction_date)))AS year_quarter,
	(EXTRACT (YEAR
FROM
	t.transaction_date) || '_' ||(EXTRACT (MONTH
FROM
	t.transaction_date))) AS year_month,
	GROUPING (EXTRACT (YEAR
FROM
	t.transaction_date),
	(EXTRACT (YEAR
FROM
	t.transaction_date) || '_' ||(EXTRACT (QUARTER
FROM
	t.transaction_date))),
	(EXTRACT (YEAR
FROM
	t.transaction_date) || '_' ||(EXTRACT (MONTH
FROM
	t.transaction_date))) ) AS row_group,
	sum(t.transaction_value) AS sum_per_type
FROM
	expense_tracker.transactions t
INNER JOIN expense_tracker.transaction_type tp ON
	t.id_trans_type = tp.id_trans_type
INNER JOIN expense_tracker.transaction_bank_accounts tba ON
	t.id_trans_ba = tba.id_trans_ba
WHERE
	tp.transaction_type_name = 'Obci¹¿enie'
	AND tba.bank_account_name = 'ROR - Janusz i Gra¿ynka'
	AND (EXTRACT (YEAR
FROM
	t.transaction_date)) = 2019
GROUP BY
	ROLLUP (EXTRACT (YEAR
FROM
	t.transaction_date),
	(EXTRACT (YEAR
FROM
	t.transaction_date) || '_' ||(EXTRACT (QUARTER
FROM
	t.transaction_date))),
	(EXTRACT (YEAR
FROM
	t.transaction_date) || '_' ||(EXTRACT (MONTH
FROM
	t.transaction_date))))
ORDER BY
	row_group ASC,
	year_quarter ASC,
	year_month ASC;


--Modu³ 8 - Zadanie 4
--Stwórz zapytanie podsumowuj¹ce sumê wydatków na koncie wspólnym Janusza i
--Gra¿ynki (ROR - Wspólny), wydatki (typ: Obci¹¿enie), w podziale na poszczególne lata
--od roku 2015 wzwy¿. Do wyników (rok, suma wydatków) dodaj korzystaj¹c z funkcji
--okna atrybut, który bêdzie ró¿nic¹ pomiêdzy danym rokiem a poprzednim (balans rok do roku).

WITH yearly_sales AS (
SELECT
	EXTRACT(YEAR
FROM
	t.transaction_date) AS sales_year,
	sum(t.transaction_value) AS total_sum
FROM
	expense_tracker.transactions t
INNER JOIN expense_tracker.transaction_type tp ON
	t.id_trans_type = tp.id_trans_type
INNER JOIN expense_tracker.transaction_bank_accounts tba ON
	t.id_trans_ba = tba.id_trans_ba
INNER JOIN expense_tracker.bank_account_types bat ON
	tba.id_ba_typ = bat.id_ba_type
WHERE
	tp.transaction_type_name = 'Obci¹¿enie'
	AND bat.ba_type = 'ROR - WSPÓLNY'
	AND (EXTRACT (YEAR
FROM
	t.transaction_date)) >= 2015
GROUP BY
	EXTRACT (YEAR
FROM
	t.transaction_date)),
previous AS(
SELECT
	*,
	LAG(ys.total_sum) OVER (
ORDER BY
	ys.sales_year) AS previous_sales_year
FROM
	yearly_sales AS ys)
SELECT
	sales_year,
	total_sum,
	previous_sales_year,
	previous_sales_year - total_sum AS balance
FROM
	previous;


--Modu³ 8 - Zadanie 5
--Korzystaj¹c z funkcji LAST_VALUE poka¿ ró¿nicê w dniach, pomiêdzy kolejnymi
--transakcjami (Obci¹¿enie) na prywatnym koncie Janusza (RoR) dla podkategorii
--Technologie w 1 kwartale roku 2020.

WITH Janusz_2020_1 AS (
SELECT
	t.id_transaction,	
	bat.ba_type,
	tba.bank_account_name,
	t.transaction_date
FROM
	expense_tracker.transactions t
INNER JOIN expense_tracker.transaction_type tp ON
	t.id_trans_type = tp.id_trans_type
INNER JOIN expense_tracker.transaction_bank_accounts tba ON
	t.id_trans_ba = tba.id_trans_ba
INNER JOIN expense_tracker.bank_account_types bat ON
	tba.id_ba_typ = bat.id_ba_type
INNER JOIN expense_tracker.transaction_subcategory ts ON
	t.id_trans_subcat = ts.id_trans_subcat
WHERE
	tp.transaction_type_name = 'Obci¹¿enie'
	AND bat.ba_type = 'ROR'
	AND tba.bank_account_name = 'ROR - Janusz'
	AND ts.subcategory_name = 'Technologie'
	AND (EXTRACT (YEAR
FROM
	t.transaction_date)) || '_' || (EXTRACT (QUARTER
FROM
	t.transaction_date)) = '2020_1')
SELECT
	*,
	FIRST_VALUE (j.transaction_date) OVER (
	ORDER BY j.transaction_date GROUPS BETWEEN CURRENT ROW AND 1 FOLLOWING EXCLUDE CURRENT ROW) AS next_transaction_date,
	FIRST_VALUE (j.transaction_date) OVER (
	ORDER BY j.transaction_date GROUPS BETWEEN CURRENT ROW AND 1 FOLLOWING EXCLUDE CURRENT ROW) - j.transaction_date AS difference_between_transactions_dates
FROM
	Janusz_2020_1 j;