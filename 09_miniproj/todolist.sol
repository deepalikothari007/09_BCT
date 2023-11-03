//SPDX-License-Identifier: MIT 
pragma solidity ^0.8.0;

contract Todolist {
    address public owner;
    struct Task { 
        uint256 id;
        string content;
        bool completed;
    }
    mapping(uint256 => Task) public tasks;
    uint256 public taskCount;
    event TaskCreated(uint256 id, string content, bool completed); 
    event TaskCompleted(uint256 id, bool completed);
    event TaskDeleted(uint256 id);
    event TaskUpdated(uint256 id, string content);

   
    constructor() {
        owner = msg.sender;
   }
    modifier onlyOwner() {
         require(msg.sender == owner, "Only the contract owner can create task");
         _;
   }

    function createTask(string memory _content) public onlyOwner { 
        taskCount++;
        tasks[taskCount] = Task(taskCount, _content, false);
        emit TaskCreated(taskCount, _content, false);
   }

    function completeTask(uint256 _taskId) public onlyOwner {
        require(_taskId > 0 && _taskId <= taskCount, "Invalid task ID"); 
        Task storage task = tasks[_taskId]; 
        task.completed = true;
        emit TaskCompleted(_taskId, true);
   }
   
    function deleteTask(uint256 _taskId) public onlyOwner {
        require(_taskId > 0 && _taskId <= taskCount, "Invalid task ID");
        delete tasks [_taskId];
        emit TaskDeleted(_taskId);
    }

    function updateTask(uint256 _taskId, string memory newContent) public onlyOwner{
        require(_taskId > 0 && _taskId <= taskCount, "Invalid task ID"); 
        Task storage task = tasks[_taskId]; 
        task.content = newContent; 
        emit TaskUpdated(_taskId, newContent);
    }

    function getTask(uint256 _taskId) public view returns (string memory, bool) { 
        require(_taskId > 0 && _taskId <= taskCount, "Invalid task ID"); 
        Task storage task = tasks [_taskId]; 
        return (task.content, task.completed);
    }

    function getTaskCount() public view returns (uint256) {
        return taskCount; 
    }
    
    function isTaskCompleted (uint256 _taskId) public view returns (bool) {
        require(_taskId > 0 && _taskId <= taskCount, "Invalid task ID"); 
        Task storage task = tasks[_taskId]; 
        return task.completed;
    }

}