CREATE TABLE users (
	id SERIAL,
	name TEXT NOT NULL,
	email TEXT NOT NULL,
	active BOOL NOT NULL DEFAULT TRUE
);

INSERT INTO users (name, email, active) VALUES
('Admin', 'admin@admin.com', true),
('User 2', 'user2@local.com', true),
('User 3', 'user3@local.com', true),
('User 4', 'user4@local.com', false);
