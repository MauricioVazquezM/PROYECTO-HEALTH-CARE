--Creación de la base de datos
CREATE TABLE medico (
  id_medico numeric(4,0) constraint pk_medico primary key,
  nombre varchar(100) NOT null,
  apellido varchar(100) not null,
  direccion varchar(200) not null,
  numero numeric (10) not null,
  posicion varchar (50) not null,
  edad numeric(2,0) not null,
  correo varchar (100) not null,
  contra varchar (100) not null
);

CREATE SEQUENCE medico_id_medico_seq START 1 INCREMENT 1 ;
ALTER TABLE medico ALTER COLUMN id_medico SET DEFAULT nextval('medico_id_medico_seq');

CREATE TABLE especialidad (
  id_especialidad numeric(4,0) constraint pk_especialidad primary key,
  nombre varchar(100) NOT null
);
CREATE SEQUENCE especialidad_id_especialidad_seq START 1 INCREMENT 1 ;
ALTER TABLE especialidad  ALTER COLUMN id_especialidad SET DEFAULT nextval('especialidad_id_especialidad_seq');

CREATE TABLE medico_especialidad (
  id_medico numeric(4) references medico (id_medico) ON UPDATE CASCADE ON DELETE CASCADE,
  id_especialidad numeric(4) references especialidad (id_especialidad) ON UPDATE cascade,
  constraint pk_medico_especialidad primary key (id_medico, id_especialidad)
);

create type gen as enum('Mujer','Hombre','Mujer Transgénero','Hombre Transgénero','Género no binario');
create type sexasig as enum('Femenino','Masculino','Intersexual');
create type afirNeg as enum('Sí','No');

------------------Informacion general del paciente-------------------

CREATE TABLE paciente (
  id_paciente numeric(4) constraint pk_paciente primary key,
  nombre varchar(50) NOT NULL,
  edad numeric(3) not null,
  ocupacion varchar(200) not null,
  genero gen not null,
  sexo sexasig not null,
  medicacion_actual afirNeg not null,
  medicamentos varchar (300) not null
);
CREATE SEQUENCE paciente_id_paciente_seq START 1 INCREMENT 1 ;
ALTER TABLE paciente ALTER COLUMN id_paciente SET DEFAULT nextval('paciente_id_paciente_seq');


CREATE TABLE enfermedad (
  id_enfermedad numeric(4,0) constraint pk_enfermedad primary key,
  nombre varchar(100) NOT null
);
CREATE SEQUENCE enfermedad_id_enfermedad_seq START 1 INCREMENT 1 ;
ALTER TABLE enfermedad ALTER COLUMN id_enfermedad SET DEFAULT nextval('enfermedad_id_enfermedad_seq');

CREATE TABLE paciente_enfermedad (
  id_paciente numeric(4) references paciente (id_paciente) ON UPDATE CASCADE ON DELETE CASCADE,
  id_enfermedad numeric(4) references enfermedad (id_enfermedad) ON UPDATE cascade,
  constraint pk_paciente_enfermedad primary key (id_paciente, id_enfermedad)
);

------------------Ginecología-------------------

create type firstmens as enum('Antes de los 10 anos','De los 10 anos a los 14 anos','Después de los 14 anos');

CREATE TABLE ginecologia (
  id_ginecologia numeric(4,0) constraint pk_ginecologia primary key,
  primera_menstruacion firstmens NOT null,
  ultima_menstruacion date not null,
  inicio_vida_sexual numeric(2,0) not null,
  id_paciente numeric(4) references paciente (id_paciente)
);
CREATE SEQUENCE ginecologia_id_ginecologia_seq START 1 INCREMENT 1 ;
ALTER TABLE ginecologia ALTER COLUMN id_ginecologia SET DEFAULT nextval('ginecologia_id_ginecologia_seq');

CREATE TABLE anticonceptivos (
  id_anticonceptivos numeric(4,0) constraint pk_anticonceptivos primary key,
  nombre varchar(100) not null
);
CREATE SEQUENCE anticonceptivos_id_anticonceptivos_seq START 1 INCREMENT 1 ;
ALTER TABLE anticonceptivos ALTER COLUMN id_anticonceptivos SET DEFAULT nextval('anticonceptivos_id_anticonceptivos_seq');

