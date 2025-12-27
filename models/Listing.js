const mongoose = require('mongoose');

const listingSchema = new mongoose.Schema({
  name: { type: String, required: true },
  type: { type: String, required: true }, // e.g., Machine, Laptop
  status: { 
    type: String, 
    enum: ['Operational', 'Maintenance Required', 'Broken'], 
    default: 'Operational' 
  },
  description: { type: String },
  createdAt: { type: Date, default: Date.now }
});

module.exports = mongoose.model('Listing', listingSchema);