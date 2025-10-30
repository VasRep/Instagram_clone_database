# 📸 Instagram Demo Database Project

## 🗂️ Project Overview
This project demonstrates the design and implementation of a **relational Instagram-like database** using **MySQL**.  
It includes **data preprocessing with Python**, **SQL schema creation**, **constraints**, **triggers**, **views**, and **analytical queries**.

The goal is to simulate the structure and functionality of a social media platform while applying advanced **SQL concepts** such as **CTEs**, **window functions**, and **trigger-based automation**.

---

## 🧮 Dataset Creation

The dataset was inspired by typical Instagram user interactions — users, photos, likes, comments, and follows.  
All CSV files in the dataset folder, which are used to populate the database, were **generated with the assistance of ChatGPT (OpenAI)**, providing realistic sample data for testing and demonstration.

---

## 🐍 Python Data Preprocessing

**File:** `modifying_keywords.py`

This Python script processes the nested `keywords.csv` file, which contains JSON-like data.  
It normalizes this structure into two flat relational tables — a process similar to data warehousing ETL (Extract, Transform, Load).

### Transformation Logic
- Reads `keywords.csv` from `/in/`
- Parses the nested JSON strings safely using `ast.literal_eval`
- Creates two new tables:
  - `tags.csv` — contains tag (keyword) IDs and names  
  - `photo_tags.csv` — maps photos to their corresponding tags
- Saves the resulting CSVs to the `/out/` folder.

The new CSVs are then used in the database to define the **many-to-many relationship** between photos and tags.

---

## 🧱 Database Schema

After generating and cleaning the data, all CSVs were imported into MySQL Workbench.

### 🧾 Tables Overview

| Table | Description |
|-------|-------------|
| **users** | User profiles containing `id`, `username`, `created_at`, `age` |
| **photos** | Stores photos uploaded by users (`id`, `image_url`, `user_id`) |
| **likes** | Tracks which users liked which photos |
| **comments** | Contains all user comments per photo |
| **follows** | Defines following relationships between users |
| **unfollows** | Logs users who unfollow others (created via trigger) |
| **tags** | List of hashtags  |
| **photo_tags** | Many-to-many link between photos and tags |

All tables were designed by the author to model realistic Instagram data behavior.

---

## 🧩 SQL Files Structure

The `sql/` folder contains organized scripts for schema creation, constraint setup, triggers, views, and analytical queries.

sql/
1.create_database.sql # Defines the tables and initial schema
2.alter_tables.sql # Adds primary keys, unique constraints, FKs, and cascading rules
3.triggers.sql # Implements business logic automation
4.views.sql # Defines reusable database views (e.g. tag statistics)
5.queries.sql # Analytical queries, CTEs, and reports


###  `create_database.sql`
Defines all tables, including:
- `users`, `photos`, `likes`, `comments`, `follows`, `unfollows`, `tags`, and `photo_tags`.

###  `alter_tables.sql`
Adds relational integrity:
- Primary and foreign keys
- `ON DELETE CASCADE` relationships to maintain referential consistency

###  `views.sql`
Defines database **views** for easier reporting.  

### `triggers.sql`
Implements automatic rules via triggers:
must_be_adult → blocks inserting users younger than 18
prevent_self_follows → prevents users from following themselves
create_unfollow → automatically records unfollows into unfollows table

### `queries.sql`
Contains SQL analytics and insights using aggregations, CTEs, and window functions:
5 oldest users
Most popular photo
Average posts per user
Top 5 hashtags
Users who liked every photo
Top 3 most-liked photos per user (DENSE_RANK())

📊 Entity Relationship Diagram (ERD)

The file ERD.pdf visualizes the database schema — showing all entities, relationships, and key constraints.

🚀 How to Run the Project

Import Data

Load CSV files from /dataset/ into MySQL tables using Workbench

Run SQL Scripts from sql folder
Execute in order:
1.create_database.sql
2.alter_tables.sql
3.triggers.sql
4.views.sql
5queries.sql

🏁 Credits

Sample CSV data generation: Assisted by ChatGPT (OpenAI)