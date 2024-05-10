# Ubuntu Throttlestop

Simple tool and steps to manage thermal behavior and disable the bd-prochot bit on Debian-based Linux distributions for Intel CPUs with MSR.

## Disclaimer
> [!WARNING]
> Please follow the instructions properly otherwise it might no work for you and may leave an impact to your hardware.
> Try it on your own risk!


## Installation

#### Before continuing, you must have ```msr-tools``` for modprobe, rdmsr and wrmsr to test/read/write model specific registers (MSRs) of an x86 CPU.
```bash
  sudo apt install msr-tools
```

#### Install cpufrequtils to check CPU usage on all cores.
```bash
  sudo apt install cpufrequtils
```

#### Enable polling
```bash
  sudo modprobe msr
```

#### Read register 0x1FC on all cores and output as decimal
```bash
  sudo rdmsr -a -d 0x1FC
```

#### Read register 0x1FC on all cores and write them down. Example of returned records:
- 262236
- 262236
- 262236
- 262236

#### Turn off the bd-prochot bit by subtracting 1 from the output of 0x1FC. Do not copy the command below, but take the command output of 0x1FC and subtract 1 and replace 262236 with it.
```bash
  sudo wrmsr 0x1FC 262235
```

#### Check if your CPU speed is changing
```bash
  watch -n 1 cpufreq-info
```

#### Process finished, now everything will be fine!

## 🚀 Automatic Instalation
Coming Soon...
