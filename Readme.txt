# Lab Exam Solution: Learning Management System (LMS)
**Software Engineering 2 - Activity & Sequence Diagrams with Complete UML Analysis**

## 1. ACTORS AND USE CASES IDENTIFICATION

### **Primary Actors:**
1. **Student** - Enrolls in courses, submits assignments, views grades
2. **Instructor/Faculty** - Manages courses, creates assignments, grades students
3. **Administrator** - Manages users, courses, system settings
4. **System** - Automated processes like notifications, backups
5. **Department Head** - Oversees department activities, approves courses
6. **Guest User** - Browses public course catalog

### **Use Cases by Actor:**

#### **Student Use Cases:**
- UC-S1: Register/Login to System
- UC-S2: Browse Course Catalog
- UC-S3: Enroll in Course
- UC-S4: View Course Materials
- UC-S5: Submit Assignment
- UC-S6: Participate in Discussion Forum
- UC-S7: View Grades/Progress Report
- UC-S8: Download Course Resources
- UC-S9: Request Course Withdrawal
- UC-S10: Update Profile Information

#### **Instructor Use Cases:**
- UC-I1: Create/Manage Course
- UC-I2: Upload Course Materials
- UC-I3: Create/Assign Assignments
- UC-I4: Grade Student Submissions
- UC-I5: Manage Discussion Forum
- UC-I6: Generate Student Reports
- UC-I7: Send Announcements
- UC-I8: Track Student Attendance
- UC-I9: Create Quizzes/Exams
- UC-I10: Approve/Reject Enrollment Requests

#### **Administrator Use Cases:**
- UC-A1: User Account Management
- UC-A2: Course Creation/Deletion
- UC-A3: System Configuration
- UC-A4: Generate System Reports
- UC-A5: Backup/Restore Data
- UC-A6: Manage Departments
- UC-A7: Handle System Issues
- UC-A8: Assign User Roles/Permissions

#### **Department Head Use Cases:**
- UC-D1: Review Department Performance
- UC-D2: Approve Course Proposals
- UC-D3: Assign Faculty to Courses
- UC-D4: Generate Department Reports
- UC-D5: Manage Department Resources

---

## 2. CLASS DIAGRAM WITH RELATIONSHIPS

```mermaid
classDiagram
    %% Main Entities
    class User {
        -String userID
        -String name
        -String email
        -String password
        -String role
        -Date registrationDate
        +login()
        +logout()
        +updateProfile()
    }

    class Student {
        -String studentID
        -String department
        -int semester
        -float CGPA
        +enrollCourse()
        +submitAssignment()
        +viewGrades()
    }

    class Instructor {
        -String facultyID
        -String specialization
        -String department
        -int experienceYears
        +createCourse()
        +gradeAssignment()
        +generateReport()
    }

    class Administrator {
        -String adminID
        -String privileges
        +manageUsers()
        +configureSystem()
        +generateReports()
    }

    class Department {
        -String deptID
        -String deptName
        -String headName
        -int totalFaculty
        -int totalStudents
        +addFaculty()
        +createCourse()
        +generateReport()
    }

    class Course {
        -String courseID
        -String courseName
        -String department
        -String instructor
        -int credits
        -int maxStudents
        -String schedule
        +addMaterial()
        +updateSyllabus()
        +getEnrolledStudents()
    }

    class Enrollment {
        -String enrollmentID
        -Date enrollmentDate
        -String status
        -float grade
        +enrollStudent()
        +withdraw()
        +calculateGrade()
    }

    class Assignment {
        -String assignmentID
        -String title
        -String description
        -Date dueDate
        -int maxPoints
        +submitSolution()
        +gradeAssignment()
        +extendDeadline()
    }

    class Material {
        -String materialID
        -String title
        -String type
        -String filePath
        -Date uploadDate
        +upload()
        +download()
        +delete()
    }

    class Grade {
        -String gradeID
        -float score
        -String letterGrade
        -String comments
        -Date gradedDate
        +calculateGrade()
        +addComments()
    }

    class Forum {
        -String forumID
        -String topic
        -List~Message~ messages
        +postMessage()
        +replyToMessage()
        +deleteMessage()
    }

    class Notification {
        -String notificationID
        -String type
        -String message
        -Date sentDate
        -boolean isRead
        +sendNotification()
        +markAsRead()
    }

    %% Relationships
    User <|-- Student
    User <|-- Instructor
    User <|-- Administrator
    
    Department "1" -- "0..*" Instructor : employs
    Department "1" -- "0..*" Course : offers
    Department "1" -- "0..*" Student : has
    
    Student "1" -- "0..*" Enrollment : has
    Course "1" -- "0..*" Enrollment : contains
    
    Instructor "1" -- "0..*" Course : teaches
    Course "1" -- "0..*" Assignment : has
    Course "1" -- "0..*" Material : contains
    
    Assignment "1" -- "0..*" Grade : results in
    Student "1" -- "0..*" Grade : receives
    
    Course "1" -- "1" Forum : has
    
    User "1" -- "0..*" Notification : receives
    
    %% Aggregation/Composition
    Course o-- Material : contains
    Course o-- Assignment : contains
    Department o-- Course : offers
```

