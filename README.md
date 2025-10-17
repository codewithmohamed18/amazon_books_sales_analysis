# 📚 **Amazon Bestselling Books Analysis**
*Unveiling Data Secrets Behind Literary Success*

---

<div align="center">
  
  <!-- Hero banner -->
  <img src="https://imgs.search.brave.com/Xxr7d4N1etRECBdf4UqlrmYnvmfdWiZp8_CJBiAWCZ4/rs:fit:500:0:1:0/g:ce/aHR0cHM6Ly93d3cu/YXV0b21hdGVlZC5j/b20vX25leHQvaW1h/Z2U_dXJsPS9hcGkv/aW1hZ2UtcHJveHkv/MjAyNC8wMS9Ub3At/U2VsbGluZy1Cb29r/LUNhdGVnb3JpZXMt/b24tQW1hem9uLVBv/cHVsYXItVHJlbmRz/LmpwZyZ3PTgyOCZx/PTcw" alt="Amazon Bestsellers Decoded banner" />

  <!-- Badges -->
  <br><br>
  <a href="LICENSE"><img src="https://img.shields.io/badge/License-MIT-yellow.svg" alt="MIT License"></a>
  <img src="https://img.shields.io/badge/Tools-Python%20|%20Pandas%20|%20Excel%20|%20Power%20BI-4A90E2.svg" alt="Tools">
  <img src="https://img.shields.io/badge/Focus-Sales%20Rank%20|%20Ratings%20|%20Price%20|%20Genres-9B59B6.svg" alt="Focus Areas">
  <img src="https://img.shields.io/badge/Data-Ready%20for%20EDA-2ECC71.svg" alt="Data Ready">

  <p>
    From raw listings to <b>actionable patterns</b>—discover how <i>price, ratings, reviews, and categories</i> 
    shape the rise of Amazon’s bestselling books.
  </p>
</div>


## 🎯 **The Mission: Decoding Amazon's Literary Universe**

**What makes a book explode into bestseller status?** Is it the author's name? The price tag? The genre timing? Or something more mysterious?

I analyzed **550 Amazon bestselling books** (2009-2019) using **advanced SQL techniques** to uncover the **hidden patterns** behind literary success. From genre evolution to author career arcs, pricing psychology, and hidden gems waiting to be discovered—this analysis reveals the **data-driven secrets** of Amazon's book empire.

> *"In the world of bestsellers, data doesn't lie—authors do."*  
> — Mohamed, Data Alchemist ✨

---

## 🔥 **What I Discovered (The Explosive Insights)**

| **Discovery** | **The Numbers** | **The Impact** |
|---------------|-----------------|---------------|
| **Non-Fiction Revolution** | 📈 **62% market dominance**, **18% YoY review growth** | Non-Fiction isn't just winning—it's rewriting the rules |
| **Budget Book Magic** | 💰 **4.7⭐** for <$10 vs **4.4⭐** for >$20 | Value pricing = higher ratings = more sales |
| **Author Consistency Kings** | 👑 **Jeff Kinney**: 85% consistency across 8 books | Series authors = predictable goldmines |
| **15 Hidden Gems Found** | 💎 **4.7+ stars**, **<500 reviews** each | Undervalued masterpieces ready for marketing magic |
| **Career Evolution Proof** | 🚀 **Suzanne Collins**: +0.3 rating improvement | Experience = excellence (for the right authors) |

---

---

## 📊 **Visual Proof: The Results Speak Louder Than Code**

<div align="center">

### **1. Genre Market Share Evolution (2009-2019)**
![Genre Trends](assets/images/1.png)
*Non-Fiction's relentless rise from 45% to 68% market dominance*

### **2. Author Performance Leaderboard**
![Author Rankings](assets/images/2.png)  
*Jeff Kinney leads with 85% consistency across 8 blockbuster books*

### **3. Price-Rating Sweet Spot Analysis**  
![Price Analysis](assets/images/3.png)
*Budget books (<$10) outperform premium by +0.3 stars on average*

### **4. Hidden Gems vs Overhyped Books**  
![Gems vs Hype](assets/images/4.png)
*15 undervalued masterpieces vs viral disappointments—marketing opportunities!*

