// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract HostelAttendance {
    address public owner;
    
    struct Student {
        string name;
        uint256 rollNumber;
        bool isRegistered;
    }

    mapping(address => Student) public students;
    mapping(uint256 => mapping(address => bool)) public attendance;

    event StudentRegistered(address indexed studentAddress, string name, uint256 rollNumber);
    event AttendanceMarked(uint256 date, address indexed studentAddress);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function registerStudent(string memory _name, uint256 _rollNumber) public {
        require(!students[msg.sender].isRegistered, "Student is already registered");
        
        students[msg.sender] = Student(_name, _rollNumber, true);
        emit StudentRegistered(msg.sender, _name, _rollNumber);
    }

    function markAttendance(uint256 _date) public {
        require(students[msg.sender].isRegistered, "Student is not registered");
        require(!attendance[_date][msg.sender], "Attendance already marked for the date");

        attendance[_date][msg.sender] = true;
        emit AttendanceMarked(_date, msg.sender);
    }

    function isPresent(uint256 _date) public view returns (bool) {
        require(students[msg.sender].isRegistered, "Student is not registered");
        return attendance[_date][msg.sender];
    }

    function getStudentDetails() public view returns (string memory, uint256, bool) {
        require(students[msg.sender].isRegistered, "Student is not registered");
        Student memory student = students[msg.sender];
        return (student.name, student.rollNumber, student.isRegistered);
    }

    function transferOwnership(address _newOwner) public onlyOwner {
        require(_newOwner != address(0), "Invalid new owner address");
        owner = _newOwner;
    }
}
