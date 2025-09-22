-- QUERY 1: Genre Trends Over Time

-- CTE 1: Aggregate yearly genre stats
WITH genre_yearly AS (
    SELECT 
        Year,
        Genre,
        COUNT(*) AS books_count,
        ROUND(AVG("User_Rating"), 2) AS avg_rating,
        SUM(Reviews) AS total_reviews,
        ROUND(AVG(Price), 2) AS avg_price
    FROM books
    GROUP BY Year, Genre
),

-- CTE 2: Calculate YoY changes and market share
yoy_trends AS (
    SELECT 
        Year,
        Genre,
        books_count,
        avg_rating,
        total_reviews,
        avg_price,
        -- YoY review growth %
        ROUND((total_reviews - LAG(total_reviews) OVER (PARTITION BY Genre ORDER BY Year)) * 100.0 / 
              NULLIF(LAG(total_reviews) OVER (PARTITION BY Genre ORDER BY Year), 0), 1) AS reviews_growth_pct,
        -- Market share %
        ROUND(books_count * 100.0 / SUM(books_count) OVER (PARTITION BY Year), 1) AS market_share_pct,
        -- Rank within year by reviews
        RANK() OVER (PARTITION BY Year ORDER BY total_reviews DESC) AS yearly_rank
    FROM genre_yearly
)

-- Final: Filter for meaningful insights (e.g., growth > 10%)
SELECT 
    Year,
    Genre,
    books_count,
    avg_rating,
    total_reviews,
    avg_price,
    reviews_growth_pct,
    market_share_pct,
    yearly_rank,
    CASE 
        WHEN reviews_growth_pct > 10 THEN '🚀 Explosive Growth'
        WHEN reviews_growth_pct > 0 THEN '📈 Steady Rise'
        ELSE '📉 Decline'
    END AS trend_insight
FROM yoy_trends
WHERE Year >= 2010  -- Skip first year for LAG
ORDER BY Year DESC, total_reviews DESC;


-- QUERY 2: Author Ranking & Success Score

-- 🌟 SIMPLE AUTHOR RANKING (NO WINDOW FUNCTIONS)
SELECT 
    ROW_NUMBER() OVER (ORDER BY total_reviews DESC) AS rank,
    Author,
    books_published,
    avg_rating,
    total_reviews,
    ROUND(consistent_pct, 1) AS consistency_pct,
    success_score,
    CASE 
        WHEN consistent_pct >= 80 THEN '🌟 Superstar'
        WHEN consistent_pct >= 60 THEN '📊 Reliable'
        ELSE '📈 Emerging'
    END AS tier
