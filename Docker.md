Docker Images for execution of tools

# Dockerfile-volatility
``` shell
docker build -t volatility -f DockerfileVolatility .
```
Run with Images mounted:
``` shell
docker run -it --rm -v ./Linux-Memory-Images/linux:/app/volatility/images volatility  /bin/bash
```

