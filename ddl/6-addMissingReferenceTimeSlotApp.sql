SET search_path = courses_app;
ALTER TABLE section ADD FOREIGN KEY(time_slot_id) REFERENCES time_slot (time_slot_id);
