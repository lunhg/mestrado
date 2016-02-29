namespace :tex do

  desc "clean som auxiliar tex files"
  task :clean do
    ["aux", "log", "bbl", "blg", "brf", "idx", "synctex.gz", "thm", "toc", "lytex"].each{|e| sh "rm *.#{e}"}
  end

  desc "compile lilypond"
  task :lytex do    
    ENV['SCORES'].split(" ").each do |e|
      begin
        File.read("#{e}.lytex")
      rescue Exception => error
        File.open("#{e}.lytex", "w+") do |f|
          f.write "\\lilypondfile\{#{e}.ly\}"
          f.close
        end

        sh "lilypond-book #{e}.lytex"
      ensure
        File.read("#{e}.lytex")
      end
    end
  end
  
  desc "compile tex"
  task :compile do
    begin
      sh "pdflatex -synctex=1 -interaction=nonstopmode -shell-escape -file-line-error #{ENV['FILE']} | egrep \".*:[0-9]*:.*|LaTeX Warning:\""
      begin
        # we need a error
        File.read("#{ENV['FILE']}.blg")
      rescue Exception => _e
        puts _e
        sh "bibtex -terse ./#{ENV['FILE']}.aux"
        sh "pdflatex -synctex=1 -interaction=nonstopmode -shell-escape -file-line-error ./#{ENV['FILE']}.tex | egrep \".*:[0-9]*:.*|LaTeX Warning:\""
        sh "pdflatex -synctex=1 -interaction=nonstopmode -shell-escape -file-line-error ./#{ENV['FILE']}.tex | egrep \".*:[0-9]*:.*|LaTeX Warning:\""
        puts "=> #{ENV['FILE']}.pdf produced!"
      ensure
        # now we need test
        File.read("#{ENV['FILE']}.blg")
      end
    rescue Exception => e
      print e
    end
  end

  task :main do
    ENV['FILE']="main"
    ENV['SCORES'] = "tidal1 tidal2 tidal3 Jarret"
    Rake::Task["tex:lytex"].invoke
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

