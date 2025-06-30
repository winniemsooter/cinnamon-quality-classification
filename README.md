# cinnamon-quality-classification
SQL project profiling Ceylon cinnamon quality using clean, synthetic data. This project showcases a complete SQL-based data profiling, quality scoring, and interpretation pipeline for Ceylon cinnamon samples. The dataset is synthetic, clean, and perfectly balanced across three quality labels: `High`, `Medium`, and `Low`.

# dataset

- `balanced_cinnamon_quality_dataset.csv` contains 60 records (20 per class).
- Features include: Moisture, Ash, Volatile Oil, Acid Insoluble Ash, Chromium, Coumarin.
- Source: Synthetic academic-style generation for educational purposes only.

# goals

- Profile chemical traits of high vs low quality cinnamon.
- Use SQL to create a quality scoring engine.
- Understand how features contribute to quality labels.
- Share insights relevant to food tech and chemical safety.

# tools used

- MySQL Workbench
- SQL (profiling, transformations, rule-based logic)
- GitHub (portfolio project)
- [View on Kaggle](https://www.kaggle.com/datasets/madaraweerasingha/cinnamon-quality-classification)

# key insights

| Quality     | Moisture | Ash | Oil | Acid Ash | Chromium | Coumarin |
|-------------|----------|------|------|------------|-----------|-----------|
| High        | Low-Mid  | Low  | High | Very Low   | Low       | Safe      |
| Medium      | Mid      | Mid  | Mid  | Low        | Slight    | Moderate  |
| Low         | High     | High | Low  | High       | Higher    | Risky     |

# SQL features demonstrated

- DISTINCT label checks
- Grouped profiling with `AVG`, `STDDEV`
- Outlier detection (z-scores)
- Rule-based scoring (`CASE WHEN`)

# files

- `cinnamon_quality_analysis.sql`: Final SQL scripts
- `balanced_cinnamon_quality_dataset.csv`: Clean data
- `README.md`: Project overview

# author

Winifred Liam — a learning & evolving cloud data analyst with interests in finance, food science, and mental health tech.

--
This is an academic simulation. No health or food decisions should be made using this data.
