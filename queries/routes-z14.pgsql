SELECT
    osm_id AS __id__,
    way AS __geometry__,
    name,
    ref,
    operator,
    route,
    tags->'type' AS type,
    tags->'colour' AS colour,
    tags->'network' AS network,
    tags->'state' AS state,
    tags->'symbol' AS symbol,
    tags->'description' AS description,
    tags->'distance' AS distance,
    tags->'ascent' AS ascent,
    tags->'descent' AS descent,
    tags->'roundtrip' AS roundtrip,
    tags->'route_name' AS route_name

FROM planet_osm_line

WHERE route is not NULL
