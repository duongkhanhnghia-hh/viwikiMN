
Install RVM & Ruby 2.2
sudo apt-get update
sudo apt-get install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev
sudo apt-get install libgdbm-dev libncurses5-dev automake libtool bison libffi-dev gawk
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
curl -L https://get.rvm.io | bash -s stable
source ~/.rvm/scripts/rvm
rvm install 2.2.3
rvm use 2.2.3 --default
ruby -v

Lỗi không cài được ruby là apt-get thì phải chắc chắn apt-get update không còn lỗi. Bằng cách chọn best server hoặc server nhanhoa, fpt tùy khu vực và nhà mạng. 

Install Imagemagick
sudo apt-get install libmagickwand-dev imagemagick

Install MySQL 
sudo apt-get install mysql-server mysql-client libmysqlclient-dev

Install LiberOffice for server
sudo add-apt-repository ppa:libreoffice/ppa
sudo apt-get update && sudo apt-get -y dist-upgrade
sudo apt-get install libreoffice

======================================================================


Maintain server
Moi khi update source code moi thi chay
* Development
- Install new gem
	bundle install
- Migrate db
	rake db:migrate
- Precompile asset
	RAILS_ENV=development bundle exec rake assets:precompile
	RAILS_ENV=production bundle exec rake assets:precompile
- Clear source code
	rake tmp:clear
- Restart server if need
	service apache2 restart