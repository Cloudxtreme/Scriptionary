:: Need to remove a lot of windows patches, just list the patch number below, one per line.

for %%a in (
3076895
3075851
3075226
) do start "" /w wusa /uninstall /kb:%%a /quiet /norestart
