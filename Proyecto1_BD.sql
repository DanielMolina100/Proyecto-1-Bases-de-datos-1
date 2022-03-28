--PROYECTO 1 BD
--BANCO PELICANO
--CREACION DE LA TABLA CLIENTES
drop table cliente
Create table cliente(
id_cliente int not null,
dpi varchar(13) not null,
nombre varchar(100) not null,
apellido varchar(100) not null,
telefono varchar(15)not null,
correo varchar(100)not null,
fecha_nac date not null,
CONSTRAINT PK_IDCLIENTE PRIMARY KEY(id_cliente),
CONSTRAINT CHK_FechaNacimiento CHECK(DATEDIFF(YEAR,fecha_nac, GETDATE()) >=45)
)

--DATOS DE LA TABLA CLIENTE
insert into cliente(id_cliente,dpi,nombre,apellido,telefono,correo,fecha_nac)
values('1','3042574000114','Daniel','Molina','30866123','josdanielmg@gmail.com','1945-06-20')
insert into cliente(id_cliente,dpi,nombre,apellido,telefono,correo,fecha_nac)
values('2','1284701481292','Manuel','Gomez','31234144','akdjslfa@gmail.com','1968-09-12')
insert into cliente(id_cliente,dpi,nombre,apellido,telefono,correo,fecha_nac)
values('3','2488014294811','Dayanna','Perez','24124141','lugato@gmail.com','1978-12-12')

Select * from cliente;
--Agregar dueño o beneficiario
--tabla del nuevo dueño

drop table beneficiario
create table beneficiario(
id_cliente int not null,
id_beneficiario varchar(10) not null,
dpi varchar(13),
nombre varchar(100)not null,
apellido varchar(100)not null,
telefono varchar(100)not null,
correo varchar(100) not null,
fecha_nac date not null,
CONSTRAINT PK_IdBeneficiario PRIMARY KEY (id_beneficiario),
CONSTRAINT FK_IdCliente FOREIGN KEY (id_cliente)references cliente(id_cliente)
)
--DATOS DE LA TABLA BENEFICIARIO
insert into beneficiario(id_cliente,id_beneficiario,dpi,nombre,apellido,telefono,correo,fecha_nac)
values('1','B1','3044274000114','Gustavo','Castro','30346521','Gustavin@gmail.com','1948-11-23')
insert into beneficiario(id_cliente,id_beneficiario,dpi,nombre,apellido,telefono,correo,fecha_nac)
values('2','B2','1242574000101','Camila','Bonifasi','57240505','camilix12@gmail.com','1981-01-09')
insert into beneficiario(id_cliente,id_beneficiario,dpi,nombre,apellido,telefono,correo,fecha_nac)
values('3','B3','3042574000114','Carla','Klee','90984321','CarlexKe@gmail.com','1960-12-28')

Select * from beneficiario;

--Creacion de la tabla cuentas bancarias donde se relaciona con los clientes
Drop table cuenta_bancaria

Create table cuenta_bancaria(
id_cliente int not null,
id_cuenta int not null,
tipo_cuenta varchar(100) not null,
Fecha_Inicio date not null DEFAULT GETDATE(),
Lugar varchar(100),
CONSTRAINT PK_CUENTA PRIMARY KEY(id_cuenta),
CONSTRAINT FK_CUENTA FOREIGN KEY(id_cliente) references cliente(id_cliente),
CONSTRAINT CHK_VAL_TIPOCUENTA CHECK((tipo_cuenta = 'Comercial') or (tipo_cuenta = 'Premium')),
CONSTRAINT CHK_VAL_FechaInici CHECK(DATEDIFF(DAY,Fecha_Inicio,GETDATE()) >= 0),
)
--datos de cuenta bancaria
insert into cuenta_bancaria(id_cliente,id_cuenta,tipo_cuenta,Fecha_Inicio,Lugar)
values('1','011','Comercial','2022-01-01','Guatemala')
insert into cuenta_bancaria(id_cliente,id_cuenta,tipo_cuenta,Fecha_Inicio,Lugar)
values('2','022','Premium','2012-02-10','Mixco')
insert into cuenta_bancaria(id_cliente,id_cuenta,tipo_cuenta,Fecha_Inicio,Lugar)
values('3','033','Comercial','2021-12-25','Guatemala')