CREATE TABLE ginecologia_anticonceptivos (
  id_ginecologia numeric(4) references ginecologia (id_ginecologia) ON UPDATE CASCADE ON DELETE CASCADE,
  id_anticonceptivos numeric(4) references anticonceptivos (id_anticonceptivos) ON UPDATE cascade,
  constraint pk_ginecologia_anticonceptivos primary key (id_ginecologia, id_anticonceptivos)
);

------------------Nutrición-------------------

CREATE TABLE nutricion (
  id_nutricion numeric(4,0) constraint pk_nutricion primary key,
  peso numeric(5,2) not null,
  talla numeric(3,1) not null,
  litros_diarios numeric (4,2) not null,
  ejercicio afirNeg not null,
  dias_semanales_actividad_fisica numeric(1) not null,
  id_paciente numeric(4) references paciente (id_paciente)
);
CREATE SEQUENCE nutricion_id_nutricion_seq START 1 INCREMENT 1 ;
ALTER TABLE nutricion ALTER COLUMN id_nutricion SET DEFAULT nextval('nutricion_id_nutricion_seq');

CREATE TABLE ejercicio (
  id_ejercicio numeric(2,0) constraint pk_ejercicio primary key,
  nombre varchar(100) not null
);
CREATE SEQUENCE ejercicio_id_ejercicio_seq START 1 INCREMENT 1;
ALTER TABLE ejercicio ALTER COLUMN id_ejercicio SET DEFAULT nextval('ejercicio_id_ejercicio_seq');

CREATE TABLE nutricion_ejercicio (
  id_nutricion numeric(4) references nutricion (id_nutricion) ON UPDATE CASCADE ON DELETE CASCADE,
  id_ejercicio numeric(4) references ejercicio (id_ejercicio) ON UPDATE cascade,
  constraint pk_nutricion_ejercicio primary key (id_nutricion, id_ejercicio)
);

-------------Psicología---------------

create type tiempo_preo as enum('Hace más de un mes','Hace más de 2 semanas','Hace menos de 2 semanas');
create type frec as enum('Siempre','Pocas veces','Frecuentemente','Nunca');

CREATE TABLE psicologia (
  id_psicologia numeric(4,0) constraint pk_psicologia primary key,
  preocupaciones varchar(200) not null,
  tiempo_preocupaciones tiempo_preo not null,
  agotamiento_emocional frec not null,
  afecta_la_vida afirNeg not null, 
  id_paciente numeric(4) references paciente (id_paciente)
);
CREATE SEQUENCE psicologia_id_psicologia_seq START 1 INCREMENT 1 ;
ALTER TABLE psicologia ALTER COLUMN id_psicologia SET DEFAULT nextval('psicologia_id_psicologia_seq');


------------Sexologia-----------------

create type frecuen as enum('Siempre','En determinada circunstancia','Otro');

CREATE TABLE sexologia (
  id_sexologia numeric(4,0) constraint pk_sexologia primary key,
  dificultad_orgasmo afirNeg not null, 
  frecuencia frecuen not null,
  conformidad_vida_sexual afirNeg not null,
  satisfecho afirNeg not null,  
  id_paciente numeric(4) references paciente (id_paciente)
);
CREATE SEQUENCE sexologia_id_sexologia_seq START 1 INCREMENT 1 ;
ALTER TABLE sexologia ALTER COLUMN id_sexologia SET DEFAULT nextval('sexologia_id_sexologia_seq');


----------Sueno-------------------------

CREATE TABLE sueno (
  id_sueno numeric(4,0) constraint pk_sueno primary key,
  horas_sueno numeric(4,2) not null, 
  ronca afirNeg not null,
  pararce_noche frec not null,
  pesadillas afirNeg not null,  
  id_paciente numeric(4) references paciente (id_paciente)
);
CREATE SEQUENCE sueno_id_sueno_seq START 1 INCREMENT 1 ;
ALTER TABLE sueno ALTER COLUMN id_sueno SET DEFAULT nextval('sueno_id_sueno_seq');


