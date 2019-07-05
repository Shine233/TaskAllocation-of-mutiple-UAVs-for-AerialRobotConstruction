# Task-Allocation-of-mutiple-UAVs-for-Aerial-robot-Construction

This project is to implement the task allocation alogrithms of multi-robot task allocation (MRTA) problems. <br>

Based on the paper of `CHEN Xia and QIAO Yan-zhi` in **Summary of unmanned aerial vehicle task allocation** [1], the algorithms can be generally divided into 4 parts:

## 1. Centralized task allocation methods
Centralized control system indicates that the group of UAVs (Unmanned Aerial Vehicles) are regulated and controlled by a single control center, including the signal transmission, communication between UAVs and the control commands of UAVs. The typical models are `MTSP`, `VRP`, `MILP`, `DNFO`, `CMTAP`.

### 1.1 Optimization methods
#### a. Exhaustive method

#### b. Mixed-Integer Linear Programming (MIP)

#### c. Constaint Programming (CP)

#### d. Graph-based method

### 1.2 Heuristic algorithm
#### a. List Scheduling (LS)
The common LS methods: 
`Dynamic List Scheduling (DLS)`, `Multi-Dimensional Dynamic List Scheduling (MDLS)`, `Multi-Priority List Dynamic Scheduling (MPLDS)` and so on.

#### b. Intelligent optimization algorithm
##### I. Evolutionary algorithms (EA) 
`Genetic Algorithm (GA)`, `Evolutionary Programming (GP)`, `Evolution Strategy (ES)` and `Evolutionary Programming (EP)`
##### II. Swarm Intelligence Algorithm (SIA)
`Particle Swarm Optimization (PSO)` and `Ant Colony Optimization(ACO)`
##### III. Others
`Artificial Immune (AI)`, `Tabu Search (TS)` and `Simulated Annealing Algorithm (SA)`

## 2. Distributed task allocation methods
Distributed control system is different from Centralized control system in the way of signale transmission. The Distributed control system can allow UAVs communiated with each other in the group.

### 2.1 ContractNet

### 2.2  Market-Based Approaches [2]
`first  price  auctions`, `Dynamic role assignment`, `Trade robots`, `Murdoch`, `Demircf`, `M+`, etc. 

## 3. Hierarchical distributed task allocation methods
This method is basically combine the first 2 methods. There is a centralized control system to control several UAV groups and for each group there is a distributed control system.

## 4. Further development methods
### 4.1 Task allocation under uncertain circumstances

### 4.2 Task allocation for multiple UAVs with different types

### 4.3 Dynamic real-time task assignment

### 4.4 Static Game Theory

### 4.5 Dynamic Game Theory
<br>  <br>  <br>  <br>  



So far, the **Ant Colony Optimization (ACO)** Algorithm has been implemented. <br>  






<br>  <br>  <br>  <br>  
## Reference：

[1] Chen, Xia, and Yan-zhi Qiao. "Summary of unmanned aerial vehicle task allocation." Journal of Shenyang Aerospace University 33.6 (2016): 1-7.

[2] Wang, Jianping, Yuesheng Gu, and Xiaomin Li. "Multi-robot task allocation based on ant colony algorithm." Journal of Computers 7.9 (2012): 2160-2167.