--Mostrar datos de tabla cuenta bancaria
select*from cuenta_bancaria

--Tabla de comercial y sus datos
drop table CComercial
create table CComercial(
id_Cuenta_Comercial varchar(100) not null,
cantidad_inicio int not null,
id_cuenta int not null,
CONSTRAINT CHK_CantAPertura CHECK ( cantidad_inicio > 50000),
CONSTRAINT PK_CuentaComercial PRIMARY KEY (id_Cuenta_Comercial),
CONSTRAINT FK_CComercial FOREIGN KEY (id_cuenta) REFERENCES cuenta_bancaria(id_cuenta)
)
--Ingresar los datos de la cuenta comercial
insert into CComercial(id_Cuenta_Comercial, cantidad_inicio,id_cuenta)
values('BI19','80000','011')
insert into CComercial(id_Cuenta_Comercial, cantidad_inicio,id_cuenta)
values('BAC1','51000','033')

--Mostrar los datos de la cuenta comercial
select*from CComercial
--Verificar si la cuenta es unicamente COMERCIAL si es premium no es de esta cuenta
select*from cuenta_bancaria where tipo_cuenta = 'Comercial'

--Tabla de los cobros de la cuenta comercial
drop table CobroComercial
Create Table CobroComercial(
id_Cuenta_Comercial varchar(100) not null,
id_CobroComercial varchar(20)not null,
tipo varchar(20) not null,
moneda varchar(20) not null,
CONSTRAINT CHK_VALIDA_COBRO CHECK((tipo = 'Deposito') or (tipo='Retiros')or(tipo='Efectivo')),
CONSTRAINT CHK_MONEDA CHECK((moneda='euro' or moneda='euros') or (moneda='dolar' or moneda='dolares')),
CONSTRAINT FK_CUENTACOMERCIAL FOREIGN KEY (id_Cuenta_Comercial) references CComercial (id_Cuenta_Comercial),
CONSTRAINT PK_COBROCOMERCIAL PRIMARY KEY (id_CobroComercial),
)
Drop table Transaccion_A
Create table Transaccion_A(
id_A int not null,
id_Cuenta_Comercial varchar(100) not null,
id_Origen varchar(100) not null,
id_Destino int not null,
TipoMoneda varchar(50) not null,
Pais varchar(30) not null,
Cantidades int not null,
FechaTransaccion date not null,
horario varchar(100) not null,
CONSTRAINT CHK_MONEDAS CHECK((TipoMoneda='euro' or TipoMoneda='euros') or ( TipoMoneda = 'dolar' or TipoMoneda='dolares')),
CONSTRAINT PK_TRANSACCIONA PRIMARY KEY (id_A),
CONSTRAINT CHK_ORIGEN CHECK(id_Origen = id_Cuenta_Comercial),
CONSTRAINT FK_TRANSACCIONA FOREIGN KEY (id_Cuenta_Comercial)references CComercial (id_Cuenta_Comercial),
)

--Insertar datos en transacciones de tipo A
insert into Transaccion_A(id_A,id_Cuenta_Comercial,id_Origen,id_Destino,TipoMoneda,Pais,Cantidades,FechaTransaccion,horario)
values ('100','BI19','BI19','948','dolares','Guatemala','90000','2022-01-03','11:51') 
insert into Transaccion_A(id_A,id_Cuenta_Comercial,id_Origen,id_Destino,TipoMoneda,Pais,Cantidades,FechaTransaccion,horario)
values ('101','BI19','BI19','112','dolares','Guatemala','80000','2022-11-13','08:10') 

