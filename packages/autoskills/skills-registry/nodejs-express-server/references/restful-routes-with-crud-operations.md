# RESTful Routes with CRUD Operations

## RESTful Routes with CRUD Operations

```javascript
const userRouter = express.Router();

// GET all users (with pagination)
userRouter.get(
  "/",
  authenticateToken,
  asyncHandler(async (req, res) => {
    const { page = 1, limit = 20 } = req.query;
    const users = await User.findAndCountAll({
      offset: (page - 1) * limit,
      limit: parseInt(limit),
    });

    res.json({
      data: users.rows,
      pagination: { page, limit, total: users.count },
    });
  }),
);

// GET single user
userRouter.get(
  "/:id",
  authenticateToken,
  asyncHandler(async (req, res) => {
    const user = await User.findByPk(req.params.id);
    if (!user) return res.status(404).json({ error: "Not found" });
    res.json({ data: user });
  }),
);

// POST create user
userRouter.post(
  "/",
  asyncHandler(async (req, res) => {
    const { email, password } = req.body;
    const hashedPassword = await bcrypt.hash(password, 10);

    const user = await User.create({
      email,
      password: hashedPassword,
    });

    res.status(201).json({ data: user });
  }),
);

// PATCH update user
userRouter.patch(
  "/:id",
  authenticateToken,
  asyncHandler(async (req, res) => {
    const user = await User.findByPk(req.params.id);
    if (!user) return res.status(404).json({ error: "Not found" });

    await user.update(req.body, {
      fields: ["email", "role"],
    });

    res.json({ data: user });
  }),
);

// DELETE user
userRouter.delete(
  "/:id",
  authenticateToken,
  asyncHandler(async (req, res) => {
    const user = await User.findByPk(req.params.id);
    if (!user) return res.status(404).json({ error: "Not found" });

    await user.destroy();
    res.status(204).send();
  }),
);

app.use("/api/users", userRouter);
```
