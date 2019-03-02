---------------------------
--Open Perpetuum Project
--Live Patch 9
--Date: 2019/02/24
--------------------------




USE [perpetuumsa]
GO

---------------------
-- Syndicate shop Paint price update
-- 5mil
-- 2019/02/03
---------------------

UPDATE dbo.itemshop
SET
credit = 5000000
WHERE
targetdefinition IN (SELECT definition FROM entitydefaults WHERE definitionname LIKE 'def_paint_%' AND note='Paint')
AND credit IS NOT NULL;

GO



USE [perpetuumsa]
GO

--
--Cronus - Add 1-turret slot to chassis
--


DECLARE @definitionID int;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_cronus_chassis' ORDER BY definition DESC);

UPDATE entitydefaults Set options='#height=f1.3#slotFlags=4250,250,2d1,2d0' where definition=@definitionID;

GO




USE [perpetuumsa]
GO

------------CONSLIDATED ARTIFACT FIXES-----------------
--01 - Raw update using diff to recover chances on ALL scientific artifacts
--02 - Balance Alpha artifactspawn rates to be faction neutral
--03 - Apply a Flat-rate to each CT-capsule type to boost drop rates to be tolerable with fixed random
------------------------------------------------------

--01--
PRINT N'RUNNING UPDATES ON ARTIFACT LOOT TO RECOVER BAD CHANCES ON SCI';
------GENERATED SQL FROM ARTIFACT RECOVERY SCRIPT------
--SELECT CONCAT ('update artifactloot set [chance]=', original.chance,' WHERE [id]=', perpetuumsa.dbo.artifactloot.id) FROM perpetuumsa.dbo.artifactloot 
--INNER JOIN perpetuumsa_vanilla.dbo.artifactloot AS original ON perpetuumsa.dbo.artifactloot.id = original.id WHERE perpetuumsa.dbo.artifactloot.chance<>original.chance;
-------------------------------------------------------


