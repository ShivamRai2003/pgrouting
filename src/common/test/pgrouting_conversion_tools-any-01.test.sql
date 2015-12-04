/*PGR-GNU*****************************************************************

Copyright (c) 2015 pgRouting developers
Mail: project@pgrouting.org

------

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.

********************************************************************PGR-GNU*/
BEGIN;
\echo '---- pgr_pointtoedgenode ----'
select pgr_pointtoedgenode('edge_table', 'POINT(2 0)'::geometry, 0.02);
select pgr_pointtoedgenode('edge_table', 'POINT(3 2)'::geometry, 0.02);

\echo '---- pgr_flipedges ----'
select st_astext(e) from (select unnest(pgr_flipedges(ARRAY[
'LINESTRING(2 1,2 2)'::geometry,
'LINESTRING(2 2,2 3)'::geometry,
'LINESTRING(2 2,2 3)'::geometry,
'LINESTRING(2 2,3 2)'::geometry,
'LINESTRING(3 2,4 2)'::geometry,
'LINESTRING(4 1,4 2)'::geometry,
'LINESTRING(3 1,4 1)'::geometry,
'LINESTRING(2 1,3 1)'::geometry,
'LINESTRING(2 0,2 1)'::geometry,
'LINESTRING(2 0,2 1)'::geometry]::geometry[])) as e) as foo;

\echo '---- pgr_texttopoints ----'
select st_astext(g) from (select unnest(pgr_texttopoints('0,0;1,1;1,0;0,1;1,4;1,5;0,4;0,5', 0)) as g) as foo;

\echo '---- pgr_pointstovids ----'
select * from pgr_pointstovids(pgr_texttopoints('2,0;2,1;3,1;2,2;4,1;4,2;2,3;3,2', 0), 'edge_table');
ROLLBACK;
