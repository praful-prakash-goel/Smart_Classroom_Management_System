const { Router } = require('express');
const indexRouter = Router();
const signupRouter = require('./signupRoute');
const faceRouter = require('./faceRoute');
const loginRouter = require('./loginRoute');
const numClasses = require('./numClassesRoute');
const usersRouter = require('./usersRoute');
const faceAttendanceRouter = require('./faceAttendanceRoute');
const attendanceRouter = require('./attendanceRoute');
//connection testing
// indexRouter.get("/", (req, res) => {
//     res.json({ message: "server check successful!" });
// });

indexRouter.use("/signup", signupRouter);
indexRouter.use("/upload", faceRouter);  
indexRouter.use("/login", loginRouter);
indexRouter.use("/today-classes", numClasses);
indexRouter.use("/users", usersRouter);
indexRouter.use("/attendance", attendanceRouter);

module.exports = indexRouter;