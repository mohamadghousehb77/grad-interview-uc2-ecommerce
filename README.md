# SQL Assessment — E-Commerce Use Case

SQL Server / T-SQL. This repo has two folders:

```
schema/     -- object scripts: database, tables, views, stored procedures, functions
sql/        -- insert scripts: seed data for every table
```

---

## 1. Get set up

Welcome, and thanks for taking the time to work through this! No need
to fork anything — you already have access to this repository
directly. Just clone it and create your own branch to work on:

```bash
git clone https://github.com/jibin-pradeepkumar/grad-interview-uc2-ecommerce.git
cd grad-interview-uc2-ecommerce
git checkout -b candidate/<your-name>
```

Do all of your work on this branch, not on `master` — that keeps
everyone's work separate and makes it easy for us to review yours
specifically.

---

## 2. Run the scripts locally

You'll need SQL Server (Developer or Express edition is fine) and
either SQL Server Management Studio (SSMS) or Azure Data Studio.

Run the scripts in this exact order:

```
schema/create_database.sql     -- creates the GradInterviewSQL database
schema/create_tables.sql       -- creates all tables
sql/insert_data.sql            -- loads seed data
schema/views.sql               -- creates the provided (buggy) views
schema/stored_procedures.sql   -- creates the provided (buggy) procedure
schema/functions.sql           -- placeholder — you'll add a function here
```

Open each file in SSMS/Azure Data Studio and execute it top to bottom
against your local instance, in the order above — later scripts
depend on objects created by earlier ones. Each object script drops
its own objects before recreating them, so it's safe to re-run any
individual script if something goes wrong.

---

## 3. What's in the database

**Exercise 1 — Revenue by Region**
| Table | Purpose |
|---|---|
| `regions` | 4 sales regions (North/South/East/West) |
| `customers` | Customer master data, linked to a region |
| `orders` | Order header — note `customer_id` and `order_date` are both stored as text |
| `order_items` | Line items per order (quantity, unit price) |
| `product_promotions` | Which products currently have an active promotion |
| `blacklisted_customers` | Customers to exclude from revenue reporting |

**Exercise 2 — Nested Views** *(separate `nv_` tables; reuses `regions` above)*
| Table | Purpose |
|---|---|
| `nv_customers` | Customer master data for this exercise |
| `nv_orders` | Orders with a status column (ACTIVE/CANCELLED/REFUNDED/PENDING) |
| `nv_promotions` | Promo codes by customer |

**Exercise 3 — Customer Engagement Summary**
| Table | Purpose |
|---|---|
| `sales_reps` | Sales rep master data |
| `eng_customers` | Customers, some with incomplete name/email/rep data |
| `eng_orders` | Orders with a discount percentage and a status code |

**Exercise 4 — Weekend Offer Calendar**
No tables — this exercise is pure date logic.

---

## 4. The assessment

Four exercises. Exercises 1 and 2 give you existing code (in
`schema/`) that runs without error but produces incorrect business
results — you're debugging. Exercises 3 and 4 give you only the
schema and a requirement — you're building from scratch.

For every exercise, submit:
- Your final SQL (corrected or newly written).
- A short written explanation of what you found and why your fix is
  correct — for debugging exercises, explain root cause, not just
  what you changed.
- The queries you ran along the way to test your assumptions. We
  care about your process, not just the final answer.

### Exercise 1 — Revenue by Region
**Object:** `get_revenue_by_region_foramonth` (in `schema/stored_procedures.sql`)

```sql
EXEC get_revenue_by_region_foramonth '202406';
EXEC get_revenue_by_region_foramonth '202412';
EXEC get_revenue_by_region_foramonth '202401';
```

**Bug report:** Finance has flagged that the monthly regional revenue
numbers from this procedure don't look right — the numbers seem off
compared to what they're seeing in the source system.

**Requirement:** The procedure should return total revenue by region
for whichever month is passed in as `@yearmonth` (format `YYYYMM`).
Revenue should:
- Include every order placed by a valid, non-blacklisted customer.
- Only count line items for products currently under an active promotion.
- Be grouped by region, sorted alphabetically by region name.

Find out what's actually wrong and fix it.

### Exercise 2 — Region Revenue Report (Nested Views)
**Objects:** `vw_active_orders`, `vw_customer_promotions`,
`vw_order_with_promo`, `vw_region_revenue_report` (all in `schema/views.sql`)

```sql
SELECT * FROM vw_region_revenue_report;
```

