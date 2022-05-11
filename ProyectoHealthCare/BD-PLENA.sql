--Creación de la base de datos
CREATE TABLE medico (
  id_medico numeric(4,0) constraint pk_medico primary key,
  nombre varchar(100) NOT null,
  apellido varchar(100) not null,
  direccion varchar(200) not null,
  numero numeric (10) not null,
  posicion varchar (50) not null,
  edad numeric(2,0) not null
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

create type firstmens as enum('Antes de los 10 años','De los 10 años a los 14 años','Después de los 14 años');

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
  id_ejercicio numeric(4) references anticonceptivos (id_anticonceptivos) ON UPDATE cascade,
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


----------Sueño-------------------------

CREATE TABLE sueño (
  id_sueño numeric(4,0) constraint pk_sueño primary key,
  horas_sueño numeric(4,2) not null, 
  ronca afirNeg not null,
  pararce_noche frec not null,
  pesadillas afirNeg not null,  
  id_paciente numeric(4) references paciente (id_paciente)
);
CREATE SEQUENCE sueño_id_sueño_seq START 1 INCREMENT 1 ;
ALTER TABLE sueño ALTER COLUMN id_sueño SET DEFAULT nextval('sueño_id_sueño_seq');


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

------------------Notas y permisos de sueño------------------------

create table notas_sueño (
	id_notas_sueño numeric (4) constraint pk_notas_sueño primary key,
	id_paciente numeric(4) references paciente (id_paciente),
	id_medico numeric(4) references medico (id_medico),
	hecha_por varchar(100) not null,
	insight varchar(500) not null,
	vigente bool not null
);

CREATE SEQUENCE notas_sueño_id_notas_sueño_seq START 1 INCREMENT 1;
ALTER TABLE notas_sueño ALTER COLUMN id_notas_sueño SET DEFAULT nextval('notas_sueño_id_notas_sueño_seq');


create table permisos_sueño (
	id_permisos_sueño numeric (4) constraint pk_permisos_sueño primary key,
	id_paciente numeric(4) references paciente (id_paciente),
	id_medico numeric(4) references medico (id_medico),
	permiso bool not null 
);

CREATE SEQUENCE permisos_sueño_id_permisos_sueño_seq START 1 INCREMENT 1;
ALTER TABLE permisos_sueño ALTER COLUMN id_permisos_sueño SET DEFAULT nextval('permisos_sueño_id_permisos_sueño_seq');



