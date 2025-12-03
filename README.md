# linux-server-toolkit

A small set of administrative scripts I run on my own systems.

### Purpose
These scripts originated from repetitive tasks I encountered while managing Ubuntu servers in my lab environment. Rather than perform the same checks manually, I wrote tools that execute reliably and leave a clear record.

### Contents

| Script             | Function                                                                 | Rationale                                      |
|--------------------|--------------------------------------------------------------------------|------------------------------------------------|
| disk-watcher.sh    | Records mount points exceeding 85 % capacity to /tmp/disk-watcher.log   | Prevents surprises from full filesystems       |
| login-auditor.sh   | Summarizes recent successful logins and failed SSH attempts            | Quick visibility into potential compromise     |
| safe-upgrade.sh    | Performs non-interactive update/upgrade; reboots only when kernel packages change | Reduces unplanned downtime after upgrades      |

Each script depends only on utilities present on a standard Ubuntu/Debian installation. No external services are required.

### Requirements
- Ubuntu 22.04 LTS or 24.04 LTS (tested)  
- Debian 12 (tested)  
- Bash ≥ 5.1  
- Standard system utilities (df, last, journalctl, apt, etc.)

### Usage
```bash
git clone https://github.com/cweit-dev/linux-server-toolkit.git
cd linux-server-toolkit
chmod +x *.sh
./disk-watcher.sh
