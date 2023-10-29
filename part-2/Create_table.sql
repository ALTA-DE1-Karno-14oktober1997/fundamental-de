--membuat database
-- Database: data1

-- DROP DATABASE IF EXISTS data1;

CREATE DATABASE data1
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'English_Indonesia.1252'
    LC_CTYPE = 'English_Indonesia.1252'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;
	
--membuat tabel
create table province (
	province_code serial,
	province_name text,
	primary key(province_code)
);
create table city (
	city_code serial,
	city_name text,
	primary key(city_code)
);
create table pekerjaan (
	job_code serial,
	job text,
	primary key (job_code)
);
DROP TABLE pekerjaan;
create table code(
	employee_id serial,
	job_code serial,
	primary key (employee_id),
	foreign key (job_code) references pekerjaan(job_code)
);
create table code_lokasi (
	city_code serial,
	province_code serial,
	primary key (city_code),
	foreign key (city_code) references city(city_code),
	foreign key (province_code) references province(province_code)
);
create table normal (
	employee_id serial,
	employee_name text,
	city_code serial,
	foreign key (employee_id) references code(employee_id),
	foreign key (city_code) references code_lokasi(city_code)
);

--insert table
insert into province ( province_code, province_name) values
	(301, 'New York'), 
	(302, 'California'),
	(303, 'lllinois'),
	(304, 'Texas'),
	(305, 'Florida'),
	(306, 'Messachusetts'),
	(307, 'California'),
	(308, 'Washington'),
	(309, 'Colorado'),
	(310, 'Georgia');

insert into city ( city_code, city_name) values
	(201, 'New York'), 
	(202, 'Los Angeles'),
	(203, 'Chicago'),
	(204, 'Houston'),
	(205, 'Miami'),
	(206, 'Boston'),
	(207, 'San Fransisco'),
	(208, 'Seattle'),
	(209, 'Denver'),
	(210, 'Atlanta');

INSERT INTO pekerjaan (job_code, job)
VALUES
  (101, 'Software Engineer'),
  (102, 'Data Analyst'),
  (103, 'Data Engineer');
delete from pekerjaan;
INSERT INTO code (employee_id, job_code) VALUES 
	(1, 101),
	(2, 102),
	(3, 103),
	(4, 101),
	(5, 102),
	(6, 103),
	(7, 101),
	(8, 102),
	(9, 103),
	(10,101);
INSERT INTO code_lokasi (city_code, province_code) VALUES 
	(201, 301),
	(202, 302),
	(203, 303),
	(204, 304),
	(205, 305),
	(206, 306),
	(207, 307),
	(208, 308),
	(209, 309),
	(210, 310);
INSERT INTO normal (employee_id, employee_name, city_code) VALUES 
	(1, 'John Smoth', 201),
	(2, 'Alice Johnson', 202),
	(3, 'Bob Davis', 203),
	(4, 'Emily Wilson', 204),
	(5, 'Michael Lee', 205),
	(6, 'Sarah Brown', 206),
	(7, 'James Clark', 207),
	(8, 'Laura Taylor', 208),
	(9, 'Daniel White', 209),
	(10, 'Olivia Martin', 210);
	
select normal.employee_id, normal.employee_name, code.job_code, pekerjaan.job, 
city.city_code, city.city_name, code_lokasi.province_code, province.province_name  from normal 
join code on normal.employee_id=code.employee_id
join pekerjaan on pekerjaan.job_code = code.job_code
join city on normal.city_code = city.city_code 
join code_lokasi on code_lokasi.city_code=normal.city_code
join province on province.province_code = code_lokasi.province_code;

select normal.employee_id, normal.employee_name, pekerjaan.job, 
city.city_name, province.province_name  from normal 
join code on normal.employee_id=code.employee_id
join pekerjaan on pekerjaan.job_code = code.job_code
join city on normal.city_code = city.city_code 
join code_lokasi on code_lokasi.city_code=normal.city_code
join province on province.province_code = code_lokasi.province_code;
