=== Reverse proxy
_Mario Wegmann_

As the web application consists of the various components described above, a reverse proxy is required to standardize them under one domain. 

==== Selection of the technology

===== Apache and Nginx
*Description:* The best-known reverse proxies are Apache and Nginx. 


*Advantages:* Widely used 


*Disadvantages:* Cumbersome configuration files

===== Caddy
*Description:* Caddy is a reverse proxy from the company ZeroSSL, which is written in Go. 


*Advantages:* In addition to an easy-to-read configuration file, Caddy offers further functions that exceed the tasks of a pure reverse proxy. For example, Caddy enables the automatic application for SSL certificates via ACME providers, an integrated file server and the possibility to reload the configuration file live without having to restart the Caddy service. 


*Disadvantages:* Caddy is not as widespread as Apache or Nginx. 

Caddy was selected for this project because the clearly structured configuration file saves time and reduces errors. 

==== Configuration

All requests to the web application go via port 80 (HTTP) to the caddy reverse proxy. HTTPs is not used in this project as the FPGA is not accessible via a public domain and therefore no signed SSL certificate can be created. The simple configuration consists of two components. Requests starting with the paths `/ws`, `/assignments`, `/logger` and `/upload` are forwarded to port 8080, where the Go backend receives them. The advertising connection between client and server via websocket is therefore located under path `/ws`. All other requests are regarded as file requests. The Caddy file server is used here, which searches for the appropriate files in the system path /var/www. These can include the .HTML, .CSS and .js files that make up the frontend, or the .dbc and .yaml files that are to be loaded by the server. 

The configuration is stored in the standard configuration file `/etc/caddy/Caddyfile` and Caddy is executed as a service in the background. 