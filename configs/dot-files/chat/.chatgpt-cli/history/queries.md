```bash
❯ sudo systemctl status mongodb.service
× mongodb.service - MongoDB Database Server
     Loaded: loaded (/usr/lib/systemd/system/mongodb.service; disabled; preset: disabled)
     Active: failed (Result: exit-code) since Thu 2023-11-30 14:10:40 CET; 3min 8s ago
   Duration: 28ms
       Docs: https://docs.mongodb.org/manual
    Process: 11832 ExecStart=/usr/bin/mongod --config /etc/mongodb.conf (code=exited, status=14)
   Main PID: 11832 (code=exited, status=14)
        CPU: 27ms

Nov 30 14:10:40 robin systemd[1]: Started MongoDB Database Server.
Nov 30 14:10:40 robin mongod[11832]: {"t":{"$date":"2023-11-30T13:10:40.167Z"},"s":"I",  "c":"CONTROL",  "id":7484500, "ctx":"main","msg":"Environment
variable MONGODB_CONFIG_OVERRIDE_NOFORK == 1, overriding \"processManagement.fork\" to false"}
Nov 30 14:10:40 robin systemd[1]: mongodb.service: Main process exited, code=exited, status=14/n/a
Nov 30 14:10:40 robin systemd[1]: mongodb.service: Failed with result 'exit-code'.
```
```bash
❯ sudo journalctl -u mongodb.service

Nov 30 14:10:33 robin systemd[1]: Started MongoDB Database Server.
Nov 30 14:10:33 robin mongod[11785]: {"t":{"$date":"2023-11-30T13:10:33.312Z"},"s":"I",  "c":"CONTROL",  "id":7484500, "ctx":"main","msg":"Environment
variable MONGODB_CONFIG_OVERRIDE_NOFORK == 1, overriding \"processManagement.fork\" to false"}
Nov 30 14:10:33 robin systemd[1]: mongodb.service: Main process exited, code=exited, status=14/n/a
Nov 30 14:10:33 robin systemd[1]: mongodb.service: Failed with result 'exit-code'.
Nov 30 14:10:40 robin systemd[1]: Started MongoDB Database Server.
Nov 30 14:10:40 robin mongod[11832]: {"t":{"$date":"2023-11-30T13:10:40.167Z"},"s":"I",  "c":"CONTROL",  "id":7484500, "ctx":"main","msg":"Environment
variable MONGODB_CONFIG_OVERRIDE_NOFORK == 1, overriding \"processManagement.fork\" to false"}
Nov 30 14:10:40 robin systemd[1]: mongodb.service: Main process exited, code=exited, status=14/n/a
Nov 30 14:10:40 robin systemd[1]: mongodb.service: Failed with result 'exit-code'.
```
```bash
❯ sudo aura -A mongodb-bin
aura >>= Determining dependencies...
aura >>= AUR Packages:
mongodb-bin
aura >>= Continue? [Y/n] Y
loading packages...
resolving dependencies...
looking for conflicting packages...

Packages (1) mongodb-bin-7.0.3-2

Total Installed Size:  217.08 MiB

:: Proceed with installation? [Y/n] y
(1/1) checking keys in keyring                                                             [#####################################################] 100%
(1/1) checking package integrity                                                           [#####################################################] 100%
(1/1) loading package files                                                                [#####################################################] 100%
(1/1) checking for file conflicts                                                          [#####################################################] 100%
(1/1) checking available disk space                                                        [#####################################################] 100%
:: Processing package changes...
(1/1) installing mongodb-bin                                                               [#####################################################] 100%
Optional dependencies for mongodb-bin
    mongodb-tools: The MongoDB tools provide import, export, and diagnostic capabilities. [installed]
:: Running post-transaction hooks...
(1/5) Creating system user accounts...
(2/5) Reloading system manager configuration...
(3/5) Creating temporary files...
(4/5) Arming ConditionNeedsUpdate...
(5/5) Refreshing PackageKit...
❯ mongod
{"t":{"$date":"2023-11-30T14:25:43.536+01:00"},"s":"I",  "c":"NETWORK",  "id":4915701, "ctx":"main","msg":"Initialized wire specification","attr":{"spe
c":{"incomingExternalClient":{"minWireVersion":0,"maxWireVersion":21},"incomingInternalClient":{"minWireVersion":0,"maxWireVersion":21},"outgoing":{"mi
nWireVersion":6,"maxWireVersion":21},"isInternalClient":true}}}
{"t":{"$date":"2023-11-30T14:25:43.538+01:00"},"s":"I",  "c":"CONTROL",  "id":23285,   "ctx":"main","msg":"Automatically disabling TLS 1.0, to force-en
able TLS 1.0 specify --sslDisabledProtocols 'none'"}
{"t":{"$date":"2023-11-30T14:25:43.538+01:00"},"s":"I",  "c":"NETWORK",  "id":4648601, "ctx":"main","msg":"Implicit TCP FastOpen unavailable. If TCP Fa
stOpen is required, set tcpFastOpenServer, tcpFastOpenClient, and tcpFastOpenQueueSize."}
{"t":{"$date":"2023-11-30T14:25:43.539+01:00"},"s":"I",  "c":"REPL",     "id":5123008, "ctx":"main","msg":"Successfully registered PrimaryOnlyService",
"attr":{"service":"TenantMigrationDonorService","namespace":"config.tenantMigrationDonors"}}
{"t":{"$date":"2023-11-30T14:25:43.539+01:00"},"s":"I",  "c":"REPL",     "id":5123008, "ctx":"main","msg":"Successfully registered PrimaryOnlyService",
"attr":{"service":"TenantMigrationRecipientService","namespace":"config.tenantMigrationRecipients"}}
{"t":{"$date":"2023-11-30T14:25:43.539+01:00"},"s":"I",  "c":"CONTROL",  "id":5945603, "ctx":"main","msg":"Multi threading initialized"}
{"t":{"$date":"2023-11-30T14:25:43.539+01:00"},"s":"I",  "c":"TENANT_M", "id":7091600, "ctx":"main","msg":"Starting TenantMigrationAccessBlockerRegistr
y"}
{"t":{"$date":"2023-11-30T14:25:43.539+01:00"},"s":"I",  "c":"CONTROL",  "id":4615611, "ctx":"initandlisten","msg":"MongoDB starting","attr":{"pid":211
58,"port":27017,"dbPath":"/data/db","architecture":"64-bit","host":"robin"}}
{"t":{"$date":"2023-11-30T14:25:43.539+01:00"},"s":"I",  "c":"CONTROL",  "id":23403,   "ctx":"initandlisten","msg":"Build Info","attr":{"buildInfo":{"v
ersion":"7.0.3","gitVersion":"b96efb7e0cf6134d5938de8a94c37cec3f22cff4","openSSLVersion":"OpenSSL 1.1.1w  11 Sep 2023","modules":[],"allocator":"tcmall
oc","environment":{"distmod":"ubuntu2004","distarch":"x86_64","target_arch":"x86_64"}}}}
{"t":{"$date":"2023-11-30T14:25:43.539+01:00"},"s":"I",  "c":"CONTROL",  "id":51765,   "ctx":"initandlisten","msg":"Operating System","attr":{"os":{"na
me":"NAME=\"Arch Linux\"","version":"Kernel 6.6.3-arch1-1"}}}
{"t":{"$date":"2023-11-30T14:25:43.539+01:00"},"s":"I",  "c":"CONTROL",  "id":21951,   "ctx":"initandlisten","msg":"Options set by command line","attr"
:{"options":{}}}
{"t":{"$date":"2023-11-30T14:25:43.539+01:00"},"s":"E",  "c":"CONTROL",  "id":20557,   "ctx":"initandlisten","msg":"DBException in initAndListen, termi
nating","attr":{"error":"NonExistentPath: Data directory /data/db not found. Create the missing directory or specify another path using (1) the --dbpat
h command line option, or (2) by adding the 'storage.dbPath' option in the configuration file."}}
{"t":{"$date":"2023-11-30T14:25:43.539+01:00"},"s":"I",  "c":"REPL",     "id":4784900, "ctx":"initandlisten","msg":"Stepping down the ReplicationCoordi
nator for shutdown","attr":{"waitTimeMillis":15000}}
{"t":{"$date":"2023-11-30T14:25:43.540+01:00"},"s":"I",  "c":"REPL",     "id":4794602, "ctx":"initandlisten","msg":"Attempting to enter quiesce mode"}
{"t":{"$date":"2023-11-30T14:25:43.540+01:00"},"s":"I",  "c":"-",        "id":6371601, "ctx":"initandlisten","msg":"Shutting down the FLE Crud thread p
ool"}
{"t":{"$date":"2023-11-30T14:25:43.540+01:00"},"s":"I",  "c":"COMMAND",  "id":4784901, "ctx":"initandlisten","msg":"Shutting down the MirrorMaestro"}
{"t":{"$date":"2023-11-30T14:25:43.540+01:00"},"s":"I",  "c":"SHARDING", "id":4784902, "ctx":"initandlisten","msg":"Shutting down the WaitForMajoritySe
rvice"}
{"t":{"$date":"2023-11-30T14:25:43.540+01:00"},"s":"I",  "c":"NETWORK",  "id":20562,   "ctx":"initandlisten","msg":"Shutdown: going to close listening
sockets"}
{"t":{"$date":"2023-11-30T14:25:43.540+01:00"},"s":"I",  "c":"NETWORK",  "id":4784905, "ctx":"initandlisten","msg":"Shutting down the global connection
 pool"}
{"t":{"$date":"2023-11-30T14:25:43.540+01:00"},"s":"I",  "c":"CONTROL",  "id":4784906, "ctx":"initandlisten","msg":"Shutting down the FlowControlTicket
holder"}
{"t":{"$date":"2023-11-30T14:25:43.540+01:00"},"s":"I",  "c":"-",        "id":20520,   "ctx":"initandlisten","msg":"Stopping further Flow Control ticke
t acquisitions."}
{"t":{"$date":"2023-11-30T14:25:43.540+01:00"},"s":"I",  "c":"NETWORK",  "id":4784918, "ctx":"initandlisten","msg":"Shutting down the ReplicaSetMonitor
"}
{"t":{"$date":"2023-11-30T14:25:43.540+01:00"},"s":"I",  "c":"SHARDING", "id":4784921, "ctx":"initandlisten","msg":"Shutting down the MigrationUtilExec
utor"}
{"t":{"$date":"2023-11-30T14:25:43.540+01:00"},"s":"I",  "c":"ASIO",     "id":22582,   "ctx":"MigrationUtil-TaskExecutor","msg":"Killing all outstandin
g egress activity."}
{"t":{"$date":"2023-11-30T14:25:43.540+01:00"},"s":"I",  "c":"COMMAND",  "id":4784923, "ctx":"initandlisten","msg":"Shutting down the ServiceEntryPoint
"}
{"t":{"$date":"2023-11-30T14:25:43.540+01:00"},"s":"I",  "c":"CONTROL",  "id":4784928, "ctx":"initandlisten","msg":"Shutting down the TTL monitor"}
{"t":{"$date":"2023-11-30T14:25:43.540+01:00"},"s":"I",  "c":"CONTROL",  "id":6278511, "ctx":"initandlisten","msg":"Shutting down the Change Stream Exp
ired Pre-images Remover"}
{"t":{"$date":"2023-11-30T14:25:43.540+01:00"},"s":"I",  "c":"CONTROL",  "id":4784929, "ctx":"initandlisten","msg":"Acquiring the global lock for shutd
own"}
{"t":{"$date":"2023-11-30T14:25:43.540+01:00"},"s":"I",  "c":"-",        "id":4784931, "ctx":"initandlisten","msg":"Dropping the scope cache for shutdo
wn"}
{"t":{"$date":"2023-11-30T14:25:43.540+01:00"},"s":"I",  "c":"CONTROL",  "id":20565,   "ctx":"initandlisten","msg":"Now exiting"}
{"t":{"$date":"2023-11-30T14:25:43.540+01:00"},"s":"I",  "c":"CONTROL",  "id":23138,   "ctx":"initandlisten","msg":"Shutting down","attr":{"exitCode":1
00}}
```
This works !

