--
--  Creating real estate database
--

set termout on
set feedback on
prompt Building real estate database.  Please wait ...


DROP TABLE staffMember;
DROP TABLE staffPhone;
DROP TABLE staffAddress;
DROP TABLE sellingAgent;
DROP TABLE listingAgent;
DROP TABLE listedBy;
DROP TABLE property;
DROP TABLE advertisement;
DROP TABLE propertyStatistics;
DROP TABLE openHouse;
DROP TABLE offersMade;
DROP TABLE owns;
DROP TABLE client;
DROP TABLE clientPhone;
DROP TABLE buyer;
DROP TABLE buyerLocation;
DROP TABLE renter;
DROP TABLE owner;
DROP TABLE hasA;
DROP TABLE branch;

DROP TABLE staffMember;
DROP TABLE client;
DROP TABLE property;
DROP TABLE branch;






CREATE TABLE branch (
  branchId VARCHAR2(10) PRIMARY KEY NOT NULL,
  street VARCHAR2(100),
  city VARCHAR2(25),
  zipCode NUMBER(5)
);

CREATE TABLE staffMember (
  staffId VARCHAR2(10) PRIMARY KEY,
  name VARCHAR2(100) NOT NULL,
  email VARCHAR2(50) UNIQUE NOT NULL,
  rating NUMBER (1),
  salary NUMBER (7, 2) NOT NULL,
  branchId VARCHAR2(10) REFERENCES branch(branchId)
);

CREATE TABLE staffPhone (
  staffId VARCHAR2(10) REFERENCES StaffMember(staffId),
  phone VARCHAR2(12) NOT NULL,
  PRIMARY KEY (staffId, phone)
);

CREATE TABLE staffAddress (
  staffId VARCHAR2(10) REFERENCES StaffMember(staffId),
  street VARCHAR2(100),
  city VARCHAR2(25),
  zipCode NUMBER(5),
  PRIMARY KEY (staffId, street)
);

CREATE TABLE sellingAgent (
  staffId VARCHAR2(10) PRIMARY KEY REFERENCES StaffMember(staffId),
  sellingAgentCommission NUMBER (7, 2)
);

CREATE TABLE listingAgent (
  staffId VARCHAR2(10) PRIMARY KEY REFERENCES StaffMember(staffId),
  listingAgentCommission NUMBER (7, 2)
);

CREATE TABLE listedBy (
  staffId VARCHAR2(10) REFERENCES StaffMember(staffId),
  propertyId VARCHAR2(10),
  PRIMARY KEY (staffId, propertyID)
);

CREATE TABLE property (
  propertyId VARCHAR2(10) PRIMARY KEY NOT NULL,
  rentalOrSale VARCHAR2(1) CONSTRAINT ck_rentalOrSale CHECK (rentalOrSale IN ('r', 's')) NOT NULL,
  propertyType VARCHAR2(20) CONSTRAINT ck_propertyType CHECK (propertyType IN ('House','Apartments','Condominium','Townhomes','Manufactured','Lots')) NOT NULL,
  street VARCHAR2(100) NOT NULL,
  city VARCHAR2(25) NOT NULL,
  zipCode INT,
  listingPrice NUMBER(10,2),
  listingDate DATE,
  branchId VARCHAR2(10) REFERENCES branch(branchId) NOT NULL
);

CREATE TABLE advertisement (
  adId VARCHAR2(10) PRIMARY KEY NOT NULL,
  adDate DATE,
  adCost NUMBER(10,2),
  adPublication VARCHAR2(100),
  propertyId VARCHAR2(10) REFERENCES property(propertyId) NOT NULL
);

CREATE TABLE propertyStatistics (
  statsId VARCHAR2(10) PRIMARY KEY NOT NULL,
  numBedrooms INT,
  hoaCost NUMBER(10,2),
  numBathrooms INT,
  onSiteParking VARCHAR2(1) CONSTRAINT ck_onSiteParking CHECK (onSiteParking IN ('y','n')) NOT NULL,
  yearBuilt INT,
  propertyId VARCHAR2(10) REFERENCES property(propertyId) NOT NULL
);

CREATE TABLE openHouse (
  openHouseId VARCHAR2(10) PRIMARY KEY NOT NULL,
  openHouseDate DATE NOT NULL,
  openHouseTime VARCHAR2(5) NOT NULL,
  adPublication VARCHAR2(100),
  propertyId VARCHAR2(10) REFERENCES property(propertyId) NOT NULL
);

