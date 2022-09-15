# Step to walkthrough this lab

1. Provision kind cluster with

    ```bash
    kind create cluster --config=kind.yaml
    ```

2. Create new namespace

    ```bash
    kubectl create ns ingress
    ```

3. Install Nginx controller

    ```bash
    helm upgrade proxy -i -n ingress nginx-stable/nginx-ingress
    ```

4. Create custom application namespace

    ```bash
    kubectl create ns app
    ```

5. Install app

    ```bash
    kubectl -n app apply -f app-deployment.yaml
    ```

6. Test demo app with `cUrl`

    ```bash
    $ curl -vI -XGET http://localhost:30080
    *   Trying 127.0.0.1:30080...
    * Connected to localhost (127.0.0.1) port 30080 (#0)
    > GET / HTTP/1.1
    > Host: localhost:30080
    > User-Agent: curl/7.81.0
    > Accept: */*
    > 
    * Mark bundle as not supporting multiuse
    < HTTP/1.1 200 OK
    HTTP/1.1 200 OK
    < Server: nginx/1.23.0
    Server: nginx/1.23.0
    < Date: Thu, 15 Sep 2022 04:27:32 GMT
    Date: Thu, 15 Sep 2022 04:27:32 GMT
    < Content-Type: text/html
    Content-Type: text/html
    < Content-Length: 1649
    Content-Length: 1649
    < Connection: keep-alive
    Connection: keep-alive

    < 
    * Excess found: excess = 1649 url = / (zero-length body)
    * Connection #0 to host localhost left intact
    ```
