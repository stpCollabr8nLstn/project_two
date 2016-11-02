select listingid from listingRentalOrSale where rentalOrSale = 'r'
INTERSECT
select listingid from listingRentalOrSale where rentalOrSale = 's';
