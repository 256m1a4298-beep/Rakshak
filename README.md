# RAKSHAK — Defence Recruitment & Exam Preparation App

A Java desktop application (Java Swing + JDBC + MySQL) that helps defence aspirants
explore career options, study defence topics, practise MCQ mock tests, save results,
and build a study timetable. Built as a college Java Programming case-study project.

> **Disclaimer:** All information is for educational purposes. Eligibility, age limits,
> exam patterns and notifications change — always verify from official sources
> (upsc.gov.in, joinindianairforce.cdac.in, indianarmy.nic.in, indiannavy.nic.in, mod.gov.in).

---

## 1. What you need

| Requirement | Version used here |
|---|---|
| JDK (Java) | 17 or above (built/tested on JDK 27) |
| MySQL Server | 8.x |
| MySQL JDBC driver | already in `lib/mysql-connector-j-9.1.0.jar` |
| Any IDE (optional) | IntelliJ / Eclipse / VS Code / NetBeans — or just the two .bat scripts |

## 2. First-time setup (5 steps)

1. **Install MySQL 8** (dev.mysql.com/downloads/installer). During setup choose
   "Developer Machine", set a root password you remember, keep default port 3306.
2. **Create the database and tables:** open *MySQL 8.0 Command Line Client*, then run
   ```
   mysql -u root -p < sql/schema.sql
   mysql -u root -p rakshak_db < sql/seed.sql
   ```
   (or paste both files into MySQL Workbench and execute).
3. **Tell the app your MySQL password:** open `db.properties` in a text editor and
   change `YOUR_MYSQL_PASSWORD` to your real root password.
4. **Build:** double-click `build.bat` (or run it in a terminal) → expect `BUILD OK`.
5. **Run:** double-click `run.bat` → the RAKSHAK login window opens.

On the login window click **Register**, create a user, then log in.

## 3. Running from an IDE

- **IntelliJ / Eclipse / NetBeans:** open/import this folder as a Java project,
  mark `src` as the source root, add `lib/mysql-connector-j-9.1.0.jar` as a
  library dependency, set the working directory to the project root
  (so `db.properties` is found), and run `rakshak.Main`.
- **VS Code (Java Extensions):** open the folder, create a `Java: Project`,
  add the jar to referenced libraries, then run `Main.java`.

## 4. Project structure

```
mini project/
├── db.properties              <- your MySQL url/user/password (file handling demo)
├── build.bat / run.bat        <- compile and start shortcuts
├── lib/                       <- MySQL JDBC driver jar
├── sql/schema.sql             <- CREATE DATABASE + 7 tables
├── sql/seed.sql               <- 80 questions, study material, careers, 8 exams
└── src/rakshak/
    ├── Main.java              <- entry point
    ├── Session.java           <- remembers the logged-in user
    ├── database/DBConnection  <- the ONLY place that opens MySQL connections
    ├── model/                 <- User, Question, Result, Exam, StudyPlan,
    │                            StudyMaterial, CareerInfo,
    │                            DefenceForce (abstract) -> Army, Navy, AirForce, CapfForce
    ├── dao/                   <- UserDAO, QuestionDAO, ResultDAO, StudyPlanDAO,
    │                            ExamDAO, CareerDAO, StudyMaterialDAO (all SQL lives here)
    ├── ui/                    <- Login, Register, Home(BaseFrame), Career, Exam,
    │                            MockTest, Result, StudyMaterial, DefenceAwareness,
    │                            StudyPlanner, About frames
    └── util/Utility.java      <- validation, SHA-256 hashing, dialogs
```

## 5. Where each OOP concept is used (for your viva)

| Concept | Where in RAKSHAK |
|---|---|
| Encapsulation | Every model class: `private` fields + getters/setters |
| Inheritance | All screens extend `BaseFrame`; `Army/Navy/AirForce/CapfForce` extend `DefenceForce` |
| Polymorphism | `describe()` calls `getOfficerRanks()` etc. — same call, different output per object; `Exam.toString()` and `StudyMaterial.toString()` override `Object` versions |
| Abstraction | `DefenceForce` is abstract with 3 abstract methods; `BaseFrame.createBody()` abstract method |
| Constructors | All models have no-arg + full constructors |
| Exception handling | `SQLException` in every DAO call site, `NumberFormatException` in planner, `JDBC` connection check in `Main` |
| Collections | `List<Question>`, `List<Exam>`, `DefaultListModel<StudyMaterial>`, arrays for answers |
| File handling | `db.properties` loaded with `FileInputStream`/`Properties` in `DBConnection` |
| JDBC + CRUD | register (INSERT), login (SELECT), save result (INSERT), history (SELECT), planner (INSERT), random questions with `ORDER BY RAND() LIMIT ?` |

## 6. Application flow

```
START → DB check → Login/Register → Home Dashboard
  ├─ Defence Career   (MySQL: defence_career)
  ├─ Exams            (MySQL: exams)
  ├─ Mock Test        (MySQL: questions → score → results)
  ├─ Study Material   (MySQL: study_material)
  ├─ Defence Awareness(DefenceForce OOP classes + static glossary)
  ├─ Study Planner    (timetable generator → MySQL: study_planner)
  ├─ Results          (MySQL: results history table)
  ├─ About
  └─ Logout / Exit
```

Full report (objectives, ER diagram, data flow, test cases, viva Q&A):
see `docs/DOCUMENTATION.md`.
