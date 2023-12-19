/*
1. For data safety, only SELECT statements are allowed
2. Results have been capped at 200 rows
*/
WITH deleted_single_account AS
(
    SELECT id, account_type
    FROM affirm_account
    WHERE action='created'
    AND id IN (
            SELECT DISTINCT id
        FROM affirm_account
        WHERE action= 'deleted'
        AND date BETWEEN '2021-08-01' AND '2021-08-31'
    )
    AND account_type IN ('checking', 'saving')
),

potential_deleted_both_account AS (
    SELECT id, account_type
    FROM affirm_account
    WHERE action='created'
    AND id IN (
            SELECT DISTINCT id
        FROM affirm_account
        WHERE action= 'deleted'
        AND date BETWEEN '2021-08-01' AND '2021-08-31'
    )
    AND account_type = 'both'
),
deleted_both_account AS (
    SELECT id
    FROM affirm_account
    WHERE ID IN (
        SELECT id
        FROM potential_deleted_both_account
    )
    AND action='deleted'
    GROUP BY id
    HAVING COUNT(*) = 2 -- Deleted both 'checking' and 'saving' account;
)

SELECT COUNT(*) FROM (
    SELECT id
    FROM deleted_single_account
    UNION
    SELECT id
    FROM deleted_both_account
) X;
