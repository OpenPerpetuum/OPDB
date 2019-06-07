# Contributing to OPDB

This repository like PerpetuumServer follows a simplified gitflow model.  All work is branched from and merged back into the `development` branch.
However, there are a few caveats with this being a database patching repository.  There is a specific folder structure to support our devops processes and a strict no-IDs policy in submitted patches due to the variability of insertion order between development and live servers.  All of this will be described in more detail below

## Contributions

### Branching model:
 - Branch from `development`
 - Make your commits
 - Submit a Pull Request from your branch to `development`
Easy!

### Folder structure

`Patches` - contains all fixed-history SQL patches as applied to the live server and are **never to be altered**.  Their presence is so that they may be run to setup locals with the same changes without requiring restores from live.
`Staging_Dev` - This is where all newly commited SQL code will go if it is being staged for a patch (ie. something that will eventually be bundled and applied to the live server and archived in `Patches`)
`Tools` - Misc utilities, scripts, and other helpful things for local setups, testing and more.  Not to be used on production server.

Within `Staging_Dev` any folders are created for some express purpose, usually as a temporary holding place.
The root of `Staging_Dev` is where your SQL files should be commited.  
The OPDB repo also hosts server data file changes that are stored on disk.  These go in a `Server/data` folder in staging, where the folder structure in `data` should mirror that of the `PerpetuumServer/data` folder.

### SQL conventions and requirements
 - The top of all scripts must explicitly call `USE [perpetuumsa] GO`
 - The top of all scripts must contain a comment that clearly describes the purpose of the script, and what changes are made.
 - Print statements should be used especially in the case of many sequential statements to assist in debugging larger scripts.
 - ALL SELECT, JOIN, UPDATES and DELETES should NEVER reference a record simply by ID ALONE, they must use some other unique set of values to select the desired record for alteration.  Note: this also applies to UUIDs and EIDs (these are randomly generated - even worse for repeatability!)
 - All scripts should end with a `GO` directive to end the scope.

The no-ID policy is to ensure that a patch will select and perform across any server (in the same schema state) without issue because it will be insertion order invariant.  For some this is a no-brainer, but let's just say the fact we are putting this into words means that it was a problem and is something we require (and will help you learn!).

