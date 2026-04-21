select
    chno,
    pin,
    date,
    amount
from {{ source('raw', 'raw_charges') }}