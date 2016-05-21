require "yaml"

namespace :tex do

  desc "clean som auxiliar tex files"
  task :clean do
    ["aux", "log", "bbl", "blg",
     "brf", "idx", "synctex.gz",
     "thm", "toc", "lytex", "dep"].each do |ext|
      Dir["./*.tex"].each do |file|
        name = file.split(".tex")[0].split("./")[1]
        if File.exists? "#{name}.#{ext}"
          sh "rm #{name}.#{ext}"
        end
      end
    end
    Dir.glob("./snippet-*.ly").each do |file|
      sh "rm #{file}"
    end
    Dir.glob("./*/").each do |folder|
      f = folder.split("./")[1]
      if f.length == 3
        sh "rm -r #{f}"
      end
    end
  end

  desc "compile lilypond"
  task :lilypond do
    
    Dir.glob("./*.ly") do |file|
      name = file.split("./")[1].split(".ly")[0]
      puts "-------------\n#{name}\n--------------"
      lytex = "#{name}.lytex"
      if not File.exists?(lytex)
        File.open(lytex, "w+") do |f|
          f.write "\\lilypondfile\{#{name}.ly\}"
          f.close
        end
        sh "lilypond-book #{lytex}"
      end
    end
  end
  
  desc "compile tex"
  task :compile do
    if not ENV['FILE'] then ENV['FILE']="main" end
    pdflatex = "pdflatex -synctex=1 -interaction=nonstopmode -shell-escape -file-line-error ./#{ENV['FILE']}.tex | egrep \".*:[0-9]*:.*|LaTeX Warning:\""
    sh pdflatex
  end

  desc "compile bibliography"
  task :bibtex do
    if not ENV['FILE'] then ENV['FILE']="main" end
    bibtex = "bibtex -terse ./#{ENV['FILE']}.aux"
    sh bibtex
  end

  desc "backup this to some computer that isnt dropbox or any cloud service"
  task :ssh do
    if not ENV['FILE'] then ENV['FILE'] = "main" end
    conf = YAML::load File.open("./#{ENV['FILE']}.yml")
    sh "rsync -avz -e ssh ./mestrado/ #{con['host']}:#{conf['path']}"
  end

  desc "make compilation, bibliography and compilation again 2 times to correct pdf"
  task :make do
    Rake::Task["tex:compile"].invoke
    Rake::Task["tex:bibtex"].invoke
    Rake::Task["tex:compile"].invoke
  end

  desc "if your project have a main.* files, then this will do all the things for you"
  task :main do
    if not ENV['FILE']
      ENV['FILE'] = "main"
    end
    Rake::Task["tex:clean"].invoke
    Rake::Task["tex:lilypond"].invoke
    Rake::Task["tex:make"].invoke
    Rake::Task["tex:ssh"]
  end
end

