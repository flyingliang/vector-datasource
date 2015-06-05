SELECT
    __id__,
    __geometry__
FROM
(
    SELECT
        1 as __id__,
        st_union(the_geom) as __geometry__
    FROM
        ne_10m_country_borders_tiles
    WHERE the_geom && !bbox!
    GROUP BY original_gid

    UNION

    SELECT
        gid as __id__,
        the_geom as __geometry__
    FROM
        ne_10m_state_borders
    WHERE the_geom && !bbox!
) as boundaries
