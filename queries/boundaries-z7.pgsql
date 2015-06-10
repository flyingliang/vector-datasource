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
        original_gid as __id__,
        max(name_long) as name,
        max(name_long)::text as country_name,
        max(adm0_a3) as abbr_name,
        max(pop_est) as population,
        st_union(the_geom) as __geometry__,
        'country' as type
    FROM
        ne_10m_country_borders_tiles
    WHERE the_geom && !bbox!
    GROUP BY original_gid

    UNION

    SELECT
        gid as __id__,
        name,
        admin as country_name,
        abbrev as abbr_name,
        NULL as population,
        the_geom as __geometry__,
        'state' as type
    FROM
        ne_10m_state_borders
    WHERE the_geom && !bbox!
) as boundaries
