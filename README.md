# Python Script Executor
- This service allows you to execute Python scripts securely within a controlled environment, supports numpy and pandas.
- This is deployed on Google Cloud Run and accesible via https://python-executor-e2gi6ai6ra-uc.a.run.app/execute.
- Your Script must send the Post request with body in this pattern `{"script": "def main(): ..."},`

# Setup 
-  docker build -t python-executor .
-  docker run -p 8080:8080 python-executor

### Curl Examples

```
curl --location 'https://python-executor-e2gi6ai6ra-uc.a.run.app/execute' \
--header 'Content-Type: application/json' \
--data '{
    "script": "def main(): return {\"message\": \"Hello, World!\"}"
}'
```

```
numpy 

curl --location 'https://python-executor-e2gi6ai6ra-uc.a.run.app/execute' \
--header 'Content-Type: application/json' \
--data '{
    "script": "def main():\r\n    arr = np.array([1, 2, 3, 4, 5])\r\n    sum_of_elements = int(np.sum(arr)) \r\n    mean_of_elements = float(np.mean(arr))\r\n    return {\r\n        \"array\": arr.tolist(), \r\n        \"sum\": sum_of_elements,\r\n        \"mean\": mean_of_elements\r\n    }"
}'

```

### Useful links
- https://github.com/google/nsjail?tab=readme-ov-file#launching-in-docker
- https://cloud.google.com/run?hl=en#build-applications-or-websites-quickly-on-a-fully-managed-platform