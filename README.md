# OPDB-docs
Repo to document PerpetuumOnline Database fields, parameters and values - for sanity

See the Wiki for docs



##DB VERSIONCONTROL PROCEDURE

**Follow CONTRIBUTING guidelines for git**  
Additionally:
ALL SQL OPERATES ON PerpSQL as from the installer
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

Submit changes via PULL REQUEST from Your branch to Development    
DB Patches to stateful DB's (DB's that persist) patch based on differences to their source branch  

The Development DB will 'monitor' its state based on the Development Branch  
The live DB will patch based on Pull Requests that are merged from Development Branch to Master.  ONLY  

YOUR DB should be dropped and re-initialized by the most recent Development SQL commit.


