const HostelAttendance = artifacts.require("HostelAttendance");

module.exports = function (deployer) {
  deployer.deploy(HostelAttendance);
};
