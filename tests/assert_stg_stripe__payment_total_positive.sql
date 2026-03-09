-- All payments should have a positive total amount. Refunds are represented as negative amounts, but the total amount of a payment should be positive.
select
    order_id,
    sum(amount) as total_amount
from {{ ref('stg_stripe__payments') }}
group by 1
having total_amount < 0