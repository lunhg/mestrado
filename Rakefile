require "json"

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
  task :lytex do    
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
    if ENV['LYTEX'] == "1"
      Rake::Task["tex:lytex"].invoke
    end
    pdflatex = "pdflatex -synctex=1 -interaction=nonstopmode -shell-escape -file-line-error ./#{ENV['FILE']}.tex | egrep \".*:[0-9]*:.*|LaTeX Warning:\""
    bibtex = "bibtex -terse ./#{ENV['FILE']}.aux"
    sh pdflatex
    if not File.exists? "./#{ENV['FILE']}.blg"
      sh bibtex
      2.times do sh pdflatex end
    end
    puts "=> DONE: see #{ENV['FILE']}"
  end

  task :main do
    ENV['FILE'] = "main"
    ENV['LYTEX'] = "1"
    Rake::Task["tex:clean"].invoke
    Rake::Task["tex:compile"].invoke
  end
end

namespace :git do

  desc "start git routines"
  task :tex do
    sh "git add *.md *.tex *.bib *.pdf imagens/"
    puts "=== This is your current status: check before commit (type ctrl+C to stop)"
    sh "git status"
    puts "=== Commit message:"
    text = gets.chomp
    puts "=== Are you ok?"
    ok = gets.chomp
    if ok == "Y" or ok == "y" or ok == "S" or ok == "s"
      sh "git commit -m #{text}"
      sh "git push origin master "
    end
  end
end