select*from CComercial
select * from Transaccion_A

--Creacion de tabla de cuentas PREMIUM
drop table CuentaPremium
Create table CuentaPremium(
id_premium int not null,
id_cuenta int not null,
cantidadAper money not null,
Tipo_CuentaPremium varchar(20) not null,
CONSTRAINT FK_IDPREMIUM FOREIGN KEY(id_cuenta) references cuenta_bancaria(id_cuenta),
CONSTRAINT PK_IDPREMIUMS PRIMARY KEY(id_premium),
CONSTRAINT CHK_VALIDOCUENTAPRIMIUM CHECK(cantidadAper> 500000),
CONSTRAINT CHK_TIPOCUENTAPRIMIUM CHECK((Tipo_CuentaPremium='euro' or Tipo_CuentaPremium='euros') or ( Tipo_CuentaPremium = 'dolar' or Tipo_CuentaPremium='dolares')),
)

--INSERTAR DATOS DE LA TABLA CUENTA PREMIUM
insert into CuentaPremium(id_premium,id_cuenta,cantidadAper,Tipo_CuentaPremium)
values('14','011','1000000','dolares')
insert into CuentaPremium(id_premium,id_cuenta,cantidadAper,Tipo_CuentaPremium)
values('15','022','700000','dolares')
insert into CuentaPremium(id_premium,id_cuenta,cantidadAper,Tipo_CuentaPremium)
values('16','033','1200000','euros')


Select * From cuenta_bancaria
select * from CuentaPremium

--TRANSACCIONES TIPO B
drop table transb
create table transb(
id_premium int not null,
id_tipoB int not  null,
id_Origen varchar(100) not null,
id_Destino int not null,
monedas varchar(12),
pais varchar (50) not null,
cantidad varchar(100)not null,
fecha date not null,
hora varchar(20) not null,
CONSTRAINT pk_idTipoB PRIMARY KEY(id_tipoB),
CONSTRAINT fk_TransB FOREIGN KEY (id_premium) references CuentaPremium(id_premium),
CONSTRAINT validar_moneda CHECK((monedas = 'Dolares' or monedas = 'dolares') or (monedas = 'Euros') or (monedas = 'euros')),
CONSTRAINT valida_cuentaorigenb CHECK(id_Origen =id_premium),
)

--Ingreso de datos en las transacciones tipo b
insert into transb(id_premium,id_tipoB,id_Origen,id_Destino,monedas,pais,cantidad,fecha,hora)
values('14','0101','14','0912','dolares','Guatemala','500000','2022-01-01','11:11')
insert into transb(id_premium,id_tipoB,id_Origen,id_Destino,monedas,pais,cantidad,fecha,hora)
values('15','0114','15','0242','euros','Guatemala','900000','2021-11-24','12:21')

--mostrar los datos
select * from CuentaPremium
select * from transb

drop table CobroPremium
create table CobroPremium(
id_premium int not null,
id_CPremium int not null,
tipo varchar(15) not null,
CONSTRAINT fk_Idpremiums FOREIGN KEY (id_premium) references CuentaPremium(id_premium),
CONSTRAINT PK_id_CPremium  PRIMARY KEY(id_CPremium),
CONSTRAINT CHK_VALIDA_COBRO2 CHECK((tipo = 'Deposito') or (tipo='Retiros')or(tipo='Efectivo')),
)

--Crear tabla de bitcoins
drop table Bitcoin
create table Bitcoin(
id_premium int not null,
id_bicoins int not null,
monto int not null,
moneda varchar(100) not null,
fecha date,
horario varchar(15),
CONSTRAINT fk_Id_depremiums FOREIGN KEY (id_premium) references CuentaPremium(id_premium),
CONSTRAINT PK_id_BITCOIN  PRIMARY KEY(id_bicoins),
CONSTRAINT CHK_DOLARES CHECK((moneda = 'Dolares' or moneda = 'dolares')),
CONSTRAINT validar_hora_transaccion CHECK((CAST(SUBSTRING(horario,0,3) AS INT) BETWEEN 8 AND 14))	
)

