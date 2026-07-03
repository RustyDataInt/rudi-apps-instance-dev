# RuDI apps server instance setup: developer mode

The [Rusty Data Interface](https://rustydataint.github.io/) (RuDI) 
is a standardized framework for developing and running HPC data 
analysis **pipelines** and interactive visualization **apps**
with a Rust-first mindset.

This repository carries **developer instance setup scripts** that 
initialize a cloud computing instance to run 
[Rust](https://rust-lang.org/)
[Dioxus](https://dioxuslabs.com/) 
for remote RuDI app development.

## Choose an IDE and cloud computing provider

You must create an instance on a cloud provider and access it 
with an IDE, i.e., a code editor. Instructions below use
[Visual Studio Code](https://code.visualstudio.com/) (VS Code)
and
[Amazon Web Services](https://aws.amazon.com/) (AWS).
Other providers are possible, but we may not be able to answer 
questions about them. If you choose other providers, adjust the 
instructions below as needed.

### Install the Rust Analyzer and Dioxus VS Code extensions

From within VS Code, open the Extensions tab, then find and install:
- `Remote - SSH` = for remote connection to your cloud instance
- `rust-analyzer` = general Rust code support
- `Dioxus` = specific additional support for Dioxus apps

## Launch a cloud compute instance

Launch an Ubuntu Linux compute instance, e.g., on AWS:
- Ubuntu 26.04 arm64
- t4g.2xlarge
- 40 Gb gp3

You can stop your developer instance when not using it and connect 
with just the IP address, so choose a well-powered configuration for 
best compiling speed. We often run the initial build with 8 CPUs as 
above, then scale back to 2 CPUs when developing (t4g.large).

You must set up a key to connect to the instance using SSH. You must 
also use a Security Group that gives at least your IP address access 
to ports 22 and 8080.

## Run the instance setup scripts

### Clone this repository

Log into your server instance remotely from your IDE, then clone
this repository:

```bash
cd ~
git clone https://github.com/RustyDataInt/rudi-apps-instance-dev.git
cd rudi-apps-instance-dev
```

### OPTIONAL: Choose a Rust and Dioxus version

The 'config.yml' file in this repository hard codes the Rust 
toolchain and Dioxus versions that will be installed and used.
In general, these will be recent, stable supported versions we 
recommend for a new installation, but you can change them as 
needed before installing. 

```bash
# OPTIONAL
nano config.yml
```

### OPTIONAL: Enter your GitHub credentials to access forked and private repos

If you will edit code in your developer forks of either a tool suite
or the RuDI apps framework, you must enter your GitHub account name:

```bash
# OPTIONAL
export GITHUB_USER=my-account
```

Additionally, if your tool suite repository is private, you must enter your 
[GitHub Personal Access Token](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens).

```bash
# OPTIONAL
export GITHUB_PAT=ghp_...
```

### Install Rust, Dioxus, and RuDI

Run the instance setup script as follows - the installations will  
run for about ten minutes with 8 CPUs (more if you are using an 
underpowered instance).

```bash
./setup.sh
source ~/.bashrc
```

### Install and compile your RuDI tool suite(s)

RuDI apps servers use a multi-suite installation, even if you only 
add one tool suite. Add as many as you need, replacing `<REPO_OWNER>` 
and `<REPO>` with the GitHub owner and name of the definitive repository,
NOT your fork of it. Be aware that each app will use an additional
6+ Gb disk space.

```bash
./add.sh <REPO_OWNER>/<REPO>
```

The script clones the tool suite repository and performs an initial
build of its apps server, which will take under five minutes with 8 CPU.

## Use your development apps server

### Launch the Dioxus apps server

Execute the following to launch your app server in developer mode.
Option `--tool-suite` is only required if you added more than 
one tool suite above; a single suite will be used automatically.

Don't forget the `-d` (`--developer`) flag to the `rudi` command, 
which is required to use `dx serve` to run the app in developer mode.

```bash
rudi -d serve [--tool-suite <REPO>]
```

Your app will do a bit more compiling to ready it for interactive
development, which takes less than a minute.

### Open your apps interface in a browser

Usually, VS Code will open a popup that asks if you want to
`Open in Browser` or `Preview in Editor`. Previewing in the editor 
is desirable as it will open your app web page in a browser 
embedded in VS Code, so you can see your work side-by-side.

Otherwise, open your web browser to <http://127.0.0.1:8080/>, 
or <http://localhost:8080/> (they are the same thing).

If the page doesn't load, you probably need to tell VS Code to
forward port 8080 to localhost. Do this in the Terminal area
by clicking the `PORTS` tab and adding 8080 to the list.

### Watch your code and styles update in the app

Dioxus (and thus RuDI) has outstanding support for "hot reloading",
meaning that you often don't need to re-compile your app to see
changes in the browser.  When needed, hit the `r` key in the 
terminal to force a relatively quick rebuild.

Use the following sites to get help on how to write a RuDI app:
- <https://github.com/RustyDataInt/rudi-suite-template>
- <https://github.com/RustyDataInt/rudi-apps-framework>

### Watch your app log and error messages in the terminal

Your terminal will report many things that happen in the app,
including any log or error messages you build into your code, 
as well as panic messages. Use these to debug your code.

### Finishing up

Hit Ctrl-C in your terminal window to shut down the 
apps server, then commit and push any code changes to GitHub.
