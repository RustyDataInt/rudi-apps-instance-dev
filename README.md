# RuDI apps server instance setup: developer mode

The [Rusty Data Interface](https://rustydataint.github.io/) (RuDI) 
is a standardized framework for developing and running HPC data 
analysis **pipelines** and interactive visualization **apps**
with a Rust-first mindset.

This repository carries a **developer instance setup script** that 
will initialize a cloud computing instance to run Rust Dioxus for remote
RuDI app development from within an IDE.

## Choose an IDE and cloud computing provider

To develop using these tools you will create an instance on a cloud
computing provider and access it with an IDE, i.e., a code editor.

Instructions below assume you will use
[Visual Studio Code](https://code.visualstudio.com/) (VS Code)
to access an instance on
[Amazon Web Services](https://aws.amazon.com/) (AWS).

These choices are not required, but we may not be able to answer 
questions about other resources. If you choose other providers,
adjust the instructions below as needed.

### Install the Rust Analyzer and Dioxus VS Code extensions

From within VS Code, open the Extensions tab, then find and install:
- `Remote - SSH` = for remote connection to your cloud instance
- `rust-analyzer` = general Rust code support
- `Dioxus` = specific additional support for Dioxus apps

## OPTIONAL: Choose a Rust and Dioxus version

The 'config.yml' file in this repository hard codes the
Rust toolchain and Dioxus versions that will be installed and used.
In general, these will be the most recent stable supported versions
that we recommend for a new installation, but you can change them
as needed before installing. 

## Launch a cloud compute instance

Launch an Ubuntu Linux compute instance on AWS or your chosen provider, e.g.:
- Ubuntu 26.04
- t3a.xlarge
- 30 Gb gp3

You must set up a key to connect to the instance using SSH. You must also
use a Security Group that gives at least your IP to ports 22 and 8080.

You can stop your developer instance when not using it and connect 
with just the IP address, so choose a well-powered instance for best
compiling speed.

## Clone this repository and install required code

### Install Rust, Dioxus, and RuDI

Log into your server instance remotely from your IDE, then clone
this repository and run its setup script.

```bash
cd ~
git clone https://github.com/RustyDataInt/rudi-apps-instance-dev.git
cd rudi-apps-instance-dev
./setup.sh
source ~/.bashrc
```

### Install and compile your RuDI tool suite(s)

RuDI apps servers use a multi-suite installation format, even if 
you only add one tool suite. Add as many as you need, replacing
`<OWNER>` and `<REPO>` with the GitHub owner and repository of
each tool suite. 

Note that `<OWNER>` should be _your_ GitHub user name if you want 
to work on your developer fork of the repo, otherwise use the 
owner of the definitive repo.

```bash
./add.sh <OWNER>/<REPO>
```

The script first clones the tool suite repository, then performs
an initial build of its apps server, which will take ~5 min.

## Run your development apps server

Execute the following to launch your app server in developer mode.
Option `--tool-suite` is only required if you added more than 
one tool suite above; a single suite will be used automatically.

```bash
rudi serve --address 0.0.0.0 [--tool-suite <REPO>]
```