----------Tabla de relación entre paciente y doctor------

CREATE TABLE paciente_medico (
  id_paciente numeric(4) references paciente (id_paciente) ON UPDATE CASCADE ON DELETE CASCADE,
  id_medico numeric(4) references medico (id_medico) ON UPDATE cascade,
  constraint pk_paciente_medico primary key (id_paciente, id_medico)
);


------------------Tablas para permisos------------------------

create table notas_generales (
	id_notas_generales numeric (4) constraint pk_notas_generales primary key,
	id_paciente numeric(4) references paciente (id_paciente),
	id_medico numeric(4) references medico (id_medico),
	hecha_por varchar(100) not null,
	insight varchar(500) not null,
	vigente bool not null,
	fecha date not null
);

CREATE SEQUENCE notas_generales_id_notas_generales_seq START 1 INCREMENT 1 ;
ALTER TABLE notas_generales ALTER COLUMN id_notas_generales SET DEFAULT nextval('notas_generales_id_notas_generales_seq');

------------------Notas y permisos de Nutricion------------------------

create table notas_nutricion (
	id_notas_nutricion numeric (4) constraint pk_notas_nutricion primary key,
	id_paciente numeric(4) references paciente (id_paciente),
	id_medico numeric(4) references medico (id_medico),
	hecha_por varchar(100) not null,
	insight varchar(500) not null,
	vigente bool not null,
	fecha date not null
);

CREATE SEQUENCE notas_nutricion_id_notas_nutricion_seq START 1 INCREMENT 1;
ALTER TABLE notas_nutricion ALTER COLUMN id_notas_nutricion SET DEFAULT nextval('notas_nutricion_id_notas_nutricion_seq');

create table permisos_nutricion (
	id_permisos_nutricion numeric (4) constraint pk_permisos_nutricion primary key,
	id_paciente numeric(4) references paciente (id_paciente),
	id_medico numeric(4) references medico (id_medico),
	permiso bool not null 
);

CREATE SEQUENCE permisos_nutricion_id_permisos_nutricion_seq START 1 INCREMENT 1;
ALTER TABLE permisos_nutricion ALTER COLUMN id_permisos_nutricion SET DEFAULT nextval('permisos_nutricion_id_permisos_nutricion_seq');



------------------Notas y permisos de Psicologia------------------------

create table notas_psicologia (
	id_notas_psicologia numeric (4) constraint pk_notas_psicologia primary key,
	id_paciente numeric(4) references paciente (id_paciente),
	id_medico numeric(4) references medico (id_medico),
	hecha_por varchar(100) not null,
	insight varchar(500) not null,
	vigente bool not null,
	fecha date not null
);

CREATE SEQUENCE notas_psicologia_id_notas_psicologia_seq START 1 INCREMENT 1;
ALTER TABLE notas_psicologia ALTER COLUMN id_notas_psicologia SET DEFAULT nextval('notas_psicologia_id_notas_psicologia_seq');

create table permisos_psicologia (
	id_permisos_psicologia numeric (4) constraint pk_permisos_psicologia primary key,
	id_paciente numeric(4) references paciente (id_paciente),
	id_medico numeric(4) references medico (id_medico),
	permiso bool not null 
);

CREATE SEQUENCE permisos_psicologia_id_permisos_psicologia_seq START 1 INCREMENT 1;
ALTER TABLE permisos_psicologia ALTER COLUMN id_permisos_psicologia SET DEFAULT nextval('permisos_psicologia_id_permisos_psicologia_seq');

------------------Notas y permisos de sexualidad------------------------

create table notas_sexualidad (
	id_notas_sexualidad numeric (4) constraint pk_notas_sexualidad primary key,
	id_paciente numeric(4) references paciente (id_paciente),
	id_medico numeric(4) references medico (id_medico),
	hecha_por varchar(100) not null,
	insight varchar(500) not null,
	vigente bool not null,
	fecha date not null
);

