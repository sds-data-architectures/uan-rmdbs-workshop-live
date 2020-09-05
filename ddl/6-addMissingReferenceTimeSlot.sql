SET search_path = courses;
ALTER TABLE section ADD FOREIGN KEY(time_slot_id) REFERENCES time_slot (time_slot_id);
