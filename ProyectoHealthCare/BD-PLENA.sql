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
	id_medico numeric(4) references medico (id_medico),
	id_paciente numeric(4) references paciente (id_paciente),
	hecha_por varchar(100) not null,
	insight varchar(500) not null,
	vigente bool not null
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
	vigente bool not null
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
	vigente bool not null
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
	vigente bool not null
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
	vigente bool not null
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
	vigente bool not null
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

update m.contra from medico m where m.id_medico = 2;

UPDATE medico
SET contra='prueba1' WHERE contra='dogcat97';

select * from medico;

insert into paciente  
(nombre, edad, ocupacion, genero, sexo ,medicacion_actual, medicamentos)
values
('Julian Gutierrez', 24, 'albanil','Hombre','Masculino','No','Ninguno'),
('Mau Nieto', 21, 'futbolista','Hombre','Masculino','Sí','Paracetamol'),
('Carolina Ramirez', 19, 'secretaria','Mujer','Femenino','No','Ninguno'),
('Paola Sanchez', 16, 'estudiante','Mujer','Femenino','Sí','Aspirina');

insert into paciente  
(nombre, edad, ocupacion, genero, sexo ,medicacion_actual, medicamentos)
values
('Juan Pablo Hermes', 23, 'actuario','Hombre','Masculino','Sí','Citalopram'),
('Lorenza Jimenez', 18,'estudiante','Mujer','Femenino','Sí','Paracetamol'),
('Silvia Gonzalez', 35, 'camionera','Mujer','Femenino','No','Ninguno'),
('Jonathan Carranza', 39, 'ingeniero','Hombre','Masculino','Sí','Diclofenaco'),
('Mayte Villalaz', 39, 'computologa','Mujer','Femenino','Sí','Genoprazol'),
('Fernanda Villapaldo', 16, 'estudiante','Mujer','Femenino','Sí','Paracetamol');

select * from paciente;

insert into paciente_medico
(id_paciente,id_medico)
values 
(4,1),
(6,2),
(7,2),
(8,2),
(9,2),
(10,2);

select * from paciente_medico pm where id_medico = 2;

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

insert into sueno 
(horas_sueno,ronca,pararce_noche,pesadillas,id_paciente)
values 
(8,'Sí','Frecuentemente','No',3);

insert into ginecologia  
(primera_menstruacion,ultima_menstruacion,inicio_vida_sexual,id_paciente)
values 
('De los 10 anos a los 14 anos','2008-12-31',14,3);

select * from ginecologia;


insert into notas_nutricion 
(id_paciente,id_medico,hecha_por,insight,vigente)
values 
(3,2,'Gregory House','El paciente presenta mejoria con su dieta',true);

select * from notas_nutricion;

insert into notas_generales 
(id_medico,id_paciente,hecha_por,insight,vigente)
values 
(2,3,'Gregory House','El paciente ya no asistira a sus citas',true);

select * from sueno;
select * from paciente;

insert into enfermedad
(nombre)
values 
('Diabetes'),
('Pulmonia'),
('Fibromialgia');

select * from enfermedad;

insert into paciente_enfermedad 
(id_paciente,id_enfermedad)
values 
(3,1),
(3,3);

select e.nombre from paciente p inner join paciente_enfermedad using(id_paciente) inner join enfermedad e using(id_enfermedad)
where p.nombre = 'Mau Nieto';

select * from paciente;

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

select * from ginecologia;

insert into ginecologia_anticonceptivos 
(id_ginecologia,id_anticonceptivos)
values
(1,1),
(1,2),
(1,4),
(1,5);

select * from ginecologia g inner join ginecologia_anticonceptivos ga using(id_ginecologia) inner join anticonceptivos a using(id_anticonceptivos);

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

insert into Nutricion
(peso,talla,litros_diarios,ejercicio,dias_semanales_actividad_fisica,id_paciente)
values 
(64.24,32,5,'Sí',4,3);

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

insert into nutricion_ejercicio
(id_nutricion,id_ejercicio)
values
(1,1),
(1,4);

select e.nombre from nutricion n inner join nutricion_ejercicio ne using(id_nutricion) inner join ejercicio e using(id_ejercicio) where n.id_paciente = 3;

