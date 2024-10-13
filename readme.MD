# readme

```bash
docker build -t nitra/actions-runner .

docker buildx build --platform=linux/amd64 -t nitra/actions-runner --squash .

docker push nitra/actions-runner
```

ci
