require "kemal"

get "/" do
  "Hello World!"
end

post "/upload" do |env|
  HTTP::FormData.parse(env.request) do |upload|
    filename = upload.filename
    
    if !filename.is_a?(String)
    # Be sure to check if file.filename is not empty otherwise it'll raise a compile time error
      p "No filename included in upload"
    else
      file_path = File.join [Kemal.config.public_folder, "uploads/", filename]
      File.open(file_path, "w") do |f|
        IO.copy(upload.body, f)
      end
      "Upload ok"
    end
  end
end

Kemal.run
