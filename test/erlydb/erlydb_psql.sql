DROP TABLE IF EXISTS language;
DROP TABLE IF EXISTS project;
DROP TABLE IF EXISTS person;
DROP TABLE IF EXISTS person_project;
DROP TABLE IF EXISTS customer;
DROP TABLE IF EXISTS store;
DROP TABLE IF EXISTS item;
DROP TABLE IF EXISTS customer_store;
DROP TABLE IF EXISTS customer_customer;


CREATE TABLE language (
	id UUID PRIMARY KEY,
	name VARCHAR(30),
	description TEXT,
	paradigm VARCHAR(30),
	creation_year INTEGER
);

CREATE TABLE project (
	id UUID PRIMARY KEY,
	name VARCHAR(30),
	description TEXT,
	language_id UUID
);

CREATE TABLE person (
 	id SERIAL PRIMARY KEY,
	type VARCHAR(10),
	name VARCHAR(30),
	age INTEGER,
	country VARCHAR(20),
	office INTEGER,
	department VARCHAR(30),
	genre VARCHAR(30),
	instrument VARCHAR(30),
	created_on TIMESTAMP
);

CREATE TABLE person_project(
	person_id INTEGER,
	project_id UUID,
    PRIMARY KEY (person_id, project_id)
);
	
	
CREATE TABLE store (
	number INTEGER,
	name VARCHAR(20),
    PRIMARY KEY (number, name)
);


CREATE TABLE item (
	size INTEGER,
	name VARCHAR(20),
	store_name VARCHAR(20),
	store_number INTEGER,
	PRIMARY KEY(size, name)
);
	
CREATE TABLE customer (
	id SERIAL PRIMARY KEY,
	name VARCHAR(20)
);
	
CREATE TABLE customer_store (
	store_number INTEGER,
	store_name VARCHAR(20),
	customer_id INTEGER,
	PRIMARY KEY(store_number, store_name, customer_id)
);

CREATE TABLE customer_customer (
	customer_id1 INTEGER,
	customer_id2 INTEGER,
	PRIMARY KEY(customer_id1, customer_id2)
);