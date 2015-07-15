module FileUpload

  def remove_file(file)
    File.delete("./public#{file}") if File.exist?("./public#{file}")
  end

  def rename_file(file)
    Time.now.strftime("%Y%m%d-%H%M%S-") + file.gsub(" ", "_")
  end

  def upload_file(file, dir, hash_key)

    # file is a ActionDispatch::Http::UploadedFile object
    
    file_path = rename_file file.original_filename
    new_file = File.open(Rails.root.join('public', "#{dir}", file_path), 'wb')
    
    new_file.write(file.read)
    new_file.close
    file.close

    return {hash_key => "/#{dir}/" + file_path}
  end

end