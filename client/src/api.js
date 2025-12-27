import axios from 'axios';

const API = axios.create({ baseURL: 'http://localhost:5000/api' });

// Add Token to every request
API.interceptors.request.use((req) => {
  if (localStorage.getItem('token')) {
    req.headers['x-auth-token'] = localStorage.getItem('token');
  }
  return req;
});

// --- AUTH (Renamed to match your Login.jsx) ---
export const loginUser = (formData) => API.post('/auth/login', formData);       // Was 'login'
export const registerUser = (formData) => API.post('/auth/register', formData); // Was 'register'

// --- LISTINGS (Marketplace) ---
export const fetchListings = () => API.get('/listings');
export const createListing = (listingData) => API.post('/listings', listingData);
export const buyEnergy = (listingId) => API.post(`/listings/buy/${listingId}`);

// --- STATS & DASHBOARD ---
export const fetchCommunityStats = () => API.get('/stats');
export const fetchHistory = () => API.get('/listings/history');
export const fetchProducerStats = () => API.get('/producer/stats');
export const fetchConsumerStats = () => API.get('/consumer/stats');

// --- GAMIFICATION (Leaderboard) ---
export const fetchLeaderboard = () => API.get('/stats/leaderboard');
export const fetchAchievements = () => API.get('/stats/achievements');

// --- NOTIFICATIONS ---
export const fetchNotifications = () => API.get('/notifications');
export const markNotificationsRead = () => API.put('/notifications/read');

// --- ADMIN PANEL ---
export const fetchAllUsers = () => API.get('/admin/users');
export const verifyUser = (id) => API.put('/admin/verify', { id });
export const fetchAllTransactions = () => API.get('/admin/transactions');
export const updatePlatformSettings = (data) => API.put('/admin/settings', data);

// --- DISPUTES ---
export const fetchDisputes = () => API.get('/admin/disputes');
export const resolveDispute = (id) => API.put('/admin/disputes/resolve', { id });