<<<<<<< Updated upstream
// routes/auth.js
const express = require('express');
const router = express.Router();

// Placeholder route
router.get('/test', (req, res) => {
    res.json({ message: "Auth route is working" });
});
=======
const express = require('express');
const router = express.Router();
const { register, login } = require('../controllers/authController');

router.post('/register', register);
router.post('/login', login);
>>>>>>> Stashed changes

module.exports = router;