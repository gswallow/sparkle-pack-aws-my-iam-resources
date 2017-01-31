# sparkle-pack-aws-my-iam-resources

Dynamics to create IAM polices, roles and instance profiles.

## Dynamics

### iam_instance_profile dynamic

Creates an IAM instance profile, which must be supplied an array of IAM roles 
to attach to and an IAM policy to depend on:

    dynamic!(:iam_instance_profile, 'loadbalancer', :iam_roles => [ 'LoadbalancerIAMRole'], :iam_policy => 'LoadbalancerIAMPolicy')

## iam_role dynamic

Creates an IAM role, which may be supplied a list of AWS services that can
assume the role:

    dynamic!(:iam_role, 'loadbalancer', :services => [ 'ec2.amazonaws.com', 'ecs-tasks.amazonaws.com' ])

By default, the IAM role will 'ec2.amazonaws.com' service to assume it.

## iam_policy_dynamic

Creates an IAM policy resource that expands policy statements through 
{{SparkleFormation.registry!}} method calls.  The policy may be supplied a
list of policy statements, an IAM role to attach the policy to, and an
IAM policy to depend on before the IAM policy gets created.

    dynamic!(:iam_policy, 'loadbalancer',
             :policy_statements => { :modify_route_53, :hosted_zone => ZONE_ID },
             :iam_roles => [ 'LoadbalancerIAMRole' ],
            )
    
    dynamic!(:iam_policy, 'loadbalancer',
             :policy_statements => [ :resource_signaling ],
             :iam_roles => [ 'LoadbalancerIAMRole' ],
            )

Both examples, above, creates an IAM policy with a logical ID named
'LoadbalancerIAMPolicy', attached to an IAM role with a logical ID named
'loadbalancerIAMRole.'  

The first example loads the 'modify_route_53' registry and passes in a 
{{:hosted_zone}} parameter as one of the registry's {{_config}} parameters.
Providing a hash to the {{:policy_statements}} parameter allows you to
pass configuration parameters to the registry, itself.

The second example simply loads the 'resource_signaling' registry; no
parameters are passed into the registry.

## Registries

### resource_signaling.rb

By default, an IAM policy allows an EC2 instance to perform the following
AWS actions: 

  - cloudformation:DescribeStackResource
  - cloudformation:SignalResource
  - autoscaling:SetInstanceHealth

These actions allow an EC2 instance in an auto scaling group to use the
cfn_signal utlity to send SUCCESS messages to a CloudFormation stack, and
mark itself unhealthy if bootstrapping fails.  Failed instances are
automatically terminated and re-launched, providing for a retry in the
event of temporal failures.
