# NaKolach Environment

## Setup

After cloning the repository, to setup the environment, do the following steps:

### 1. Submodules

```shell
cd NaKolachEnvironment

git submodule init
git submodule update --remote
```

### 2. DNS override

Then you have to override your local DNS.

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

### 3. CA

Because we use self signed CA certificates with HTTPS redirection you have to generate your own CA.

```shell
cd certs
./generate_certs.sh
```

At last import the ca.crt certificate into your browser.

## Running

Now you are ready to go. To launch the environment use `make up` command. The panel will be availabe under https://nakolach.com address.

### Available make commands:

```
make up # launches the environment
make stop # shut down the environment and keep the containers
make down # shut down the environment and remove the containers
make clean # shut down and clean up the environment
```
