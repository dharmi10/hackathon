const User = require('../models/User');

// @desc    Register a new user
// @route   POST /api/auth/register
exports.register = async (req, res) => {
  try {
    const { name, email, password, role } = req.body;

    // 1. Check if user already exists
    let user = await User.findOne({ email });
    if (user) {
      return res.status(400).json({ msg: 'User already exists' });
    }

    // 2. Create new user
    user = new User({
      name,
      email,
      password, // Note: For production, you should hash this password using bcrypt
      role
    });

    // 3. Save to database
    await user.save();

    res.status(201).json({ msg: 'User registered successfully', user });
  } catch (err) {
    console.error(err.message);
    res.status(500).send('Server Error');
  }
};

// @desc    Login user
// @route   POST /api/auth/login
exports.login = async (req, res) => {
  try {
    const { email, password } = req.body;

    // 1. Check if user exists
    let user = await User.findOne({ email });
    if (!user) {
      return res.status(400).json({ msg: 'Invalid Credentials' });
    }

    // 2. Simple password check (matches the plain text password above)
    if (user.password !== password) {
      return res.status(400).json({ msg: 'Invalid Credentials' });
    }

    res.json({ msg: 'Login successful', user });
  } catch (err) {
    console.error(err.message);
    res.status(500).send('Server Error');
  }
};