select
    pin,
    firstname,
    lastname,
    birthdate,
    sex,
    civil
from {{ source('raw', 'raw_patient') }}