USE [perpetuumsa]
GO


-------------------------------------------------------------
--PATCH 29: Gamma PBS hitboxs fix,
--00_staging_table_for_pbs_hitboxes.sql
-------------------------------------------------------------

----------------------------------------
-- Creates and initially fills staging table for pbs hitboxes for further usage
-- Date Modified: 2023/07/15
----------------------------------------

PRINT N'Create staging table';
DROP TABLE IF EXISTS [environmentdescriptionstaging];
CREATE TABLE [environmentdescriptionstaging](
	[definition] [int] NOT NULL,
	[descriptionstring] [varchar](max) NOT NULL,
 CONSTRAINT [IX_environmentdescriptionstaging] UNIQUE NONCLUSTERED 
(
	[definition] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[environmentdescriptionstaging]  WITH CHECK ADD  CONSTRAINT [FK_environmentdescriptionstaging_entitydefaults] FOREIGN KEY([definition])
REFERENCES [dbo].[entitydefaults] ([definition])
GO

ALTER TABLE [dbo].[environmentdescriptionstaging] CHECK CONSTRAINT [FK_environmentdescriptionstaging_entitydefaults]
GO

PRINT N'Fill initial hitboxes staging data, cone-shaped';
INSERT INTO environmentdescriptionstaging (definition, descriptionstring) VALUES
--------- Mining outpost ---------
--------- T1 ---------
(4689, '#blocks=[|t0=[|x=i-1|y=i-3|data=i3]|t1=[|x=i0|y=i-3|data=i3]|t2=[|x=i1|y=i-3|data=i3]|t3=[|x=i-2|y=i-2|data=i4]|t4=[|x=i-1|y=i-2|data=i4]|t5=[|x=i0|y=i-2|data=i4]|t6=[|x=i1|y=i-2|data=i4]|t7=[|x=i2|y=i-2|data=i4]|t8=[|x=i-3|y=i-1|data=i3]|t9=[|x=i-2|y=i-1|data=i4]|t10=[|x=i-1|y=i-1|data=i5]|t11=[|x=i0|y=i-1|data=i5]|t12=[|x=i1|y=i-1|data=i5]|t13=[|x=i2|y=i-1|data=i4]|t14=[|x=i3|y=i-1|data=i3]|t15=[|x=i-3|y=i0|data=i3]|t16=[|x=i-2|y=i0|data=i4]|t17=[|x=i-1|y=i0|data=i5]|t18=[|x=i0|y=i0|data=i3b]|t19=[|x=i1|y=i0|data=i5]|t20=[|x=i2|y=i0|data=i4]|t21=[|x=i3|y=i0|data=i3]|t22=[|x=i-3|y=i1|data=i3]|t23=[|x=i-2|y=i1|data=i4]|t24=[|x=i-1|y=i1|data=i5]|t25=[|x=i0|y=i1|data=i5]|t26=[|x=i1|y=i1|data=i5]|t27=[|x=i2|y=i1|data=i4]|t28=[|x=i3|y=i1|data=i3]|t29=[|x=i-2|y=i2|data=i4]|t30=[|x=i-1|y=i2|data=i4]|t31=[|x=i0|y=i2|data=i4]|t32=[|x=i1|y=i2|data=i4]|t33=[|x=i2|y=i2|data=i4]|t34=[|x=i-1|y=i3|data=i3]|t35=[|x=i0|y=i3|data=i3]|t36=[|x=i1|y=i3|data=i3]]'),
--------- T2 ---------
(4737, '#blocks=[|t0=[|x=i-1|y=i-3|data=i3]|t1=[|x=i0|y=i-3|data=i3]|t2=[|x=i1|y=i-3|data=i3]|t3=[|x=i-2|y=i-2|data=i4]|t4=[|x=i-1|y=i-2|data=i4]|t5=[|x=i0|y=i-2|data=i4]|t6=[|x=i1|y=i-2|data=i4]|t7=[|x=i2|y=i-2|data=i4]|t8=[|x=i-3|y=i-1|data=i3]|t9=[|x=i-2|y=i-1|data=i4]|t10=[|x=i-1|y=i-1|data=i5]|t11=[|x=i0|y=i-1|data=i5]|t12=[|x=i1|y=i-1|data=i5]|t13=[|x=i2|y=i-1|data=i4]|t14=[|x=i3|y=i-1|data=i3]|t15=[|x=i-3|y=i0|data=i3]|t16=[|x=i-2|y=i0|data=i4]|t17=[|x=i-1|y=i0|data=i5]|t18=[|x=i0|y=i0|data=i3b]|t19=[|x=i1|y=i0|data=i5]|t20=[|x=i2|y=i0|data=i4]|t21=[|x=i3|y=i0|data=i3]|t22=[|x=i-3|y=i1|data=i3]|t23=[|x=i-2|y=i1|data=i4]|t24=[|x=i-1|y=i1|data=i5]|t25=[|x=i0|y=i1|data=i5]|t26=[|x=i1|y=i1|data=i5]|t27=[|x=i2|y=i1|data=i4]|t28=[|x=i3|y=i1|data=i3]|t29=[|x=i-2|y=i2|data=i4]|t30=[|x=i-1|y=i2|data=i4]|t31=[|x=i0|y=i2|data=i4]|t32=[|x=i1|y=i2|data=i4]|t33=[|x=i2|y=i2|data=i4]|t34=[|x=i-1|y=i3|data=i3]|t35=[|x=i0|y=i3|data=i3]|t36=[|x=i1|y=i3|data=i3]]'),
--------- T3 ---------
(4740, '#blocks=[|t0=[|x=i-1|y=i-3|data=i3]|t1=[|x=i0|y=i-3|data=i3]|t2=[|x=i1|y=i-3|data=i3]|t3=[|x=i-2|y=i-2|data=i4]|t4=[|x=i-1|y=i-2|data=i4]|t5=[|x=i0|y=i-2|data=i4]|t6=[|x=i1|y=i-2|data=i4]|t7=[|x=i2|y=i-2|data=i4]|t8=[|x=i-3|y=i-1|data=i3]|t9=[|x=i-2|y=i-1|data=i4]|t10=[|x=i-1|y=i-1|data=i5]|t11=[|x=i0|y=i-1|data=i5]|t12=[|x=i1|y=i-1|data=i5]|t13=[|x=i2|y=i-1|data=i4]|t14=[|x=i3|y=i-1|data=i3]|t15=[|x=i-3|y=i0|data=i3]|t16=[|x=i-2|y=i0|data=i4]|t17=[|x=i-1|y=i0|data=i5]|t18=[|x=i0|y=i0|data=i3b]|t19=[|x=i1|y=i0|data=i5]|t20=[|x=i2|y=i0|data=i4]|t21=[|x=i3|y=i0|data=i3]|t22=[|x=i-3|y=i1|data=i3]|t23=[|x=i-2|y=i1|data=i4]|t24=[|x=i-1|y=i1|data=i5]|t25=[|x=i0|y=i1|data=i5]|t26=[|x=i1|y=i1|data=i5]|t27=[|x=i2|y=i1|data=i4]|t28=[|x=i3|y=i1|data=i3]|t29=[|x=i-2|y=i2|data=i4]|t30=[|x=i-1|y=i2|data=i4]|t31=[|x=i0|y=i2|data=i4]|t32=[|x=i1|y=i2|data=i4]|t33=[|x=i2|y=i2|data=i4]|t34=[|x=i-1|y=i3|data=i3]|t35=[|x=i0|y=i3|data=i3]|t36=[|x=i1|y=i3|data=i3]]'),

--------- Command relay ---------
--------- T1 ---------
(4702, '#blocks=[|t0=[|x=i-1|y=i-1|data=i5]t1=[|x=i0|y=i-1|data=i5]t2=[|x=i1|y=i-1|data=i5]|t3=[|x=i-1|y=i0|data=i5]t4=[|x=i0|y=i0|data=i17]t5=[|x=i1|y=i0|data=i5]|t6=[|x=i-1|y=i1|data=i5]t7=[|x=i0|y=i1|data=i8]t5=[|x=i1|y=i1|data=i5]]'),
--------- T2 ---------
(4743, '#blocks=[|t0=[|x=i-1|y=i-1|data=i5]t1=[|x=i0|y=i-1|data=i5]t2=[|x=i1|y=i-1|data=i5]|t3=[|x=i-1|y=i0|data=i5]t4=[|x=i0|y=i0|data=i17]t5=[|x=i1|y=i0|data=i5]|t6=[|x=i-1|y=i1|data=i5]t7=[|x=i0|y=i1|data=i8]t5=[|x=i1|y=i1|data=i5]]'),
--------- T3 ---------
(4746, '#blocks=[|t0=[|x=i-1|y=i-1|data=i5]t1=[|x=i0|y=i-1|data=i5]t2=[|x=i1|y=i-1|data=i5]|t3=[|x=i-1|y=i0|data=i5]t4=[|x=i0|y=i0|data=i17]t5=[|x=i1|y=i0|data=i5]|t6=[|x=i-1|y=i1|data=i5]t7=[|x=i0|y=i1|data=i8]t5=[|x=i1|y=i1|data=i5]]'),

--------- Repair node ---------
--------- T1 ---------
(4692, '#blocks=[|t0=[|x=i-1|y=i-1|data=i2]|t1=[|x=i0|y=i-1|data=i2]|t2=[|x=i1|y=i-1|data=i2]|t3=[|x=i-1|y=i0|data=i2]|t4=[|x=i0|y=i0|data=ib]|t5=[|x=i1|y=i0|data=i2]|t6=[|x=i-1|y=i1|data=i2]|t7=[|x=i0|y=i1|data=i2]|t8=[|x=i1|y=i1|data=i2]]'),
--------- T2 ---------
(4720, '#blocks=[|t0=[|x=i-1|y=i-1|data=i2]|t1=[|x=i0|y=i-1|data=i2]|t2=[|x=i1|y=i-1|data=i2]|t3=[|x=i-1|y=i0|data=i2]|t4=[|x=i0|y=i0|data=ib]|t5=[|x=i1|y=i0|data=i2]|t6=[|x=i-1|y=i1|data=i2]|t7=[|x=i0|y=i1|data=i2]|t8=[|x=i1|y=i1|data=i2]]'),
--------- T3 ---------
(4723, '#blocks=[|t0=[|x=i-1|y=i-1|data=i2]|t1=[|x=i0|y=i-1|data=i2]|t2=[|x=i1|y=i-1|data=i2]|t3=[|x=i-1|y=i0|data=i2]|t4=[|x=i0|y=i0|data=ib]|t5=[|x=i1|y=i0|data=i2]|t6=[|x=i-1|y=i1|data=i2]|t7=[|x=i0|y=i1|data=i2]|t8=[|x=i1|y=i1|data=i2]]'),

--------- Energy well ---------
--------- T1 ---------
(5349, '#blocks=[|t0=[|x=i-1|y=i-3|data=i1]|t1=[|x=i0|y=i-3|data=i1]|t2=[|x=i1|y=i-3|data=i1]|t3=[|x=i2|y=i-3|data=i1]|t7=[|x=i-2|y=i-2|data=i1]|t8=[|x=i-1|y=i-2|data=i1]|t9=[|x=i0|y=i-2|data=i1]|t10=[|x=i1|y=i-2|data=i1]|t11=[|x=i2|y=i-2|data=i1]|t12=[|x=i3|y=i-2|data=i1]|t13=[|x=i-3|y=i-1|data=i1]|t14=[|x=i-2|y=i-1|data=i1]|t15=[|x=i-1|y=i-1|data=i2]|t16=[|x=i0|y=i-1|data=i2]|t17=[|x=i1|y=i-1|data=i2]|t18=[|x=i3|y=i-1|data=i1]|t19=[|x=i2|y=i-1|data=i1]|t20=[|x=i-3|y=i0|data=i1]|t21=[|x=i-2|y=i0|data=i1]|t22=[|x=i-1|y=i0|data=i2]|t23=[|x=i0|y=i0|data=i3b]|t24=[|x=i1|y=i0|data=i2]|t25=[|x=i2|y=i0|data=i1]|t26=[|x=i3|y=i0|data=i1]|t27=[|x=i-3|y=i1|data=i1]|t28=[|x=i-2|y=i1|data=i1]|t29=[|x=i-1|y=i1|data=i2]|t30=[|x=i0|y=i1|data=i2]|t31=[|x=i1|y=i1|data=i2]|t32=[|x=i2|y=i1|data=i1]|t33=[|x=i3|y=i1|data=i1]|t34=[|x=i-2|y=i2|data=i1]|t35=[|x=i-1|y=i2|data=i1]|t36=[|x=i0|y=i2|data=i1]|t37=[|x=i1|y=i2|data=i1]|t38=[|x=i2|y=i2|data=i1]|t39=[|x=i-1|y=i3|data=i1]|t40=[|x=i0|y=i3|data=i1]|t41=[|x=i1|y=i3|data=i1]]'),
--------- T2 ---------
(5350, '#blocks=[|t0=[|x=i-1|y=i-3|data=i1]|t1=[|x=i0|y=i-3|data=i1]|t2=[|x=i1|y=i-3|data=i1]|t3=[|x=i2|y=i-3|data=i1]|t7=[|x=i-2|y=i-2|data=i1]|t8=[|x=i-1|y=i-2|data=i1]|t9=[|x=i0|y=i-2|data=i1]|t10=[|x=i1|y=i-2|data=i1]|t11=[|x=i2|y=i-2|data=i1]|t12=[|x=i3|y=i-2|data=i1]|t13=[|x=i-3|y=i-1|data=i1]|t14=[|x=i-2|y=i-1|data=i1]|t15=[|x=i-1|y=i-1|data=i2]|t16=[|x=i0|y=i-1|data=i2]|t17=[|x=i1|y=i-1|data=i2]|t18=[|x=i3|y=i-1|data=i1]|t19=[|x=i2|y=i-1|data=i1]|t20=[|x=i-3|y=i0|data=i1]|t21=[|x=i-2|y=i0|data=i1]|t22=[|x=i-1|y=i0|data=i2]|t23=[|x=i0|y=i0|data=i3b]|t24=[|x=i1|y=i0|data=i2]|t25=[|x=i2|y=i0|data=i1]|t26=[|x=i3|y=i0|data=i1]|t27=[|x=i-3|y=i1|data=i1]|t28=[|x=i-2|y=i1|data=i1]|t29=[|x=i-1|y=i1|data=i2]|t30=[|x=i0|y=i1|data=i2]|t31=[|x=i1|y=i1|data=i2]|t32=[|x=i2|y=i1|data=i1]|t33=[|x=i3|y=i1|data=i1]|t34=[|x=i-2|y=i2|data=i1]|t35=[|x=i-1|y=i2|data=i1]|t36=[|x=i0|y=i2|data=i1]|t37=[|x=i1|y=i2|data=i1]|t38=[|x=i2|y=i2|data=i1]|t39=[|x=i-1|y=i3|data=i1]|t40=[|x=i0|y=i3|data=i1]|t41=[|x=i1|y=i3|data=i1]]'),
--------- T3 ---------
(5351, '#blocks=[|t0=[|x=i-1|y=i-3|data=i1]|t1=[|x=i0|y=i-3|data=i1]|t2=[|x=i1|y=i-3|data=i1]|t3=[|x=i2|y=i-3|data=i1]|t7=[|x=i-2|y=i-2|data=i1]|t8=[|x=i-1|y=i-2|data=i1]|t9=[|x=i0|y=i-2|data=i1]|t10=[|x=i1|y=i-2|data=i1]|t11=[|x=i2|y=i-2|data=i1]|t12=[|x=i3|y=i-2|data=i1]|t13=[|x=i-3|y=i-1|data=i1]|t14=[|x=i-2|y=i-1|data=i1]|t15=[|x=i-1|y=i-1|data=i2]|t16=[|x=i0|y=i-1|data=i2]|t17=[|x=i1|y=i-1|data=i2]|t18=[|x=i3|y=i-1|data=i1]|t19=[|x=i2|y=i-1|data=i1]|t20=[|x=i-3|y=i0|data=i1]|t21=[|x=i-2|y=i0|data=i1]|t22=[|x=i-1|y=i0|data=i2]|t23=[|x=i0|y=i0|data=i3b]|t24=[|x=i1|y=i0|data=i2]|t25=[|x=i2|y=i0|data=i1]|t26=[|x=i3|y=i0|data=i1]|t27=[|x=i-3|y=i1|data=i1]|t28=[|x=i-2|y=i1|data=i1]|t29=[|x=i-1|y=i1|data=i2]|t30=[|x=i0|y=i1|data=i2]|t31=[|x=i1|y=i1|data=i2]|t32=[|x=i2|y=i1|data=i1]|t33=[|x=i3|y=i1|data=i1]|t34=[|x=i-2|y=i2|data=i1]|t35=[|x=i-1|y=i2|data=i1]|t36=[|x=i0|y=i2|data=i1]|t37=[|x=i1|y=i2|data=i1]|t38=[|x=i2|y=i2|data=i1]|t39=[|x=i-1|y=i3|data=i1]|t40=[|x=i0|y=i3|data=i1]|t41=[|x=i1|y=i3|data=i1]]')

PRINT N'Staging table created and filled';
GO

PRINT N'Replace old environment definitions with staging';
GO

PRINT N'Completed';
GO