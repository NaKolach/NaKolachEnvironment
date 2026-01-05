# NaKolach Environment

## Setup

After cloning the repository, to setup the environment, do the following steps:

```
cd NaKolachEnvironment

git submodule init
git submodule update --remote
```

Then you have to overrite your local DNS.

### Linux

Modify first line of your `/etc/hosts` file:

```
127.0.0.1	localhost nakolach.com

# rest of your /etc/hosts content...
```

### Windows

You'll need to run Notepad as administrator to edit the hosts file. Once Notepad is open, click on File > Open, and navigate to "C:\Windows\System32\drivers\etc".

Notepad is set to look for TXT files by default, so you'll need to set it to look for "All Files" in the drop-down menu instead. Then, click the hosts file and hit open.

At the end of hosts file add this line:

```
# ... your hosts file content

127.0.0.1 nakolach.com
```

## Running

Now you are ready to go. To launch the environment use `make up` command. The panel will be availabe under http://nakolach.com address.

### Other make commands:

```
make up # launches the environment
make stop # shuts down the environment and keeps the containers
make down # shuts down the environment and removes the containers
```
