#  Instagram Clone Database Project

##  Project Description
This project demonstrates the design and implementation of a **relational Instagram clone database** using **MySQL** and **Python**.  

The goal is to simulate the structure and functionality of a social media platform,such as posting photos, liking, commenting, tagging, and following, while applying  **SQL concepts** such as **views**, **triggers**, **CTEs** and **window functions**.

**Technologies Used:**

-   **MySQL & MySQL Workbench** – Use for database design, schema creation, constraints, triggers, views and analytical queries.
    
-   **Python**  - Performs data preprocessing using `modifying_keywords.py` by converting the nested `keywords.csv`  from `/in/` into the normalized relational tables `tags.csv` and `photo_tags.csv`,which are used by the database.The latter two CSVs are saved to the 	`/out/` folder.

**Planned Future Enhancements:**

-   Use **Pandas** and **NumPy** to perform deeper data analysis and quality checks.
    
-   Apply **Matplotlib** for visual insights..
    
-   Connect the MySQL database to **Power BI** and build interactive dashboards.

## **How to Install and Run the Project**

Follow the steps below to set up the database, preprocess the data and run all SQL scripts.

### **1. Clone or Download the Project**

Download the project folder or clone this repository:
```bash
git clone https://github.com/VasRep/Instagram_clone_database
```
### **2. Create the Database Schema**
- Open MySQL Workbench (or your preferred SQL client).
- Run the script **`create_database.sql`** from the `/sql/` folder.  
  This creates the initial database structure.

### **3. Import Data**
- Use the **“Table Data Import Wizard”** in MySQL Workbench to create the tables.  
- Import all CSV files from the `/dataset/` and `/out/` folders into their corresponding tables:  
  - `users.csv` → `users`  
  - `photos.csv` → `photos`  
  - `likes.csv` → `likes`  
  - `comments.csv` → `comments`  
  - `follows.csv` → `follows`  
  - `tags.csv` → `tags` 
  - `photo_tags.csv` → `photo_tags`  

### **4. Run SQL Scripts**
Execute the SQL scripts in the correct order from the `/sql/` folder to apply fixes and run the SQL code.

**Execution Order:**
1. **alter_tables.sql** — Adds primary keys, unique constraints, foreign keys, and cascading rules.  
2. **triggers.sql** — Implements automation.  
3. **views.sql** — Defines reusable database views (e.g. tag_stats).  
4. **queries.sql** — Contains analytical queries, CTEs, and reports.

## Credits

Sample CSV data generation: Assisted by ChatGPT (OpenAI)
