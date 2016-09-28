Webcampak 3
=============
[![SensioLabsInsight](https://insight.sensiolabs.com/projects/c9bafa1f-910d-40fa-8b99-030cf1b531c0/mini.png)](https://insight.sensiolabs.com/projects/c9bafa1f-910d-40fa-8b99-030cf1b531c0) [![License: GPL v3](https://img.shields.io/badge/License-GPL%20v3-blue.svg)](http://www.gnu.org/licenses/gpl-3.0)

Webcampak is a set of tools to reliably capture high definition pictures, at pre-defined interval, over a very long period of time and automatically generate timelapse videos. Built to scale and adapt to a variety of use cases, Webcampak will drive a DSLR camera for projects typically ranging from 6 months to years. Failsafe mechanisms are available to ensure no pictures get lost during that time.

## Repository

Webcampak software is broken down in multiple repository corresponding to its main components:

 - [Core](https://github.com/Webcampak/core): Entry-point repository, contains all commons elements and installation scripts.
 - [API](https://github.com/Webcampak/api): Contains the Symfony API used by the User Interface to communicate with the Webcampak.
 - [UI](https://github.com/Webcampak/ui): Contains Sencha Extjs User Interfaces.
 - [CLI](https://github.com/Webcampak/cli): Contains the Python Cement command line interface used to drive Webcampak inner activities. 

## Demo
A demo version of Webcampak is available at [https://demo.webcampak.com](https://demo.webcampak.com)

 - Login: demo
 - Password: omed

## Features
We are constantly adding new features, so the list might not be up-to-date, but should provide a good idea of Webcampak capabilities:

- Image Capture and automated processing
 - Capture JPG and/or RAW
 - Variable capture rate based on hour of the day and/or day of the week
 - Picture manipulation: rotate, crop, zoom, resize, watermark, legend
 - Video formats: H.264, MP4
 - Video effects: crop, zoom, resize, watermark, legend, thumbnail
 - Multi-Camera
 - Email alerts and daily summary
- User Interface
 - Browse pictures & videos
 - Webcampak configuration
 - Per-user and Source Access Control 
 - Access logs
 - Manage fleet of Webcampaks
 - Access reports
 - Launch jobs (video, large picture transfer)
 - Monitor system (logs, statistics, ...)

## Setup

Run the following command from a fresh ubuntu server install and follow instructions
```
bash <(curl -s https://raw.githubusercontent.com/Webcampak/core/master/init/install/install.Ubuntu16.04.sh)
```
After installation connect to your Webcampak's IP via https

## Directory Structure

- apps/: API, UI and CLI.
- i18n/: Language files used for internationalization. Using gettext for the most part.
- install/: Install script(s) and system configuration files
- resources/: Common assets available to all components

During installation, the webcampak will create many more directories, those will not be synced with github as they are specific to each install.

## History
Webcampak project was initiated in 2009, initially as a set of bash scripts to control Canon compact cameras and automatically generate timelapse videos. 
Number of features have been progressively growing with the following major technical differences between versions:

- Webcampapk pre 1.0: Webcampak core in Bash, Simple UI in PHP/Html, then [PHP/Smarty](http://www.smarty.net/) 
- Webcampak 1.0+: Webcampak core in Python, UI in [PHP/Smarty](http://www.smarty.net/)
- Webcampak 2.0+: Webcampak core in Python, PHP API (custom framework) and [Sencha](https://www.sencha.com/) Extjs 4.x/Touch UI
- Webcampak 3.0+: Webcampak core in Python wrapped with [Cement](http://builtoncement.com/), [Symfony](https://symfony.com/Symfony) 3.0 API, [Sencha](https://www.sencha.com/) Extjs 6.0 UI.

### What's next

The next move from a software perpespective will be to conver the API to REST (currently some sort of HTTP-RPC, relying mostly on POST) and likely move away from Extjs in favor of a [more modern Javascript framework](https://www.sencha.com/forum/showthread.php?304118-Is-ExtJS-dying)

## Where to learn more
You can learn more on our website/blog: http://www.webcampak.com

## Documentation
User guides and other end-user documentation is available here: http://docs.webcampak.com

Note that the document has not been yet updated for Webcampak 3

## License
>You can check out the full license [here](https://github.com/Webcampak/v3.0/blob/master/LICENSE)

This project is licensed under the terms of the **GPLv3** license.

Any questions, contact@webcampak.com

