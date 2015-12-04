BEGIN;
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
--              PGR_apspJohnson
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
SELECT seq, id1 AS FROM, id2 AS to, cost
    FROM pgr_apspJohnson(
        'SELECT source, target, cost FROM edge_table order by id'
    ) limit 10; 
ROLLBACK;
