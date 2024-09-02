# Fail2Ban Simple Monitoring

This is a simple script to monitor Fail2Ban activity on your server. The script generates an HTML report that displays information about blocked IP addresses, ports, protocols, and actions taken by Fail2Ban. The report is then sent to another monitoring server via SSH, making it accessible through a web browser.

## Features

- **Firewall Data Extraction:** Retrieves rules from the firewall managed by `firewall-cmd`.
- **HTML Report Generation:** Creates an HTML file containing a table with information about blocked IPs.
- **Remote Monitoring Server Integration:** Sends the HTML report to a monitoring server using `rsync` over SSH.
- **Automated Scheduling with Cron:** The script can be scheduled to run automatically using cron jobs, ensuring that the report is always up-to-date.

## Prerequisites

Ensure you have the following prerequisites before using this script:

1. **Fail2Ban and firewall-cmd:** Your server should have Fail2Ban and `firewall-cmd` installed.
2. **Monitoring Server:** A separate server is needed to receive the HTML report and display it.
3. **SSH Connection:** Ensure a secure SSH connection between the main server and the monitoring server.
4. **Cron:** Cron needs to be configured to run this script periodically.

## Installation

1. Clone this repository to your server:
    ```bash
    git clone https://github.com/rudiputranode/Fail2ban-Simple-Monitoring.git
    cd Fail2ban-Simple-Monitoring
    ```

2. Edit the `monitor.sh` script to match your server configuration, particularly the section where the file is sent via SSH (`rsync`).

3. Add a cron job to run the script automatically. For example, to run it every 10 minutes:
    ```bash
    */10 * * * * /path/to/Fail2ban-Simple-Monitoring/monitor.sh
    ```

## Usage

Once the script runs, the monitoring results will be sent to the specified monitoring server. You can access the HTML report via a web browser by navigating to the monitoring server's URL.

Example:
http://192.168.1.100/fail2ban.html

## Contributing

If you would like to contribute to this project, please fork the repository, make the necessary changes, and submit a pull request. Contributions and feedback are greatly appreciated!

## License

This project is licensed under the MIT License. Please see the `LICENSE` file for more details.