### **5. Author Career Evolution Trajectories**  
![Author Evolution](assets/images/5.png)
*Suzanne Collins: +0.3 rating improvement over 4-year career arc*

</div>

---



## 🛠️ **Technical Wizardry Unleashed**

This isn't basic `SELECT * FROM books` analysis. I wielded **SQL like a lightsaber**:

| **Advanced Technique** | **What It Does** | **Business Value** |
|------------------------|------------------|-------------------|
| **CTEs (Common Table Expressions)** | Complex data pipelines | Clean, readable transformations |
| **Window Functions** | `LAG`, `RANK`, `ROW_NUMBER` | Year-over-year comparisons, leaderboards |
| **Subqueries** | Dynamic genre benchmarks | Real-time competitive analysis |
| **UNION Operations** | Gems vs Hype detection | Multi-angle pattern discovery |
| **CASE Statements** | Insight categorization | Actionable business recommendations |

---

## 📁 **Repository Navigation: Your Data Journey**

```
amazon-bestselling-books/
│
├── 📄 amazon_books_queries.sql          # 🔥 The complete SQL arsenal (5 advanced queries)
├── 📄 books.csv                         # 📊 Raw dataset: 550 bestselling books
├── 📁 assets/images/                    # 🎨 Visual proof of insights
│   ├── 1.png  # Genre evolution trends (2009-2019)
│   ├── 2.png  # Author performance rankings
│   ├── 3.png  # Price vs rating sweet spots
│   ├── 4.png  # Hidden gems vs overhyped books
│   └── 5.png  # Author career trajectories
└── 📄 README.md                         # 📖 You're reading it! (This file)
```

---

## 🚀 **The 5 Epic Queries: Technical Deep Dive**

### **Query 1: Genre Evolution Engine** 🕰️
```sql
-- CTEs + LAG for year-over-year growth analysis
WITH genre_yearly AS (...),
yoy_trends AS (
    SELECT ..., 
    ROUND((total_reviews - LAG(total_reviews) OVER (...)) * 100.0 / ..., 1) AS reviews_growth_pct
)
```
**Insight**: Non-Fiction's market share exploded from **45% to 68%** in 10 years!

### **Query 2: Author Success Algorithm** 👑
```sql
-- Custom success scoring with ROW_NUMBER ranking
SELECT ROW_NUMBER() OVER (ORDER BY success_score DESC) AS rank,
       ROUND(avg_rating * 10 + total_reviews / 1000.0, 2) AS success_score
```
**Insight**: **Jeff Kinney** reigns supreme with **165.0 success score** and **85% consistency**!

### **Query 3: Price Psychology Decoder** 💰
```sql
-- Dynamic price tiering with subquery benchmarking
CASE WHEN Price < 10 THEN '💸 Budget' 
     WHEN Price < 15 THEN '💰 Value' 
     ELSE '🏆 Premium' END AS price_range
```
**Insight**: **Budget books** average **+0.3 stars** over premium—value wins every time!

### **Query 4: Gems vs Hype Detector** 💎⚠️
```sql
-- UNION ALL for multi-perspective analysis
SELECT ... FROM (gems_query) UNION ALL SELECT ... FROM (hype_query)
```
**Insight**: Discovered **15 hidden gems** with **4.7+ stars** but **<500 reviews**—marketing gold!

### **Query 5: Author Career Trajectory Mapper** 📈
```sql
-- LAG for temporal analysis + correlated subqueries
LAG(avg_rating_that_year) OVER (PARTITION BY Author ORDER BY Year) AS prev_year_rating
```
**Insight**: **Suzanne Collins** improved **+0.3 rating points** from debut to Hunger Games peak!



## 💡 **Battle-Tested Business Insights**

### **For Publishers & Marketers:**
- **Genre Strategy**: Allocate **70% budget** to Non-Fiction (18% YoY growth)
- **Pricing Power**: Target **$7.99-$9.99 sweet spot** for maximum ratings
- **Author Partnerships**: Prioritize **series authors** (80%+ consistency = predictable ROI)
- **Discovery Goldmine**: Promote **15 hidden gems** with 4.7+ stars but <500 reviews