CREATE SEQUENCE notas_sexualidad_id_notas_sexualidad_seq START 1 INCREMENT 1;
ALTER TABLE notas_sexualidad ALTER COLUMN id_notas_sexualidad SET DEFAULT nextval('notas_sexualidad_id_notas_sexualidad_seq');

create table permisos_sexualidad (
	id_permisos_sexualidad numeric (4) constraint pk_permisos_sexualidad primary key,
	id_paciente numeric(4) references paciente (id_paciente),
	id_medico numeric(4) references medico (id_medico),
	permiso bool not null 
);

CREATE SEQUENCE permisos_sexualidad_id_permisos_sexualidad_seq START 1 INCREMENT 1;
ALTER TABLE permisos_sexualidad ALTER COLUMN id_permisos_sexualidad SET DEFAULT nextval('permisos_sexualidad_id_permisos_sexualidad_seq');
------------------Notas y permisos de ginecologia------------------------

create table notas_ginecologia (
	id_notas_ginecologia numeric (4) constraint pk_notas_ginecologia primary key,
	id_paciente numeric(4) references paciente (id_paciente),
	id_medico numeric(4) references medico (id_medico),
	hecha_por varchar(100) not null,
	insight varchar(500) not null,
	vigente bool not null,
	fecha date not null
);

CREATE SEQUENCE notas_ginecologia_id_notas_ginecologia_seq START 1 INCREMENT 1;
ALTER TABLE notas_ginecologia ALTER COLUMN id_notas_ginecologia SET DEFAULT nextval('notas_ginecologia_id_notas_ginecologia_seq');

create table permisos_ginecologia (
	id_permisos_ginecologia numeric (4) constraint pk_permisos_ginecologia primary key,
	id_paciente numeric(4) references paciente (id_paciente),
	id_medico numeric(4) references medico (id_medico),
	permiso bool not null 
);

CREATE SEQUENCE permisos_ginecologia_id_permisos_ginecologia_seq START 1 INCREMENT 1;
ALTER TABLE permisos_ginecologia ALTER COLUMN id_permisos_ginecologia SET DEFAULT nextval('permisos_ginecologia_id_permisos_ginecologia_seq');

------------------Notas y permisos de sueno------------------------

create table notas_sueno (
	id_notas_sueno numeric (4) constraint pk_notas_sueno primary key,
	id_paciente numeric(4) references paciente (id_paciente),
	id_medico numeric(4) references medico (id_medico),
	hecha_por varchar(100) not null,
	insight varchar(500) not null,
	vigente bool not null,
	fecha date not null
);

CREATE SEQUENCE notas_sueno_id_notas_sueno_seq START 1 INCREMENT 1;
ALTER TABLE notas_sueno ALTER COLUMN id_notas_sueno SET DEFAULT nextval('notas_sueno_id_notas_sueno_seq');

create table permisos_sueno (
	id_permisos_sueno numeric (4) constraint pk_permisos_sueno primary key,
	id_paciente numeric(4) references paciente (id_paciente),
	id_medico numeric(4) references medico (id_medico),
	permiso bool not null 
);

CREATE SEQUENCE permisos_sueno_id_permisos_sueno_seq START 1 INCREMENT 1;
ALTER TABLE permisos_sueno ALTER COLUMN id_permisos_sueno SET DEFAULT nextval('permisos_sueno_id_permisos_sueno_seq');

insert into medico  
(nombre, apellido, direccion, numero, posicion ,edad, correo,contra)
values
('Meredith','Grey','Reforma #23', '2378564352',true,34,'meredith@plenna.mx','medicinageneral'),
('Gregory', 'House','Insurgentes #17', '9786543521',false,42,'gregory@plenna.mx','dogcat97');


insert into paciente  
(nombre, edad, ocupacion, genero, sexo ,medicacion_actual, medicamentos)
values
('Julian Gutierrez', 24, 'albanil','Hombre','Masculino','No','Ninguno'),
('Mau Nieto', 21, 'futbolista','Hombre','Masculino','Sí','Paracetamol'),
('Carolina Ramirez', 19, 'secretaria','Mujer','Femenino','No','Ninguno');