### **Class Diagram Explanation:**
- **Generalization**: User is parent of Student, Instructor, Administrator
- **Association**: Course has many Enrollments
- **Aggregation**: Department contains Courses (weak ownership)
- **Composition**: Course contains Materials (strong ownership)
- **Multiplicity**: One-to-many relationships between entities

---

## 3. ACTIVITY DIAGRAM - Department Management Workflow

```mermaid
flowchart TD
    Start([Department Process Starts]) --> A{Identify Process Type}
    
    A -->|Course Management| B[Request New Course]
    B --> C{Faculty Request}
    C -->|Yes| D[Submit Course Proposal]
    C -->|No| E[Department Creates Course]
    D --> F[Department Head Review]
    E --> F
    F --> G{Approved?}
    G -->|Yes| H[Assign Instructor]
    G -->|No| I[Return for Revision]
    I --> D
    H --> J[Create Course in System]
    J --> K[Set Course Parameters]
    K --> L[Course Published]
    
    A -->|Student Enrollment| M[Student Applies]
    M --> N[Check Prerequisites]
    N --> O{Requirements Met?}
    O -->|Yes| P[Check Seat Availability]
    O -->|No| Q[Reject Application]
    P --> R{Seats Available?}
    R -->|Yes| S[Approve Enrollment]
    R -->|No| T[Waitlist Student]
    S --> U[Generate Enrollment Record]
    T --> V[Notify When Available]
    U --> W[Update Course Roster]
    
    A -->|Faculty Assignment| X[Department Review Need]
    X --> Y{Need New Assignment?}
    Y -->|Yes| Z[Check Faculty Availability]
    Y -->|No| AA[End Process]
    Z --> AB[Assign Faculty to Course]
    AB --> AC[Update Teaching Schedule]
    AC --> AD[Notify Faculty]
    
    A -->|Resource Management| AE[Identify Resource Need]
    AE --> AF[Budget Check]
    AF --> AG{Budget Available?}
    AG -->|Yes| AH[Approve Resource]
    AG -->|No| AI[Request Additional Budget]
    AH --> AJ[Allocate Resources]
    AI --> AK[Higher Authority Review]
    AK --> AL{Approved?}
    AL -->|Yes| AH
    AL -->|No| AM[Deny Request]
    
    A -->|Reporting| AN[Generate Report Request]
    AN --> AO{Report Type}
    AO -->|Student Performance| AP[Gather Student Data]
    AO -->|Course Evaluation| AQ[Collect Course Metrics]
    AO -->|Faculty Performance| AR[Review Faculty Activities]
    AP --> AS[Analyze Data]
    AQ --> AS
    AR --> AS
    AS --> AT[Generate Report]
    AT --> AU[Submit to Department Head]
    
    L --> End([Process Complete])
    W --> End
    AD --> End
    AJ --> End
    AM --> End
    AU --> End
    Q --> End
    V --> End
    AA --> End
```

---

## 4. SEQUENCE DIAGRAM - Course Enrollment Process