```bash
sudo mongod --dbpath /var/lib/mongodb
```

Now, since I've installed the -bin version, I would need to fix the systemctl service to
read from `/etc/mongodb.conf` or at least to use `/var/lib/mongodb` as db path.

<!-- include: /usr/lib/systemd/system/mongodb.service -->
Now I'm more confused, since it's al ready there....

You can see the configuration specifies dbpath already....

<!-- include: /usr/lib/systemd/system/mongodb.service -->

<!-- include: /etc/mongodb.conf -->
```
❯ sudo systemctl restart mongodb.service
❯ sudo tail -n 50 /var/log/mongodb/mongod.log
{"t":{"$date":"2023-11-30T14:10:33.336+01:00"},"s":"F",  "c":"ASSERT",   "id":23091,   "ctx":"initandlisten","msg":"Fatal assertion","attr":{"msgid":40
486,"file":"src/mongo/transport/asio/asio_transport_layer.cpp","line":1202}}
{"t":{"$date":"2023-11-30T14:10:33.336+01:00"},"s":"F",  "c":"ASSERT",   "id":23092,   "ctx":"initandlisten","msg":"\n\n***aborting after fassert() fai
lure\n\n"}

{"t":{"$date":"2023-11-30T14:10:40.167+01:00"},"s":"I",  "c":"CONTROL",  "id":20698,   "ctx":"main","msg":"***** SERVER RESTARTED *****"}
{"t":{"$date":"2023-11-30T14:10:40.168+01:00"},"s":"I",  "c":"NETWORK",  "id":4915701, "ctx":"main","msg":"Initialized wire specification","attr":{"spe
c":{"incomingExternalClient":{"minWireVersion":0,"maxWireVersion":21},"incomingInternalClient":{"minWireVersion":0,"maxWireVersion":21},"outgoing":{"mi
nWireVersion":6,"maxWireVersion":21},"isInternalClient":true}}}
{"t":{"$date":"2023-11-30T14:10:40.168+01:00"},"s":"I",  "c":"CONTROL",  "id":23285,   "ctx":"main","msg":"Automatically disabling TLS 1.0, to force-en
able TLS 1.0 specify --sslDisabledProtocols 'none'"}
{"t":{"$date":"2023-11-30T14:10:40.169+01:00"},"s":"I",  "c":"NETWORK",  "id":4648601, "ctx":"main","msg":"Implicit TCP FastOpen unavailable. If TCP Fa
stOpen is required, set tcpFastOpenServer, tcpFastOpenClient, and tcpFastOpenQueueSize."}
{"t":{"$date":"2023-11-30T14:10:40.173+01:00"},"s":"I",  "c":"REPL",     "id":5123008, "ctx":"main","msg":"Successfully registered PrimaryOnlyService",
"attr":{"service":"TenantMigrationDonorService","namespace":"config.tenantMigrationDonors"}}
{"t":{"$date":"2023-11-30T14:10:40.173+01:00"},"s":"I",  "c":"REPL",     "id":5123008, "ctx":"main","msg":"Successfully registered PrimaryOnlyService",
"attr":{"service":"TenantMigrationRecipientService","namespace":"config.tenantMigrationRecipients"}}
{"t":{"$date":"2023-11-30T14:10:40.173+01:00"},"s":"I",  "c":"CONTROL",  "id":5945603, "ctx":"main","msg":"Multi threading initialized"}
{"t":{"$date":"2023-11-30T14:10:40.173+01:00"},"s":"I",  "c":"TENANT_M", "id":7091600, "ctx":"main","msg":"Starting TenantMigrationAccessBlockerRegistr
y"}
{"t":{"$date":"2023-11-30T14:10:40.173+01:00"},"s":"I",  "c":"CONTROL",  "id":4615611, "ctx":"initandlisten","msg":"MongoDB starting","attr":{"pid":118
32,"port":27017,"dbPath":"/var/lib/mongodb","architecture":"64-bit","host":"robin"}}
{"t":{"$date":"2023-11-30T14:10:40.173+01:00"},"s":"I",  "c":"CONTROL",  "id":23403,   "ctx":"initandlisten","msg":"Build Info","attr":{"buildInfo":{"v
ersion":"7.0.3","gitVersion":"b96efb7e0cf6134d5938de8a94c37cec3f22cff4","openSSLVersion":"OpenSSL 1.1.1w  11 Sep 2023","modules":[],"allocator":"tcmall
oc","environment":{"distmod":"ubuntu2004","distarch":"x86_64","target_arch":"x86_64"}}}}
{"t":{"$date":"2023-11-30T14:10:40.173+01:00"},"s":"I",  "c":"CONTROL",  "id":51765,   "ctx":"initandlisten","msg":"Operating System","attr":{"os":{"na
me":"NAME=\"Arch Linux\"","version":"Kernel 6.6.3-arch1-1"}}}
{"t":{"$date":"2023-11-30T14:10:40.173+01:00"},"s":"I",  "c":"CONTROL",  "id":21951,   "ctx":"initandlisten","msg":"Options set by command line","attr"
:{"options":{"config":"/etc/mongodb.conf","net":{"bindIp":"127.0.0.1","port":27017},"processManagement":{"timeZoneInfo":"/usr/share/zoneinfo"},"storage
":{"dbPath":"/var/lib/mongodb"},"systemLog":{"destination":"file","logAppend":true,"path":"/var/log/mongodb/mongod.log"}}}}
{"t":{"$date":"2023-11-30T14:10:40.173+01:00"},"s":"E",  "c":"NETWORK",  "id":23024,   "ctx":"initandlisten","msg":"Failed to unlink socket file","attr
":{"path":"/tmp/mongodb-27017.sock","error":"Operation not permitted"}}
{"t":{"$date":"2023-11-30T14:10:40.173+01:00"},"s":"F",  "c":"ASSERT",   "id":23091,   "ctx":"initandlisten","msg":"Fatal assertion","attr":{"msgid":40
486,"file":"src/mongo/transport/asio/asio_transport_layer.cpp","line":1202}}
{"t":{"$date":"2023-11-30T14:10:40.173+01:00"},"s":"F",  "c":"ASSERT",   "id":23092,   "ctx":"initandlisten","msg":"\n\n***aborting after fassert() fai
lure\n\n"}

{"t":{"$date":"2023-11-30T14:24:58.788+01:00"},"s":"I",  "c":"CONTROL",  "id":20698,   "ctx":"main","msg":"***** SERVER RESTARTED *****"}
{"t":{"$date":"2023-11-30T14:24:58.791+01:00"},"s":"I",  "c":"CONTROL",  "id":23285,   "ctx":"main","msg":"Automatically disabling TLS 1.0, to force-en
able TLS 1.0 specify --sslDisabledProtocols 'none'"}
{"t":{"$date":"2023-11-30T14:24:58.791+01:00"},"s":"I",  "c":"NETWORK",  "id":4915701, "ctx":"main","msg":"Initialized wire specification","attr":{"spe
c":{"incomingExternalClient":{"minWireVersion":0,"maxWireVersion":21},"incomingInternalClient":{"minWireVersion":0,"maxWireVersion":21},"outgoing":{"mi
nWireVersion":6,"maxWireVersion":21},"isInternalClient":true}}}
{"t":{"$date":"2023-11-30T14:24:58.791+01:00"},"s":"I",  "c":"NETWORK",  "id":4648601, "ctx":"main","msg":"Implicit TCP FastOpen unavailable. If TCP Fa
stOpen is required, set tcpFastOpenServer, tcpFastOpenClient, and tcpFastOpenQueueSize."}
{"t":{"$date":"2023-11-30T14:24:58.796+01:00"},"s":"I",  "c":"REPL",     "id":5123008, "ctx":"main","msg":"Successfully registered PrimaryOnlyService",
"attr":{"service":"TenantMigrationDonorService","namespace":"config.tenantMigrationDonors"}}
{"t":{"$date":"2023-11-30T14:24:58.796+01:00"},"s":"I",  "c":"REPL",     "id":5123008, "ctx":"main","msg":"Successfully registered PrimaryOnlyService",
"attr":{"service":"TenantMigrationRecipientService","namespace":"config.tenantMigrationRecipients"}}
{"t":{"$date":"2023-11-30T14:24:58.796+01:00"},"s":"I",  "c":"CONTROL",  "id":5945603, "ctx":"main","msg":"Multi threading initialized"}
{"t":{"$date":"2023-11-30T14:24:58.796+01:00"},"s":"I",  "c":"TENANT_M", "id":7091600, "ctx":"main","msg":"Starting TenantMigrationAccessBlockerRegistr
y"}
{"t":{"$date":"2023-11-30T14:24:58.796+01:00"},"s":"I",  "c":"CONTROL",  "id":4615611, "ctx":"initandlisten","msg":"MongoDB starting","attr":{"pid":206
73,"port":27017,"dbPath":"/var/lib/mongodb","architecture":"64-bit","host":"robin"}}
{"t":{"$date":"2023-11-30T14:24:58.796+01:00"},"s":"I",  "c":"CONTROL",  "id":23403,   "ctx":"initandlisten","msg":"Build Info","attr":{"buildInfo":{"v
ersion":"7.0.3","gitVersion":"b96efb7e0cf6134d5938de8a94c37cec3f22cff4","openSSLVersion":"OpenSSL 1.1.1w  11 Sep 2023","modules":[],"allocator":"tcmall
oc","environment":{"distmod":"ubuntu2004","distarch":"x86_64","target_arch":"x86_64"}}}}
{"t":{"$date":"2023-11-30T14:24:58.796+01:00"},"s":"I",  "c":"CONTROL",  "id":51765,   "ctx":"initandlisten","msg":"Operating System","attr":{"os":{"na
me":"NAME=\"Arch Linux\"","version":"Kernel 6.6.3-arch1-1"}}}
{"t":{"$date":"2023-11-30T14:24:58.796+01:00"},"s":"I",  "c":"CONTROL",  "id":21951,   "ctx":"initandlisten","msg":"Options set by command line","attr"
:{"options":{"config":"/etc/mongodb.conf","net":{"bindIp":"127.0.0.1","port":27017},"processManagement":{"timeZoneInfo":"/usr/share/zoneinfo"},"storage
":{"dbPath":"/var/lib/mongodb"},"systemLog":{"destination":"file","logAppend":true,"path":"/var/log/mongodb/mongod.log"}}}}
{"t":{"$date":"2023-11-30T14:24:58.797+01:00"},"s":"E",  "c":"NETWORK",  "id":23024,   "ctx":"initandlisten","msg":"Failed to unlink socket file","attr
":{"path":"/tmp/mongodb-27017.sock","error":"Operation not permitted"}}
{"t":{"$date":"2023-11-30T14:24:58.797+01:00"},"s":"F",  "c":"ASSERT",   "id":23091,   "ctx":"initandlisten","msg":"Fatal assertion","attr":{"msgid":40
486,"file":"src/mongo/transport/asio/asio_transport_layer.cpp","line":1202}}
{"t":{"$date":"2023-11-30T14:24:58.797+01:00"},"s":"F",  "c":"ASSERT",   "id":23092,   "ctx":"initandlisten","msg":"\n\n***aborting after fassert() fai
lure\n\n"}

{"t":{"$date":"2023-11-30T14:39:16.003+01:00"},"s":"I",  "c":"CONTROL",  "id":20698,   "ctx":"main","msg":"***** SERVER RESTARTED *****"}
{"t":{"$date":"2023-11-30T14:39:16.004+01:00"},"s":"I",  "c":"NETWORK",  "id":4915701, "ctx":"main","msg":"Initialized wire specification","attr":{"spe
c":{"incomingExternalClient":{"minWireVersion":0,"maxWireVersion":21},"incomingInternalClient":{"minWireVersion":0,"maxWireVersion":21},"outgoing":{"mi
nWireVersion":6,"maxWireVersion":21},"isInternalClient":true}}}
{"t":{"$date":"2023-11-30T14:39:16.005+01:00"},"s":"I",  "c":"CONTROL",  "id":23285,   "ctx":"main","msg":"Automatically disabling TLS 1.0, to force-en
able TLS 1.0 specify --sslDisabledProtocols 'none'"}
{"t":{"$date":"2023-11-30T14:39:16.005+01:00"},"s":"I",  "c":"NETWORK",  "id":4648601, "ctx":"main","msg":"Implicit TCP FastOpen unavailable. If TCP Fa
stOpen is required, set tcpFastOpenServer, tcpFastOpenClient, and tcpFastOpenQueueSize."}
{"t":{"$date":"2023-11-30T14:39:16.009+01:00"},"s":"I",  "c":"REPL",     "id":5123008, "ctx":"main","msg":"Successfully registered PrimaryOnlyService",
"attr":{"service":"TenantMigrationDonorService","namespace":"config.tenantMigrationDonors"}}
{"t":{"$date":"2023-11-30T14:39:16.009+01:00"},"s":"I",  "c":"REPL",     "id":5123008, "ctx":"main","msg":"Successfully registered PrimaryOnlyService",
"attr":{"service":"TenantMigrationRecipientService","namespace":"config.tenantMigrationRecipients"}}
{"t":{"$date":"2023-11-30T14:39:16.009+01:00"},"s":"I",  "c":"CONTROL",  "id":5945603, "ctx":"main","msg":"Multi threading initialized"}
{"t":{"$date":"2023-11-30T14:39:16.009+01:00"},"s":"I",  "c":"TENANT_M", "id":7091600, "ctx":"main","msg":"Starting TenantMigrationAccessBlockerRegistr
y"}
{"t":{"$date":"2023-11-30T14:39:16.009+01:00"},"s":"I",  "c":"CONTROL",  "id":4615611, "ctx":"initandlisten","msg":"MongoDB starting","attr":{"pid":307
27,"port":27017,"dbPath":"/var/lib/mongodb","architecture":"64-bit","host":"robin"}}
{"t":{"$date":"2023-11-30T14:39:16.009+01:00"},"s":"I",  "c":"CONTROL",  "id":23403,   "ctx":"initandlisten","msg":"Build Info","attr":{"buildInfo":{"v
ersion":"7.0.3","gitVersion":"b96efb7e0cf6134d5938de8a94c37cec3f22cff4","openSSLVersion":"OpenSSL 1.1.1w  11 Sep 2023","modules":[],"allocator":"tcmall
oc","environment":{"distmod":"ubuntu2004","distarch":"x86_64","target_arch":"x86_64"}}}}
{"t":{"$date":"2023-11-30T14:39:16.009+01:00"},"s":"I",  "c":"CONTROL",  "id":51765,   "ctx":"initandlisten","msg":"Operating System","attr":{"os":{"na
me":"NAME=\"Arch Linux\"","version":"Kernel 6.6.3-arch1-1"}}}
{"t":{"$date":"2023-11-30T14:39:16.009+01:00"},"s":"I",  "c":"CONTROL",  "id":21951,   "ctx":"initandlisten","msg":"Options set by command line","attr"
:{"options":{"config":"/etc/mongodb.conf","net":{"bindIp":"127.0.0.1","port":27017},"processManagement":{"timeZoneInfo":"/usr/share/zoneinfo"},"storage
":{"dbPath":"/var/lib/mongodb"},"systemLog":{"destination":"file","logAppend":true,"path":"/var/log/mongodb/mongod.log"}}}}
{"t":{"$date":"2023-11-30T14:39:16.010+01:00"},"s":"F",  "c":"STORAGE",  "id":28661,   "ctx":"initandlisten","msg":"Unable to read the storage engine m
etadata file","attr":{"error":{"code":38,"codeName":"FileNotOpen","errmsg":"Failed to read metadata from /var/lib/mongodb/storage.bson"}}}
{"t":{"$date":"2023-11-30T14:39:16.010+01:00"},"s":"F",  "c":"ASSERT",   "id":23091,   "ctx":"initandlisten","msg":"Fatal assertion","attr":{"msgid":28
661,"file":"src/mongo/db/storage/storage_engine_metadata.cpp","line":90}}
{"t":{"$date":"2023-11-30T14:39:16.010+01:00"},"s":"F",  "c":"ASSERT",   "id":23092,   "ctx":"initandlisten","msg":"\n\n***aborting after fassert() fai
lure\n\n"}
❯ sudo systemctl status mongodb.service
× mongodb.service - MongoDB Database Server
Loaded: loaded (/usr/lib/systemd/system/mongodb.service; disabled; preset: disabled)
Active: failed (Result: exit-code) since Thu 2023-11-30 14:39:16 CET; 7s ago
Duration: 30ms
Docs: https://docs.mongodb.org/manual
Process: 30727 ExecStart=/usr/bin/mongod --config /etc/mongodb.conf (code=exited, status=14)
Main PID: 30727 (code=exited, status=14)
CPU: 29ms

Nov 30 14:39:15 robin systemd[1]: Started MongoDB Database Server.
Nov 30 14:39:16 robin mongod[30727]: {"t":{"$date":"2023-11-30T13:39:16.003Z"},"s":"I",  "c":"CONTROL",  "id":7484500, "ctx":"main","msg":"Environment
variable MONGODB_CONFIG_OVERRIDE_NOFORK == 1, overriding \"processManagement.fork\" to false"}
Nov 30 14:39:16 robin systemd[1]: mongodb.service: Main process exited, code=exited, status=14/n/a
Nov 30 14:39:16 robin systemd[1]: mongodb.service: Failed with result 'exit-code'.
```
How to make KDE wallet have no password ?
❯ sudo aura -A spotify
aura >>= Determining dependencies...
aura >>= AUR Packages:
spotify
aura >>= Continue? [Y/n] Y
aura >>= Building spotify...
aura >>= Building failed. Would you like to see the error? [Y/n] Y
% Total % Received % Xferd Average Speed Time Time Time Current
Dload Upload Total Spent Left Speed
100 126M 100 126M 0 0 67.0M 0 0:00:01 0:00:01 --:--:-- 67.0M
% Total % Received % Xferd Average Speed Time Time Time Current
Dload Upload Total Spent Left Speed
100 2447 100 2447 0 0 22137 0 --:--:-- --:--:-- --:--:-- 22245
% Total % Received % Xferd Average Speed Time Time Time Current
Dload Upload Total Spent Left Speed
100 833 100 833 0 0 4093 0 --:--:-- --:--:-- --:--:-- 4103
% Total % Received % Xferd Average Speed Time Time Time Current
Dload Upload Total Spent Left Speed
100 1253 100 1253 0 0 22478 0 --:--:-- --:--:-- --:--:-- 22781
spotify-1.2.25.1011-g0348b2ea-x86_64.deb ... Passed
spotify.sh ... Passed
spotify.protocol ... Passed
LICENSE ... Passed
spotify-1.2.25.1011-1-Release ... Skipped
spotify-1.2.25.1011-1-Release.sig ... Skipped
spotify-1.2.25.1011-1-x86_64-Packages ... Skipped
spotify-1.2.25.1011-1-Release ... FAILED (unknown public key 7A3A762FAFD4A51F)
==> ERROR: One or more PGP signatures could not be verified!