### **For Amazon & Retailers:**
- **Recommendation Engine**: Surface **high-efficiency gems** (4.8 stars, 200 reviews)
- **Dynamic Pricing**: Test **budget tier promotions** for +0.3 star uplift
- **Author Spotlights**: Feature **career-improvers** like Suzanne Collins for inspiration
- **Genre Merchandising**: Double-down on **Non-Fiction dominance** in browse paths

---

## 🏆 **Technical Skills Showcase**

| **Skill Category** | **Techniques Used** | **Portfolio Value** |
|--------------------|---------------------|---------------------|
| **Data Engineering** | CTEs, Subqueries, UNION | Complex transformation pipelines |
| **Advanced Analytics** | Window Functions (LAG, RANK, ROW_NUMBER) | Temporal analysis, leaderboards |
| **Business Intelligence** | CASE logic, Dynamic calculations | Actionable insights generation |
| **Data Visualization** | Structured result formatting | Screenshot-ready outputs |
| **Database Design** | SQLite optimization, Query performance | Production-ready SQL |

---

## 🎮 **How to Run This Analysis (5 Minutes)**

### **Prerequisites:**
- **SQLite** (or SQLiteStudio for GUI)
- **Basic SQL knowledge** (you've got this! 💪)

### **Quick Start:**
```bash
# 1. Download the dataset
# books.csv already in this repo!

# 2. Create database (SQLite CLI)
sqlite3 amazon_books.db
.mode csv
.import books.csv books
.headers on
.exit

# 3. Open in SQLiteStudio or run:
sqlite3 amazon_books.db < amazon_books_queries.sql

# 4. View results in assets/images/ or export to CSV
```

### **Full Setup Guide:**
See the **inline comments** in `amazon_books_queries.sql` for detailed execution instructions.



## 🌟 **About the Data Alchemist**

**Mohamed** — *Data Analyst | SQL Enthusiast | Storyteller*

I transform **raw numbers into compelling narratives** that drive decisions and spark curiosity. When I'm not decoding bestseller secrets, you'll find me exploring new datasets, building dashboards, or recommending that next hidden gem you didn't know you needed.

<div align="center">

[![Portfolio](https://img.shields.io/badge/Portfolio-GitHub-black?style=flat&logo=github)](https://github.com/codewithmohamed18)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-blue?style=flat&logo=linkedin)](https://linkedin.com/in/codewithmohamed18)
[![Email](https://img.shields.io/badge/Email-Contact-red?style=flat&logo=gmail)](mailto:mohamed@example.com)

</div>

---

## 🚀 **Ready to Level Up Your Analysis?**

### **Fork & Extend:**
- **Add 2020-2024 data** to see pandemic impact
- **Incorporate Goodreads ratings** for cross-platform analysis  
- **Build Power BI dashboard** with interactive filters
- **Add author demographics** for diversity analysis

### **Contribute:**
- Found a bug? **Open an issue**
- Have a killer query? **Submit a pull request**  
- Want to collaborate? **Message me on LinkedIn**

---

<div align="center">

## 🎉 **The Final Word**

*"Data doesn't just tell us what happened—it reveals what will happen next."*

This analysis proves that behind every bestseller is a **pattern waiting to be discovered**. Whether you're a publisher seeking the next big hit, an author plotting your series strategy, or a data enthusiast honing your SQL craft—this project shows the **power of asking the right questions** of the right data.

**⭐ Star this repo** if it inspired you!  
**👏 Give it a shoutout** if it helped your analysis journey!  
**📞 Let's connect**—I'm always up for data adventures!

</div>

---

<div align="right">
*Built with ❤️, SQL, and curiosity*  
**© 2025 Mohamed — Keep analyzing, keep discovering!** ✨
</div>

---

## 📚 **Quick Links**
- [📊 Full SQL Queries](amazon_books_queries.sql)
- [📈 Live Results](assets/images/)
- [📋 Raw Dataset](books.csv)
- [🔧 Setup Guide](#-how-to-run-this-analysis-5-minutes)

---

> **P.S.** That one hidden gem with 4.8 stars and only 234 reviews? *It's calling your name.* 📖✨
