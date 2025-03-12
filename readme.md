# Simple DDNS
A super simple DDNS made to update records on cloudflare.

Do note that you must use `chmod +x ./ddns_checker.sh` and `chmod +x ./ddns.sh`.
Some editing is required for the ddns.service, you need to set the correct path for the ddns folder & set a correct user.

```
[Unit]
Description=Custom DDNS Updater
After=network.target

[Service]
Type=simple
ExecStart=/bin/bash /home/youruser/simple-ddns/ddns_checker.sh
Restart=always
User=youruser

[Install]
WantedBy=multi-user.target
```
You need to replace the "youruser" fields with your actual username of the account, or you could alternatively use root, although i'd advice against, as I haven't tested it.

Update records by either editing the config file that is found in your root home folder `/home/username/ddns_records.json` or the more preferable way by doing `./ddns.sh` in the ddns folder.
After you're done with the records, and overall editing the service, you must move it to your systemd folder.
*I believe* it's in `/etc/systemd/system/`; my path is `/etc/systemd/system/simpleddns.service`.

# WARNING
This was made super quickly for **PRIVATE** use, this should not be used in a prod environment, I use this on my home server if anything.
YOUR CLOUDFLARE API KEY WILL BE STORED IN __**PLAIN TEXT**__ IN YOUR DDNS FOLDER. (thus the warning)

PR's are welcome to improve it (although try not to make it extremely overcomplicated, it's called simple for a reason).