FROM (
    SELECT 
        Author,
        COUNT(*) AS books_published,
        ROUND(AVG("User_Rating"), 2) AS avg_rating,
        SUM(Reviews) AS total_reviews,
        -- Simple consistency: percentage of books with 4+ stars
        ROUND(
            SUM(CASE WHEN "User_Rating" >= 4.0 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 
            1
        ) AS consistent_pct,
        -- Simple success score
        ROUND(AVG("User_Rating") * 10 + SUM(Reviews) / 1000.0, 2) AS success_score
    FROM books
    GROUP BY Author
    HAVING books_published > 2
) author_summary
ORDER BY success_score DESC
LIMIT 10;


-- QUERY 3: Price vs Ratings Analysis

-- 💰 BASIC PRICE ANALYSIS (NO CTEs)
SELECT 
    price_range,
    COUNT(*) AS books_count,
    ROUND(AVG("User_Rating"), 2) AS avg_rating,
    ROUND(AVG(Reviews), 0) AS avg_reviews,
    ROUND(MIN(Price), 2) AS min_price,
    ROUND(MAX(Price), 2) AS max_price,
    ROUND(AVG("User_Rating") - (SELECT AVG("User_Rating") FROM books), 2) AS vs_global_avg
FROM (
    SELECT 
        *,
        CASE 
            WHEN Price < 10 THEN '💸 Budget (<$10)'
            WHEN Price < 15 THEN '💰 Value ($10-15)'
            WHEN Price < 20 THEN '💎 Mid ($15-20)'
            ELSE '🏆 Premium (>$20)'
        END AS price_range
    FROM books
    WHERE Price IS NOT NULL AND "User_Rating" IS NOT NULL
) priced_books
GROUP BY price_range
ORDER BY avg_rating DESC;

-- QUERY 4: Hidden Gems vs Overhyped Books

-- 💎 SIMPLIFIED MIXED GEMS & HYPE (SCREENSHOT READY)
SELECT 
    CASE 
        WHEN gem_type = 'gem' THEN '🥇 GEM RANK: ' || gem_rank
        ELSE '😱 HYPE RANK: ' || hype_rank
    END AS "🏆 POSITION",
    gem_type AS "📊 TYPE",
    Name AS "📚 TITLE",
    Author AS "✍️ AUTHOR", 
    ROUND("User_Rating", 1) AS "⭐ RATING",
    Reviews AS "💬 REVIEWS",
    ROUND(Price, 2) AS "💰 PRICE",
    Genre AS "📖 GENRE",
    ROUND("User_Rating" / (1.0 + Reviews / 1000.0), 2) AS "⚡ SCORE",
    CASE 
        WHEN gem_type = 'gem' THEN 
            '💎 Hidden treasure! Only ' || Reviews || ' reviews for ' || ROUND("User_Rating", 1) || ' stars'
        ELSE 
            '⚠️ Overhyped alert! ' || Reviews || ' reviews but only ' || ROUND("User_Rating", 1) || ' stars'
    END AS "💡 INSIGHT"
FROM (
    -- Hidden Gems: High rating, low reviews
    SELECT 
        Name, Author, "User_Rating", Reviews, Price, Genre,
        ROW_NUMBER() OVER (ORDER BY "User_Rating" DESC, Reviews ASC) AS gem_rank,
        NULL AS hype_rank,
        '💎 GEM' AS gem_type
    FROM books 
    WHERE Reviews < 2000 AND "User_Rating" >= 4.5 AND Reviews > 0
    
    UNION ALL
    
    -- Overhyped: Low rating, high reviews  
    SELECT 
        Name, Author, "User_Rating", Reviews, Price, Genre,
        NULL AS gem_rank,
        ROW_NUMBER() OVER (ORDER BY "User_Rating" ASC, Reviews DESC) AS hype_rank,
        '⚠️ HYPE' AS gem_type
    FROM books 
    WHERE Reviews > 5000 AND "User_Rating" <= 4.2 AND Reviews > 0
)
WHERE (gem_rank <= 5 OR hype_rank <= 5)
ORDER BY 
    CASE gem_type 
        WHEN '💎 GEM' THEN 1 
        WHEN '⚠️ HYPE' THEN 2 
    END,
    ABS(Reviews - 5000),  -- Mixes review counts
    gem_rank NULLS LAST, hype_rank NULLS LAST
LIMIT 15;






-- QUERY 5: Author Evolution Over the Years


-- CTE 1: Author yearly aggregates
WITH author_yearly AS (
    SELECT 
        Author,
        Year,
        COUNT(*) AS books_that_year,
        ROUND(AVG("User_Rating"), 2) AS avg_rating_that_year,
        SUM(Reviews) AS total_reviews_that_year
    FROM books
    GROUP BY Author, Year
    HAVING books_that_year > 1  -- Focus on active years
),

-- CTE 2: Evolution with deltas
author_evolution AS (
    SELECT 
        Author,
        Year,
        books_that_year,
        avg_rating_that_year,
        total_reviews_that_year,
        LAG(avg_rating_that_year) OVER (PARTITION BY Author ORDER BY Year) AS prev_year_rating,
        ROUND(avg_rating_that_year - LAG(avg_rating_that_year) OVER (PARTITION BY Author ORDER BY Year), 2) AS rating_delta,
        -- Self-join like: Compare to debut year (correlated subquery)
        (SELECT avg_rating_that_year FROM author_yearly ay2 WHERE ay2.Author = author_yearly.Author ORDER BY Year LIMIT 1) AS debut_rating
    FROM author_yearly
)

-- Final: Authors with positive evolution
SELECT 
    Author,
    Year,
    books_that_year,
    avg_rating_that_year,
    total_reviews_that_year,
    rating_delta,
    debut_rating,
    ROUND((avg_rating_that_year - debut_rating) * 100.0 / NULLIF(debut_rating, 0), 1) AS pct_improvement_from_debut,
    CASE 
        WHEN rating_delta > 0.2 THEN '🌟 Improving Rapidly'
        WHEN rating_delta > 0 THEN '📈 Steady Improvement'
        ELSE '🟡 Stable or Declining'
    END AS evolution_insight
FROM author_evolution
WHERE Author IN (SELECT Author FROM books GROUP BY Author HAVING COUNT(DISTINCT Year) > 3)  -- Multi-year authors
ORDER BY Author, Year;


