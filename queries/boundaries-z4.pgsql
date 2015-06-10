SELECT
    __id__,
    __geometry__,
    name,
    abbr_name,
    country_name,
    population
FROM
(
    SELECT
        gid as __id__,
        name_long as name,
        name_long::text as country_name,
        adm0_a3 as abbr_name,
        pop_est as population,
        the_geom as __geometry__,
        'country' as type
    FROM
        ne_50m_country_borders
    WHERE the_geom && !bbox!

    UNION

    SELECT
        gid as __id__,
        name,
        admin::text as country_name,
        abbrev as abbr_name,
        NULL as population,
        the_geom as __geometry__,
        'state' as type
    FROM
        -- The 50m state dataset contains states only for the US, Canada, and
        -- some other countries, while the 10m version covers the entire
        -- planet, so we'll opt for the 10m dataset even though we typically
        -- use 50m at this zoom level.
        ne_10m_state_borders
    WHERE the_geom && !bbox!
) as boundaries
