#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_FILE="$SCRIPT_DIR/ddns_records.json"

echo "Looking for config at: $CONFIG_FILE"

while true; do
    records=$(jq -c '.[]' "$CONFIG_FILE")

    for record in $records; do
        domain=$(echo "$record" | jq -r '.domain')
        interval=$(echo "$record" | jq -r '.interval')
        api_key=$(echo "$record" | jq -r '.api_key')
        zone=$(echo "$record" | jq -r '.zone')
        record=$(echo "$record" | jq -r '.record')
        proxied=$(echo "$record" | jq -r '.proxied')

        # Get current external IP
        current_ip=$(curl -s https://ifconfig.me)

        # Fetch current Cloudflare record IP
        cf_record_ip=$(dig +short "$domain")

        if [[ "$current_ip" != "$cf_record_ip" ]]; then
            echo "Updating Cloudflare record for $domain..."
            curl -X PUT "https://api.cloudflare.com/client/v4/zones/$zone/dns_records/$record" \
                -H "Authorization: Bearer $api_key" \
                -H "Content-Type: application/json" \
                --data "{\"type\":\"A\",\"name\":\"$domain\",\"content\":\"$current_ip\",\"ttl\":120,\"proxied\":\"$proxied\"}"
        fi

        sleep "$interval"
    done
done
