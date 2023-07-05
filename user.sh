echo -e "\e[33mConfigurung nodejs repos\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/roboshop.log

echo -e "\e[33m Install nodejs repos\e[0m"
yum install nodejs -y &>>/tmp/roboshop.log

echo -e "\e[33madd application user\e[0m"
useradd roboshop &>>/tmp/roboshop.log

echo -e "\e[33m Create Application Directory\e[0m"
rm -rf /app &>>/tmp/roboshop.log
mkdir /app

echo -e "\e[33mDownload Application Content\e[0m"
curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip
cd /app

echo -e "\e[33m Extract application content\e[0m"
unzip /tmp/user.zip &>>/tmp/roboshop.log
cd /app


echo -e "\e[33m Install nodejs dependencies\e[0m"
npm install &>>/tmp/roboshop.log

echo -e "\e[33m setup systemd service\e[0m"
cp /home/centos/roboshop-shell/user.service /etc/systemd/system/user.service &>>/tmp/roboshop.log

echo -e "\e[33m Start user service\e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable user &>>/tmp/roboshop.log
systemctl restart user &>>/tmp/roboshop.log

echo -e "\e[33m Copy mongodb repo file\e[0m"
cp /home/centos/roboshop-shell/mongodb.repo /etc/yum.repos.d/mongodb.repo &>>/tmp/roboshop.log


echo -e "\e[33mInstall mongodb client\e[0m"
yum install mongodb-org-shell -y &>>/tmp/roboshop.log

echo -e "\e[33m load schema\e[0m"
mongo --host mongodb-dev.pandudevopsb72.store </app/schema/user.js &>>/tmp/roboshop.log