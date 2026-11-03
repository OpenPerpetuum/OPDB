# Custom dictionary deployment — next update

The corporation-founding-fee label is now a `{%PRICE%}` template.  The server
replaces that token with the configured `Corporation.FoundingPrice` when a
player signs in.

When preparing the next server-data update:

1. Create the update's `Server/data/customDictionary/` directory.
2. Copy the latest **complete** language dictionary files into that directory.
   Do not deploy the partial staging `0.json` by itself; it is not a complete
   runtime dictionary.
3. Replace the `corporationcreate_price` value in every shipped language file
   with its localized label containing `{%PRICE%}`.
4. Add the update to `apply_all.bat` and `apply_all_local.bat` with `Server` as
   the third `applyPatch` argument.  The existing `xcopy` step will then copy
   the complete dictionary files to `C:\PerpetuumServer\data\customDictionary`.
5. Verify a clean local update, restart the server, sign in again, and confirm
   the dialog displays the configured fee.

Do not modify existing `Patches/Live_*` directories for this change.  Their
contents are historical release records.