aura >>= There was a makepkg failure.
How to tell my `mongod` installe from aur in arch linux to see what file is using as config?
❯ ps -aux | grep mongo
aemonge 12659 0.0 0.0 6272 1920 pts/10 S+ 17:20 0:00 grep mongo
❯ mongod --dbpath /home/database
{"t":{"$date":"2023-11-30T17:20:51.631+01:00"},"s":"I",  "c":"CONTROL",  "id":23285,   "
ctx":"main","msg":"Automatically disabling TLS 1.0, to force-enable TLS 1.0 specify --ss
lDisabledProtocols 'none'"}
{"t":{"$date":"2023-11-30T17:20:51.632+01:00"},"s":"I", "c":"NETWORK", "id":4915701, "
ctx":"main","msg":"Initialized wire specification","attr":{"spec":{"incomingExternalClie
nt":{"minWireVersion":0,"maxWireVersion":21},"incomingInternalClient":{"minWireVersion":
0,"maxWireVersion":21},"outgoing":{"minWireVersion":6,"maxWireVersion":21},"isInternalCl
ient":true}}}
{"t":{"$date":"2023-11-30T17:20:51.633+01:00"},"s":"I",  "c":"NETWORK",  "id":4648601, "
ctx":"main","msg":"Implicit TCP FastOpen unavailable. If TCP FastOpen is required, set t
cpFastOpenServer, tcpFastOpenClient, and tcpFastOpenQueueSize."}
{"t":{"$date":"2023-11-30T17:20:51.634+01:00"},"s":"I", "c":"REPL", "id":5123008, "
ctx":"main","msg":"Successfully registered PrimaryOnlyService","attr":{"service":"Tenant
MigrationDonorService","namespace":"config.tenantMigrationDonors"}}
{"t":{"$date":"2023-11-30T17:20:51.634+01:00"},"s":"I",  "c":"REPL",     "id":5123008, "
ctx":"main","msg":"Successfully registered PrimaryOnlyService","attr":{"service":"Tenant
MigrationRecipientService","namespace":"config.tenantMigrationRecipients"}}
{"t":{"$date":"2023-11-30T17:20:51.634+01:00"},"s":"I", "c":"CONTROL", "id":5945603, "
ctx":"main","msg":"Multi threading initialized"}
{"t":{"$date":"2023-11-30T17:20:51.634+01:00"},"s":"I",  "c":"TENANT_M", "id":7091600, "
ctx":"main","msg":"Starting TenantMigrationAccessBlockerRegistry"}
{"t":{"$date":"2023-11-30T17:20:51.634+01:00"},"s":"I", "c":"CONTROL", "id":4615611, "
ctx":"initandlisten","msg":"MongoDB starting","attr":{"pid":12665,"port":27017,"dbPath":
"/home/database","architecture":"64-bit","host":"robin"}}
{"t":{"$date":"2023-11-30T17:20:51.634+01:00"},"s":"I",  "c":"CONTROL",  "id":23403,   "
ctx":"initandlisten","msg":"Build Info","attr":{"buildInfo":{"version":"7.0.3","gitVersi
on":"b96efb7e0cf6134d5938de8a94c37cec3f22cff4","openSSLVersion":"OpenSSL 1.1.1w  11 Sep
2023","modules":[],"allocator":"tcmalloc","environment":{"distmod":"ubuntu2004","distarc
h":"x86_64","target_arch":"x86_64"}}}}
{"t":{"$date":"2023-11-30T17:20:51.634+01:00"},"s":"I", "c":"CONTROL", "id":51765, "
ctx":"initandlisten","msg":"Operating System","attr":{"os":{"name":"NAME=\"Arch Linux\""
,"version":"Kernel 6.6.3-arch1-1"}}}
{"t":{"$date":"2023-11-30T17:20:51.634+01:00"},"s":"I",  "c":"CONTROL",  "id":21951,   "
ctx":"initandlisten","msg":"Options set by command line","attr":{"options":{"storage":{"
dbPath":"/home/database"}}}}
{"t":{"$date":"2023-11-30T17:20:51.635+01:00"},"s":"E", "c":"CONTROL", "id":20557, "
ctx":"initandlisten","msg":"DBException in initAndListen, terminating","attr":{"error":"
Location28596: Unable to determine status of lock file in the data directory /home/datab
ase: boost::filesystem::status: Permission denied [system:13]: \"/home/database/mongod.l
ock\""}}
{"t":{"$date":"2023-11-30T17:20:51.635+01:00"},"s":"I",  "c":"REPL",     "id":4784900, "
ctx":"initandlisten","msg":"Stepping down the ReplicationCoordinator for shutdown","attr
":{"waitTimeMillis":15000}}
{"t":{"$date":"2023-11-30T17:20:51.635+01:00"},"s":"I", "c":"REPL", "id":4794602, "
ctx":"initandlisten","msg":"Attempting to enter quiesce mode"}
{"t":{"$date":"2023-11-30T17:20:51.635+01:00"},"s":"I",  "c":"-",        "id":6371601, "
ctx":"initandlisten","msg":"Shutting down the FLE Crud thread pool"}
{"t":{"$date":"2023-11-30T17:20:51.635+01:00"},"s":"I", "c":"COMMAND", "id":4784901, "
ctx":"initandlisten","msg":"Shutting down the MirrorMaestro"}
{"t":{"$date":"2023-11-30T17:20:51.635+01:00"},"s":"I",  "c":"SHARDING", "id":4784902, "
ctx":"initandlisten","msg":"Shutting down the WaitForMajorityService"}
{"t":{"$date":"2023-11-30T17:20:51.635+01:00"},"s":"I", "c":"NETWORK", "id":20562, "
ctx":"initandlisten","msg":"Shutdown: going to close listening sockets"}
{"t":{"$date":"2023-11-30T17:20:51.635+01:00"},"s":"I",  "c":"NETWORK",  "id":4784905, "
ctx":"initandlisten","msg":"Shutting down the global connection pool"}
{"t":{"$date":"2023-11-30T17:20:51.635+01:00"},"s":"I", "c":"CONTROL", "id":4784906, "
ctx":"initandlisten","msg":"Shutting down the FlowControlTicketholder"}
{"t":{"$date":"2023-11-30T17:20:51.635+01:00"},"s":"I",  "c":"-",        "id":20520,   "
ctx":"initandlisten","msg":"Stopping further Flow Control ticket acquisitions."}
{"t":{"$date":"2023-11-30T17:20:51.635+01:00"},"s":"I", "c":"NETWORK", "id":4784918, "
ctx":"initandlisten","msg":"Shutting down the ReplicaSetMonitor"}
{"t":{"$date":"2023-11-30T17:20:51.635+01:00"},"s":"I",  "c":"SHARDING", "id":4784921, "
ctx":"initandlisten","msg":"Shutting down the MigrationUtilExecutor"}
{"t":{"$date":"2023-11-30T17:20:51.635+01:00"},"s":"I", "c":"ASIO", "id":22582, "
ctx":"MigrationUtil-TaskExecutor","msg":"Killing all outstanding egress activity."}
{"t":{"$date":"2023-11-30T17:20:51.635+01:00"},"s":"I",  "c":"COMMAND",  "id":4784923, "
ctx":"initandlisten","msg":"Shutting down the ServiceEntryPoint"}
{"t":{"$date":"2023-11-30T17:20:51.635+01:00"},"s":"I", "c":"CONTROL", "id":4784928, "
ctx":"initandlisten","msg":"Shutting down the TTL monitor"}
{"t":{"$date":"2023-11-30T17:20:51.635+01:00"},"s":"I",  "c":"CONTROL",  "id":6278511, "
ctx":"initandlisten","msg":"Shutting down the Change Stream Expired Pre-images Remover"}
{"t":{"$date":"2023-11-30T17:20:51.635+01:00"},"s":"I", "c":"CONTROL", "id":4784929, "
ctx":"initandlisten","msg":"Acquiring the global lock for shutdown"}
{"t":{"$date":"2023-11-30T17:20:51.635+01:00"},"s":"I",  "c":"-",        "id":4784931, "
ctx":"initandlisten","msg":"Dropping the scope cache for shutdown"}
{"t":{"$date":"2023-11-30T17:20:51.635+01:00"},"s":"I", "c":"CONTROL", "id":20565, "
ctx":"initandlisten","msg":"Now exiting"}
{"t":{"$date":"2023-11-30T17:20:51.636+01:00"},"s":"I", "c":"CONTROL", "id":23138, "
ctx":"initandlisten","msg":"Shutting down","attr":{"exitCode":100}}
❯ sudo ls /home/database -la
total 0
drwx------ 1 mongodb daemon 0 Nov 30 17:16 .
drwxr-xr-x 1 root root 30 Nov 30 17:16 ..
❯ ps -aux | grep mongo
aemonge 12659 0.0 0.0 6272 1920 pts/10 S+ 17:20 0:00 grep mongo
❯ mongod --dbpath /home/database
{"t":{"$date":"2023-11-30T17:20:51.631+01:00"},"s":"I",  "c":"CONTROL",  "id":23285,   "
ctx":"main","msg":"Automatically disabling TLS 1.0, to force-enable TLS 1.0 specify --ss
lDisabledProtocols 'none'"}
{"t":{"$date":"2023-11-30T17:20:51.632+01:00"},"s":"I", "c":"NETWORK", "id":4915701, "
ctx":"main","msg":"Initialized wire specification","attr":{"spec":{"incomingExternalClie
nt":{"minWireVersion":0,"maxWireVersion":21},"incomingInternalClient":{"minWireVersion":
0,"maxWireVersion":21},"outgoing":{"minWireVersion":6,"maxWireVersion":21},"isInternalCl
ient":true}}}
{"t":{"$date":"2023-11-30T17:20:51.633+01:00"},"s":"I",  "c":"NETWORK",  "id":4648601, "
ctx":"main","msg":"Implicit TCP FastOpen unavailable. If TCP FastOpen is required, set t
cpFastOpenServer, tcpFastOpenClient, and tcpFastOpenQueueSize."}
{"t":{"$date":"2023-11-30T17:20:51.634+01:00"},"s":"I", "c":"REPL", "id":5123008, "
ctx":"main","msg":"Successfully registered PrimaryOnlyService","attr":{"service":"Tenant
MigrationDonorService","namespace":"config.tenantMigrationDonors"}}
{"t":{"$date":"2023-11-30T17:20:51.634+01:00"},"s":"I",  "c":"REPL",     "id":5123008, "
ctx":"main","msg":"Successfully registered PrimaryOnlyService","attr":{"service":"Tenant
MigrationRecipientService","namespace":"config.tenantMigrationRecipients"}}
{"t":{"$date":"2023-11-30T17:20:51.634+01:00"},"s":"I", "c":"CONTROL", "id":5945603, "
ctx":"main","msg":"Multi threading initialized"}
{"t":{"$date":"2023-11-30T17:20:51.634+01:00"},"s":"I",  "c":"TENANT_M", "id":7091600, "
ctx":"main","msg":"Starting TenantMigrationAccessBlockerRegistry"}
{"t":{"$date":"2023-11-30T17:20:51.634+01:00"},"s":"I", "c":"CONTROL", "id":4615611, "
ctx":"initandlisten","msg":"MongoDB starting","attr":{"pid":12665,"port":27017,"dbPath":
"/home/database","architecture":"64-bit","host":"robin"}}
{"t":{"$date":"2023-11-30T17:20:51.634+01:00"},"s":"I",  "c":"CONTROL",  "id":23403,   "
ctx":"initandlisten","msg":"Build Info","attr":{"buildInfo":{"version":"7.0.3","gitVersi
❯ sudo chmod -R 755 /home/database
❯ mongod
{"t":{"$date":"2023-11-30T17:21:53.203+01:00"},"s":"I", "c":"CONTROL", "id":23285, "
ctx":"main","msg":"Automatically disabling TLS 1.0, to force-enable TLS 1.0 specify --ss
lDisabledProtocols 'none'"}
{"t":{"$date":"2023-11-30T17:21:53.205+01:00"},"s":"I",  "c":"NETWORK",  "id":4915701, "
ctx":"main","msg":"Initialized wire specification","attr":{"spec":{"incomingExternalClie
nt":{"minWireVersion":0,"maxWireVersion":21},"incomingInternalClient":{"minWireVersion":
0,"maxWireVersion":21},"outgoing":{"minWireVersion":6,"maxWireVersion":21},"isInternalCl
ient":true}}}
{"t":{"$date":"2023-11-30T17:21:53.206+01:00"},"s":"I", "c":"NETWORK", "id":4648601, "
ctx":"main","msg":"Implicit TCP FastOpen unavailable. If TCP FastOpen is required, set t
cpFastOpenServer, tcpFastOpenClient, and tcpFastOpenQueueSize."}
{"t":{"$date":"2023-11-30T17:21:53.207+01:00"},"s":"I",  "c":"REPL",     "id":5123008, "
ctx":"main","msg":"Successfully registered PrimaryOnlyService","attr":{"service":"Tenant
MigrationDonorService","namespace":"config.tenantMigrationDonors"}}
{"t":{"$date":"2023-11-30T17:21:53.207+01:00"},"s":"I", "c":"REPL", "id":5123008, "
ctx":"main","msg":"Successfully registered PrimaryOnlyService","attr":{"service":"Tenant
MigrationRecipientService","namespace":"config.tenantMigrationRecipients"}}
{"t":{"$date":"2023-11-30T17:21:53.207+01:00"},"s":"I",  "c":"CONTROL",  "id":5945603, "
ctx":"main","msg":"Multi threading initialized"}
{"t":{"$date":"2023-11-30T17:21:53.207+01:00"},"s":"I", "c":"TENANT_M", "id":7091600, "
ctx":"main","msg":"Starting TenantMigrationAccessBlockerRegistry"}
{"t":{"$date":"2023-11-30T17:21:53.207+01:00"},"s":"I",  "c":"CONTROL",  "id":4615611, "
ctx":"initandlisten","msg":"MongoDB starting","attr":{"pid":12739,"port":27017,"dbPath":
"/data/db","architecture":"64-bit","host":"robin"}}
{"t":{"$date":"2023-11-30T17:21:53.207+01:00"},"s":"I", "c":"CONTROL", "id":23403, "
ctx":"initandlisten","msg":"Build Info","attr":{"buildInfo":{"version":"7.0.3","gitVersi
on":"b96efb7e0cf6134d5938de8a94c37cec3f22cff4","openSSLVersion":"OpenSSL 1.1.1w 11 Sep
2023","modules":[],"allocator":"tcmalloc","environment":{"distmod":"ubuntu2004","distarc
h":"x86_64","target_arch":"x86_64"}}}}
{"t":{"$date":"2023-11-30T17:21:53.207+01:00"},"s":"I",  "c":"CONTROL",  "id":51765,   "
ctx":"initandlisten","msg":"Operating System","attr":{"os":{"name":"NAME=\"Arch Linux\""
,"version":"Kernel 6.6.3-arch1-1"}}}
{"t":{"$date":"2023-11-30T17:21:53.207+01:00"},"s":"I", "c":"CONTROL", "id":21951, "
ctx":"initandlisten","msg":"Options set by command line","attr":{"options":{}}}
{"t":{"$date":"2023-11-30T17:21:53.208+01:00"},"s":"E",  "c":"STORAGE",  "id":22312,   "
ctx":"initandlisten","msg":"Error creating journal directory","attr":{"directory":"/data
/db/journal","error":"boost::filesystem::create_directory: Permission denied [system:13]
: \"/data/db/journal\""}}
{"t":{"$date":"2023-11-30T17:21:53.208+01:00"},"s":"E", "c":"CONTROL", "id":20558, "
ctx":"initandlisten","msg":"std::exception in initAndListen, terminating","attr":{"error
":"boost::filesystem::create_directory: Permission denied [system:13]: \"/data/db/journa
l\""}}
{"t":{"$date":"2023-11-30T17:21:53.208+01:00"},"s":"I",  "c":"REPL",     "id":4784900, "
ctx":"initandlisten","msg":"Stepping down the ReplicationCoordinator for shutdown","attr
":{"waitTimeMillis":15000}}
{"t":{"$date":"2023-11-30T17:21:53.208+01:00"},"s":"I", "c":"REPL", "id":4794602, "
ctx":"initandlisten","msg":"Attempting to enter quiesce mode"}
{"t":{"$date":"2023-11-30T17:21:53.208+01:00"},"s":"I",  "c":"-",        "id":6371601, "
ctx":"initandlisten","msg":"Shutting down the FLE Crud thread pool"}
{"t":{"$date":"2023-11-30T17:21:53.208+01:00"},"s":"I", "c":"COMMAND", "id":4784901, "
ctx":"initandlisten","msg":"Shutting down the MirrorMaestro"}
{"t":{"$date":"2023-11-30T17:21:53.208+01:00"},"s":"I",  "c":"SHARDING", "id":4784902, "
ctx":"initandlisten","msg":"Shutting down the WaitForMajorityService"}
{"t":{"$date":"2023-11-30T17:21:53.208+01:00"},"s":"I", "c":"NETWORK", "id":20562, "
ctx":"initandlisten","msg":"Shutdown: going to close listening sockets"}
{"t":{"$date":"2023-11-30T17:21:53.208+01:00"},"s":"I",  "c":"NETWORK",  "id":4784905, "
ctx":"initandlisten","msg":"Shutting down the global connection pool"}
{"t":{"$date":"2023-11-30T17:21:53.208+01:00"},"s":"I", "c":"CONTROL", "id":4784906, "
ctx":"initandlisten","msg":"Shutting down the FlowControlTicketholder"}
{"t":{"$date":"2023-11-30T17:21:53.208+01:00"},"s":"I",  "c":"-",        "id":20520,   "
ctx":"initandlisten","msg":"Stopping further Flow Control ticket acquisitions."}
{"t":{"$date":"2023-11-30T17:21:53.208+01:00"},"s":"I", "c":"NETWORK", "id":4784918, "
ctx":"initandlisten","msg":"Shutting down the ReplicaSetMonitor"}
{"t":{"$date":"2023-11-30T17:21:53.208+01:00"},"s":"I",  "c":"SHARDING", "id":4784921, "
ctx":"initandlisten","msg":"Shutting down the MigrationUtilExecutor"}
{"t":{"$date":"2023-11-30T17:21:53.209+01:00"},"s":"I", "c":"ASIO", "id":22582, "
ctx":"MigrationUtil-TaskExecutor","msg":"Killing all outstanding egress activity."}
{"t":{"$date":"2023-11-30T17:21:53.209+01:00"},"s":"I",  "c":"COMMAND",  "id":4784923, "
ctx":"initandlisten","msg":"Shutting down the ServiceEntryPoint"}
{"t":{"$date":"2023-11-30T17:21:53.209+01:00"},"s":"I", "c":"CONTROL", "id":4784928, "
ctx":"initandlisten","msg":"Shutting down the TTL monitor"}
{"t":{"$date":"2023-11-30T17:21:53.209+01:00"},"s":"I",  "c":"CONTROL",  "id":6278511, "
ctx":"initandlisten","msg":"Shutting down the Change Stream Expired Pre-images Remover"}
{"t":{"$date":"2023-11-30T17:21:53.209+01:00"},"s":"I", "c":"CONTROL", "id":4784929, "
ctx":"initandlisten","msg":"Acquiring the global lock for shutdown"}
{"t":{"$date":"2023-11-30T17:21:53.209+01:00"},"s":"I",  "c":"-",        "id":4784931, "
ctx":"initandlisten","msg":"Dropping the scope cache for shutdown"}
{"t":{"$date":"2023-11-30T17:21:53.209+01:00"},"s":"I", "c":"CONTROL", "id":20565, "
ctx":"initandlisten","msg":"Now exiting"}
{"t":{"$date":"2023-11-30T17:21:53.209+01:00"},"s":"I",  "c":"CONTROL",  "id":23138,   "
ctx":"initandlisten","msg":"Shutting down","attr":{"exitCode":100}}
❯ mongod --dbpath /home/database
{"t":{"$date":"2023-11-30T17:21:55.507+01:00"},"s":"I", "c":"CONTROL", "id":23285, "
ctx":"main","msg":"Automatically disabling TLS 1.0, to force-enable TLS 1.0 specify --ss
lDisabledProtocols 'none'"}
{"t":{"$date":"2023-11-30T17:21:55.508+01:00"},"s":"I",  "c":"NETWORK",  "id":4915701, "
ctx":"main","msg":"Initialized wire specification","attr":{"spec":{"incomingExternalClie
nt":{"minWireVersion":0,"maxWireVersion":21},"incomingInternalClient":{"minWireVersion":
0,"maxWireVersion":21},"outgoing":{"minWireVersion":6,"maxWireVersion":21},"isInternalCl
ient":true}}}
{"t":{"$date":"2023-11-30T17:21:55.510+01:00"},"s":"I", "c":"NETWORK", "id":4648601, "
ctx":"main","msg":"Implicit TCP FastOpen unavailable. If TCP FastOpen is required, set t
cpFastOpenServer, tcpFastOpenClient, and tcpFastOpenQueueSize."}
{"t":{"$date":"2023-11-30T17:21:55.511+01:00"},"s":"I",  "c":"REPL",     "id":5123008, "
ctx":"main","msg":"Successfully registered PrimaryOnlyService","attr":{"service":"Tenant
MigrationDonorService","namespace":"config.tenantMigrationDonors"}}
{"t":{"$date":"2023-11-30T17:21:55.511+01:00"},"s":"I", "c":"REPL", "id":5123008, "
ctx":"main","msg":"Successfully registered PrimaryOnlyService","attr":{"service":"Tenant
MigrationRecipientService","namespace":"config.tenantMigrationRecipients"}}
{"t":{"$date":"2023-11-30T17:21:55.511+01:00"},"s":"I",  "c":"CONTROL",  "id":5945603, "
ctx":"main","msg":"Multi threading initialized"}
{"t":{"$date":"2023-11-30T17:21:55.511+01:00"},"s":"I", "c":"TENANT_M", "id":7091600, "
ctx":"main","msg":"Starting TenantMigrationAccessBlockerRegistry"}
{"t":{"$date":"2023-11-30T17:21:55.512+01:00"},"s":"I",  "c":"CONTROL",  "id":4615611, "
ctx":"initandlisten","msg":"MongoDB starting","attr":{"pid":12754,"port":27017,"dbPath":
"/home/database","architecture":"64-bit","host":"robin"}}
{"t":{"$date":"2023-11-30T17:21:55.512+01:00"},"s":"I", "c":"CONTROL", "id":23403, "
ctx":"initandlisten","msg":"Build Info","attr":{"buildInfo":{"version":"7.0.3","gitVersi
on":"b96efb7e0cf6134d5938de8a94c37cec3f22cff4","openSSLVersion":"OpenSSL 1.1.1w 11 Sep
2023","modules":[],"allocator":"tcmalloc","environment":{"distmod":"ubuntu2004","distarc
h":"x86_64","target_arch":"x86_64"}}}}
{"t":{"$date":"2023-11-30T17:21:55.512+01:00"},"s":"I",  "c":"CONTROL",  "id":51765,   "
ctx":"initandlisten","msg":"Operating System","attr":{"os":{"name":"NAME=\"Arch Linux\""
,"version":"Kernel 6.6.3-arch1-1"}}}
{"t":{"$date":"2023-11-30T17:21:55.512+01:00"},"s":"I", "c":"CONTROL", "id":21951, "
ctx":"initandlisten","msg":"Options set by command line","attr":{"options":{"storage":{"
dbPath":"/home/database"}}}}
{"t":{"$date":"2023-11-30T17:21:55.513+01:00"},"s":"E",  "c":"STORAGE",  "id":22312,   "
ctx":"initandlisten","msg":"Error creating journal directory","attr":{"directory":"/home
/database/journal","error":"boost::filesystem::create_directory: Permission denied [syst
em:13]: \"/home/database/journal\""}}
{"t":{"$date":"2023-11-30T17:21:55.513+01:00"},"s":"E", "c":"CONTROL", "id":20558, "
ctx":"initandlisten","msg":"std::exception in initAndListen, terminating","attr":{"error
":"boost::filesystem::create_directory: Permission denied [system:13]: \"/home/database/
journal\""}}
{"t":{"$date":"2023-11-30T17:21:55.513+01:00"},"s":"I",  "c":"REPL",     "id":4784900, "
ctx":"initandlisten","msg":"Stepping down the ReplicationCoordinator for shutdown","attr
":{"waitTimeMillis":15000}}
{"t":{"$date":"2023-11-30T17:21:55.513+01:00"},"s":"I", "c":"REPL", "id":4794602, "
ctx":"initandlisten","msg":"Attempting to enter quiesce mode"}
{"t":{"$date":"2023-11-30T17:21:55.513+01:00"},"s":"I",  "c":"-",        "id":6371601, "
ctx":"initandlisten","msg":"Shutting down the FLE Crud thread pool"}
{"t":{"$date":"2023-11-30T17:21:55.513+01:00"},"s":"I", "c":"COMMAND", "id":4784901, "
ctx":"initandlisten","msg":"Shutting down the MirrorMaestro"}
{"t":{"$date":"2023-11-30T17:21:55.513+01:00"},"s":"I",  "c":"SHARDING", "id":4784902, "
ctx":"initandlisten","msg":"Shutting down the WaitForMajorityService"}
{"t":{"$date":"2023-11-30T17:21:55.513+01:00"},"s":"I", "c":"NETWORK", "id":20562, "
ctx":"initandlisten","msg":"Shutdown: going to close listening sockets"}
{"t":{"$date":"2023-11-30T17:21:55.513+01:00"},"s":"I",  "c":"NETWORK",  "id":4784905, "
ctx":"initandlisten","msg":"Shutting down the global connection pool"}
{"t":{"$date":"2023-11-30T17:21:55.513+01:00"},"s":"I", "c":"CONTROL", "id":4784906, "
ctx":"initandlisten","msg":"Shutting down the FlowControlTicketholder"}
{"t":{"$date":"2023-11-30T17:21:55.513+01:00"},"s":"I",  "c":"-",        "id":20520,   "
ctx":"initandlisten","msg":"Stopping further Flow Control ticket acquisitions."}
{"t":{"$date":"2023-11-30T17:21:55.513+01:00"},"s":"I", "c":"NETWORK", "id":4784918, "
ctx":"initandlisten","msg":"Shutting down the ReplicaSetMonitor"}
{"t":{"$date":"2023-11-30T17:21:55.513+01:00"},"s":"I",  "c":"SHARDING", "id":4784921, "
ctx":"initandlisten","msg":"Shutting down the MigrationUtilExecutor"}
{"t":{"$date":"2023-11-30T17:21:55.513+01:00"},"s":"I", "c":"ASIO", "id":22582, "
ctx":"MigrationUtil-TaskExecutor","msg":"Killing all outstanding egress activity."}
{"t":{"$date":"2023-11-30T17:21:55.513+01:00"},"s":"I",  "c":"COMMAND",  "id":4784923, "
ctx":"initandlisten","msg":"Shutting down the ServiceEntryPoint"}
{"t":{"$date":"2023-11-30T17:21:55.513+01:00"},"s":"I", "c":"CONTROL", "id":4784928, "
ctx":"initandlisten","msg":"Shutting down the TTL monitor"}
{"t":{"$date":"2023-11-30T17:21:55.514+01:00"},"s":"I",  "c":"CONTROL",  "id":6278511, "
ctx":"initandlisten","msg":"Shutting down the Change Stream Expired Pre-images Remover"}
{"t":{"$date":"2023-11-30T17:21:55.514+01:00"},"s":"I", "c":"CONTROL", "id":4784929, "
ctx":"initandlisten","msg":"Acquiring the global lock for shutdown"}
{"t":{"$date":"2023-11-30T17:21:55.514+01:00"},"s":"I",  "c":"-",        "id":4784931, "
ctx":"initandlisten","msg":"Dropping the scope cache for shutdown"}
{"t":{"$date":"2023-11-30T17:21:55.514+01:00"},"s":"I", "c":"CONTROL", "id":20565, "
ctx":"initandlisten","msg":"Now exiting"}
{"t":{"$date":"2023-11-30T17:21:55.514+01:00"},"s":"I", "c":"CONTROL", "id":23138, "
ctx":"initandlisten","msg":"Shutting down","attr":{"exitCode":100}}
❯ ls -lat
total 0
drwx------ 1 aemonge aemonge 1004 Nov 30 17:22 aemonge
drwxr-xr-x 1 root root 30 Nov 30 17:16 .
drwxr-xr-x 1 mongodb daemon 0 Nov 30 17:16 database
drwxr-xr-x 1 root root 150 Nov 30 17:13 ..
zsh: IOT instruction (core dumped) mongod
zsh: IOT instruction (core dumped) mongod
Fix this bash script.

It should attempt to start mongo, and save the PID to kill the process at the end of the script.

Also, can you make it so that If this process dies it kill mongo automatically ?

Or at least, checks before starting mongo at the port :27018 if it exist, should be killed.

Keep other mongod with other ports like `27017` intact.

```bash
start_mongo() {
    if command_exists docker; then
        docker stop helios-test-db >/dev/null 2>&1
        docker run -d --rm -p 27018:27017 --name helios-test-db mongo:6 >/dev/null
        USING_DOCKER=true
    else
        # Assuming you have MongoDB installed locally and available as 'mongod' command
        # Starts MongoDB in the background

        if ! mongod --port 27018 >.mongo.log & then
            echo "soooooo $?"
            cat .mongo.log
            exit $?
        else
            echo 'wwwwwsoooooo'
            rm .mongo.log
        fi
        MONGO_PID="$!"
        USING_DOCKER=false
    fi
    export MONGO_PID
    export USING_DOCKER
}
```
fix this attempt

```bash
stop_mongo() {
    if [ "$USING_DOCKER" = true ]; then
        docker stop helios-test-db >/dev/null &
    else
        if [ -n "$MONGO_PID" ]; then
          kill "$MONGO_PID"
        elif [ -v lsof -i :27018 ]; then
          kill  "$(lsof -i :27018 | tail -1 | cut -f3 -d' ')"
        fi
        unset MONGO_PID
    fi
}
```
Convert this four values:

```

    (25, 8.99): 0,
    (20, 8.99): 4.43864,
    (15, 8.99): 4.438637,
    (10, 8.99): 4.458637,

    (25, 6.49): 19.40300,
    (20, 6.49): 17.99408,
    (15, 6.49): 16.618064,
    (10, 6.49): 13.960108,

    (25, 3.99): 54.44016,
    (20, 3.99): 52.09126,
    (15, 3.99): 49.812730,
    (10, 3.99): 45.454550,
```

Into thirty. The idea is to extend the increment of the values from 10, 15, 20 and 15 years all the way up from 0 year up to 30

```
    (25, 8.99): 0,
    (20, 8.99): 4.43864,
    (15, 8.99): 4.438637,
    (10, 8.99): 4.458637,

    (25, 6.49): 19.40300,
    (20, 6.49): 17.99408,
    (15, 6.49): 16.618064,
    (10, 6.49): 13.960108,

    (25, 3.99): 54.44016,
    (20, 3.99): 52.09126,
    (15, 3.99): 49.812730,
    (10, 3.99): 45.454550,
```
okey, what pip would install sklearn ?
Can you finish the example, to provide me with the array of 30 years for `8.99` ?
In ptyhon how to trim to 88888888, this float number, as an upper ?

(1940300 \* 1e-7)
I want the float representation with it's eight decimals
Is there a way to make 7 round it self to 10, generaccally?

```python
_input = 7
print(round(_input, 1, step=5)) # 10
_input = 8
print(round(_input, 1, step=5)) # 10
_input = 11
print(round(_input, 1, step=5)) # 15
```
Find the element wich is from "key" 5

a = [(5, 'hola'), (10, 'adios')]
```
====================================================== FAILURES =======================================================
________________________________ TestCostCalculator.test_before_n_after_premium_n_cash ________________________________

self = <financial.tests.services_tests.TestCostCalculator object at 0x7f6e1c4cb2d0>
cost_barely_expectations_premium_fixture_location_cash = <app.shared.financial.services.CostCalculator object at 0x7f6e
1c4dfbd0>

    @pytest.mark.focus
    def test_before_n_after_premium_n_cash(
        self, cost_barely_expectations_premium_fixture_location_cash
    ):
        c = cost_barely_expectations_premium_fixture_location_cash
        c.consumptions(
            ConsumptionDetails(
                yearely_watt_hour_ussage=Units(
                    unit=UnitsEnum.watt_hours, amount=7150000
                )
            )
        )
        c.update_actual_panels()
        c.update_system()
        c.selected_batteries = [BatteryTypes.enphase_self_consumed_5]
        c.calculate_financing_details()
>       c.savings()

app/shared/financial/tests/services_tests.py:1811:
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
app/shared/financial/services.py:1306: in savings
    with_solar_cost_xxx_years = self._with_solar_cost_xxx_years()
app/shared/financial/services.py:1001: in _with_solar_cost_xxx_years
    amounts=[
app/shared/financial/services.py:1005: in <listcomp>
    self._nightly_utility_bill(year)
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _

self = <app.shared.financial.services.CostCalculator object at 0x7f6e1c4dfbd0>, year = 1

    def _nightly_utility_bill(self, year: int = None) -> float:
        """
        Get the nightly estimated utility bill.

        Parameters
        ----------
        year : int
            The selected year or years to calculate.

        Returns
        -------
        : float
            The nightly estimated utility bill.
        """
        if year is None:
            year = self.selected_saving_years

        if self.battery_kwh_included_value >= self.average_day_night_usage:
            return 0

        return (
>           (
                self.average_day_night_usage
                - (  # batteries work very good
                    self.battery_kwh_included_value
                    if BATTERY_DEGRADATION_YEAR < year
                    else 0  # batteries are depleted
                ),
            )
            * (self.selected_utility.rate.amount / 1e10)
            * (365 / 12)
            * ((1 + UTILITY_RATE_INCREASE / 100) ** year)
        )
E       TypeError: can't multiply sequence by non-int of type 'float'

app/shared/financial/services.py:1123: TypeError

---------- coverage: platform linux, python 3.11.5-final-0 -----------

FAIL Required test coverage of 65.0% not reached. Total coverage: 0.00%
=============================================== short test summary info ===============================================
FAILED app/shared/financial/tests/services_tests.py::TestCostCalculator::test_before_n_after_premium_n_cash - TypeError
: can't multiply sequence by non-int of type 'float'
==================================== 1 failed, 95 deselected, 32 warnings in 2.41s ====================================
```
Make it so that the following code has two csv to reaf from

```python
    @pytest.mark.parametrize(
        "unit, minimum, field, maximum, field_size",
        csv.reader(open(os.path.join(_dir, "magnitud_financing.csv"), "r")),
    )
    def test_all_field_test_from_csv_financing(
        self,
        unit,
        minimum,
        field,
        maximum,
        field_size,
        authorized_client,
        fresh_session_for_15_fixture_financing,
        user_fixture,
```

LIKE if this `csv.append` mehtod existed:

```python
    @pytest.mark.parametrize(
        "unit, minimum, field, maximum, field_size",
        csv.reader(open(os.path.join(_dir, "magnitud_base.csv"), "r")),
        csv.append(open(os.path.join(_dir, "magnitud_financing.csv"), "r")),
    )
    def test_all_field_test_from_csv_financing(
        self,
        unit,
        minimum,
        field,
        maximum,
        field_size,
        authorized_client,
        fresh_session_for_15_fixture_financing,
        user_fixture,
```
Hey, I'm trying to fix some issues with my arch linux installation.
I need to fix this messages from when I hibernate:

    iwlwifi  .... WRT: Invalid bugger destination
    iosm .....: msg timeout
    i915 .... [drm] *ERROR* Failied to get ACT after 3000ms, last status: 00
    i915 .... [drm] *ERROR* Failied to get ACT after 3000ms, last status: 00
    iosm .....: msg timeout
    iwlwifi  .... WRT: Invalid bugger destination
    iosm .....: msg timeout
    iosm .....: msg timeout
    iosm .....: msg timeout
    iwlwifi  .... WRT: Invalid bugger destination

I have read the arch wiki, and changed this files accordingly, can you check them please?

<!-- include: /etc/modprobe.d/audio_powersave.conf -->

<!-- include: /etc/modprobe.d/blacklist.conf -->

<!-- include: /etc/modprobe.d/iwlwifi.conf -->
Configuration seams OK, what else can be done to make the hibernate don't see this issues?
Any other suggestions?