select * from paciente p;

insert into paciente_medico
(id_paciente,id_medico)
values 
(1,2),
(2,2),
(3,2);

insert into especialidad 
(nombre)
values 
('Ginecologia'),
('Sexologia'),
('Psicologia'),
('Nutricion'),
('Sueno');

insert into medico_especialidad 
(id_medico,id_especialidad)
values 
(2,4);

insert into medico  
(nombre, apellido, direccion, numero, posicion ,edad, correo,contra)
values
('Romeo','Ramirez','Rio Hondo 24','3333317989',false,54,'romeo@plenna.mx','123456'),
('Kiko','Osorio','Rio Xhico 23','3312345678',false,40,'kiko@plenna.mx','13456'),
('Ernesto','Zereno','Rio azul 13','3332456777',false,39,'ernesto@plenna.mx','3456'),
('David','Macareni','Rio tinto 45','3323234323',false,54,'david@plenna.mx','1235'),
('Tonio','Dominguez','Rio Reforma','3334343433',false,29,'tonio@plenna.mx','128856'),
('Romulo','De Ramoos','Girasol 34','3321212323',false,36,'romulo@plenna.mx','12856'),
('Alfaro','SotoMayor','Chihuahua 89','5224989234',false,45,'alfaro@plenna.mx','1342346');

insert into paciente  
(nombre, edad, ocupacion, genero, sexo ,medicacion_actual, medicamentos)
values
('Juan Pablo Carrillo', 23, 'abogado','Hombre','Masculino','No','Ninguno'),
('Laura Labastida', 22,'actriz','Mujer','Femenino','Sí','Paracetamol'),
('Silvia Corona', 21, 'maestra','Mujer','Femenino','No','Ninguno');


insert into sueno 
(horas_sueno,ronca,pararce_noche,pesadillas,id_paciente)
values 
(8,'Sí','Frecuentemente','No',4);





select * from medico m;
select * from especialidad e;

insert into medico_especialidad 
(id_medico,id_especialidad)
values
(3,5),
(4,1),
(5,2),
(6,3),
(7,4),
(8,5),
(9,1),
(1,2);


insert into paciente  
(nombre, edad, ocupacion, genero, sexo ,medicacion_actual, medicamentos)
values
('Juan Pablo Hermes', 23, 'actuario','Hombre','Masculino','Sí','Citalopram'),
('Lorenza Jimenez', 18,'estudiante','Mujer','Femenino','Sí','Paracetamol'),
('Silvia Gonzalez', 35, 'camionera','Mujer','Femenino','No','Ninguno'),
('Jonathan Carranza', 39, 'ingeniero','Hombre','Masculino','Sí','Diclofenaco'),
('Mayte Villalaz', 39, 'computologa','Mujer','Femenino','Sí','Genoprazol'),
('Fernanda Villapaldo', 16, 'estudiante','Mujer','Femenino','Sí','Paracetamol');

insert into paciente_medico
(id_paciente,id_medico)
values 
(4,1),
(5,2),
(6,3),
(7,4),
(8,5),
(9,6),
(10,7),
(11,8),
(12,9),
(3,1),
(4,2),
(5,3),
(9,4),
(1,5),
(2,6),
(3,7),
(4,8),
(5,9),
(6,1);



---create type frec as enum('Siempre','Pocas veces','Frecuentemente','Nunca');
insert into sueno 
(horas_sueno,ronca,pararce_noche,pesadillas,id_paciente)
values 
(8,'Sí','Frecuentemente','No',1),
(7,'No','Siempre','No',2),
(6,'No','Frecuentemente','No',3),
(5,'No','Pocas veces','No',5),
(8,'Sí','Nunca','No',6),
(7,'Sí','Nunca','No',7),
(6,'Sí','Frecuentemente','No',8),
(5,'No','Pocas veces','No',9),
(4,'Sí','Frecuentemente','No',10),
(7,'No','Pocas veces','No',11),
(5,'Sí','Frecuentemente','No',12);


