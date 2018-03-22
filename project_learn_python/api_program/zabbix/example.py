from zabbix.api import ZabbixAPI

# Create ZabbixAPI class instance
zapi = ZabbixAPI(url='http://localhost/zabbix/', user='Admin', password='zabbix')

# Get all monitored hosts
result1 = zapi.host.get(monitored_hosts=1, output='extend')

# Get all disabled hosts
result2 = zapi.do_request('host.get',
                          {
                              'filter': {'status': 1},
                              'output': 'extend'
                          })

# Filter results
hostnames1 = [host['host'] for host in result1]
hostnames2 = [host['host'] for host in result2['result']]
print hostnames1
print hostnames2
