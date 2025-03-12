# Simple DDNS
A super simple DDNS made to update records on cloudflare.

Do note that you must use `chmod +x ./ddns_checker.sh` and `chmod +x ./ddns.sh`.
Some editing is required for the ddns.service, you need to set the correct path for the ddns folder & set a correct user.

Update records by either editing the config file that is found in your root home folder `/home/username/ddns_records.json` or the more preferable way by doing `./ddns.sh` in the ddns folder.
After you're done with the records, and overall editing the service, you must move it to your systemd folder.
*I believe* it's in `/etc/systemd/system/`; my path is `/etc/systemd/system/simpleddns.service`.

# WARNING
This was made super quickly for **PRIVATE** use, this should not be used in a prod environment, I use this on my home server if anything.
YOUR CLOUDFLARE API KEY WILL BE STORED IN __**PLAIN TEXT**__ IN YOUR HOME FOLDER. (thus the warning)

PR's are welcome to improve it (although try not to make it extremely overcomplicated, it's called simple for a reason).
