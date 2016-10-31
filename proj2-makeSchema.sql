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

insert into branch values ('b000000001', '123 Redwood Ln', 'Los Angeles', 90001);
insert into branch values ('b000000002', '2001 Braker Ln', 'Austin', 78757);
insert into branch values ('b000000003', '108 Candlestick Rd', 'Levittown', 19057);

insert into staffMember values ('s000000001', 'Jimi Hendrix', 'jimi@aol.com', 3, 20000, 'b000000001');
insert into staffMember values ('s000000002', 'Janis Joplin', 'janis@aol.com', 5, 40000, 'b000000002');
insert into staffMember values ('s000000003', 'David Bowie', 'david@aol.com', 4, 30000, 'b000000003');
insert into staffMember values ('s000000004', 'Carole King', 'carole@aol.com', 2, 2500, 'b000000001');
insert into staffMember values ('s000000005', 'Joni Mitchell', 'joni@aol.com', 6, 15000, 'b000000002');
insert into sellingAgent values ('s000000001', 2000);
insert into sellingAgent values ('s000000002', 3000);
insert into sellingAgent values ('s000000003', 4000);
insert into sellingAgent values ('s000000004', 5000);
insert into sellingAgent values ('s000000005', 8000);
insert into staffPhone values ('s000000001', '512-123-1234');
insert into staffPhone values ('s000000001', '800-123-4567');
insert into staffPhone values ('s000000002', '215-890-1672');
insert into staffPhone values ('s000000003', '610-860-7350');
insert into staffPhone values ('s000000004', '212-612-6790');
insert into staffPhone values ('s000000004', '303-724-7352');
insert into staffPhone values ('s000000005', '404-679-3721');
insert into staffAddress values ('s000000001', '763 Eggdrop Ln', 'Los Angeles', 90001);
insert into staffAddress values ('s000000001', '8632 Expresso Rd', 'Los Angeles', 90001);
insert into staffAddress values ('s000000002', '9093 Fern Hollow Pl', 'Austin', 78765);
insert into staffAddress values ('s000000003', '7362 Red Stripe Rd', 'Levittown', 19057);
insert into staffAddress values ('s000000004', '832 Grumpy Cat Rd', 'Los Angeles', 90001);
insert into staffAddress values ('s000000004', '7321 Github Rd', 'Los Angeles', 90001);
insert into staffAddress values ('s000000005', '873 Guitar Ln', 'Austin', 78757);

insert into staffMember values ('s000000006', 'PaulMcCartney', 'paul@gmail.com', 3, 20000, 'b000000001');
insert into staffMember values ('s000000007', 'Marvin Gaye', 'marvin@gmail.com', 5, 40000, 'b000000002');
insert into staffMember values ('s000000008', 'Billy Joel', 'bill@gmail.com', 4, 30000, 'b000000003');
insert into staffMember values ('s000000009', 'Stevie Wonder', 'stevie@gmail.com', 2, 2500, 'b000000001');
insert into staffMember values ('s000000010', 'John Lennon', 'john@gmail.com', 6, 15000, 'b000000002');
insert into listingAgent values ('s000000006', 6000);
insert into listingAgent values ('s000000007', 2000);
insert into listingAgent values ('s000000008', 7000);
insert into listingAgent values ('s000000009', 8000);
insert into listingAgent values ('s000000010', 1000);
insert into staffPhone values ('s000000006', '512-353-1434');
insert into staffPhone values ('s000000006', '800-999-9999');
insert into staffPhone values ('s000000007', '215-890-2342');
insert into staffPhone values ('s000000008', '610-783-9372');
insert into staffPhone values ('s000000009', '212-912-6783');
insert into staffPhone values ('s000000009', '303-904-9321');
insert into staffPhone values ('s000000010', '404-876-0876');
insert into staffAddress values ('s000000006', '322 Amber Ln', 'Los Angeles', 90001);
insert into staffAddress values ('s000000006', '325 Birch Rd', 'Los Angeles', 90001);
insert into staffAddress values ('s000000007', '332 Bluff Pl', 'Austin', 78765);
insert into staffAddress values ('s000000008', '324 Blossom Rd', 'Levittown', 19057);
insert into staffAddress values ('s000000009', '321 Canyon Rd', 'Los Angeles', 90001);
insert into staffAddress values ('s000000009', '937 Chase Rd', 'Los Angeles', 90001);
insert into staffAddress values ('s000000010', '321 Bear Ln', 'Austin', 78757);

insert into property values ('p000000001', 'r', 'House', '123 Cozy Ln', 'Los Angeles', 90001, 8000000, '01-JAN-16', 'b000000001');
insert into property values ('p000000002', 'r', 'Lots', '893 Crimson Ln', 'Austin', 78757, 9000000, '03-MAR-15', 'b000000002');
insert into property values ('p000000003', 'r', 'Manufactured', '234 Ivory Cozy Ln', 'Walnut Grove', 56180, 6000000, '09-DEC-14', 'b000000003');
insert into property values ('p000000004', 'r', 'Townhomes', '3792 Ledge Cozy Ln', 'Bryn Mawr', 19010, 900000, '11-APR-15', 'b000000001');
insert into property values ('p000000005', 'r', 'Condominium', '324 Holly Ln', 'Virginia City', 89440, 850000, '20-FEB-16', 'b000000002');
insert into property values ('p000000006', 'r', 'Apartments', '782 Island Ln', 'Los Angeles', 90071, 10000000, '11-NOV-15', 'b000000003');
insert into property values ('p000000007', 'r', 'House', '325 Meadow Ln', 'Evening Shade', 72532, 3000000, '18-OCT-16', 'b000000001');
insert into property values ('p000000008', 'r', 'Condominium', '3243 Lamb Ln', 'Miami', 33162, 2000000, '02-APR-15', 'b000000002');
insert into property values ('p000000009', 's', 'House', '324 Leaf Ln', 'Plano', 75094, 3000000, '17-APR-16', 'b000000003');
insert into property values ('p000000010', 's', 'House', '703 Orchard Ln', 'Los Angeles', 90046, 2000000, '25-JUN-16', 'b000000001');
insert into property values ('p000000011', 's', 'Manufactured', '324 Fox Ln', 'Washington DC', 20006, 1000000, '16-APR-15', 'b000000002');
insert into property values ('p000000012', 's', 'House', '329 Quay Ln', 'Las Vegas', 89145, 1500000, '13-JUL-16', 'b000000003');
insert into property values ('p000000013', 's', 'Condominium', '325 Pine Ln', 'Chicago', 60611, 1000000, '03-OCT-11', 'b000000001');
insert into property values ('p000000014', 's', 'Condominium', '832 Pioneer Ln', 'East Setauket,', 11733, 750000, '21-MAY-16', 'b000000002');
insert into property values ('p000000015', 's', 'House', '293 Rock Ln', 'Lake Forest', 60045, 3000000, '22-FEB-15', 'b000000001');

insert into listedBy values ('s000000001', 'p000000001');
insert into listedBy values ('s000000002', 'p000000002');
insert into listedBy values ('s000000003', 'p000000003');
insert into listedBy values ('s000000004', 'p000000004');
insert into listedBy values ('s000000005', 'p000000005');
insert into listedBy values ('s000000001', 'p000000006');
insert into listedBy values ('s000000002', 'p000000007');
