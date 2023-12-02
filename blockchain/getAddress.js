// getAddresses.js
const Attendance = artifacts.require("Attendance"); // Update with your actual contract name

module.exports = async function () {
  const attendance = await Attendance.deployed();
  console.log("Contract Address:", attendance.address);

  const accounts = await web3.eth.getAccounts();
  const senderAddress = accounts[0];
  console.log("Sender Address:", senderAddress);
};