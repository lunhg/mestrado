namespace :yt do
  desc "Download video from url's id (ex: rake yt:video T2TfIQNxhjc)"
  task :video do 
    if not File.directory?("#{File.dirname(__FILE__)}/videos")
      sh("mkdir #{File.dirname(__FILE__)}/videos")
    end
    sh("youtube-dl --output './videos/%(uploader)s-%(title)s.%(ext)s' https://www.youtube.com/watch?v=#{ENV['URL_ID']}")
  end

  desc "Extract audio from from url's id (ex: rake yt:audio T2TfIQNxhjc)"
  task :audio do
    if not File.directory?("#{File.dirname(__FILE__)}/audios")
      sh("mkdir #{File.dirname(__FILE__)}/audios")
    end
    sh("youtube-dl --extract-audio --audio-format #{ENV['FORMAT']} --audio-quality #{ENV['QUALITY']} --prefer-ffmpeg --output './audios/%(uploader)s-%(title)s.%(ext)s' https://www.youtube.com/watch?v=#{ENV['URL_ID']}")
  end
end

