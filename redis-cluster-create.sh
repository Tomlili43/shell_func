# 容器1
docker run -p 6371:6379 -p 16371:16379 --name redis-1 \
-v ~/redis/node-1/data:/data \
-v ~/redis/node-1/conf/redis.conf:/etc/redis/redis.conf \
-d --net redis --ip 172.28.0.11 redis:5.0.9-alpine3.11 redis-server /etc/redis/redis.conf

# 容器2
docker run -p 6372:6379 -p 16372:16379 --name redis-2 \
-v ~/redis/node-2/data:/data \
-v ~/redis/node-2/conf/redis.conf:/etc/redis/redis.conf \
-d --net redis --ip 172.28.0.12 redis:5.0.9-alpine3.11 redis-server /etc/redis/redis.conf

# 容器3
docker run -p 6373:6379 -p 16373:16379 --name redis-3 \
-v ~/redis/node-3/data:/data \
-v ~/redis/node-3/conf/redis.conf:/etc/redis/redis.conf \
-d --net redis --ip 172.28.0.13 redis:5.0.9-alpine3.11 redis-server /etc/redis/redis.conf

# 容器4
docker run -p 6374:6379 -p 16374:16379 --name redis-4 \
-v ~/redis/node-4/data:/data \
-v ~/redis/node-4/conf/redis.conf:/etc/redis/redis.conf \
-d --net redis --ip 172.28.0.14 redis:5.0.9-alpine3.11 redis-server /etc/redis/redis.conf

# 容器5
docker run -p 6375:6379 -p 16375:16379 --name redis-5 \
-v ~/redis/node-5/data:/data \
-v ~/redis/node-5/conf/redis.conf:/etc/redis/redis.conf \
-d --net redis --ip 172.28.0.15 redis:5.0.9-alpine3.11 redis-server /etc/redis/redis.conf

# 容器6
docker run -p 6376:6379 -p 16376:16379 --name redis-6 \
-v ~/redis/node-6/data:/data \
-v ~/redis/node-6/conf/redis.conf:/etc/redis/redis.conf \
-d --net redis --ip 172.28.0.16 redis:5.0.9-alpine3.11 redis-server /etc/redis/redis.conf
