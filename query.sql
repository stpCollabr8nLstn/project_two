select listingId from listing where rental = 'y' intersect select listingId from listing where sale = 'y';