```mermaid
sequenceDiagram
    participant S as Student
    participant UI as LMS Interface
    participant EC as Enrollment Controller
    participant CM as Course Manager
    participant DM as Department Manager
    participant DB as Database
    participant N as Notification System
    
    Note over S,DM: Student Enrollment Process
    
    S->>UI: Login to System
    UI->>DB: Authenticate User
    DB-->>UI: Authentication Result
    UI-->>S: Display Dashboard
    
    S->>UI: Browse Course Catalog
    UI->>CM: Get Available Courses
    CM->>DB: Fetch Course Data
    DB-->>CM: Course List
    CM-->>UI: Display Courses
    UI-->>S: Show Course Details
    
    S->>UI: Select Course to Enroll
    UI->>EC: Request Enrollment
    EC->>CM: Check Course Availability
    CM->>DB: Verify Seat Count
    DB-->>CM: Availability Status
    CM-->>EC: Course Status
    
    EC->>DM: Check Department Approval
    DM->>DB: Verify Department Rules
    DB-->>DM: Department Policies
    DM-->>EC: Approval Status
    
    alt Course Available & Approved
        EC->>DB: Create Enrollment Record
        DB-->>EC: Enrollment Confirmed
        EC->>CM: Update Course Enrollment Count
        CM->>DB: Increment Enrollment
        DB-->>CM: Update Successful
        
        EC->>N: Send Enrollment Confirmation
        N->>S: Email/SMS Notification
        EC->>UI: Show Success Message
        UI-->>S: Enrollment Successful
    else Course Full
        EC->>UI: Show Waitlist Option
        UI-->>S: Prompt for Waitlist
        S->>UI: Confirm Waitlist
        UI->>DB: Add to Waitlist
        DB-->>UI: Waitlist Confirmed
        UI-->>S: Waitlist Position
    else Not Approved
        EC->>UI: Show Rejection Reason
        UI-->>S: Enrollment Denied
    end
    
    Note over S,DM: Enrollment Process Complete
```

---

## 5. OUTPUT FOR TEST CASES

### **Test Case 1: Student Course Enrollment**
```
TEST CASE: TC-ENROLL-001
ACTION: Student enrolls in available course
INPUT: StudentID: S2023001, CourseID: CS-401
EXPECTED OUTPUT:
-----------------------------------------
ENROLLMENT CONFIRMATION
-----------------------------------------
Student: John Doe (S2023001)
Course: Data Structures & Algorithms (CS-401)
Instructor: Dr. Mohamed Ayman
Credits: 3 | Schedule: MWF 10:00-11:00
Enrollment Date: 2024-03-15
Status: ENROLLED
Enrollment ID: ENR-20240315-001
-----------------------------------------
NOTIFICATION: Enrollment confirmation sent to student email
SYSTEM: Course enrollment count updated to 86/100
```

### **Test Case 2: Faculty Creating Assignment**
```
TEST CASE: TC-ASSIGN-002
ACTION: Instructor creates new assignment
INPUT: CourseID: CS-401, Title: "Linked List Implementation"
EXPECTED OUTPUT:
-----------------------------------------
ASSIGNMENT CREATED SUCCESSFULLY
-----------------------------------------
Assignment ID: ASG-CS401-003
Course: Data Structures & Algorithms
Title: Linked List Implementation
Due Date: 2024-04-10 23:59
Max Points: 100
Status: ACTIVE
-----------------------------------------
NOTIFICATION: Assignment announcement sent to 85 enrolled students
SYSTEM: Assignment added to course materials
GRADEBOOK: Assignment column created
```

