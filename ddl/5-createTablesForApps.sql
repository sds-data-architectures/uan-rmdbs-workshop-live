SET search_path = courses_app;
CREATE TABLE classroom
(
    classroom_id integer PRIMARY KEY,
    building     varchar(15),
    room_number  varchar(7),
    capacity     numeric(4, 0),
    UNIQUE (building, room_number),
    CHECK (classroom_id > 0)
);

CREATE TABLE department
(
    dept_id   integer PRIMARY KEY,
    dept_name varchar(20),
    building  varchar(15),
    budget    numeric(12, 2) CHECK (budget > 0),
    UNIQUE (dept_name),
    CHECK (dept_id > 0)
);

CREATE TABLE course
(
    course_id integer PRIMARY KEY,
    title     varchar(50),
    dept_id   integer,
    credits   numeric(2, 0) CHECK (credits > 0),
    FOREIGN KEY (dept_id) REFERENCES department (dept_id)
        ON DELETE SET null,
    CHECK (course_id > 0)
);

CREATE TABLE instructor
(
    instructor_id integer PRIMARY KEY,
    name          varchar(20) not null,
    dept_id       integer,
    salary        numeric(8, 2) CHECK (salary > 29000),
    FOREIGN KEY (dept_id) REFERENCES department (dept_id)
        ON DELETE SET null,
    CHECK (instructor_id > 0)
);

CREATE TABLE section
(
    section_id   integer PRIMARY KEY,
    course_id    integer,
    classroom_id integer,
    semester     varchar(6)
        CHECK (semester in ('Fall', 'Winter', 'Spring', 'Summer')),
    year         numeric(4, 0) CHECK (year > 1701 and year < 2100),
    time_slot_id integer,
    UNIQUE (course_id, section_id, semester, year),
    FOREIGN KEY (course_id) REFERENCES course (course_id)
        ON DELETE CASCADE,
    FOREIGN KEY (classroom_id) REFERENCES classroom (classroom_id)
        ON DELETE SET null,
    CHECK (section_id > 0)
);

CREATE TABLE teaches
(
    teaches_id integer PRIMARY KEY,
    course_id  integer,
    section_id integer,
    FOREIGN KEY (section_id) REFERENCES section (section_id)
        ON DELETE CASCADE,
    FOREIGN KEY (teaches_id) REFERENCES instructor (instructor_id)
        ON DELETE CASCADE,
    UNIQUE (course_id, section_id),
    CHECK (teaches_id > 0)
);

CREATE TABLE student
(
    student_id integer PRIMARY KEY,
    name       varchar(20) not null,
    dept_id  integer,
    tot_cred   numeric(3, 0) CHECK (tot_cred >= 0),
    FOREIGN KEY (dept_id) REFERENCES department (dept_id)
        ON DELETE SET null,
    CHECK (student_id > 0)
);

CREATE TABLE takes
(
    takes_id   integer PRIMARY KEY,
    course_id  integer,
    section_id integer,
    grade      varchar(2),
    UNIQUE (course_id, section_id),
    FOREIGN KEY (section_id) REFERENCES section (section_id)
        ON DELETE CASCADE,
    FOREIGN KEY (takes_id) REFERENCES student (student_id)
        ON DELETE CASCADE,
    CHECK (takes_id > 0)
);

CREATE TABLE advisor
(
    student_id integer PRIMARY KEY,
    instructor_id integer,
    FOREIGN KEY (instructor_id) REFERENCES instructor (instructor_id)
        ON DELETE SET null,
    FOREIGN KEY (student_id) REFERENCES student (student_id)
        ON DELETE CASCADE,
    CHECK (student_id > 0)
);

CREATE TABLE time_slot
(
    time_slot_id integer PRIMARY KEY,
    time_slot_name varchar(4),
    day          varchar(1),
    start_hr     numeric(2) CHECK (start_hr >= 0 and start_hr < 24),
    start_min    numeric(2) CHECK (start_min >= 0 and start_min < 60),
    end_hr       numeric(2) CHECK (end_hr >= 0 and end_hr < 24),
    end_min      numeric(2) CHECK (end_min >= 0 and end_min < 60),
    UNIQUE (time_slot_name, day, start_hr, start_min),
    CHECK (time_slot_id > 0)
);

CREATE TABLE prereq
(
    prereq_id integer PRIMARY KEY,
    prereq_course_id integer,
    course_id integer,
    UNIQUE (prereq_course_id, course_id),
    FOREIGN KEY (prereq_course_id) REFERENCES course (course_id)
        ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES course (course_id),
    CHECK (prereq_id > 0)
);
