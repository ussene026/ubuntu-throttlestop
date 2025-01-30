# Ubuntu Throttlestop

A simple tool and set of instructions to manage thermal behavior and disable the `bd-prochot` bit on Intel CPUs for Debian-based Linux distributions (like Ubuntu) using MSR (Model-Specific Registers).

## Disclaimer
> [!WARNING]
> Please follow the instructions properly otherwise it might no work for you and may leave an impact to your hardware.
> Try it on your own risk!


## 🚀 Features

- Disable the `bd-prochot` bit on Intel CPUs to prevent thermal throttling.
- Easy-to-follow steps for managing CPU performance.
- Compatible with most Intel CPUs on Debian-based distributions (e.g., Ubuntu).

---

## 🛠️ Prerequisites

Before you begin, you need the following:

- **MSR Tools**: For testing, reading, and writing Model Specific Registers (MSRs) of an x86 CPU.
  ```bash
  sudo apt install msr-tools
  ```

- **cpufrequtils**: To monitor CPU usage across all cores.
  ```bash
  sudo apt install cpufrequtils
  ```

## 📋 Installation Steps
### 1. Enable MSR module
Load the `msr` module:
```bash
sudo modprobe msr
```

### 2. Read the MSR register `0x1FC` on all cores
To check the current value of register `0x1FC`:
```bash
sudo rdmsr -a -d 0x1FC
```
Example output:
```
262236
262236
262236
262236
```

### 3. Disable the `bd-prochot` bit
To disable the `bd-prochot` bit, subtract 1 from the value of `0x1FC`. Using the example above, subtract `1` from `262236`:
```bash
sudo wrmsr 0x1FC 262235
```

### 4. Verify CPU behavior
Check if your CPU speed is changing by running:
```bash
watch -n 1 cpufreq-info
```

---

## ⚡ Automatic Installation

To quickly set up the tool, you can clone this repository and run the installation script:

```bash
git clone git@github.com:ussene026/ubuntu-throttlestop.git
cd ubuntu-throttlestop
sudo bash install.sh
```

### Manually start the service:

```bash
sudo systemctl start bdprochot.service
```

---

## 🛠️ Uninstallation

To uninstall this script, run the following commands:

```bash
sudo systemctl stop bdprochot.service
sudo systemctl disable bdprochot.service
sudo rm /usr/local/bin/bdprochot.sh
sudo rm /etc/systemd/system/bdprochot.service
sudo systemctl daemon-reload
```

---

## 📢 Contributing

We welcome contributions to improve this project! Feel free to fork the repository, submit issues, and open pull requests.

### Steps for contributing:

1. Fork the repository
2. Clone your fork to your local machine
3. Create a new branch for your work
4. Make your changes
5. Test your changes
6. Submit a pull request with a description of the changes

---

## 📜 License

This project is licensed under the [MIT License](LICENSE).

---

## 👥 Author

- [ussene026](https://github.com/ussene026)
