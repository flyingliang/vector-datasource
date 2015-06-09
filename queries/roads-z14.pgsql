SELECT
    way AS __geometry__,
    name,
    osm_id AS __id__,
    aeroway,
    bridge,
    highway,
    layer,
    railway,
    tunnel,
    oneway,
    %#tags AS tags

FROM planet_osm_line

WHERE
    mz_calculate_road_level(highway, railway, aeroway) <= 14
