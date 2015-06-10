SELECT
    gid as __id__,
    name_long as name,
    name_long as country_name,
    adm0_a3 as abbr_name,
    pop_est as population,
    the_geom as __geometry__,
    'country' as type
FROM
    ne_110m_country_borders
