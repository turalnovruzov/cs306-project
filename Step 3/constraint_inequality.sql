ALTER TABLE cs306_project.inequality_in_life
ADD CONSTRAINT check_inequality
CHECK (inequality >= 0 AND inequality <= 100)