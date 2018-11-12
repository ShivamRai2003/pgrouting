/*PGR-GNU*****************************************************************
File: pgr_minCostMaxFlow_Cost.sql

Generated with Template by:
Copyright (c) 2016 pgRouting developers
Mail: project@pgrouting.org

Function's developer:
Copyright (c) 2018 Maoguang Wang
Mail: xjtumg1007@gmail.com

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

----------------------------
-- pgr_minCostMaxFlow_Cost
----------------------------

--    ONE TO ONE
CREATE OR REPLACE FUNCTION pgr_minCostMaxFlow_Cost(
    TEXT,   -- edges_sql (required)
    BIGINT,   -- source (required)
    BIGINT)   -- target (required)
RETURNS FLOAT AS
$BODY$
    SELECT cost
    FROM _pgr_minCostMaxFlow(_pgr_get_statement($1), ARRAY[$2]::BIGINT[], ARRAY[$3]::BIGINT[], only_cost := true);
$BODY$
LANGUAGE SQL VOLATILE;

--    ONE TO MANY
CREATE OR REPLACE FUNCTION pgr_minCostMaxFlow_Cost(
    TEXT,   -- edges_sql (required)
    BIGINT,   -- source (required)
    ANYARRAY) -- targets (required)
RETURNS FLOAT AS
$BODY$
    SELECT cost
    FROM _pgr_minCostMaxFlow(_pgr_get_statement($1), ARRAY[$2]::BIGINT[], $3::BIGINT[], only_cost := true);
$BODY$
LANGUAGE SQL VOLATILE;

--    MANY TO ONE
CREATE OR REPLACE FUNCTION pgr_minCostMaxFlow_Cost(
    TEXT,   -- edges_sql (required)
    ANYARRAY, -- sources (required)
    BIGINT)   -- target (required)
RETURNS FLOAT AS
$BODY$
    SELECT cost
    FROM _pgr_minCostMaxFlow(_pgr_get_statement($1), $2::BIGINT[], ARRAY[$3]::BIGINT[], only_cost := true);
$BODY$
LANGUAGE SQL VOLATILE;


--    MANY TO MANY
CREATE OR REPLACE FUNCTION pgr_minCostMaxFlow_Cost(
    TEXT,   -- edges_sql (required)
    ANYARRAY, -- sources (required)
    ANYARRAY) -- targets (required)
RETURNS FLOAT AS
$BODY$
    SELECT cost
    FROM _pgr_minCostMaxFlow(_pgr_get_statement($1), $2::BIGINT[], $3::BIGINT[], only_cost := true);
$BODY$
LANGUAGE SQL VOLATILE;

-- COMMENTS

COMMENT ON FUNCTION pgr_minCostMaxFlow_Cost(TEXT, BIGINT, BIGINT)
IS 'EXPERIMENTAL pgr_minCostMaxFlow_Cost--One to One--(edges_sql(id,source,target,cost[,reverse_cost]), from_vid, to_vid';
COMMENT ON FUNCTION pgr_minCostMaxFlow_Cost(TEXT, BIGINT, ANYARRAY)
IS 'EXPERIMENTAL pgr_minCostMaxFlow_Cost--One to Many--(edges_sql(id,source,target,cost[,reverse_cost]), from_vid, to_vids';
COMMENT ON FUNCTION pgr_minCostMaxFlow_Cost(TEXT, ANYARRAY, BIGINT)
IS 'EXPERIMENTAL pgr_minCostMaxFlow_Cost--Many to One--(edges_sql(id,source,target,cost[,reverse_cost]), from_vids, to_vid';
COMMENT ON FUNCTION pgr_minCostMaxFlow_Cost(TEXT, ANYARRAY, ANYARRAY)
IS 'EXPERIMENTAL pgr_minCostMaxFlow_Cost--Many to Many--(edges_sql(id,source,target,cost[,reverse_cost]), from_vids, to_vids';