### **Test Case 3: Department Head Generating Report**
```
TEST CASE: TC-REPORT-003
ACTION: Department Head requests performance report
INPUT: Department: Computer Science, Period: Spring 2024
EXPECTED OUTPUT:
=========================================
DEPARTMENT PERFORMANCE REPORT
Computer Science - Spring 2024
=========================================
GENERATED: 2024-03-15 14:30:45
REPORT ID: DEP-REP-20240315-001

1. ENROLLMENT STATISTICS:
   - Total Courses Offered: 42
   - Total Students Enrolled: 1,250
   - Average Class Size: 29.8
   - Enrollment Growth: +12.5%

2. FACULTY PERFORMANCE:
   - Total Faculty: 28
   - Courses per Faculty: 1.5
   - Student Satisfaction: 4.7/5.0
   - Research Publications: 85

3. STUDENT PERFORMANCE:
   - Average GPA: 3.45
   - Graduation Rate: 89.2%
   - Placement Rate: 92.5%
   - Dropout Rate: 3.2%

4. RESOURCE UTILIZATION:
   - Lab Utilization: 78%
   - Software Licenses: 95% active
   - Budget Utilization: 87.5%
   - Equipment Maintenance: 92%

5. TOP PERFORMING COURSES:
   1. CS-401 (Data Structures) - Rating: 4.8
   2. CS-402 (Algorithms) - Rating: 4.7
   3. CS-405 (Database Systems) - Rating: 4.6

RECOMMENDATIONS:
- Increase lab hours for CS-401
- Consider hiring 2 more faculty
- Update CS-303 curriculum
=========================================
```

### **Test Case 4: System Notification Generation**
```
TEST CASE: TC-NOTIFY-004
ACTION: System sends deadline reminders
INPUT: Upcoming assignments due in 24 hours
EXPECTED OUTPUT:
-----------------------------------------
SYSTEM NOTIFICATION BATCH PROCESS
-----------------------------------------
PROCESS STARTED: 2024-03-15 06:00:00
NOTIFICATIONS GENERATED: 342
NOTIFICATIONS SENT: 342
FAILED: 0

NOTIFICATION BREAKDOWN:
- Assignment Reminders: 285
- Course Enrollment: 42
- System Updates: 15

DELIVERY METHODS:
- Email: 342 (100%)
- SMS: 120 (35%)
- In-app: 342 (100%)

SAMPLE NOTIFICATION CONTENT:
Subject: Assignment Due Tomorrow - CS-401
Body: Dear Student,
      Your assignment "Linked List Implementation" 
      is due tomorrow (2024-04-10).
      Please submit before 23:59.
-----------------------------------------
```

---

## 6. SYSTEM REPORTS

### **Report 1: Student Academic Transcript**
```
================================================================
                OFFICIAL ACADEMIC TRANSCRIPT
================================================================
STUDENT INFORMATION:
Name: Sarah Johnson
ID: S2023001
Department: Computer Science
Program: Bachelor of Science
Admission Date: Fall 2022
Current GPA: 3.78 / 4.00

================================================================
COURSE HISTORY - SPRING 2024
================================================================
Code    Course Name                Credits Grade Points
----------------------------------------------------------------
CS-401  Data Structures             3.0    A     12.00
CS-402  Algorithms                  3.0    A-    11.10
MATH-301 Advanced Calculus          3.0    B+    9.90
ENG-205 Technical Writing           2.0    A     8.00
PHYS-202 Modern Physics             3.0    B     9.00
----------------------------------------------------------------
Semester Total: 14.0 Credits | GPA: 3.57
Cumulative Total: 78.0 Credits | CGPA: 3.78

================================================================
ACADEMIC STANDING: GOOD
================================================================
Completed: 78/120 Credits (65%)
Expected Graduation: Spring 2025
Honors: Dean's List (3 semesters)
================================================================
```

### **Report 2: Course Evaluation Summary**
```
===============================================================
            COURSE EVALUATION REPORT - CS-401
===============================================================
Course: Data Structures & Algorithms
Instructor: Dr. Mohamed Ayman
Semester: Spring 2024 | Students Enrolled: 85

---------------------------------------------------------------
EVALUATION METRICS (Scale: 1-5):
---------------------------------------------------------------
1. Course Organization: 4.7
2. Instructor Knowledge: 4.9
3. Material Quality: 4.5
4. Assignment Relevance: 4.6
5. Grading Fairness: 4.4
6. Overall Satisfaction: 4.7

---------------------------------------------------------------
STUDENT COMMENTS SUMMARY:
---------------------------------------------------------------
POSITIVE:
- "Excellent explanations of complex topics"
- "Assignments helped understand real-world applications"
- "Instructor was very responsive to questions"

AREAS FOR IMPROVEMENT:
- "Need more office hours"
- "Some lecture videos had audio issues"
- "More practice problems would be helpful"

---------------------------------------------------------------
GRADE DISTRIBUTION:
---------------------------------------------------------------
A: 25 students (29.4%)
B: 38 students (44.7%)
C: 17 students (20.0%)
D: 3 students (3.5%)
F: 2 students (2.4%)
Withdrawn: 0

---------------------------------------------------------------
RECOMMENDATIONS:
1. Increase office hours by 2 hours/week
2. Update lecture video quality
3. Add more practice exercises
===============================================================
```

