SELECT
    __id__,
    __geometry__,
    name,
    abbr_name,
    country_name,
    population
FROM
(
    -- The 10m country borders table contains some large, highly detailed
    -- polygons that take long to intersect, simplify, etc.; as a result, we
    -- need to do a lot of work even if only a sliver of one such polygon
    -- intersects a tile's bounding box. To reduce it, we tiled up the dataset
    -- using the `mz_SplitIntoTiles()` function defined in
    -- `../data/split_to_tiles.sql`, which partitions the polygons along a
    -- uniform grid and thus allows us to operate on large geometries in
    -- discrete chunks. Since we might receive multiple such tiles back that
    -- were created from the same original polygon, we need to group them
    -- by `original_gid`, union the geometries, and somehow aggregate the name,
    -- population, etc. fields (note that they'll by definition have the same
    -- value), so we just use max().
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
