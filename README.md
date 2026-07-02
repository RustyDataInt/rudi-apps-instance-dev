# RuDI Command Line Installer and Interface

The [Rusty Data Interface](https://rustydataint.github.io/) (RuDI) 
is a standardized framework for developing and running HPC data 
analysis **pipelines** and interactive visualization **apps**
with a Rust-first mindset.

This repository carries a **server setup script** that will 
set up a public server instance to run Rust Dioxus for remote
app development for one tool suite from the 
[RuDI Desktop App](https://github.com/RustyDataInt/rudi-desktop-app).

## Launch a remote compute instance

Launch a compute instance on AWS, or another provider of your preference.
The following is a good place to start:
- Ubuntu 26.04
- t3.xlarge
- 30 Gb gp3

You must set up keys to connect to the instance using SSH. 

Note that you can stop the instance when not using it and connect with
just the IP address, so use a well-powered instance.

## Clone and run the configuration script

After logging in to the server instance remotely from your IDE
(e.g., VS Code), clone this repository and run the setup script.
Replace `<OWNER>` and `<REPO>` with the GitHub owner and repository
names for the tool suite you will develop on this instance.

```sh
cd ~
git clone https://github.com/RustyDataInt/rudi-apps-server-dev.git
cd rudi-apps-server-dev
./setup.sh https://github.com/<OWNER>/<REPO>.git
```

## Run your development apps server

Install the 
[RuDI Desktop App](https://github.com/RustyDataInt/rudi-desktop-app)
and follow the instructions it provides to connect to your server instance.
