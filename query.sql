CREATE TABLE client
( clientId varchar2(10) PRIMARY KEY not null,
  email varchar2(50) not null,
  name varchar2(100),
  street varchar2(100),
  city varchar2(25),
  zipCode numeric(5)
);
