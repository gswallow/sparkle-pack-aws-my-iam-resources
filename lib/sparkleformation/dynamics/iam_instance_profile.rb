SparkleFormation.dynamic(:iam_instance_profile) do |_name, _config = {}|

  dynamic!(:i_a_m_instance_profile, _name).properties do
    path '/'
    roles _config.fetch(:iam_roles, [ "#{_name.capitalize}IAMRole" ]).map { |r| ref!(r) }
  end

  dynamic!(:i_a_m_instance_profile, _name).depends_on _config.fetch(:iam_policy, "#{_name.capitalize}IAMPolicy")
end