--Agregar datos a la tabla de bitcoins

insert into Bitcoin(id_premium,id_bicoins,monto,moneda,fecha ,horario)
values('14','1500','141599','dolares','2022-10-12','12:00')
insert into Bitcoin(id_premium,id_bicoins,monto,moneda,fecha ,horario)
values('15','1600','901599','dolares','2022-01-10','10:00')

--agregar los datos a la tabla bitcoins y tambien los pagos realizados en bitcoins, por comercio
select*from Bitcoin


--ultima parte del dashboard
--cuantas cuentas se aperturan por dia
select COUNT(tipo_cuenta)'cantidad de cuentas ',tipo_cuenta,Fecha_Inicio from cuenta_bancaria where(Fecha_Inicio= '2022-03-27') group by tipo_cuenta,Fecha_Inicio

-- Qué país realiza más transacciones por Bitcoin.select nombre,id_cliente into #Clientes_Tempo from cliente order by nombre asc
select  id_cliente,Tipo_Cuenta into #TipoCuenta from cuenta_bancaria order by Tipo_Cuenta asc
select ct.nombre,COUNT(ct.nombre) as 'cantida de nacionalidades ',tp.Tipo_Cuenta from #Clientes_Tempo ct inner join #TipoCuenta tp on ct.id_cliente = tp.id_cliente group by ct.nombre,tp.Tipo_Cuenta

--Información de clientes que tienen más de 30 años y que comparten cuentas.
select id_cliente into #EdadClientes from cliente where DATEDIFF(YEAR,fecha_nac, GETDATE()) >= 30
select cd.id_cliente into #Beneficiarios_id from beneficiario b inner join #EdadClientes cd  on b.id_cliente=cd.id_cliente group by cd.id_cliente,b.id_cliente having count (cd.id_cliente)>0
select c.id_cliente,c.DPI,c.Nombre,c.Apellido,c.fecha_nac,c.telefono,c.correo from cliente c inner join #Beneficiarios_id bi on c.id_cliente = bi.id_cliente 


--Que pais realiza mas bitcoins

select count(tipo_cuenta) Cant_Cuentas from cuenta_bancaria where DATEDIFF(YEAR,Fecha_Inicio, GETDATE()) > 5
--  Cuantas cuentas tipo comercio tienen más de 5 años de apertura. 
--- Listado de transacciones en el último trimestre, que corresponden a montos arriba de $ 100,000 (dólares y euros) y que sean realizadas entre las 11 pm y 3 am.
SELECT * into #TRANSFERENCIAS FROM Transaccion_A where ((Cantidades > 100000) and (DATEDIFF(MONTH,FechaTransaccion, GETDATE()) = 3) AND ( (CAST(SUBSTRING(horario,0,3) AS INT) BETWEEN 1 AND 2) OR (CAST(SUBSTRING(horario,0,3) AS INT) BETWEEN 11 AND 24)))
SELECT * into #TRANSFERENCIASB FROM transb where ((cantidad > 100000) and (DATEDIFF(MONTH,fecha, GETDATE()) = 3) AND ( (CAST(SUBSTRING(hora,0,3) AS INT) BETWEEN 1 AND 2) OR (CAST(SUBSTRING(hora,0,3) AS INT) BETWEEN 11 AND 24)))
SELECT * into #TRANSFERENCIASBITCOIN FROM Bitcoin where ((monto > 100000) and (DATEDIFF(MONTH,fecha ,GETDATE()) = 3) AND ( (CAST(SUBSTRING(horario,0,3) AS INT) BETWEEN 1 AND 2) OR (CAST(SUBSTRING(horario,0,3) AS INT) BETWEEN 11 AND 24)))
