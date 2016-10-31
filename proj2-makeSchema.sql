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
  acceptedOrRejected VARCHAR2(8) CONSTRAINT ck_offersMade CHECK (acceptedOrRejected IN ('accepted','rejected')),
  propertyId VARCHAR2(10) REFERENCES property(propertyId) NOT NULL
);

CREATE TABLE owns (
  clientId VARCHAR2(10) REFERENCES client(clientId) NOT NULL,
  propertyId VARCHAR2(10) REFERENCES property(propertyId) NOT NULL,
  PRIMARY KEY (staffId, phone)
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
insert into property values ('p000000006', 's', 'Apartments', '782 Island Ln', 'Los Angeles', 90071, 10000000, '11-NOV-15', 'b000000003');
insert into property values ('p000000007', 's', 'House', '325 Meadow Ln', 'Evening Shade', 72532, 3000000, '18-OCT-16', 'b000000001');
insert into property values ('p000000008', 's', 'Condominium', '3243 Lamb Ln', 'Miami', 33162, 2000000, '02-APR-15', 'b000000002');
insert into property values ('p000000009', 's', 'House', '324 Leaf Ln', 'Plano', 75094, 3000000, '17-APR-16', 'b000000003');
insert into property values ('p000000010', 's', 'House', '703 Orchard Ln', 'Los Angeles', 90046, 2000000, '25-JUN-16', 'b000000001');
insert into property values ('p000000011', 's', 'Manufactured', '324 Fox Ln', 'Washington DC', 20006, 1000000, '16-APR-15', 'b000000002');
insert into property values ('p000000012', 's', 'House', '329 Quay Ln', 'Las Vegas', 89145, 1500000, '13-JUL-16', 'b000000003');
insert into property values ('p000000013', 's', 'Condominium', '325 Pine Ln', 'Chicago', 60611, 1000000, '03-OCT-11', 'b000000001');
insert into property values ('p000000014', 's', 'Condominium', '832 Pioneer Ln', 'East Setauket,', 11733, 750000, '21-MAY-16', 'b000000002');
insert into property values ('p000000015', 's', 'House', '293 Rock Ln', 'Lake Forest', 60045, 3000000, '22-FEB-15', 'b000000001');

insert into listedBy values ('s000000004', 'p000000008');
insert into listedBy values ('s000000003', 'p0000000010');
insert into listedBy values ('s000000004', 'p0000000011');
insert into listedBy values ('s000000005', 'p000000012');
insert into listedBy values ('s000000001', 'p000000013');
insert into listedBy values ('s000000002', 'p000000014');
insert into listedBy values ('s000000003', 'p000000015');

insert into advertisement values ('a000000001', '17-APR-16', 1000, 'Real Estate Today', 'p000000001');
insert into advertisement values ('a000000002', '13-JAN-16', 2000, 'coolhouses.com', 'p000000002');
insert into advertisement values ('a000000003', '20-AUG-16', 3000, 'Weekly Real Estate', 'p000000003');

insert into propertyStatistics values ('ps00000001', 2, 200, 1, 'y', 1979, 'p000000001');
insert into propertyStatistics values ('ps00000002', 3, 300, 2, 'y', 1980, 'p000000002');
insert into propertyStatistics values ('ps00000003', 1, 400, 1, 'y', 1975, 'p000000003');
insert into propertyStatistics values ('ps00000004', 3, 500, 3, 'y', 1972, 'p000000004');
insert into propertyStatistics values ('ps00000005', 2, 100, 4, 'y', 1981, 'p000000005');
insert into propertyStatistics values ('ps00000006', 1, 400, 3, 'n', 1985, 'p000000006');
insert into propertyStatistics values ('ps00000007', 1, 600, 2, 'n', 2010, 'p000000007');
insert into propertyStatistics values ('ps00000008', 2, 200, 1, 'n', 2000, 'p000000008');
insert into propertyStatistics values ('ps00000009', 1, 100, 3, 'n', 1965, 'p000000009');
insert into propertyStatistics values ('ps00000010', 2, 170, 2, 'n', 1960, 'p000000010');
insert into propertyStatistics values ('ps00000011', 1, 105, 3, 'n', 2001, 'p000000011');
insert into propertyStatistics values ('ps00000012', 1, 205, 2, 'n', 2010, 'p000000012');
insert into propertyStatistics values ('ps00000013', 2, 250, 1, 'n', 2007, 'p000000013');
insert into propertyStatistics values ('ps00000014', 1, 700, 3, 'n', 1965, 'p000000014');
insert into propertyStatistics values ('ps00000015', 2, 203, 2, 'n', 1980, 'p000000015');

insert into openHouse values ('oh00000001', '20-DEC-16', '12:00', 'realestate.com', 'p000000001');
insert into openHouse values ('oh00000002', '15-NOV-16', '13:00', 'Real Estate Daily', 'p000000002');
insert into openHouse values ('oh00000003', '03-JAN-17', '14:00', 'Best Houses In Town', 'p000000003');

insert into offersMade values ('om00000001', '15-NOV-15', 3000000, 'accepted', 'p000000006');
insert into offersMade values ('om00000002', '20-SEP-16', 400000, 'accepted', 'p000000007');
insert into offersMade values ('om00000003', '01-JUN-16', 750000, 'accepted', 'p000000008');
insert into offersMade values ('om00000004', '15-MAY-16', 555000, 'accepted', 'p000000009');
insert into offersMade values ('om00000005', '03-MAR-16', 600000, 'accepted', 'p000000010');
insert into offersMade values ('om00000006', '10-JUN-16', 100000, 'rejected', 'p000000001');
insert into offersMade values ('om00000007', '17-MAR-16', 200000, 'rejected', 'p000000002');

insert into client values ('c000000001', 'pablo@gmail.com', 'Pablo Picasso', '6649 N Blue Gum St', 'New Orleans', 70116);
insert into client values ('c000000002', 'vincent@gmail.com', 'Vincent van Gogh', '4 B Blue Ridge Blvd', 'Brighton', 48116);
insert into client values ('c000000003', 'salvador@gmail.com', 'Salvador Dali', '8 W Cerritos Ave #54', 'Bridgeport', 80140);
insert into client values ('c000000004', 'frida@gmail.com', 'Frida Kahlo', '639 Main St', 'Anchorage', 99501);
insert into client values ('c000000005', 'andy@gmail.com', 'Andy Warhol', '34 Center St', 'Hamilton', 45011);
insert into client values ('c000000006', 'claude@gmail.com', 'Claude Monet', '3 Mcauley Dr', 'Ashland', 44805);
insert into client values ('c000000007', 'leonardo@gmail.com', 'Leonardo da Vinci', '7 Eads St', 'Chicago', 60632);
insert into client values ('c000000008', 'jackson@gmail.com', 'Jackson Pollock', '7 W Jackson Blvd', 'San Jose', 95111);
insert into client values ('c000000009', 'henri@gmail.com', 'Henri Matisse', '5 Boston Ave #88', 'Sioux Falls', 57105);
insert into client values ('c000000010', 'michelangelo@gmail.com', 'Michelangelo', '228 Runamuck Pl #2808', 'Baltimore', 21224);
insert into client values ('c000000011', 'georgia@gmail.com', 'Georgia O''Keeffe', '2371 Jerrold Ave', 'Kulpsville', 19443);
insert into client values ('c000000012', 'paul@gmail.com', 'Paul Cezanne', '37275 St  Rt 17m M', 'Middle Island', 11953);
insert into client values ('c000000013', 'wassily@gmail.com', 'Wassily Kandinsky', '25 E 75th St #69', 'Los Angeles', 90034);
insert into client values ('c000000014', 'pierre-auguste@gmail.com', 'Pierre-Auguste Renoir', '98 Connecticut Ave Nw', 'Chagrin Falls', 44023);
insert into client values ('c000000015', 'gustav@gmail.com', 'Gustav Klimt', '56 E Morehead St', 'Laredo', 78045);
insert into clientPhone values ('c000000001', '512-324-3152');
insert into clientPhone values ('c000000001', '800-342-4634');
insert into clientPhone values ('c000000002', '800-532-6553');
insert into clientPhone values ('c000000002', '215-438-6432');
insert into clientPhone values ('c000000003', '215-326-6446');
insert into clientPhone values ('c000000004', '610-654-7654');
insert into clientPhone values ('c000000005', '212-654-5711');
insert into clientPhone values ('c000000005', '610-764-6542');
insert into clientPhone values ('c000000006', '303-424-6532');
insert into clientPhone values ('c000000006', '212-643-5542');
insert into clientPhone values ('c000000007', '404-765-6664');
insert into clientPhone values ('c000000008', '512-221-2462');
insert into clientPhone values ('c000000009', '800-536-6542');
insert into clientPhone values ('c000000009', '303-653-3461');
insert into clientPhone values ('c000000010', '215-653-6531');
insert into clientPhone values ('c000000010', '404-653-6526');
insert into clientPhone values ('c000000011', '610-775-4163');
insert into clientPhone values ('c000000012', '212-642-4264');
insert into clientPhone values ('c000000013', '303-462-7245');
insert into clientPhone values ('c000000014', '404-632-4324');
insert into clientPhone values ('c000000015', '512-366-6421');