update artifactloot set [chance]=0.025 WHERE [id]=55
update artifactloot set [chance]=0.025 WHERE [id]=56
update artifactloot set [chance]=0.025 WHERE [id]=57
update artifactloot set [chance]=0.025 WHERE [id]=58
update artifactloot set [chance]=0.005 WHERE [id]=59
update artifactloot set [chance]=0.005 WHERE [id]=60
update artifactloot set [chance]=0.025 WHERE [id]=79
update artifactloot set [chance]=0.025 WHERE [id]=80
update artifactloot set [chance]=0.005 WHERE [id]=81
update artifactloot set [chance]=0.025 WHERE [id]=106
update artifactloot set [chance]=0.025 WHERE [id]=107
update artifactloot set [chance]=0.025 WHERE [id]=108
update artifactloot set [chance]=0.025 WHERE [id]=109
update artifactloot set [chance]=0.005 WHERE [id]=110
update artifactloot set [chance]=0.005 WHERE [id]=111
update artifactloot set [chance]=0.025 WHERE [id]=161
update artifactloot set [chance]=0.025 WHERE [id]=162
update artifactloot set [chance]=0.005 WHERE [id]=163
update artifactloot set [chance]=0.025 WHERE [id]=167
update artifactloot set [chance]=0.025 WHERE [id]=168
update artifactloot set [chance]=0.005 WHERE [id]=169
update artifactloot set [chance]=0.025 WHERE [id]=179
update artifactloot set [chance]=0.025 WHERE [id]=180
update artifactloot set [chance]=0.025 WHERE [id]=181
update artifactloot set [chance]=0.025 WHERE [id]=182
update artifactloot set [chance]=0.005 WHERE [id]=183
update artifactloot set [chance]=0.005 WHERE [id]=184
update artifactloot set [chance]=0.025 WHERE [id]=218
update artifactloot set [chance]=0.025 WHERE [id]=219
update artifactloot set [chance]=0.005 WHERE [id]=220
update artifactloot set [chance]=0.025 WHERE [id]=227
update artifactloot set [chance]=0.025 WHERE [id]=228
update artifactloot set [chance]=0.005 WHERE [id]=229
update artifactloot set [chance]=0.025 WHERE [id]=236
update artifactloot set [chance]=0.025 WHERE [id]=237
update artifactloot set [chance]=0.005 WHERE [id]=238
update artifactloot set [chance]=0.025 WHERE [id]=242
update artifactloot set [chance]=0.025 WHERE [id]=243
update artifactloot set [chance]=0.005 WHERE [id]=244
update artifactloot set [chance]=0.025 WHERE [id]=254
update artifactloot set [chance]=0.025 WHERE [id]=255
update artifactloot set [chance]=0.005 WHERE [id]=256
update artifactloot set [chance]=0.025 WHERE [id]=266
update artifactloot set [chance]=0.025 WHERE [id]=267
update artifactloot set [chance]=0.005 WHERE [id]=268
update artifactloot set [chance]=0.025 WHERE [id]=281
update artifactloot set [chance]=0.025 WHERE [id]=282
update artifactloot set [chance]=0.005 WHERE [id]=283
update artifactloot set [chance]=0.025 WHERE [id]=287
update artifactloot set [chance]=0.025 WHERE [id]=288
update artifactloot set [chance]=0.005 WHERE [id]=289
update artifactloot set [chance]=0.025 WHERE [id]=315
update artifactloot set [chance]=0.025 WHERE [id]=316
update artifactloot set [chance]=0.005 WHERE [id]=317
update artifactloot set [chance]=0.025 WHERE [id]=531
update artifactloot set [chance]=0.025 WHERE [id]=532
update artifactloot set [chance]=0.005 WHERE [id]=533
update artifactloot set [chance]=0.025 WHERE [id]=534
update artifactloot set [chance]=0.025 WHERE [id]=535
update artifactloot set [chance]=0.025 WHERE [id]=536
update artifactloot set [chance]=0.025 WHERE [id]=537
update artifactloot set [chance]=0.005 WHERE [id]=538
update artifactloot set [chance]=0.005 WHERE [id]=539
update artifactloot set [chance]=0.025 WHERE [id]=540
update artifactloot set [chance]=0.025 WHERE [id]=541
update artifactloot set [chance]=0.005 WHERE [id]=542
update artifactloot set [chance]=0.025 WHERE [id]=543
update artifactloot set [chance]=0.025 WHERE [id]=544
update artifactloot set [chance]=0.005 WHERE [id]=545
update artifactloot set [chance]=0.025 WHERE [id]=546
update artifactloot set [chance]=0.025 WHERE [id]=547
update artifactloot set [chance]=0.025 WHERE [id]=548
update artifactloot set [chance]=0.025 WHERE [id]=549
update artifactloot set [chance]=0.005 WHERE [id]=550
update artifactloot set [chance]=0.005 WHERE [id]=551
update artifactloot set [chance]=0.025 WHERE [id]=552
update artifactloot set [chance]=0.025 WHERE [id]=553
update artifactloot set [chance]=0.005 WHERE [id]=554
update artifactloot set [chance]=0.025 WHERE [id]=555
update artifactloot set [chance]=0.025 WHERE [id]=556
update artifactloot set [chance]=0.005 WHERE [id]=557
update artifactloot set [chance]=0.025 WHERE [id]=558
update artifactloot set [chance]=0.025 WHERE [id]=559
update artifactloot set [chance]=0.025 WHERE [id]=560
update artifactloot set [chance]=0.025 WHERE [id]=561
update artifactloot set [chance]=0.005 WHERE [id]=562
update artifactloot set [chance]=0.005 WHERE [id]=563
update artifactloot set [chance]=0.025 WHERE [id]=564
update artifactloot set [chance]=0.025 WHERE [id]=565
update artifactloot set [chance]=0.005 WHERE [id]=566
update artifactloot set [chance]=0.025 WHERE [id]=567
update artifactloot set [chance]=0.025 WHERE [id]=568
update artifactloot set [chance]=0.005 WHERE [id]=569
update artifactloot set [chance]=0.025 WHERE [id]=570
update artifactloot set [chance]=0.025 WHERE [id]=571
update artifactloot set [chance]=0.005 WHERE [id]=572
update artifactloot set [chance]=0.025 WHERE [id]=573
update artifactloot set [chance]=0.025 WHERE [id]=574
update artifactloot set [chance]=0.005 WHERE [id]=575
update artifactloot set [chance]=0.025 WHERE [id]=576
update artifactloot set [chance]=0.025 WHERE [id]=577
update artifactloot set [chance]=0.005 WHERE [id]=578
update artifactloot set [chance]=0.025 WHERE [id]=579
update artifactloot set [chance]=0.025 WHERE [id]=580
update artifactloot set [chance]=0.005 WHERE [id]=581
update artifactloot set [chance]=0.025 WHERE [id]=582
update artifactloot set [chance]=0.025 WHERE [id]=583
update artifactloot set [chance]=0.005 WHERE [id]=584
update artifactloot set [chance]=0.025 WHERE [id]=585
update artifactloot set [chance]=0.025 WHERE [id]=586
update artifactloot set [chance]=0.005 WHERE [id]=587
update artifactloot set [chance]=0.025 WHERE [id]=588
update artifactloot set [chance]=0.025 WHERE [id]=589
update artifactloot set [chance]=0.025 WHERE [id]=590
update artifactloot set [chance]=0.025 WHERE [id]=591
update artifactloot set [chance]=0.005 WHERE [id]=592
update artifactloot set [chance]=0.005 WHERE [id]=593
update artifactloot set [chance]=0.025 WHERE [id]=594
update artifactloot set [chance]=0.025 WHERE [id]=595
update artifactloot set [chance]=0.005 WHERE [id]=596
update artifactloot set [chance]=0.025 WHERE [id]=597
update artifactloot set [chance]=0.025 WHERE [id]=598
update artifactloot set [chance]=0.005 WHERE [id]=599
update artifactloot set [chance]=0.025 WHERE [id]=600
update artifactloot set [chance]=0.025 WHERE [id]=601
update artifactloot set [chance]=0.025 WHERE [id]=602
update artifactloot set [chance]=0.025 WHERE [id]=603
update artifactloot set [chance]=0.005 WHERE [id]=604
update artifactloot set [chance]=0.005 WHERE [id]=605
update artifactloot set [chance]=0.025 WHERE [id]=606
update artifactloot set [chance]=0.025 WHERE [id]=607
update artifactloot set [chance]=0.005 WHERE [id]=608
update artifactloot set [chance]=0.025 WHERE [id]=609
update artifactloot set [chance]=0.025 WHERE [id]=610
update artifactloot set [chance]=0.005 WHERE [id]=611
update artifactloot set [chance]=0.025 WHERE [id]=618
update artifactloot set [chance]=0.025 WHERE [id]=619
update artifactloot set [chance]=0.005 WHERE [id]=620
update artifactloot set [chance]=0.025 WHERE [id]=621
update artifactloot set [chance]=0.025 WHERE [id]=622
update artifactloot set [chance]=0.005 WHERE [id]=623
update artifactloot set [chance]=0.025 WHERE [id]=624
update artifactloot set [chance]=0.025 WHERE [id]=625
update artifactloot set [chance]=0.005 WHERE [id]=626
update artifactloot set [chance]=0.025 WHERE [id]=627
update artifactloot set [chance]=0.025 WHERE [id]=628
update artifactloot set [chance]=0.005 WHERE [id]=629
update artifactloot set [chance]=0.025 WHERE [id]=630
update artifactloot set [chance]=0.025 WHERE [id]=631
update artifactloot set [chance]=0.005 WHERE [id]=632
update artifactloot set [chance]=0.025 WHERE [id]=633
update artifactloot set [chance]=0.025 WHERE [id]=634
update artifactloot set [chance]=0.005 WHERE [id]=635
update artifactloot set [chance]=0.025 WHERE [id]=636
update artifactloot set [chance]=0.025 WHERE [id]=637
update artifactloot set [chance]=0.005 WHERE [id]=638
update artifactloot set [chance]=0.025 WHERE [id]=990
update artifactloot set [chance]=0.025 WHERE [id]=991
update artifactloot set [chance]=0.005 WHERE [id]=992
update artifactloot set [chance]=0.05 WHERE [id]=1209
update artifactloot set [chance]=0.05 WHERE [id]=1210
update artifactloot set [chance]=0.05 WHERE [id]=1211
update artifactloot set [chance]=0.05 WHERE [id]=1212
update artifactloot set [chance]=0.05 WHERE [id]=1213
update artifactloot set [chance]=0.05 WHERE [id]=1214
update artifactloot set [chance]=0.05 WHERE [id]=1215
update artifactloot set [chance]=0.05 WHERE [id]=1216
update artifactloot set [chance]=0.05 WHERE [id]=1217
update artifactloot set [chance]=0.05 WHERE [id]=1218
update artifactloot set [chance]=0.05 WHERE [id]=1219
update artifactloot set [chance]=0.05 WHERE [id]=1220
update artifactloot set [chance]=0.05 WHERE [id]=1221
update artifactloot set [chance]=0.05 WHERE [id]=1222
update artifactloot set [chance]=0.05 WHERE [id]=1223
update artifactloot set [chance]=0.05 WHERE [id]=1224
update artifactloot set [chance]=0.05 WHERE [id]=1225
update artifactloot set [chance]=0.05 WHERE [id]=1226
update artifactloot set [chance]=0.015 WHERE [id]=1227
update artifactloot set [chance]=0.015 WHERE [id]=1228
update artifactloot set [chance]=0.015 WHERE [id]=1229
update artifactloot set [chance]=0.015 WHERE [id]=1230
update artifactloot set [chance]=0.015 WHERE [id]=1231
update artifactloot set [chance]=0.015 WHERE [id]=1232
update artifactloot set [chance]=0.015 WHERE [id]=1233
update artifactloot set [chance]=0.015 WHERE [id]=1234
update artifactloot set [chance]=0.015 WHERE [id]=1235
update artifactloot set [chance]=0.015 WHERE [id]=1236
update artifactloot set [chance]=0.015 WHERE [id]=1237
update artifactloot set [chance]=0.015 WHERE [id]=1238
update artifactloot set [chance]=0.015 WHERE [id]=1239
update artifactloot set [chance]=0.015 WHERE [id]=1240
update artifactloot set [chance]=0.015 WHERE [id]=1241
update artifactloot set [chance]=0.015 WHERE [id]=1242
update artifactloot set [chance]=0.015 WHERE [id]=1243
update artifactloot set [chance]=0.015 WHERE [id]=1244
update artifactloot set [chance]=0.015 WHERE [id]=1245
update artifactloot set [chance]=0.015 WHERE [id]=1246
update artifactloot set [chance]=0.015 WHERE [id]=1247
update artifactloot set [chance]=0.015 WHERE [id]=1248
update artifactloot set [chance]=0.015 WHERE [id]=1249
update artifactloot set [chance]=0.015 WHERE [id]=1250
update artifactloot set [chance]=0.015 WHERE [id]=1251
update artifactloot set [chance]=0.015 WHERE [id]=1252
update artifactloot set [chance]=0.015 WHERE [id]=1253
update artifactloot set [chance]=0.015 WHERE [id]=1254
update artifactloot set [chance]=0.015 WHERE [id]=1255
update artifactloot set [chance]=0.015 WHERE [id]=1256
update artifactloot set [chance]=0.015 WHERE [id]=1257
update artifactloot set [chance]=0.015 WHERE [id]=1258
update artifactloot set [chance]=0.015 WHERE [id]=1259
update artifactloot set [chance]=0.015 WHERE [id]=1260
update artifactloot set [chance]=0.015 WHERE [id]=1261
update artifactloot set [chance]=0.015 WHERE [id]=1262
update artifactloot set [chance]=0.05 WHERE [id]=1263
update artifactloot set [chance]=0.05 WHERE [id]=1264
update artifactloot set [chance]=0.05 WHERE [id]=1265
update artifactloot set [chance]=0.05 WHERE [id]=1266
update artifactloot set [chance]=0.05 WHERE [id]=1267
update artifactloot set [chance]=0.05 WHERE [id]=1268
update artifactloot set [chance]=0.05 WHERE [id]=1269
update artifactloot set [chance]=0.05 WHERE [id]=1270
update artifactloot set [chance]=0.05 WHERE [id]=1271
update artifactloot set [chance]=0.05 WHERE [id]=1272
update artifactloot set [chance]=0.05 WHERE [id]=1273
update artifactloot set [chance]=0.05 WHERE [id]=1274
update artifactloot set [chance]=0.05 WHERE [id]=1275
update artifactloot set [chance]=0.05 WHERE [id]=1276
update artifactloot set [chance]=0.05 WHERE [id]=1277
update artifactloot set [chance]=0.05 WHERE [id]=1278
update artifactloot set [chance]=0.05 WHERE [id]=1279
update artifactloot set [chance]=0.05 WHERE [id]=1280
update artifactloot set [chance]=0.05 WHERE [id]=1633
update artifactloot set [chance]=0.05 WHERE [id]=1634
update artifactloot set [chance]=0.05 WHERE [id]=1635
update artifactloot set [chance]=0.05 WHERE [id]=1636
update artifactloot set [chance]=0.05 WHERE [id]=1637
update artifactloot set [chance]=0.05 WHERE [id]=1638
update artifactloot set [chance]=0.05 WHERE [id]=1639
update artifactloot set [chance]=0.05 WHERE [id]=1640
update artifactloot set [chance]=0.05 WHERE [id]=1641
update artifactloot set [chance]=0.05 WHERE [id]=1642
update artifactloot set [chance]=0.05 WHERE [id]=1643
update artifactloot set [chance]=0.05 WHERE [id]=1644
update artifactloot set [chance]=0.05 WHERE [id]=1645
update artifactloot set [chance]=0.05 WHERE [id]=1646
update artifactloot set [chance]=0.05 WHERE [id]=1647
update artifactloot set [chance]=0.05 WHERE [id]=1648
update artifactloot set [chance]=0.05 WHERE [id]=1649
update artifactloot set [chance]=0.05 WHERE [id]=1650
update artifactloot set [chance]=0.015 WHERE [id]=1651
update artifactloot set [chance]=0.015 WHERE [id]=1652
update artifactloot set [chance]=0.015 WHERE [id]=1653
update artifactloot set [chance]=0.015 WHERE [id]=1654
update artifactloot set [chance]=0.015 WHERE [id]=1655
update artifactloot set [chance]=0.015 WHERE [id]=1656
update artifactloot set [chance]=0.015 WHERE [id]=1657
update artifactloot set [chance]=0.015 WHERE [id]=1658
update artifactloot set [chance]=0.015 WHERE [id]=1659
update artifactloot set [chance]=0.015 WHERE [id]=1660
update artifactloot set [chance]=0.015 WHERE [id]=1661
update artifactloot set [chance]=0.015 WHERE [id]=1662
update artifactloot set [chance]=0.015 WHERE [id]=1663
update artifactloot set [chance]=0.015 WHERE [id]=1664
update artifactloot set [chance]=0.015 WHERE [id]=1665
update artifactloot set [chance]=0.015 WHERE [id]=1666
update artifactloot set [chance]=0.015 WHERE [id]=1667
update artifactloot set [chance]=0.015 WHERE [id]=1668
update artifactloot set [chance]=0.015 WHERE [id]=1669
update artifactloot set [chance]=0.015 WHERE [id]=1670
update artifactloot set [chance]=0.015 WHERE [id]=1671
update artifactloot set [chance]=0.015 WHERE [id]=1672
update artifactloot set [chance]=0.015 WHERE [id]=1673
update artifactloot set [chance]=0.015 WHERE [id]=1674
update artifactloot set [chance]=0.015 WHERE [id]=1675
update artifactloot set [chance]=0.015 WHERE [id]=1676
update artifactloot set [chance]=0.015 WHERE [id]=1677
update artifactloot set [chance]=0.015 WHERE [id]=1678
update artifactloot set [chance]=0.015 WHERE [id]=1679
update artifactloot set [chance]=0.015 WHERE [id]=1680
update artifactloot set [chance]=0.015 WHERE [id]=1681
update artifactloot set [chance]=0.015 WHERE [id]=1682
update artifactloot set [chance]=0.015 WHERE [id]=1683
update artifactloot set [chance]=0.015 WHERE [id]=1684
update artifactloot set [chance]=0.015 WHERE [id]=1685
update artifactloot set [chance]=0.015 WHERE [id]=1686
update artifactloot set [chance]=0.015 WHERE [id]=1687
update artifactloot set [chance]=0.015 WHERE [id]=1688
update artifactloot set [chance]=0.015 WHERE [id]=1689
update artifactloot set [chance]=0.015 WHERE [id]=1690
update artifactloot set [chance]=0.015 WHERE [id]=1691
update artifactloot set [chance]=0.015 WHERE [id]=1692
update artifactloot set [chance]=0.015 WHERE [id]=1693
update artifactloot set [chance]=0.015 WHERE [id]=1694
update artifactloot set [chance]=0.015 WHERE [id]=1695
update artifactloot set [chance]=0.015 WHERE [id]=1696
update artifactloot set [chance]=0.015 WHERE [id]=1697
update artifactloot set [chance]=0.015 WHERE [id]=1698
update artifactloot set [chance]=0.05 WHERE [id]=1699
update artifactloot set [chance]=0.05 WHERE [id]=1700
update artifactloot set [chance]=0.05 WHERE [id]=1701
update artifactloot set [chance]=0.05 WHERE [id]=1702
update artifactloot set [chance]=0.05 WHERE [id]=1703
update artifactloot set [chance]=0.05 WHERE [id]=1704
update artifactloot set [chance]=0.05 WHERE [id]=1705
update artifactloot set [chance]=0.05 WHERE [id]=1706
update artifactloot set [chance]=0.05 WHERE [id]=1707
update artifactloot set [chance]=0.05 WHERE [id]=1708
update artifactloot set [chance]=0.05 WHERE [id]=1709
update artifactloot set [chance]=0.05 WHERE [id]=1710
update artifactloot set [chance]=0.05 WHERE [id]=1711
update artifactloot set [chance]=0.05 WHERE [id]=1712
update artifactloot set [chance]=0.05 WHERE [id]=1713
update artifactloot set [chance]=0.05 WHERE [id]=1714
update artifactloot set [chance]=0.05 WHERE [id]=1715
update artifactloot set [chance]=0.05 WHERE [id]=1716
update artifactloot set [chance]=0.05 WHERE [id]=1717
update artifactloot set [chance]=0.05 WHERE [id]=1718
update artifactloot set [chance]=0.05 WHERE [id]=1719
update artifactloot set [chance]=0.05 WHERE [id]=1720
update artifactloot set [chance]=0.05 WHERE [id]=1721
update artifactloot set [chance]=0.05 WHERE [id]=1722
update artifactloot set [chance]=0.05 WHERE [id]=1723
update artifactloot set [chance]=0.05 WHERE [id]=1724
update artifactloot set [chance]=0.05 WHERE [id]=1725
update artifactloot set [chance]=0.05 WHERE [id]=1726
update artifactloot set [chance]=0.05 WHERE [id]=1727
update artifactloot set [chance]=0.05 WHERE [id]=1728
update artifactloot set [chance]=0.05 WHERE [id]=2081
update artifactloot set [chance]=0.05 WHERE [id]=2082
update artifactloot set [chance]=0.05 WHERE [id]=2083
update artifactloot set [chance]=0.05 WHERE [id]=2084
update artifactloot set [chance]=0.05 WHERE [id]=2085
update artifactloot set [chance]=0.05 WHERE [id]=2086
update artifactloot set [chance]=0.05 WHERE [id]=2087
update artifactloot set [chance]=0.05 WHERE [id]=2088
update artifactloot set [chance]=0.05 WHERE [id]=2089
update artifactloot set [chance]=0.05 WHERE [id]=2090
update artifactloot set [chance]=0.05 WHERE [id]=2091
update artifactloot set [chance]=0.05 WHERE [id]=2092
update artifactloot set [chance]=0.05 WHERE [id]=2093
update artifactloot set [chance]=0.05 WHERE [id]=2094
update artifactloot set [chance]=0.05 WHERE [id]=2095
update artifactloot set [chance]=0.05 WHERE [id]=2096
update artifactloot set [chance]=0.05 WHERE [id]=2097
update artifactloot set [chance]=0.015 WHERE [id]=2098
update artifactloot set [chance]=0.015 WHERE [id]=2099
update artifactloot set [chance]=0.015 WHERE [id]=2100
update artifactloot set [chance]=0.015 WHERE [id]=2101
update artifactloot set [chance]=0.015 WHERE [id]=2102
update artifactloot set [chance]=0.015 WHERE [id]=2103
update artifactloot set [chance]=0.015 WHERE [id]=2104
update artifactloot set [chance]=0.015 WHERE [id]=2105
update artifactloot set [chance]=0.015 WHERE [id]=2106
update artifactloot set [chance]=0.015 WHERE [id]=2107
update artifactloot set [chance]=0.015 WHERE [id]=2108
update artifactloot set [chance]=0.015 WHERE [id]=2109
update artifactloot set [chance]=0.015 WHERE [id]=2110
update artifactloot set [chance]=0.015 WHERE [id]=2111
update artifactloot set [chance]=0.015 WHERE [id]=2112
update artifactloot set [chance]=0.015 WHERE [id]=2113
update artifactloot set [chance]=0.015 WHERE [id]=2114
update artifactloot set [chance]=0.015 WHERE [id]=2115
update artifactloot set [chance]=0.015 WHERE [id]=2116
update artifactloot set [chance]=0.015 WHERE [id]=2117
update artifactloot set [chance]=0.015 WHERE [id]=2118
update artifactloot set [chance]=0.015 WHERE [id]=2119
update artifactloot set [chance]=0.015 WHERE [id]=2120
update artifactloot set [chance]=0.015 WHERE [id]=2121
update artifactloot set [chance]=0.015 WHERE [id]=2122
update artifactloot set [chance]=0.015 WHERE [id]=2123
update artifactloot set [chance]=0.015 WHERE [id]=2124
update artifactloot set [chance]=0.015 WHERE [id]=2125
update artifactloot set [chance]=0.015 WHERE [id]=2126
update artifactloot set [chance]=0.015 WHERE [id]=2127
update artifactloot set [chance]=0.015 WHERE [id]=2128
update artifactloot set [chance]=0.015 WHERE [id]=2129
update artifactloot set [chance]=0.015 WHERE [id]=2130
update artifactloot set [chance]=0.015 WHERE [id]=2131
update artifactloot set [chance]=0.05 WHERE [id]=2132
update artifactloot set [chance]=0.05 WHERE [id]=2133
update artifactloot set [chance]=0.05 WHERE [id]=2134
update artifactloot set [chance]=0.05 WHERE [id]=2135
update artifactloot set [chance]=0.05 WHERE [id]=2136
update artifactloot set [chance]=0.05 WHERE [id]=2137
update artifactloot set [chance]=0.05 WHERE [id]=2138
update artifactloot set [chance]=0.05 WHERE [id]=2139
update artifactloot set [chance]=0.05 WHERE [id]=2140
update artifactloot set [chance]=0.05 WHERE [id]=2141
update artifactloot set [chance]=0.05 WHERE [id]=2142
update artifactloot set [chance]=0.05 WHERE [id]=2143
update artifactloot set [chance]=0.05 WHERE [id]=2144
update artifactloot set [chance]=0.05 WHERE [id]=2145
update artifactloot set [chance]=0.05 WHERE [id]=2146
update artifactloot set [chance]=0.05 WHERE [id]=2147
update artifactloot set [chance]=0.05 WHERE [id]=2148
update artifactloot set [chance]=1 WHERE [id]=2415
update artifactloot set [chance]=0.1 WHERE [id]=2421
update artifactloot set [chance]=0.1 WHERE [id]=2429
update artifactloot set [chance]=1 WHERE [id]=2432
update artifactloot set [chance]=1 WHERE [id]=2435
update artifactloot set [chance]=0.1 WHERE [id]=2437
update artifactloot set [chance]=0.1 WHERE [id]=2442
update artifactloot set [chance]=1 WHERE [id]=2446
update artifactloot set [chance]=1 WHERE [id]=2458
update artifactloot set [chance]=0.1 WHERE [id]=2462
update artifactloot set [chance]=0.1 WHERE [id]=2464
update artifactloot set [chance]=1 WHERE [id]=2465
update artifactloot set [chance]=1 WHERE [id]=2474
update artifactloot set [chance]=0.1 WHERE [id]=2475
update artifactloot set [chance]=0.1 WHERE [id]=2497
update artifactloot set [chance]=1 WHERE [id]=2500
update artifactloot set [chance]=1 WHERE [id]=2503
update artifactloot set [chance]=0.1 WHERE [id]=2506
update artifactloot set [chance]=0.025 WHERE [id]=2691
update artifactloot set [chance]=0.025 WHERE [id]=2694
update artifactloot set [chance]=0.025 WHERE [id]=2697
update artifactloot set [chance]=0.025 WHERE [id]=2702
update artifactloot set [chance]=0.025 WHERE [id]=2705
update artifactloot set [chance]=0.025 WHERE [id]=2710
update artifactloot set [chance]=0.025 WHERE [id]=2719
update artifactloot set [chance]=0.025 WHERE [id]=2722
update artifactloot set [chance]=0.025 WHERE [id]=2725
update artifactloot set [chance]=0.0125 WHERE [id]=2728
update artifactloot set [chance]=0.0125 WHERE [id]=2731
update artifactloot set [chance]=0.0125 WHERE [id]=2734
update artifactloot set [chance]=0.025 WHERE [id]=2737
update artifactloot set [chance]=0.025 WHERE [id]=2740
update artifactloot set [chance]=0.025 WHERE [id]=2746
update artifactloot set [chance]=0.025 WHERE [id]=2749
update artifactloot set [chance]=0.025 WHERE [id]=2752
update artifactloot set [chance]=0.025 WHERE [id]=2755
update artifactloot set [chance]=0.0125 WHERE [id]=2758
update artifactloot set [chance]=0.025 WHERE [id]=2761
update artifactloot set [chance]=0.0125 WHERE [id]=2764
update artifactloot set [chance]=0.025 WHERE [id]=2767
update artifactloot set [chance]=0.0125 WHERE [id]=2770
update artifactloot set [chance]=0.025 WHERE [id]=2773
update artifactloot set [chance]=0.0125 WHERE [id]=2776
update artifactloot set [chance]=0.0125 WHERE [id]=2779
update artifactloot set [chance]=0.0125 WHERE [id]=2782
update artifactloot set [chance]=0.1 WHERE [id]=2792
update artifactloot set [chance]=0.1 WHERE [id]=2793
update artifactloot set [chance]=0.1 WHERE [id]=2794
update artifactloot set [chance]=0.1 WHERE [id]=2796
update artifactloot set [chance]=0.1 WHERE [id]=2797
update artifactloot set [chance]=0.1 WHERE [id]=2799
update artifactloot set [chance]=0.1 WHERE [id]=2800
update artifactloot set [chance]=0.1 WHERE [id]=2801
update artifactloot set [chance]=0.1 WHERE [id]=2803
update artifactloot set [chance]=0.05 WHERE [id]=2995
update artifactloot set [chance]=0.05 WHERE [id]=2996
update artifactloot set [chance]=0.01 WHERE [id]=2997
update artifactloot set [chance]=0.05 WHERE [id]=3022
update artifactloot set [chance]=0.05 WHERE [id]=3023
update artifactloot set [chance]=0.05 WHERE [id]=3024
update artifactloot set [chance]=0.05 WHERE [id]=3025
update artifactloot set [chance]=0.01 WHERE [id]=3026
update artifactloot set [chance]=0.01 WHERE [id]=3027
update artifactloot set [chance]=0.05 WHERE [id]=3069
update artifactloot set [chance]=0.05 WHERE [id]=3070
update artifactloot set [chance]=0.01 WHERE [id]=3071
update artifactloot set [chance]=0.05 WHERE [id]=3075
update artifactloot set [chance]=0.05 WHERE [id]=3076
update artifactloot set [chance]=0.01 WHERE [id]=3077
update artifactloot set [chance]=0.05 WHERE [id]=3084
update artifactloot set [chance]=0.05 WHERE [id]=3085
update artifactloot set [chance]=0.05 WHERE [id]=3086
update artifactloot set [chance]=0.05 WHERE [id]=3087
update artifactloot set [chance]=0.01 WHERE [id]=3088
update artifactloot set [chance]=0.01 WHERE [id]=3089
update artifactloot set [chance]=0.05 WHERE [id]=3120
update artifactloot set [chance]=0.05 WHERE [id]=3121
update artifactloot set [chance]=0.01 WHERE [id]=3122
update artifactloot set [chance]=0.05 WHERE [id]=3126
update artifactloot set [chance]=0.05 WHERE [id]=3127
update artifactloot set [chance]=0.01 WHERE [id]=3128
update artifactloot set [chance]=0.05 WHERE [id]=3152
update artifactloot set [chance]=0.05 WHERE [id]=3153
update artifactloot set [chance]=0.05 WHERE [id]=3154
update artifactloot set [chance]=0.05 WHERE [id]=3155
update artifactloot set [chance]=0.01 WHERE [id]=3156
update artifactloot set [chance]=0.01 WHERE [id]=3157
update artifactloot set [chance]=0.05 WHERE [id]=3187
update artifactloot set [chance]=0.05 WHERE [id]=3188
update artifactloot set [chance]=0.01 WHERE [id]=3189
update artifactloot set [chance]=0.05 WHERE [id]=3196
update artifactloot set [chance]=0.05 WHERE [id]=3197
update artifactloot set [chance]=0.01 WHERE [id]=3198
update artifactloot set [chance]=0.05 WHERE [id]=3205
update artifactloot set [chance]=0.05 WHERE [id]=3206
update artifactloot set [chance]=0.01 WHERE [id]=3207
update artifactloot set [chance]=0.05 WHERE [id]=3217
update artifactloot set [chance]=0.05 WHERE [id]=3218
update artifactloot set [chance]=0.01 WHERE [id]=3219
update artifactloot set [chance]=0.05 WHERE [id]=3232
update artifactloot set [chance]=0.05 WHERE [id]=3233
update artifactloot set [chance]=0.01 WHERE [id]=3234
update artifactloot set [chance]=0.05 WHERE [id]=3238
update artifactloot set [chance]=0.05 WHERE [id]=3239
update artifactloot set [chance]=0.01 WHERE [id]=3240
update artifactloot set [chance]=0.05 WHERE [id]=3265
update artifactloot set [chance]=0.05 WHERE [id]=3285
update artifactloot set [chance]=0.01 WHERE [id]=3286
update artifactloot set [chance]=1 WHERE [id]=3329
update artifactloot set [chance]=0.05 WHERE [id]=3451
update artifactloot set [chance]=0.05 WHERE [id]=3452
update artifactloot set [chance]=0.01 WHERE [id]=3453
update artifactloot set [chance]=1 WHERE [id]=3542
update artifactloot set [chance]=0.2 WHERE [id]=3548
update artifactloot set [chance]=0.2 WHERE [id]=3556
update artifactloot set [chance]=1 WHERE [id]=3559
update artifactloot set [chance]=1 WHERE [id]=3562
update artifactloot set [chance]=0.2 WHERE [id]=3564
update artifactloot set [chance]=0.2 WHERE [id]=3569
update artifactloot set [chance]=1 WHERE [id]=3573
update artifactloot set [chance]=1 WHERE [id]=3585
update artifactloot set [chance]=0.03 WHERE [id]=3602
update artifactloot set [chance]=0.03 WHERE [id]=3603
update artifactloot set [chance]=0.03 WHERE [id]=3604
update artifactloot set [chance]=0.03 WHERE [id]=3605
update artifactloot set [chance]=0.03 WHERE [id]=3606
update artifactloot set [chance]=0.03 WHERE [id]=3607
update artifactloot set [chance]=0.03 WHERE [id]=3608
update artifactloot set [chance]=0.03 WHERE [id]=3609
update artifactloot set [chance]=0.03 WHERE [id]=3610
update artifactloot set [chance]=0.05 WHERE [id]=3611
update artifactloot set [chance]=0.05 WHERE [id]=3612
update artifactloot set [chance]=0.01 WHERE [id]=3613
update artifactloot set [chance]=0.05 WHERE [id]=3614
update artifactloot set [chance]=0.05 WHERE [id]=3615
update artifactloot set [chance]=0.05 WHERE [id]=3616
update artifactloot set [chance]=0.05 WHERE [id]=3617
update artifactloot set [chance]=0.01 WHERE [id]=3618
update artifactloot set [chance]=0.01 WHERE [id]=3619
update artifactloot set [chance]=0.05 WHERE [id]=3620
update artifactloot set [chance]=0.05 WHERE [id]=3621
update artifactloot set [chance]=0.01 WHERE [id]=3622
update artifactloot set [chance]=0.05 WHERE [id]=3623
update artifactloot set [chance]=0.05 WHERE [id]=3624
update artifactloot set [chance]=0.01 WHERE [id]=3625
update artifactloot set [chance]=0.05 WHERE [id]=3626
update artifactloot set [chance]=0.05 WHERE [id]=3627
update artifactloot set [chance]=0.05 WHERE [id]=3628
update artifactloot set [chance]=0.05 WHERE [id]=3629
update artifactloot set [chance]=0.01 WHERE [id]=3630
update artifactloot set [chance]=0.01 WHERE [id]=3631
update artifactloot set [chance]=0.05 WHERE [id]=3632
update artifactloot set [chance]=0.05 WHERE [id]=3633
update artifactloot set [chance]=0.01 WHERE [id]=3634
update artifactloot set [chance]=0.05 WHERE [id]=3635
update artifactloot set [chance]=0.05 WHERE [id]=3636
update artifactloot set [chance]=0.01 WHERE [id]=3637
update artifactloot set [chance]=0.05 WHERE [id]=3638
update artifactloot set [chance]=0.05 WHERE [id]=3639
update artifactloot set [chance]=0.05 WHERE [id]=3640
update artifactloot set [chance]=0.05 WHERE [id]=3641
update artifactloot set [chance]=0.01 WHERE [id]=3642
update artifactloot set [chance]=0.01 WHERE [id]=3643
update artifactloot set [chance]=0.05 WHERE [id]=3644
update artifactloot set [chance]=0.05 WHERE [id]=3645
update artifactloot set [chance]=0.01 WHERE [id]=3646
update artifactloot set [chance]=0.05 WHERE [id]=3647
update artifactloot set [chance]=0.05 WHERE [id]=3648
update artifactloot set [chance]=0.01 WHERE [id]=3649
update artifactloot set [chance]=0.05 WHERE [id]=3650
update artifactloot set [chance]=0.05 WHERE [id]=3651
update artifactloot set [chance]=0.01 WHERE [id]=3652
update artifactloot set [chance]=0.05 WHERE [id]=3653
update artifactloot set [chance]=0.05 WHERE [id]=3654
update artifactloot set [chance]=0.01 WHERE [id]=3655
update artifactloot set [chance]=0.05 WHERE [id]=3656
update artifactloot set [chance]=0.05 WHERE [id]=3657
update artifactloot set [chance]=0.01 WHERE [id]=3658
update artifactloot set [chance]=0.05 WHERE [id]=3659
update artifactloot set [chance]=0.05 WHERE [id]=3660
update artifactloot set [chance]=0.01 WHERE [id]=3661
update artifactloot set [chance]=0.05 WHERE [id]=3662
update artifactloot set [chance]=0.05 WHERE [id]=3663
update artifactloot set [chance]=0.01 WHERE [id]=3664
update artifactloot set [chance]=0.05 WHERE [id]=3665
update artifactloot set [chance]=0.05 WHERE [id]=3666
update artifactloot set [chance]=0.01 WHERE [id]=3667
update artifactloot set [chance]=0.05 WHERE [id]=3668
update artifactloot set [chance]=0.05 WHERE [id]=3669
update artifactloot set [chance]=0.05 WHERE [id]=3670
update artifactloot set [chance]=0.05 WHERE [id]=3671
update artifactloot set [chance]=0.01 WHERE [id]=3672
update artifactloot set [chance]=0.01 WHERE [id]=3673
update artifactloot set [chance]=0.05 WHERE [id]=3674
update artifactloot set [chance]=0.05 WHERE [id]=3675
update artifactloot set [chance]=0.01 WHERE [id]=3676
update artifactloot set [chance]=0.05 WHERE [id]=3677
update artifactloot set [chance]=0.05 WHERE [id]=3678
update artifactloot set [chance]=0.01 WHERE [id]=3679
update artifactloot set [chance]=0.05 WHERE [id]=3680
update artifactloot set [chance]=0.05 WHERE [id]=3681
update artifactloot set [chance]=0.05 WHERE [id]=3682
update artifactloot set [chance]=0.05 WHERE [id]=3683
update artifactloot set [chance]=0.01 WHERE [id]=3684
update artifactloot set [chance]=0.01 WHERE [id]=3685
update artifactloot set [chance]=0.05 WHERE [id]=3686
update artifactloot set [chance]=0.05 WHERE [id]=3687
update artifactloot set [chance]=0.01 WHERE [id]=3688
update artifactloot set [chance]=0.05 WHERE [id]=3689
update artifactloot set [chance]=0.05 WHERE [id]=3690
update artifactloot set [chance]=0.01 WHERE [id]=3691
update artifactloot set [chance]=0.03 WHERE [id]=3692
update artifactloot set [chance]=0.03 WHERE [id]=3693
update artifactloot set [chance]=0.03 WHERE [id]=3694
update artifactloot set [chance]=0.03 WHERE [id]=3695
update artifactloot set [chance]=0.03 WHERE [id]=3696
update artifactloot set [chance]=0.03 WHERE [id]=3697
update artifactloot set [chance]=0.05 WHERE [id]=3698
update artifactloot set [chance]=0.05 WHERE [id]=3699
update artifactloot set [chance]=0.01 WHERE [id]=3700
update artifactloot set [chance]=0.05 WHERE [id]=3701
update artifactloot set [chance]=0.05 WHERE [id]=3702
update artifactloot set [chance]=0.01 WHERE [id]=3703
update artifactloot set [chance]=0.05 WHERE [id]=3704
update artifactloot set [chance]=0.05 WHERE [id]=3705
update artifactloot set [chance]=0.01 WHERE [id]=3706
update artifactloot set [chance]=0.05 WHERE [id]=3707
update artifactloot set [chance]=0.05 WHERE [id]=3708
update artifactloot set [chance]=0.01 WHERE [id]=3709
update artifactloot set [chance]=0.05 WHERE [id]=3710
update artifactloot set [chance]=0.05 WHERE [id]=3711
update artifactloot set [chance]=0.01 WHERE [id]=3712
update artifactloot set [chance]=0.05 WHERE [id]=3713
update artifactloot set [chance]=0.05 WHERE [id]=3714
update artifactloot set [chance]=0.01 WHERE [id]=3715
update artifactloot set [chance]=0.05 WHERE [id]=3716
update artifactloot set [chance]=0.05 WHERE [id]=3717
update artifactloot set [chance]=0.01 WHERE [id]=3718
update artifactloot set [chance]=0.03 WHERE [id]=3731
update artifactloot set [chance]=0.03 WHERE [id]=3732
update artifactloot set [chance]=0.03 WHERE [id]=3733
update artifactloot set [chance]=0.1 WHERE [id]=3734
update artifactloot set [chance]=0.1 WHERE [id]=3735
update artifactloot set [chance]=0.1 WHERE [id]=3736
update artifactloot set [chance]=0.2 WHERE [id]=3905
update artifactloot set [chance]=0.2 WHERE [id]=3906
update artifactloot set [chance]=1 WHERE [id]=3925
update artifactloot set [chance]=0.2 WHERE [id]=3945
update artifactloot set [chance]=0.1 WHERE [id]=4169
update artifactloot set [chance]=0.1 WHERE [id]=4170
update artifactloot set [chance]=0.1 WHERE [id]=4171
update artifactloot set [chance]=0.1 WHERE [id]=4172
update artifactloot set [chance]=0.1 WHERE [id]=4173
update artifactloot set [chance]=0.1 WHERE [id]=4174
update artifactloot set [chance]=0.1 WHERE [id]=4175
update artifactloot set [chance]=0.1 WHERE [id]=4176
update artifactloot set [chance]=0.1 WHERE [id]=4177
update artifactloot set [chance]=0.1 WHERE [id]=4178
update artifactloot set [chance]=0.1 WHERE [id]=4179
update artifactloot set [chance]=0.1 WHERE [id]=4180
update artifactloot set [chance]=0.1 WHERE [id]=4181
update artifactloot set [chance]=0.1 WHERE [id]=4182
update artifactloot set [chance]=0.1 WHERE [id]=4183
update artifactloot set [chance]=0.1 WHERE [id]=4184
update artifactloot set [chance]=0.1 WHERE [id]=4185
update artifactloot set [chance]=0.1 WHERE [id]=4186
update artifactloot set [chance]=0.03 WHERE [id]=4187
update artifactloot set [chance]=0.03 WHERE [id]=4188
update artifactloot set [chance]=0.03 WHERE [id]=4189
update artifactloot set [chance]=0.03 WHERE [id]=4190
update artifactloot set [chance]=0.03 WHERE [id]=4191
update artifactloot set [chance]=0.03 WHERE [id]=4192
update artifactloot set [chance]=0.03 WHERE [id]=4193
update artifactloot set [chance]=0.03 WHERE [id]=4194
update artifactloot set [chance]=0.03 WHERE [id]=4195
update artifactloot set [chance]=0.03 WHERE [id]=4196
update artifactloot set [chance]=0.03 WHERE [id]=4197
update artifactloot set [chance]=0.03 WHERE [id]=4198
update artifactloot set [chance]=0.03 WHERE [id]=4199
update artifactloot set [chance]=0.03 WHERE [id]=4200
update artifactloot set [chance]=0.03 WHERE [id]=4201
update artifactloot set [chance]=0.03 WHERE [id]=4202
update artifactloot set [chance]=0.03 WHERE [id]=4203
update artifactloot set [chance]=0.03 WHERE [id]=4204
update artifactloot set [chance]=0.1 WHERE [id]=4205
update artifactloot set [chance]=0.1 WHERE [id]=4206
update artifactloot set [chance]=0.1 WHERE [id]=4207
update artifactloot set [chance]=0.1 WHERE [id]=4208
update artifactloot set [chance]=0.1 WHERE [id]=4209
update artifactloot set [chance]=0.1 WHERE [id]=4210
update artifactloot set [chance]=0.1 WHERE [id]=4211
update artifactloot set [chance]=0.1 WHERE [id]=4212
update artifactloot set [chance]=0.1 WHERE [id]=4213
update artifactloot set [chance]=0.1 WHERE [id]=4214
update artifactloot set [chance]=0.1 WHERE [id]=4215
update artifactloot set [chance]=0.1 WHERE [id]=4216
update artifactloot set [chance]=0.1 WHERE [id]=4217
update artifactloot set [chance]=0.1 WHERE [id]=4218
update artifactloot set [chance]=0.1 WHERE [id]=4219
update artifactloot set [chance]=0.1 WHERE [id]=4572
update artifactloot set [chance]=0.1 WHERE [id]=4573
update artifactloot set [chance]=0.1 WHERE [id]=4574
update artifactloot set [chance]=0.1 WHERE [id]=4575
update artifactloot set [chance]=0.1 WHERE [id]=4576
update artifactloot set [chance]=0.1 WHERE [id]=4577
update artifactloot set [chance]=0.1 WHERE [id]=4578
update artifactloot set [chance]=0.1 WHERE [id]=4579
update artifactloot set [chance]=0.1 WHERE [id]=4580
update artifactloot set [chance]=0.1 WHERE [id]=4581
update artifactloot set [chance]=0.1 WHERE [id]=4582
update artifactloot set [chance]=0.1 WHERE [id]=4583
update artifactloot set [chance]=0.1 WHERE [id]=4584
update artifactloot set [chance]=0.1 WHERE [id]=4585
update artifactloot set [chance]=0.1 WHERE [id]=4586
update artifactloot set [chance]=0.1 WHERE [id]=4587
update artifactloot set [chance]=0.1 WHERE [id]=4588
update artifactloot set [chance]=0.1 WHERE [id]=4589
update artifactloot set [chance]=0.03 WHERE [id]=4590
update artifactloot set [chance]=0.03 WHERE [id]=4591
update artifactloot set [chance]=0.03 WHERE [id]=4592
update artifactloot set [chance]=0.03 WHERE [id]=4593
update artifactloot set [chance]=0.03 WHERE [id]=4594
update artifactloot set [chance]=0.03 WHERE [id]=4595
update artifactloot set [chance]=0.03 WHERE [id]=4596
update artifactloot set [chance]=0.03 WHERE [id]=4597
update artifactloot set [chance]=0.03 WHERE [id]=4598
update artifactloot set [chance]=0.03 WHERE [id]=4599
update artifactloot set [chance]=0.03 WHERE [id]=4600
update artifactloot set [chance]=0.03 WHERE [id]=4601
update artifactloot set [chance]=0.03 WHERE [id]=4602
update artifactloot set [chance]=0.03 WHERE [id]=4603
update artifactloot set [chance]=0.03 WHERE [id]=4604
update artifactloot set [chance]=0.03 WHERE [id]=4605
update artifactloot set [chance]=0.03 WHERE [id]=4606
update artifactloot set [chance]=0.03 WHERE [id]=4607
update artifactloot set [chance]=0.03 WHERE [id]=4608
update artifactloot set [chance]=0.03 WHERE [id]=4609
update artifactloot set [chance]=0.03 WHERE [id]=4610
update artifactloot set [chance]=0.03 WHERE [id]=4611
update artifactloot set [chance]=0.03 WHERE [id]=4612
update artifactloot set [chance]=0.03 WHERE [id]=4613
update artifactloot set [chance]=0.03 WHERE [id]=4614
update artifactloot set [chance]=0.03 WHERE [id]=4615
update artifactloot set [chance]=0.03 WHERE [id]=4616
update artifactloot set [chance]=0.03 WHERE [id]=4617
update artifactloot set [chance]=0.03 WHERE [id]=4618
update artifactloot set [chance]=0.03 WHERE [id]=4619
update artifactloot set [chance]=0.03 WHERE [id]=4620
update artifactloot set [chance]=0.03 WHERE [id]=4621
update artifactloot set [chance]=0.03 WHERE [id]=4622
update artifactloot set [chance]=0.03 WHERE [id]=4623
update artifactloot set [chance]=0.03 WHERE [id]=4624
update artifactloot set [chance]=0.03 WHERE [id]=4625
update artifactloot set [chance]=0.03 WHERE [id]=4626
update artifactloot set [chance]=0.03 WHERE [id]=4627
update artifactloot set [chance]=0.03 WHERE [id]=4628
update artifactloot set [chance]=0.03 WHERE [id]=4629
update artifactloot set [chance]=0.03 WHERE [id]=4630
update artifactloot set [chance]=0.03 WHERE [id]=4631
update artifactloot set [chance]=0.03 WHERE [id]=4632
update artifactloot set [chance]=0.03 WHERE [id]=4633
update artifactloot set [chance]=0.03 WHERE [id]=4634
update artifactloot set [chance]=0.03 WHERE [id]=4635
update artifactloot set [chance]=0.03 WHERE [id]=4636
update artifactloot set [chance]=0.03 WHERE [id]=4637
update artifactloot set [chance]=0.1 WHERE [id]=4638
update artifactloot set [chance]=0.1 WHERE [id]=4639
update artifactloot set [chance]=0.1 WHERE [id]=4640
update artifactloot set [chance]=0.1 WHERE [id]=4641
update artifactloot set [chance]=0.1 WHERE [id]=4642
update artifactloot set [chance]=0.1 WHERE [id]=4643
update artifactloot set [chance]=0.1 WHERE [id]=4644
update artifactloot set [chance]=0.1 WHERE [id]=4645
update artifactloot set [chance]=0.1 WHERE [id]=4646
update artifactloot set [chance]=0.1 WHERE [id]=4647
update artifactloot set [chance]=0.1 WHERE [id]=4648
update artifactloot set [chance]=0.1 WHERE [id]=4649
update artifactloot set [chance]=0.1 WHERE [id]=4650
update artifactloot set [chance]=0.1 WHERE [id]=4651
update artifactloot set [chance]=0.1 WHERE [id]=4652
update artifactloot set [chance]=0.1 WHERE [id]=4653
update artifactloot set [chance]=0.1 WHERE [id]=4654
update artifactloot set [chance]=0.1 WHERE [id]=4655
update artifactloot set [chance]=0.1 WHERE [id]=4656
update artifactloot set [chance]=0.1 WHERE [id]=4657
update artifactloot set [chance]=0.1 WHERE [id]=4658
update artifactloot set [chance]=0.1 WHERE [id]=4659
update artifactloot set [chance]=0.1 WHERE [id]=4660
update artifactloot set [chance]=0.1 WHERE [id]=4661
update artifactloot set [chance]=0.1 WHERE [id]=4662
update artifactloot set [chance]=0.1 WHERE [id]=4663
update artifactloot set [chance]=0.1 WHERE [id]=4664
update artifactloot set [chance]=0.1 WHERE [id]=4665
update artifactloot set [chance]=0.1 WHERE [id]=4666
update artifactloot set [chance]=0.1 WHERE [id]=4667
update artifactloot set [chance]=0.1 WHERE [id]=5020
update artifactloot set [chance]=0.1 WHERE [id]=5021
update artifactloot set [chance]=0.1 WHERE [id]=5022
update artifactloot set [chance]=0.1 WHERE [id]=5023
update artifactloot set [chance]=0.1 WHERE [id]=5024
update artifactloot set [chance]=0.1 WHERE [id]=5025
update artifactloot set [chance]=0.1 WHERE [id]=5026
update artifactloot set [chance]=0.1 WHERE [id]=5027
update artifactloot set [chance]=0.1 WHERE [id]=5028
update artifactloot set [chance]=0.1 WHERE [id]=5029
update artifactloot set [chance]=0.1 WHERE [id]=5030
update artifactloot set [chance]=0.1 WHERE [id]=5031
update artifactloot set [chance]=0.1 WHERE [id]=5032
update artifactloot set [chance]=0.1 WHERE [id]=5033
update artifactloot set [chance]=0.1 WHERE [id]=5034
update artifactloot set [chance]=0.1 WHERE [id]=5035
update artifactloot set [chance]=0.1 WHERE [id]=5036
update artifactloot set [chance]=0.03 WHERE [id]=5037
update artifactloot set [chance]=0.03 WHERE [id]=5038
update artifactloot set [chance]=0.03 WHERE [id]=5039
update artifactloot set [chance]=0.03 WHERE [id]=5040
update artifactloot set [chance]=0.03 WHERE [id]=5041
update artifactloot set [chance]=0.03 WHERE [id]=5042
update artifactloot set [chance]=0.03 WHERE [id]=5043
update artifactloot set [chance]=0.03 WHERE [id]=5044
update artifactloot set [chance]=0.03 WHERE [id]=5045
update artifactloot set [chance]=0.03 WHERE [id]=5046
update artifactloot set [chance]=0.03 WHERE [id]=5047
update artifactloot set [chance]=0.03 WHERE [id]=5048
update artifactloot set [chance]=0.03 WHERE [id]=5049
update artifactloot set [chance]=0.03 WHERE [id]=5050
update artifactloot set [chance]=0.03 WHERE [id]=5051
update artifactloot set [chance]=0.03 WHERE [id]=5052
update artifactloot set [chance]=0.03 WHERE [id]=5053
update artifactloot set [chance]=0.03 WHERE [id]=5054
update artifactloot set [chance]=0.03 WHERE [id]=5055
update artifactloot set [chance]=0.03 WHERE [id]=5056
update artifactloot set [chance]=0.03 WHERE [id]=5057
update artifactloot set [chance]=0.03 WHERE [id]=5058
update artifactloot set [chance]=0.03 WHERE [id]=5059
update artifactloot set [chance]=0.03 WHERE [id]=5060
update artifactloot set [chance]=0.03 WHERE [id]=5061
update artifactloot set [chance]=0.03 WHERE [id]=5062
update artifactloot set [chance]=0.03 WHERE [id]=5063
update artifactloot set [chance]=0.03 WHERE [id]=5064
update artifactloot set [chance]=0.03 WHERE [id]=5065
update artifactloot set [chance]=0.03 WHERE [id]=5066
update artifactloot set [chance]=0.03 WHERE [id]=5067
update artifactloot set [chance]=0.03 WHERE [id]=5068
update artifactloot set [chance]=0.03 WHERE [id]=5069
update artifactloot set [chance]=0.03 WHERE [id]=5070
update artifactloot set [chance]=0.1 WHERE [id]=5071
update artifactloot set [chance]=0.1 WHERE [id]=5072
update artifactloot set [chance]=0.1 WHERE [id]=5073
update artifactloot set [chance]=0.1 WHERE [id]=5074
update artifactloot set [chance]=0.1 WHERE [id]=5075
update artifactloot set [chance]=0.1 WHERE [id]=5076
update artifactloot set [chance]=0.1 WHERE [id]=5077
update artifactloot set [chance]=0.1 WHERE [id]=5078
update artifactloot set [chance]=0.1 WHERE [id]=5079
update artifactloot set [chance]=0.1 WHERE [id]=5080
update artifactloot set [chance]=0.1 WHERE [id]=5081
update artifactloot set [chance]=0.1 WHERE [id]=5082
update artifactloot set [chance]=0.1 WHERE [id]=5083
update artifactloot set [chance]=0.1 WHERE [id]=5084
update artifactloot set [chance]=0.1 WHERE [id]=5085
update artifactloot set [chance]=0.1 WHERE [id]=5086
update artifactloot set [chance]=0.1 WHERE [id]=5087
update artifactloot set [chance]=0.05 WHERE [id]=5422
update artifactloot set [chance]=0.05 WHERE [id]=5424
update artifactloot set [chance]=0.05 WHERE [id]=5427
update artifactloot set [chance]=0.025 WHERE [id]=5430
update artifactloot set [chance]=0.025 WHERE [id]=5434
update artifactloot set [chance]=0.05 WHERE [id]=5437
update artifactloot set [chance]=0.025 WHERE [id]=5440
update artifactloot set [chance]=0.05 WHERE [id]=5443
update artifactloot set [chance]=0.025 WHERE [id]=5446
update artifactloot set [chance]=0.025 WHERE [id]=5449
update artifactloot set [chance]=0.025 WHERE [id]=5452
update artifactloot set [chance]=0.2 WHERE [id]=5454
update artifactloot set [chance]=0.2 WHERE [id]=5455
update artifactloot set [chance]=0.2 WHERE [id]=5463
update artifactloot set [chance]=1 WHERE [id]=5466
update artifactloot set [chance]=1 WHERE [id]=5468
update artifactloot set [chance]=0.2 WHERE [id]=5471
update artifactloot set [chance]=0.025 WHERE [id]=5501
update artifactloot set [chance]=0.2 WHERE [id]=5507
update artifactloot set [chance]=0.2 WHERE [id]=5509
update artifactloot set [chance]=0.2 WHERE [id]=5510
update artifactloot set [chance]=0.2 WHERE [id]=5512
update artifactloot set [chance]=0.2 WHERE [id]=5513
update artifactloot set [chance]=0.2 WHERE [id]=5514
update artifactloot set [chance]=0.2 WHERE [id]=5516
update artifactloot set [chance]=0.05 WHERE [id]=5680
update artifactloot set [chance]=0.05 WHERE [id]=5683
update artifactloot set [chance]=0.05 WHERE [id]=5686
update artifactloot set [chance]=0.05 WHERE [id]=5691
update artifactloot set [chance]=0.05 WHERE [id]=5694
update artifactloot set [chance]=0.05 WHERE [id]=5699
update artifactloot set [chance]=0.025 WHERE [id]=5707
update artifactloot set [chance]=0.025 WHERE [id]=5710
update artifactloot set [chance]=0.05 WHERE [id]=5713
update artifactloot set [chance]=0.05 WHERE [id]=5716
update artifactloot set [chance]=0.05 WHERE [id]=5719
update artifactloot set [chance]=0.05 WHERE [id]=5722
update artifactloot set [chance]=0.05 WHERE [id]=5725
update artifactloot set [chance]=0.05 WHERE [id]=5728
update artifactloot set [chance]=0.05 WHERE [id]=5732
update artifactloot set [chance]=0.025 WHERE [id]=5976
update artifactloot set [chance]=0.2 WHERE [id]=8272
update artifactloot set [chance]=1 WHERE [id]=8273
update artifactloot set [chance]=0.1 WHERE [id]=8274
update artifactloot set [chance]=0.1 WHERE [id]=8275
update artifactloot set [chance]=0.1 WHERE [id]=8276
update artifactloot set [chance]=0.1 WHERE [id]=8277
update artifactloot set [chance]=0.1 WHERE [id]=8278
update artifactloot set [chance]=0.1 WHERE [id]=8279
update artifactloot set [chance]=0.1 WHERE [id]=8280
update artifactloot set [chance]=0.1 WHERE [id]=8281
update artifactloot set [chance]=0.1 WHERE [id]=8282
update artifactloot set [chance]=0.1 WHERE [id]=8283
update artifactloot set [chance]=0.1 WHERE [id]=8284
update artifactloot set [chance]=0.1 WHERE [id]=8285
update artifactloot set [chance]=0.1 WHERE [id]=8286
update artifactloot set [chance]=0.1 WHERE [id]=8287
update artifactloot set [chance]=0.1 WHERE [id]=8288
update artifactloot set [chance]=0.1 WHERE [id]=8289
update artifactloot set [chance]=0.1 WHERE [id]=8290
update artifactloot set [chance]=0.1 WHERE [id]=8291
update artifactloot set [chance]=0.03 WHERE [id]=8292
update artifactloot set [chance]=0.03 WHERE [id]=8293
update artifactloot set [chance]=0.03 WHERE [id]=8294
update artifactloot set [chance]=0.03 WHERE [id]=8295
update artifactloot set [chance]=0.03 WHERE [id]=8296
update artifactloot set [chance]=0.03 WHERE [id]=8297
update artifactloot set [chance]=0.03 WHERE [id]=8298
update artifactloot set [chance]=0.03 WHERE [id]=8299
update artifactloot set [chance]=0.03 WHERE [id]=8300
update artifactloot set [chance]=0.03 WHERE [id]=8301
update artifactloot set [chance]=0.03 WHERE [id]=8302
update artifactloot set [chance]=0.03 WHERE [id]=8303
update artifactloot set [chance]=0.03 WHERE [id]=8304
update artifactloot set [chance]=0.03 WHERE [id]=8305
update artifactloot set [chance]=0.03 WHERE [id]=8306
update artifactloot set [chance]=0.03 WHERE [id]=8307
update artifactloot set [chance]=0.03 WHERE [id]=8308
update artifactloot set [chance]=0.03 WHERE [id]=8309
update artifactloot set [chance]=0.2 WHERE [id]=8311
update artifactloot set [chance]=0.05 WHERE [id]=8325
update artifactloot set [chance]=0.025 WHERE [id]=8326
update artifactloot set [chance]=1 WHERE [id]=8329
update artifactloot set [chance]=0.05 WHERE [id]=8330
update artifactloot set [chance]=0.05 WHERE [id]=8331
update artifactloot set [chance]=0.01 WHERE [id]=8332
update artifactloot set [chance]=0.05 WHERE [id]=8333
update artifactloot set [chance]=0.05 WHERE [id]=8334
update artifactloot set [chance]=0.05 WHERE [id]=8335
update artifactloot set [chance]=0.05 WHERE [id]=8336
update artifactloot set [chance]=0.01 WHERE [id]=8337
update artifactloot set [chance]=0.01 WHERE [id]=8338
update artifactloot set [chance]=0.05 WHERE [id]=8339
update artifactloot set [chance]=0.05 WHERE [id]=8340
update artifactloot set [chance]=0.01 WHERE [id]=8341
update artifactloot set [chance]=0.05 WHERE [id]=8342
update artifactloot set [chance]=0.05 WHERE [id]=8343
update artifactloot set [chance]=0.01 WHERE [id]=8344
update artifactloot set [chance]=0.05 WHERE [id]=8345
update artifactloot set [chance]=0.05 WHERE [id]=8346
update artifactloot set [chance]=0.05 WHERE [id]=8347
update artifactloot set [chance]=0.05 WHERE [id]=8348
update artifactloot set [chance]=0.01 WHERE [id]=8349
update artifactloot set [chance]=0.01 WHERE [id]=8350
update artifactloot set [chance]=0.05 WHERE [id]=8351
update artifactloot set [chance]=0.05 WHERE [id]=8352
update artifactloot set [chance]=0.01 WHERE [id]=8353
update artifactloot set [chance]=0.05 WHERE [id]=8354
update artifactloot set [chance]=0.05 WHERE [id]=8355
update artifactloot set [chance]=0.01 WHERE [id]=8356
update artifactloot set [chance]=0.05 WHERE [id]=8357
update artifactloot set [chance]=0.05 WHERE [id]=8358
update artifactloot set [chance]=0.05 WHERE [id]=8359
update artifactloot set [chance]=0.05 WHERE [id]=8360
update artifactloot set [chance]=0.01 WHERE [id]=8361
update artifactloot set [chance]=0.01 WHERE [id]=8362
update artifactloot set [chance]=0.05 WHERE [id]=8363
update artifactloot set [chance]=0.05 WHERE [id]=8364
update artifactloot set [chance]=0.01 WHERE [id]=8365
update artifactloot set [chance]=0.05 WHERE [id]=8366
update artifactloot set [chance]=0.05 WHERE [id]=8367
update artifactloot set [chance]=0.01 WHERE [id]=8368
update artifactloot set [chance]=0.05 WHERE [id]=8369
update artifactloot set [chance]=0.05 WHERE [id]=8370
update artifactloot set [chance]=0.01 WHERE [id]=8371
update artifactloot set [chance]=0.05 WHERE [id]=8372
update artifactloot set [chance]=0.05 WHERE [id]=8373
update artifactloot set [chance]=0.01 WHERE [id]=8374
update artifactloot set [chance]=0.05 WHERE [id]=8375
update artifactloot set [chance]=0.05 WHERE [id]=8376
update artifactloot set [chance]=0.01 WHERE [id]=8377
update artifactloot set [chance]=0.05 WHERE [id]=8378
update artifactloot set [chance]=0.05 WHERE [id]=8379
update artifactloot set [chance]=0.01 WHERE [id]=8380
update artifactloot set [chance]=0.05 WHERE [id]=8381
update artifactloot set [chance]=0.05 WHERE [id]=8382
update artifactloot set [chance]=0.01 WHERE [id]=8383
update artifactloot set [chance]=0.2 WHERE [id]=8384
update artifactloot set [chance]=0.025 WHERE [id]=8397
update artifactloot set [chance]=0.2 WHERE [id]=8400
update artifactloot set [chance]=0.05 WHERE [id]=8415
update artifactloot set [chance]=0.05 WHERE [id]=8416
update artifactloot set [chance]=0.2 WHERE [id]=8420
update artifactloot set [chance]=1 WHERE [id]=8421
update artifactloot set [chance]=0.03 WHERE [id]=8422
update artifactloot set [chance]=0.03 WHERE [id]=8423
update artifactloot set [chance]=0.03 WHERE [id]=8424
update artifactloot set [chance]=0.03 WHERE [id]=8425
update artifactloot set [chance]=0.03 WHERE [id]=8426
update artifactloot set [chance]=0.03 WHERE [id]=8427
update artifactloot set [chance]=0.03 WHERE [id]=8428
update artifactloot set [chance]=0.03 WHERE [id]=8429
update artifactloot set [chance]=0.03 WHERE [id]=8430
update artifactloot set [chance]=0.03 WHERE [id]=8431
update artifactloot set [chance]=0.03 WHERE [id]=8432
update artifactloot set [chance]=0.03 WHERE [id]=8433
update artifactloot set [chance]=0.03 WHERE [id]=8434
update artifactloot set [chance]=0.03 WHERE [id]=8435
update artifactloot set [chance]=0.03 WHERE [id]=8436
update artifactloot set [chance]=0.03 WHERE [id]=8437
update artifactloot set [chance]=0.03 WHERE [id]=8438
update artifactloot set [chance]=0.03 WHERE [id]=8439
update artifactloot set [chance]=0.03 WHERE [id]=8440
update artifactloot set [chance]=0.03 WHERE [id]=8441
update artifactloot set [chance]=0.03 WHERE [id]=8442
update artifactloot set [chance]=0.03 WHERE [id]=8443
update artifactloot set [chance]=0.03 WHERE [id]=8444
update artifactloot set [chance]=0.03 WHERE [id]=8445
update artifactloot set [chance]=0.03 WHERE [id]=8446
update artifactloot set [chance]=0.03 WHERE [id]=8447
update artifactloot set [chance]=0.03 WHERE [id]=8448
update artifactloot set [chance]=0.03 WHERE [id]=8449
update artifactloot set [chance]=0.03 WHERE [id]=8450
update artifactloot set [chance]=0.03 WHERE [id]=8451
update artifactloot set [chance]=0.1 WHERE [id]=8452
update artifactloot set [chance]=0.1 WHERE [id]=8453
update artifactloot set [chance]=0.1 WHERE [id]=8454
update artifactloot set [chance]=0.1 WHERE [id]=8455
update artifactloot set [chance]=0.1 WHERE [id]=8456
update artifactloot set [chance]=0.1 WHERE [id]=8457
update artifactloot set [chance]=0.1 WHERE [id]=8458
update artifactloot set [chance]=0.1 WHERE [id]=8459
update artifactloot set [chance]=0.1 WHERE [id]=8460
update artifactloot set [chance]=0.1 WHERE [id]=8461
update artifactloot set [chance]=0.1 WHERE [id]=8462
update artifactloot set [chance]=0.1 WHERE [id]=8463
update artifactloot set [chance]=0.1 WHERE [id]=8464
update artifactloot set [chance]=0.1 WHERE [id]=8465
update artifactloot set [chance]=0.1 WHERE [id]=8466
update artifactloot set [chance]=0.1 WHERE [id]=8467
update artifactloot set [chance]=0.1 WHERE [id]=8468
update artifactloot set [chance]=0.1 WHERE [id]=8469
update artifactloot set [chance]=0.1 WHERE [id]=8470
update artifactloot set [chance]=0.1 WHERE [id]=8471
update artifactloot set [chance]=0.1 WHERE [id]=8472
update artifactloot set [chance]=0.1 WHERE [id]=8473
update artifactloot set [chance]=0.1 WHERE [id]=8474
update artifactloot set [chance]=0.1 WHERE [id]=8475
update artifactloot set [chance]=0.1 WHERE [id]=8476
update artifactloot set [chance]=0.1 WHERE [id]=8477
update artifactloot set [chance]=0.1 WHERE [id]=8478
update artifactloot set [chance]=0.1 WHERE [id]=8479
update artifactloot set [chance]=0.1 WHERE [id]=8480
update artifactloot set [chance]=0.1 WHERE [id]=8481
update artifactloot set [chance]=0.025 WHERE [id]=8492
update artifactloot set [chance]=0.2 WHERE [id]=8493
update artifactloot set [chance]=0.05 WHERE [id]=8498
update artifactloot set [chance]=0.05 WHERE [id]=8499
update artifactloot set [chance]=0.05 WHERE [id]=8500
update artifactloot set [chance]=0.1 WHERE [id]=8517
update artifactloot set [chance]=0.1 WHERE [id]=8518
update artifactloot set [chance]=0.1 WHERE [id]=8519
update artifactloot set [chance]=0.1 WHERE [id]=8520
update artifactloot set [chance]=0.1 WHERE [id]=8521
update artifactloot set [chance]=0.1 WHERE [id]=8522
update artifactloot set [chance]=0.1 WHERE [id]=8523
update artifactloot set [chance]=0.1 WHERE [id]=8524
update artifactloot set [chance]=0.1 WHERE [id]=8525
update artifactloot set [chance]=0.1 WHERE [id]=8526
update artifactloot set [chance]=0.1 WHERE [id]=8527
update artifactloot set [chance]=0.1 WHERE [id]=8528
update artifactloot set [chance]=0.1 WHERE [id]=8529
update artifactloot set [chance]=0.1 WHERE [id]=8530
update artifactloot set [chance]=0.1 WHERE [id]=8531
update artifactloot set [chance]=0.1 WHERE [id]=8532
update artifactloot set [chance]=0.1 WHERE [id]=8533
update artifactloot set [chance]=0.1 WHERE [id]=8534
update artifactloot set [chance]=0.03 WHERE [id]=8535
update artifactloot set [chance]=0.03 WHERE [id]=8536
update artifactloot set [chance]=0.03 WHERE [id]=8537
update artifactloot set [chance]=0.03 WHERE [id]=8538
update artifactloot set [chance]=0.03 WHERE [id]=8539
update artifactloot set [chance]=0.03 WHERE [id]=8540
update artifactloot set [chance]=0.03 WHERE [id]=8541
update artifactloot set [chance]=0.03 WHERE [id]=8542
update artifactloot set [chance]=0.03 WHERE [id]=8543
update artifactloot set [chance]=0.03 WHERE [id]=8544
update artifactloot set [chance]=0.03 WHERE [id]=8545
update artifactloot set [chance]=0.03 WHERE [id]=8546
update artifactloot set [chance]=0.03 WHERE [id]=8547
update artifactloot set [chance]=0.03 WHERE [id]=8548
update artifactloot set [chance]=0.03 WHERE [id]=8549
update artifactloot set [chance]=0.03 WHERE [id]=8550
update artifactloot set [chance]=0.03 WHERE [id]=8551
update artifactloot set [chance]=0.03 WHERE [id]=8552
update artifactloot set [chance]=0.025 WHERE [id]=8553
update artifactloot set [chance]=0.2 WHERE [id]=8554
update artifactloot set [chance]=1 WHERE [id]=8555
update artifactloot set [chance]=0.2 WHERE [id]=8556
update artifactloot set [chance]=0.05 WHERE [id]=8557
update artifactloot set [chance]=0.05 WHERE [id]=8560
update artifactloot set [chance]=0.05 WHERE [id]=8561
update artifactloot set [chance]=0.01 WHERE [id]=8562
update artifactloot set [chance]=0.05 WHERE [id]=8563
update artifactloot set [chance]=0.05 WHERE [id]=8564
update artifactloot set [chance]=0.05 WHERE [id]=8565
update artifactloot set [chance]=0.05 WHERE [id]=8566
update artifactloot set [chance]=0.01 WHERE [id]=8567
update artifactloot set [chance]=0.01 WHERE [id]=8568
update artifactloot set [chance]=0.05 WHERE [id]=8569
update artifactloot set [chance]=0.05 WHERE [id]=8570
update artifactloot set [chance]=0.01 WHERE [id]=8571
update artifactloot set [chance]=0.05 WHERE [id]=8572
update artifactloot set [chance]=0.05 WHERE [id]=8573
update artifactloot set [chance]=0.01 WHERE [id]=8574
update artifactloot set [chance]=0.05 WHERE [id]=8575
update artifactloot set [chance]=0.05 WHERE [id]=8576
update artifactloot set [chance]=0.05 WHERE [id]=8577
update artifactloot set [chance]=0.05 WHERE [id]=8578
update artifactloot set [chance]=0.01 WHERE [id]=8579
update artifactloot set [chance]=0.01 WHERE [id]=8580
update artifactloot set [chance]=0.05 WHERE [id]=8581
update artifactloot set [chance]=0.05 WHERE [id]=8582
update artifactloot set [chance]=0.01 WHERE [id]=8583
update artifactloot set [chance]=0.05 WHERE [id]=8584
update artifactloot set [chance]=0.05 WHERE [id]=8585
update artifactloot set [chance]=0.01 WHERE [id]=8586
update artifactloot set [chance]=0.05 WHERE [id]=8587
update artifactloot set [chance]=0.05 WHERE [id]=8588
update artifactloot set [chance]=0.05 WHERE [id]=8589
update artifactloot set [chance]=0.05 WHERE [id]=8590
update artifactloot set [chance]=0.01 WHERE [id]=8591
update artifactloot set [chance]=0.01 WHERE [id]=8592
update artifactloot set [chance]=0.05 WHERE [id]=8593
update artifactloot set [chance]=0.05 WHERE [id]=8594
update artifactloot set [chance]=0.01 WHERE [id]=8595
update artifactloot set [chance]=0.05 WHERE [id]=8596
update artifactloot set [chance]=0.05 WHERE [id]=8597
update artifactloot set [chance]=0.01 WHERE [id]=8598
update artifactloot set [chance]=0.05 WHERE [id]=8599
update artifactloot set [chance]=0.05 WHERE [id]=8600
update artifactloot set [chance]=0.01 WHERE [id]=8601
update artifactloot set [chance]=0.05 WHERE [id]=8602
update artifactloot set [chance]=0.05 WHERE [id]=8603
update artifactloot set [chance]=0.01 WHERE [id]=8604
update artifactloot set [chance]=0.05 WHERE [id]=8605
update artifactloot set [chance]=0.05 WHERE [id]=8606
update artifactloot set [chance]=0.01 WHERE [id]=8607
update artifactloot set [chance]=0.05 WHERE [id]=8608
update artifactloot set [chance]=0.05 WHERE [id]=8609
update artifactloot set [chance]=0.01 WHERE [id]=8610
update artifactloot set [chance]=0.05 WHERE [id]=8611
update artifactloot set [chance]=0.05 WHERE [id]=8612
update artifactloot set [chance]=0.01 WHERE [id]=8613
update artifactloot set [chance]=0.025 WHERE [id]=8642
update artifactloot set [chance]=0.2 WHERE [id]=8643
update artifactloot set [chance]=1 WHERE [id]=8644
update artifactloot set [chance]=0.2 WHERE [id]=8645
update artifactloot set [chance]=0.05 WHERE [id]=8646
update artifactloot set [chance]=0.05 WHERE [id]=8647
update artifactloot set [chance]=1 WHERE [id]=8652
update artifactloot set [chance]=0.03 WHERE [id]=8664
update artifactloot set [chance]=0.03 WHERE [id]=8665
update artifactloot set [chance]=0.03 WHERE [id]=8666
update artifactloot set [chance]=0.03 WHERE [id]=8667
update artifactloot set [chance]=0.03 WHERE [id]=8668
update artifactloot set [chance]=0.03 WHERE [id]=8669
update artifactloot set [chance]=0.03 WHERE [id]=8670
update artifactloot set [chance]=0.03 WHERE [id]=8671
update artifactloot set [chance]=0.03 WHERE [id]=8672
update artifactloot set [chance]=0.03 WHERE [id]=8673
update artifactloot set [chance]=0.03 WHERE [id]=8674
update artifactloot set [chance]=0.03 WHERE [id]=8675
update artifactloot set [chance]=0.03 WHERE [id]=8676
update artifactloot set [chance]=0.03 WHERE [id]=8677
update artifactloot set [chance]=0.03 WHERE [id]=8678
update artifactloot set [chance]=0.03 WHERE [id]=8679
update artifactloot set [chance]=0.03 WHERE [id]=8680
update artifactloot set [chance]=0.03 WHERE [id]=8681
update artifactloot set [chance]=0.1 WHERE [id]=8682
update artifactloot set [chance]=0.1 WHERE [id]=8683
update artifactloot set [chance]=0.1 WHERE [id]=8684
update artifactloot set [chance]=0.2 WHERE [id]=8688
update artifactloot set [chance]=0.1 WHERE [id]=8689
update artifactloot set [chance]=0.1 WHERE [id]=8690
update artifactloot set [chance]=0.1 WHERE [id]=8691
update artifactloot set [chance]=0.1 WHERE [id]=8692
update artifactloot set [chance]=0.1 WHERE [id]=8693
update artifactloot set [chance]=0.1 WHERE [id]=8694
update artifactloot set [chance]=0.1 WHERE [id]=8695
update artifactloot set [chance]=0.1 WHERE [id]=8696
update artifactloot set [chance]=0.1 WHERE [id]=8697
update artifactloot set [chance]=0.1 WHERE [id]=8698
update artifactloot set [chance]=0.1 WHERE [id]=8699
update artifactloot set [chance]=0.1 WHERE [id]=8700
update artifactloot set [chance]=0.1 WHERE [id]=8701
update artifactloot set [chance]=0.1 WHERE [id]=8702
update artifactloot set [chance]=0.1 WHERE [id]=8703
update artifactloot set [chance]=0.05 WHERE [id]=8704
update artifactloot set [chance]=0.025 WHERE [id]=8705
update artifactloot set [chance]=0.2 WHERE [id]=8706
update artifactloot set [chance]=0.05 WHERE [id]=8707
update artifactloot set [chance]=0.05 WHERE [id]=8708
update artifactloot set [chance]=1 WHERE [id]=8711
update artifactloot set [chance]=0.2 WHERE [id]=8712
update artifactloot set [chance]=0.1 WHERE [id]=8713
update artifactloot set [chance]=0.1 WHERE [id]=8714
update artifactloot set [chance]=0.1 WHERE [id]=8715
update artifactloot set [chance]=0.1 WHERE [id]=8716
update artifactloot set [chance]=0.1 WHERE [id]=8717
update artifactloot set [chance]=0.1 WHERE [id]=8718
update artifactloot set [chance]=0.1 WHERE [id]=8719
update artifactloot set [chance]=0.1 WHERE [id]=8720
update artifactloot set [chance]=0.1 WHERE [id]=8721
update artifactloot set [chance]=0.1 WHERE [id]=8722
update artifactloot set [chance]=0.1 WHERE [id]=8723
update artifactloot set [chance]=0.1 WHERE [id]=8724
update artifactloot set [chance]=0.1 WHERE [id]=8725
update artifactloot set [chance]=0.1 WHERE [id]=8726
update artifactloot set [chance]=0.1 WHERE [id]=8727
update artifactloot set [chance]=0.1 WHERE [id]=8728
update artifactloot set [chance]=0.1 WHERE [id]=8729
update artifactloot set [chance]=0.03 WHERE [id]=8730
update artifactloot set [chance]=0.03 WHERE [id]=8731
update artifactloot set [chance]=0.03 WHERE [id]=8732
update artifactloot set [chance]=0.03 WHERE [id]=8733
update artifactloot set [chance]=0.03 WHERE [id]=8734
update artifactloot set [chance]=0.03 WHERE [id]=8735
update artifactloot set [chance]=0.03 WHERE [id]=8736
update artifactloot set [chance]=0.03 WHERE [id]=8737
update artifactloot set [chance]=0.03 WHERE [id]=8738
update artifactloot set [chance]=0.03 WHERE [id]=8739
update artifactloot set [chance]=0.03 WHERE [id]=8740
update artifactloot set [chance]=0.03 WHERE [id]=8741
update artifactloot set [chance]=0.03 WHERE [id]=8742
update artifactloot set [chance]=0.03 WHERE [id]=8743
update artifactloot set [chance]=0.03 WHERE [id]=8744
update artifactloot set [chance]=0.03 WHERE [id]=8745
update artifactloot set [chance]=0.03 WHERE [id]=8746
update artifactloot set [chance]=0.05 WHERE [id]=8758
update artifactloot set [chance]=0.2 WHERE [id]=8762
update artifactloot set [chance]=0.025 WHERE [id]=8763
update artifactloot set [chance]=0.05 WHERE [id]=8766
update artifactloot set [chance]=0.05 WHERE [id]=8767
update artifactloot set [chance]=0.01 WHERE [id]=8768
update artifactloot set [chance]=0.2 WHERE [id]=8769
update artifactloot set [chance]=1 WHERE [id]=8770
update artifactloot set [chance]=0.05 WHERE [id]=8771
update artifactloot set [chance]=0.05 WHERE [id]=8772
update artifactloot set [chance]=0.01 WHERE [id]=8773
update artifactloot set [chance]=0.05 WHERE [id]=8774
update artifactloot set [chance]=0.05 WHERE [id]=8775
update artifactloot set [chance]=0.05 WHERE [id]=8776
update artifactloot set [chance]=0.05 WHERE [id]=8777
update artifactloot set [chance]=0.01 WHERE [id]=8778
update artifactloot set [chance]=0.01 WHERE [id]=8779
update artifactloot set [chance]=0.05 WHERE [id]=8780
update artifactloot set [chance]=0.05 WHERE [id]=8781
update artifactloot set [chance]=0.01 WHERE [id]=8782
update artifactloot set [chance]=0.05 WHERE [id]=8783
update artifactloot set [chance]=0.05 WHERE [id]=8784
update artifactloot set [chance]=0.01 WHERE [id]=8785
update artifactloot set [chance]=0.05 WHERE [id]=8786
update artifactloot set [chance]=0.05 WHERE [id]=8787
update artifactloot set [chance]=0.05 WHERE [id]=8788
update artifactloot set [chance]=0.05 WHERE [id]=8789
update artifactloot set [chance]=0.01 WHERE [id]=8790
update artifactloot set [chance]=0.01 WHERE [id]=8791
update artifactloot set [chance]=0.05 WHERE [id]=8792
update artifactloot set [chance]=0.05 WHERE [id]=8793
update artifactloot set [chance]=0.01 WHERE [id]=8794
update artifactloot set [chance]=0.05 WHERE [id]=8795
update artifactloot set [chance]=0.05 WHERE [id]=8796
update artifactloot set [chance]=0.01 WHERE [id]=8797
update artifactloot set [chance]=0.05 WHERE [id]=8798
update artifactloot set [chance]=0.05 WHERE [id]=8799
update artifactloot set [chance]=0.01 WHERE [id]=8800
update artifactloot set [chance]=0.05 WHERE [id]=8801
update artifactloot set [chance]=0.05 WHERE [id]=8802
update artifactloot set [chance]=0.01 WHERE [id]=8803
update artifactloot set [chance]=0.05 WHERE [id]=8804
update artifactloot set [chance]=0.05 WHERE [id]=8805
update artifactloot set [chance]=0.01 WHERE [id]=8806
update artifactloot set [chance]=0.05 WHERE [id]=8807
update artifactloot set [chance]=0.05 WHERE [id]=8808
update artifactloot set [chance]=0.01 WHERE [id]=8809
update artifactloot set [chance]=0.05 WHERE [id]=8810
update artifactloot set [chance]=0.05 WHERE [id]=8811
update artifactloot set [chance]=0.01 WHERE [id]=8812
update artifactloot set [chance]=0.05 WHERE [id]=8813
update artifactloot set [chance]=0.05 WHERE [id]=8814
update artifactloot set [chance]=0.01 WHERE [id]=8815
update artifactloot set [chance]=0.05 WHERE [id]=8816
update artifactloot set [chance]=0.05 WHERE [id]=8817
update artifactloot set [chance]=0.01 WHERE [id]=8818
update artifactloot set [chance]=0.05 WHERE [id]=8831
update artifactloot set [chance]=0.025 WHERE [id]=8839
update artifactloot set [chance]=0.2 WHERE [id]=8840
update artifactloot set [chance]=0.05 WHERE [id]=8850
update artifactloot set [chance]=1 WHERE [id]=8854
update artifactloot set [chance]=0.2 WHERE [id]=8855
update artifactloot set [chance]=0.03 WHERE [id]=8856
update artifactloot set [chance]=0.03 WHERE [id]=8857
update artifactloot set [chance]=0.03 WHERE [id]=8858
update artifactloot set [chance]=0.03 WHERE [id]=8859
update artifactloot set [chance]=0.03 WHERE [id]=8860
update artifactloot set [chance]=0.03 WHERE [id]=8861
update artifactloot set [chance]=0.03 WHERE [id]=8862
update artifactloot set [chance]=0.03 WHERE [id]=8863
update artifactloot set [chance]=0.03 WHERE [id]=8864
update artifactloot set [chance]=0.03 WHERE [id]=8865
update artifactloot set [chance]=0.03 WHERE [id]=8866
update artifactloot set [chance]=0.03 WHERE [id]=8867
update artifactloot set [chance]=0.03 WHERE [id]=8868
update artifactloot set [chance]=0.03 WHERE [id]=8869
update artifactloot set [chance]=0.03 WHERE [id]=8870
update artifactloot set [chance]=0.03 WHERE [id]=8871
update artifactloot set [chance]=0.03 WHERE [id]=8872
update artifactloot set [chance]=0.1 WHERE [id]=8873
update artifactloot set [chance]=0.1 WHERE [id]=8874
update artifactloot set [chance]=0.1 WHERE [id]=8875
update artifactloot set [chance]=0.1 WHERE [id]=8876
update artifactloot set [chance]=0.1 WHERE [id]=8877
update artifactloot set [chance]=0.1 WHERE [id]=8878
update artifactloot set [chance]=0.1 WHERE [id]=8879
update artifactloot set [chance]=0.1 WHERE [id]=8880
update artifactloot set [chance]=0.1 WHERE [id]=8881
update artifactloot set [chance]=0.1 WHERE [id]=8882
update artifactloot set [chance]=0.1 WHERE [id]=8883
update artifactloot set [chance]=0.1 WHERE [id]=8884
update artifactloot set [chance]=0.1 WHERE [id]=8885
update artifactloot set [chance]=0.1 WHERE [id]=8886
update artifactloot set [chance]=0.1 WHERE [id]=8887
update artifactloot set [chance]=0.1 WHERE [id]=8888
update artifactloot set [chance]=0.1 WHERE [id]=8889
update artifactloot set [chance]=0.05 WHERE [id]=8900
update artifactloot set [chance]=0.05 WHERE [id]=8901
update artifactloot set [chance]=0.025 WHERE [id]=8902
update artifactloot set [chance]=0.2 WHERE [id]=8905
update artifactloot set [chance]=0.05 WHERE [id]=8908


