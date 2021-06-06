USE [perpetuumsa]
GO


DECLARE @newsCat AS INT = (SELECT TOP 1 id FROM newscategories WHERE category='newscat_developer');

UPDATE channels SET 
	topic = 'You are running the Open Perpetuum Server! https://OpenPerpetuum.com for more details';

INSERT INTO news (title,body,type,language) VALUES
('OPP Server Info',
N'Thank you for choosing the Open Perpetuum Server for your Perpetuum Server needs!
Please note that OPP does NOT provide technical support.  Your server; your responsibility!
If you require assistance, please content AC at: info@perpetuum-online.com

For more details on Open Perpetuum - the free, volunteer run, open source, Perpetuum server check the website: https://OpenPerpetuum.com
Want to join the team? https://openperpetuum.com/volunteer
Or contribute your own fixes or features to our github: https://github.com/OpenPerpetuum
Or support free, open source development and the live server by donating at: https://patreon.com/OpenPerpetuum
',
@newsCat,0);

UPDATE serverinfo SET
	name='Dev instance of OPP server',
	description='This server is running Open Perpetuum - a fork of the Perpetuum Online server',
	isbroadcast=0,
	isopen=0;
GO