#!/bin/bash

CONFIG_FILE="$HOME/ddns_records.json"

if [[ ! -f "$CONFIG_FILE" ]]; then
    echo "[]" > "$CONFIG_FILE"
fi

list_records() {
    jq -r '.[] | "\(.domain) (Interval: \(.interval) seconds)"' "$CONFIG_FILE"
}

add_record() {
    read -p "Enter domain name (e.g., Fr3akyMurk.eu): " domain
    read -p "Enter check interval in seconds (default: 60): " interval
    interval=${interval:-60}
    read -p "Enter a Zone ID for the cloudflare record: " zone
    read -p "Enter a Record ID for the cloudflare record: " record
    read -p "Proxy this record? (Must be true / false): " proxy
    read -s -p "Enter Cloudflare API Key (DO NOTE, this is in plain text in your home folder.): " api_key
    echo

    jq --arg domain "$domain" --argjson interval "$interval" --arg zone "$zone" --arg record "$record" --arg proxy "$proxy" --arg api_key "$api_key" \
        '. + [{"domain": $domain, "interval": $interval, "api_key": $api_key, "zone": $zone, "proxied":$proxy, "record": $record}]' "$CONFIG_FILE" > temp.json && mv temp.json "$CONFIG_FILE"

    echo "Added $domain to tracking list."
}

remove_record() {
    list_records
    read -p "Enter domain to remove: " domain

    jq --arg domain "$domain" 'del(.[] | select(.domain == $domain))' "$CONFIG_FILE" > temp.json && mv temp.json "$CONFIG_FILE"

    echo "Removed $domain from tracking list."
}

echo "What would you like to do?"
echo "[1] Add a new record"
echo "[2] Remove a record"
read -p "Select an option: " option

case $option in
    1) add_record ;;
    2) remove_record ;;
    *) echo "Invalid option." ;;
esac
