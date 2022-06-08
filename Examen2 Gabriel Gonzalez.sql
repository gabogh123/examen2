----Segundo Examne Parcial Gabriel González-----

-----Ejercicio 1------

create table Pelicula(
	ID int not null,
	Nombre varchar(40),
	Duracion int,
	AnioDeLanzamiento datetime,
	Estado char,
	PaisID int,
	Genero int
)

create table Actor(
	ID int not null,
	Nombre varchar(40),
	Apellido varchar(40),
	FechaNacimiento datetime,
	Pais int
)

create table ActoresXPelicula(
	IDPelicula int,
	IDProtagonista int
)



-------TABLAS NO NECESARIAS-------------

create table Pais(
	ID int,
	Nombre varchar(40)
)

create table Usuario(
	Emainl varchar(60),
	Nombre varchar(40),
	Apellido1 varchar(40),
	Apellido2 varchar(40),
	Password varchar(20),
	FechaNacimiento datetime,
	FechaIngreso datetime,
	Pais int
)

create table PeliculasXUsuario(
	IDPelicula int,
	IDUsuario varchar(60)
)

create table Genero(
	ID int,
	Nombre varchar(40)
)


--------FIN TABLAS NO NECESARIAS

alter table Pelicula
add constraint PK_Pelicula primary key (ID)

alter table Actor
add constraint PK_Actor primary key (ID)

alter table ActoresXPelicula
add constraint PK_ActoresXPelicula primary key (IDPelicula,IDProtagonista)


--------PRIMARY KEYS NO NECESARIAS-----------


alter table Pais
add constraint PK_Pais primary key (ID)

alter table Usuario
add constraint PK_Usuario primary key (Email)

alter table PeliculasXUsuario
add constraint PK_PeliculasXUsuario primary key (IDPelicula,IDUsuario)

alter table Genero
add constraint PK_Genero primary key (ID)

--------FIN PRIMARY KEYS NO NECESARIAS-----------

alter table Pelicula
add constraint Pelicula_Pais_FK foreign key (PaisID)
references Pais(ID)

alter table Pelicula
add constraint Pelicula_Genero_FK foreign key (GENERO)
references Genero(ID)

alter table Actor
add constraint Actor_Pais_FK foreign key (Pais)
references Pais(ID)

alter table ActoresXPelicula
add constraint ActoresXPelicula_Pelicula_FK foreign key (IDPelicula)
references Pelicula(ID)

alter table ActoresXPelicula
add constraint ActoresXPelicula_Protagonista_FK foreign key (IDProtagonista)
references Actor(ID)

--------FOREIGN KEYS NO NECESARIAS-----------


alter table Usuario
add constraint Usuario_Pais_FK foreign key (PaisID)
references Pais(ID)

alter table PeliculasXUsuario
add constraint PeliculasXUsuario_Pelicula_FK foreign key (IDPelicula)
references Pelicula(ID)

alter table ActoresXPelicula
add constraint PeliculasXUsuario_Usuario_FK foreign key (IDUsuario)
references Usuario(ID)

--------FIN FOREIGN KEYS NO NECESARIAS-----------