GO


--02--
PRINT N'RUNNING UPDATES ON ARTIFACT SPAWN INFO to balance alpha';

USE [perpetuumsa]
GO

-----------------------ARTIFACT ALPHA-ZONE BALANCE----------------------
--The alpha zones still have significant pelistal bias in artifactspawninfos
--This flattens the racial biases for Hershfield and New Virginia
--Also fixes other rate/spawn info idiosyncrasies, missing entries, or rates that appear anomalous
--
--This script: A) Inserts one missing artifact type to hershfield (that was found on NV)
--B) Updates the rates of the artifacts from the balance document on the gdrive (changes bolded and highlighted in red)
--Document at OpenPerpetuum-TeamFolders/Economy/Artifacts sheet="ArtifactSpawnInfo - AlphaBalance"
--
--Updates below were generated with:
--SELECT CONCAT('UPDATE artifactspawninfo SET rate=',spawnrate, ' WHERE zoneid=(SELECT TOP 1 id FROM zones WHERE note=''',zonenote,''') AND artifacttype=(SELECT TOP 1 id FROM artifacttypes WHERE artifacttypes.name=''',artifacttypename,''');')
--FROM #TEMP_ARTI_SPAWN_INFO
----------------------Revision 2018/12/11---------------------

DECLARE @insert_check bit;
SET @insert_check = 
	CASE 
		WHEN exists (SELECT 1 FROM [artifactspawninfo] WHERE zoneid=(SELECT TOP 1 id FROM zones WHERE note='hershfield') AND artifacttype=(SELECT TOP 1 id FROM artifacttypes WHERE artifacttypes.name='industrial_nuimqol_level2_alpha'))
		THEN 1
		ELSE 0
	END;

IF @insert_check=0
--INSERT missing artifact type to hersh
	INSERT INTO [dbo].[artifactspawninfo]
			   ([artifacttype]
			   ,[zoneid]
			   ,[rate])
		 VALUES
			   ((SELECT TOP 1 id FROM artifacttypes WHERE NAME='industrial_nuimqol_level2_alpha'),
			   (SELECT TOP 1 ID FROM zones WHERE note='hershfield'),
			   4);
ELSE
	PRINT N'INSERT ALREADY RUN! - be careful hotshot';

IF @insert_check=0
	PRINT N'Insert complete, (hopefully without issue)';

GO

--Run updates generated by :
--SELECT CONCAT('UPDATE artifactspawninfo SET rate=',spawnrate, ' WHERE zoneid=(SELECT TOP 1 id FROM zones WHERE note=''',zonenote,''') AND artifacttype=(SELECT TOP 1 id FROM artifacttypes WHERE artifacttypes.name=''',artifacttypename,''');')
--FROM #TEMP_ARTI_SPAWN_INFO
--#TEMP_ARTI_SPAWN_INFO is data from the OpenPerpetuum-TeamFolders/Economy/Artifacts sheet="ArtifactSpawnInfo - AlphaBalance" googlesheet
UPDATE artifactspawninfo SET rate=8 WHERE zoneid=(SELECT TOP 1 id FROM zones WHERE note='new virginia') AND artifacttype=(SELECT TOP 1 id FROM artifacttypes WHERE artifacttypes.name='industrial_nuimqol_level1_alpha');
UPDATE artifactspawninfo SET rate=4 WHERE zoneid=(SELECT TOP 1 id FROM zones WHERE note='new virginia') AND artifacttype=(SELECT TOP 1 id FROM artifacttypes WHERE artifacttypes.name='industrial_nuimqol_level2_alpha');
UPDATE artifactspawninfo SET rate=2 WHERE zoneid=(SELECT TOP 1 id FROM zones WHERE note='new virginia') AND artifacttype=(SELECT TOP 1 id FROM artifacttypes WHERE artifacttypes.name='industrial_nuimqol_level3_alpha');
UPDATE artifactspawninfo SET rate=8 WHERE zoneid=(SELECT TOP 1 id FROM zones WHERE note='new virginia') AND artifacttype=(SELECT TOP 1 id FROM artifacttypes WHERE artifacttypes.name='industrial_pelistal_level1_alpha');
UPDATE artifactspawninfo SET rate=4 WHERE zoneid=(SELECT TOP 1 id FROM zones WHERE note='new virginia') AND artifacttype=(SELECT TOP 1 id FROM artifacttypes WHERE artifacttypes.name='industrial_pelistal_level2_alpha');
UPDATE artifactspawninfo SET rate=2 WHERE zoneid=(SELECT TOP 1 id FROM zones WHERE note='new virginia') AND artifacttype=(SELECT TOP 1 id FROM artifacttypes WHERE artifacttypes.name='industrial_pelistal_level3_alpha');
UPDATE artifactspawninfo SET rate=8 WHERE zoneid=(SELECT TOP 1 id FROM zones WHERE note='new virginia') AND artifacttype=(SELECT TOP 1 id FROM artifacttypes WHERE artifacttypes.name='industrial_thelodica_level1_alpha');
UPDATE artifactspawninfo SET rate=4 WHERE zoneid=(SELECT TOP 1 id FROM zones WHERE note='new virginia') AND artifacttype=(SELECT TOP 1 id FROM artifacttypes WHERE artifacttypes.name='industrial_thelodica_level2_alpha');
UPDATE artifactspawninfo SET rate=2 WHERE zoneid=(SELECT TOP 1 id FROM zones WHERE note='new virginia') AND artifacttype=(SELECT TOP 1 id FROM artifacttypes WHERE artifacttypes.name='industrial_thelodica_level3_alpha');
UPDATE artifactspawninfo SET rate=12 WHERE zoneid=(SELECT TOP 1 id FROM zones WHERE note='new virginia') AND artifacttype=(SELECT TOP 1 id FROM artifacttypes WHERE artifacttypes.name='infestation_nuimqol_level1_alpha');
UPDATE artifactspawninfo SET rate=6 WHERE zoneid=(SELECT TOP 1 id FROM zones WHERE note='new virginia') AND artifacttype=(SELECT TOP 1 id FROM artifacttypes WHERE artifacttypes.name='infestation_nuimqol_level2_alpha');
UPDATE artifactspawninfo SET rate=3 WHERE zoneid=(SELECT TOP 1 id FROM zones WHERE note='new virginia') AND artifacttype=(SELECT TOP 1 id FROM artifacttypes WHERE artifacttypes.name='infestation_nuimqol_level3_alpha');
UPDATE artifactspawninfo SET rate=12 WHERE zoneid=(SELECT TOP 1 id FROM zones WHERE note='new virginia') AND artifacttype=(SELECT TOP 1 id FROM artifacttypes WHERE artifacttypes.name='infestation_pelistal_level1_alpha');
UPDATE artifactspawninfo SET rate=6 WHERE zoneid=(SELECT TOP 1 id FROM zones WHERE note='new virginia') AND artifacttype=(SELECT TOP 1 id FROM artifacttypes WHERE artifacttypes.name='infestation_pelistal_level2_alpha');
UPDATE artifactspawninfo SET rate=3 WHERE zoneid=(SELECT TOP 1 id FROM zones WHERE note='new virginia') AND artifacttype=(SELECT TOP 1 id FROM artifacttypes WHERE artifacttypes.name='infestation_pelistal_level3_alpha');
UPDATE artifactspawninfo SET rate=12 WHERE zoneid=(SELECT TOP 1 id FROM zones WHERE note='new virginia') AND artifacttype=(SELECT TOP 1 id FROM artifacttypes WHERE artifacttypes.name='infestation_thelodica_level1_alpha');
UPDATE artifactspawninfo SET rate=6 WHERE zoneid=(SELECT TOP 1 id FROM zones WHERE note='new virginia') AND artifacttype=(SELECT TOP 1 id FROM artifacttypes WHERE artifacttypes.name='infestation_thelodica_level2_alpha');
UPDATE artifactspawninfo SET rate=3 WHERE zoneid=(SELECT TOP 1 id FROM zones WHERE note='new virginia') AND artifacttype=(SELECT TOP 1 id FROM artifacttypes WHERE artifacttypes.name='infestation_thelodica_level3_alpha');
UPDATE artifactspawninfo SET rate=2 WHERE zoneid=(SELECT TOP 1 id FROM zones WHERE note='new virginia') AND artifacttype=(SELECT TOP 1 id FROM artifacttypes WHERE artifacttypes.name='observer_nuimqol_level1_alpha');
UPDATE artifactspawninfo SET rate=1 WHERE zoneid=(SELECT TOP 1 id FROM zones WHERE note='new virginia') AND artifacttype=(SELECT TOP 1 id FROM artifacttypes WHERE artifacttypes.name='observer_nuimqol_level2_alpha');
UPDATE artifactspawninfo SET rate=0.5 WHERE zoneid=(SELECT TOP 1 id FROM zones WHERE note='new virginia') AND artifacttype=(SELECT TOP 1 id FROM artifacttypes WHERE artifacttypes.name='observer_nuimqol_level3_alpha');
UPDATE artifactspawninfo SET rate=2 WHERE zoneid=(SELECT TOP 1 id FROM zones WHERE note='new virginia') AND artifacttype=(SELECT TOP 1 id FROM artifacttypes WHERE artifacttypes.name='observer_pelistal_level1_alpha');
UPDATE artifactspawninfo SET rate=1 WHERE zoneid=(SELECT TOP 1 id FROM zones WHERE note='new virginia') AND artifacttype=(SELECT TOP 1 id FROM artifacttypes WHERE artifacttypes.name='observer_pelistal_level2_alpha');
UPDATE artifactspawninfo SET rate=0.5 WHERE zoneid=(SELECT TOP 1 id FROM zones WHERE note='new virginia') AND artifacttype=(SELECT TOP 1 id FROM artifacttypes WHERE artifacttypes.name='observer_pelistal_level3_alpha');
UPDATE artifactspawninfo SET rate=2 WHERE zoneid=(SELECT TOP 1 id FROM zones WHERE note='new virginia') AND artifacttype=(SELECT TOP 1 id FROM artifacttypes WHERE artifacttypes.name='observer_thelodica_level1_alpha');
UPDATE artifactspawninfo SET rate=1 WHERE zoneid=(SELECT TOP 1 id FROM zones WHERE note='new virginia') AND artifacttype=(SELECT TOP 1 id FROM artifacttypes WHERE artifacttypes.name='observer_thelodica_level2_alpha');
UPDATE artifactspawninfo SET rate=0.5 WHERE zoneid=(SELECT TOP 1 id FROM zones WHERE note='new virginia') AND artifacttype=(SELECT TOP 1 id FROM artifacttypes WHERE artifacttypes.name='observer_thelodica_level3_alpha');
UPDATE artifactspawninfo SET rate=12 WHERE zoneid=(SELECT TOP 1 id FROM zones WHERE note='new virginia') AND artifacttype=(SELECT TOP 1 id FROM artifacttypes WHERE artifacttypes.name='salvage_nuimqol_level1_alpha');
UPDATE artifactspawninfo SET rate=6 WHERE zoneid=(SELECT TOP 1 id FROM zones WHERE note='new virginia') AND artifacttype=(SELECT TOP 1 id FROM artifacttypes WHERE artifacttypes.name='salvage_nuimqol_level2_alpha');
UPDATE artifactspawninfo SET rate=3 WHERE zoneid=(SELECT TOP 1 id FROM zones WHERE note='new virginia') AND artifacttype=(SELECT TOP 1 id FROM artifacttypes WHERE artifacttypes.name='salvage_nuimqol_level3_alpha');
UPDATE artifactspawninfo SET rate=12 WHERE zoneid=(SELECT TOP 1 id FROM zones WHERE note='new virginia') AND artifacttype=(SELECT TOP 1 id FROM artifacttypes WHERE artifacttypes.name='salvage_pelistal_level1_alpha');
UPDATE artifactspawninfo SET rate=6 WHERE zoneid=(SELECT TOP 1 id FROM zones WHERE note='new virginia') AND artifacttype=(SELECT TOP 1 id FROM artifacttypes WHERE artifacttypes.name='salvage_pelistal_level2_alpha');
UPDATE artifactspawninfo SET rate=3 WHERE zoneid=(SELECT TOP 1 id FROM zones WHERE note='new virginia') AND artifacttype=(SELECT TOP 1 id FROM artifacttypes WHERE artifacttypes.name='salvage_pelistal_level3_alpha');
UPDATE artifactspawninfo SET rate=12 WHERE zoneid=(SELECT TOP 1 id FROM zones WHERE note='new virginia') AND artifacttype=(SELECT TOP 1 id FROM artifacttypes WHERE artifacttypes.name='salvage_thelodica_level1_alpha');
UPDATE artifactspawninfo SET rate=6 WHERE zoneid=(SELECT TOP 1 id FROM zones WHERE note='new virginia') AND artifacttype=(SELECT TOP 1 id FROM artifacttypes WHERE artifacttypes.name='salvage_thelodica_level2_alpha');
UPDATE artifactspawninfo SET rate=3 WHERE zoneid=(SELECT TOP 1 id FROM zones WHERE note='new virginia') AND artifacttype=(SELECT TOP 1 id FROM artifacttypes WHERE artifacttypes.name='salvage_thelodica_level3_alpha');
UPDATE artifactspawninfo SET rate=8 WHERE zoneid=(SELECT TOP 1 id FROM zones WHERE note='new virginia') AND artifacttype=(SELECT TOP 1 id FROM artifacttypes WHERE artifacttypes.name='science_nuimqol_level1_alpha');
UPDATE artifactspawninfo SET rate=4 WHERE zoneid=(SELECT TOP 1 id FROM zones WHERE note='new virginia') AND artifacttype=(SELECT TOP 1 id FROM artifacttypes WHERE artifacttypes.name='science_nuimqol_level2_alpha');
UPDATE artifactspawninfo SET rate=2 WHERE zoneid=(SELECT TOP 1 id FROM zones WHERE note='new virginia') AND artifacttype=(SELECT TOP 1 id FROM artifacttypes WHERE artifacttypes.name='science_nuimqol_level3_alpha');
UPDATE artifactspawninfo SET rate=8 WHERE zoneid=(SELECT TOP 1 id FROM zones WHERE note='new virginia') AND artifacttype=(SELECT TOP 1 id FROM artifacttypes WHERE artifacttypes.name='science_pelistal_level1_alpha');
UPDATE artifactspawninfo SET rate=4 WHERE zoneid=(SELECT TOP 1 id FROM zones WHERE note='new virginia') AND artifacttype=(SELECT TOP 1 id FROM artifacttypes WHERE artifacttypes.name='science_pelistal_level2_alpha');
UPDATE artifactspawninfo SET rate=2 WHERE zoneid=(SELECT TOP 1 id FROM zones WHERE note='new virginia') AND artifacttype=(SELECT TOP 1 id FROM artifacttypes WHERE artifacttypes.name='science_pelistal_level3_alpha');
UPDATE artifactspawninfo SET rate=8 WHERE zoneid=(SELECT TOP 1 id FROM zones WHERE note='new virginia') AND artifacttype=(SELECT TOP 1 id FROM artifacttypes WHERE artifacttypes.name='science_thelodica_level1_alpha');
UPDATE artifactspawninfo SET rate=4 WHERE zoneid=(SELECT TOP 1 id FROM zones WHERE note='new virginia') AND artifacttype=(SELECT TOP 1 id FROM artifacttypes WHERE artifacttypes.name='science_thelodica_level2_alpha');
UPDATE artifactspawninfo SET rate=2 WHERE zoneid=(SELECT TOP 1 id FROM zones WHERE note='new virginia') AND artifacttype=(SELECT TOP 1 id FROM artifacttypes WHERE artifacttypes.name='science_thelodica_level3_alpha');
UPDATE artifactspawninfo SET rate=8 WHERE zoneid=(SELECT TOP 1 id FROM zones WHERE note='hershfield') AND artifacttype=(SELECT TOP 1 id FROM artifacttypes WHERE artifacttypes.name='industrial_nuimqol_level1_alpha');
UPDATE artifactspawninfo SET rate=4 WHERE zoneid=(SELECT TOP 1 id FROM zones WHERE note='hershfield') AND artifacttype=(SELECT TOP 1 id FROM artifacttypes WHERE artifacttypes.name='industrial_nuimqol_level2_alpha');
UPDATE artifactspawninfo SET rate=2 WHERE zoneid=(SELECT TOP 1 id FROM zones WHERE note='hershfield') AND artifacttype=(SELECT TOP 1 id FROM artifacttypes WHERE artifacttypes.name='industrial_nuimqol_level3_alpha');
UPDATE artifactspawninfo SET rate=8 WHERE zoneid=(SELECT TOP 1 id FROM zones WHERE note='hershfield') AND artifacttype=(SELECT TOP 1 id FROM artifacttypes WHERE artifacttypes.name='industrial_pelistal_level1_alpha');
UPDATE artifactspawninfo SET rate=4 WHERE zoneid=(SELECT TOP 1 id FROM zones WHERE note='hershfield') AND artifacttype=(SELECT TOP 1 id FROM artifacttypes WHERE artifacttypes.name='industrial_pelistal_level2_alpha');
UPDATE artifactspawninfo SET rate=2 WHERE zoneid=(SELECT TOP 1 id FROM zones WHERE note='hershfield') AND artifacttype=(SELECT TOP 1 id FROM artifacttypes WHERE artifacttypes.name='industrial_pelistal_level3_alpha');
UPDATE artifactspawninfo SET rate=8 WHERE zoneid=(SELECT TOP 1 id FROM zones WHERE note='hershfield') AND artifacttype=(SELECT TOP 1 id FROM artifacttypes WHERE artifacttypes.name='industrial_thelodica_level1_alpha');
UPDATE artifactspawninfo SET rate=4 WHERE zoneid=(SELECT TOP 1 id FROM zones WHERE note='hershfield') AND artifacttype=(SELECT TOP 1 id FROM artifacttypes WHERE artifacttypes.name='industrial_thelodica_level2_alpha');
UPDATE artifactspawninfo SET rate=2 WHERE zoneid=(SELECT TOP 1 id FROM zones WHERE note='hershfield') AND artifacttype=(SELECT TOP 1 id FROM artifacttypes WHERE artifacttypes.name='industrial_thelodica_level3_alpha');
UPDATE artifactspawninfo SET rate=12 WHERE zoneid=(SELECT TOP 1 id FROM zones WHERE note='hershfield') AND artifacttype=(SELECT TOP 1 id FROM artifacttypes WHERE artifacttypes.name='infestation_nuimqol_level1_alpha');
UPDATE artifactspawninfo SET rate=6 WHERE zoneid=(SELECT TOP 1 id FROM zones WHERE note='hershfield') AND artifacttype=(SELECT TOP 1 id FROM artifacttypes WHERE artifacttypes.name='infestation_nuimqol_level2_alpha');
UPDATE artifactspawninfo SET rate=3 WHERE zoneid=(SELECT TOP 1 id FROM zones WHERE note='hershfield') AND artifacttype=(SELECT TOP 1 id FROM artifacttypes WHERE artifacttypes.name='infestation_nuimqol_level3_alpha');
UPDATE artifactspawninfo SET rate=12 WHERE zoneid=(SELECT TOP 1 id FROM zones WHERE note='hershfield') AND artifacttype=(SELECT TOP 1 id FROM artifacttypes WHERE artifacttypes.name='infestation_pelistal_level1_alpha');
UPDATE artifactspawninfo SET rate=6 WHERE zoneid=(SELECT TOP 1 id FROM zones WHERE note='hershfield') AND artifacttype=(SELECT TOP 1 id FROM artifacttypes WHERE artifacttypes.name='infestation_pelistal_level2_alpha');
UPDATE artifactspawninfo SET rate=3 WHERE zoneid=(SELECT TOP 1 id FROM zones WHERE note='hershfield') AND artifacttype=(SELECT TOP 1 id FROM artifacttypes WHERE artifacttypes.name='infestation_pelistal_level3_alpha');
UPDATE artifactspawninfo SET rate=12 WHERE zoneid=(SELECT TOP 1 id FROM zones WHERE note='hershfield') AND artifacttype=(SELECT TOP 1 id FROM artifacttypes WHERE artifacttypes.name='infestation_thelodica_level1_alpha');
UPDATE artifactspawninfo SET rate=6 WHERE zoneid=(SELECT TOP 1 id FROM zones WHERE note='hershfield') AND artifacttype=(SELECT TOP 1 id FROM artifacttypes WHERE artifacttypes.name='infestation_thelodica_level2_alpha');
UPDATE artifactspawninfo SET rate=3 WHERE zoneid=(SELECT TOP 1 id FROM zones WHERE note='hershfield') AND artifacttype=(SELECT TOP 1 id FROM artifacttypes WHERE artifacttypes.name='infestation_thelodica_level3_alpha');
UPDATE artifactspawninfo SET rate=2 WHERE zoneid=(SELECT TOP 1 id FROM zones WHERE note='hershfield') AND artifacttype=(SELECT TOP 1 id FROM artifacttypes WHERE artifacttypes.name='observer_nuimqol_level1_alpha');
UPDATE artifactspawninfo SET rate=1 WHERE zoneid=(SELECT TOP 1 id FROM zones WHERE note='hershfield') AND artifacttype=(SELECT TOP 1 id FROM artifacttypes WHERE artifacttypes.name='observer_nuimqol_level2_alpha');
UPDATE artifactspawninfo SET rate=0.5 WHERE zoneid=(SELECT TOP 1 id FROM zones WHERE note='hershfield') AND artifacttype=(SELECT TOP 1 id FROM artifacttypes WHERE artifacttypes.name='observer_nuimqol_level3_alpha');
UPDATE artifactspawninfo SET rate=2 WHERE zoneid=(SELECT TOP 1 id FROM zones WHERE note='hershfield') AND artifacttype=(SELECT TOP 1 id FROM artifacttypes WHERE artifacttypes.name='observer_pelistal_level1_alpha');
UPDATE artifactspawninfo SET rate=1 WHERE zoneid=(SELECT TOP 1 id FROM zones WHERE note='hershfield') AND artifacttype=(SELECT TOP 1 id FROM artifacttypes WHERE artifacttypes.name='observer_pelistal_level2_alpha');
UPDATE artifactspawninfo SET rate=0.5 WHERE zoneid=(SELECT TOP 1 id FROM zones WHERE note='hershfield') AND artifacttype=(SELECT TOP 1 id FROM artifacttypes WHERE artifacttypes.name='observer_pelistal_level3_alpha');
UPDATE artifactspawninfo SET rate=2 WHERE zoneid=(SELECT TOP 1 id FROM zones WHERE note='hershfield') AND artifacttype=(SELECT TOP 1 id FROM artifacttypes WHERE artifacttypes.name='observer_thelodica_level1_alpha');
UPDATE artifactspawninfo SET rate=1 WHERE zoneid=(SELECT TOP 1 id FROM zones WHERE note='hershfield') AND artifacttype=(SELECT TOP 1 id FROM artifacttypes WHERE artifacttypes.name='observer_thelodica_level2_alpha');
UPDATE artifactspawninfo SET rate=0.5 WHERE zoneid=(SELECT TOP 1 id FROM zones WHERE note='hershfield') AND artifacttype=(SELECT TOP 1 id FROM artifacttypes WHERE artifacttypes.name='observer_thelodica_level3_alpha');
UPDATE artifactspawninfo SET rate=12 WHERE zoneid=(SELECT TOP 1 id FROM zones WHERE note='hershfield') AND artifacttype=(SELECT TOP 1 id FROM artifacttypes WHERE artifacttypes.name='salvage_nuimqol_level1_alpha');
UPDATE artifactspawninfo SET rate=6 WHERE zoneid=(SELECT TOP 1 id FROM zones WHERE note='hershfield') AND artifacttype=(SELECT TOP 1 id FROM artifacttypes WHERE artifacttypes.name='salvage_nuimqol_level2_alpha');
UPDATE artifactspawninfo SET rate=3 WHERE zoneid=(SELECT TOP 1 id FROM zones WHERE note='hershfield') AND artifacttype=(SELECT TOP 1 id FROM artifacttypes WHERE artifacttypes.name='salvage_nuimqol_level3_alpha');
UPDATE artifactspawninfo SET rate=12 WHERE zoneid=(SELECT TOP 1 id FROM zones WHERE note='hershfield') AND artifacttype=(SELECT TOP 1 id FROM artifacttypes WHERE artifacttypes.name='salvage_pelistal_level1_alpha');
UPDATE artifactspawninfo SET rate=6 WHERE zoneid=(SELECT TOP 1 id FROM zones WHERE note='hershfield') AND artifacttype=(SELECT TOP 1 id FROM artifacttypes WHERE artifacttypes.name='salvage_pelistal_level2_alpha');
UPDATE artifactspawninfo SET rate=3 WHERE zoneid=(SELECT TOP 1 id FROM zones WHERE note='hershfield') AND artifacttype=(SELECT TOP 1 id FROM artifacttypes WHERE artifacttypes.name='salvage_pelistal_level3_alpha');
UPDATE artifactspawninfo SET rate=12 WHERE zoneid=(SELECT TOP 1 id FROM zones WHERE note='hershfield') AND artifacttype=(SELECT TOP 1 id FROM artifacttypes WHERE artifacttypes.name='salvage_thelodica_level1_alpha');
UPDATE artifactspawninfo SET rate=6 WHERE zoneid=(SELECT TOP 1 id FROM zones WHERE note='hershfield') AND artifacttype=(SELECT TOP 1 id FROM artifacttypes WHERE artifacttypes.name='salvage_thelodica_level2_alpha');
UPDATE artifactspawninfo SET rate=3 WHERE zoneid=(SELECT TOP 1 id FROM zones WHERE note='hershfield') AND artifacttype=(SELECT TOP 1 id FROM artifacttypes WHERE artifacttypes.name='salvage_thelodica_level3_alpha');
UPDATE artifactspawninfo SET rate=8 WHERE zoneid=(SELECT TOP 1 id FROM zones WHERE note='hershfield') AND artifacttype=(SELECT TOP 1 id FROM artifacttypes WHERE artifacttypes.name='science_nuimqol_level1_alpha');
UPDATE artifactspawninfo SET rate=4 WHERE zoneid=(SELECT TOP 1 id FROM zones WHERE note='hershfield') AND artifacttype=(SELECT TOP 1 id FROM artifacttypes WHERE artifacttypes.name='science_nuimqol_level2_alpha');
UPDATE artifactspawninfo SET rate=2 WHERE zoneid=(SELECT TOP 1 id FROM zones WHERE note='hershfield') AND artifacttype=(SELECT TOP 1 id FROM artifacttypes WHERE artifacttypes.name='science_nuimqol_level3_alpha');
UPDATE artifactspawninfo SET rate=8 WHERE zoneid=(SELECT TOP 1 id FROM zones WHERE note='hershfield') AND artifacttype=(SELECT TOP 1 id FROM artifacttypes WHERE artifacttypes.name='science_pelistal_level1_alpha');
UPDATE artifactspawninfo SET rate=4 WHERE zoneid=(SELECT TOP 1 id FROM zones WHERE note='hershfield') AND artifacttype=(SELECT TOP 1 id FROM artifacttypes WHERE artifacttypes.name='science_pelistal_level2_alpha');
UPDATE artifactspawninfo SET rate=2 WHERE zoneid=(SELECT TOP 1 id FROM zones WHERE note='hershfield') AND artifacttype=(SELECT TOP 1 id FROM artifacttypes WHERE artifacttypes.name='science_pelistal_level3_alpha');
UPDATE artifactspawninfo SET rate=8 WHERE zoneid=(SELECT TOP 1 id FROM zones WHERE note='hershfield') AND artifacttype=(SELECT TOP 1 id FROM artifacttypes WHERE artifacttypes.name='science_thelodica_level1_alpha');
UPDATE artifactspawninfo SET rate=4 WHERE zoneid=(SELECT TOP 1 id FROM zones WHERE note='hershfield') AND artifacttype=(SELECT TOP 1 id FROM artifacttypes WHERE artifacttypes.name='science_thelodica_level2_alpha');
UPDATE artifactspawninfo SET rate=2 WHERE zoneid=(SELECT TOP 1 id FROM zones WHERE note='hershfield') AND artifacttype=(SELECT TOP 1 id FROM artifacttypes WHERE artifacttypes.name='science_thelodica_level3_alpha');

GO


--03
PRINT N'RUNNING UPDATES ON ARTIFACTLOOT on CT-Capsules only - set each to a flat rate for all artifacts';



USE [perpetuumsa]
GO

------------------------
--Simple Boost for CT drop chances
--2019/01/31
--drop rates A = 3%, B = 2%, C = 1%
------------------------


--Set the chance to 3, 2, 1% respectively (TO BE FIXED to something more sensible)
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



------------------------
--EP Bonus Item
------------------------

USE [perpetuumsa]
GO

CREATE SCHEMA opp
GO



-- Patch to add EP Boost Item Definition
begin transaction
set xact_abort on

create table #temp_ins_entitydefaults 
(
	[definition] int not null,
	definitionname varchar(100) not null,
	credit float not null,
	tmcoin int not null,
	icscoin int not null,
	asicoin int not null,
	unicoin int not null
);

insert into dbo.entitydefaults
(
	definitionname,
	quantity,
	attributeflags,
	categoryflags,
	options,
	note,
	[enabled],
	volume,
	mass,
	[hidden],
	health,
	descriptiontoken,
	purchasable,
	tiertype,
	tierlevel
)
output
	inserted.[definition] as [definition],
	inserted.definitionname as definitionname,
	75000000.0 as credit,
	36 as tmcoin,
	36 as icscoin,
	36 as asicoin,
	0 as unicoin
into #temp_ins_entitydefaults
values
(
	'def_boost_ep_t1', --'def_epboost_tier1', -- definitionname
	1, -- quantity
	2052, -- attribute flags : 0x804 copied from paint
	1179, -- category flags : 0x49B copied from paint
	'#addBoost=n2 #timePeriodHours=i18 #tier=$tierlevel_t1', -- options
	'Adds 2 to the current EP income multiplier for 24 hours', -- note
	1, -- enabled
	1E-06, -- volume
	1E-06, -- mass
	0, -- hidden
	100, -- health
	'def_redeemable_ep_standard_desc', -- descriptiontoken
	1, --purchasable
	1, -- tiertype
	1 -- tierlevel
);

insert into dbo.entitydefaults
(
	definitionname,
	quantity,
	attributeflags,
	categoryflags,
	options,
	note,
	[enabled],
	volume,
	mass,
	[hidden],
	health,
	descriptiontoken,
	purchasable,
	tiertype,
	tierlevel
)
output
	inserted.[definition] as [definition],
	inserted.definitionname as definitionname,
	115000000.0 as credit,
	60 as tmcoin,
	60 as icscoin,
	60 as asicoin,
	0 as unicoin
into #temp_ins_entitydefaults
values
(
	'def_boost_ep_t2', --'def_epboost_tier1', -- definitionname
	1, -- quantity
	2052, -- attribute flags : 0x804 copied from paint
	1179, -- category flags : 0x49B copied from paint
	'#addBoost=n3 #timePeriodHours=i18 #tier=$tierlevel_t2', -- options
	'Adds 3 to the current EP income multiplier for 24 hours', -- note
	1, -- enabled
	1E-06, -- volume
	1E-06, -- mass
	0, -- hidden
	100, -- health
	'def_redeemable_ep_standard_desc', -- descriptiontoken
	1, --purchasable
	1, -- tiertype
	2 -- tierlevel
);

insert into dbo.entitydefaults
(
	definitionname,
	quantity,
	attributeflags,
	categoryflags,
	options,
	note,
	[enabled],
	volume,
	mass,
	[hidden],
	health,
	descriptiontoken,
	purchasable,
	tiertype,
	tierlevel
)
output
	inserted.[definition] as [definition],
	inserted.definitionname as definitionname,
	185000000.0 as credit,
	120 as tmcoin,
	120 as icscoin,
	120 as asicoin,
	0 as unicoin
into #temp_ins_entitydefaults
values
(
	'def_boost_ep_t3', --'def_epboost_tier1', -- definitionname
	1, -- quantity
	2052, -- attribute flags : 0x804 copied from paint
	1179, -- category flags : 0x49B copied from paint
	'#addBoost=n5 #timePeriodHours=i18 #tier=$tierlevel_t3', -- options
	'Adds 5 to the current EP income multiplier for 24 hours', -- note
	1, -- enabled
	1E-06, -- volume
	1E-06, -- mass
	0, -- hidden
	100, -- health
	'def_redeemable_ep_standard_desc', -- descriptiontoken
	1, --purchasable
	1, -- tiertype
	3 -- tierlevel
);

insert into dbo.itemshop
(
	presetid,
	targetdefinition,
	targetamount,
	credit,
	purchasecount,
	tmcoin,
	icscoin,
	asicoin,
	unicoin
)
select
	1, --presetid
	[definition], --targetdefinition
	1, -- targetamount
	credit, -- credit
	1, --purchasecount
	tmcoin, -- tmcoin
	icscoin, -- icscoin
	asicoin, -- asicoin
	unicoin -- unicoin
from #temp_ins_entitydefaults

insert into dbo.aggregatevalues
(
	[definition],
	[field],
	[value]
)
select
	[definition],
	af.id,
	8.64E+7
from #temp_ins_entitydefaults
join aggregatefields af on af.[name] = 'despawn_time';

select * from #temp_ins_entitydefaults
--drop table #temp_ins_entitydefaults;

commit transaction
go

-- Update the extensionsubscription table to add the extra bonus value
begin transaction
set xact_abort on

alter table dbo.extensionsubscription
add multiplierBonus int not null;

commit transaction
go


begin transaction
set xact_abort on

commit transaction
go



-- Update the subscription procedure to accept a value
-- Split into 2 parts, removal and addition
if object_id('opp.extensionSubscriptionStart', 'P') is not null
	drop procedure opp.extensionSubscriptionStart;
go

create procedure opp.extensionSubscriptionStart
	@accountID int,
	@startTime datetime,
	@endTime datetime,
	@multiplierBonus int
as

set nocount on;

begin transaction
set xact_abort on
set transaction isolation level read committed

if exists (select * from dbo.extensionsubscription where accountid = @accountID and endTime > @startTime)
	throw 100000, 'Extension bonus already active', 1;

insert into dbo.extensionsubscription
(
	accountid,
	starttime,
	endtime,
	multiplierBonus
)
values
(
	@accountid,
	@startTime,
	@endTime,
	@multiplierBonus
)
commit transaction
go


-- Remove the extension extension procedure - no longer required
if object_id('dbo.extensionSubscriptionExtend', 'P') is not null
	drop procedure dbo.extensionSubscriptionExtend;
go

if object_id('opp.getExtensionSubscription', 'P') is not null
	drop procedure opp.getExtensionSubscription;
go

create procedure opp.getExtensionSubscription
	@accountID int
as

select top 1
	starttime,
	endtime,
	multiplierBonus
from dbo.extensionsubscription
where startTime < getutcdate() and endtime > getutcdate()
order by endtime desc;