### **Report 3: Department Resource Utilization**
```
================================================================
        DEPARTMENT RESOURCE UTILIZATION REPORT
================================================================
Department: Computer Science | Period: Jan-Mar 2024
Generated: 2024-03-31 | Report ID: RES-20240331-CS

---------------------------------------------------------------
1. LABORATORY USAGE:
---------------------------------------------------------------
Lab          Capacity Hours Used Utilization Peak Times
----------------------------------------------------------------
Main Lab        40     280/320     87.5%     Mon 2-4 PM
Network Lab     25     200/240     83.3%     Wed 10-12 AM
Project Lab     30     250/280     89.3%     Fri 1-3 PM
Research Lab    15     110/120     91.7%     Thu 11-1 PM
----------------------------------------------------------------
Average Utilization: 87.7%

---------------------------------------------------------------
2. SOFTWARE LICENSE USAGE:
---------------------------------------------------------------
Software          Licenses Used/Available Utilization
----------------------------------------------------------------
Visual Studio       85/100         85%
MATLAB             42/50          84%
AutoCAD            28/30          93%
VMware             65/80          81%
----------------------------------------------------------------
Total Cost: $15,200 | Cost per Student: $12.16

---------------------------------------------------------------
3. EQUIPMENT STATUS:
---------------------------------------------------------------
Equipment Type  Total Functional Maintenance Due
----------------------------------------------------------------
Desktop PCs     120    115 (96%)   5 (April)
Laptops         50     48 (96%)    2 (May)
Servers         8      8 (100%)    0
Printers        12     11 (92%)    1 (April)
----------------------------------------------------------------
Maintenance Budget: $8,500 | Spent: $6,200 (73%)

---------------------------------------------------------------
4. RECOMMENDATIONS:
---------------------------------------------------------------
1. Purchase 10 more Visual Studio licenses ($2,500)
2. Schedule maintenance for 8 PCs in April
3. Consider extending lab hours on Wednesdays
4. Renew MATLAB license in June ($3,000)
================================================================
```

### **Report 4: System Performance Metrics**
```
================================================================
         LMS SYSTEM PERFORMANCE REPORT - Q1 2024
================================================================
Report Period: Jan 1 - Mar 31, 2024
Generated: 2024-04-01 00:05 | System Uptime: 99.8%

---------------------------------------------------------------
1. USER ACTIVITY STATISTICS:
---------------------------------------------------------------
Total Active Users: 12,850
Daily Active Users (Avg): 3,450
Peak Concurrent Users: 1,250
New Registrations: 1,250
Login Success Rate: 99.2%

User Type        Count   Activity Rate
----------------------------------------
Students         11,500  85.4%
Faculty          850     92.1%
Administrators   50      98.5%
Department Heads 20      96.3%

---------------------------------------------------------------
2. SYSTEM PERFORMANCE:
---------------------------------------------------------------
Metric                      Value     Target Status
----------------------------------------------------
Average Response Time      0.45s     <1.0s  ✅
System Uptime              99.8%     >99.5% ✅
API Success Rate           99.7%     >99.0% ✅
Database Query Time        0.12s     <0.2s  ✅
File Upload Success        98.5%     >98.0% ✅

---------------------------------------------------------------
3. CONTENT AND USAGE:
---------------------------------------------------------------
Total Courses: 350
Active Courses: 342
Assignments Created: 4,250
Submissions Processed: 85,200
Forum Posts: 12,500
Materials Uploaded: 8,450 (45.2 GB)

---------------------------------------------------------------
4. ISSUES AND RESOLUTIONS:
---------------------------------------------------------------
Incident Type          Count   Avg Resolution
------------------------------------------------
Login Issues           45      15 minutes
Upload Failures        28      30 minutes
Gradebook Errors       12      45 minutes
Notification Delays    8       20 minutes

Total Downtime: 14 hours | Scheduled Maintenance: 8 hours

---------------------------------------------------------------
5. RECOMMENDATIONS:
---------------------------------------------------------------
1. Increase server capacity by 20% before fall semester
2. Implement CDN for video content delivery
3. Schedule database optimization for April 15
4. Add backup notification system
================================================================
```