---create type frecuen as enum('Siempre','En determinada circunstancia','Otro');
insert into sexologia 
(dificultad_orgasmo,frecuencia,conformidad_vida_sexual,satisfecho,id_paciente)
values
('Sí','Siempre','Sí','Sí',1),
('No','En determinada circunstancia','No','No',2),
('Sí','Siempre','No','Sí',3),
('No','En determinada circunstancia','Sí','No',4),
('Sí','Siempre','No','Sí',5),
('No','Otro','Sí','No',6),
('Sí','Siempre','No','Sí',7),
('No','En determinada circunstancia','Sí','No',8),
('Sí','Otro','No','Sí',9),
('No','Siempre','Sí','No',10),
('Sí','Siempre','No','Sí',11),
('Sí','En determinada circunstancia','No','No',12);


--create type tiempo_preo as enum('Hace más de un mes','Hace más de 2 semanas','Hace menos de 2 semanas');
--create type frec as enum('Siempre','Pocas veces','Frecuentemente','Nunca');

insert into psicologia 
(preocupaciones,tiempo_preocupaciones,agotamiento_emocional,afecta_la_vida,id_paciente)
values 
('violencia familiar','Hace más de 2 semanas','Pocas veces','Sí',1),
('violencia social','Hace menos de 2 semanas','Siempre','No',2),
('hambre mundial','Hace más de un mes','Frecuentemente','Sí',3),
('contaminacion','Hace menos de 2 semanas','Nunca','No',4),
('violencia familiar','Hace más de un mes','Siempre','Sí',5),
('violacion','Hace más de un mes','Siempre','No',6),
('violencia familiar','Hace menos de 2 semanas','Frecuentemente','No',7),
('persecusion politica','Hace más de un mes','Siempre','Sí',8),
('contaminacion','Hace más de un mes','Siempre','Sí',9),
('violencia familiar','Hace más de 2 semanas','Frecuentemente','No',10),
('insuficiencia economica','Hace más de un mes','Siempre','Sí',11),
('violencia familiar','Hace más de 2 semanas','Frecuentemente','No',12);

select * from psicologia p;

insert into enfermedad 
(nombre)
values 
('Gastroenteritis'),
('Depresion'),
('Clamidia'),
('Influenza'),
('Obesidad'),
('VIH'),
('Bipolaridad'),
('Alzheimer'),
('Mal de Parkinson'),
('Estres postraumatico'),
('Hipertiroidismo');

select * from enfermedad e;
insert into paciente_enfermedad 
(id_paciente, id_enfermedad)
values 
(1,1),
(2,2),
(3,3),
(4,4),
(5,5),
(6,6),
(7,7),
(8,8),
(9,9),
(10,11),
(11,10),
(12,1),
(5,6),
(7,9),
(9,8);

select * from paciente_enfermedad pe;

insert into ejercicio 
(nombre)
values 
('Caminar'),
('Eliptica'),
('Bicicleta estatica'),
('Pesas o ejercicios de fuerza'),
('Yoga'),
('Actvidades al aire libre'),
('Otro');

insert into nutricion 
(peso,talla,litros_diarios,ejercicio,dias_semanales_actividad_fisica,id_paciente)
values 
(122.5,1.9,2.5,'Sí',4,1),
(56.7,1.6,3.5,'Sí',5,2),
(80,1.7,3.5,'Sí',6,3),
(99,1.9,1.5,'No',0,4),
(80,1.7,3,'No',0,5),
(78.9,1.6,2.5,'Sí',6,6),
(72.5,1.7,2.5,'Sí',4,7),
(82.5,1.8,3.5,'Sí',3,8),
(62.5,1.6,2.5,'Sí',4,9),
(42.5,1.5,3.5,'Sí',4,10),
(67,1.6,1.5,'Sí',2,11),
(122.5,1.8,2.5,'Sí',7,12);

select * from nutricion n;

