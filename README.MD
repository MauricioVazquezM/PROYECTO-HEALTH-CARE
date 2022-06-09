# Proyecto Plenna 2022

![image](https://user-images.githubusercontent.com/98365606/171641574-cb0c606e-dcf7-4993-8eb9-c6ec283fc44d.png)


Plenna es un Start Up  que facilita el servicio de salud femenina reuniendo una atención integral en un solo lugar, es decir, en Plenna se ofrecen servicios de nutrición, psicología, ginecología (principalmente), sexología y sueño. De esta manera, abordan una "*salud integral para la mujer*", cómo bien lo dice su eslogan. 

### Tabla de contenidos
* [Objetivo](#objetivo)
* [Requisitos del problema](#requisitos-del-problema) 
* [Cómo hacer uso de la interfaz gráfica](#cómo-hacer-uso-de-la-interfaz-gráfica) 


## Objetivo

Diseñar e implementar una plataforma tecnológica que permita el almacenamiento, edición, análisis y visualización de la información médica y personal de nuestras pacientes, habilitando así a las doctoras para dar consulta de manera eficiente, compartir información e insights entre ellas para llegar a mejores diagnósticos y proteger la información de las pacientes a través de todo este proceso.

## Requisitos del problema 

-  Repositorios de github con el código generado para cumplir con el objetivo: Este requerimiento se cumple en este mismo repositorio, donde puede encontrar todos los documentos y archivos involucrados en la resolución de este proyecto. 
-  Documentación necesaria para ejecutar el proyecto de manera local y realizar pruebas: Este mismo documento funge como documentación y, puede encontrar un Script con el que fue creada la base de datos en Postgresql, para hacer uso de esta base de datos, simplemente puede usar DBeaver o, inclusive ingresar a la nuve de AWS donde se alberga la base de datos y hacer las pruebas que se necesiten. El Script puede encontrarlo [Aquí](https://github.com/MauricioVazquezM/PROYECTO-HEALTH-CARE/blob/main/ProyectoHealthCare/BD-PLENA.sql). Donde podra encontrar incluso algunos métodos para saber información valiosa de su empresa.
- Documentación tecnica con diagramas de flujo y diagramas de secuencia: puede encontrar este documento [Aquí](https://github.com/MauricioVazquezM/PROYECTO-HEALTH-CARE/blob/main/DOCUMENTACION%20TECNICA.pdf). Además, si desea ver dicha información de una manera más grafica puede consultar las diapositivas que explican el proyecto y que de igual manera contienen los diagramas solicitados. [Presentacion](https://github.com/MauricioVazquezM/PROYECTO-HEALTH-CARE/blob/main/Proyecto%20Health-Care%20Plenna%202022.pdf). 
- Ofrecer vistas análíticas de la base de datos: El query con el que se desarrolló la base de datos (el cual corresponde al Script mencionado anteriormente),  contiene además los querys con los que se desarrollaron las gráficas ánalíticas, utilizando MetaBase. De igual manera, puede encontrar sin necesidad de usar la aplicación las vistas analíticas [aquí](https://github.com/MauricioVazquezM/PROYECTO-HEALTH-CARE/blob/main/PlennaAnalytics.pdf). Además, algunas de estas gráficas son empleadas en la interfaz desarrollada.

## Cómo hacer uso de la interfaz gráfica

El proyecto está desarrollado con una base de datos de Postqresql, la cual se alberga en la nube, esto nos permite que el programa sea accesible y funcional desde cualquier diapositivo. Debido a lo anterior es que, para hacer uso de la interfaz que se ha desarrollado y que puede servir para realizar sus operaciones, basta con descargar la carpeta *Ejecutable*, descomprimir y dar click en el archivo *ProyectoHealthCare.exe* que se encuentra en este mismo repositorio, otorgar los permisos para acceder a la interfaz y listo, ya podrá utilizar la plataforma sin necesidad de instalar nada, gozando de la interfaz como una aplicación de escritorio.

## Funcionalidades de la interfaz

- Contiene un *log in*, el cual permite diferenciar los usuarios y, más importante aún, a la médica general del resto de médicos. La necesidad de esta funcionalidad radica en que cada médico tiene sus pacientes y la médica general tiene funciones que nigún otro médico tiene.
- Es posible visualizar toda la información, de cualquier categoría de la salud de los pacientes que cada médico atiende, más no de los que no. Además, la médica general puede ver la información de cualquier paciente.
- Cualquier médico puede ver las notas sobre su paciente, más sin embargo sólo le es posible modificar las notas propias. Esto sirve para dar diagnósticos más integrados entre las diferentes ramas de estudio de la salud.
- Cada médico puede crear nuevas notas de las consultas con sus pacientes, o puede quitar la vigencia de un diágnostico equivocado, por ejemplo.
- La médica general puede dar acceso (o quitarlo) a otros médicos a editar la información de un paciente, lo que significa que ahora existe una nueva realición médico-paciente.
- A cada médico se le presenta en su interfaz principal información general, estadística, del conglomerado de sus pacientes.
- Ante anomalías o casos extraordinarios la médica general puede comunicar una *NOTA GENERAL* que será visible para todos los médicos que atiendan a ese paciente.
- Cualquier médico puede cambiar su contraseña para logearse.


