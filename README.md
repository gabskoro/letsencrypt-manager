## Letsencrypt manager

####Features

1. Installing letsencrypt
2. Domain registering
3. [Domain renewal](#3-domain-renewal)

####Install instructions

Copy this script to you server, make it executable

```
chmod +x letsencrypt-manager.sh
```

run it

```
./letsencrypt-manager.sh
```

and follow the instructions.


### 3. Domain renewal

Before renewing a domain you need to add this line of code in your `server` block.

```
location ~ /.well-known {
  allow all;
}
```
