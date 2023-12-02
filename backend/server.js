import express from "express";
import userRoutes from "./routes/userRoutes.js";
import studentRoutes from "./routes/studentRoutes.js";
import attendanceRoutes from "./routes/attendanceRoutes.js";
import path from "path";
import morgan from "morgan";
import Web3 from "web3"; // Add this line

import dotenv from "dotenv";
import connectDB from "./config/mongoDBConfig.js";
import { errorHandler, notFound } from "./middleware/errorMiddleware.js";
dotenv.config();
connectDB();
const app = express();

if (process.env.NODE_ENV === "development") {
  app.use(morgan("dev"));
}
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use("/users", userRoutes);
app.use("/student", studentRoutes);
app.use("/attendance", attendanceRoutes);

// Initialize Web3 with your Ethereum node URL
const web3 = new Web3("http://localhost:7545"); // Update with your Ethereum node URL

// Replace with the actual deployed contract address and ABI
const contractAddress = "YOUR_CONTRACT_ADDRESS";
const abi = []; // Update with the ABI of your smart contract
const attendanceContract = new web3.eth.Contract(abi, contractAddress);

// Modify your route to interact with the smart contract
const enterAttendanceByRoomNo = async (req, res) => {
  try {
    // ... (Your existing code)

    // Mark attendance on the blockchain
    const date = req.body.date || new Date().toString().substring(0, 15);
    const senderAddress = "SENDER_ADDRESS"; // Update with the Ethereum address that will be used to interact with the smart contract

    // Call the markAttendance function in the smart contract
    await attendanceContract.methods.markAttendance(date).send({ from: senderAddress });

    // ... (Your existing code)

    res.json({ message: "Attendance marked successfully." });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Internal Server Error" });
  }
};

const __dirname = path.resolve();
if (process.env.NODE_ENV === "production") {
  app.use(express.static(path.join(__dirname, "/frontend/build")));

  app.get("*", (req, res) =>
    res.sendFile(path.resolve(__dirname, "frontend", "build", "index.html"))
  );
} else {
  app.get("/", (req, res) => {
    res.send("API is running....");
  });
}
app.use(errorHandler);
app.use(notFound);

const PORT = process.env.PORT || 5000;

app.listen(
  PORT,
  console.log(`Server running in ${process.env.NODE_ENV} mode on port ${PORT}`)
);