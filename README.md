Dockerized NBMiner https://github.com/NebuTech/NBMiner

Based on CUDA 11.6.2

## Build

```
git clone https://github.com/yurikorolov/nbminer_docker
cd nbminer_docker
docker build --tag=nbminer .    
```

## Example usage (RVN on 2miners pool)

```
docker run -dt \
    --runtime nvidia \
    --name nbminer \
    --publish 8000:8000/tcp \
    --env ALGO="kawpow" \
    --env SERVER="stratum+tcp://rvn.2miners.com:6060" \
    --env USERNAME="RSVSQpK3QDgF3QVc5Q1togocAqD3Zy9FsB" \
    --env PASSWORD="x" \
    --env WORKER_NAME="workername_here" \
    --env API_URL="0.0.0.0" \
    --env API_PORT="8000" \
    --env EXTRA_ARGS="" \
    nbminer
```
