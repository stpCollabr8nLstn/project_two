CREATE TABLE staffMember (
  staffId VARCHAR2(10)  PRIMARY KEY,
  name VARCHAR2(100) NOT NULL,
  email VARCHAR2(50) UNIQUE NOT NULL,
  rating NUMBER (1),
  salary NUMBER (7, 2) NOT NULL,
  branchId VARCHAR2(10)
);

CREATE TABLE staffPhone (
  staffId VARCHAR2(10) REFERENCES StaffMember(staffId),
  phone VARCHAR2(12) NOT NULL
);

CREATE TABLE staffAddress (
  staffId VARCHAR2(10) REFERENCES StaffMember(staffId),
  street VARCHAR2(100),
  city VARCHAR2(25),
  zipCode NUMBER(5)
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

CREATE TABLE client (
  clientId VARCHAR2(10) PRIMARY KEY NOT NULL,
  email VARCHAR2(50) NOT NULL,
  name VARCHAR2(100),
  street VARCHAR2(100),
  city VARCHAR2(25),
  zipCode NUMERIC(5)
);

CREATE TABLE clientType (
  clientId VARCHAR2(10) REFERENCES client (clientId),
  clientTypeId VARCHAR2(10),
  rentalContract VARCHAR2(1),
  amenities VARCHAR2(1000),
  minPrice NUMBER(20,2),
  maxPrice NUMBER(20,2)
);

CREATE TABLE clientBuyerLocation (
  clientId VARCHAR2(10) REFERENCES client (clientId),
  street VARCHAR2(100),
  city VARCHAR2(25),
  zipCode NUMBER(5)
);

CREATE TABLE clientPhone (
  clientId VARCHAR2(10) REFERENCES client (clientId),
  phone VARCHAR2(12)
);

CREATE TABLE branch (
  branchId VARCHAR2(10) PRIMARY KEY NOT NULL,
  street VARCHAR2(100),
  city VARCHAR2(25),
  zipCode NUMBER(5)
);
CREATE TABLE hasA (
  clientId VARCHAR2(10) REFERENCES client (clientId),
  branchId VARCHAR2(10) REFERENCES branch(branchId)
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
  branch VARCHAR2(10) REFERENCES branch(branchId) NOT NULL
);
CREATE TABLE propertyStats (
  statsId VARCHAR2(10) PRIMARY KEY NOT NULL,
  hoaCost NUMBER(10,2),
  onSiteParking VARCHAR2(1) CONSTRAINT ck_onSiteParking CHECK (onSiteParking IN ('y','n')) NOT NULL,
  numBedrooms INT,
  numBathrooms INT,
  yearBuilt INT,
  property VARCHAR2(10) REFERENCES property(propertyId) NOT NULL
);

CREATE TABLE ad (
  adId VARCHAR2(10) PRIMARY KEY NOT NULL,
  adDate DATE,
  adCost NUMBER(10,2),
  adPublication VARCHAR2(100),
  property VARCHAR2(10) REFERENCES property(propertyId) NOT NULL
);

CREATE TABLE offer (
  offerId VARCHAR2(10) PRIMARY KEY NOT NULL,
  offerDate DATE NOT NULL,
  acceptedOrRejected VARCHAR2(8),
  property VARCHAR2(10) REFERENCES property(propertyId) NOT NULL
);

CREATE TABLE openHouse (
  openHouseId VARCHAR2(10) PRIMARY KEY NOT NULL,
  openHouseDate DATE NOT NULL,
  openHouseTime VARCHAR2(5) NOT NULL,
  property VARCHAR2(10) REFERENCES property(propertyId) NOT NULL
);
