# infra-monitor

**infra-monitor** is a lightweight Nmap NSE script for silently testing response consistency across web infrastructure routes.  
It helps detect anomalies in access control, configuration discrepancies, or potential inconsistencies in how different endpoints respond.

This tool is designed for **ethical diagnostics** and **authorized infrastructure audits**.

---

## 🔍 Features

- Compares HTTP responses between normal and slightly varied access patterns
- Supports multiple HTTP headers to simulate real client traffic
- Detects potential filtering behavior or inconsistent behavior on protected routes
- Fully silent and unobtrusive by design — does not trigger obvious vulnerability scans

---

## 📅 Installation

1. Download the script:

```bash
curl -O https://raw.githubusercontent.com/your-user/infra-monitor/main/infra-monitor.nse
```

2. Run it using Nmap:

```bash
nmap -p443 --script=./infra-monitor.nse www.example.com
```

Or for multiple hosts:

```bash
nmap -p443 --script=./infra-monitor.nse -iL targets.txt
```

---

## 📄 Example Output

```
| infra-monitor: Responses matched normally
|_No unusual behavior observed
```

```
| infra-monitor: Response mismatch: 200 vs 403
|_Observed activity at: /ccenter/setup.jsp (code: 500)
```

---

## ⚠️ Legal & Ethical Use

This script is intended for **authorized security assessments and diagnostic audits only**.  
Do not use against targets you do not own or explicitly have permission to test.

---

## 👤 Author

Built by [Eliran Loai Deeb](https://www.linkedin.com/in/loai-deeb), cybersecurity researcher & ethical hacker.

---

