# Clea CPU metrics sample app for i.MX RT1064

This sample application is a simple demo app for the Clea platform on the i.MX RT1064 EVK board.
The sample application connects the board to Clea enabling IoT management and displays a simple
custom application for the Clea platform that collects CPU usage and temperature statistics
and displays them on a web based GUI.

## Setup the workspace

Start by creating a new workspace folder and a venv where `west` will reside.
```sh
mkdir ~/clea_cpu_monitor_zephyrproject && cd ~/clea_cpu_monitor_zephyrproject
python3 -m venv .venv
source .venv/bin/activate
pip install west
```

Initalize the workspace as a Zephyr project.
```sh
west init -m git@github.com:secomind/clea_cpu_monitoring_zephyr --mr master
west update
```

Install the required dependencies
```sh
west zephyr-export
west packages pip --install
```

## Configure the application

The following entries should be modified in the `proj.conf` file.

```kconfig
CONFIG_ASTARTE_DEVICE_SDK_HOSTNAME="<HOSTNAME>"
CONFIG_ASTARTE_DEVICE_SDK_REALM_NAME="<REALM_NAME>"

CONFIG_ASTARTE_DEVICE_ID="<DEVICE_ID>"
CONFIG_ASTARTE_CREDENTIAL_SECRET="<CREDENTIAL_SECRET>"
```

Where `<DEVICE_ID>` is the device ID of the device you would like to use in the sample, `<HOSTNAME>`
is the hostname for your Astarte instance, `<REALM_NAME>` is the name of your testing realm and
`<CREDENTIAL_SECRET>` is the credential secret obtained through the manual registration

## Build and flash the sample

You can now build the sample with the following command:
```sh
west build --sysbuild -p -b mimxrt1064_evk clea_cpu_monitoring_zephyr/app/
```
Then flash it with the command:
```sh
west flash --runner=linkserver
```
