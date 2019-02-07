USE [perpetuumsa]
GO

------------------------
--Simple Boost for CT drop chances
--2019/01/31
--drop rates A = 3%, B = 2%, C = 1%
------------------------


--Set the chance to 5, 3, 1% respectively (TO BE FIXED to something more sensible)
UPDATE artifactloot
SET chance = 0.03
WHERE definition IN (SELECT definition FROM entitydefaults WHERE categoryflags=1179 AND definitionname like '%_mk2_A_CT_capsule');

UPDATE artifactloot
SET chance = 0.02
WHERE definition IN (SELECT definition FROM entitydefaults WHERE categoryflags=1179 AND definitionname like '%_mk2_B_CT_capsule');

UPDATE artifactloot
SET chance = 0.01
WHERE definition IN (SELECT definition FROM entitydefaults WHERE categoryflags=1179 AND definitionname like '%_mk2_C_CT_capsule');

GO