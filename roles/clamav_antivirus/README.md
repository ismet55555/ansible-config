# ClamAV

ClamAV is an open source (GPLv2) anti-virus toolkit, designed especially for e-mail
scanning on mail gateways. It provides a number of utilities including a flexible
and scalable multi-threaded daemon, a command line scanner and advanced tool for
automatic database updates. The core of the package is an anti-virus engine
available in a form of shared library.

**IMPORTANT:** On-Access Scanning is not automatically enabled and must be
configured and enabled seperately with `clamonacc`

## Resources

- <https://docs.clamav.net/>
- <https://aaronbrighton.medium.com/installation-configuration-of-clamav-antivirus-on-ubuntu-18-04-a6416bab3b41>
- <https://blog.clamav.net/2016/03/configuring-on-access-scanning-in-clamav.html>

## Installation

```bash
sudo apt-get update
sudo apt-get install -y \
    clamav \
    clamtk \
    clamav-base \
    clamav-daemon \
    clamav-freshclam
```

## ClamAV Components

### Daemons and Tools

- [`clamav-freshclam` (daemon)](https://docs.clamav.net/manual/Usage/SignatureManagement.html#freshclam)
  - Daemon that periodically checks for virus
    database definition updates, downloads, installs them, and notifies `clamd`
    to refresh it’s in-memory virus database cache.

- [`clamd` (daemon)](https://docs.clamav.net/manual/Usage/Scanning.html#clamd)
  - Daemon that loads the virus database definitions into memory,
    and handles scanning of files when instructed to do so by clients such as
    `clamdscan` or `clamonacc`.

- [`clamdscan`](https://docs.clamav.net/manual/Usage/Scanning.html#clamdscan)
  - Utility that allows you to scan the filesystem and ask
    `clamd` to scan a given set files.

- [`clamonacc` (daemon)](https://docs.clamav.net/manual/Usage/Scanning.html#on-access-scanning)
- Similar to `clamdscan`, but listens for file
  operations and asks clamd to scan files with activity. This daemon
  provides the On-Access Scanning functionality.

- [`clamdtop`](https://docs.clamav.net/manual/Usage/Scanning.html#clamdtop)
  - Resource monitoring interface for `clamd`

- [`clamconf`](https://docs.clamav.net/manual/Usage/Configuration.html#clamconf)
  - Tool ClamAV provides for checking your entire system configuration, as it
    relates to your ClamAV installation. When run, it displays values used when
    configuring ClamAV at compilation time, important OS details, the contents
    (and validity) of both `clamd.conf` and `freshclam.conf`, along with other
    important engine, database, platform, and build information.

- [`clamtk`](https://github.com/dave-theunsub/clamtk)
  - Frontend UI for CLamAV

### Configuration Files

- [`clamd.conf`](https://docs.clamav.net/manual/Usage/Configuration.html#clamdconf)
  - Configuring the behavior of the ClamAV Daemon `clamd` and associated tools
  - Typically, used from template: `clamd.conf.example`
  - Placed: `/etc/clamav/clamd.conf`

- [`freshclam.conf`](https://docs.clamav.net/manual/Usage/Configuration.html#freshclamconf)
  - Configuring the behavior of the signature database update tool, `freshclam`
  - Placed: `/etc/clamav/freshclam.conf`

## Setting up `clamav` Linux User and Group

1. Before install

- ```bash
    # Add group and user
    sudo groupadd clamav
    sudo useradd -g clamav -s /bin/false -c "Clam Antivirus" clamav

    # Ownership of freshclam logs
    sudo touch /var/log/freshclam.log
    sudo chmod 600 /var/log/freshclam.log
    sudo chown clamav /var/log/freshclam.log

    # Set up quarantine directory for clamonacc
    sudo mkdir -p /root/quarantine
    sudo chown root:clamav /root/quarantine
    sudo chmod 750 /root/quarantine

    # For clamonacc give clamav user co-owenership of actively scanned directories
    sudo setfacl -m u:clamav:rx /home
    sudo setfacl -m u:clamav:rx /root
    sudo setfacl -m u:clamav:rx /var/www
    ```

2. After ClamAV Install

- ```bash
    # Ownership for database directory (must exist first)
    sudo chown -R clamav:clamav /usr/local/share/clamav | sudo chown -R clamav:clamav /var/lib/clamav/
    ```

## Testing `clamonacc`

- If daemon service is not running, can run `clamonacc` manually

  - ```bash
    sudo clamonacc \
      --config-file=/etc/clamav/clamd.conf \
      --log=/var/log/clamav/clamonacc.log \
      --move=/root/quarantine
    ```

- Create a [mock virus file](https://www.eicar.org/download-anti-malware-testfile/) in a monitored directory

  - ```bash
    sudo wget -O /home/<USER>/eicar_clamav_testfile.txt https://secure.eicar.org/eicar.com
    sudo wget -O /root/eicar_clamav_testfile.txt https://secure.eicar.org/eicar.com
    ```

- Clamoncc should immediately move the file to `/root/quarantine`

- Check logs

  - ```bash
    sudo tail /var/log/clamav/clamonacc.log
    ```

- If manually started, kill it

  - ```bash
    sudo kill `ps auxf | grep clamonacc | grep -v "grep" | awk '{print $2}'`
    # - or -
    sudo kill -9 $(pgrep clamonacc)
    ```

## Notes

- ClamAV versions: <https://www.clamav.net/downloads>
- Log file: `/var/log/clamav/clamav.log`
- Moves infected files to `/root/quarantine`
- `OnAccessPrevention` may impact performacne
- `/tmp` directory may need to be skipped
- Download virus definitions
- Memory requirements: 1 GB