CREATE TABLE offersMade (
  offerId VARCHAR2(10) PRIMARY KEY NOT NULL,
  offerDate DATE NOT NULL,
  offerPrice NUMBER(10,2),
  acceptedOrRejected VARCHAR2(8),
  propertyId VARCHAR2(10) REFERENCES property(propertyId) NOT NULL
);

CREATE TABLE owns (
  clientId VARCHAR2(10) PRIMARY KEY NOT NULL,
  propertyId VARCHAR2(10) REFERENCES property(propertyId) NOT NULL
);

CREATE TABLE client (
  clientId VARCHAR2(10) PRIMARY KEY NOT NULL,
  email VARCHAR2(50) NOT NULL,
  name VARCHAR2(100),
  street VARCHAR2(100),
  city VARCHAR2(25),
  zipCode NUMBER(5)
);

CREATE TABLE clientPhone (
  clientId VARCHAR2(10) REFERENCES client (clientId),
  phone VARCHAR2(12)
);

CREATE TABLE buyer (
  clientId VARCHAR2(10) REFERENCES client (clientId),
  minPrice NUMBER(20,2),
  maxPrice NUMBER(20,2),
  amenities VARCHAR2(1000)
);

CREATE TABLE buyerLocation (
  clientId VARCHAR2(10) REFERENCES client (clientId),
  street VARCHAR2(100),
  city VARCHAR2(25),
  zipCode NUMBER(5)
);

CREATE TABLE renter (
  clientId VARCHAR2(10) REFERENCES client (clientId),
  rentalContract VARCHAR2(4000)
);

CREATE TABLE owner (
  clientId VARCHAR2(10) REFERENCES client (clientId),
  ownerType VARCHAR2(1) CONSTRAINT ck_ownerType CHECK (ownerType IN ('s','r')) NOT NULL
);

CREATE TABLE hasA (
  clientId VARCHAR2(10) REFERENCES client (clientId),
  branchId VARCHAR2(10) REFERENCES branch(branchId),
  PRIMARY KEY (clientId, branchId)
);

insert into branch values ('b00000001', '123 Redwood Ln', 'Los Angeles', 90001);
insert into branch values ('b00000002', '2001 Braker Ln', 'Austin', 78757);
insert into branch values ('b00000003', '108 Candlestick Rd', 'Levittown', 19057);

insert into staffMember values ('s00000001', 'Jimi Hendrix', 'jimi@aol.com', 3, 20000, 'b00000001');
insert into staffMember values ('s00000002', 'Janis Joplin', 'janis@aol.com', 5, 40000, 'b00000002');
insert into staffMember values ('s00000003', 'David Bowie', 'david@aol.com', 4, 30000, 'b00000003');
insert into staffMember values ('s00000004', 'Carole King', 'carole@aol.com', 2, 2500, 'b00000001');
insert into staffMember values ('s00000005', 'Joni Mitchell', 'joni@aol.com', 6, 15000, 'b00000002');

insert into staffPhone values ('s00000001', '512-123-1234');
insert into staffPhone values ('s00000001', '800-123-4567');
insert into staffPhone values ('s00000002', '215-890-1672');
insert into staffPhone values ('s00000003', '610-860-7350');
insert into staffPhone values ('s00000004', '212-612-6790');
insert into staffPhone values ('s00000004', '303-724-7352');
insert into staffPhone values ('s00000005', '404-679-3721');

insert into staffAddress values ('s00000001', '763 Eggdrop Ln', 'Los Angeles', 90001);
insert into staffAddress values ('s00000001', '8632 Expresso Rd', 'Los Angeles', 90001);
insert into staffAddress values ('s00000002', '9093 Fern Hollow Pl', 'Austin', 78765);
insert into staffAddress values ('s00000003', '7362 Red Stripe Rd', 'Levittown', 19057);
insert into staffAddress values ('s00000004', '832 Grumpy Cat Rd', 'Los Angeles', 90001);
insert into staffAddress values ('s00000004', '7321 Github Rd', 'Los Angeles', 90001);
insert into staffAddress values ('s00000005', '873 Guitar Ln', 'Austin', 78757);
