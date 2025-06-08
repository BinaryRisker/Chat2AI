const getUserProfile = async (req, res) => {
  try {
    // req.user is attached by the authenticate middleware and is a Sequelize instance
    res.json({
      id: req.user.id,
      email: req.user.email,
      createdAt: req.user.createdAt,
      updatedAt: req.user.updatedAt,
    });
  } catch (err) {
    console.error('Get user error:', err);
    res.status(500).json({ error: 'Internal server error' });
  }
};

const updateUserProfile = async (req, res) => {
  try {
    const { email } = req.body;
    
    // The password should be updated via a separate, dedicated endpoint
    // for security reasons, so we only allow email updates here.
    if (email) {
      req.user.email = email;
    }

    await req.user.save();
    res.json({
      id: req.user.id,
      email: req.user.email,
    });
  } catch (err) {
    console.error('Update user error:', err);
    if (err.name === 'SequelizeValidationError') {
      return res.status(400).json({ error: err.errors.map(e => e.message).join(', ') });
    }
    res.status(500).json({ error: 'Internal server error' });
  }
};

const deleteUserProfile = async (req, res) => {
  try {
    await req.user.destroy(); // Use destroy() for Sequelize instances
    res.json({ message: 'User deleted successfully' });
  } catch (err) {
    console.error('Delete user error:', err);
    res.status(500).json({ error: 'Internal server error' });
  }
};

module.exports = {
  getUserProfile,
  updateUserProfile,
  deleteUserProfile,
}; 