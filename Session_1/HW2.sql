-- Stratascratch 10568

with
    date_generated as (
        select cast(
                generate_series (
                    cast('2025-04-15' as date), cast('2025-04-28' as date), cast('1 day' as interval)
                ) as date
            ) dated
    ),
    net_revenue as (
        select p.transaction_date, (
                p.amount + coalesce(r.amount, 0)
            ) as Transaction
        from
            product_sales p
            LEFT JOIN product_sales r ON p.transaction_id = r.original_transaction_id
        WHERE
            p.type = 'purchase'
            AND p.product_id = 'PROD-2891'
            AND p.status = 'completed'
            AND p.country = 'US'
    )
select
    d.dated as transaction_date,
    coalesce(SUM(n.Transaction), 0) as daily_net_revenue
from
    net_revenue n
    RIGHT JOIN date_generated d ON n.transaction_date = d.dated
GROUP BY
    d.dated
ORDER BY d.dated;