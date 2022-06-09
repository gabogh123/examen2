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


alter table Pelicula
add constraint PK_Pelicula primary key (ID)

alter table Actor
add constraint PK_Actor primary key (ID)

alter table ActoresXPelicula
add constraint PK_ActoresXPelicula primary key (IDPelicula,IDProtagonista)


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

create procedure delete_movie(@ID int) 

go
----Ejercicio 5-----


select Actor.Nombre, Actor.Apellido, COUNT(*) as CantPeliculas, SUM(Duracion) as Duracion_Total ,AVG(Duracion) as Duracion_Promedio 
from (Actor left join ActoresXPelicula
on Actor.ID = ActoresXPelicula.IDProtagonista)
inner join Pelicula on ActoresXPelicula.IDPelicula = Pelicula.ID
group by  Actor.Nombre, Actor.Apellido
order by Actor.Nombre, Actor.Apellido
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

