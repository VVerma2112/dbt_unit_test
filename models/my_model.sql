SELECT

    users.user_id
    , users.email

    , COALESCE (REGEXP_LIKE(users.email,
        '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$') = TRUE
        AND accepted_email_domains.tld IS NOT NULL, FALSE) AS is_valid_email_address

FROM {{ ref('users') }} AS users

LEFT JOIN {{ ref('top_level_domains') }} AS accepted_email_domains
    ON users.email_top_level_domain = LOWER(accepted_email_domains.tld)