SparkleFormation.dynamic(:iam_policy) do |_name, _config = {}|

  _config[:policy_statements] ||= [ 'resource_signaling' ]

  statements = Array.new
  if _config[:policy_statements].is_a?(Array)
    # Maybe a splat here on the first _config, instead.
    statements = _config[:policy_statements].map { |statement| registry!(statement.to_sym) }.first
  elsif _config[:policy_statements.is_a?(Hash)
    statements = _config[:policy_statements].hash { |statement, config| registry!(statement.to_sym, config) }.first
  end

  # <shrug> http://docs.aws.amazon.com/autoscaling/latest/userguide/IAM.html#AutoScaling_ARN_Format
  dynamic!(:i_a_m_policy, _name).properties do
    policy_name "#{_name}IAMPolicy".capitalize
    policy_document do
      version '2012-10-17'
      statements statements
    end
    roles _array(
      _config.fetch(:iam_roles, [ "#{_name}_i_a_m_role".to_sym ]).map { |r| ref!(r) }
    )
  end

  dynamic!(:i_a_m_policy, _name).depends_on _config.fetch(:iam_roles, [ "#{_name}IAMRoles" ]).map { |r| r.capitalize }
end
