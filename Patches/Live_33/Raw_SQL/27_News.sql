USE perpetuumsa

GO

INSERT INTO news (title, body, ntime, type, language) VALUES (
'Syndicate Warning: Intrusion detected!',
'To: All Syndicate Agents


Agents,


Our sensors detected possible intrusion.

Something managed to get out of one of those Network Breaches and now roaming on Herschfield.

Syndicate wants you to discover and eliminate all the possible threats, even if they don''t show any agression.

Once it''s done, stay alerted. Security Division thinks that this is not just a single accident.


For the Syndicate,

Command Directorate',
GETUTCDATE(),
5,
0)

GO