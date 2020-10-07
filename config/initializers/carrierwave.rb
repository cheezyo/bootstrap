CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',                        # required
    :aws_access_key_id      => ENV['S3_KEY'],                        # required
    :aws_secret_access_key  => ENV['S3_SECRET'],                        # required
    :region                 => 'eu-central-1',                  # optional, defaults to 'us-east-1'
    :endpoint => 'https://s3-eu-central-1.amazonaws.com'
  }
  config.fog_directory  = 'stk-server'                     # required
  config.fog_public     = false                                   # optional, defaults to true
  config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
end

#'AKIAIHMLQEQDE2LFTJ5A'
#'K4A0nyLMF9Y2n0y1d71cvVCCGwfCCl0VUt2ru+P8'
