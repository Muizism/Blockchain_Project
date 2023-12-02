const HostelAttendance = artifacts.require("Attendance");

module.exports = async (deployer) =>{
  let instance= await deployer.deploy(HostelAttendance);
  console.log(instance)
};
