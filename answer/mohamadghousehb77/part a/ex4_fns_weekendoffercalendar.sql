USE GradInterviewSQL;
GO

CREATE OR ALTER FUNCTION fn_generate_calendar
(
    @start_date DATE,
    @end_date DATE
)
RETURNS TABLE
AS
RETURN
(
    SELECT
        DATEADD(
            DAY,
            n,
            @start_date
        ) AS calendar_date
    FROM
    (
        SELECT TOP
            (CASE
                WHEN @start_date <= @end_date
                    THEN DATEDIFF(DAY, @start_date, @end_date) + 1
                ELSE 0
             END)
            ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) - 1 AS n
        FROM sys.all_objects a
        CROSS JOIN sys.all_objects b
    ) d
);
GO


CREATE OR ALTER PROCEDURE get_weekend_offer_calendar
    @start_date DATE,
    @end_date DATE
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        c.calendar_date,
        CASE
            WHEN ((DATEDIFF(DAY, '19000101', c.calendar_date) % 7 + 7) % 7) = 0
                THEN 'Monday'
            WHEN ((DATEDIFF(DAY, '19000101', c.calendar_date) % 7 + 7) % 7) = 1
                THEN 'Tuesday'
            WHEN ((DATEDIFF(DAY, '19000101', c.calendar_date) % 7 + 7) % 7) = 2
                THEN 'Wednesday'
            WHEN ((DATEDIFF(DAY, '19000101', c.calendar_date) % 7 + 7) % 7) = 3
                THEN 'Thursday'
            WHEN ((DATEDIFF(DAY, '19000101', c.calendar_date) % 7 + 7) % 7) = 4
                THEN 'Friday'
            WHEN ((DATEDIFF(DAY, '19000101', c.calendar_date) % 7 + 7) % 7) = 5
                THEN 'Saturday'
            WHEN ((DATEDIFF(DAY, '19000101', c.calendar_date) % 7 + 7) % 7) = 6
                THEN 'Sunday'
        END AS day_of_week_name,

        CASE
            WHEN ((DATEDIFF(DAY, '19000101', c.calendar_date) % 7 + 7) % 7) IN (5, 6)
                THEN 'Y'
            ELSE 'N'
        END AS weekend_offer

    FROM fn_generate_calendar(@start_date, @end_date) c
    ORDER BY c.calendar_date;
END;
GO


EXEC get_weekend_offer_calendar
    '2026-08-01',
    '2026-08-31';