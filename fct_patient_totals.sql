with charges_summary as (
    select
        pin,
        sum(amount) as total_charges,
        count(*) as claim_count
    from {{ ref('stg_charges') }}
    group by pin
)

select
    p.pin,
    p.firstname,
    p.lastname,
    p.sex,
    coalesce(c.total_charges, 0) as total_charges,
    coalesce(c.claim_count, 0) as claim_count
from {{ ref('stg_patient') }} p
left join charges_summary c on p.pin = c.pin