---

## 7. USE CASE DESCRIPTIONS (Key Use Cases)

### **Use Case: Enroll in Course**
- **Actor:** Student
- **Preconditions:** Student is logged in, course is available
- **Main Flow:**
  1. Student browses course catalog
  2. System displays available courses
  3. Student selects desired course
  4. System checks prerequisites
  5. System checks seat availability
  6. System enrolls student
  7. System sends confirmation
- **Postconditions:** Student is enrolled, enrollment count updated

### **Use Case: Grade Assignment**
- **Actor:** Instructor
- **Preconditions:** Assignment submitted, instructor logged in
- **Main Flow:**
  1. Instructor accesses assignment submissions
  2. System displays student submissions
  3. Instructor reviews and grades
  4. System calculates final grade
  5. System updates gradebook
  6. System notifies student
- **Postconditions:** Grades updated, notifications sent

### **Use Case: Generate Department Report**
- **Actor:** Department Head
- **Preconditions:** Department head logged in, data available
- **Main Flow:**
  1. Department head requests report
  2. System gathers department data
  3. System analyzes metrics
  4. System generates report
  5. System displays/saves report
- **Postconditions:** Report available for review

---

## 8. TEST CASE TABLE

| Test ID | Description | Input | Expected Output | Status |
|---------|-------------|-------|----------------|--------|
| TC-ENROLL-001 | Student enrolls in course | StudentID, CourseID | Enrollment confirmation | ✅ |
| TC-ENROLL-002 | Student enrolls in full course | StudentID, FullCourseID | Waitlist option | ✅ |
| TC-ENROLL-003 | Student without prerequisites | StudentID, AdvancedCourseID | Prerequisite error | ✅ |
| TC-ASSIGN-001 | Create assignment | CourseID, AssignmentDetails | Assignment created | ✅ |
| TC-ASSIGN-002 | Submit assignment | StudentID, AssignmentID | Submission confirmed | ✅ |
| TC-ASSIGN-003 | Grade assignment | InstructorID, SubmissionID | Grade updated | ✅ |
| TC-GRADE-001 | Calculate final grade | CourseID, StudentID | Final grade calculated | ✅ |
| TC-REPORT-001 | Generate transcript | StudentID | Academic transcript | ✅ |
| TC-REPORT-002 | Course evaluation | CourseID | Evaluation report | ✅ |
| TC-REPORT-003 | Department stats | DepartmentID | Performance report | ✅ |
| TC-NOTIFY-001 | Deadline reminder | CourseID | Notifications sent | ✅ |
| TC-AUTH-001 | User login | Username, Password | Access granted | ✅ |
| TC-AUTH-002 | Invalid login | Wrong credentials | Access denied | ✅ |

---

## 9. SYSTEM ARCHITECTURE OVERVIEW

```
LAYERED ARCHITECTURE:
1. Presentation Layer (UI)
   - Web Interface
   - Mobile App
   - Admin Dashboard

2. Application Layer
   - Controllers
   - Business Logic
   - Service Layer

3. Business Layer
   - Domain Models
   - Business Rules
   - Validation Logic

4. Data Access Layer
   - Repositories
   - ORM Mapping
   - Database Connections

5. Infrastructure Layer
   - Database (MySQL/PostgreSQL)
   - File Storage
   - External APIs
   - Notification Service
```

---

## 10. SECURITY CONSIDERATIONS

```
SECURITY MEASURES:
1. Authentication: Multi-factor authentication
2. Authorization: Role-based access control
3. Data Encryption: AES-256 for sensitive data
4. Audit Trail: All actions logged
5. Input Validation: Sanitize all user inputs
6. Session Management: Secure session handling
7. Backup: Daily automated backups
8. Compliance: GDPR, FERPA compliant
```
