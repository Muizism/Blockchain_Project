// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Attendance {
    struct AttendanceRecord {
        mapping(address => bool) isPresent;
    }

    mapping(string => AttendanceRecord) private attendanceRecords;

    // Events
    event AttendanceMarked(string date, address attendee);

    // Mark attendance for a given date
    function markAttendance(string calldata date) external {
        require(!attendanceRecords[date].isPresent[msg.sender], "Attendance already marked.");

        attendanceRecords[date].isPresent[msg.sender] = true;
        emit AttendanceMarked(date, msg.sender);
    }

    // Check if a specific address marked attendance on a given date
    function checkAttendance(string calldata date, address attendee) external view returns (bool) {
        return attendanceRecords[date].isPresent[attendee];
    }
}
