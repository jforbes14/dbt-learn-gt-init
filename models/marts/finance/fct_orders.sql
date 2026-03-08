with payments as (
    select * from {{ ref('stg_stripe__payments') }}
),

orders as (
    select * from {{ ref('stg_jaffle_shop__orders') }}
),

order_payments as (
    select
        order_id,
        sum(case when status = 'success' then amount else 0 end) as amount
    from payments
    group by 1
)

select
    o.order_id,
    o.customer_id,
    o.order_date,
    p.amount
from orders o
left join order_payments p
on o.order_id = p.order_id
