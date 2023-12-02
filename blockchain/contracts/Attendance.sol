// contracts/Attendance.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Attendance {
    struct AttendanceRecord {
        mapping(address => bool) isPresent;
        string date;
    }

    mapping(string => AttendanceRecord) attendanceRecords;

    function markAttendance(string memory date) public {
        require(!attendanceRecords[date].isPresent[msg.sender], "Attendance already marked.");

        attendanceRecords[date].isPresent[msg.sender] = true;
        attendanceRecords[date].date = date;
    }

    function getAttendance(string memory date) public view returns (bool) {
        return attendanceRecords[date].isPresent[msg.sender];
    }

    function getAttendanceDate(string memory date) public view returns (string memory) {
        return attendanceRecords[date].date;
    }
}
