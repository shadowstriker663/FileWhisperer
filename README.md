# EchoMonitor
A lightweight network monitoring tool built with Batch and PowerShell.   Performs host reachability checks, port scanning, logging, and real-time email alerts.   Designed for learning, automation, and proactive monitoring in cybersecurity.  
How to Use
 Installation
1. Clone this repository:
   ```bash
   git clone https://github.com/<your-username>/EchoMonitor.git


Navigate into the project folder:

cd EchoMonitor


Run the batch script:

Echomonitor.bat

⚙ Usage

When you run the script, it will prompt you for:

Logfile Name → Where results will be saved (default: network_monitoring.txt)

Target IP Address → The host you want to monitor (e.g., 8.8.8.8)

Ports → Space-separated list of ports (default: 80 443 22)

Email Address → Where alerts should be sent

SMTP Server & Port → Email server (default: Gmail: smtp.gmail.com:587)

SMTP Username & Password → Your email credentials (App Password if Gmail)

Delay (seconds) → Time between each check (default: 60)

Example input session:

Set Logfile Name (default: network_monitoring.txt): monitor_log.txt
Enter Target IP Address (e.g 8.8.8.8): 64.226.87.251
Enter Ports To Monitor (default: 80 443 22): 22 80 443
Enter Your Email For Alerts: yourmail@example.com
Enter Your SMTP server (default: smtp.gmail.com): 
Enter SMTP port (default: 587): 
Enter SMTP Username (default: same as email): 
Enter your SMTP App Password (16 characters, no spaces): ********
Enter Delay Between Checks (seconds, default: 60): 30

📩 Output

The script will:

Continuously monitor the given host and ports.

Save results in the logfile.

Send you an email summary at every interval.

Sample email:

Network Status Update - 64.226.87.251 (26/08/2025 16:50:10)
Host: Reachable
Port 80: OPEN
Port 443: CLOSED
Port 22: OPEN


⚠️ Note for Gmail users:
You must enable 2FA and create a Gmail App Password (16 characters) to use instead of your normal email password.
