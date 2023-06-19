import mysql.connector
import pandas as pd
import matplotlib.pyplot as plt

cnx = mysql.connector.connect(
    host="localhost",
    user="root",
    password="12345678",
    database="cs306_project"
)


# Line graphs for survival_male and survival_female:

iso_codes = ["FRA", "DEU", "USA", "POL", "ITA", "RUS", "GBR"]
query = """
SELECT year, iso, survival_male, survival_female
FROM survival_to_65
WHERE iso IN ('FRA', 'DEU', 'USA', 'POL', 'ITA', 'RUS', 'GBR');
"""
df = pd.read_sql(query, cnx)

fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(15, 5))
for iso in iso_codes:
    df_line_male = df[df['iso'] == iso]
    ax1.plot(df_line_male['year'], df_line_male['survival_male'], label=iso)  
    
    df_line_female = df[df['iso'] == iso]
    ax2.plot(df_line_female['year'], df_line_female['survival_female'], label=iso)
    
ax1.set(xlabel="Year", ylabel="Survival Male", title="Survival Male by Year")
ax2.set(xlabel="Year", ylabel="Survival Female", title="Survival Female by Year")
plt.legend()
plt.show()


# Scatter plot for life_expectancy and health_expenditure:

query = """
SELECT AVG(le) as avg_life_expectancy, AVG(expenditure) as avg_health_expenditure, iso
FROM life_expectancy_all JOIN health_expenditure USING (iso, year)
WHERE year BETWEEN 2010 AND 2014
GROUP BY iso
"""
df = pd.read_sql(query, cnx)

plt.scatter(df['avg_health_expenditure'], df['avg_life_expectancy'], label=df['iso'], s=12)
plt.ylabel('Average Life Expectancy between 2010 and 2014')
plt.xlabel('Average Health Expenditure between 2010 and 2014')
plt.title('Scatter plot of Life Expectancy vs Health Expenditure')

for i, iso in enumerate(df['iso']):
    plt.annotate(iso, (df['avg_health_expenditure'][i], df['avg_life_expectancy'][i]), fontsize=5)

plt.show()


# Pie chart for top 10 total health expenditure countries between 2010 and 2019:

query = """
SELECT SUM(expenditure) as total_expenditure, name
FROM health_expenditure JOIN country USING (iso)
WHERE year BETWEEN 2010 AND 2019
GROUP BY iso
ORDER BY total_expenditure DESC
LIMIT 10
"""
df = pd.read_sql(query, cnx)

plt.pie(df['total_expenditure'], labels=df['name'], autopct='%1.1f%%')
plt.title('Top 10 Health Expenditure Countries (2010-2019)')
plt.axis('equal')
plt.show()


# Histogram for average inequality_in_life values of top 10 health expenditure countries:

query = """
SELECT AVG(inequality) as avg_inequality, name
FROM health_expenditure JOIN country USING (iso) JOIN inequality_in_life USING (iso, year)
WHERE year BETWEEN 2010 AND 2015 AND iso IN (SELECT * FROM (
    SELECT iso
    FROM health_expenditure
    WHERE year BETWEEN 2010 AND 2015
    GROUP BY iso
    ORDER BY SUM(expenditure) DESC
    LIMIT 10) temp)
GROUP BY iso
ORDER BY SUM(expenditure) DESC
"""
df = pd.read_sql(query, cnx)

plt.bar(df['name'], df['avg_inequality'])
plt.xlabel('Top 10 Health Expenditure Countries')
plt.ylabel('Average Inequality in Life (2010-2015)')
plt.title('Histogram of Inequality in Life')
plt.xticks(rotation=45)
plt.show()