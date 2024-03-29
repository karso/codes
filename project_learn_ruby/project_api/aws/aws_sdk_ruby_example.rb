require 'aws-sdk'

client = Aws::CloudWatch::Client.new(region: 'us-east-1')

# use  client.describe_alarms({alarm_names: ['Name1', 'Name2']})
# to get information about alarms Name1 and Name2
resp = client.describe_alarms

resp.metric_alarms.each do |alarm|
  puts 'Name:           ' + alarm.alarm_name
  puts 'State:          ' + alarm.state_value
  puts '  reason:       ' + alarm.state_reason
  puts 'Metric:         ' + alarm.metric_name
  puts 'Namespace:      ' + alarm.namespace
  puts 'Statistic:      ' + alarm.statistic
  puts 'Dimensions (' + alarm.dimensions.length.to_s + '):'

  alarm.dimensions.each do |d|
    puts '  Name:         ' + d.name
    puts '  Value:        ' + d.value
  end

  puts 'Period:         ' + alarm.period.to_s
  puts 'Unit:           ' + alarm.unit.to_s
  puts 'Eval periods:   ' + alarm.evaluation_periods.to_s
  puts 'Threshold:      ' + alarm.threshold.to_s
  puts 'Comp operator:  ' + alarm.comparison_operator
  puts
end
