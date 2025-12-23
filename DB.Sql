CREATE TABLE Users (
    UserID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100) UNIQUE,
    PasswordHash VARCHAR(255),
    Role ENUM('Student','Faculty','Admin'),
    CreatedAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE StudentProfile (
    StudentID INT PRIMARY KEY,
    DepartmentID INT,
    EnrollmentYear YEAR,
    FOREIGN KEY (StudentID) REFERENCES Users(UserID),
    FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID)
);

CREATE TABLE FacultyProfile (
    FacultyID INT PRIMARY KEY,
    DepartmentID INT,
    Qualification VARCHAR(255),
    Expertise VARCHAR(255),
    SocialLinks VARCHAR(255),
    FOREIGN KEY (FacultyID) REFERENCES Users(UserID),
    FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID)
);

CREATE TABLE Department (
    DepartmentID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100)
);

CREATE TABLE Course (
    CourseID INT PRIMARY KEY AUTO_INCREMENT,
    Title VARCHAR(255),
    Description TEXT,
    Code VARCHAR(50),
    CategoryID INT,
    Price DECIMAL(10,2),
    PrerequisiteCourseID INT NULL,
    AverageRating DECIMAL(3,2) DEFAULT 0,
    FOREIGN KEY (CategoryID) REFERENCES Department(DepartmentID),
    FOREIGN KEY (PrerequisiteCourseID) REFERENCES Course(CourseID)
);

CREATE TABLE CourseMaterial (
    MaterialID INT PRIMARY KEY AUTO_INCREMENT,
    CourseID INT,
    Title VARCHAR(255),
    Type ENUM('Video','PDF','Document'),
    URL VARCHAR(255),
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);

CREATE TABLE Enrollment (
    EnrollmentID INT PRIMARY KEY AUTO_INCREMENT,
    StudentID INT,
    CourseID INT,
    EnrolledAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(StudentID, CourseID),
    FOREIGN KEY (StudentID) REFERENCES StudentProfile(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);

CREATE TABLE Assignment (
    AssignmentID INT PRIMARY KEY AUTO_INCREMENT,
    CourseID INT,
    Title VARCHAR(255),
    Description TEXT,
    DueDate DATETIME,
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);

CREATE TABLE Submission (
    SubmissionID INT PRIMARY KEY AUTO_INCREMENT,
    AssignmentID INT,
    StudentID INT,
    SubmissionDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    Grade DECIMAL(5,2),
    FOREIGN KEY (AssignmentID) REFERENCES Assignment(AssignmentID),
    FOREIGN KEY (StudentID) REFERENCES StudentProfile(StudentID)
);

CREATE TABLE Event (
    EventID INT PRIMARY KEY AUTO_INCREMENT,
    Title VARCHAR(255),
    Description TEXT,
    Category VARCHAR(100),
    Date DATE,
    Time TIME,
    Capacity INT,
    ImageURL VARCHAR(255)
);

CREATE TABLE EventRegistration (
    RegistrationID INT PRIMARY KEY AUTO_INCREMENT,
    EventID INT,
    UserID INT,
    UNIQUE(EventID, UserID),
    FOREIGN KEY (EventID) REFERENCES Event(EventID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

CREATE TABLE PricingPlan (
    PlanID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(50),
    Features TEXT,
    Price DECIMAL(10,2),
    AccessLevel INT
);

CREATE TABLE Subscription (
    SubscriptionID INT PRIMARY KEY AUTO_INCREMENT,
    UserID INT,
    PlanID INT,
    StartDate DATE,
    EndDate DATE,
    Status ENUM('Active','Expired'),
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (PlanID) REFERENCES PricingPlan(PlanID)
);

CREATE TABLE Payment (
    PaymentID INT PRIMARY KEY AUTO_INCREMENT,
    SubscriptionID INT,
    Amount DECIMAL(10,2),
    PaymentDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    PaymentMethod VARCHAR(50),
    FOREIGN KEY (SubscriptionID) REFERENCES Subscription(SubscriptionID)
);

CREATE TABLE Discussion (
    DiscussionID INT PRIMARY KEY AUTO_INCREMENT,
    CourseID INT,
    UserID INT,
    Message TEXT,
    CreatedAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);
