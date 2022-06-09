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
	IDPelicula int not null,
	IDProtagonista int not null
)



-------TABLAS NO NECESARIAS-------------

create table Pais(
	ID int not null,
	Nombre varchar(40)
)

create table Usuario(
	Email varchar(60) not null,
	Nombre varchar(40),
	Apellido1 varchar(40),
	Apellido2 varchar(40),
	Password varchar(20),
	FechaNacimiento datetime,
	FechaIngreso datetime,
	Pais int
)

create table PeliculasXUsuario(
	IDPelicula int not null,
	IDUsuario varchar(60) not null
)

create table Genero(
	ID int not null,
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
add constraint Usuario_Pais_FK foreign key (Pais)
references Pais(ID)

alter table PeliculasXUsuario
add constraint PeliculasXUsuario_Pelicula_FK foreign key (IDPelicula)
references Pelicula(ID)

alter table PeliculasXUsuario
add constraint PeliculasXUsuario_Usuario_FK foreign key (IDUsuario)
references Usuario(Email)
go

--------FIN FOREIGN KEYS NO NECESARIAS-----------

----Ejercicio 2 -----

update Pelicula
set Estado = 'I'
FROM Pais inner join Pelicula
on Pais.ID = Pelicula.PaisID
where Pais.Nombre = 'Rusia'
go


----Ejercicio 3 -----

create procedure ejercicio3( @ID int, 
							 @Nombre varchar(40),
							 @Apellido varchar(40),
							 @FechaNacimiento datetime,
							 @Pais int)
as
begin

	insert into Actor(ID, Nombre, Apellido, FechaNacimiento,Pais)
	values(@ID,@Nombre, @Apellido, @FechaNacimiento, @Pais)
end
go


----Ejercicio 4-----



----Ejercicio 5-----

select * from (Actor inner join ActoresXPelicula
on Actor.ID = ActoresXPelicula.IDProtagonista)
inner join Pelicula 

go

----Ejercicio 6-----

create view assocMovie 
as select Nombre, Apellido1, Apellido2 
from Usuario left join PeliculasXUsuario
on Usuario.Email = PeliculasXUsuario.IDUsuario
where PeliculasXUsuario.IDPelicula is null
go

----Ejercicio 7-----

create trigger less_date
on Usuario
instead of insert
as
begin
	declare @Fecha datetime
	select @Fecha = FechaIngreso from inserted

	if(@Fecha > getdate())
	begin
		insert into Usuario
		select * from inserted i
	end
end
go

