/**
  Precondition: The specified folder as a parameter must exist.
  Example: 'K:\PostgreSQL124\data\pg_uan_rmdbs_workshoplive_ts'
 */
CREATE TABLESPACE uan_rmdbs_workshoplive_ts
  OWNER postgres
  LOCATION ?;
ALTER TABLESPACE uan_rmdbs_workshoplive_ts
  OWNER TO universitydbuserlive;
