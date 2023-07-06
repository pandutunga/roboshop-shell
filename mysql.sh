echo -e "\e[33m Disable MYSQL Default version\e[0m"
yum module disable mysql -y &>>/tmp/roboshop.log

echo -e "\e[33m copy MYSQL Repo file\e[0m"
cp /home/centos/roboshop-shell/mysql.repo /etc/yum.repos.d/mysql.repo &>>/tmp/roboshop.log

echo -e "\e[33m Intall MYSQL Community server\e[0m"
yum install mysql-community-server -y &>>/tmp/roboshop.log

echo -e "\e[33m start MYSQL service\e[0m"
systemctl enable mysqld &>>/tmp/roboshop.log
systemctl restart mysqld &>>/tmp/roboshop.log

echo -e "\e[33m Setip MYSQL password\e[0m"
mysql_secure_installation --set-root-pass RoboShop@1 &>>/tmp/roboshop.log

#mysql -uroot -pRoboShop@1

