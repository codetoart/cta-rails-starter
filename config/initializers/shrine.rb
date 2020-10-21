require "shrine"
Shrine.plugin :activerecord
Shrine.plugin :derivatives, versions_compatibility: true
if Rails.env.production?
  require "shrine/storage/s3"
  s3_options = {
      access_key_id:     Rails.application.credentials[Rails.env.to_sym][:aws][:access_key_id],
      secret_access_key: Rails.application.credentials[Rails.env.to_sym][:aws][:secret_access_key],
      region:            Rails.application.credentials[Rails.env.to_sym][:aws][:s3_region],
      bucket:            Rails.application.credentials[Rails.env.to_sym][:aws][:s3_bucket]
    }
  Shrine.storages = {
    cache: Shrine::Storage::S3.new(upload_options: {acl: "public-read", cache_control: "public, max-age=3600"}, prefix: "cache", **s3_options),
    store: Shrine::Storage::S3.new(upload_options: {acl: "public-read", cache_control: "public, max-age=3600"}, prefix: "uploads", **s3_options)
  }
elsif Rails.env.development?
  # require "shrine/storage/file_system"
  # Shrine.storages = {
  #   cache: Shrine::Storage::FileSystem.new("public", prefix: "uploads/cache"),
  #   store: Shrine::Storage::FileSystem.new("public", prefix: "uploads")
  # }
  require "shrine/storage/s3"
  s3_options = {
      access_key_id:     Rails.application.credentials[Rails.env.to_sym][:aws][:access_key_id],
      secret_access_key: Rails.application.credentials[Rails.env.to_sym][:aws][:secret_access_key],
      region:            Rails.application.credentials[Rails.env.to_sym][:aws][:s3_region],
      bucket:            Rails.application.credentials[Rails.env.to_sym][:aws][:s3_bucket]
    }
  Shrine.storages = {
    cache: Shrine::Storage::S3.new(upload_options: {acl: "public-read", cache_control: "public, max-age=3600"}, prefix: "cache", **s3_options),
    store: Shrine::Storage::S3.new(upload_options: {acl: "public-read", cache_control: "public, max-age=3600"}, prefix: "uploads", **s3_options)
  }
elsif Rails.env.staging?
    require "shrine/storage/s3"
    s3_options = {
        access_key_id:     Rails.application.credentials[Rails.env.to_sym][:aws][:access_key_id],
        secret_access_key: Rails.application.credentials[Rails.env.to_sym][:aws][:secret_access_key],
        region:            Rails.application.credentials[Rails.env.to_sym][:aws][:s3_region],
        bucket:            Rails.application.credentials[Rails.env.to_sym][:aws][:s3_bucket]
      }
    Shrine.storages = {
      cache: Shrine::Storage::S3.new(upload_options: {acl: "public-read", cache_control: "public, max-age=3600"}, prefix: "cache", **s3_options),
      store: Shrine::Storage::S3.new(upload_options: {acl: "public-read", cache_control: "public, max-age=3600"}, prefix: "uploads", **s3_options)
    }
end