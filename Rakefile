task :default => [:build]

desc "jekyll build"
task :build do
  sh "touch ./tmp/restart.txt"
  sh "JEKYLL_ENV=production jekyll build"
end

desc "jekyll watch"
task :watch do
  sh "touch ./tmp/restart.txt"
  sh "JEKYLL_ENV=production jekyll build --watch --trace"
end

desc "jekyll deploy"
task :deploy do
  sh "JEKYLL_ENV=production jekyll build"
  sh "jekyll deploy"
end
