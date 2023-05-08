
 
# (Unofficial) zyb0t Docker Container

## Docker Statistics

![docker build status](https://img.shields.io/docker/cloud/build/computeronix/zyb0t?style=plastic)
![docker build type](https://img.shields.io/docker/cloud/automated/computeronix/zyb0t?style=plastic)
![docker build pulls](https://img.shields.io/docker/pulls/computeronix/zyb0t?style=plastic)
![docker build open issues](https://img.shields.io/github/issues/computeronix/docker-zyb0t?style=plastic)
![docker build stars](https://img.shields.io/docker/stars/computeronix/zyb0t?style=plastic)

### Stable Release 
![docker build version by latest stable version](https://img.shields.io/docker/v/computeronix/zyb0t/latest?style=plastic)
![docker build size by latest stable version](https://img.shields.io/docker/image-size/computeronix/zyb0t/latest?style=plastic)  

### Beta Release
![docker build version by latest beta version](https://img.shields.io/docker/v/computeronix/zyb0t/beta?style=plastic)
![docker build size by latest beta version](https://img.shields.io/docker/image-size/computeronix/zyb0t/beta?style=plastic)

## Introduction

The docker container will allow for a zyb0t setup, in less than a minute, allowing full customizations, while providing one with the latest versions, at all times.

### Highlights

Key capabilities of this zyb0t container:

- Auto-builds with the latest stable version of Gunbot, use the tag `:latest`
- Gunbot Betas are supported, use the tag `:beta`
- Always the latest version of zyb0t
- Supports HTTPS by default with the Web GUI
- Multi-platform support ( `amd64` and `arm64` )

# What is zyb0t
zyb0t is an add-on module for Gunbot.

Gunbot is an easy to use, advanced crypto trading bot. You define or select a trading strategy and watch Gunbot trade. Enabling you to get up to hundreds of profitable trades per day, 24/7.

Learn more about Gunbot at https://www.gunbot.com

# Documentation
Review to our wiki style docs for all the latest information on the container at: https://docs.gunthy.trade/

## How to Get Started

### Licensing
zyb0t requires a license. Please contact zy0n to inquire about a license.

Gunbot requires licensing to run and please check out the latest licensing details on the Gunbot Wiki at [Gunbot About Blockchain Licensing](https://wiki.gunthy.org/about/system-requirements/license-info#blockchain-based-license-system).

To acquire a license, please reach out to a [Gunbot Reseller](https://gunthy.org/resellers/) for more information.

### Docker Hub Repo
Access the [Docker Hub](https://hub.docker.com/r/computeronix/zyb0t) to review tags and all the details of the container.

### Quick Start
For the automated, quick start route, with your container tool, simply run
```bash
docker run -d computeronix/zyb0t:latest
```

Once the image is downloaded, it will run and auto-start in usually about one minute or less.

If the port, by default **5000**, is open on the host, go to `https://IPofCONTAINER:5000` (`localhost` could be used if local environment)

> PRO TIP: if this is the first time using Gunbot, or you need assistance setting up the config, open the port and pass-it through the container, then use the Web GUI to set it up. The Gunbot team has done an outstanding job with the Web GUI!  
  
> DO NOT forget to use the persistent data option below if you plan to keep your data

Example with persistent data and port pass-through
```bash
docker run -d -p 5010:5000 -v "/host/directory/to/volume:/mnt/gunbot" computeronix/zyb0t:latest
```
In the above example, Gunbot would be available on `https://IPofCONTAINER:5010` and data would persist on the mounted directory `/host/directory/to/volume`.

## Support

### Need Help with Gunbot?

Check out the Gunbot Wiki to [Learn how to use Gunbot | Gunbot docs (gunthy.org)](https://wiki.gunthy.org/)

>Gunbot Docker (Container) works the same as if it is running on Linux directly

### Want more information on Gunbot Docker?
The detailed documentation on how to use the container, background, future roadmap, etc are all located on the [(Unofficial) Gunbot Docker Container Docs](https://docs.gunthy.trade/) site.

### Need Help or Have Feedback with Gunbot Docker?

 - Join the Telegram Community, ask the Gunbot School for access.
 - Submit issues/feedback/feature requests at the GitHub site, under [issues](https://github.com/computeronix/docker-zyb0t/issues).
 
