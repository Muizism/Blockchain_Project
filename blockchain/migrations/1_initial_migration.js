const HostelAttendance = artifacts.require("Attendance");

module.exports = async (deployer) =>{
   deployer.deploy(HostelAttendance);
 
};
