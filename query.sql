select listingId from listingRentalOrSale where rentalOrSale = 'r' intersect select listingId from listingRentalOrSale where rentalOrSale = 's';

