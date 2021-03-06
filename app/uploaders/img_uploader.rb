class ImgUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  include CarrierWave::RMagick #リサイズ、画像形式を変更に必要
  # include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url(*args)
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end
  #上限変更
  process :resize_to_limit => [700, 700]
  #jpgで保存
  process :convert => 'jpg'
  # Process files as they are uploaded:
  # process scale: [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:サムネイルを生成
  version :thumb do
    process :resize_to_limit => [300, 300]
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:　jpg,jpeg,gif,pngのみ
  def extension_whitelist
    %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  #ファイル名を変更し、拡張子を同じにする
  def filename
    super.chomp(File.extname(super)) + '.jpg'
  end
  
  def filename
    if original_filename.present?
      time = Time.now
      name = time.strftime('%Y%m%d%H%M%S') + '.jpg'
      name.downcase
    end
  end
end
