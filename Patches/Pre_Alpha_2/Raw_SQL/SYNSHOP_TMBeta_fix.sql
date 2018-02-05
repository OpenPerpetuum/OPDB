SELECT * FROM itemshoplocations
JOIN entities ON locationeid=entities.eid
WHERE entities.parent=47383

--Set TMB to TM PVP synshop preset (sells green stuff with green tokens)
UPDATE itemshoplocations
SET presetid=6
FROM itemshoplocations 
JOIN entities on itemshoplocations.locationeid=entities.eid
WHERE entities.parent=47383;