insert into nutricion_ejercicio 
(id_nutricion,id_ejercicio)
values 
(1,1),
(2,2),
(3,3),
(4,4),
(5,5),
(6,6),
(7,7),
(8,1),
(9,2),
(10,3),
(11,4),
(12,5),
(8,6),
(9,7),
(6,1);

insert into anticonceptivos 
(nombre)
values
('Condón'),
('Sistema de larga duración hormonal (Mirena o Kyleena)'),
('DIU de cobre o DIU de plata'),
('Implante subdérmico'),
('Anticonceptivos orales combinados'),
('Anillo vaginal'),
('Parche'),
('Inyección'),
('Ciclo natural'),
('Espermicidas (lámina, esponja, gel)'),
('Coitus interruptus / método del retiro / método de la marcha atrás'),
('Ligación o corte de trompas uterinas'),
('Vasectomía'),
('Ninguno');

insert into ginecologia 
(primera_menstruacion,ultima_menstruacion,inicio_vida_sexual ,id_paciente)
values
('Después de los 14 anos','2008-06-15','12',1),
('Antes de los 10 anos','2008-08-15','11',2),
('De los 10 anos a los 14 anos','2008-09-15','12',3),
('Antes de los 10 anos','2008-10-15','11',4),
('De los 10 anos a los 14 anos','2008-11-15','10',5),
('Antes de los 10 anos','2008-12-15','10',6),
('Después de los 14 anos','2008-11-15','12',7),
('Antes de los 10 anos','2008-12-15','11',8),
('Después de los 14 anos','2008-11-15','13',9),
('De los 10 anos a los 14 anos','2008-10-15','11',10),
('Después de los 14 anos','2008-11-15','12',11),
('Antes de los 10 anos','2008-11-15','12',12);

select * from anticonceptivos a;
insert into ginecologia_anticonceptivos 
(id_ginecologia,id_anticonceptivos)
values
(1,1),
(2,2),
(3,3),
(4,4),
(5,5),
(6,6),
(7,7),
(8,8),
(9,9),
(10,10),
(11,11),
(12,12),
(11,13),
(8,14),
(9,1),
(3,2);

select * from especialidad me; 

select * from medico_especialidad;

insert into permisos_nutricion 
(id_paciente,id_medico,permiso)
values
(1,2,true),
(2,2,true),
(3,2,true),
(5,2,true),
(10,7,true),
(4,2,true),
(3,7,true);

insert into permisos_ginecologia  
(id_paciente,id_medico,permiso)
values
(7,4,true),
(12,4,true),
(9,4,true),
(5,9,true);

insert into permisos_psicologia  
(id_paciente,id_medico,permiso)
values
(9,6,true),
(2,6,true);

insert into permisos_sexualidad  
(id_paciente,id_medico,permiso)
values
(8,5,true),
(3,1,true),
(1,5,true),
(4,1,true),
(6,1,true);

insert into permisos_sueno 
(id_paciente,id_medico,permiso)
values
(6,3,true),
(11,8,true),
(5,3,true),
(4,8,true);

select * from paciente_medico pm;
select * from notas_generales ng;
select * from notas_nutricion;
select * from notas_sexualidad ns;

select count(*) from paciente p;
select count(*) from medico p;


---QUERIES GENERALES
select * from medico m;
select * from paciente p;

select pm.id_medico ,count(*)
from paciente_medico pm join medico m using(id_medico)
group by pm.id_medico
order by pm.id_medico asc;

select aux.rango_edad, count(*)
from (select m.edad, case 
	when m.edad<= 35 then 'menor a 35 anhos'
	when m.edad > 35 and m.edad<=45  then 'entre 35 y 45 anhos'
	else 'mayor a 45 anhos'
	end as rango_edad
	from medico m) as aux
group by aux.rango_edad;

select aux.rango_edad, count(*)
from (select p.edad, case 
	when p.edad<= 25 then 'menor a 25 anhos'
	when p.edad > 25 and p.edad<=35  then 'entre 25 y 35 anhos'
	else 'mayor a 35 anhos'
	end as rango_edad
	from paciente p) as aux
