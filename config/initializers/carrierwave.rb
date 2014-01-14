CarrierWave.configure do |config|
  config.fog_credentials = {
      :provider               => 'AWS',
      :aws_access_key_id      => ENV['S3_ID'],
      :aws_secret_access_key  => ENV['S3_KEY']
  }
  config.fog_directory  = ENV['S3_BUCKET']                     # required
  config.fog_public     = false
end
