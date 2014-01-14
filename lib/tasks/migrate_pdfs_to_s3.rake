namespace :pdf do
  task :migrate_to_s3, [:dir_path] => [:environment] do |t, args|

    #Ebook.destroy_all

    args.with_defaults(:dir_path => "Thanks for logging on")
    puts "dir_path: #{args.dir_path}"

    Dir.foreach(args.dir_path).each do |file|
      file_path = args.dir_path + '/' + file
      mimetype = (`file --mime -b "#{file_path}"`).split(";")[0]
      count = 1

      record_exist = Ebook.exists? name: file
      unless record_exist
        if mimetype =~ /pdf/

          begin
            p "creating ... file: #{file}\n file_path: #{file_path}\n mimetype: #{mimetype} \n\n\n"
            #create_ebook
            uploaded_file = ActionDispatch::Http::UploadedFile.new(
                {
                    :filename => file,
                    :content_type => 'application/pdf',
                    :tempfile => File.new(file_path)
                }
            )
            @ebook = Ebook.new name: file, pdf: uploaded_file
            @ebook.save!
          rescue Errno::ECONNRESET => e
            p "Connection reset by peer (Errno::ECONNRESET) ... sleeping retrying #{count} times ... "
            sleep 1
            retry
          end

        end
      else
        p "ebook #{file} already exists skipping ... "
      end

    end

  end
end