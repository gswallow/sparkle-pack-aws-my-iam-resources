SparkleFormation.dynamic(:iam_instance_profile) do |_name, _config = {}|

  dynamic!(:i_a_m_instance_profile, _name).properties do
    path '/'
    roles _array(
            config.fetch(:iam_roles, [ "#{_name}_i_a_m_role".to_sym ]).map { |r| ref!(r) }
          )
  end

  dynamic!(:i_a_m_instance_profile, _name).depends_on _config.fetch(:iam_policy, "#{_name}IAMPolicy".capitalize)
end
