# 🚲 NaKolach (Sightseeing Bike Map)

**NaKolach** is an interactive web application built with GIS functionalities, designed for cycling enthusiasts. It allows users to easily find bike routes and discover interesting Points of Interest (POIs) in their area. Each user has a personal account to save their favorite routes and customize map markers.

### Key project features:

- **Client-Server Architecture:** Complete separation of the React frontend and .NET backend API.
- **Relational Spatial Database:** Persistent storage of user data and bike routes using PostgreSQL with the PostGIS extension.
- **GIS Functionalities:** Advanced tools enabling efficient use of the interactive map component, including radius search and route calculation.
- **Real-world Map Data:** Integration with OpenStreetMap (OSM) and the GraphHopper routing engine for accurate, bike-friendly navigation.
- **Automated Data Ingestion:** Custom initialization scripts that automatically download Poland's OSM dataset and extract the specific target area (Gdańsk region) on the first run, preparing the local spatial database.
- **Reverse Proxy:** HAProxy implementation to securely route and load-balance traffic between the client and internal services.
- **Fully Containerized:** The entire environment (frontend, backend, database, proxy, and map services) is logically separated and orchestrated using Docker and Docker Compose.

## ⚡Interactive Dashboard

ToDo

## 🛠️ Tech Stack

### Infrastructure & Environment

- **Docker & Docker Compose:** Containerization and orchestration of the entire microservices architecture.
- **HAProxy:** Reverse proxy routing traffic securely to internal services and preventing direct external access to the backend/database.

### Back-end

- **C# & ASP.NET Core:** The primary framework used to build the robust RESTful API, handle business logic, and manage user authentication.
- **PostgreSQL & PostGIS:** A powerful relational spatial database used for persistent storage of user profiles and saved routes. It also handles complex geographical queries (e.g., finding POIs within a specific radius) directly from the locally ingested map data.
- **GraphHopper:** A fast, self-hosted routing engine that processes map data to calculate optimal, bike-friendly paths.
- **OpenStreetMap (OSM) Data:** The core real-world map data source (PBF files) processed locally, making the application fully self-contained without relying on external APIs for POI retrieval.

### Front-end

- **React (TypeScript + Vite):** Modern SPA environment and lightning-fast build tool.
- **Leaflet.js:** Lightweight JavaScript library for interactive map rendering and OSM integration.
- **Tailwind CSS:** Utility-first CSS framework for rapid UI development and styling.

## 🚀 How to run

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
```

## ☎️ Authors & Contact

This project was collaboratively created by:

- **Kacper Jankowski** - [GitHub](https://github.com/X3raFin) | [LinkedIn](https://www.linkedin.com/in/kacper-jankowski-webdev/) | [Portfolio](https://kacper-jan-webdev.vercel.app/) | 📧 kacper.jankowski.webdev@gmail.com
- **Jakub Sobota** - [GitHub](https://github.com/Jacko0b) | [LinkedIn](https://www.linkedin.com/in/link-jakuba/)
- **Maciej Bereda** - [GitHub](https://github.com/gl00man) | [LinkedIn](https://www.linkedin.com/in/maciejbereda/)
