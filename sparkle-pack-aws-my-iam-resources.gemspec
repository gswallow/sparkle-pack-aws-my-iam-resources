Gem::Specification.new do |s|
  s.name = 'sparkle-pack-aws-my-iam-resources'
  s.version = '0.0.1'
  s.licenses = ['MIT']
  s.summary = 'AWS My IAM Resources  SparklePack'
  s.description = 'SparklePack to provide dynamics to create IAM policies, roles and instance profiles'
  s.authors = ['Greg Swallow']
  s.email = 'gswallow@gmail.com'
  s.homepage = 'https://github.com/gswallow'
  s.files = Dir[ 'lib/sparkleformation/registry/*' ] + %w(sparkle-pack-aws-my-iam-resources.gemspec lib/sparkle-pack-aws-my-iam-resources.rb)
  s.add_runtime_dependency 'sparkle_formation'
end
