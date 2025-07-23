db.campaign_feedback.insertOne({
  productID: 3,
  storeID: 2,
  campaignName: "MegaDiscount-2025",
  startDate: new Date("2025-06-10"),
  endDate: new Date("2025-06-20"),
  feedback: [
    {
      customerID: 1,
      rating: 5,
      comment: "Amazing deals!",
      timestamp: new Date("2025-06-12")
    },
    {
      customerID: 2,
      rating: 4,
      comment: "Happy with bumper offers",
      timestamp: new Date("2025-06-15")
    },
    {
      customerID: 3,
      rating: 2,
      comment: "Stock out on third day",
      timestamp: new Date("2025-06-13")
    }
  ]
});

db.campaign_feedback.createIndex({ productID: 1 });

db.campaign_feedback.createIndex({ storeID: 1 });

db.campaign_feedback.createIndex({ campaignName: 1 });