group by aux.rango_edad;

select p.sexo as sexo_biologico, count(*) 
from paciente p 
group by p.sexo;

select p.genero as genero, count(*) 
from paciente p 
group by p.genero;

select p.medicamentos as medicamentos, count(*) 
from paciente p 
group by p.medicamentos;

select e.nombre, count(*) from paciente p inner join paciente_enfermedad pe 
using (id_paciente) inner join enfermedad e using(id_enfermedad) group by e.nombre;


----QUERIES POR RAMAS

--1)SEXOLOGIA
select * from sexologia s;

select s.conformidad_vida_sexual, count(*)
from sexologia s
group by s.conformidad_vida_sexual;

select s.dificultad_orgasmo , count(*)
from sexologia s
group by s.dificultad_orgasmo;

select s.frecuencia  , count(*)
from sexologia s
group by s.frecuencia;

select s.satisfecho , count(*)
from sexologia s
group by s.satisfecho ;


--2)GINECOLOGIA
select * from ginecologia g;

select g.primera_menstruacion, count(*)
from ginecologia g 
group by g.primera_menstruacion;

select g.inicio_vida_sexual, count(*) 
from ginecologia g 
group by g.inicio_vida_sexual;

select a.nombre, count(*) from ginecologia g inner join ginecologia_anticonceptivos ga using(id_ginecologia) 
inner join anticonceptivos a using(id_anticonceptivos) group by a.nombre;


--3)NUTRICION
select * from nutricion n;

select n.litros_diarios, count(*)
from nutricion n 
group by n.litros_diarios;

select n.ejercicio , count(*)
from nutricion n 
group by n.ejercicio;

select e.nombre, count(*) from nutricion inner join nutricion_ejercicio ne using(id_nutricion) 
inner join ejercicio e using(id_ejercicio) group by e.nombre;

select aux.rango_peso, count(*)
from (select n.peso, case 
	when n.peso<= 60 then 'menor a 60 kg'
	when n.peso > 60 and n.peso<=80  then 'entre 60 kg y 80 kg'
	else 'mayor a 80'
	end as rango_peso
	from nutricion n) as aux
group by aux.rango_peso;

select aux.rango_estatura, count(*)
from (select n.talla, case 
	when n.talla<= 1.5 then 'menor a 1.5m'
	when n.talla > 1.5 and n.talla<=1.8  then 'entre 1.5m y 1.8m'
	else 'mayor a 1.8m'
	end as rango_estatura
	from nutricion n) as aux
group by aux.rango_estatura;

select aux.rango_dias_act_fisica, count(*)
from (select n.talla, case 
	when n.dias_semanales_actividad_fisica<= 2 then 'menos de 2 dias'
	when n.dias_semanales_actividad_fisica > 2 and n.dias_semanales_actividad_fisica<=4  then 'entre 2 y 4 dias'
	else 'mas de 4 dias'
	end as rango_dias_act_fisica
	from nutricion n) as aux
group by aux.rango_dias_act_fisica;

---4)SUENO
select * from sueno s;

select s.ronca  , count(*)
from sueno s  
group by s.ronca ;

select s.pararce_noche  , count(*)
from sueno s 
group by s.pararce_noche ;

select s.pesadillas, count(*)
from sueno s 
group by s.pesadillas;

select aux.rango_sueno, count(*)
from (select s.horas_sueno, case 
	when s.horas_sueno <= 5 then 'menor a 6'
	when s.horas_sueno > 6 then ' mayor a 6'
	else 'igual a 6'
	end as rango_sueno
	from sueno s) as aux
group by aux.rango_sueno;


---5)PSICOLOGIA
select * from psicologia p;

select p.agotamiento_emocional , count(*)
from psicologia p 
group by p.agotamiento_emocional ;

select p.afecta_la_vida , count(*)
from psicologia p 
group by p.afecta_la_vida ;

select p.preocupaciones, count(*)
from psicologia p 
group by p.preocupaciones;

select p.tiempo_preocupaciones, count(*)
from psicologia p 
group by p.tiempo_preocupaciones;
