# Quick Start
```sh
git clone https://github.com/lomik/graphite-clickhouse-tldr
cd graphite-clickhouse-tldr
make
# or
make daemon
make stop # to stop the docker
```
Open http://127.0.0.1/ in browser, credentials are `admin:tldr`

### Mapped Ports

Host | Container | Service
---- | --------- | -------------------------------------------------------------------------------------------------------------------
  80 |      3000 | [grafana](https://grafana.com/grafana)
2003 |      2003 | [carbon receiver - plaintext](http://graphite.readthedocs.io/en/latest/feeding-carbon.html#the-plaintext-protocol)
2004 |      2004 | [carbon receiver - pickle](http://graphite.readthedocs.io/en/latest/feeding-carbon.html#the-pickle-protocol)
2006 |      2006 | [carbon receiver - prometheus remote write](https://prometheus.io/docs/prometheus/latest/configuration/configuration/#%3Cremote_write%3E)
9090 |      9090 | carbonapi/graphite-web endpoint
9092 |      9092 | prometheus UI endpoint
