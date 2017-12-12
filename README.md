# OPDB

## DB VERSION CONTROL PROCEDURE

**Follow [CONTRIBUTING](https://github.com/OpenPerpetuum/OP-Project/blob/master/CONTRIBUTING.md) guidelines for git**  
OPP Team members:  
Commit and push changes to **YOUR-BRANCH-ONLY**
When you are ready, submit a Pull Request to **DEVELOPMENT ONLY**
Your changes MUST BE REVIEWED before they can be merged to Development

OPP DB Admins:  
You are in charge of ensuring the states of the Dev and Live Server DB, and their coordination with the Server Repo and the changes as You accept them on Development and Master respectively.  
Pull Requests should be submitted to Master from DEVELOPMENT ONLY.  


How this Repo operates:
ALL SQL OPERATES ON the PerpSQL state from a FRESH INSTALL  
SQL statements then are version controlled in the OPDB repo  

** To commit a change w/o key conflicts**  
Pull and catch up to most recent SQL state, run SQL, then make changes freely locally.    
Once you are done, REVERT to the pull state.  
Write your SQL for the singular change(s) (not the history of work/rework/undo/redo).  
Push change.  


REPO structure   
Master- what is on live server  
Development - what is on dev server  
Your branch - what you do  

YOUR DB should be dropped and re-initialized with the most recent Development commit.


