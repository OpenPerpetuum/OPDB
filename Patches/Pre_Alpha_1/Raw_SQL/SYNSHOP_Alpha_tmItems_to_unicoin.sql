SELECT * from itemshop
WHERE presetid=1

--Set all items in TM-Alpha Synshop preset to sell with equivalent unicoin amounts (where not already set)
UPDATE itemshop 
SET unicoin=tmcoin
WHERE presetid=1 and unicoin IS NULL;

--Clear out tmcoin values after setting unicoin amount
UPDATE itemshop
SET tmcoin=NULL
WHERE presetid=1;

