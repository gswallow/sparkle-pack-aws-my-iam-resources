SfnRegistry.register(:resource_signaling) do
  [
    {
      'Action' => %w(cloudformation:DescribeStackResource cloudformation:SignalResource),
      'Resource' => join!( join!('arn', 'aws', 'cloudformation', region!, account_id!, 'stack', :options => { :delimiter => ':'}), stack_name!, '*', :options => { :delimiter => '/' }),
      'Effect' => 'Allow'
    },
    {
      'Action' => %w(autoscaling:SetInstanceHealth),
      'Resource' => %w(*),
      'Effect' => 'Allow'
    }
  ]
end
