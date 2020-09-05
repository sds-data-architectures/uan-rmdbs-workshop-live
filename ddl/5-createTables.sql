SET search_path = courses;
CREATE TABLE classroom
(
    building    varchar(15),
    room_number varchar(7),
    capacity    numeric(4, 0),
    PRIMARY KEY (building, room_number)
);

CREATE TABLE department
(
    dept_name varchar(20),
    building  varchar(15),
    budget    numeric(12, 2) CHECK (budget > 0),
    PRIMARY KEY (dept_name)
);

CREATE TABLE course
(
    course_id varchar(8),
    title     varchar(50),
    dept_name varchar(20),
    credits   numeric(2, 0) CHECK (credits > 0),
    PRIMARY KEY (course_id),
    FOREIGN KEY (dept_name) REFERENCES department (dept_name)
        ON DELETE SET null
);

CREATE TABLE instructor
(
    instructor_id        varchar(5),
    name      varchar(20) not null,
    dept_name varchar(20),
    salary    numeric(8, 2) CHECK (salary > 29000),
    PRIMARY KEY (instructor_id),
    FOREIGN KEY (dept_name) REFERENCES department (dept_name)
        ON DELETE SET null
);

CREATE TABLE section
(
    course_id    varchar(8),
    section_id       varchar(8),
    semester     varchar(6)
        CHECK (semester in ('Fall', 'Winter', 'Spring', 'Summer')),
    year         numeric(4, 0) CHECK (year > 1701 and year < 2100),
    building     varchar(15),
    room_number  varchar(7),
    time_slot_id varchar(4),
    PRIMARY KEY (course_id, section_id, semester, year),
    FOREIGN KEY (course_id) REFERENCES course (course_id)
        ON DELETE CASCADE,
    FOREIGN KEY (building, room_number) REFERENCES classroom (building, room_number)
        ON DELETE SET null
);

CREATE TABLE teaches
(
    teaches_id varchar(5),
    course_id varchar(8),
    section_id    varchar(8),
    semester  varchar(6),
    year      numeric(4, 0),
    PRIMARY KEY (teaches_id, course_id, section_id, semester, year),
    FOREIGN KEY (course_id, section_id, semester, year) REFERENCES section (course_id, section_id, semester, year)
        ON DELETE CASCADE,
    FOREIGN KEY (teaches_id) REFERENCES instructor (instructor_id)
        ON DELETE CASCADE
);

CREATE TABLE student
(
    student_id        varchar(5),
    name      varchar(20) not null,
    dept_name varchar(20),
    tot_cred  numeric(3, 0) CHECK (tot_cred >= 0),
    PRIMARY KEY (student_id),
    FOREIGN KEY (dept_name) REFERENCES department (dept_name)
        ON DELETE SET null
);

CREATE TABLE takes
(
    takes_id        varchar(5),
    course_id varchar(8),
    section_id    varchar(8),
    semester  varchar(6),
    year      numeric(4, 0),
    grade     varchar(2),
    PRIMARY KEY (takes_id, course_id, section_id, semester, year),
    FOREIGN KEY (course_id, section_id, semester, year) REFERENCES section (course_id, section_id, semester, year)
        ON DELETE CASCADE,
    FOREIGN KEY (takes_id) REFERENCES student (student_id)
        ON DELETE CASCADE
);

CREATE TABLE advisor
(
    student_id varchar(5),
    instructor_id varchar(5),
    PRIMARY KEY (student_id),
    FOREIGN KEY (instructor_id) REFERENCES instructor (instructor_id)
        ON DELETE SET null,
    FOREIGN KEY (student_id) REFERENCES student (student_id)
        ON DELETE CASCADE
);

CREATE TABLE time_slot
(
    time_slot_id varchar(4),
    day          varchar(1),
    start_hr     numeric(2) CHECK (start_hr >= 0 and start_hr < 24),
    start_min    numeric(2) CHECK (start_min >= 0 and start_min < 60),
    end_hr       numeric(2) CHECK (end_hr >= 0 and end_hr < 24),
    end_min      numeric(2) CHECK (end_min >= 0 and end_min < 60),
    PRIMARY KEY (time_slot_id, day, start_hr, start_min)
);

CREATE TABLE prereq
(
    course_id varchar(8),
    prereq_id varchar(8),
    PRIMARY KEY (course_id, prereq_id),
    FOREIGN KEY (course_id) REFERENCES course (course_id)
        ON DELETE CASCADE,
    FOREIGN KEY (prereq_id) REFERENCES course (course_id)
);
