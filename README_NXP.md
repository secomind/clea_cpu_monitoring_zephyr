<!--
Copyright 2025 SECO Mind Srl

SPDX-License-Identifier: Apache-2.0
-->

# Clea CPU metrics sample app for i.MX RT1064

[![License badge](https://img.shields.io/badge/License-Apache%202.0-red)](https://www.apache.org/licenses/LICENSE-2.0.txt)
![Language badge](https://img.shields.io/badge/Language-C-yellow)
![Language badge](https://img.shields.io/badge/Language-C++-yellow)
[![Board badge](https://img.shields.io/badge/Board-EVK&ndash;MIMXRT1064-blue)](https://www.nxp.com/pip/MIMXRT1064-EVK)
[![Category badge](https://img.shields.io/badge/Category-CLOUD%20CONNECTED%20DEVICES-yellowgreen)](https://mcuxpresso.nxp.com/appcodehub?search=cloud%20connected%20devices)
[![Toolchain badge](https://img.shields.io/badge/Toolchain-VS%20CODE-orange)](https://github.com/nxp-mcuxpresso/vscode-for-mcux/wiki)

Clea is SECO's comprehensive software suite for building IoT solutions that
harness field data. It provides fleet management functionality and data collection through the
Edgehog and Astarte components.

This demo application showcases a simple CPU monitoring application. Some CPU statistics are read
from the device and displayed on a custom application installed on Clea portal. The demo includes
both the Astarte and Edgehog components making it easy to manage the device, performing operations
such as over the air (OTA) updates.

For more information on Clea check out the [website](https://clea.ai/).

## Table of Contents
1. [Software](#step1)
2. [Hardware](#step2)
3. [Setup](#step3)
4. [Results](#step4)
5. [Support](#step5)
6. [Release Notes](#step6)

## 1. Software<a name="step1"></a>

This demo application is intended to be built using VS Code through the
[MCUXpresso](https://www.nxp.com/design/design-center/software/embedded-software/mcuxpresso-for-visual-studio-code:MCUXPRESSO-VSC)
extension. It furthermore requires the Zephyr developer dependencies for MCUXpresso to be
installed, this can be done through the
[MCUXpresso Installer](https://github.com/nxp-mcuxpresso/vscode-for-mcux/wiki/Dependency-Installation).

The internal dependencies of this application are:
- [Edgehog device for Zephyr](https://github.com/edgehog-device-manager/edgehog-zephyr-device) at
  version **0.8.0**.
- [Astarte device for Zephyr](https://github.com/astarte-platform/astarte-device-sdk-zephyr) at
  version **0.8.0**.
- [Zephyr RTOS](https://github.com/zephyrproject-rtos/zephyr) at version **4.1.0**.

The internal dependencies are going to be automatically installed by MCUXpresso when adding the
sample.

## 2. Hardware<a name="step2"></a>

This demo application is provided for use with the NXP MIMXRT1064-EVK board.
However, the application can be run on a wide range of boards with minimal configuration changes.
The minimum requirements for this application are the following:
- At least 500KB of RAM
- At least 500KB of FLASH storage
- An Ethernet interface
- A device tree alias `die-temp0` for a CPU die temperature sensor.

Additionally, each board should provide a dedicated flash partition for Astarte and one for Edgehog.

## 3. Setup<a name="step3"></a>

### 3.1 Registering the device on Clea

As mentioned above Clea is an IoT software suite, and the device software that makes this sample
is only half of the cake. The other half is the cloud Clea suite where users can manage their
connected devices and install custom applications.
The simplest way to try Clea is by requesting an evalutation account by filling out the registration
form at https://clea.ai/contact. Once the account request is submitted, you will receive the
credentials and access links to the platform via email.

Once you got your evaluation account you can log in to the Clea administration panel using the
credentials provided via email, select the available tenant, and access its dedicated dashboard.
The dashboard provides general information about the tenant, references to the Edgehog
and Astarte components, and links to documentation resources. From this page record the *Astarte API
URL* and the *Astarte Realm*.

Navigate into Astarte section and select the devices section. Click register a new device, generate
a random ID with the provided button and then register the device.
Store the following information for later:
- Device ID
- Device credential secret

### 3.2 Configuring the CPU monitoring application

We will now configure the application so that once flashed to the device it will know how to
authenticate itself to Clea.

The following entries should be modified in the `proj.conf` file of this project to match the
information you collected in the previous step.
```kconfig
CONFIG_ASTARTE_DEVICE_SDK_HOSTNAME="<HOSTNAME>"
CONFIG_ASTARTE_DEVICE_SDK_REALM_NAME="<REALM_NAME>"

CONFIG_ASTARTE_DEVICE_ID="<DEVICE_ID>"
CONFIG_ASTARTE_CREDENTIAL_SECRET="<CREDENTIAL_SECRET>"
```

`<HOSTNAME>` is the Astarte API URL, `<REALM_NAME>` is the Astarte realm name, `<DEVICE_ID>` is the
device ID and `<CREDENTIAL_SECRET>` is the device credential secret obtained during registration.

## 4. Results<a name="step4"></a>

Upon running the code the demo application will display on the serial monitor its progression.
The device will first connect to Clea using the credential secret, once the device is connected it
will appear in the Clea dashboard in both the Astarte and Edgehog sections and the user will be able
to interact with it.
For example, an OTA update can be performed. You will first need to locate the binary generated
during the build process and then trigger the update procedure using the dashboard.

## 5. Support<a name="step5"></a>

For more information about Clea check out the
[Clea documentation](https://docs.clea.ai/), and our projects on
[GitHub](https://github.com/secomind/clea_cpu_monitoring_zephyr).

Questions regarding the content/correctness of this example can be filed as issues within this
GitHub repository.

## 6. Release Notes<a name="step6"></a>
| Version | Description / Update                           | Date                        |
|:-------:|------------------------------------------------|----------------------------:|
| 1.0     | Initial release on Application Code Hub        | March 21<sup>rd</sup> 2025  |

## Licensing

This project is licensed under Apache 2.0 license. Find out more at
[www.apache.org](https://www.apache.org/licenses/LICENSE-2.0.).
