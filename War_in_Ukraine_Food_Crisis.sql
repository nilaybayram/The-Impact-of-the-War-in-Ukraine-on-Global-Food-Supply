--The queries have been written to find out the impact of the war in Ukraine on global food supply. 
--The dataset has been gathered from:https://ourworldindata.org/ukraine-russia-food
--Dataset has been cleaned on excel and then imported to Oracle Sql Developer as 4 different tables.

--Finding Exporters

--Top Barley Exporters

SELECT
    country,
    SUM(barley_exports) AS barley_exports
FROM
    barley
GROUP BY
    country
ORDER BY
    2 DESC;

--Top Maize Exporters

SELECT
    country,
    SUM(maize_exports) AS maize_exports
FROM
    maize
GROUP BY
    country
ORDER BY
    2 DESC;

--Top Sunflower Oil Exporters

SELECT
    country,
    SUM(sunflower_oil_exports) AS sunflower_oil_exports
FROM
    sunflower
GROUP BY
    country
ORDER BY
    2 DESC;

--Top Wheat Exporters

SELECT
    country,
    SUM(wheat_exports) AS wheat_exports
FROM
    wheat
GROUP BY
    country
ORDER BY
    2 DESC;
    
--Finding Importers
--Top Wheat Importers

SELECT
    country,
    SUM(maize_imports) AS maize_imports,
    SUM(maize_imports_from_russia_in_imports),
    SUM(maize_imports_from_russia)
FROM
    maize
GROUP BY
    country
ORDER BY
    3 DESC;

--Join the four tables 

SELECT
    *
FROM
    barley
    LEFT JOIN maize ON barley.country = maize.country
                       AND barley.year_ = maize.year_
    LEFT JOIN sunflower ON barley.country = sunflower.country
                           AND barley.year_ = sunflower.year_
    LEFT JOIN wheat ON barley.country = wheat.country
                       AND barley.year_ = wheat.year_;

--Summary Table
SELECT
    round(SUM(barley.barley_imports_from_ukraine) / SUM(barley.barley_exports) * 100, 3)                     AS ukraine_share_global_barley_exports_pc,
    round(SUM(barley.barley_imports_from_russia) / SUM(barley.barley_exports) * 100, 3)                      AS russia_share_global_barley_exports_pc,
    round(SUM(maize.maize_imports_from_ukraine) / SUM(maize.maize_exports) * 100, 3)                         AS ukraine_share_global_maize_exports_pc,
    round(SUM(maize.maize_imports_from_russia) / SUM(maize.maize_exports) * 100, 3)                          AS russia_share_global_maize_exports_pc,
    round(SUM(sunflower.sunflower_oil_imports_from_ukraine) / SUM(sunflower.sunflower_oil_exports) * 100, 3) AS ukraine_share_global_sonflower_oil_exports_pc,
    round(SUM(sunflower.sunflower_oil_imports_from_russia) / SUM(sunflower.sunflower_oil_exports) * 100, 3)  AS russia_share_global_sunflower_oil_exports_pc,
    round(SUM(wheat.wheat_imports_from_ukraine) / SUM(wheat.wheat_exports) * 100, 3)                         AS ukraine_share_global_wheat_exports_pc,
    round(SUM(wheat.wheat_imports_from_russia) / SUM(wheat.wheat_exports) * 100, 3)                          AS russia_share_global_wheat_exports_pc
FROM
    barley
    LEFT JOIN maize ON barley.country = maize.country
                       AND barley.year_ = maize.year_
    LEFT JOIN sunflower ON barley.country = sunflower.country
                           AND barley.year_ = sunflower.year_
    LEFT JOIN wheat ON barley.country = wheat.country
                       AND barley.year_ = wheat.year_;