SELECT
    __id__,
    __geometry__
FROM
(
    SELECT
        gid as __id__,
        the_geom as __geometry__
    FROM
        ne_50m_country_borders
    WHERE the_geom && !bbox!

    UNION

    SELECT
        gid as __id__,
        the_geom as __geometry__
    FROM
        ne_50m_state_borders
    WHERE the_geom && !bbox!
) as boundaries