**Requirement:** `vw_region_revenue_report` should show total revenue
by region across **all** orders, regardless of status — active,
cancelled, refunded, and pending orders should all count toward the
total.

The view runs and returns a row for every region, but the numbers are
wrong. There are multiple layers of views underneath it — don't
assume the top-level view is where the problem lives.

### Exercise 3 — Customer Engagement Summary
**Tables:** `sales_reps`, `eng_customers`, `eng_orders`
No procedure is provided. Add `get_customer_engagement_summary` to
your own copy of `schema/stored_procedures.sql`.

**Requirement:** Write a stored procedure that returns either one of the below 2 result sets based on the **parameter**:

1. **Rep-level summary** — one row per sales rep, showing:
   - Rep name
   - Number of customers assigned to that rep
   - Average order discount percentage across that rep's customers' orders

2. **Customer roster** — one row per customer/order combination, showing:
   - Customer ID
   - Full name
   - A human-readable order status label
   - Email address

**Constraints:**
- Every real customer must appear in the rep-level summary, including
  customers not yet assigned to a rep (show them under "Unassigned"
  rather than omitting them).
- Every order status code present in the data must produce a readable
  label — nothing should come out blank.
- Every customer's full name must display correctly, regardless of
  which name fields are populated.
- The average discount and customer counts must match what you'd get
  by manually cross-checking against the raw tables.

### Exercise 4 — Weekend Offer Calendar
No tables involved — pure date logic. No function is provided. Add
`fn_generate_calendar` to your own copy of `schema/functions.sql`, and
`get_weekend_offer_calendar` to `schema/stored_procedures.sql`.

**Requirement:** Build two objects from scratch:

1. **`fn_generate_calendar(@start_date DATE, @end_date DATE)`** — an
   inline table-valued function returning one row per calendar day
   from `@start_date` to `@end_date`, inclusive of both endpoints.

2. **`get_weekend_offer_calendar(@start_date DATE, @end_date DATE)`**
   — a stored procedure using the function above to return, for every
   day in the range: the date, the day-of-week name, and a flag for
   whether that day should show a weekend promotional offer
   (Saturday and Sunday only).

**Constraints:**
- The result must include the first and last day of the requested range.
- The weekend flag must correctly identify Saturday and Sunday
  regardless of any session- or server-level date configuration.
- Test across at least one full month and check the weekend flag
  count against a real calendar before submitting.

---


## 7. Submitting Your Answers

All answer scripts go in a zipped folder named <yourfullname>.zip organized like this and to be sent via email:
combining both the assignments
```
<yourfullname-email>
└──grad-interview-uc1-investment-banking/
   └── answers/
        ├── part_a/
        │   ├── q01_portfolio_value_usd.sql
        │   ├── q02_advisor_changes_2025.sql
        │   ├── q03_sector_change_while_held.sql
        │   ├── q04_kyc_expired_transactions.sql
        │   ├── q05_delisted_holdings.sql
        │   ├── q06_fifo_realized_pnl.sql
        │   ├── q07_top_10_gainers_90d.sql
        │   ├── q08_stale_prices.sql
        │   ├── q09_negative_holdings.sql
        │   ├── q10_circular_transfers.sql
        │   ├── q11_advisor_aum_trend.sql
        │   ├── q12_pre_spike_purchases.sql
        │   ├── q13_weighted_avg_purchase_price.sql
        │   ├── q14_advisor_growth_ranking.sql
        │   └── q15_advisor_switch_decline.sql
        ├── part_b/
        │   ├── b1_advisor_commissions_aug2025.sql
        │   ├── b2_portfolio_value_31aug2025.sql
        │   ├── b3_valuation_methodology_notes.md   (short written explanation, item 3 in Section 6)
        │   └── b4_usd_reporting_check.sql
        └── Notes-investment-banking.md                                (your assumptions log, one line per question)
└──grad-interview-uc2-ecommerce/  
   └── answers/
        ├── part_a/
        │   ├── ex01_get_revenue_by_region_foramonth.sql
        │   ├── ex02_vw_region_revenue_report.sql
        │   ├── ex03_sector_change_while_held.sql
        │   └── ex04_fns_weekendoffercalendar.sql
        └──Notes-ecommerce.md
```

That's it — good luck, and don't hesitate to ask if anything about
the setup itself is unclear.

---

## General notes

- Code that "runs without error" is not the same as code that's
  correct here. Several exercises are specifically designed so that
  plausible-looking output can still be wrong — verify against the
  actual data, don't just trust that it compiled.
- Partial credit is given for a correct, well-evidenced diagnosis even
  without a complete fix.