#!/bin/bash

firewall-cmd --list-rich-rules > /tmp/rich-rules.txt

OUTPUT_FILE="/tmp/fail2ban.html"

echo "<!DOCTYPE html>
<html>
<head>
    <title>Fail2Ban Monitoring</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
        }
        table, th, td {
            border: 1px solid black;
        }
        th, td {
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>
    <h2>Fail2Ban Monitoring</h2>
    <table>
        <tr>
            <th>Source IP</th>
            <th>Port</th>
            <th>Protocol</th>
            <th>Action</th>
        </tr>" > $OUTPUT_FILE

while IFS= read -r line; do
    # Hanya proses baris yang terdeteksi sebagai alamat IP
    if [[ $line =~ source\ address=\"([0-9]+\.[0-9]+\.[0-9]+\.[0-9]+)\" ]]; then
        ip=${BASH_REMATCH[1]}
        port=$(echo $line | grep -oP 'port port="\K[^"]+')
        protocol=$(echo $line | grep -oP 'protocol="\K[^"]+')
        action=$(echo $line | grep -oP 'reject type="\K[^"]+')

        # Tambahkan baris ke tabel HTML
        echo "           <tr>
            <td>$ip</td>
            <td>$port</td>
            <td>$protocol</td>
            <td>$action</td>
        </tr>" >> $OUTPUT_FILE
    fi
done < "/tmp/rich-rules.txt"

echo "       </table>
</body>
</html>" >> $OUTPUT_FILE

rsync -ravzh --delete-after -e 'ssh -p2930'  $OUTPUT_FILE root@203.14.x.x:/var/www/html/fail2ban.html